Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CBA7FFD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376797AbjK3UvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376740AbjK3UvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:51:16 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70211713
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cdfb721824so195262b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701377482; x=1701982282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHspbjyNxD70S26h5FJFbJyrOIpjQKEiRZEPO/RowOY=;
        b=YQxvOw0t1CbnlpsR46OUOms4DEPmzvsbiw1fyX8MpNED6y7LWiQ9FvJfTa6w0B4QEc
         MT2RAgXiah5yqVm3BQenT6T+rO2QVnz6Av0xSzPk/bkBRDK21QTd47fogsBd52a6ie67
         WUXlZ7M8p/8gSRXf3/bOdZe5yjqpZhxq5UZww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701377482; x=1701982282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHspbjyNxD70S26h5FJFbJyrOIpjQKEiRZEPO/RowOY=;
        b=dktjPwjQMnuW0TLqx8twRHeb/iR7RCjNsyK+wta8jTdgDx8VQR0PY2U61e1QxGMQ1y
         uxJQAdMo7sKDZFTj17wb6TvYYl0V1AlUa2nxB/a8rThoSbx6vXOITACDb9/HccweXsQN
         YihtbfJtppxIG744+QFy3ErVmpiPpHAP5xlCqXREyjBS/+zFLhXcUJ9oXsoDMFUwabjz
         o17p9uTNQDkyNkHJrjv6F0FUaNiiXF/PnZT+2b4osWLKL2GKU/26luVqKud3GnTa4cDs
         qkRJHDclaiPAV/rlJiWm0NNnxxSSRNnSKqWp6KOdX9FSdu6XClyKkhhUPfuHOPcPrpUe
         z1fg==
X-Gm-Message-State: AOJu0Ywd5XbcQG366vz6zy3m69M7nO730JpdJ8j0YjmWPQDhvacUTagd
        icuPfdzerGVG+Z9be4N5mLMkxw==
X-Google-Smtp-Source: AGHT+IFm/DuSKcpDXL4yPGVmvfLKtyAbGASsT7oxedviVQc3mYSpRkK8dKsCbVIVi7NEegnOzk/qHA==
X-Received: by 2002:a05:6a00:6c86:b0:6cd:d8c6:5f2d with SMTP id jc6-20020a056a006c8600b006cdd8c65f2dmr7397977pfb.2.1701377482345;
        Thu, 30 Nov 2023 12:51:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e23-20020a63d957000000b005b7dd356f75sm1707007pgj.32.2023.11.30.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:51:21 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Anders Larsen <al@alarsen.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] qnx4: Use get_directory_fname() in qnx4_match()
Date:   Thu, 30 Nov 2023 12:51:19 -0800
Message-Id: <20231130205120.3642477-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130205010.it.412-kees@kernel.org>
References: <20231130205010.it.412-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2137; i=keescook@chromium.org;
 h=from:subject; bh=0NRaB2XyKTke+LAIiZpTjtyDvsns87ckz1A+4wFT/pU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaPXHwMRifvoP3X5IR1swGuZKu3ezjNx6+q9Y/
 rued3z2/QSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWj1xwAKCRCJcvTf3G3A
 JrG9D/9U5Pt6Io0TBKu5fsoHGeADe3EEyPVr7dNlaSkT0fd+Z/wUv4HjAeK18w8+mEqzKmc+8D7
 osq79lqROKhvGAzuGte+1dtUAJyrG2N+kIY7whVWjFYj4aJe9hMLi0E+gHz2F8BvYdqHQqgU2s+
 qZX0/u3GMTF27uOLRvWKgGkvf1quTpALZEm0jbwf9lRMIYHUdmtXP8IRCYnkM+4QNUktyAK4Krb
 Dy/Ievfz1/oZbltim3dvynxT4mW/gVzLy6wYEuIIR4869XRwaMNR30r7Ed+qcL0DkTrB4OtcRNa
 qyYp1GGNlvQwKN0EfJiYldys+16liBo7iFSaocEeeHxl/4Oic1xjF40gIWQQgrdzvafhAF+Ojkc
 t17iCMyooYWMfhjsmQHwg4LK2UPHKYN/o436ElHiNmfm6dI+/R2umxX52SUKIgIzKX9+pEM78HK
 j26HLelWfEjfBzhhLYlSGeVX+KX5vzfIBoLjdhIurCLq4Sv3M7NvCGgJzINZsuyYDI1VTxoEbi3
 QihxHdAviQUn4QrllwBAW3JPmFaBxWIgQ44D9E8jfW0pJ94L/ClDxU47yv0ocYxzAVbNn7BRM6o
 U3sm5w5geeMVlifVE2Kn31bRC4LL4Y3P5edIn4YqZ8kUuHvZKG1pYSn4Vt/3wmFM4SQGpP9AOtM O5YgvLYssasy3wA==
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
Link: https://lore.kernel.org/r/20231118033225.2181299-2-keescook@chromium.org
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

