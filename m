Return-Path: <linux-kernel+bounces-61081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF880850CF8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BED52879F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B463CB;
	Mon, 12 Feb 2024 02:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jdyyW5hJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596D107B4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706539; cv=none; b=d0QwOqwc8MHFz31MNzYVfPqqgNScRsHllhHzvuvrLgZepEhVR1K+B5ept3jLqS2IOXXdr+Qszad6WYail9QG4kQCtSEiE6HhWwTPrYo43t2I4NVcRB8BNxWhcwJ+Gm9HGb+PnF/feTOlXDesuU/RpJuV5kSF5zn+msUPdE+vE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706539; c=relaxed/simple;
	bh=UttEtih3z9yX90IGUQyC21qiA8cAYwBHPSzo6eqGVuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWG5OWYLI3QFcGFeR/6oCt2sTglsg4srNViO6/kk3a+ws5UAlM2A5eE97ifRbl+9qntb9Wx7co4GsFU7OfkpSECe0LJivjLbPWcnz5LqFi4wMJqIvIkSibZ1uxjXXPn+C+kKRLTrSvjvqb9ai3FbmCjpdvAJhk+YRofsJVxnn4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jdyyW5hJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d93ddd76adso18932705ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 18:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1707706537; x=1708311337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox1XwYN/8KUHgBEQv3P+eTmNJiT79C/wgnmP2bJX61k=;
        b=jdyyW5hJtNaKAH3J7syG/qH9SJm1y82cwy/l/Y2OrkSZijS9isSYbqq51rd7dL9DH0
         zk0qNHhYTqIp99/FvZKxPyrJvGgg5Bhy9bDCARh67WOf4pSK0R0s4SVsx0ILwSz+Jzxz
         bg5PA9RTDcp+mAkr4TFok10bwCDIkq0zEUaWdfAc3RaiQNqlpX20or6uVVcZlNbZxcdR
         CU+xAavVv0/BcMrgBxxirvIu5sCW23STdP8wBu0XwtXEsoR0NY9AbRzxyf+IFsTSAz2U
         GC67csQb7c8HL/FZNEOAqSyXrvN8c2WbQFRgiKC4JAbcd+3g7nf+Tq0P0CP7ZfTVIHhF
         vxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707706537; x=1708311337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox1XwYN/8KUHgBEQv3P+eTmNJiT79C/wgnmP2bJX61k=;
        b=lef/ic9RTsz+vhGDfUKkssBu/LSHx3n+U2pxC+tnqSIp0DPimNz9RXSTGWLW8l/Jd6
         /J/8iHFaTAwgvF22wpqPmjE/AxrU62wG/iXfb/pM7LvJXFB6xziRQpS3GkPf6kEOypd4
         tf9mvHMC5n4h4O6q6H3j0NsmLh4kyp3kfld7aYGHD1A3LPKTqg5GPY4axkrH+Amga6+Q
         bfz8gcEMZ8H+KjZWf16DgrqNNqdrRfIt6sVbD5DkrxECC/V7xM+9QwM5m7qDjP60/8Cr
         M9kgedDJzjAQIYj8NwYxC1Hsj0i7hsvdKr2wIW820fI926kegOF6f/XwHuHamYue3hJF
         mqgQ==
X-Gm-Message-State: AOJu0Yz/WFUEuj7z+sqh8harzDbbdrjSI47MI/SztsCBhcGfZ+Ha74yJ
	8Lqs1MEn8NvOYScdBnd/SEoIR/v739IGG5xTekeLBcY+TrIXRPP9OhZEli2uxy8=
X-Google-Smtp-Source: AGHT+IHYkVCajx+MEy/OfBC5bCV7cXqNkY+WfR1rDLZRGVuEpdHJ+RaOhpbXqqJFldLP0UL2Pylt4g==
X-Received: by 2002:a17:902:ec91:b0:1d9:a148:48a with SMTP id x17-20020a170902ec9100b001d9a148048amr6334084plg.24.1707706537479;
        Sun, 11 Feb 2024 18:55:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSKmmJnT8/3BSU7Qh0RzNAg0qQ1juI97gXPgba5vC2fWKScLl4PX6qPshaybpKTz5/v3owJsCFEwiJlXAtPYFw/embDaV2OphOMNya5Shdc8dllDXVfo1lnQ+DisEUKB9rWLv40/ii
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id lb3-20020a170902fa4300b001d9af77893esm4906443plb.58.2024.02.11.18.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 18:55:37 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 7/7] riscv: Remove extra variable in patch_text_nosync()
Date: Sun, 11 Feb 2024 18:55:18 -0800
Message-ID: <20240212025529.1971876-8-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212025529.1971876-1-samuel.holland@sifive.com>
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This cast is superfluous, and is incorrect anyway if compressed
instructions may be present.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/kernel/patch.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index b0cf050738aa..80755aa627d2 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -176,13 +176,11 @@ NOKPROBE_SYMBOL(patch_insn_set);
 
 int patch_text_set_nosync(void *addr, u8 c, size_t len)
 {
-	u32 *tp = addr;
 	int ret;
 
-	ret = patch_insn_set(tp, c, len);
-
+	ret = patch_insn_set(addr, c, len);
 	if (!ret)
-		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
+		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
 
 	return ret;
 }
@@ -212,13 +210,11 @@ NOKPROBE_SYMBOL(patch_insn_write);
 
 int patch_text_nosync(void *addr, const void *insns, size_t len)
 {
-	u32 *tp = addr;
 	int ret;
 
-	ret = patch_insn_write(tp, insns, len);
-
+	ret = patch_insn_write(addr, insns, len);
 	if (!ret)
-		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
+		flush_icache_range((uintptr_t)addr, (uintptr_t)addr + len);
 
 	return ret;
 }
-- 
2.43.0


