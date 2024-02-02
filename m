Return-Path: <linux-kernel+bounces-50147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD98474EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2B329046E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE52314900E;
	Fri,  2 Feb 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GtWBhmZb"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5CF14830B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891690; cv=none; b=V3h1ZiIimapU01bS9Eeeo18VovkZnnwL5dvFVZDyS/pgc9pf2a+TM1Gkw/l65Et/kX8iV9LyrIXvmpKqfxk8GEHZB/u4S8YkDbF/4/h+HT9/IV6dPsNVZ6j1mvFuOMg7May+NMf/JeRZHz/RYNgNGkIrj2epeRrFh5kfdEVAxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891690; c=relaxed/simple;
	bh=Ikc0whWoh7rMxU2EQziFijF9n08K3zToYOOQC/gU6Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dWMUSUUiqkZiT2iBesacjwsn+QNEvooG24v8V5W16X6nu+imJJQ+YfSH7A+QzyVi782TuDs0C5H8VGw1JVVr1oQbk46cP1ol8WvfKvzi11txgTGIUK8CySsuNCeN2d93fqhVCZlsrp+e1WTLNU9ch8halgS/BdCeU8AwWAw/XuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GtWBhmZb; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29041136f73so1718885a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706891688; x=1707496488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4XLcspDZ2svWPCn3b1Mu60aWYrbol9SnEepXTKa4KE=;
        b=GtWBhmZbc3MF+D7n2KyuoyJXPFF+HpI+Bqz01BA5dmLByc7hGNPyLEdNMO+eZJiCkY
         bAAm2PgUYmuSgKja+nie+Tmz/EP43bpN74WBcZ5G6dUwB49GkMuHxFrfMVoXlBscf5MC
         bHidPyQdE4LJDTH6i5xYH6T3b2DDqxhAmRJgbqPvm8EZwHk367pohy39O+rn7oXBM0Eg
         cKuPScqAr6jSfLr73WbqVPhwsGoND7b1XkjAmo2bDfJnzBhnDPB1qg1nNpr6wSA0OWH0
         NZe02HBJmUgTqVP9LpJLYkzBU8ZlAOWiqW11c9UhGplh8OHI4c+eKxTiWnOj9CJYdv9n
         8bKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891688; x=1707496488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4XLcspDZ2svWPCn3b1Mu60aWYrbol9SnEepXTKa4KE=;
        b=jaEAYlkALLzDwCz5PWOqonbXphnSk6Ay8bNR48/7egCRYWdbYw2MldFnhYOA27p14Q
         v/yCINPtCdAQjbv7lsEv/c09LuZtOxfhfvbc/Ysk9SQBaGCbMTFioFmIXIhgljUlR3nm
         5fzZNrYNujH9+rQ4E97FlWy46gzH0CWFC8B8RhASCcWuQvpmADBhUvxepbG+fIFBucuA
         mxGVUwwjyXpkATXqbjKnbXmoKt3nETI+OooOeuBCd41K5X+EUWIPIMDuILE9oJFMr0Cz
         ytYtJuy+6LuclTTF69FyO4ynG7DtTmJ9tsKUZUmfetKa9UEt1TAXrInWzsI6X7Sxc4eX
         RVoA==
X-Gm-Message-State: AOJu0Yx+pXJKTqjQFifYkJ/e1IzFl0Di3jv/o0Ra+6W5yu4QXCl19WYg
	qbAaGafe6GTwOXItxPXUEdsheCJszjsibivoWanU02TM+1NTdoqMXk2APUkSL6I=
X-Google-Smtp-Source: AGHT+IFSaOJGmU3nV35wyc0qbUGGVGRDpxLFzEIabMTzgK3Mk6BNdYPxuXKelnyByl8YF5H8/0qHBA==
X-Received: by 2002:a17:90b:80d:b0:295:ff5a:5e4d with SMTP id bk13-20020a17090b080d00b00295ff5a5e4dmr2634953pjb.20.1706891687915;
        Fri, 02 Feb 2024 08:34:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWl8eUkaFifVQfTIqx1jcOjqKGs+PzcPRmEeuWoGgHYEFqPgSWmGUEk8Z+2QzGzXhmi67UxDhC3lP11ZX5isxcEAUwRnOHIaqKRDQhDpW4rFHWMP1CsvPVVId7GnG8mz2+Jt2Ytj3xxCuaJFJNofafO/EUbReVVwNNgGdkYaB1HYH+faUsW9CNoLYFgaTphCuhfzUaQm+OE9phqQRx9H494jbkBk8ioZi7E7f3gLr5F4VRW/AMwDA/pj6h3qCnsXoDtCNPo2DsMQNL7
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ju15-20020a170903428f00b001d75c26e857sm1784870plb.288.2024.02.02.08.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:34:47 -0800 (PST)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH 1/2] efi: runtime: Fix potential overflow of soft-reserved region size
Date: Fri,  2 Feb 2024 08:34:32 -0800
Message-Id: <20240202163433.786581-2-abrestic@rivosinc.com>
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

md_size will have been narrowed if we have >= 4GB worth of pages in a
soft-reserved region.

Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 drivers/firmware/efi/arm-runtime.c   | 2 +-
 drivers/firmware/efi/riscv-runtime.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 83f5bb57fa4c..f369256c7003 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -107,7 +107,7 @@ static int __init arm_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			unsigned long md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
diff --git a/drivers/firmware/efi/riscv-runtime.c b/drivers/firmware/efi/riscv-runtime.c
index 09525fb5c240..9da79b8169d2 100644
--- a/drivers/firmware/efi/riscv-runtime.c
+++ b/drivers/firmware/efi/riscv-runtime.c
@@ -85,7 +85,7 @@ static int __init riscv_enable_runtime_services(void)
 		efi_memory_desc_t *md;
 
 		for_each_efi_memory_desc(md) {
-			int md_size = md->num_pages << EFI_PAGE_SHIFT;
+			unsigned long md_size = md->num_pages << EFI_PAGE_SHIFT;
 			struct resource *res;
 
 			if (!(md->attribute & EFI_MEMORY_SP))
-- 
2.34.1


