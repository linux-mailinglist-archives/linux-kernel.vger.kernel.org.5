Return-Path: <linux-kernel+bounces-106009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF987E77A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0152C1C21060
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BF832C9C;
	Mon, 18 Mar 2024 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L/KAllU8"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905652EB14
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758410; cv=none; b=WFIya6flHOOy7f6m+4nOX0Ke2k1A+WYDm2SA0dXswvZz6eUBjZasO/rr89/sr+s4uLbJ53FiWe5GoVPqs4X36leRwTwHyyjxKcaKvJODCDCMOX4L+xZ2B3ix7ShgIPuLn56RyKowOrRfUlWL3NHHAygZq4wsHTEo6g4CIHi48f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758410; c=relaxed/simple;
	bh=mWlzxMbIZuWLXbPXbdzePV4/OdHCOixoEUI0M1hFEvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbeXiMsfhYD2wE7tUMw/URo3YVBizTjxo8bjg8U8udC7AMfDqJnwaix4ktjDavBFxyLaL/Mf1WDis3Qsjf876lv/24POlWD6FVVezj9pFp1xRkAau8V/lmaZ9P8mxUXru9DVTOJiGSJOKpkY/7VS9eZ+t9UAE8CPYyTvdhMkq/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L/KAllU8; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6adc557b6so3926326b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710758408; x=1711363208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQUHrqHWjcyGyF/NEsfpZqczPZC6iW3/Q7JuMvHiRfE=;
        b=L/KAllU8PCNCdT2CgaOP6jFTNz3qN/DAHOezgjsWw4wOf/+UTTcT2m4weM7wpXoHeM
         SdnttVQscSw6wtu/ACVl+S53YkbW3nJOjV8DPaxrWlm6SgYhx2TkE91bCBUNKAiILXfR
         ozaA97Kp6ZNgyCBhQ2gD1tWxP6bFtS+wpnVFI2vmlUmyIAuviddnKiZwwsFXZ53JJqb3
         Tx5yruLTcmuTrfewQ0vmrLUR5O5O9oOw9ZMkqz6xgmYSjuOEsIXVxyarvthgK5ztVNoJ
         EoQ/9MEHT8IcetgD6GG0beUJa76yZr6LRq25CaGajw4sUVxN0bUMlaAOytqiFpx71Wqp
         stkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758408; x=1711363208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQUHrqHWjcyGyF/NEsfpZqczPZC6iW3/Q7JuMvHiRfE=;
        b=F/47bJ8lspLBzG6Rs5sm2hsyF5u7WsISMs5mxJwgnlBZud/vqOtVtfPfDmg6OBvfrd
         fqh8Gd5vNwcy4u11FIYjUtWKM7rOH+e5BB3EzU2UxWRamMijmREGQyECacHSClRAqaar
         LJTW765IaTn0rvieh+Y1i9sm8CzQMCgSwE6l3p7FPkN6IZo/Xt5S8rgOpwdSPJ0tBXnL
         8yzrAhlES9QlV708nwJK5K7GD8jlwjxz5uN9VT7fd/RNSv09nlfoDuFyxyybitehM5SD
         NoZGF/fjMuLw3zdPUN72e0eneLYWsGsbOSpSSr/Xutz8SGlaBVuuydR32f1E8mSN7H8h
         vXCw==
X-Forwarded-Encrypted: i=1; AJvYcCXKEovIbsHCYuLJbzPLUiw6BJrdZnJ8gz8GMFO6XcMQDfcRH6aX/pRjCaujimKdGwjAFidjPOuNy9dJMDo/VUDcXTGO0iqLOGadCIVS
X-Gm-Message-State: AOJu0YyN5FpI7pxzZdWT0BNo3shkO7Q0PWEcB9wEpBfmv27gB3y/V/gs
	S6THzHHMXd546mgGo9dDFihUt8UGqT2okqPKBCcXEIxVsvtjIqs/9otsgNTcBGA=
X-Google-Smtp-Source: AGHT+IHBRt10B3JNwV8vX+UWPVBlF2Eg87pHt2EqyuL8zRUXC32dZPfWh7m+ZkrSI2TISV+eofA7Yg==
X-Received: by 2002:a05:6a00:816:b0:6e7:2018:aabd with SMTP id m22-20020a056a00081600b006e72018aabdmr4873937pfk.8.1710758408088;
        Mon, 18 Mar 2024 03:40:08 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a00008b00b006e647716b6esm7838969pfj.149.2024.03.18.03.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:40:07 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 18 Mar 2024 18:39:55 +0800
Subject: [PATCH v3 2/7] riscv: smp: fail booting up smp if inconsistent
 vlen is detected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-zve-detection-v3-2-e12d42107fa8@sifive.com>
References: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
In-Reply-To: <20240318-zve-detection-v3-0-e12d42107fa8@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andy Chiu <andy.chiu@sifive.com>, Vincent Chen <vincent.chen@sifive.com>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Greentime Hu <greentime.hu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.13-dev-a684c

Currently we only support Vector for SMP platforms, that is, all SMP
cores have the same vlenb. If we happen to detect a mismatching vlen, it
is better to just fail bootting it up to prevent further race/scheduling
issues.

Also, move .Lsecondary_park forward and chage `tail smp_callin` into a
regular call in the early assembly. So a core would be parked right
after a return from smp_callin. Note that a successful smp_callin
does not return.

Fixes: 7017858eb2d7 ("riscv: Introduce riscv_v_vsize to record size of Vector context")
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/linux-riscv/20240228-vicinity-cornstalk-4b8eb5fe5730@spud/
Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
---
Changelog v2:
 - update commit message to explain asm code change (Conor)
---
 arch/riscv/kernel/head.S    | 14 +++++++-------
 arch/riscv/kernel/smpboot.c | 14 +++++++++-----
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 4236a69c35cb..a158fa9f2656 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -165,9 +165,15 @@ secondary_start_sbi:
 #endif
 	call .Lsetup_trap_vector
 	scs_load_current
-	tail smp_callin
+	call smp_callin
 #endif /* CONFIG_SMP */
 
+.align 2
+.Lsecondary_park:
+	/* We lack SMP support or have too many harts, so park this hart */
+	wfi
+	j .Lsecondary_park
+
 .align 2
 .Lsetup_trap_vector:
 	/* Set trap vector to exception handler */
@@ -181,12 +187,6 @@ secondary_start_sbi:
 	csrw CSR_SCRATCH, zero
 	ret
 
-.align 2
-.Lsecondary_park:
-	/* We lack SMP support or have too many harts, so park this hart */
-	wfi
-	j .Lsecondary_park
-
 SYM_CODE_END(_start)
 
 SYM_CODE_START(_start_kernel)
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index cfbe4b840d42..1f86ee10192f 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -218,6 +218,15 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int curr_cpuid = smp_processor_id();
 
+	if (has_vector()) {
+		/*
+		 * Return as early as possible so the hart with a mismatching
+		 * vlen won't boot.
+		 */
+		if (riscv_v_setup_vsize())
+			return;
+	}
+
 	/* All kernel threads share the same mm context.  */
 	mmgrab(mm);
 	current->active_mm = mm;
@@ -230,11 +239,6 @@ asmlinkage __visible void smp_callin(void)
 	numa_add_cpu(curr_cpuid);
 	set_cpu_online(curr_cpuid, 1);
 
-	if (has_vector()) {
-		if (riscv_v_setup_vsize())
-			elf_hwcap &= ~COMPAT_HWCAP_ISA_V;
-	}
-
 	riscv_user_isa_enable();
 
 	/*

-- 
2.44.0.rc2


