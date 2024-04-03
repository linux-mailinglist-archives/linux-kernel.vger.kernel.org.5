Return-Path: <linux-kernel+bounces-129242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A0896789
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 043C7B244CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BD26FE04;
	Wed,  3 Apr 2024 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oxhkt9fd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925876E613
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131518; cv=none; b=Y99b1DY4tnpqE46u28g3TJVj8MkydVoubJooRG4rL0TXVtRC5QWie1UeJ0FrvLIpWS0dihB6gtLtAW+FHrb40bqmGneSUY4hSD8Xqk0X9zZJvJYIZdKKVC7lOAcSb9a9IeOidOjJRvTqXiIaLmq5LVMsTUU6zOrdpAq0eWwkKgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131518; c=relaxed/simple;
	bh=lSkNV6iOiiqqPiO/F6auQ8ekda3aYuop52golLpc0/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzFW30pDdgyFFpo3TAFy23Rkg9W0DehzFm3qSzzsMpliqTCZNomcVzP7pz70OOxdS+E79qtmUclC32hUHIRvs0cL+jgI2PzDtTBvPkPewVLk47sKs8lvCcOqM7YjRFGrqz24x5S826sFBdZf7CEVKMdHwPKSxXTpQw5LTt2x5EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oxhkt9fd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0f3052145so57204695ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712131516; x=1712736316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc4Qbmx0AoxDu4ditj7xvL7MfGG2VDboL8zvDiTC/bw=;
        b=oxhkt9fdvmejQVTV8QHTUzo7DRIpKcnjzFU+NnGgKNIBu8ieSzb6S2HReVX67i+wWr
         YJUxb7Kkcvtv8Iy4HW0WTlt12PpIz5iRapjoRPv5t1KlSdu1sq1HZlHq6qYJOBy/RCvQ
         M8bwsCMM8UQRRYkfnjvdgjdiEaRnyt4A3YzSPmRNyyPT3syoIVRfbmJjzpxMDE3Yumdc
         i7T+Lrc//ohXWlC+hPX3q8Ik8FP7yNcE4qSxe5Dun/c7VLW4UaqHCjeRl3fFN/XIMttu
         mephSuuXM/lQC488lnVyAsklT2yMsl8AnAfQ2rB95SUm58PClgrG2Am8LqKmGGvPeTqZ
         dG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131516; x=1712736316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc4Qbmx0AoxDu4ditj7xvL7MfGG2VDboL8zvDiTC/bw=;
        b=GxaKHfvaXPR8rWN3AaDsQiNUNlLkwRMYtWqqLE9/2uMob8F46dGDZKpB9trOFqd/YW
         OfypCS1Jg/kPdIvd49rArT50pQYskaAPuiw4Y7Fn5fDU66T8AooLo+wbcZwoxVZ9zk+s
         BKsYfT/LGfn0oGFOql1fO8VIm+oqn+Zk97WD04RnFQ52xvBjwTAmOBN8Y93nRIeZZBz/
         TmggMr0e3m6/5mansl81+jkM0isjq7ttBSsuvunV68p6SA9ehecA33st3J8ScBKEBffb
         vRDJ0a/lGrBE30vl8nVMU29yBMT7A4xnz7kIFJLcUxDM2t6qyxqrkGWO7gQeNEf4GmPq
         V5Vg==
X-Gm-Message-State: AOJu0YzL2d9+MgYF7TD9KAdBE64QhWSd0i7E4TLournC0qDdl0rBMuu3
	ccClta8rgyQZo/DKH/Bc4NsMHuF99V0rIistd0pyQWoHnRDxGdpbiTXgmp0Yy+s2N4HTdNtx6Rg
	7
X-Google-Smtp-Source: AGHT+IEN9FTCaj0hRotpYu2L3MLNBsnLZyWzCk4MgIL/9u1tPeTTuGgG3qQXqUKuRiVdVxo5cBEIJA==
X-Received: by 2002:a17:902:b089:b0:1dd:878d:9dca with SMTP id p9-20020a170902b08900b001dd878d9dcamr1981385plr.48.1712131516075;
        Wed, 03 Apr 2024 01:05:16 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001e0b5d49fc7sm12557229plg.161.2024.04.03.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:05:15 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <anup@brainfault.org>,
	Ajay Kaher <akaher@vmware.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexey Makhalov <amakhalov@vmware.com>,
	Andrew Jones <ajones@ventanamicro.com>,
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
Subject: [PATCH v5 02/22] RISC-V: Add FIRMWARE_READ_HI definition
Date: Wed,  3 Apr 2024 01:04:31 -0700
Message-Id: <20240403080452.1007601-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403080452.1007601-1-atishp@rivosinc.com>
References: <20240403080452.1007601-1-atishp@rivosinc.com>
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


