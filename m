Return-Path: <linux-kernel+bounces-109520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C36C881A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF39282A17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919117FD;
	Thu, 21 Mar 2024 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GtVs/JL"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB07EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981537; cv=none; b=r8++kECKNBVSDI6/Y0CtapER8Y7ld2B0Q1pdVPm3hVO242Mf391f17nvYGlprHmpYjdVa+eeKMkejLbLKCoqBi06wiya7rs0I1wT8h14Uta1gQpKapGiC2z1ALz9wQ0dap+WBkOFGHyS7Jcjkt1ZmulmgfsTXzU5VVwT/p+Fl9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981537; c=relaxed/simple;
	bh=XWwaocKABQ9jnViAkbtIF/KvUYPFqVLENRHRK/iFWVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pUP0IlAn1wPiC/IuS7Xckp8wzOyOpWI4BaQn+bF5XLUgpAQ4NH8TOiyZdsS7eZynccyVCJqf7QJKkLpie1xa7fW7QKCqr1YyGmRtoEKdLwuOYIZjOUzFnTJ4wJvs8uRVes9pOHyVsxo3YtqqRk2lDgC8Nm9pcIx6jcXWQxg+cNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GtVs/JL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd944567b6cso527210276.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710981535; x=1711586335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiemHHBtoyDT5DKRZLV0lQm6JsJHIMbODJolPo371hM=;
        b=0GtVs/JLnLnnGCIDQ2qGKDedgaMNKmIQH7DjYxwn9Id400GFYwtuK6MZOwUORA115W
         NNkdpHF4H22iB0Ok0g/Lxk6IC1f+C8Dfjv8NRYiLS0ZNBRAz9rH7XNKtPhz7/lDNXay4
         fV16qY/90Zze9qPCZnq2ciWtyoLC8wHUv/DpVM7YGqq6Oahj5t3In26GN9+H280uCO1I
         f9zgtM1TaVhA54TUqNv8Dv6CoMPOncDUKymwBB1bJcwGrE+mAwuuxPQvkRblk6FrXJFb
         jSfIe5u7UFc1qqGMsfVi0CesYaz1Zokprb//zr95dEkWNitTCFNwEs1jKy8CQePh6ZkL
         LIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710981535; x=1711586335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiemHHBtoyDT5DKRZLV0lQm6JsJHIMbODJolPo371hM=;
        b=phWe6ZkJnyiP9/1ZlrwXP6ABwm9kGUq5mIs7zOrIwNF62f9Gt4G7T1ozK9GnZvUPbF
         OFF65v8Xxpq42YWVUM1Xm3/mL40HEx7poTQaeX6yrn2Q/RnsKvoUCqctYoqdfh/yn7ut
         llVND+0zkWjCSg9jZp7fCFq8mEAPw6uAZ+kwnVDPWrxl33NrJXpEn9HXCl4Hj7+2KAk8
         woznblna1bcRbHelLvg4h+TOOPTOn+cmXQaLNq1UZ54EkSe+B+f5IA9rH3IVUZmbP7bp
         jKL6vIj6YokCf9RnRLpsYOLDoJe0tiBTOs0URCxz6mgLClW8Aq52y3i3MiGS6WqQCk5b
         LQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXo+fk6LpicNU4Y1/IMsvT11LyKEOImkxSfwmEXCiLQzqvOvjuholjZ7iwupbuqaDM4Za3DNYTC+3HhyCdgcBmy6VzAO1cCOpwYJg9o
X-Gm-Message-State: AOJu0YwVeZ2oaytXj8MfXE01360TFEYWa4Ab+fb4KVagFUiQiDiVBZ70
	RAy5rY8Htl6B5aT2g69dxybrYICuA6faa9PL0Bp2KNoYSNJZ4HoE1FBKC7oXxjo72hlkD0Qmxy9
	TzXCxfhMLg//89uOpmXlzPQ==
X-Google-Smtp-Source: AGHT+IEyZS/GnFbBPsZmSMZkiLLZnAAkx4UzmIWqrQdpodEes9mL4Gqf1zabfr+eMBwIO+azPp4WMHvsfJ63gPdLdQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:160c:b0:dd9:20fb:20a1 with
 SMTP id bw12-20020a056902160c00b00dd920fb20a1mr563186ybb.10.1710981535047;
 Wed, 20 Mar 2024 17:38:55 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:38:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ2B+2UC/x2Muw6DMAwAfwV5rqU8YCi/gjqkxqFekshGVRHi3
 xsx3d1yJxirsME8nKD8FZNaevjHAPRJZWOUtTcEF0YXg0fbtVA7MBsy6dH2LjcrEqbp+Y6UXYp E0BdNOcvv3i+v6/oDnEyEKm4AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710981534; l=4760;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=XWwaocKABQ9jnViAkbtIF/KvUYPFqVLENRHRK/iFWVw=; b=ZcTTtdciSPEfO0FzGxDVut7rB4NJpxOIDpSNKacGuqw0E9oZmdCWm78ES7wtKmtQt5C/hBbkh
 Fj1g6RGbhumCW9AxyrArhailPRTKc7ssmywSffs/q8IMdUh7wG3Yxvk
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
Subject: [PATCH] fs: ecryptfs: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. A good alternative is strscpy() as it guarantees
NUL-termination on the destination buffer.

In crypto.c:
We expect cipher_name to be NUL-terminated based on its use with
the C-string format specifier %s and with other string apis like
strlen():
|	printk(KERN_ERR "Error attempting to initialize key TFM "
|		"cipher with name = [%s]; rc = [%d]\n",
|		tmp_tfm->cipher_name, rc);
and
|	int cipher_name_len = strlen(cipher_name);

In main.c:
We can remove the manual NUL-byte assignments as well as the pointers to
destinations (which I assume only existed to trim down on line length?)
in favor of directly using the destination buffer which allows the
compiler to get size information -- enabling the usage of the new
2-argument strscpy().

Note that this patch relies on the _new_ 2-argument versions of
strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/ecryptfs/crypto.c |  4 +---
 fs/ecryptfs/main.c   | 26 ++++++--------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 2fe0f3af1a08..d39a1a69fecc 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1606,9 +1606,7 @@ ecryptfs_add_new_key_tfm(struct ecryptfs_key_tfm **key_tfm, char *cipher_name,
 		goto out;
 	}
 	mutex_init(&tmp_tfm->key_tfm_mutex);
-	strncpy(tmp_tfm->cipher_name, cipher_name,
-		ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-	tmp_tfm->cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+	strscpy(tmp_tfm->cipher_name, cipher_name);
 	tmp_tfm->key_size = key_size;
 	rc = ecryptfs_process_key_cipher(&tmp_tfm->key_tfm,
 					 tmp_tfm->cipher_name,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067f..577c56302314 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -256,11 +256,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 	substring_t args[MAX_OPT_ARGS];
 	int token;
 	char *sig_src;
-	char *cipher_name_dst;
 	char *cipher_name_src;
-	char *fn_cipher_name_dst;
 	char *fn_cipher_name_src;
-	char *fnek_dst;
 	char *fnek_src;
 	char *cipher_key_bytes_src;
 	char *fn_cipher_key_bytes_src;
@@ -293,12 +290,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 		case ecryptfs_opt_cipher:
 		case ecryptfs_opt_ecryptfs_cipher:
 			cipher_name_src = args[0].from;
-			cipher_name_dst =
-				mount_crypt_stat->
-				global_default_cipher_name;
-			strncpy(cipher_name_dst, cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(mount_crypt_stat->global_default_cipher_name,
+				cipher_name_src);
 			cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_ecryptfs_key_bytes:
@@ -326,11 +319,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			break;
 		case ecryptfs_opt_fnek_sig:
 			fnek_src = args[0].from;
-			fnek_dst =
-				mount_crypt_stat->global_default_fnek_sig;
-			strncpy(fnek_dst, fnek_src, ECRYPTFS_SIG_SIZE_HEX);
-			mount_crypt_stat->global_default_fnek_sig[
-				ECRYPTFS_SIG_SIZE_HEX] = '\0';
+			strscpy(mount_crypt_stat->global_default_fnek_sig,
+				fnek_src);
 			rc = ecryptfs_add_global_auth_tok(
 				mount_crypt_stat,
 				mount_crypt_stat->global_default_fnek_sig,
@@ -348,12 +338,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			break;
 		case ecryptfs_opt_fn_cipher:
 			fn_cipher_name_src = args[0].from;
-			fn_cipher_name_dst =
-				mount_crypt_stat->global_default_fn_cipher_name;
-			strncpy(fn_cipher_name_dst, fn_cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			mount_crypt_stat->global_default_fn_cipher_name[
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(mount_crypt_stat->global_default_fn_cipher_name,
+				fn_cipher_name_src);
 			fn_cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_fn_cipher_key_bytes:

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240321-strncpy-fs-ecryptfs-crypto-c-a59b3cf0a3cc

Best regards,
--
Justin Stitt <justinstitt@google.com>


