Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60CC67D255B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjJVSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVSja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:39:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FEFE0;
        Sun, 22 Oct 2023 11:39:28 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d9443c01a7336-1c5cd27b1acso21311045ad.2;
        Sun, 22 Oct 2023 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697999967; x=1698604767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9XnGTqS6VWrLiI+nuP6yzxfhhc0PJY1/9rd1gvde04=;
        b=M8RmgpghbgOiMvD/9ADwgkcMhlaPaJwabSPXNTP6WEY6GrGkU63tXSRY3ZTmUTnTZW
         ozEr6qj4TUQuriomfLqbVaxy7LuwQTjgzHlvbTE/yCC8DPklVyf1d1+SJWWjWOUsUnhP
         Df2evXTLXNQdqA3hcKVR3EOj86rb9yK3PgeAI0EYdkvJObxG7K1RwkHj7WZEf90du0Dw
         5Q47YzsbN9SzRmaWoBQfHSk3t8tfCgPStw4P9ZTbbO1HoGWUXAEhoyUMdJ4rDQgRHVpW
         grYHCkfK9dQPzjTLDn+QWp4zBfFdbbKF2t+u8EeWMveYNjKP0HwzXo1tCeaTMicMauRO
         vGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697999967; x=1698604767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9XnGTqS6VWrLiI+nuP6yzxfhhc0PJY1/9rd1gvde04=;
        b=f6snRjiUoFsVfTAxrs/Uogx5OoYryDZRxfAZJjqFRTIEOnT2DwOQmK7sLBu/yZHgxs
         OyYVJ2fX/9BhLdG0avxpKRr1kuSfEPFTPHDs+sfagJX0r9O8rSYTqCmARYNHMLI9aK1O
         55X4XwQ8H+AKSA+30ceUm5ImbNC1Y+jI5k/Mez00n9tkkzzQzmggSv9CqkyHBe5cKSWP
         jC/A7rfVTHCupwBJPHWsgf6C8kaPPqQ8yPrDbDl6DBjiykndtkv7bwDLIpAjY4yGfuy/
         low8kkco1j2YGK95CCMzpq+sJGFQOxZRkTr43+DA3mckLVILu5G1cFFhQU+zZMuZUtbv
         VblA==
X-Gm-Message-State: AOJu0Yz/fwEtwi5iG9In+yMRvtBJOUwNAqge1kQZDTqZn7o0PNDbnypr
        8thkskgh7Jobzd4lDg00iU0=
X-Google-Smtp-Source: AGHT+IGtJn40MHIY1wL/r/2JYdCJPBQM+Et+9XlN6Ua5mnUsXU68QMG0DWmO7g0krYdP9MYWZgbJqg==
X-Received: by 2002:a17:902:e844:b0:1c6:25c3:13d3 with SMTP id t4-20020a170902e84400b001c625c313d3mr8145238plg.6.1697999967482;
        Sun, 22 Oct 2023 11:39:27 -0700 (PDT)
Received: from localhost ([2409:8a3c:3640:7481:178a:30e9:674c:c2f3])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001b8b07bc600sm4649961plh.186.2023.10.22.11.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 11:39:27 -0700 (PDT)
From:   John Sanpe <sanpeqf@gmail.com>
To:     stfrench@microsoft.com, linkinjeon@kernel.org, pc@manguebit.com,
        sprasad@microsoft.com, linux-cifs@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, John Sanpe <sanpeqf@gmail.com>
Subject: [PATCH] fs/smb: using crypto lib instead cifs_arc4
Date:   Mon, 23 Oct 2023 02:39:17 +0800
Message-ID: <20231022183917.1013135-1-sanpeqf@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace internal logic with an independent arc4 library.

Signed-off-by: John Sanpe <sanpeqf@gmail.com>
---
 fs/smb/Kconfig              |  1 +
 fs/smb/client/cifsencrypt.c |  7 ++--
 fs/smb/common/Makefile      |  1 -
 fs/smb/common/arc4.h        | 23 ------------
 fs/smb/common/cifs_arc4.c   | 74 -------------------------------------
 fs/smb/server/auth.c        |  6 +--
 6 files changed, 7 insertions(+), 105 deletions(-)
 delete mode 100644 fs/smb/common/arc4.h
 delete mode 100644 fs/smb/common/cifs_arc4.c

diff --git a/fs/smb/Kconfig b/fs/smb/Kconfig
index ef425789fa6a..65e5a437898b 100644
--- a/fs/smb/Kconfig
+++ b/fs/smb/Kconfig
@@ -7,5 +7,6 @@ source "fs/smb/server/Kconfig"
 
 config SMBFS
 	tristate
+	select CRYPTO_LIB_ARC4
 	default y if CIFS=y || SMB_SERVER=y
 	default m if CIFS=m || SMB_SERVER=m
diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index ef4c2e3c9fa6..d8754c406b5f 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -21,7 +21,7 @@
 #include <linux/random.h>
 #include <linux/highmem.h>
 #include <linux/fips.h>
-#include "../common/arc4.h"
+#include <crypto/arc4.h>
 #include <crypto/aead.h>
 
 /*
@@ -826,9 +826,8 @@ calc_seckey(struct cifs_ses *ses)
 		return -ENOMEM;
 	}
 
-	cifs_arc4_setkey(ctx_arc4, ses->auth_key.response, CIFS_SESS_KEY_SIZE);
-	cifs_arc4_crypt(ctx_arc4, ses->ntlmssp->ciphertext, sec_key,
-			CIFS_CPHTXT_SIZE);
+	arc4_setkey(ctx_arc4, ses->auth_key.response, CIFS_SESS_KEY_SIZE);
+	arc4_crypt(ctx_arc4, ses->ntlmssp->ciphertext, sec_key, CIFS_CPHTXT_SIZE);
 
 	/* make secondary_key/nonce as session key */
 	memcpy(ses->auth_key.response, sec_key, CIFS_SESS_KEY_SIZE);
diff --git a/fs/smb/common/Makefile b/fs/smb/common/Makefile
index c66dbbc1469c..9e0730a385fb 100644
--- a/fs/smb/common/Makefile
+++ b/fs/smb/common/Makefile
@@ -3,5 +3,4 @@
 # Makefile for Linux filesystem routines that are shared by client and server.
 #
 
-obj-$(CONFIG_SMBFS) += cifs_arc4.o
 obj-$(CONFIG_SMBFS) += cifs_md4.o
diff --git a/fs/smb/common/arc4.h b/fs/smb/common/arc4.h
deleted file mode 100644
index 12e71ec033a1..000000000000
--- a/fs/smb/common/arc4.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Common values for ARC4 Cipher Algorithm
- */
-
-#ifndef _CRYPTO_ARC4_H
-#define _CRYPTO_ARC4_H
-
-#include <linux/types.h>
-
-#define ARC4_MIN_KEY_SIZE	1
-#define ARC4_MAX_KEY_SIZE	256
-#define ARC4_BLOCK_SIZE		1
-
-struct arc4_ctx {
-	u32 S[256];
-	u32 x, y;
-};
-
-int cifs_arc4_setkey(struct arc4_ctx *ctx, const u8 *in_key, unsigned int key_len);
-void cifs_arc4_crypt(struct arc4_ctx *ctx, u8 *out, const u8 *in, unsigned int len);
-
-#endif /* _CRYPTO_ARC4_H */
diff --git a/fs/smb/common/cifs_arc4.c b/fs/smb/common/cifs_arc4.c
deleted file mode 100644
index 043e4cb839fa..000000000000
--- a/fs/smb/common/cifs_arc4.c
+++ /dev/null
@@ -1,74 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Cryptographic API
- *
- * ARC4 Cipher Algorithm
- *
- * Jon Oberheide <jon@oberheide.org>
- */
-
-#include <linux/module.h>
-#include "arc4.h"
-
-MODULE_LICENSE("GPL");
-
-int cifs_arc4_setkey(struct arc4_ctx *ctx, const u8 *in_key, unsigned int key_len)
-{
-	int i, j = 0, k = 0;
-
-	ctx->x = 1;
-	ctx->y = 0;
-
-	for (i = 0; i < 256; i++)
-		ctx->S[i] = i;
-
-	for (i = 0; i < 256; i++) {
-		u32 a = ctx->S[i];
-
-		j = (j + in_key[k] + a) & 0xff;
-		ctx->S[i] = ctx->S[j];
-		ctx->S[j] = a;
-		if (++k >= key_len)
-			k = 0;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cifs_arc4_setkey);
-
-void cifs_arc4_crypt(struct arc4_ctx *ctx, u8 *out, const u8 *in, unsigned int len)
-{
-	u32 *const S = ctx->S;
-	u32 x, y, a, b;
-	u32 ty, ta, tb;
-
-	if (len == 0)
-		return;
-
-	x = ctx->x;
-	y = ctx->y;
-
-	a = S[x];
-	y = (y + a) & 0xff;
-	b = S[y];
-
-	do {
-		S[y] = a;
-		a = (a + b) & 0xff;
-		S[x] = b;
-		x = (x + 1) & 0xff;
-		ta = S[x];
-		ty = (y + ta) & 0xff;
-		tb = S[ty];
-		*out++ = *in++ ^ S[a];
-		if (--len == 0)
-			break;
-		y = ty;
-		a = ta;
-		b = tb;
-	} while (true);
-
-	ctx->x = x;
-	ctx->y = y;
-}
-EXPORT_SYMBOL_GPL(cifs_arc4_crypt);
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 229a6527870d..5640196b313f 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -29,7 +29,7 @@
 #include "mgmt/user_config.h"
 #include "crypto_ctx.h"
 #include "transport_ipc.h"
-#include "../common/arc4.h"
+#include <crypto/arc4.h>
 
 /*
  * Fixed format data defining GSS header and fixed string
@@ -362,9 +362,9 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 		if (!ctx_arc4)
 			return -ENOMEM;
 
-		cifs_arc4_setkey(ctx_arc4, sess->sess_key,
+		arc4_setkey(ctx_arc4, sess->sess_key,
 				 SMB2_NTLMV2_SESSKEY_SIZE);
-		cifs_arc4_crypt(ctx_arc4, sess->sess_key,
+		arc4_crypt(ctx_arc4, sess->sess_key,
 				(char *)authblob + sess_key_off, sess_key_len);
 		kfree_sensitive(ctx_arc4);
 	}
-- 
2.41.0

