Return-Path: <linux-kernel+bounces-129248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE928967A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8BA1C2561A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6949811F7;
	Wed,  3 Apr 2024 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="TSeifkcC"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3576D1AF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131532; cv=none; b=ZEfuYtB/o8WQp+06YjenRgF7uGLdJ7IsM8HuCKAOFNGdt86doyhc7pOKylqczqOJ3WbMM65N2lwpxv8+isJkINooV6wMB/fI3VYqJ2owjuZUEOysjX4ksV+pqVbSydah35aStKbn2AdB4fzHkiSmMB5i9/4ZGL4sAuhWtAypDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131532; c=relaxed/simple;
	bh=qmTer1L5IWEJQe0rkUy5cvb4CMl5u/8y+hPoEZoMutA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zj81jhNmz9VaU9NulnnwqcDLFK6ipS73qzqV64K/hikpxbi/niwjWEE2ZvEtvxdoUHwDNamxpmzqR99GIddiHZx1VAqbg30vb78vqHAq64W8qsPB0//8Ct0qY+Gm6vhhgQfyCiHsaJTyhnoA5O8VCz4Dnx5xD4Vk3o4e9k8g32g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=TSeifkcC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0411c0a52so51648385ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131529; x=1712736329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HMUEh/ouJpwrjadx4E8ELJ1oGZIEAqlVNHNOiveHPA=;
        b=TSeifkcCVel9tg4BDxNqVioc8wG9MlkoJ3zjDFmQ42yLVyPQQ8/t+ga6mhJbasv/cw
         kdJkdlohOprTHDTHFncMalAz2OKXkpESH3KiBcjPJ3O0ROPYzDMLNerLFiJXwcaURbUe
         3mI2ilSR2OFLFlLOLX1B4cW/7jrw41WmIldFZwK2rPx7Q4ZzK6Bw97v8K/ZJs5yHr3TS
         6SlM4sakMFvnbC9Gbl3qb8BFO+Y+NQVomRmg8WnYURs55sBXVKzOufTz7YG/ZqSp8MLp
         ZVpChGoH1VXBdxE7bFMf9Dp0wm1JhxgFxm0n5HeRKbSBSShB8oHiu3umukjLxijTUd35
         srDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131529; x=1712736329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HMUEh/ouJpwrjadx4E8ELJ1oGZIEAqlVNHNOiveHPA=;
        b=FJs1+8/ahjNP+76QCj6oI84FSkkQYcjXW2hF6ZADnno6I7wc0NktplpZEaz/LHXjnS
         KA4DuOBpiMnbp28Ogsl5ki5MmEUcffoFaV59z2OiTL+i2k3vG+p5ToItWR2AafUKHsX6
         06x2+vgknvcEEmxganeGSjaaMYIvOVLeeJ4kPnHUhv+V4x03qY+hpFAcwuXVoZtBNQGO
         jxfjjt5Vh08tzWUmHn8XXK7jVfyzx09sDQlhpyG3tMwFAG8njCse1iN7iLNnvvQFPaYM
         GUD7d/x6DZOZ+dIYxvdtAVaI7JLKTLSlOGKtKgpSMoDp5TtL+854HzC7Pln1WyNjUl+M
         IPAw==
X-Gm-Message-State: AOJu0Yzf+ddMuae206tRLTS3uvczUJri5+5nhYD6oP5q+HSsx0pkRw7i
	GP0ub43xMNybvKIFj0jCkBDZih5jLFOcKMzzpPmvKd0UfT8vi2pKjs/Wi4rdk8IbyzTho/A9Fyo
	3
X-Google-Smtp-Source: AGHT+IF30gBaFjuZamH6gB+fLa8VQAOCDXL32p+FdETcNWyCBYGk0g9s0A7zOmyK2RvO8zqC4rEDCA==
X-Received: by 2002:a17:902:aa04:b0:1e2:23b8:98dd with SMTP id be4-20020a170902aa0400b001e223b898ddmr14090965plb.69.1712131529484;
        Wed, 03 Apr 2024 01:05:29 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:28 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Juergen Gross <jgross@suse.com>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	virtualization@lists.linux.dev,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v5 08/22] RISC-V: KVM: Fix the initial sample period value
Date: Wed,  3 Apr 2024 01:04:37 -0700
Message-Id: <20240403080452.1007601-9-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial sample period value when counter value is not assigned
should be set to maximum value supported by the counter width.
Otherwise, it may result in spurious interrupts.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kvm/vcpu_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_pmu.c b/arch/riscv/kvm/vcpu_pmu.c
index 86391a5061dd..cee1b9ca4ec4 100644
--- a/arch/riscv/kvm/vcpu_pmu.c
+++ b/arch/riscv/kvm/vcpu_pmu.c
@@ -39,7 +39,7 @@ static u64 kvm_pmu_get_sample_period(struct kvm_pmc *pmc)
 	u64 sample_period;
 
 	if (!pmc->counter_val)
-		sample_period = counter_val_mask + 1;
+		sample_period = counter_val_mask;
 	else
 		sample_period = (-pmc->counter_val) & counter_val_mask;
 
-- 
2.34.1


