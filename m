Return-Path: <linux-kernel+bounces-50295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94144847714
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8E288025
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C51714E2C9;
	Fri,  2 Feb 2024 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="eIxez5hU"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF414D445
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897237; cv=none; b=PrBHarzPI4kBJKVXWuuG308bmflwzIwI1kaSjngmm+Z45ZZtr3vVnC6ijH7p22nzVQNcJhC8NekWV4JP9UAU2O9XjbATf3zrkD6R+5i6jseqNBTPJQULEnuZERbdIdbOaChyi8dufq+jXEOhBfxMHASIH4m8A7WOyghDEFKjTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897237; c=relaxed/simple;
	bh=rOW+QJMgxaki+Zs/59rTQG+pV3s0svR8zftHybnFrCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxI7WMc8ur4HC0RfkI2SN+Xxt78smdTUJbC3hwWp3R5BBoCiP3eBpHe6Eer+3iZENae2UxCfL4jyZDgGK+U/xHDsPv1QqqPfFQiixjwSYa/2VDef0OsdNWAz07n+y7v/GaIAsexoO64MPrUITvihuYa3bY9q6tXUi+Lx40TBMsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=eIxez5hU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ddd1fc67d2so1812837b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706897235; x=1707502035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDme6jlnfxJTWCG7qW4Qy8DGvSmakPXAl9L2egvk9Cw=;
        b=eIxez5hUfp9YtpCJbFFsq5rHhz4ETMEgVxD3PyaqapRe+MNvn+FW4F/1PQ3S83IN6Q
         Z6X1KG1LbIVKZ5STLjcROvU40m66iRYZ/9gWL9KI4ECoFyL0zwWc9vHMPxVs9q6sEvLw
         GS/4JaTNu6j6ve5C8MAC5g2cOXUFky2G1F077K1c6RSEaovfRfeW7ruSbqsWaoMiZHhO
         EOHZkoRujQYwUy5aPGvmkT1ux7uVvX1qh0l6n9FjCzakC3z4nXLkew4PqYedL2+aeG4X
         X5r2+awR/z7ZgZoqEz95l/mmLIlRXk+dmWzsK+1/G/U+LbE1acs9GNdTjcYcI6SdlAlX
         DsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897235; x=1707502035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDme6jlnfxJTWCG7qW4Qy8DGvSmakPXAl9L2egvk9Cw=;
        b=E872wFsxSOrbiSo2Gl2FyVeDLohy1eOdUdoSBXZYqjKRC064knuAWQXSRzh+LGWHwi
         DBSV1Z2UdmyKQD9x0HebvX+tdgObHGbnx8NgStWEJlXhWi6Bn1unE25lh/DnRJSvsVqJ
         T/JiUXxov1PGhuxRA9PcsgVHgW2aRoVAoG7LROFQczzDnquttaT2im8ubLWmsJfRfQOn
         I+79mZtuYUvrrhTF11w2KktMmV0F6VJ+RofspIudWLsr0q2sEmBmj7qM5SdTxqxAwhAS
         J2mri7nLk8DwGcVojeSVzrHeYH+7P9kyGmjd9h9zcFyjwHDCp0CAR6QQWoCUVuGA6/o8
         KfEw==
X-Gm-Message-State: AOJu0YzKShpRRtbTtjkvNlwnzs/WEeum5me1V6ZQRR2teKQJpz0DTmvd
	StEZ2fdsahc2HK1if7TnkuG0F+APivdwf/IwPjLyiD23ty1h9JL+9vWFEIQF8Gs=
X-Google-Smtp-Source: AGHT+IGApjy1ny5FjS4Gq04ep4ZGH47dxEianIZwB0z+YLgCGzepTGWlWVGFhBvj0Leq9dER0TovMw==
X-Received: by 2002:a05:6a00:2d0b:b0:6de:2f30:9aa5 with SMTP id fa11-20020a056a002d0b00b006de2f309aa5mr10452219pfb.23.1706897235504;
        Fri, 02 Feb 2024 10:07:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUwNs/zU8/SXHjEg5qUkWY+fJgs2JKC5h3bIMxiFY66H4USskIUSM3fOxkdHpyh6sQ4e2yYOdz45C57EARz86REEZiCOCXWbA5Gm0Sypq6v9RBEWN+/mx4GuYvD6I1trxf3wKO1ukvU3hoffX9eTbINn/OcE3cSok4CavXG2l66S+no2C6S9fhUfvsxLFKbFDXcy3TWbq5Aq6sHseHObZF/cMmyc0nLCh8CIDSfRN4magWGtl7jSipLlkKKq5yv2ltHVt83sqeCYfeM
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id s26-20020aa78d5a000000b006ddd31a701esm1989267pfe.19.2024.02.02.10.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:07:15 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2 2/2] efi: Don't add memblocks for soft-reserved memory
Date: Fri,  2 Feb 2024 10:07:04 -0800
Message-Id: <20240202180704.808766-3-abrestic@rivosinc.com>
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

Adding memblocks for soft-reserved regions prevents them from later being
hotplugged in by dax_kmem.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
v2: only skip adding memblocks for soft-reserved mem
---
 drivers/firmware/efi/efi-init.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index d4987d013080..a00e07b853f2 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -143,15 +143,6 @@ static __init int is_usable_memory(efi_memory_desc_t *md)
 	case EFI_BOOT_SERVICES_DATA:
 	case EFI_CONVENTIONAL_MEMORY:
 	case EFI_PERSISTENT_MEMORY:
-		/*
-		 * Special purpose memory is 'soft reserved', which means it
-		 * is set aside initially, but can be hotplugged back in or
-		 * be assigned to the dax driver after boot.
-		 */
-		if (efi_soft_reserve_enabled() &&
-		    (md->attribute & EFI_MEMORY_SP))
-			return false;
-
 		/*
 		 * According to the spec, these regions are no longer reserved
 		 * after calling ExitBootServices(). However, we can only use
@@ -196,6 +187,16 @@ static __init void reserve_regions(void)
 		size = npages << PAGE_SHIFT;
 
 		if (is_memory(md)) {
+			/*
+			 * Special purpose memory is 'soft reserved', which
+			 * means it is set aside initially. Don't add a memblock
+			 * for it now so that it can be hotplugged back in or
+			 * be assigned to the dax driver after boot.
+			 */
+			if (efi_soft_reserve_enabled() &&
+			    (md->attribute & EFI_MEMORY_SP))
+				continue;
+
 			early_init_dt_add_memory_arch(paddr, size);
 
 			if (!is_usable_memory(md))
-- 
2.34.1


