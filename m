Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A47378DF35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbjH3T3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbjH3QEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:04:21 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E94119A;
        Wed, 30 Aug 2023 09:04:16 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7926de0478eso25852339f.0;
        Wed, 30 Aug 2023 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693411455; x=1694016255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Itk0FxQ8aOsxaobxShDhDlHfcsOYRAIoJ1pjGXmSZV4=;
        b=GJqaxRXrqP3tfXYyoPEAclxSEFPhmot5J7AEnOwXKnTF0oHkmQqLlZWQtqv+ekZstV
         cTBaoTVCObR6uMsgun8w1UAVaSyBw746Zeu9XBQWw4jnllcFfbwxosocxcCc3z0p8y5w
         HBjN965O3EWVPmImQvI7tMndGw/k7IPIGyBmVapUbxgl2qD1+4xWZlxCM92uEPJsJ8xC
         BBcjhAm05kkSN4n5HpX+0zNFeTMUkeF1P1su29+RMbfHJn6NBYotlG2I/hhb+CN41nmB
         8vX4m6klJgp21gy28BgcIOr1BEM2j3/Q5eF4xeWWYrc+L309a1bFgvXqIEM+ml/HB32p
         B3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411455; x=1694016255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Itk0FxQ8aOsxaobxShDhDlHfcsOYRAIoJ1pjGXmSZV4=;
        b=E/AOHJmABidnZqDJLA5gFmLD01W+487PEhHx6TvVoq7IXbueHk8S0bsUKSqSCLuveK
         paiPGudJBR8PN1G5CBa3wAxx2QhBTmLLeM68tcHna6LszeZQ987tdAqGwlyLJ4+FxaCn
         JTS3/AvOYF8ulkrNfBiay2rETr5dOXrskVSCxhYitdY7zlYm/3Oqirl7sNuDiX9JOnaw
         /uj/ycqyTbTqJvGwd9rg37l46972HHJI1ewgqGmTcCMQ9LIY2V6ZBf/FX9/ZOyBF9i7L
         cMe50Ug3wBt2Dk7IYiBb9W2q+2d1g4xZQstAYAtMBPq73TjKmDo4CPlPyBNpf3Xj2r9M
         i3IA==
X-Gm-Message-State: AOJu0YyhPHqYg+PB1b2257LuxwUFigm20fSyROTD6zMTxsaHusqf3d1S
        RktbLdmElgLDnAXfzcC5XcU=
X-Google-Smtp-Source: AGHT+IE/mdDVJxnztFfE1Z24ZonvEplc5Jx9Gwc1i+sXFyxHd5QrWAmYh4fW+EAyMNbrmhpLipU78w==
X-Received: by 2002:a92:dc47:0:b0:348:7f18:68be with SMTP id x7-20020a92dc47000000b003487f1868bemr69372ilq.4.1693411455448;
        Wed, 30 Aug 2023 09:04:15 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id t9-20020a92c0c9000000b0034cc253a78esm3912100ilf.51.2023.08.30.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 09:04:14 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] vt: Fix potential read overflow of kernel memory
Date:   Wed, 30 Aug 2023 16:04:10 +0000
Message-ID: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit if
a source string is not NUL-terminated [1].

The copy_to_user() call uses @len returned from strlcpy() directly
without checking its value. This could potentially lead to read
overflow.

In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/tty/vt/keyboard.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 358f216c6cd6..15359c328a23 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 			return -ENOMEM;

 		spin_lock_irqsave(&func_buf_lock, flags);
-		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
+		len = strscpy(kbs, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);

+		if (len < 0) {
+			ret = -EFAULT;
+			break;
+		}
 		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
 			-EFAULT : 0;
-
 		break;
 	}
 	case KDSKBSENT:
--
2.42.0.rc2.253.gd59a3bf2b4-goog


