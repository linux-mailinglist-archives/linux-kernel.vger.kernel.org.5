Return-Path: <linux-kernel+bounces-139565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A00798A0481
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17A2B217F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A50C224D8;
	Thu, 11 Apr 2024 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="l6q4d0pp"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C7E1DFF9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794116; cv=none; b=fyKGqpH31678FgrpLaGQLV7WNakoW0xpzm0JTCSuWUXi/Aax1XiTPB0zjVSgjxT5nf18+rkZIJiWDRkG+R04nRlnknTmStkB2pAJEmIh7cB7Q8/Eu9ZvzA54Gu0tDwAAqeYkd2EnYWfJAch8I+uSMeBi7oFOzU9npPANwOWMgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794116; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MNtHG9Ll/kYsfLFD3ZkV3CTcdqwvtoWGBbGanlptmQNVZdDcbhgVxKFtgr4phLDRYrUbJfzhlcmUvk17UO/rZfOizA1Sx93bBoVR9WtsM2+FVPjFrcghtJ+upnBnTIQ7Oa53TMadXFw78NpRtGpF7QTcLDTat5qnlZYqqkPUO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=l6q4d0pp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e24c889618so59414535ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712794114; x=1713398914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=l6q4d0ppNxosr61PxpO+nUwCvp8BuauMe8AT/gF+ws53u+i1hRcpLbAxgLL/RR9FNM
         I2ehD7DsI9uFFtzN6CmfRs0UQs23vpNYKPCV57cGjhERXd1jCXhEJT2XFyXnERDqU9qr
         hDX27UVa/IAVTggAs3avcEOHN+5kbilri8uxj9GTd4MxtBzOYq5BfIxhtGBbRNNxF0aC
         wxUA2/IWKnkYOblTYQWHV9V0yVhMugliuiLDTPpoiAiGaf7gwPk1BOQlymixilBoEsco
         ZIa3OcH8XGoBnSDo99fhtXchf3E5jKN4U/1Tgx5MpbrQaf8hHA/losih3lakGF2Xx5UE
         TcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794114; x=1713398914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=MioMByPyyxiuREJyOX+kkqVoy5fVEqtbwWJWB3HC0TrpivRHZDzoQdQjon92SYImIe
         5ArLPUggEuJYGWAMCQsUNVvyJBc0Njl96VD2WBov+Iyv06FlZ8Q1CXDNnBgUdc01sk1H
         t0ZrqUhNFMgs0fBqt2HiC+wF7oNP+swLwEdDdO1t3pQAt3TsDuZl31HJoCPxXXSHjeZC
         95b6Bde0du/lLXxMfUvQlJcLW7skLLqt5KYEbl21ju6ZN1aaj2AM6i+IRab/W2xZSI+4
         7a7d1HRxiGuim/bmkw2vMhPZMQxkb5dO9h0w5LgiMiQBR61dO6nyKT5FOjCGBvik4Da5
         slOA==
X-Gm-Message-State: AOJu0Yxap/oCShNxQEZ2kpVm6TBMAqRUSGA6eBghq07mDkzpjnYqgdgy
	/hkdHKUoOCHpzFd2LMteS15FL/NuEW0cQoYL76qROn7L9hiZr4j7zZNa+mETrPlbdUI2ed0ETg0
	5
X-Google-Smtp-Source: AGHT+IGlZjUnG/cOH6oxCvOCuQrtoKifdSzPlvvNyoKqm+NzGiaKMBomwqkIVAChpjCW/s39Q+Uflg==
X-Received: by 2002:a17:902:8490:b0:1e0:119e:f935 with SMTP id c16-20020a170902849000b001e0119ef935mr3564608plo.15.1712794114043;
        Wed, 10 Apr 2024 17:08:34 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001e3d8a70780sm130351pln.171.2024.04.10.17.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 17:08:33 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v6 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Wed, 10 Apr 2024 17:07:38 -0700
Message-Id: <20240411000752.955910-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411000752.955910-1-atishp@rivosinc.com>
References: <20240411000752.955910-1-atishp@rivosinc.com>
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
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


