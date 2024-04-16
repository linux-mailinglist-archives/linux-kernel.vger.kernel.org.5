Return-Path: <linux-kernel+bounces-147406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88E38A7384
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DD92847C3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E513AA51;
	Tue, 16 Apr 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sih91rTS"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3A13A410
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293094; cv=none; b=sYfzbhKG13QtYCHgMQsJfxT44mn9qUy4r7nXRjHy2cl3QWCL3Y579EdQUVJoXy7Yd8qFU5197ZjMBNJz3dnw7UQX2rmoP4WTiQ8kMfT5WjbH60d0r79ev5j9tu2Ju6eDEEuJy0Md4ORcfNFzebrGs/Gc9f73pebwe25Xfb7C3YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293094; c=relaxed/simple;
	bh=H8usdALoznAt2isX7oNnrfLpFcaNKxvOOWa8DDbamCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RybjcYg+uyRQJZyWUj9VXBqovh6qSpWhQp9T2RvZGHAnjg1Ddz6fDyirBLW5pukkT0aeMsaUGVl2AvhNVudvFQCoLwNl5RtVfmWtDXWGl/I3hfBJVhhu1mZTwL8GeqSXr9pFH/i/cnWk30AvG4DLrDtKc88+WoIu4yYiYEruecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sih91rTS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a475bdd4a6so2768470a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293091; x=1713897891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=sih91rTShDqoyV9/xzv6ODbOQ9WzXUI0NA2N1u5hPo4SN8KN0LHQo1ZKOgYVCGwTup
         ooHHf3cdnJAc8xN7jJgrHvCGIXVIZ64R18tYAbskUBMrZBHusxX4d5LgQmPbWDAJAzF0
         Fae4+KQcuB9wmkjoliYD5KUG9qO3YBVeZrBEfAlO7lGQ43bbJCvCyNer94VMG1OpDuiT
         N+TEOuIfBx/WJqG/ajyuJimeA8ZpQGEmEpYu3eyAItpFJWMbcP+6Rt0oCw9D+w9+0+bK
         HThFiybcQVw+QrT04+tgmTVeQyP4IzdlRbwj62zlatrQP0ZVf/tXoXPzmHM8xZBHL8So
         KxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293091; x=1713897891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rU9bTQzimBlb4bBeVGV64JD8vBjMh3ZSXWmumJprSMc=;
        b=LnFaOtmC9rjLcEc9lv2U5hJ9fCP620weLhYINxDP+B/F+jVVjARVK6clAsEP3VeRGF
         4tD+mN/fqdyZDHsM6yAkdd29GQ2kPGIYiwUUgqvHNCa+lfg/+KWEHUPqndcOGQXd4L6e
         3Q//pnpb5FG38ND3BMDt7kJ3PckFzonEm3/F8+jgDdlO3UDy3a9c9H3kxm6iKDCsXBbR
         frYGaGxm4vXykVo4kVnL5AWTKSM/+nv1Qawcfjg858QT38TYD9RC+JJgG77/WVKi4OOK
         eSFb2AQNRbqbSO/kPs5psZGlJVddcKsU91cYOBwUW9SyLwxgE6xn/d2pczhCP2jxLFrK
         TUyg==
X-Gm-Message-State: AOJu0YybKmYgZZy4jXKFsZMubA2CfGii5lqezO7KnpQzcqiWQnnSJxoO
	He0lMt03x3EW+4aDtyYBU5Vs2Viz1rzFPdR3fLNpvKEspsFLrSKjBhmbVcruw7meo30NhesEXRW
	g
X-Google-Smtp-Source: AGHT+IFO7gBokex9KDHR7FMDDghsIz2thvCcgFt0g1hVdtn3kLkpEMXY9Ea3s80HyJZdLNzoP7x/LQ==
X-Received: by 2002:a17:90b:46c8:b0:2a2:50ef:ece2 with SMTP id jx8-20020a17090b46c800b002a250efece2mr12099952pjb.17.1713293091321;
        Tue, 16 Apr 2024 11:44:51 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:50 -0700 (PDT)
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
Subject: [PATCH v7 07/24] RISC-V: Use the minor version mask while computing sbi version
Date: Tue, 16 Apr 2024 11:44:04 -0700
Message-Id: <20240416184421.3693802-8-atishp@rivosinc.com>
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

As per the SBI specification, minor version is encoded in the
lower 24 bits only. Make sure that the SBI version is computed
with the appropriate mask.

Currently, there is no minor version in use. Thus, it doesn't
change anything functionality but it is good to be compliant with
the specification.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index f31650b10899..112a0a0d9f46 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -367,8 +367,8 @@ static inline unsigned long sbi_minor_version(void)
 static inline unsigned long sbi_mk_version(unsigned long major,
 					    unsigned long minor)
 {
-	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
-		SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
+	return ((major & SBI_SPEC_VERSION_MAJOR_MASK) << SBI_SPEC_VERSION_MAJOR_SHIFT)
+		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
 int sbi_err_map_linux_errno(int err);
-- 
2.34.1


