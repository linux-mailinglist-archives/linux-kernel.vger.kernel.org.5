Return-Path: <linux-kernel+bounces-83997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7892786A12E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D9B1F241D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4914F963;
	Tue, 27 Feb 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="O/ACh58K"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34AD48CFC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067144; cv=none; b=DWKvcl5SxisuxxR/bUZByUpw31EUt5rYo0MHA2sySCwiA6GZbsOhA8SJ23Isiaj0EKeZyx2hkoaxI3BgCGgA5MNV0eIp2yIo39WT3AIGFryxD6uf0alTvoICl4+vh7BAdjer3rB2GuTHdOJXT101YR6CaigeaDKHZiVvFV9K3Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067144; c=relaxed/simple;
	bh=JsQ1nGdibb8WX0Sy1YuZgdzxR6vLTyCS9HB+mk8bneU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJp+zN+flhBLTx0HnOzHK2y2ylUEfILdCGhKahQ3MgVXZgZkmov1CgTdjHmHHP5UBllpi/pfedM7C786E0odZHFFaqekvhdpPCiH2qv4hSNz9d3vNBQNmqGvhoNXLaeXyKgqOq/ZtkYIYqHhozR9siyU7y2iroJ/DTWiFKtJgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=O/ACh58K; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33d28468666so4111205f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709067141; x=1709671941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzfPm4MGmy+twyI4zc1gm3KO2QTVwDkS4GmOlB/j8Xc=;
        b=O/ACh58KQp//yOLDqxJlq9hSIMjQauD04mbLhyKQa6Yuo++Kb2Iz9bK2PdzpbqFeJ0
         6aAQ4FBDq3F2h5zDizfBfla9HkeW6+mDU2Ib9HcZOOxbgWsIMHl3sVZAhOou9cAKdjoi
         Z/7NS284XeCm2OMlg5XNAeFF6PpZI7+dTV7I18h8hK1dH7cw8COeGv6XxRNso0kq35V8
         pL05BAka4XLOhQX/zgQyTvMuSQ4mejI2brh4HeAU2Al7DgbKx/7NJIgVycJaVcKHsKl6
         6XxL07G1bMbUzzv/+5P4iBhqfUNnylxsfuhmyQtvXj7AwcDgkfVdbX7fguwjomyZVnlh
         GwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067141; x=1709671941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzfPm4MGmy+twyI4zc1gm3KO2QTVwDkS4GmOlB/j8Xc=;
        b=drNMlNIGnotrkoMUY5EzCODXu8J8mjcqePkEvFfZylbm4GDMSLcpSnvrAu/4DvUGMS
         gBiDw0vnWENEr9aBOKMhj7sv5cY8sTuyIjGMN1AsvareBlpD3fwIpFKc3NATjnoy7wXO
         nae5sxFnAo0FAmsxX9uUNm784I6yVGHnnxvCPw3a0f0lN0tvOpIJEbZStzMIXJBAjoJ7
         GyLmdorZUwL0PPmYrBNqtmw23l77vDAAYyQdyL060vVQgQUVwbuTcEAJp57ARIZG9AS5
         icvo5pIAQXYvaPkVraHhBR8/w4nfVwkbJkXdy6/R5u43yD03MWHHT3d2TDFXmUKxHEW8
         r+Pg==
X-Forwarded-Encrypted: i=1; AJvYcCW7JytsczSdVMjDIJFRg0t6+Xj/wF/HdAwQxGvC4XDachiuXSSFVptOo9yz+6WIrm0F/Dst7ptqT86vbDq0rzdsa9zzcG2M949/uQ88
X-Gm-Message-State: AOJu0Yz1GanSnoR0NQkfz2wXbw6sfNZxzNsBFUN1BZSRfU9KuwkcGqKC
	39hKjo0Y474Mi8qx056PBdm87IdMPGJ6DKT7KgBMh+J9aeXdUdvVtrgO/yIqnS0=
X-Google-Smtp-Source: AGHT+IFncYLlF2rT6hN0L/p/TQJ5LNx4aKQQWd8sjTrt7kQ6BYHBKX2Y0keQQEflI2wLg+Jl/BzNrA==
X-Received: by 2002:adf:f08d:0:b0:33d:1eea:4346 with SMTP id n13-20020adff08d000000b0033d1eea4346mr7362784wro.37.1709067141078;
        Tue, 27 Feb 2024 12:52:21 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id bw1-20020a0560001f8100b0033af3a43e91sm12539544wrb.46.2024.02.27.12.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:52:20 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 2/2] riscv: Fix pte_leaf_size() for NAPOT
Date: Tue, 27 Feb 2024 21:50:16 +0100
Message-Id: <20240227205016.121901-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227205016.121901-1-alexghiti@rivosinc.com>
References: <20240227205016.121901-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pte_leaf_size() must be reimplemented to add support for NAPOT mappings.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0c94260b5d0c..89f5f1bd6e46 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -439,6 +439,10 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+#define pte_leaf_size(pte)	(pte_napot(pte) ?				\
+					napot_cont_size(napot_cont_order(pte)) :\
+					PAGE_SIZE)
+
 #ifdef CONFIG_NUMA_BALANCING
 /*
  * See the comment in include/asm-generic/pgtable.h
-- 
2.39.2


