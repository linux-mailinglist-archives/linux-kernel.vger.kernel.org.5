Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688367939CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbjIFK0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbjIFK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:26:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AAB10C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 03:26:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cb845f2f2so36102387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693995979; x=1694600779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bd8xPMJuwIaL4g5So5Hpw2FKK/Xq7RuyWEq/PvNzxXE=;
        b=bd3P5L2QfUWkrIhT2st/O48iS8Ew2tRAYPpzoyBE2S2T5Nex+LsZHGVxfdbPO9P8R5
         +25y3HAaekcS809uNaqHU2VXed4HB3GA0awjBb//vogVM7eZ+C5h2GFI3MU6bBcZ+x3q
         fyhsyvYTmdLK/QODO4R/C9onqZqddqdpeEcQ9jh9Q3A4JTAxwCJUYIocWDHz1d5Mxnmg
         +48aJ5b9JV5yr2xCrWcrTVIC4I3FMdihSEfcASYkYIa9LdcSG0J1cU1kiUsFH67zvGBL
         w4T1ysNJeR+saPZc5grIGMNYlrlL/tD2Oc20AiPP8JgIWR4Shr+cXgLjekNq6Tus/Z/9
         3MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995979; x=1694600779;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd8xPMJuwIaL4g5So5Hpw2FKK/Xq7RuyWEq/PvNzxXE=;
        b=KxGC2WvjXRBYAzBVLQL7FgnpvA/ATWhmSQeTosHzI/Q0Sx9Y2M1N4vFGFHDVW4ucbY
         7EUmQwf18UiGnlHFTXQMs7ZXDE6IFqHpgE8KvjGq1ryQ2Y9uADYKsHzdziCmwz/2dFTU
         i9PeUjVsjzZZJ+G2E7wi7a060hw5mLl/1iaFSDMNmJ4L93sEFGuU1MpAUxhAW/cFhatN
         5FUnqoqCF5rspPAuuRhh/cZsslJ1s3hJ3VNsxjLZXNjfEsxFRAbrKoVvpbI+Od6cwW3r
         PZT3bOTiHbM9WlduXrgMiPZq8GCENDUsmphMWZ3tJ2HJPAUUU/kF8fMAZsyn4r9ucCuO
         Pv+g==
X-Gm-Message-State: AOJu0YzPRbDWGTds0Qgms07uSwED/1GUak2N02REkXXiyoSAtpCqsedE
        szsqK1TGYPPYGPIVF5Bk1UWi8wuElA==
X-Google-Smtp-Source: AGHT+IE/UnZx+PImE5pc+JUOpSk02v87E9WHzmFRHcOsG8fNZn7gy5TZNBqX0sBQuSywALVf2UHXb/I+GQ==
X-Received: from alpic.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1bf2])
 (user=alpic job=sendgmr) by 2002:a25:ca87:0:b0:cb6:6c22:d0f8 with SMTP id
 a129-20020a25ca87000000b00cb66c22d0f8mr383370ybg.4.1693995979209; Wed, 06 Sep
 2023 03:26:19 -0700 (PDT)
Date:   Wed,  6 Sep 2023 12:25:57 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906102557.3432236-1-alpic@google.com>
Subject: [PATCH] SELinux: Check correct permissions for FS_IOC32_*
From:   Alfred Piccioni <alpic@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     stable@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alfred Piccioni <alpic@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ioctl commands do not require ioctl permission, but are routed to
other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).

However, if a 32-bit process is running on a 64-bit kernel, it emmits
32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
being checked erroneoulsy, which leads to these ioctl operations being
routed to the ioctl permission, rather than the correct file permissions.

Two possible solutions exist:

- Trim parameter "cmd" to a u16 so that only the last two bytes are
  checked in the case statement.

- Explicitily add the FS_IOC32_* codes to the case statement.

Solution 2 was chosen because it is a minimal explicit change. Solution
1 is a more elegant change, but is less explicit, as the switch
statement appears to only check the FS_IOC_* codes upon first reading.

Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
Signed-off-by: Alfred Piccioni <alpic@google.com>
---
 security/selinux/hooks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..bba83f437a1d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3644,11 +3644,15 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	case FIGETBSZ:
 	case FS_IOC_GETFLAGS:
 	case FS_IOC_GETVERSION:
+	case FS_IOC32_GETFLAGS:
+	case FS_IOC32_GETVERSION:
 		error = file_has_perm(cred, file, FILE__GETATTR);
 		break;
 
 	case FS_IOC_SETFLAGS:
 	case FS_IOC_SETVERSION:
+	case FS_IOC32_SETFLAGS:
+	case FS_IOC32_SETVERSION:
 		error = file_has_perm(cred, file, FILE__SETATTR);
 		break;
 

base-commit: 50a510a78287c15cee644f345ef8bac8977986a7
-- 
2.42.0.283.g2d96d420d3-goog

