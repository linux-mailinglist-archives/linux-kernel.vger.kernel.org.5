Return-Path: <linux-kernel+bounces-92454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E22F387205E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1214D1C23237
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCC18614C;
	Tue,  5 Mar 2024 13:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="IFAAh9Et"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99C85C7B;
	Tue,  5 Mar 2024 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709645881; cv=none; b=PtD32EHCXa/s4tGvOiOHpDZ+NZwnTo+Cb/sIq6+kyk1+MswglI0O2y/tncRmW6585AgTbICGVYlrg0CmahqpayFn6xNnqjvviRPhzkefpOxKaGsNan3KuXBBhs9dpSIRGfx7lEX9OcaNTlqd0RfZqlTRHMX+Zim2Il+MouT17q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709645881; c=relaxed/simple;
	bh=TNlY1e36myGTfYO8pTuVFOr+Ap0PleNaokblvqP8fmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0g6cG5kBN0dD8qweW7k+Idl/JuFh8fTptZWipCvncF0uTp9yYRqxSL/kPCs9O26sduw/2Lb6Npe55zpN39Uru5n+kPABCi3KNopTSSISdHfveiSYa77VuUuMXvmw8ag+jZUgxgQrFUG9/9zuRwfsTNoYfABZbEbIfR8C4z580Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=IFAAh9Et; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cedfc32250so4902766a12.0;
        Tue, 05 Mar 2024 05:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709645880; x=1710250680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNOF+/pr6oPp3zreBaQy80bebzg5O2KDW6z8yCKWOro=;
        b=ZhHVQd6fu5QhYwp799FS8LbuUMc2mZSXWx8qtQLTRyQDmKXOhaNds0Q147QsKN8Q10
         zF2gyVlgS7tnRibrTA7bYWmhGTebXqYy2tRUP3E7wXWFLXtO4WA/INUwgve/KsxvNll2
         uf/wmOGobtnH2/CLxqh3l0ojinA8al9bmV8R/m+aXU+A30f6duAEhlRzBPVZSrs9n+64
         IDI2MVzbBbwKXTwZfjZGnNxIDBanYMtPgtxXrIfuaKHZBjMCpXP6Becwspowq9mOxLwE
         gerl+XXrvP0MMR8zx5WuHIbtM2/D/EdMJ5FeXShNVU6LinA/vl3K0m4ta+Jpf9nq+mr9
         Rmig==
X-Forwarded-Encrypted: i=1; AJvYcCWGZZyo2c3LydeSS3itQ9SPt56mr/OvZ8vyCMCnD79vCOP4UKn68TpRkbEEtj5eViPtVuMgfr7gyquvKySuiCYxUbn+iwN+CZVNiJUm
X-Gm-Message-State: AOJu0Ywj+HokvshJy5YubqAu4NDuwj/RR6YSkfPvOOZp4XlgeA4joAJq
	7VY9oFwgB8XGLg9ghstAsBaVn8xlEl6LUfgvvM37vZ4tT0jEGEN3Y+YOFv4d8zuN3Q==
X-Google-Smtp-Source: AGHT+IHKko49MK0XfiDUXC91H6w3LCLLSXfcK8SMzT6staEd3Ru+UpGkiQyvb3JxiOBLM8tyDLEuMg==
X-Received: by 2002:a05:6a20:4c20:b0:1a0:e03f:dee with SMTP id fm32-20020a056a204c2000b001a0e03f0deemr1308143pzb.43.1709645879688;
        Tue, 05 Mar 2024 05:37:59 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id rj10-20020a17090b3e8a00b0029996fd70e2sm9510232pjb.45.2024.03.05.05.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 05:37:59 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1709645877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lNOF+/pr6oPp3zreBaQy80bebzg5O2KDW6z8yCKWOro=;
	b=IFAAh9Etq3IoxkwKUQ3sVwRHaxvadKKyX7ZIa9P+kAP2RW9vEvNI8qQK1lK9Ew3XBaguTk
	i6u3xAn9rVp0j2pNg2FkHQJcQbTZtDhoHQEh9i+eW1gprawym2bIu+FAfcUdIhJrzy7K/1
	zTUzdbF/A/fkCQaRa3zZ/b7ehAIAqfMbAYRv+OnkqSN9+BKTLr/TpoZYTCUBsVDmJjq5W5
	RPbtn9n+TiPJ2J8dIPLL8VuUAJ8cLOqlvuGcUulvBtMSx30uR2lqVcsopXpGNkCRXFFZCy
	+PuQekpbMzuPbN85QnU7xpFdqWVhzepyk4RCP/LX9QVN2+FXqVENV2pCX6CFZw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 05 Mar 2024 10:37:50 -0300
Subject: [PATCH 1/2] mips: mt: make mt_class constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-class_cleanup-mips-v1-1-e93726711468@marliere.net>
References: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>
In-Reply-To: <20240305-class_cleanup-mips-v1-0-e93726711468@marliere.net>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=TNlY1e36myGTfYO8pTuVFOr+Ap0PleNaokblvqP8fmw=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl5yAuaeONegv9D8DreA4Gwy7oj1wOIDjIxcGFo
 jajy7t9iquJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZecgLgAKCRDJC4p8Y4ZY
 pt1rD/92sRV2fkWQRBwgt3KloAZaybdC3zfNJDNiTGWph+jwXFZpYYtJat7IFw1SIB5OqcTtL7A
 NAPP5quFmCyPvKdY5Uq5nvTaf8XX26pFoHqXKunvJSK5kxkWbTFZKbkAzx8aWJRfKyUBvz+5K+4
 EaAFn2EaDAdg0m6c+E1LJKMJRTrtqFdXMFZpqtHIEwA4U3cH46fKM5eSfzC/H+XHzZnPRgYinY4
 ftMjpVxDMQ68sdHn7OmeSh+zGjTyTulGADV/PNEgqDzq6ncnNm3himB3RB2DTPUBRINIoLS566b
 heF5iXJlSd992Prm6U8QG4uTQp2xfEfnhdtMOtddUIYXD1XfOSMXmtIApSy+/h8j0ivJtX8Zzz4
 cJmzgkiJGYDMQAGcXqeSh6m8mZxwKBxrONEnXUN8WR/DLQDQQDBIn6lFa7XtNQ2BUwlS34H073F
 9WdjfUwbUvDBDMSbmKno3J591gar03R83Hi9QiaUM+aOi5Vst5AhbEBm0SHk4i9f5RJtX3czFpM
 yt+uaB+tltmwlsInwCA/viF68ryT416fYq5eDh8p39E6Wzes8y07O0RFkGRO1/DlZvZBOaJckC/
 4y54nIRwhmyKwuajzTW0fSdG3qGauTKOSaeiCwHyi3afOsE1XYs/Q6lkuCFrf3oM6Pl5BaSEadM
 OHIMU7KHfda1ERg==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the mt_class structure to be declared at build time placing
it into read-only memory, instead of having to be dynamically allocated at
boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
KTODO: use device_register instead of device_create?
---
 arch/mips/include/asm/mips_mt.h |  2 +-
 arch/mips/kernel/mips-mt.c      | 14 ++++----------
 arch/mips/kernel/rtlx-mt.c      |  8 ++++----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/mips_mt.h b/arch/mips/include/asm/mips_mt.h
index b444523ecd50..28917f1582b3 100644
--- a/arch/mips/include/asm/mips_mt.h
+++ b/arch/mips/include/asm/mips_mt.h
@@ -26,6 +26,6 @@ static inline void mips_mt_set_cpuoptions(void) { }
 #endif
 
 struct class;
-extern struct class *mt_class;
+extern const struct class mt_class;
 
 #endif /* __ASM_MIPS_MT_H */
diff --git a/arch/mips/kernel/mips-mt.c b/arch/mips/kernel/mips-mt.c
index c07d64438b5b..c938ba208fc0 100644
--- a/arch/mips/kernel/mips-mt.c
+++ b/arch/mips/kernel/mips-mt.c
@@ -229,19 +229,13 @@ void mips_mt_set_cpuoptions(void)
 	}
 }
 
-struct class *mt_class;
+const struct class mt_class = {
+	.name = "mt",
+};
 
 static int __init mips_mt_init(void)
 {
-	struct class *mtc;
-
-	mtc = class_create("mt");
-	if (IS_ERR(mtc))
-		return PTR_ERR(mtc);
-
-	mt_class = mtc;
-
-	return 0;
+	return class_register(&mt_class);
 }
 
 subsys_initcall(mips_mt_init);
diff --git a/arch/mips/kernel/rtlx-mt.c b/arch/mips/kernel/rtlx-mt.c
index 38c6925a1bea..ff7535de42ca 100644
--- a/arch/mips/kernel/rtlx-mt.c
+++ b/arch/mips/kernel/rtlx-mt.c
@@ -95,11 +95,11 @@ int __init rtlx_module_init(void)
 		atomic_set(&channel_wqs[i].in_open, 0);
 		mutex_init(&channel_wqs[i].mutex);
 
-		dev = device_create(mt_class, NULL, MKDEV(major, i), NULL,
+		dev = device_create(&mt_class, NULL, MKDEV(major, i), NULL,
 				    "%s%d", RTLX_MODULE_NAME, i);
 		if (IS_ERR(dev)) {
 			while (i--)
-				device_destroy(mt_class, MKDEV(major, i));
+				device_destroy(&mt_class, MKDEV(major, i));
 
 			err = PTR_ERR(dev);
 			goto out_chrdev;
@@ -127,7 +127,7 @@ int __init rtlx_module_init(void)
 
 out_class:
 	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
+		device_destroy(&mt_class, MKDEV(major, i));
 out_chrdev:
 	unregister_chrdev(major, RTLX_MODULE_NAME);
 
@@ -139,7 +139,7 @@ void __exit rtlx_module_exit(void)
 	int i;
 
 	for (i = 0; i < RTLX_CHANNELS; i++)
-		device_destroy(mt_class, MKDEV(major, i));
+		device_destroy(&mt_class, MKDEV(major, i));
 
 	unregister_chrdev(major, RTLX_MODULE_NAME);
 

-- 
2.43.0


