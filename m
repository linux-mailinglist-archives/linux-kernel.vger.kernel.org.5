Return-Path: <linux-kernel+bounces-93586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB1C873213
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24AF01F21B61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EAD74E11;
	Wed,  6 Mar 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ULFJY8yl"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1A260B8D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715410; cv=none; b=Ytq8ws4BXHCfmiyGeEBbLmk7kIspjM55iamB3ne48EGBtlASSGtbmW+bMVFNmKnbCpVIPnwF9gdGRa0VKOJuMVVGrsKtnqm75xUupnaoLD1KBF4Y30Wy+7HQYUWSPdUz560R5fUQbFir8LUBugMzJ40VqwEyx16G8YYlDsARFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715410; c=relaxed/simple;
	bh=5PaOQohqxvp2+MT7niO+peIr/2hmdAFE5UfHwQ4Ukws=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mvm7IUpMmKitHUg3RwVbxv+7KPwy6obncsZ7OEdc0uIBVVhcNAlzGaz0GDk6P3oPer8XNP3oLMjykKJSjB0GxDmLwIL+0Kzfw/vIJSFXzhgpEzLIzWYLXRkd4tlH/VEcoBSwOovErKAUouUq3K0MT/kMlipFAqfFMQHrAV9R7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ULFJY8yl; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e125818649so3462738a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709715408; x=1710320208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CABJMt4hSO244iW5Glz3DNnS14exaADs5c0BJOhPvw=;
        b=ULFJY8ylDjBgKKt/Wg0/xtbkvfomi2pAmc3fbrLuQPCkAqtDQwGzAm7Q0mUHzQOsdj
         DMPwBWObGn0POhIJlb6liPmoePrS6j2CZiCtmLiaSKGrCSI/0PxdVasK9BF0qly8m+HE
         //ONfWOQAXSfz9Jj4tLyQF6knxEsiPbAtiz9+BZU2Tab9xqev0KHcmdgxj6ShQ9Xpdxj
         a5bCyhUl0m2Zb8tz4f2Cs5KVv+6iV5aToGjXpa7XajXah6PTMvzvEL8kieh5SSjHRg8j
         vZrZF9v9E67NrC36fhjMYB8A+AYNsb5he05z4KKTam6MuGhPUoYro73NL8hKbEz81Jx6
         RmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715408; x=1710320208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CABJMt4hSO244iW5Glz3DNnS14exaADs5c0BJOhPvw=;
        b=Y+a3q0EQFGD+jzGxILB6WO41ItwFN4fXYMAA2eICbnS84L0NTSaZkqkwq2uroNsLFm
         zYDWGu3GlSRnAjBH8pq9rkuaCa2fVQucLDblbm64uUHI7Dc5HmJlY/54reHD0x499OkE
         uYK8K6JJvjzqEUpbUQzg+dJy+cX92BZyTOQW1+JUkOU+IMslXz9nUAB3pNk2uDDivgiR
         tQpntQuJ4gjVr38T+DH/MowvPq/idBgbYfi9Id0cYnNlnP5bwrwxL3STUgf0BZXz/3gI
         1/bQn5GQIHLJHQsZpee3NP9NJh51dG+TCF09SUwpZnRUTGXLwIhd+syldoZZoCuwju6n
         2Cug==
X-Forwarded-Encrypted: i=1; AJvYcCUiJRef0DcWERMRKPtgBpOn0sVvmUQIiR7j6Zxzl72ejhCFWgZtPgupIPd2fDv+weIk7Om3/HmKQiSBN0zUR5x1Utnmh/tLg8xLYHfe
X-Gm-Message-State: AOJu0YyOgk5TPZIVPhkDdIosWydUXQds9GdKbQEuEkE9IsiLPSzF7DfO
	YGV6ISbd4UKgPu+rCZAMYH2sjN1l3CmnwJpN77E5Skv2H6QBRRkTCzmpi6ooDs4=
X-Google-Smtp-Source: AGHT+IE2BdBcL6wdxX3LfFe6ila1xwesEmOhKWIXEUQRU2u85mQlRvRPcTSduuuATxjh6RtMEQbedw==
X-Received: by 2002:a05:6870:819e:b0:21d:e28a:fb14 with SMTP id k30-20020a056870819e00b0021de28afb14mr4580959oae.47.1709715407767;
        Wed, 06 Mar 2024 00:56:47 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.7])
        by smtp.gmail.com with ESMTPSA id o74-20020a62cd4d000000b006e58663dd0asm10740071pfg.110.2024.03.06.00.56.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Mar 2024 00:56:47 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	cuiyunhui@bytedance.com,
	xuzhipeng.1973@bytedance.com,
	alexghiti@rivosinc.com,
	samitolvanen@google.com,
	bp@alien8.de,
	xiao.w.wang@intel.com,
	jan.kiszka@siemens.com,
	kirill.shutemov@linux.intel.com,
	nathan@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH 3/3] efistub: fix missed the initialization of gp
Date: Wed,  6 Mar 2024 16:56:22 +0800
Message-Id: <20240306085622.87248-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240306085622.87248-1-cuiyunhui@bytedance.com>
References: <20240306085622.87248-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared with gcc version 12, gcc version 13 uses the gp
register for compilation optimization, but the efistub module
does not initialize gp.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Co-Developed-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
---
 arch/riscv/kernel/efi-header.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi-header.S
index 515b2dfbca75..fa17c08c092a 100644
--- a/arch/riscv/kernel/efi-header.S
+++ b/arch/riscv/kernel/efi-header.S
@@ -40,7 +40,7 @@ optional_header:
 	.long	__pecoff_data_virt_end - __pecoff_text_end	// SizeOfInitializedData
 #endif
 	.long	0					// SizeOfUninitializedData
-	.long	__efistub_efi_pe_entry - _start		// AddressOfEntryPoint
+	.long	_efistub_entry - _start		// AddressOfEntryPoint
 	.long	efi_header_end - _start			// BaseOfCode
 #ifdef CONFIG_32BIT
 	.long  __pecoff_text_end - _start		// BaseOfData
@@ -121,4 +121,13 @@ section_table:
 
 	.balign	0x1000
 efi_header_end:
+
+	.global	_efistub_entry
+_efistub_entry:
+	/* Reload the global pointer */
+	load_global_pointer
+
+	call __efistub_efi_pe_entry
+	ret
+
 	.endm
-- 
2.20.1


