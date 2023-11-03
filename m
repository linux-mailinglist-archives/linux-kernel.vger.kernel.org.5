Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E7C7E0178
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346351AbjKCH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbjKCH6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 03:58:16 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FADE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 00:58:10 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so2927597a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1698998289; x=1699603089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPAmSObx1rTjBn4nXLAthbW9IygJi6dwZRaXAiU/c0k=;
        b=iUYsi+nYIOwDGO18ci6KREkynsVFgTPPqLnNOTd+lFrGU3oJkp6OvBGHg6cLOx0G3N
         fhOcrmfozaqcOa8umdvum/WMWb0o6oQPGQ22T4AqXOiyg/DMDbzXMPWKK4WgfAZpcwfa
         zAgGXT2yaIV4Xg+9HWx+lUbi7y88Bf1+AmDCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698998289; x=1699603089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPAmSObx1rTjBn4nXLAthbW9IygJi6dwZRaXAiU/c0k=;
        b=N6FZcJlTLh343g6O3zy9w2YAk/VgGaAhoZ2Ci+SAuR+hFfX2iFWrHs68Kqkp6ilAb3
         uTjutNM1GbwmEuIZSATgMk9eaKTgV086/ShI272gbEfi3WxLM4GWVc1plR8CQO1tnYEz
         d8mzQvWQvcWDpkq3vdmIkLnCF7ZZ2QVbdZb5xUs0Ue79kD8IBn3QgfAVZBo8rMuWDlo1
         5dwC5iPDVIoh7iWDhp2xCmUXhHLv41OXLDcux4g+mA/JYFbxLz7SpRLmTZVs5dM12sci
         vebfTZ4nRheumnMsbR63Me9jZc+aiLKXrxvqaRd7a1ADXf1iHCprtwab2t5+f6yY1ya3
         lHvw==
X-Gm-Message-State: AOJu0YwYTqMsTi0n1kDvFdDH380EVUYwoWfxVO1ulwOxmVhJ+DzBmKAW
        MkuXFAbhYXglx3jqeAPwSXrmIQ==
X-Google-Smtp-Source: AGHT+IGJK4iQupnRNttfSqheROBdR5rFmsaz8iuN25//lT545h/Jxz3DPSmcllXwCFl24PhKzhp3iw==
X-Received: by 2002:a17:907:3683:b0:9b2:be5e:7545 with SMTP id bi3-20020a170907368300b009b2be5e7545mr5710534ejc.36.1698998288263;
        Fri, 03 Nov 2023 00:58:08 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m21-20020a1709066d1500b009b9aa8fffdasm598994ejr.131.2023.11.03.00.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 00:58:07 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: VDSO: remove cntvct_ok global variable
Date:   Fri,  3 Nov 2023 08:57:59 +0100
Message-Id: <20231103075800.3254680-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cntvct_ok variable has not had any external user since commit
c7a18100bdff ("lib/vdso: Avoid highres update if clocksource is not
VDSO capable").

It also only has one user in vdso.c, once during init, so rather than
having the caller of patch_vdso() initialize cntvct_ok, just call
cntvct_functional() directly and avoid the global variable entirely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/include/asm/vdso/vsyscall.h |  1 -
 arch/arm/kernel/vdso.c               | 10 +++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso/vsyscall.h
index 47e41ae8ccd0..9a2cd2673a82 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -9,7 +9,6 @@
 #include <asm/cacheflush.h>
 
 extern struct vdso_data *vdso_data;
-extern bool cntvct_ok;
 
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index f297d66a8a76..ba87ffc6f194 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -67,11 +67,9 @@ struct elfinfo {
 	char		*dynstr;	/* ptr to .dynstr section */
 };
 
-/* Cached result of boot-time check for whether the arch timer exists,
- * and if so, whether the virtual counter is useable.
+/* Boot-time check for whether the arch timer exists, and if so,
+ * whether the virtual counter is useable.
  */
-bool cntvct_ok __ro_after_init;
-
 static bool __init cntvct_functional(void)
 {
 	struct device_node *np;
@@ -172,7 +170,7 @@ static void __init patch_vdso(void *ehdr)
 	 * want programs to incur the slight additional overhead of
 	 * dispatching through the VDSO only to fall back to syscalls.
 	 */
-	if (!cntvct_ok) {
+	if (!cntvct_functional()) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
@@ -213,8 +211,6 @@ static int __init vdso_init(void)
 	vdso_total_pages = 1; /* for the data/vvar page */
 	vdso_total_pages += text_pages;
 
-	cntvct_ok = cntvct_functional();
-
 	patch_vdso(vdso_start);
 
 	return 0;
-- 
2.40.1.1.g1c60b9335d

