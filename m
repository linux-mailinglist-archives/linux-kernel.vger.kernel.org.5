Return-Path: <linux-kernel+bounces-50148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351AD8474EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095AB1C27366
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CEC14A097;
	Fri,  2 Feb 2024 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qASvpXb5"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D214900F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891692; cv=none; b=DOyBuuZCE333QpTm3KKjoZXRV8x0HUwA/qiUXzLu37BwDvuEpansM0CMWlEJxRXavREsb1UVJUFx37q1kXfd4SeXFv+RzT1jHCFjB3EFkm8UY3QzoqEgMpeek4D/zmQsjQ0bxRDdHkjFwHM1ImN4mbCQeD3GGSDfzW7UqAuK+jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891692; c=relaxed/simple;
	bh=6wzJzUOn25V37JzavypuqOKI2HSv2Q0C4HVDvOIYmqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJEbF10I86mirdwuIxaRM1w1T/zDBc146wEYz9jEL4gNcmvkv5hLo/LRUvNUT7PiJcJWyVoW2t7rjiMpKku29bp9oviuZ6S8qv6fhkgmmsGWL5AuTwJgGw/unHDRh/z1IApjLkKS6n1kdEL0t+rsZ4WHMkbfr2Y/aa3d3e1w5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qASvpXb5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so1543857a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706891690; x=1707496490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqv6IbT5YBrkVHXBtAcPOljl6IyXNltBMTpBEU5EmMk=;
        b=qASvpXb5+QgDNx9N/WUpe1DkSlpp+G2g3zzxSJTjH4UIahWyvqFQmSaIaZuT9sUjfu
         8sXbNmJpT6JQMEzl6haHnjCzsS92bKpMOyfCsVeJv/M1BodeHD4aGp4tWc8RaHmoOiFZ
         Pn+gL0R29J0R8Sj7SQjN7iVXAEK/A71DyMYCABfBamZQVtjanbtDyoLG8PN4F9o9bC21
         vyjtrd+utvw2PmPGl3OF5DJlUg/Pfn9Fda4xYVzBOYp12bWGVQhg1LU+2zV6feoojHir
         y/65cKPNx5ggt2ems/5NA1Wl7smRnK7OjD8+VYXKig/HV506aUafNtgNcF9vZPMWGfup
         YSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891690; x=1707496490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bqv6IbT5YBrkVHXBtAcPOljl6IyXNltBMTpBEU5EmMk=;
        b=ku+934T8JuwBTQnYP4shaO3AyhmOA2ryrLm2nbfhFsAR0KuV1UP1IQjukZHJKXaRkM
         eVnDY/cya3lqZijobkjxMO6b+piywpQt1qKvMg0YbPw2fyxlwaY0TNPQlt1oiQBuK7nV
         cb7jxZf69vyyZ4oUlYOJunKtRq7hKgoUnXuyepaqK1lk+6fCchS54tHAwG8Iw2pOXs3H
         x2d7mQw1XqtLcbuHFwCMTkUuZiYlebew658H1x5X/g8hoQmytXZOrFDHtZLyj0IrHWm3
         cnaUwfZCZAuxkspJ7QwPMwAdxdBgbkp4JjhZ/7PGgGD6VyMddR2ohXr1rKTDfXLUCBtw
         vZsw==
X-Gm-Message-State: AOJu0YzfUi0+aplwFyrt4kFvhsD2Vt6Y/pep9X2pCPodT1i3p1Waj6OL
	c0vy/MMMFfIfkmdfDl3vZPZW0H8F8ONZjow2YcimcnOh77tATly11OzDFfyiIQQ=
X-Google-Smtp-Source: AGHT+IGqHgU6dK6aj/33iDUN8jETVP+XvIewbJ5TV+sTPM+PPxaI5s4OR+NQbwDplcZetb8cpjDR5g==
X-Received: by 2002:a17:902:848b:b0:1d8:fcac:eff0 with SMTP id c11-20020a170902848b00b001d8fcaceff0mr7497653plo.9.1706891690057;
        Fri, 02 Feb 2024 08:34:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXMrpNV1ur1ZaUXyBREl/idQhnbrCLLbzfYUB6Yw5ZhB75G4Q5ZLpVuL60eFiSgHyQig+jkiOD/tHdIOzF+cK9nOkO9xQbFvFlf2pFBL/0ugpZBj5vBMrmBZNP44ch2ldgxCpOPavoC0ailhrqy3fOjDKBt9FTts48VbvXKCAdPTJ2pfBz1eKjn44ykacO+n6SixsVEAeA8I8Gcqw0pDXijksNLSVozgSD3J5gq9FQKAb4MDVqjy3mHagVLPo+ZjqteleNjFQnu52Zh
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d75c26e857sm1784870plb.288.2024.02.02.08.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:49 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH 2/2] efi: Don't add memblocks for unusable memory
Date: Fri,  2 Feb 2024 08:34:33 -0800
Message-Id: <20240202163433.786581-3-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202163433.786581-1-abrestic@rivosinc.com>
References: <20240202163433.786581-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding memblocks (even if nomap) for such regions unnecessarily consumes
resources by creating struct pages for memory that may never be used or,
in the case of soft-reserved regions, prevents the memory from later
being hotplugged in by dax_kmem. This is also consistent with how x86
handles unusable memory found in the EFI memory map.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 drivers/firmware/efi/efi-init.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index d4987d013080..f05bacac89b7 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -24,13 +24,6 @@
 
 unsigned long __initdata screen_info_table = EFI_INVALID_TABLE_ADDR;
 
-static int __init is_memory(efi_memory_desc_t *md)
-{
-	if (md->attribute & (EFI_MEMORY_WB|EFI_MEMORY_WT|EFI_MEMORY_WC))
-		return 1;
-	return 0;
-}
-
 /*
  * Translate a EFI virtual address into a physical address: this is necessary,
  * as some data members of the EFI system table are virtually remapped after
@@ -195,12 +188,9 @@ static __init void reserve_regions(void)
 		memrange_efi_to_native(&paddr, &npages);
 		size = npages << PAGE_SHIFT;
 
-		if (is_memory(md)) {
+		if (is_usable_memory(md)) {
 			early_init_dt_add_memory_arch(paddr, size);
 
-			if (!is_usable_memory(md))
-				memblock_mark_nomap(paddr, size);
-
 			/* keep ACPI reclaim memory intact for kexec etc. */
 			if (md->type == EFI_ACPI_RECLAIM_MEMORY)
 				memblock_reserve(paddr, size);
-- 
2.34.1


