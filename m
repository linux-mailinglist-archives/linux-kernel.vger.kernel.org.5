Return-Path: <linux-kernel+bounces-159083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3358B2918
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FD5EB249DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B6152537;
	Thu, 25 Apr 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jTHaAyMn"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E6814B06B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714073999; cv=none; b=Na0YMntQDjC5p2F4CKmauSVsXt+PDy6FbO9AyOTMFmI/fjWSyHUMpEKxz27AwE1HzgkiCkVx6mws0O8Py3Q2/0EYqCNUE5Zx0ZaqGDqOVp4aUv/WiCglaJ6d6YIJ0M3zrGyldF3UPLEZAr2iEMUnn5CJD5VMKSbre24RRdK1uWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714073999; c=relaxed/simple;
	bh=syWSVYZk+UhguXN13SKZzHMRwdHzGaDls4FDqD0fJbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LwaV8tC3zw7ykzUTpJqI8g04Ngy1+XKgufRurzeWKhdXVTPwy2Gz/j71PMO3P7Jmi0cE5YzndNj6Q3w11SZX6QDHdDm8hZfxFnVJwmHaC85YoHwWxPLqKNJBINtgv7pg5bRBB08YBxwJo1JBy2F3zt+kiIBBpxXyoSBSKZ3GxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jTHaAyMn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed112c64beso1401378b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714073997; x=1714678797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwQycTSydr72l3rI7Ia2qnujI4hDZcXzi79vpal+Gok=;
        b=jTHaAyMn8khsO93P7lYb4cvVv9zo0XPxBoYAu0nyVKp+yEWaV3MMkD3X5WV4MzR7No
         umFytCNt37dzXluEub5yuBD6PJxOVCQRccwjaHDfHbgNUx5DEm43XEFLWpcPo3Ifn68x
         LvclCc4CatQ+Awi9gq6qYm/hS0qMkvUPUCf98fSUKe0J1t6ss+7VvFCd7i36QpYgP3oP
         8rGyxBL6AfWV6kv+1S3k6pc8O3Yut4uO4SbM99AeU9Knfdz9hNCA1Ex17HQet+ThIpmD
         Oy8AHqQW4SmvvkT0XLsOKEqqm8+8RqzuJgmb+YD8dKH1UqTV+lLzQvYHynLdAgVdeR5M
         bSVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714073997; x=1714678797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwQycTSydr72l3rI7Ia2qnujI4hDZcXzi79vpal+Gok=;
        b=kGrTX+TEfo3PFfkrYPWzLF45+r8y5i4o/km859gGwYnOWo1XMjnL1F7359vrIBKm4K
         E58b1ULfVM69NP9KRG8ajAvcWgGTLAo2FMQweZQIwRrAaIMOG4HJndU1uqGw0Lg3LYYw
         WcUO9YzrhZ970gcPosy/2bS1l+EMG5i5wofp3DvkFNx6uMZSm23laHOg+35PZdP8XPxd
         uUtwlSlDqD1CMeclhloKAyY5DaKqLxkp+zlLwvyVGrVL3IR7X9XcWwRcJtOvESiIpIqK
         dd9WvuVAy1AwvTMKlPjMN0qHIcl8G/n9YKyk+1835wnBFWU3q6xnKY6K5HyXT9F5LK+e
         keaQ==
X-Gm-Message-State: AOJu0YwD7bJnUttI2K+cI2VJfYTfZmkUnpSgUE//QV9IlzX+wnMDT+5m
	TaOW5yJ4detGPoFRzqJ8JBikxRuTJuXH6+pKKODw3/ll8uPvqEtEDc/hqrWMnjsgkJSIdf/OrI/
	t
X-Google-Smtp-Source: AGHT+IEthZSW1CX7a3PvofFEwe48ZsCzJG8DzRSx1GcFLQyxF4hEvHFisHhdU+teFKmXklSnLYrqaQ==
X-Received: by 2002:a05:6a00:1704:b0:6eb:3d37:ce7a with SMTP id h4-20020a056a00170400b006eb3d37ce7amr979454pfc.21.1714073996665;
        Thu, 25 Apr 2024 12:39:56 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fk12-20020a056a003a8c00b006e6a684a6ddsm13525487pfb.220.2024.04.25.12.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 12:39:56 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	kvm-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Will Deacon <will@kernel.org>
Subject: [kvm-riscv/for-next 1/2] drivers/perf: riscv: Remove the warning from stop function
Date: Thu, 25 Apr 2024 16:29:31 -0700
Message-Id: <20240425232933.4111680-2-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425232933.4111680-1-atishp@rivosinc.com>
References: <20240425232933.4111680-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The warning message was initially added just to indicate that counter
stop function is being called while the event is already stopped.

However, we update the state to stopped case now in an overflow handler
after stopping the counter. If there is another child overflow handler
is registered (e.g kvm) it may call stop again which will trigger the
warning.

Fixes : commit 22f5dac41004d ("drivers/perf: riscv: Implement SBI PMU snapshot function")

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/riscv_pmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 36d348753d05..78c490e0505a 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -191,8 +191,6 @@ void riscv_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
 
-	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
-
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		if (rvpmu->ctr_stop) {
 			rvpmu->ctr_stop(event, 0);
-- 
2.34.1


