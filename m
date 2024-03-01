Return-Path: <linux-kernel+bounces-89107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667286EA89
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B796F28F425
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AD03D572;
	Fri,  1 Mar 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="qoOjG5/j"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76F3D55D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709325842; cv=none; b=XH3MHdRhwA7Wru4SJUlHJb2e4M7li3YFDxBXv34t3ZRUUQkbRVT4AhWcFhKihP9sv0ABQJVHofuLdHig+c7osf/JuXHym0R/MYi7aL3D/62DczazEQwKKp94p4rFn60140mj1Xp5gwa7gp2UtTerRl4LQmgmFRbQ2uL1m+HRMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709325842; c=relaxed/simple;
	bh=sUfNkHPoo9V2T9fMcmHeyl/JS8OZvn4x9zPyEVooEi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AC2s00hCMjq5A10hEF3hJIgLo5e8WzglGOb2AXV8MRCa/7UsdAuN2XNH3LdUrnj5yJnltN6Nn4nfelSGjWQjMpeTR12XL7OQC4mzFLkI9QI9q7EuN3EtBHm1iYW8oyskIOjbzxSw3nr4B7cxk4G3FKcaWXlwrwq32BAZumQ8Tzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=qoOjG5/j; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a44b0b2c7cdso110098966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709325839; x=1709930639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HnyW+esM+BKf2jxrZdh8XqknpO03iR3YuY63S1e4b0=;
        b=qoOjG5/jfIB30hsbW5XXzj7dxMkd6wE2MshnIu/K7hTMNtDee0cTrGenGNb9WLMsDE
         oQbMpfQw+GL0pjZ5djoTnvh+7ahmJd5BF+I0G8tyuqnotkHflQDGo5YZkdeGNYmzPImG
         oZbSHnSGB64yNeYxh0IzJekIu/AScKoFzeCLSq/alRQIbhXFrUyXXu+64VLuxVfm8GWQ
         Vsd7BV5CpksDQUQrqhJ6vmLr1YkB/+mZhMO+wdtR9iOA4H08P73dVvSBMFTH8WYy2MoP
         WQnKZm2uSJpXilHJR0G8k92DElJTGNfDjOjdEor5K1Ywb1fUo2YS6D5FY1VZg9WvZbc0
         YcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709325839; x=1709930639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HnyW+esM+BKf2jxrZdh8XqknpO03iR3YuY63S1e4b0=;
        b=bch13A8SORMY00UjG9T9SW1Rfbzpcx3qWDMKq3fW048zksQ7R4Gol/dvlGMTVdvLzT
         PVGua5Zi2B6Ay19NTwDjiHyvdERqWkvBzIo1q28qW2ksX+Sj+0quFfOXHDhQbhVISK5l
         +97H6dgjY4JF4uKuhSLk4cUd74BdWHI/P88RxaFG1dcBujFbg14Wxh9vtJavEaLtKWDN
         c1s1lgFCqsGH/5w7eNmkcOeqbWOh1tSzomEi+7z7YKWWOyGXSiyTDVqIlXqFl0TGNdYg
         SiM0T6yHVOSA13vsJa+QbzW8NY/hmbVVpTCTO+uTLbnyFSXZe2oIeZftXIrgybNHXALW
         0jnw==
X-Forwarded-Encrypted: i=1; AJvYcCVOAG/j2i0I0ZTiOom59ER6/a2KouruRcAeoo3t/fCNcfX4FJBo5LmN6jcqCUfvMmS+QID4wTBrVYUJ8vmxzmSxMAuqzYYBivQK9wnI
X-Gm-Message-State: AOJu0YxwM7YAS7nEHeexoSWXG7tCnkH4aLjzOMBKPGzdZplh0ChnDnRs
	2McwAFg53KELatdQDdDacsX9R74Y7rwP3KxAleQoAiaO6BjV8GExKypmtWY0G/8=
X-Google-Smtp-Source: AGHT+IE7p2FuGWmCkIvX2UxIH/G/OwPt64X3vwqabXyM+0Gf/SqpN76b9W+UCjYPRBkAVsroaNq2GQ==
X-Received: by 2002:a17:906:ae4e:b0:a41:30be:4a82 with SMTP id lf14-20020a170906ae4e00b00a4130be4a82mr2127487ejb.61.1709325839106;
        Fri, 01 Mar 2024 12:43:59 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id cm29-20020a170906f59d00b00a3ce60b003asm2065880ejd.176.2024.03.01.12.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:43:58 -0800 (PST)
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
Subject: [PATCH v2] x86/apic: Use u32 instead of unsigned long
Date: Fri,  1 Mar 2024 21:39:03 +0100
Message-ID: <20240301203901.150465-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <8ECEC999-A742-488F-99B2-A076EF9CA2B2@toblux.com>
References: <8ECEC999-A742-488F-99B2-A076EF9CA2B2@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use u32 to fix Coccinelle/coccicheck warnings reported by do_div.cocci.

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


