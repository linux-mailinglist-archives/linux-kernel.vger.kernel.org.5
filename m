Return-Path: <linux-kernel+bounces-127016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 564708945D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E0D1C210DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D7353815;
	Mon,  1 Apr 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yyhp8BXB"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C3020DE7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001714; cv=none; b=B/kdK8frxelOrHltu4Nzb8FN5yu+Q2fPa0aKxrXuRxHsm8IpgQWxJjmxUZ1kC1NkD0PHA2YNFLLJTvn4IyhqXMKFNPMUGBPILsOkYwdDficg8ccZrIyHj22jIw0clZiF3ln8rzLallBlXRofdSEvVF5E7kjqUEBtX8KgPH2DFQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001714; c=relaxed/simple;
	bh=d4AgVvQfDxsO4HKlrM9TlJqYk+dfwSSv3RP/H+3B2M4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KvChoWtHzoWTdwJ0GrHsUubb9xvzGGBV2AUYnMYt/r92V/271Qrf9P+f8hbMmDjpZwf8/Yt458dX1tdrNiLOWPPRnEjpUJxdAUjYyLkqma3F+gyuYhwoAXLSez9sQ44Flwjl4vXeWD5v9AgYz4zt8vFsh9/RWh1ZtaLKaAp15i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yyhp8BXB; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615119b39deso6052177b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712001712; x=1712606512; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ohu9J8V3slBzBNecdA/Mm/ogrugR1WhcZXDtgnukl9Y=;
        b=Yyhp8BXBL0SfHFg8fHIJ2KxkxMp+n01k8sajY2bDBerMNpwwstRYGKxOtVJOXqnAPN
         TFm9Xkc/hiJ9isz/QerjkWR+OYmsYZ3vngbAL71KWkso2Ssaq4HO0F1anEvKTY+SQQKZ
         vKGU+WB5io2otNs/ECt2ltOAoQbN/9IKy14r8ZZUEjtX3qQaaCKmGPXldOZ0iH9jmEuM
         ATsrT3ORSD5uqSLFbKxiKegV6aKkt0z+HCdGkuIQlFVQEIHBkfqtBVpVdCeCiPFNWALE
         oj1oV/mVre0rF0OaPD+2cebPXWMP58S+Mm7O9XH0MYxHsYMk5SDQZn1+6tzbCGo9Uq8z
         9ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712001712; x=1712606512;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohu9J8V3slBzBNecdA/Mm/ogrugR1WhcZXDtgnukl9Y=;
        b=gTzOp/V731J47kO65OkWLJP3YKbGw5IOT2ljB2xgdmR7Czdm+TnANimPJsG557gxGl
         AcSZWgo893sHyG7NRG51HF5TE+vQuk0+oxj6QJvj+A6e3sDogynv5bidOEm3fpTTU3+D
         2UJl+V+XpEjVfqF4XdZR/etO3z80+/YW8ambx2sc9fBC8ZJAlTWCdpDwEvyEkJ7T1m0U
         nCh4zrzJf5IBrmFAxETNUKedIiTlG8CAExFH72ua3h+zx9vnEOT3m9hoYz7y/qNbdSGD
         sXhVW/EkbYdHI10epM6wx5JYgIr96MKwTybjiwok6Ip1zQjC+Njxt0BPTCYufepymtwn
         ZLRg==
X-Gm-Message-State: AOJu0YwuAPXyOvVRTcpTocrKnW5FUQY1m/BQSlKtoFHOE34iXtUeccwf
	HOqQuMiTw/tepg/NwA6jwzJpgfHtjiqDbIOKdL3UVmLu4QQQhiTXqpxAinGQsKW0OWFokBtUbGq
	8jMUZe6/CGceOr9fFtTNQoQ==
X-Google-Smtp-Source: AGHT+IFV/55l3VXvrIqD3f5Ut3eTi3qLd5jLPB1PRdN8bsHilEXwud8S56q7n8vTh8Iw9WSvYUNIMFJWRqfjoSszYQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:e2ca:0:b0:611:33b5:8555 with SMTP
 id l193-20020a0de2ca000000b0061133b58555mr2903019ywe.3.1712001711942; Mon, 01
 Apr 2024 13:01:51 -0700 (PDT)
Date: Mon, 01 Apr 2024 20:01:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAK4SC2YC/x3MQQ7CIBBA0as0s3YSKBitVzFdIAw6G0pmbKMh3
 F3i8i3+b6AkTAq3qYHQwcpbGbCnCeIrlCchp2GYzeyNNxb1LSXWL2bFPWXUvZJgxOXq/PlCDx+ igxFXocyf//i+9v4DrBtO72gAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712001711; l=2724;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=d4AgVvQfDxsO4HKlrM9TlJqYk+dfwSSv3RP/H+3B2M4=; b=WzUrYsCQC/OoCv2dtg4p+2iW/utOWrqjmReCDJPMh+lESSzaXdlVNUPjmGGj1+E4BDThJmSzA
 v+K+74E6xaOBc/aVcVyjlsLdIqXrFVfnW5KDHiO4lwSaRygoQnVvkwY
X-Mailer: b4 0.12.3
Message-ID: <20240401-strncpy-fs-udf-super-c-v1-1-80cddab7a281@google.com>
Subject: [PATCH] udf: replace deprecated strncpy/strcpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Jan Kara <jack@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. Also replace an instance of strcpy() which is also
deprecated.

s_volume_ident is a NUL-terminated string which is evident from its
usage in udf_debug:
|	udf_debug("volIdent[] = '%s'\n", UDF_SB(sb)->s_volume_ident);

s_volume_ident should also be NUL-padded as it is copied out to
userspace:
|	if (copy_to_user((char __user *)arg,
|				UDF_SB(inode->i_sb)->s_volume_ident, 32))
|		return -EFAULT;

Considering the above, a suitable replacement is `strscpy_pad` [2] due
to the fact that it guarantees both NUL-termination and NUL-padding on
the destination buffer.

To simplify the code, let's use the new 2-argument version of
strscpy_pad() introduced in Commit e6584c3964f2f ("string: Allow
2-argument strscpy()"). Also zero-allocate @outstr so we can safely use
a non-@ret length argument. This is just in case udf_dstrCS0toChar()
doesn't include the NUL-byte in its return length, we won't truncate
@outstr or write garbage bytes either.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/udf/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 2217f7ed7a49..77d32fe14434 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -895,7 +895,7 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 	int ret;
 	struct timestamp *ts;
 
-	outstr = kmalloc(128, GFP_KERNEL);
+	outstr = kzalloc(128, GFP_KERNEL);
 	if (!outstr)
 		return -ENOMEM;
 
@@ -921,11 +921,11 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
 
 	ret = udf_dstrCS0toChar(sb, outstr, 31, pvoldesc->volIdent, 32);
 	if (ret < 0) {
-		strcpy(UDF_SB(sb)->s_volume_ident, "InvalidName");
+		strscpy_pad(UDF_SB(sb)->s_volume_ident, "InvalidName");
 		pr_warn("incorrect volume identification, setting to "
 			"'InvalidName'\n");
 	} else {
-		strncpy(UDF_SB(sb)->s_volume_ident, outstr, ret);
+		strscpy_pad(UDF_SB(sb)->s_volume_ident, outstr);
 	}
 	udf_debug("volIdent[] = '%s'\n", UDF_SB(sb)->s_volume_ident);
 

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240401-strncpy-fs-udf-super-c-983457eb4ac3

Best regards,
--
Justin Stitt <justinstitt@google.com>


