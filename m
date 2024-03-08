Return-Path: <linux-kernel+bounces-97684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86121876DC8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 00:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0540B22964
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F2D3BBF2;
	Fri,  8 Mar 2024 23:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="JpGxm/qa"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68B3BBF7
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709939204; cv=none; b=NTlaQch2s31zOW8zfDB9rO0StjwIpAqmRicYl+gBlIHEmEFqXOwxmbFC0TqcoBrphV8Xr6SRrwGCAZDy0njQA09Qd1kZcUMSw62MaBqjAbpUKUvUhzegYPHe6FSkG4s4kxoX1j8LNOLBjGgIzxAG2RE+DUV9sVeHBMdPLMEJTEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709939204; c=relaxed/simple;
	bh=w8kGD73Xz/uZpQJ5ZgCw6GsFXXl9zD5Qm0dcGMbIXpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=blFSjdygk7lX6QLGA1iT0IHJ8c2I2hTwgMJyc70b0Cim/m1MoJ9s2U7Psj5MQ3SCq6fPzagfV5sH9fpVsMPMq8UeqDIYBzPfpBO1xf3OsGnQzX4LEST+UPsi0mLaFJVneZd3zAkNGSFtQOA721f1KILmbCTrQ+FwrHSMLUrgiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=JpGxm/qa; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d36736d4eso1797585f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 15:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709939201; x=1710544001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7t60vDpglsBHCmAmlybKd04G36JOxRBGBizt48yxWg=;
        b=JpGxm/qasJOxvwdYLH7Q5G/i7hCYQHks45aQ9iwQrkoqFSFITj7ozNxRY2ivYM2kg7
         3cGTzZFzS5vlAk9oSA1THXfT6DQDH+rgZ85Wu2pl2Tzj0GmjbluUiLSJ8L7WwARkQEJr
         4YVD0ykvxHYFY72lvyc7MCaYXHauvRT+UCN4H6ILSzbPdqZ1Y+lA/EkIC0GDO0s/QoPP
         7K5T2T34P2I2JV/VawVPxUuzP9sOjpAXz1SsIh8UgwW9KSbWKaFFF91X9NjgG0duNKOx
         JDQfg3maXB44G1+kpJt6VR6FlokWXP8xk0WJnMWJryXEHsxsZxsorD6Q+27R4td01VLw
         v1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709939201; x=1710544001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7t60vDpglsBHCmAmlybKd04G36JOxRBGBizt48yxWg=;
        b=fQflNAo/kYVpWDZ1qmQQQuz4GNhRcAhY8sO4GBiu1VyZomx7MyjmIN7N/GV5nlEDut
         gPmB6riKSMmXYRiT9PUUT7sUUQC3qdVDXRSTYhB9GZsKXK5GS52YTNhze7EN0iTJYbF3
         LCZhBF/xp9P1cdNsFrUDBbArsIxOkBvr0clNfra/69pYhsYd5Rv3z7VO1vAxZFLJMOFQ
         9ue1a0DN+H1msFPS4KpNOA+z28x9cxAweSXi350W+mYYAySfgQEB7PbLzR0or8D6iMJ9
         ZiHsmwyhcTPuKdySrDDxHyzW4UmWiqrS0sqSnn/3GOU5TG5UG08HOgDYPeJ/bKY0SGGs
         F0RA==
X-Forwarded-Encrypted: i=1; AJvYcCWOPRc3x4KMQRiySnANzC8PRk6meO5PBiEKaqChgry9w27EhSRZASVMju8zPtAD4JJd6x+u6VvgtCiDo3IZLORUVbzbm/gelRKjgSDi
X-Gm-Message-State: AOJu0YwbKMDUr5cU6JZwPKp6uKyIhW9ceNjEbtNROsOqYJ6c1M+/xtYE
	31o9TC1h+R4CyULUUo/sF0jDVqcsYiuBllqwoZw0zMTdCPlIGpanNsr6YphJSHw=
X-Google-Smtp-Source: AGHT+IGIOrQJr4Nra+hIRyuM+HynD9ddE0mdyHLocDur6Am2eUWZInzyX3blGNeYkc3QCa+PsmCoNQ==
X-Received: by 2002:adf:f4cb:0:b0:33e:75d9:75cf with SMTP id h11-20020adff4cb000000b0033e75d975cfmr432664wrp.52.1709939198829;
        Fri, 08 Mar 2024 15:06:38 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-247.dynamic.mnet-online.de. [82.135.80.247])
        by smtp.gmail.com with ESMTPSA id m21-20020a056000175500b0033e052be14fsm473204wrf.98.2024.03.08.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 15:06:38 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: David.Laight@ACULAB.COM,
	bp@alien8.de,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	x86@kernel.org
Subject: [PATCH v3] x86/apic: Improve data types to fix Coccinelle warnings
Date: Sat,  9 Mar 2024 00:02:29 +0100
Message-ID: <20240308230228.3161-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <6548057B-015C-4A67-8231-0E63224BF74F@toblux.com>
References: <6548057B-015C-4A67-8231-0E63224BF74F@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given that acpi_pm_read_early() returns a u32 (masked to 24 bits), several
variables that store its return value are improved by adjusting their data
types from unsigned long to u32. Specifically, change deltapm's type from
long to u32 because its value fits into 32 bits and it cannot be negative.

These data type improvements resolve the following two Coccinelle/
coccicheck warnings reported by do_div.cocci:

arch/x86/kernel/apic/apic.c:734:1-7: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

arch/x86/kernel/apic/apic.c:742:2-8: WARNING: do_div() does a 64-by-32
division, please consider using div64_long instead.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Revert changing do_div() to div64_ul() after feedback from David Laight
- Use u32 instead of unsigned long to fix Coccinelle warnings
- Update patch title and description

Changes in v3:
- Adjust patch summary and description after feedback from Dave Hansen
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


