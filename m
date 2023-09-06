Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD7793C08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbjIFL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIFL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:59:48 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522B1A7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 04:59:44 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-317a84a3ebeso367170f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694001582; x=1694606382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ45QK6IZz6Y3HlhiHmijDorqTKf0Kc5k/F4bqv8ZPU=;
        b=V9xQgZhC51/IccpfbhWJFiRXRLjcFHgbXvObSd82yob283xHadPHcY2wwOFJcntXUr
         XA3exGZo7sE8GWCWESMw6Luo5+bMYY0svdAD3ue3w+e+06HybXIv59Sr3cFvff1/8tC7
         gN8Hy/+nMKo4a+gvDn6h+Ghjias3hw70v2rOPzU1/7Q77TS7KdJPQHGcnK+ECCJJ5Y+L
         TMSPVVHtePhXH15mc4XUQBv4wASg9iKqieB5aBKNx6PNYjWqH5VguAd4E25pnzWeGW9F
         Jq5BWvc2VHe36DlbaRlhbAh1yMdOdaO+TwArejpAC5zs34kJeE66l6yKbqQlRjlK7SV1
         251g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694001582; x=1694606382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZ45QK6IZz6Y3HlhiHmijDorqTKf0Kc5k/F4bqv8ZPU=;
        b=bx6f8cpjgmaqhNXGjKYoL8xVYOhU1E5GaJEqz805yxsfeztUneNqLJtkKkWfNAeY86
         blvgg9OZ1IZRHoda0mZYUOvtiP+jSmYv1ZjjIuFmsg/AoipZVYr/kZADqtPL0giXjzXn
         GJ02vRPwN7NUwhyl2+b2d08+vdI6c2yaKBtcYPN3haJ+tBfDyxAzuGtJdF/4Pv7bzErs
         C1i/0nH6bS2BnqsGI103wS0j7vFz7EZm0zgXuBfxRpw61NV/Qzqin6AVlRo/BSa7pm2f
         urQZJ/1UbrjmsPSR/GCLEK1OmCLGVutnzKNdyBNXJSs8slWMnGVOERZGQ7d2RaUWmsso
         LsLA==
X-Gm-Message-State: AOJu0YxuHqkMJ6BY92Gf3g3B04BF4e1TBHxHH1s9HT5/gWYC7LA3b37r
        6PEzcz4pcBjT+3l4DFQKNRITZB9H/w==
X-Google-Smtp-Source: AGHT+IHyrWV8acPN9HP3oz5oz/0VQKRUGYP/4SMuhpP6WbUylN5q+J5bASQWA2/S0MVnVxpukdeBqvYYJQ==
X-Received: from alpic.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1bf2])
 (user=alpic job=sendgmr) by 2002:adf:e195:0:b0:31a:d852:b6b2 with SMTP id
 az21-20020adfe195000000b0031ad852b6b2mr50983wrb.0.1694001582575; Wed, 06 Sep
 2023 04:59:42 -0700 (PDT)
Date:   Wed,  6 Sep 2023 13:59:27 +0200
In-Reply-To: <20230906102557.3432236-1-alpic@google.com>
Mime-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906115928.3749928-1-alpic@google.com>
Subject: [PATCH V2] SELinux: Check correct permissions for FS_IOC32_*
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some ioctl commands do not require ioctl permission, but are routed to
other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).

However, if a 32-bit process is running on a 64-bit kernel, it emits
32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
being checked erroneously, which leads to these ioctl operations being
routed to the ioctl permission, rather than the correct file permissions.

Two possible solutions exist:

- Trim parameter "cmd" to a u16 so that only the last two bytes are
  checked in the case statement.

- Explicitly add the FS_IOC32_* codes to the case statement.

Solution 2 was chosen because it is a minimal explicit change. Solution
1 is a more elegant change, but is less explicit, as the switch
statement appears to only check the FS_IOC_* codes upon first reading.

Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
Signed-off-by: Alfred Piccioni <alpic@google.com>
Cc: stable@vger.kernel.org
---
V1->V2: Cleaned up some typos and added tag for -stable tree inclusion.

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

