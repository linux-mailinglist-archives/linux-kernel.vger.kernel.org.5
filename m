Return-Path: <linux-kernel+bounces-97022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9FC876481
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82AF1F222E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7237617753;
	Fri,  8 Mar 2024 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="UrhA2Sj6"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE033134A9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901988; cv=none; b=f2G7B0cJXGbImdV4wp2bYw3L+f8mUoojbqgrWX7V8noG790E6ZA1nBN/ZA2n0OKJ5HWDcnMO+b4ewdfxfJJJbkS6swf0DJkKh6tLh19D3ysoPC4XXmISUt8DzdBsajcs7Dld0ZRJyqMYKcAbYLGckD+/T8qUKkH0qY6ZJWi1hD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901988; c=relaxed/simple;
	bh=lC5yQxdaVNiFX1FCkgmTGC04REnu2YrGytPwqQ1LzKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nse4px8x0BCrWn/sr+o13Y7r2kPSxXAEdXndBTXGVkyVeozs+RYvM7Tz/yDZX4u0I4K3XZD3AmM7FKO2899lR7lgBleMVen32UUoahWTdFcLAoP8PCesweDSAefh+j+7X9I/A8B0+V6/dSv47OfxwClgOEALc2WHlx0OH0ozSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=UrhA2Sj6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412f62ee005so15206455e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709901985; x=1710506785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSC3VchrKSriPFqJb390A7+6m5EVYRKP2rJaLF33dcE=;
        b=UrhA2Sj6M7mGx/4nITO+wKJLXElxijV/+J9fu2bcmiiGk3ohEOzoMF7sMFO4O7LGZq
         vCo3EYUe93ltR9i7p1by/MOV+f8mhFTK/fpM0ozyrf5Bjyd4x45p573UyzfuUcDH8olQ
         uOj6Wq19Msou9Z5MrgIC9IAc45rDr4XpICdWUju90u44/irpOXsuj5iKL+xKuGZLOcxG
         AcG92510NUELCM+HRErVHKiHUjoAShYC7s3AaLcXnEuCR2/LuE9dcOx0CbGi5nWqJ45z
         PkXlGuBiXGJDpIkrC0mWYIiDnBWsgBLlIsPdLbLXMXU7xGWFngZI2lx3rA+LNgB0i37N
         X1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709901985; x=1710506785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSC3VchrKSriPFqJb390A7+6m5EVYRKP2rJaLF33dcE=;
        b=HyqBIIN7z8pOMJZLikcqVZqcZk34J7nkZGfvJxJ+mxAa9vM1Vshb87pbIhwkXu58HK
         H7pMPaXLRnJPCIXeDCdiwsRT6P6PKGOQwhXcTEsnbmEUqxY5C0XsE1CJgzRNwkgi13oO
         kiivbDtFl3DkxCS1dKllXpdEAs/Bf6v9YuDlmu54/z7fEnK+KRfnree/EmTxb3lvYn09
         5wxN24ulbGYteKpFVr4dpGDzD75CtpcPEcp00Cn8WEyagpG/4qyOiwEPVE80cR1BIK8l
         nC59PlxFxV3IhanyJqU0i41rIn3Ts8wgjwzc1prjZOpvA9+R7UBCX9TC+OAu3Miyu+ZY
         DG9A==
X-Forwarded-Encrypted: i=1; AJvYcCWm473pDGG0lrX+oeALtu2lPJ4OWu8ncrpZPK5ni0qkRCKYL4U43e2oJByKr7xNuDxm4PlxWOiu446QtVsVu0nt7LNCRJltSU+33Ow/
X-Gm-Message-State: AOJu0Ywn6lsmvsqXNecWDVln8higLOAIRfbpuO+vl4fTA45f/Rn4GO9f
	J1ZsyIfk9k5F49xerpYv+A94CX4HLQC3IJhC+hcFiFzq905D30vfKBv1I/iDRgs=
X-Google-Smtp-Source: AGHT+IF66YZUxLnyCYBBwG6/pgIqnrGGOsxmyygjR2zRqyH2HPn4eBpoLCe3akXubj7FR0wBp3/p1g==
X-Received: by 2002:adf:f94a:0:b0:33d:579e:f462 with SMTP id q10-20020adff94a000000b0033d579ef462mr15362918wrr.36.1709901984855;
        Fri, 08 Mar 2024 04:46:24 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-247.dynamic.mnet-online.de. [82.135.80.247])
        by smtp.gmail.com with ESMTPSA id bn1-20020a056000060100b0033e17341ebesm3486020wrb.117.2024.03.08.04.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 04:46:24 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: David.Laight@ACULAB.COM,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org
Subject: [RESEND PATCH v2] x86/apic: Use u32 instead of unsigned long
Date: Fri,  8 Mar 2024 13:43:37 +0100
Message-ID: <20240308124336.41654-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240301203901.150465-3-thorsten.blum@toblux.com>
References: <20240301203901.150465-3-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve types by using u32 instead of unsigned long. Fixes two
Coccinelle/coccicheck warnings reported by do_div.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Revert changing do_div() to div64_ul() after feedback from David Laight
- Use u32 instead of unsigned long to fix Coccinelle warnings
- Update patch title and description
---
 arch/x86/kernel/apic/apic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4667bc4b00ab..184e1843620d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -664,7 +664,7 @@ void lapic_update_tsc_freq(void)
 static __initdata int lapic_cal_loops = -1;
 static __initdata long lapic_cal_t1, lapic_cal_t2;
 static __initdata unsigned long long lapic_cal_tsc1, lapic_cal_tsc2;
-static __initdata unsigned long lapic_cal_pm1, lapic_cal_pm2;
+static __initdata u32 lapic_cal_pm1, lapic_cal_pm2;
 static __initdata unsigned long lapic_cal_j1, lapic_cal_j2;
 
 /*
@@ -674,7 +674,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 {
 	unsigned long long tsc = 0;
 	long tapic = apic_read(APIC_TMCCT);
-	unsigned long pm = acpi_pm_read_early();
+	u32 pm = acpi_pm_read_early();
 
 	if (boot_cpu_has(X86_FEATURE_TSC))
 		tsc = rdtsc();
@@ -699,7 +699,7 @@ static void __init lapic_cal_handler(struct clock_event_device *dev)
 }
 
 static int __init
-calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
+calibrate_by_pmtimer(u32 deltapm, long *delta, long *deltatsc)
 {
 	const long pm_100ms = PMTMR_TICKS_PER_SEC / 10;
 	const long pm_thresh = pm_100ms / 100;
@@ -710,7 +710,7 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return -1;
 #endif
 
-	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %ld\n", deltapm);
+	apic_printk(APIC_VERBOSE, "... PM-Timer delta = %u\n", deltapm);
 
 	/* Check, if the PM timer is available */
 	if (!deltapm)
-- 
2.44.0


