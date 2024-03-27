Return-Path: <linux-kernel+bounces-121605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728288EAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07902A5A09
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CB9136E29;
	Wed, 27 Mar 2024 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IwIiEzgn"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C4131E27
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555529; cv=none; b=j6AfsrC3QfMi58btga7HEk6Whz8jKfsXbcJ8cRaADamzuiQpQ0IjL8e9AFy4cOVl5toeWDVKSBkEkgSKpz218+8QUOmYmrdhVlWWo6mpYVQ+2Dj9dvV2unwuAi3B2iqR5+/C19EVDgXtYzRAuBqOcsjypmkYKlrktE5KspToNBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555529; c=relaxed/simple;
	bh=r89XNv4WfgUD7lamaOlWbD2n2mjunEetZGP7bb3T1KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpNHGJpTQAcP2k+pequdC3AsFtzIFhQ2X2UFPuSdOLsJAFguICXAFIs5/2jLSEPuIoZEo2s0B+pPj7jriCe6k67zL2omtAG7J360qYBGkH5IGGyX+WvCylS1NBjiFTlY4roADhKKGypz0c3fI1vwMZE2cuwPsKhH4ezl2nneDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IwIiEzgn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1def59b537cso46637045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711555527; x=1712160327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4M9Lk9Z8nU8etdW0Vehxd3ZiXzPs65Q9tqt+MZAHIQ=;
        b=IwIiEzgnc6qnAAt5G7fRO88YvBd1Un4Wsm0oxdxPSwsbNSQVrKbS3RH9vprTsVi7X1
         0IaxRHqWciemuna7fhWh29cMmt2EKYaiU6crZ8C/oEcBtakWk7FyGFBOWlHTwflfX4/W
         4AFJaRcvHUIzlq5VK1uANZ4jXuqJKgxPgvwpRrEZN5OxMnflEMDCZOl0emAj/KCJdrU6
         024bE31naaByDUDJTc67w/qqD1tFcKz0SRqDCTpwoBwVfTyAWGcPMgTY5L0HsoHcoCbt
         qwqAXMIYIjzjdy2tWvDs0NxdjOVzgz4bwCh2Q+gujnZR+fBwWfo0Vccj9faRwefKmldG
         0uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555527; x=1712160327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4M9Lk9Z8nU8etdW0Vehxd3ZiXzPs65Q9tqt+MZAHIQ=;
        b=XzWwzNdP1Tfjaqq7jHZ96p7c0Eez2jjQrYyimmHsIeV4Rvj+2XBrJgLfqXO+DpVOKK
         u9IiSjKOpu2xYKSvwGBBwycr/JGtUpH7At24w36eWGcBIiHJGk42kE7jNANsX+UWo3dw
         iUGcmdmLCx1EjgXnN9CWpQxOrb41/AoaUomBHhzcUXJzr8GV0b2jkaUGRGveE6AmuN19
         EjsVi0smxTjhF0qwG08Q2Q3zH24y6QuBxvxiHxRS/iv4X1hlmbIvrLSklv5PWd1Y6B8c
         P0Ab5V9w6WkgVPJNjP+6GcBSaIEmZx+kb+AuyAaNhQ+vr804RysPU0AqrVzGGD1tvUXn
         Xv3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrxgTvHOSOn9YYqUJoCiP+vsHvN/1+IghmnNa3oqA1gKbC/nhvAYuwarlOzsDJeQbv6RWA48xvAGwfFC0o0Ww6i+RvWjvjHVTSE4+T
X-Gm-Message-State: AOJu0YywK7hXCc8v9VlBXLIpdZbUD1ulFp2ibaFRikDZKYnw6wihPp9i
	H+wAt7MEDaYeBYpsE8QYATw5qIdfvXfPlFzPOBk7ji99g/i47++i02mlDkRaQ4O6lW1Lr9UHbaD
	R
X-Google-Smtp-Source: AGHT+IHmU9bA6AvbKxQ+lqld0GtL9R2sxBrS7FKO5825OmmPZqHfmYm+9jb41eb0MCY+vR/dQnQAlw==
X-Received: by 2002:a17:902:e541:b0:1e0:9122:abc4 with SMTP id n1-20020a170902e54100b001e09122abc4mr169570plf.21.1711555527635;
        Wed, 27 Mar 2024 09:05:27 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bf4-20020a170902b90400b001e14807f9cesm1718226plb.125.2024.03.27.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:05:27 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 4/7] riscv: Simplify text patching loops
Date: Wed, 27 Mar 2024 09:04:43 -0700
Message-ID: <20240327160520.791322-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327160520.791322-1-samuel.holland@sifive.com>
References: <20240327160520.791322-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the number of variables and makes the code easier to parse.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Further simplify patch_insn_set()/patch_insn_write() loop conditions
 - Use min() instead of min_t() since both sides are unsigned long

 arch/riscv/kernel/patch.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 9a1bce1adf5a..0d1700d1934c 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -155,22 +155,24 @@ NOKPROBE_SYMBOL(__patch_insn_write);
 
 static int patch_insn_set(void *addr, u8 c, size_t len)
 {
-	size_t patched = 0;
 	size_t size;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
 	 * loop with len <= 2 * PAGE_SIZE.
 	 */
-	while (patched < len && !ret) {
-		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
-		ret = __patch_insn_set(addr + patched, c, size);
-
-		patched += size;
+	while (len) {
+		size = min(len, PAGE_SIZE * 2 - offset_in_page(addr));
+		ret = __patch_insn_set(addr, c, size);
+		if (ret)
+			return ret;
+
+		addr += size;
+		len -= size;
 	}
 
-	return ret;
+	return 0;
 }
 NOKPROBE_SYMBOL(patch_insn_set);
 
@@ -190,22 +192,25 @@ NOKPROBE_SYMBOL(patch_text_set_nosync);
 
 int patch_insn_write(void *addr, const void *insn, size_t len)
 {
-	size_t patched = 0;
 	size_t size;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Copy the instructions to the destination address, two pages at a time
 	 * because __patch_insn_write() can only handle len <= 2 * PAGE_SIZE.
 	 */
-	while (patched < len && !ret) {
-		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
-		ret = __patch_insn_write(addr + patched, insn + patched, size);
-
-		patched += size;
+	while (len) {
+		size = min(len, PAGE_SIZE * 2 - offset_in_page(addr));
+		ret = __patch_insn_write(addr, insn, size);
+		if (ret)
+			return ret;
+
+		addr += size;
+		insn += size;
+		len -= size;
 	}
 
-	return ret;
+	return 0;
 }
 NOKPROBE_SYMBOL(patch_insn_write);
 
-- 
2.43.1


