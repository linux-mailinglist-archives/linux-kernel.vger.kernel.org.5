Return-Path: <linux-kernel+bounces-147401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D7A8A736E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578BA1C21839
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B73138496;
	Tue, 16 Apr 2024 18:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="utrstbRr"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83D9137920
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293087; cv=none; b=TmlXwUKG53TDDQkHHa8Ks4BpKv8fn3PdOZhj+MBgFGKysV3G81iK5vcUvNLXp4pNiMkMYGjdK7eDkUmC4Sg2vDeuSg73u0kD8h0wza4LmSfNQwkfj/i3m/wfrT11FFytDdinYpcXJxF0xcJqoFOjJZp+ZOQ4aIJuUeNaCuAydBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293087; c=relaxed/simple;
	bh=tjU5YEqQieqMxVoH/UAjG6llZvkwIlIrjBWxORyGdm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3r1tNFFNTmw6vJgvwVrqPdL152xdlx9MxL3EcxmKbVQb8I1NLZiOa4By3239FuBxg1neEdSKBAvs6jsamhHMV8yqXok8KYqp0LltoNKfzaxmmCsHvhcfqGLwSVXAyibJ9LniGmO1512iNUJhM3AB6YB2zW3eAanJi1TCPhei7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=utrstbRr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a87bd53dc3so2071931a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713293084; x=1713897884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=utrstbRrMjRRChhLFVweOitbaGiAHu9BN399M6mQ43R7/NSkrgveJU3xJXgO4vQaKn
         ndPp5i9j/h9Ku9haCS/419zxpUZFqIqcRiIcBjZg7WRWCXzltRd4lLhHoQUc0VE/fT5a
         T2jUqlApgJcLfwjD8/qAOsd4o56XGKpfTTDR+7aZJvnr9iKjgFqEhRbD2JNfmlQ7nYD7
         iZvwLiIgVHOI/hB2hZovs7Xyq/0Fp5rToGFuXGSHtpqsDSxYWwVv+YnWurZkcjwhL2dr
         oeXrQQM7F5BMh0FpFnvpzHRM2C0boNpcV+P3C/QZFdiFgEdylg15M40xE/t0YwfhXNw8
         o94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713293084; x=1713897884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nwzSC0mjOXawHhzlfTnID2LKW7HdSbdpZLlPlBet3o=;
        b=p7/1egwV81yVUDAvdNEKCOWXgpUcgsnkhWUNPKvreD6T/0PKQjBbchNjR0n/0jSNkT
         LfPrgKAf0FEuq0pCs8LD11kUkt3CEziQ8MUkkAVjtUmgDlKTcAJBmptnVJvV5wic/+nC
         yBci9DUSdrGvHtNrx5faFk2rcb05ZuGOylhHgnaywcJfH2/gy9SN0G5Hrbsfta2oB+Gq
         AwjdQkZJA6CKUCXVhH3+014QDq15ICeYq6sxP+AIw5JwJPFP/W0QoaN6svYrc2B4cYhH
         rpXhCWyZf8P5eST8iZ7j8EnX4NPt5zNLwfbtbcTMBScC7OPQM6kpZEipJ9bfyhzytfI8
         Scmg==
X-Gm-Message-State: AOJu0YwZZhX3kQgNLH7whvgbfOMzIxVlOL10/e30kRY6SdiAK2cfhH9D
	LRjL5hxgHYu/9bv/J+1avoFAT2JQ5JpIplsJ9LkJtey3NBGzwnw4NQS3UKzNXDslRx40B66NUMk
	e
X-Google-Smtp-Source: AGHT+IEoEjUu4cy1AorDUlJRRsn2LFZCsazPsjOtul090pjdnU5WLR3vSTyvWTwboMGTmVgvzKEuGA==
X-Received: by 2002:a17:90a:b00d:b0:2a7:8794:bd9d with SMTP id x13-20020a17090ab00d00b002a78794bd9dmr7689700pjq.39.1713293084173;
        Tue, 16 Apr 2024 11:44:44 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm8883645pjq.40.2024.04.16.11.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:44:43 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
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
Subject: [PATCH v7 02/24] RISC-V: Add FIRMWARE_READ_HI definition
Date: Tue, 16 Apr 2024 11:43:59 -0700
Message-Id: <20240416184421.3693802-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416184421.3693802-1-atishp@rivosinc.com>
References: <20240416184421.3693802-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SBI v2.0 added another function to SBI PMU extension to read
the upper bits of a counter with width larger than XLEN.

Add the definition for that function.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Clément Léger <cleger@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..ef8311dafb91 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -131,6 +131,7 @@ enum sbi_ext_pmu_fid {
 	SBI_EXT_PMU_COUNTER_START,
 	SBI_EXT_PMU_COUNTER_STOP,
 	SBI_EXT_PMU_COUNTER_FW_READ,
+	SBI_EXT_PMU_COUNTER_FW_READ_HI,
 };
 
 union sbi_pmu_ctr_info {
-- 
2.34.1


