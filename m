Return-Path: <linux-kernel+bounces-30573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C438320D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A7A1C22603
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8631732;
	Thu, 18 Jan 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Fn/pJhct"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39092EAF9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612889; cv=none; b=XMFrh6DEkq5Er/Al/ZRUYxhN4PEMLOMIg4EKAPNweV8vLQ0AMMvUK4HicCwahrHPJecS3dzkOPfoqrgE9zAJ1j1fau659AYeyqSUtmzAHeHT2+CJjJGoUpYZkcmrlYaazo9QShaWxL/lgSDmtz2mfQmFNyC2ok7JPud10jHNSr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612889; c=relaxed/simple;
	bh=+NyDWna56jKRxjX4nRCOG0ayBgfwHK46u0ayzUjMQuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kC8HOIVunWdlZoX+5zJlSqoojtaFUQRUP4ufcOHWRVbqj8pTxOAxE4J76uZP6cE5n6wdw62PVONUmf7pw2VMgomwRb/m9TAHZAm6VCmmbEIJidswrVudY/l+PMNYA4hQZSBidDWVqnD4vTAGZjQ7nCnHg4KY8nEePkOYv8t+DJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Fn/pJhct; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e8ddebc71so794765e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705612885; x=1706217685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=urN5IOlkkqGseby2zF94lkjsWOAoFsi6eWXRkVQaSnc=;
        b=Fn/pJhctyfPAKKLVGIPE8Q37KC/7/TFNA6MFljCJmjNPdR0zxrXA0ACuEITw1V//eP
         hsG4qp6J9IMs+MRuxyS/Y9V3ZYnl3anJurzjpbBHCegLdxjtxqLxwjstMcT/XjNO7/1y
         8wAknVUkBQqO8T366XNQHVGzR+QZJiZxbk40Ot+vUtVP7kH3JTx9aOXQeyyIrJ970bAk
         ggN7IE5d6SPcVg4H0/hAEcHfUNRIVOaJKUigo539RtIDEZH1pGqBTIg/nhGHA5CmDv9S
         tey0/dtPL2DlRJyKvNRj6EpEMbSZTK+mkxZ4Xb/3qRXQ1/Ha5NR0OynSrzH96ezjlYcQ
         EuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705612885; x=1706217685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=urN5IOlkkqGseby2zF94lkjsWOAoFsi6eWXRkVQaSnc=;
        b=Je6papXPMMT3CLhsrPnXAQvXsRnplVIZRK2O2RbqupxnZ2Q3C2+Lv3OaUMjDmU2RHY
         WufuBUizvkB7bifYv7G3USyXQdCnxqc4Kz6e3AU8ySB04Vmh/Qn9WymX3S2N0NRkHpjH
         0hmqYMoK0otDQbp/vi/yUeEUhwcfogPcq6MScLse2AmKYeLvRVdlVEejOGn1gRlkz7X0
         Y4ARfNqJdI6a0CIq5v0YeeuYj64KHyP8FxjQTLpUkdmu5fzimJAvUiDkgNOXK1GMlyLU
         K3eL7Z9g5GwixgtrhoCCkB0yBqDp7gaclk27OReG24dQx8q1PE7+G+99IDPjYn/UWPpw
         romQ==
X-Gm-Message-State: AOJu0YzHjCRDU99LufQ5R8eRi4IZPl/YUOx3WbgX8pH5WTDh/X4ww1F1
	pPaauB07pq6T+mUmm+1mjeiVd312xeH7Mbr37SiptZ264sDJjsmX6haO3mgm0Ec=
X-Google-Smtp-Source: AGHT+IGT2HKqFx5QAe2KTAwWSlOY74v3tpR9NOljC/IgWxHa4M77k5iJTiBdsA6Jkp3CA5L9pfsrWA==
X-Received: by 2002:a05:600c:6557:b0:40e:52fa:9e5f with SMTP id dn23-20020a05600c655700b0040e52fa9e5fmr909250wmb.63.1705612884943;
        Thu, 18 Jan 2024 13:21:24 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm30740992wmo.7.2024.01.18.13.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:21:24 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Frederik Haxel <haxel@fzi.de>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Fix build error on rv32 + XIP
Date: Thu, 18 Jan 2024 22:21:20 +0100
Message-Id: <20240118212120.2087803-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 66f1e6809397 ("riscv: Make XIP bootable again") restricted page
offset to the sv39 page offset instead of the default sv57, which makes
sense since probably the platforms that target XIP kernels do not
support anything else than sv39 and we do not try to find out the
largest address space supported on XIP kernels (ie set_satp_mode()).

But PAGE_OFFSET_L3 is not defined for rv32, so fix the build error by
restoring the previous behaviour which picks CONFIG_PAGE_OFFSET for rv32.

Fixes: 66f1e6809397 ("riscv: Make XIP bootable again")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-riscv/344dca85-5c48-44e1-bc64-4fa7973edd12@infradead.org/T/#u
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f533dd667a83..32cad6a65ccd 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1060,7 +1060,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	kernel_map.virt_addr = KERNEL_LINK_ADDR + kernel_map.virt_offset;
 
 #ifdef CONFIG_XIP_KERNEL
+#ifdef CONFIG_64BIT
 	kernel_map.page_offset = PAGE_OFFSET_L3;
+#else
+	kernel_map.page_offset = _AC(CONFIG_PAGE_OFFSET, UL);
+#endif
 	kernel_map.xiprom = (uintptr_t)CONFIG_XIP_PHYS_ADDR;
 	kernel_map.xiprom_sz = (uintptr_t)(&_exiprom) - (uintptr_t)(&_xiprom);
 
-- 
2.39.2


