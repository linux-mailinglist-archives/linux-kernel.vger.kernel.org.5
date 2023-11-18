Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABD7EFD6D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 04:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbjKRDci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 22:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjKRDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 22:32:33 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE0610CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:32:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c320a821c4so2411000b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 19:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700278349; x=1700883149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUNX4Pr0e63GOp5Q1i8+8pUFIEK3hETBMWLJLAQNpAU=;
        b=LIl7ImygH4QE78Jnvt+8VjpRoBbEt0RybWpiIkGZSYockNCRcmOIH5adk9WuQ5CYWS
         RADZ7ULcmEVAalURw4bprUX+feuPDCPHSoMSZJiyFsCBLS4h6c7MvwS/hDeHTwLmdl8t
         yud28OFYY2+s/ohY0ZIbzVtpBS4UFvQMFjRwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700278349; x=1700883149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUNX4Pr0e63GOp5Q1i8+8pUFIEK3hETBMWLJLAQNpAU=;
        b=SB0oRrljhmkJNPo/X8w0MgIxbB6vT6H2jBP8ho/gVD0UnBE4ss2+vdJ2Q3T0JjdW5a
         XyFXshBFLFjkwfiYR3BuYHE38CMItlMel7T3gPR3mLHyumEmR49176obTYAxbWrAaQxz
         ovG8ZNNz1dwDfUGPj8fprX/x5l9gGTrxDCjl1q+KQDYnRN4u/zIJUG7+AgFYj/Vt6j20
         OB9xvncOCj0MjGoyY1I9aIrL8z8fiMkw8KeTtca9jU7BmD2GK41npil2tUsrfBUr/e67
         PM6bW0H0dUJ89K4xZX2NBlWqLbs4lrr6yEUvXnaxvRuo119BWNNPyMKikVkfR1Srof6i
         lzTA==
X-Gm-Message-State: AOJu0YxI7rMBdsCbKwQp5FwUY5K7S/RXFxO/i2DP8hKif0OG2K24XAMe
        oO254PigErslRdoDVA3pSu9LdQ==
X-Google-Smtp-Source: AGHT+IHn5W15vaMMMeZcjnHp9mCYupUevMqRAJPExmNc/p1BHGjN0FU7nrwoV0mUh0XdiZuO73B7YQ==
X-Received: by 2002:a05:6a20:3e16:b0:187:1015:bf88 with SMTP id m22-20020a056a203e1600b001871015bf88mr803069pzc.29.1700278349034;
        Fri, 17 Nov 2023 19:32:29 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001c60a2b5c61sm2068173plb.134.2023.11.17.19.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 19:32:26 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] qnx4: Use get_directory_fname() in qnx4_match()
Date:   Fri, 17 Nov 2023 19:32:23 -0800
Message-Id: <20231118033225.2181299-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118032638.work.955-kees@kernel.org>
References: <20231118032638.work.955-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057; i=keescook@chromium.org;
 h=from:subject; bh=OhI/ZifeBTDlKg1Qzh7oz3gDWu25PlWJzlLQLPT3/7Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlWDBHYnwwXN6DifyScJCDU1k4klZEHrQeAbVxO
 WPackvO556JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVgwRwAKCRCJcvTf3G3A
 JghJD/9FcggML2h6nM/xEZ50lWpdxVZnBj1oQhkTQJtXykLeD4GhH3Fo7k4wqHPGNt3NHcOjxDz
 8wc9HYXWEdWEhBhR2IFQE+iETopUHDNGJ+Z2qpnCRUgFiwCJML4VvMjs/OLU1WsDtvvXmmtSApA
 j1dggGXIm1aDFES3WZj7MLbICqDNORhV1AB0/2kOyIVDdy0f/lLHNArhA4H1jwc80maFqJAQsna
 mHOCblm6l1RbytvX53le+z8IXhcOlEnVvQNKlJ2ljWpElpTRl3fHEIReyTkwfiVVUrWFAbG/Laa
 zo2KNadtfSTwLxBDv2rodZSDt4TTvdqw413rAGeQi/EmSbRjfA0kGuy5FnU9yOu8czTWentFWTB
 sE4FLVY3uR8To4VIRPuXX+bokslF1pCD/EcFiJRU3hcEZPeNmiCP9nFd186ToTxhpulkNCatmlM
 l4YAogd+8vgEhUuEK3skqO9VcnpUw1EyUo0uM8agp5K7Sc1VHhDjIAaeEr+v6Rq7KfrtoxUIZGj
 d77dTo1pMyiCAYIoh7ZeG8j4qemCL2ndbDN+Eo1XyXnVbqgDBoXEpVtd5td3biUTIJ6ig5hiDF+
 D4WXLfkY1OSZWAIw/1lAwHrT0eiUqa3ZhKvcKr6OyTNppZ1Q6xKQdd8QSHbZmFcrsw6YS/Khswq v5xIgGNbr5C5aJA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new common directory entry name accessor helper to avoid
confusing the compiler about over-running the file name buffer. Avoids
false positive buffer overflow warning:

[ 4849.636861] detected buffer overflow in strlen
[ 4849.636897] ------------[ cut here ]------------
[ 4849.636902] kernel BUG at lib/string.c:1165!
...
[ 4849.637047] Call Trace:
...
[ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
[ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]

Cc: Anders Larsen <al@alarsen.net>
Reported-by: Ronald Monthero <debug.penguin32@gmail.com>
Closes: https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/qnx4/namei.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..bb8db6550ca5 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -26,31 +26,24 @@
 static int qnx4_match(int len, const char *name,
 		      struct buffer_head *bh, unsigned long *offset)
 {
-	struct qnx4_inode_entry *de;
-	int namelen, thislen;
+	union qnx4_directory_entry *de;
+	const char *fname;
+	int fnamelen;
 
 	if (bh == NULL) {
 		printk(KERN_WARNING "qnx4: matching unassigned buffer !\n");
 		return 0;
 	}
-	de = (struct qnx4_inode_entry *) (bh->b_data + *offset);
+	de = (union qnx4_directory_entry *) (bh->b_data + *offset);
 	*offset += QNX4_DIR_ENTRY_SIZE;
-	if ((de->di_status & QNX4_FILE_LINK) != 0) {
-		namelen = QNX4_NAME_MAX;
-	} else {
-		namelen = QNX4_SHORT_NAME_MAX;
-	}
-	thislen = strlen( de->di_fname );
-	if ( thislen > namelen )
-		thislen = namelen;
-	if (len != thislen) {
+
+	fname = get_entry_fname(de, &fnamelen);
+	if (!fname || len != fnamelen)
 		return 0;
-	}
-	if (strncmp(name, de->di_fname, len) == 0) {
-		if ((de->di_status & (QNX4_FILE_USED|QNX4_FILE_LINK)) != 0) {
-			return 1;
-		}
-	}
+
+	if (strncmp(name, fname, len) == 0)
+		return 1;
+
 	return 0;
 }
 
-- 
2.34.1

