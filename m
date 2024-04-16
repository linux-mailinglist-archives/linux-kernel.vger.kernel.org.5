Return-Path: <linux-kernel+bounces-147409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13218A7392
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B604280CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C5D13C3CF;
	Tue, 16 Apr 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pU92mXUn"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6B013BAC2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293098; cv=none; b=jE1i9/s6IRoq2Un40QySrCZg/zambe1Vk491PsMGq4fpNjTIpUGL2XhmmgOL/ae2sHHcnszhRXd1+XzYp9wh1I9UlL/vdRcjBmUkHzE3d9MP9kmRsVQQMBJEIB574KZhp6KSAE80mfJMEKXJaJ4orKFVbmYHpTanjcYQzH7JUqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293098; c=relaxed/simple;
	bh=i4/+SnhxIOkVH6jnqRPVGKLSvQvEdBjQqHeh5YP3SQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsyryCUSu/91HV+92esPydEquL9+GpH4FVWI8SAQybK+ji/DNXLFTjazDXyeLlmIr4xyavH8TOKkyrppYbwg6UbdX5i4TzOI4+5gQCqkxpjOL6+oThAdPDqdUyYF92Udust1lDED2GKv70mgacmVKBCxIoYMWF5HUkG0Jk/5RWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pU92mXUn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2859622a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293095; x=1713897895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=pU92mXUn3chFfAWKly7r0IXT8AqER8I1anwhMtEkZOFJpBhLtgIOAY067BpK23DBKJ
         /90TPJmwWM1GRnh+iGj6j6D2Xqubf98xQ7Gx31dD1d8bm7FQT17DL5dQIIBHxjJrtzAt
         4r0/J5wpFyp/AyQAauSYdWqCQl4WQTc2Uvi5NTGFRA9+OQVZGRl+F4+elcXpn1vhwz7h
         FKMgXB/Y7MPBrdD04fYJgOraN26QhQUTK9v6Ci+EdhhGRwIevK56aZdXAf4Jer6RB9PE
         wjCNV8IDf+3xh7yKy3OkfSgs2DzNkmiTkmysII0fDy6gcEZJ4s5/h6Y54Pm1uug46wtn
         uHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293095; x=1713897895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3Hu7DESDZEmcgrq2jc0sr2sorL47aa7h3H8SzaxXXM=;
        b=bmN4yQiGYEGtlLlqoNSLAlCXm+GjpZx5s7vklZY3jAC3I6wX++pkgQW4YoafOGsG6i
         1yyXIyqTCgfrb8SRfaHXUnEgFK4iWGLggmVAiKCJToEKCtk7cH+mXuvstWeoPlxgtFEv
         BH2a633h3BkHi6ypQOnkNEwZBp339FQWeUTQxEJvc4DX5SfWBzD5+Kb/nCq9AJNh5QMD
         lK/45c0az3LOJKQ5PfAiCVYh3i4+2JjRcb9JxzTaor17aQ2B5axx/JQ7bTelB95r4gVd
         ttzXZeP71CBq+CCDOAolZ0hkwCdiZdbV+DSVnEP05QpIovkih5+WfOoEHfJgjEOYjX4u
         yM/Q==
X-Gm-Message-State: AOJu0Yy67c+pv0VNkilG7h9/pYXk8dZrhFHODrrk/BhluXEpzTnnZw72
	cFPT132jgGWabBkOGiHhnIF+x0sedKKL/R/c0JjYOXefmistBYpuBy+jUdzUs57LF6geHNKLB6q
	6
X-Google-Smtp-Source: AGHT+IHMrJmnJNbaJLJrDUHsyvS17+PaYjcpk56OE5mezOqfopuoWKSQzyxBPEpMmbqXUeSJxlz5IA==
X-Received: by 2002:a17:90a:d511:b0:2a4:8706:ed44 with SMTP id t17-20020a17090ad51100b002a48706ed44mr10231042pju.19.1713293095691;
        Tue, 16 Apr 2024 11:44:55 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:55 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
	Will Deacon <will@kernel.org>,
	x86@kernel.org
Subject: [PATCH v7 10/24] RISC-V: KVM: Fix the initial sample period value
Date: Tue, 16 Apr 2024 11:44:07 -0700
Message-Id: <20240416184421.3693802-11-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
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


