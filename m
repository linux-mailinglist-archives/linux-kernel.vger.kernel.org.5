Return-Path: <linux-kernel+bounces-85973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F13A686BDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 02:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92178B21C82
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24494F1F5;
	Thu, 29 Feb 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sgC/D0hg"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C030482D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168515; cv=none; b=oOKVkVGvVo8HtQrbPMBZnBTAH8deNBf7Kt50Am2vvFdN+7lAfW/hnYjXF3t4zfgk0DQxxq4YxY+H05dQHz/gFNAs0jnNsDqLzviDLH6TiB2xNwdcIikyZhzViPDQqypcVMXwv6g2eZWiKwedxqYVE6M5/nuLt9SkauYCCZQDhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168515; c=relaxed/simple;
	bh=6N05/K2UvCYRRfCLnwVFTd9h5Sj1jFnGkcVaR9eaoMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Po6yK5tb/hwvF23ivAO60ftVlYDCsL7tZX1WCMWo1vW+FQ+2Oiz6hUBR7jVo97iZ3B3bVBb6mOb6YD3w6U1aMHVKP6ZWZ/FEHZDyLeCEd1kNh62mOa/YMVesWuOoRkwo4wPOydaDoVn9Wyl4tKQmWEujdSoi6QRiVNFNrTkKQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sgC/D0hg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc139ed11fso13096965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709168512; x=1709773312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QezjoA6tUvS/5tHzC/r6igb3Gn0pDkI0esE0F/349nk=;
        b=sgC/D0hgIrkS/Ns+m3Nn/PGM+duAU9Dz+cj+bibk7Uyia2cq45zyKv1DJim2hr1UM9
         +C1+7s63g4F39p2YiGF+oadSxbsVZ4uDU1ie6uWL+f43KcBGzAf6rL7kbq1zuCrgLgSZ
         cVuElr2/IujXk7zis7I3X9S5qF/fjkxYmQ+kQHc/u3UOmOlU1Bor43/vvrpFvKTm+XfT
         SrNyMcPUKp+KbucgTX6w2aFqBbaKGEAlvM9aLSVt8NQU6cs4AyZyzqUZ0yFAINoFf693
         yKziRqdFTX2fP8wtLJrYKVGlsNKjhMyLnN9mQSmRVGacyaLPq4f3ktu1/LUh4Wxjf2NZ
         VcMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709168512; x=1709773312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QezjoA6tUvS/5tHzC/r6igb3Gn0pDkI0esE0F/349nk=;
        b=Uh/sGpUSmpH5dOEsFtjjRQSpKcJo8Nvmr0cwQeg4ODPd+45/xL6NzATrGv5LH/BA2h
         jC6E9DCG6TtOCuKb6/YDR9K4Tg9UH0OsjCPxBKgPxI9L58gHipWUSfVWDU/F+BdXzeKa
         eRoM2dUNpSpsnMorZ+rzy7eaq9/R6POuarAaNFDXM9wC5Vk7uYRL8xRzPLBvRcP9DqPz
         7vsRTgknOtCXJMtCy845R8TsgqhWBZuQtun7pB28gdlzbOxepi5pPlwfIA0hGz4DT1mi
         PAKWFBu3+1XMJwZ2Va6EtNhIdHc4Gh3YG3ClH2UPoZdoTl1K62AZFiqT2IoIOPEcYCjN
         0Jhw==
X-Gm-Message-State: AOJu0YxULuwBFByXbtmGbWcA3wOC8P+UjA0l78nnVKHbIs651I/+M7nq
	xWwjJ0MAFFGD3t2Zdiajy773xTTsgIbCjjMyGrz/WwykERAGKBXNN2SXw7kB0IkoiLT82ifhTyH
	I
X-Google-Smtp-Source: AGHT+IH+EET8Cs2/q8Wdb2LR8HizaxTodw9btWcX4EbiH9oLwp/Rp0ha58Tl1o83d2hPXDRaMhd1dg==
X-Received: by 2002:a17:902:d486:b0:1dc:1ca9:daf4 with SMTP id c6-20020a170902d48600b001dc1ca9daf4mr595765plg.12.1709168512153;
        Wed, 28 Feb 2024 17:01:52 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902da8e00b001dc8d6a9d40sm78043plx.144.2024.02.28.17.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 17:01:51 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@atishpatra.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Icenowy Zheng <uwu@icenowy.me>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v4 06/15] RISC-V: KVM: No need to update the counter value during reset
Date: Wed, 28 Feb 2024 17:01:21 -0800
Message-Id: <20240229010130.1380926-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229010130.1380926-1-atishp@rivosinc.com>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtual counter value is updated during pmu_ctr_read. There is no need
to update it in reset case. Otherwise, it will be counted twice which is
incorrect.

Fixes: 0cb74b65d2e5 ("RISC-V: KVM: Implement perf support without sampling")
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..b1574c043f77 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -397,7 +397,6 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 {
 	struct kvm_pmu *kvpmu = vcpu_to_pmu(vcpu);
 	int i, pmc_index, sbiret = 0;
-	u64 enabled, running;
 	struct kvm_pmc *pmc;
 	int fevent_code;
 
@@ -432,12 +431,9 @@ int kvm_riscv_vcpu_pmu_ctr_stop(struct kvm_vcpu *vcpu, unsigned long ctr_base,
 				sbiret = SBI_ERR_ALREADY_STOPPED;
 			}
 
-			if (flags & SBI_PMU_STOP_FLAG_RESET) {
-				/* Relase the counter if this is a reset request */
-				pmc->counter_val += perf_event_read_value(pmc->perf_event,
-									  &enabled, &running);
+			if (flags & SBI_PMU_STOP_FLAG_RESET)
+				/* Release the counter if this is a reset request */
 				kvm_pmu_release_perf_event(pmc);
-			}
 		} else {
 			sbiret = SBI_ERR_INVALID_PARAM;
 		}
-- 
2.34.1


