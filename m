Return-Path: <linux-kernel+bounces-81228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0B867249
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79EC91C25403
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476B12CCA0;
	Mon, 26 Feb 2024 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQVJPwDn"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F3B2206B;
	Mon, 26 Feb 2024 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944877; cv=none; b=r6HUqhuomQTes6CT6Rfln6SNDx4LGuTf8ANbL3SLdIwxV1AG+JbMbAz3DPXLn7aefVNV0ofcX7+GNUUpGbF6MQg4CUKLFNi4ARLwx/X5NsffbI1qTGoFoptp7RL0za/AEfPQRS34gvRPe6XPbUikrRf1O3A1dFLNPX3GhmhGSuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944877; c=relaxed/simple;
	bh=8xB3k09RSJts2z0NK9alSi0oCp0ekNEmZOpK3Mqg9FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIIBZJkL8GqhE1IynOabLMIojnlVIii6viRmYyjsNF27Rl9ASlYpbXIJl92qQYWV1s/JKr4ojO0eNoCY4aBHV1/PlVkTS8dzAgfM20fYQpOkSJ1ke2EKG7W28sMVCZZbmDQ5XipC6wmeU+pultQJs2Bx3ct9CHEu8ZXKSTBb9hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQVJPwDn; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512fe342841so543196e87.0;
        Mon, 26 Feb 2024 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708944874; x=1709549674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYVbCLcMxay+zfpwGmsXhfLKgVTaAV17WjEUbbfo6ys=;
        b=jQVJPwDntnf2yUUogwJ+dz94dBMp5v0uq1PFEsT65KGD2hClSwddORzshuDqABvVJX
         dSqOws/TUeiQqfqt9w5FlxEkt5M0YTFY+ew1XVCjp2pAwQ2mMcXLz6XuANrutqnawy/m
         gulv+q9xoeQQUOP/oLdZg5zauG1HJY0vdeQBMpHdjHA1kCDtB5xiF++jG/JMJT7xWDuw
         ajLRPAc4swrYVCUpq9lYl5Ki4YoqC8rctxHHMN5dp96IOBL/OvAUDfmaV5kBxgJpIYvQ
         3fsNsB5Z/AQ+msYDIMqPKPzG933jDdLK93+BVgzjjgerTlvyuBzyePS48yZ5BK2K400I
         Bnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944874; x=1709549674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYVbCLcMxay+zfpwGmsXhfLKgVTaAV17WjEUbbfo6ys=;
        b=NMewOk4PS8OaFlXME5AU7zzjJCzhDOEIWrGUBdynsPwPS4es9TLAerhvPU+WJhu6NQ
         aQGvN9/uRr3Kyj4sc7KkkQvnSIFOD2fvjaWP01IeFtpohVxnBJaVI4925pi5zSuOWIwi
         TwCCjxyPzJR/XXWMbDcTMyRiruAoy4D11Msw3tfoBqK7zqzgmCcqPwH41goZ7e+dep7V
         kIGgL3Q7huOcyS6zMhyUdd9Jt+74PYX5oh3KyVoUv4qdLoBhv/GrgT0GqES7/MNyDGKD
         BgKhXihdb40YCdkVFMzH7jFQK044sDtbbkNuiXbF0zDSAA3wAd3jnXP+h1mHVLeao+ll
         mA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVq5/V81yUQVhoutyAUAQ37CtRCb1zyLe+sxo5Ytsd59HwhxmiZb2axETjJB2pNxJM6q99Od2ESKplsG4EQG4RzODxjusUmqcwtYUnzkEtG7br6eJxaujiTR/t8PoKUnfo9tcB1ZAdAHQ==
X-Gm-Message-State: AOJu0Yy6OCWx0RzI72xHXSQJIV168UT7NoSGPPMcVmtOJgRSxTi5HDnR
	OpUsbA2FvxAQx+Y+tZUvIkrW83dk5nyYiPPxijMQeEbtdrgzXO9W
X-Google-Smtp-Source: AGHT+IHcUiHhuNtht/nsiRIPXJD2/gdhNYyv//ly8x6RMo9aEOcIb52RkSq9/S0gKD2HyzHnsGKfbA==
X-Received: by 2002:ac2:5e75:0:b0:512:b2b0:89d with SMTP id a21-20020ac25e75000000b00512b2b0089dmr1895157lfr.28.1708944873988;
        Mon, 26 Feb 2024 02:54:33 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b25-20020ac25639000000b00512ffcdcde8sm171626lff.1.2024.02.26.02.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:54:33 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] mips: cm: Convert __mips_cm_phys_base() to weak function
Date: Mon, 26 Feb 2024 13:54:22 +0300
Message-ID: <20240226105427.7191-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226105427.7191-1-fancer.lancer@gmail.com>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on the design pattern utilized in the CM GCR base address getter
implementation, the platform-specific code is capable to re-define the
getter and re-use the weakly defined initial version. But since the
pattern hasn't been used for over 10 years and another similar case (CM
L2-sync only base address getter) has just been fixed, let's unify the
interface and convert it to a more traditional single weakly defined
method: mips_cm_phys_base() (see the link below for the discussion around
this).

Link: https://lore.kernel.org/linux-mips/20240215171740.14550-3-fancer.lancer@gmail.com
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Convert the underscored method to a single weakly defined function.
---
 arch/mips/include/asm/mips-cm.h | 7 +++----
 arch/mips/kernel/mips-cm.c      | 5 +----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 6cc79296c8ef..c4e27970d88f 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -22,16 +22,15 @@ extern void __iomem *mips_gcr_base;
 extern void __iomem *mips_cm_l2sync_base;
 
 /**
- * __mips_cm_phys_base - retrieve the physical base address of the CM
+ * mips_cm_phys_base - retrieve the physical base address of the CM
  *
  * This function returns the physical base address of the Coherence Manager
  * global control block, or 0 if no Coherence Manager is present. It provides
  * a default implementation which reads the CMGCRBase register where available,
  * and may be overridden by platforms which determine this address in a
- * different way by defining a function with the same prototype except for the
- * name mips_cm_phys_base (without underscores).
+ * different way by defining a function with the same prototype.
  */
-extern phys_addr_t __mips_cm_phys_base(void);
+extern phys_addr_t mips_cm_phys_base(void);
 
 /**
  * mips_cm_l2sync_phys_base - retrieve the physical base address of the CM
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 268ac0b811e3..3a115fab5573 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -179,7 +179,7 @@ static char *cm3_causes[32] = {
 static DEFINE_PER_CPU_ALIGNED(spinlock_t, cm_core_lock);
 static DEFINE_PER_CPU_ALIGNED(unsigned long, cm_core_lock_flags);
 
-phys_addr_t __mips_cm_phys_base(void)
+phys_addr_t __weak mips_cm_phys_base(void)
 {
 	unsigned long cmgcr;
 
@@ -198,9 +198,6 @@ phys_addr_t __mips_cm_phys_base(void)
 	return (cmgcr & MIPS_CMGCRF_BASE) << (36 - 32);
 }
 
-phys_addr_t mips_cm_phys_base(void)
-	__attribute__((weak, alias("__mips_cm_phys_base")));
-
 phys_addr_t __weak mips_cm_l2sync_phys_base(void)
 {
 	u32 base_reg;
-- 
2.43.0


