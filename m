Return-Path: <linux-kernel+bounces-130148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C88974AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579EF1F23C00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A214A4FD;
	Wed,  3 Apr 2024 15:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EddwekMh"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF714A60B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159869; cv=none; b=HQ/N2CoyXyFITy0LKSfK6xm/+CM139zKGPWk/3oJr2DAyRvtQbrRcGeiCYm6vcO892KO2tzbn/3c3+Q0HzgW7L57KuyTN6rolUiLXY3CqG0j5h6IJYHHwtA+V8VuUt9I3qs0NvTohziF1lFGWwxPpz2a3S0Ut8Ni2KcNq3nl89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159869; c=relaxed/simple;
	bh=dbBUSzgDjt5q/Qw6Ntc0Km4NWLoKgjePpI1VLpqH2lY=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xtg73BH3rwLX/aaDD2Qx8LW6ywW5wNHZbPXwVni1ZJTdny1JC7vys2sUMpiqo5rSDfAwBaV1ju5iRnt+rcTDqqC+hV7I+l0U/mjJShDNjD9Uc/n20erBPlhYI6Hk5vDBOOp0sG0H3omlM2hYMKNP/PIAy4Ti7ynNWF/qAZqVjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EddwekMh; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so38280a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712159867; x=1712764667; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdweFtJcPnF4iKraZ/QiNKzHUXSD+PPerrMSFfCr9Ok=;
        b=EddwekMhwobfMlB8WDmTnaiNnbFoB8PN6ckvbicajbNSn52MbezZ+1S1k6eAr1Jgp/
         kCRN4BitdCbWqNVC1Y4u+bMmEeH/tLBZOrr2J3a5KDZBZ0VszXX/vY+RJOtw4xjvX+Ik
         5C7MM6ekGDj+I74yifzYMqnXxLuZgn4G9e9DvE3KR5uNwAQHmLptjJIgRMeMaE1YEgQB
         +NHJVFY1MxbwGVfAVx2U/zde+ceJxPy/d+umM5xuhdMSUjmVomoje6TRPfUoBSt13FTt
         vyXEQRQzxsDqob8K6laTgIbZQ3feFI5jPKbJVMPuMksvoFpRsk4RMc4ji7BrJahl0OWV
         xS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712159867; x=1712764667;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdweFtJcPnF4iKraZ/QiNKzHUXSD+PPerrMSFfCr9Ok=;
        b=R+Tc3yuznH9DGEoTRtpi/QR1V4CsmjzInOSgprk9Vs64rLzlmegHKETmXmmre75Nmy
         fxPamNY0kwiCaYb9rd/URzS9Fn+1u/yVWBdk/qnQrIJLvGxsAqsCyVjpnyBQS+2+t4xW
         /CHtH/UThLOWIzpFFxWtC9hbvk+RVdzFQ3wY9Wz0FRGvgME2t0L6+D09ofalpVgqhQkQ
         oH7bcbj5fYQZ5E5T0x/waYMOeu+a+pIC6sKaLlY2P+xKQ6ieyLWprWe5Yz4m/QpM8y6Q
         TQSKMNcmHaPM3fQi/aGrgUyMGLQNurisf21wM/I6n8la3mm8j5N7nU7EkvZJpiStcUmW
         rJRg==
X-Gm-Message-State: AOJu0YxacW+QHPQIdMjp9qxeboPrUFYiqGBOFH6qRtrXGBvskzOEcfRX
	nmefeJQ2HBiIfIVgf3MGO2Dxsidf+r2lj9hkNPdkrepnbpHB4VHM/2ta4siRaMBUTftX/b9NvZw
	X
X-Google-Smtp-Source: AGHT+IGEc5SiTKlBMDw+hag7ah4JiRNUxWrcEjIvg5ALhnlJaggwk6Jks2Mq0GlmxJFoHaYgczxTKw==
X-Received: by 2002:a17:90a:a782:b0:2a2:b5db:79cf with SMTP id f2-20020a17090aa78200b002a2b5db79cfmr943565pjq.21.1712159866705;
        Wed, 03 Apr 2024 08:57:46 -0700 (PDT)
Received: from PF361X9BRQR ([2601:602:a080:1560:2d8a:1669:70cd:2501])
        by smtp.gmail.com with ESMTPSA id pb7-20020a17090b3c0700b002a287d6457bsm2061362pjb.41.2024.04.03.08.57.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2024 08:57:46 -0700 (PDT)
From: <jonathan.oleson@bytedance.com>
To: <linux-kernel@vger.kernel.org>
References: <20240403080452.1007601-1-atishp@rivosinc.com> <20240403080452.1007601-5-atishp@rivosinc.com>
In-Reply-To: <20240403080452.1007601-5-atishp@rivosinc.com>
Subject: unsubscribe
Date: Wed, 3 Apr 2024 08:57:45 -0700
Message-ID: <00a601da85df$ab1ac330$01504990$@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdqF36p1cS3yrfaBR9e0iMPYJxi6MA==
Content-Language: en-us

unsubscribe

Jonathan Oleson

Talent Acquisition | Seattle
linkedin.com/in/jonathanoleson/
jonathan.oleson@bytedance.com



-----Original Message-----
From: Atish Patra <atishp@rivosinc.com> 
Sent: Wednesday, April 3, 2024 1:05 AM
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>; Ajay Kaher <akaher@vmware.com>;
Alexandre Ghiti <alexghiti@rivosinc.com>; Alexey Makhalov
<amakhalov@vmware.com>; Andrew Jones <ajones@ventanamicro.com>; Anup Patel
<anup@brainfault.org>; Conor Dooley <conor.dooley@microchip.com>; Juergen
Gross <jgross@suse.com>; kvm-riscv@lists.infradead.org; kvm@vger.kernel.org;
linux-kselftest@vger.kernel.org; linux-riscv@lists.infradead.org; Mark
Rutland <mark.rutland@arm.com>; Palmer Dabbelt <palmer@dabbelt.com>; Paolo
Bonzini <pbonzini@redhat.com>; Paul Walmsley <paul.walmsley@sifive.com>;
Shuah Khan <shuah@kernel.org>; virtualization@lists.linux.dev; VMware
PV-Drivers Reviewers <pv-drivers@vmware.com>; Will Deacon <will@kernel.org>;
x86@kernel.org
Subject: [External] [PATCH v5 04/22] drivers/perf: riscv: Use BIT macro for
shifting operations

It is a good practice to use BIT() instead of (1UL << x).
Replace the current usages with BIT().

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 20 ++++++++++----------
drivers/perf/riscv_pmu_sbi.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index ef8311dafb91..4afa2cd01bae 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -233,20 +233,20 @@ enum sbi_pmu_ctr_type {  #define
SBI_PMU_EVENT_IDX_INVALID 0xFFFFFFFF
 
 /* Flags defined for config matching function */
-#define SBI_PMU_CFG_FLAG_SKIP_MATCH	(1 << 0)
-#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	(1 << 1)
-#define SBI_PMU_CFG_FLAG_AUTO_START	(1 << 2)
-#define SBI_PMU_CFG_FLAG_SET_VUINH	(1 << 3)
-#define SBI_PMU_CFG_FLAG_SET_VSINH	(1 << 4)
-#define SBI_PMU_CFG_FLAG_SET_UINH	(1 << 5)
-#define SBI_PMU_CFG_FLAG_SET_SINH	(1 << 6)
-#define SBI_PMU_CFG_FLAG_SET_MINH	(1 << 7)
+#define SBI_PMU_CFG_FLAG_SKIP_MATCH	BIT(0)
+#define SBI_PMU_CFG_FLAG_CLEAR_VALUE	BIT(1)
+#define SBI_PMU_CFG_FLAG_AUTO_START	BIT(2)
+#define SBI_PMU_CFG_FLAG_SET_VUINH	BIT(3)
+#define SBI_PMU_CFG_FLAG_SET_VSINH	BIT(4)
+#define SBI_PMU_CFG_FLAG_SET_UINH	BIT(5)
+#define SBI_PMU_CFG_FLAG_SET_SINH	BIT(6)
+#define SBI_PMU_CFG_FLAG_SET_MINH	BIT(7)
 
 /* Flags defined for counter start function */ -#define
SBI_PMU_START_FLAG_SET_INIT_VALUE (1 << 0)
+#define SBI_PMU_START_FLAG_SET_INIT_VALUE BIT(0)
 
 /* Flags defined for counter stop function */ -#define
SBI_PMU_STOP_FLAG_RESET (1 << 0)
+#define SBI_PMU_STOP_FLAG_RESET BIT(0)
 
 enum sbi_ext_dbcn_fid {
 	SBI_EXT_DBCN_CONSOLE_WRITE = 0,
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index babf1b9a4dbe..a83ae82301e3 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -386,7 +386,7 @@ static int pmu_sbi_ctr_get_idx(struct perf_event *event)
 			cmask = 1;
 		} else if (event->attr.config == PERF_COUNT_HW_INSTRUCTIONS)
{
 			cflags |= SBI_PMU_CFG_FLAG_SKIP_MATCH;
-			cmask = 1UL << (CSR_INSTRET - CSR_CYCLE);
+			cmask = BIT(CSR_INSTRET - CSR_CYCLE);
 		}
 	}
 
--
2.34.1




