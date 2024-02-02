Return-Path: <linux-kernel+bounces-50294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D0C847712
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB3871C28BEB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A8514D443;
	Fri,  2 Feb 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="H62nDHHG"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C514C5AF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897235; cv=none; b=cA/cYTJAtz4ahXP8ry35HXIOK3gVuHxVNlgGQySqiOaD7JbaORU+mMWDXLN/RDZGkVomYhcfpbLXFleVk5gY65ZAwvfujPPcEpx4CwDQyITPFVzP7sUMHe+rxKsgxMr0Bqx66TUYyWXZ1ZO4ELriJtRipt/a7sFz5Ijl+/u/GEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897235; c=relaxed/simple;
	bh=WyNQGE65iXrMr9yngCo4GWOgGd/sXGPgehCp3iXlLL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lAvrSddEmPrsjNv+a6mhoEkIi7FvLs6KPac9p5f+ykcY61QCCfKSy8zKKpMU4XIuotZToQys9IChL1mT9HBzJwf//mwzpBVUbyrzxRyxCnOn5XRo2JNrc3M/oxAkOAulplkNR1FrWfyDL/YXxvXsc4MzklNP1N7bbdVioJzA01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=H62nDHHG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so1878244b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706897233; x=1707502033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Yyrip3T2gRBwGLvYCLpLjUFISir/avz/b+c2luLHGY=;
        b=H62nDHHGZYda9okCf2JfKZCp+55LjIpMigZ5Y5jAtyqGH9J1UzEB356D3pdmoyujqj
         x/0Krd6MFnGDgwUhTpgOujbbhdnw7AMR5nmplvXz9vmkO+/PHVqUdswaMm0R5Lmq4OOD
         r9wGLBVANxD8YP7S6XMIWtTTKVvrOiUjD1Xxo/qaN/k8CUHIZOcwVgMJfk3Nv2+jTX5y
         w7D34t2HgHPv81SjoaW58JJ3PjZL6v/ELD2sFFLIR6rrbK5o1397KBCDrX2Eiu2AfM3X
         94fyHHWuDlGxfXtFG/aL4LpY67jD+Fe2Lztx8kYLULlNFKK/TsKfEuCiQLNJDWF7b5ze
         d6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897233; x=1707502033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Yyrip3T2gRBwGLvYCLpLjUFISir/avz/b+c2luLHGY=;
        b=RGLK0gTgpgxkng1al8STMQr0R/husjlP3bYPZilUfh0VBCfYC5Qa41St+ImKUqhpDv
         jL6Kz6rJl3eHAg0/pV/zKsLY47bNq5J3ZAQH3L1pPi7OCw+qdDkOIr2HD4STAwzKYxIu
         SxdiA/Ntz/3EguP06HQ1aOuWJOW3DyNfKMUVWz628bidpwEHTCqV4yw93TTVw0EAuHgh
         iLt6UHYiTkILemFy1Imb/MiZlEvYtCy8jlpkJ6L2a15PRmoGW7NVDXIXKYeA2m401zV9
         ObeaGAbeQ66TB2hsjYFZW7KKQ4M7r10My6sz6YinYjsKluM96dh7dsCWnhZJzAcWaJ4p
         AymQ==
X-Gm-Message-State: AOJu0YwwhRXrZnKh+DI9jKh7FV4PbkHYIU3Hg+GJL5EChYg+c8WDcwJZ
	ZMtQvAIxeMXnyx5n3th7BALmZUEwXYUF/vXzlKglPDCqGgRKjyRoIsqMOON2gYY=
X-Google-Smtp-Source: AGHT+IG+xYxv+LwajPk4C5nz4DY2qxbK7PqAKE+WcH5FBlppsmmhxviIkgQ4jI0JLjaR+O7wz2Jigg==
X-Received: by 2002:aa7:9e11:0:b0:6ce:751b:81d9 with SMTP id y17-20020aa79e11000000b006ce751b81d9mr3346175pfq.9.1706897233322;
        Fri, 02 Feb 2024 10:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU5uQRhhNr4F5Tr/eDx4VZKGJkZm2fFKhzvmErVJFdhN1keJw/2/IIbPia/PAaM3mkVII16Nt5yvabl0M3Zh8DUWKa04jN+PvoVj8IbhmJzrBJJb9Arr0kaYy98U+F3QdLE5FXpj6PMaQqSExRB9qZR4DdEU4G0klU6A2Yo5YCioE6HI4Uq69jHHuQmm1KAoMudrIvnpqJDFjQ+aG90RJGeKLQrNFSBnP1dKqm3fulhCWqUkrdAXfbWK+vNySD4eg8DV/zQ0+5yqh++
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm1989267pfe.19.2024.02.02.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:07:12 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2 1/2] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Fri,  2 Feb 2024 10:07:03 -0800
Message-Id: <20240202180704.808766-2-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202180704.808766-1-abrestic@rivosinc.com>
References: <20240202180704.808766-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

md_size will have been narrowed if we have >= 4GB worth of pages in a
soft-reserved region.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v2: use u64 instead of unsigned long
---
 drivers/firmware/efi/arm-runtime.c   | 2 +-
 drivers/firmware/efi/riscv-runtime.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83f5bb57fa4c..83092d93f36a 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index 09525fb5c240..01f0f90ea418 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			u64 md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
-- 
2.34.1


