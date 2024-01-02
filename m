Return-Path: <linux-kernel+bounces-14920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC2822476
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CDFA285724
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF608199C3;
	Tue,  2 Jan 2024 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fq3hbOFI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6F199B3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bc7155755so3952305a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232907; x=1704837707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8uQuAx5HbeGrqX4Ip/qQY7nv6lrxw4qacCJFbpKbko=;
        b=Fq3hbOFITwhrCF1xo3JKafxvDiY2hTS9MG3k7e4U6FsfOrftpP2sgWuYYotBePj36L
         r7sCj50iDICiKIuU1qwmr09yvMpY20VBxLYXG6yxBqvnvwQPjeC0V7wW6LpAEulpXfiE
         v3Rz8ObmvE59Bu3mCceu1lmwgUwSHxmcM3KheDBO2Bmz2pZ00PTqqqC/NBcNH2AGHXrt
         ND4lYHzancP0+KLfkwpx7ENF8Yp1DWN4O9hCWx2N3pse78IR1KJZszpuBAtog0GqQ1M9
         IIHzSvnEP9FlF50k0LH9O7g8vqLSyjk/7xHMrW4TFcp5v9AsH5gaJ73h2GIzwZb6UHoj
         vzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232907; x=1704837707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8uQuAx5HbeGrqX4Ip/qQY7nv6lrxw4qacCJFbpKbko=;
        b=aiYRk/sAsIbXlwN2X6acgr4GekvqfPejipnlsTraEbESE0JsuRhKjP0ZfgNPH2pLId
         JrkrBroK4KvwCSNpSBrQnZqYA87pR8VldWoNc2fLvmcSHwbjwZT1UgOxWYlOhCg55zpc
         AKFnPTLXuCopmurQVyTePWO49C6GkqsNWQteuJtntoRB3gwVHzoHQOGgmytlwe5LIx9w
         H2RfUP+3iZuc/eXehSonT98k13J/ezCNWZRavWpv+KLnYDePJO5TKZ6LNI+xtte113Gx
         XxtlAe7n53zjVhIauTU7UpQUwcuOt+AXAWMTpScjBtNX07uE8Vq4H3cpnQruOiE/CzDe
         b5oA==
X-Gm-Message-State: AOJu0YwC0s7Hbc9S/XXeGyZTNRlbMZC3fMjmmPwJn6M40U5leNSMeRdm
	zPbu7CAwxVoD1RAW4bNWdS1sVjbfi1EiUkgbFEq0z2pD/Zs=
X-Google-Smtp-Source: AGHT+IEU78MnSVmG+tTKoY5SsP+KmgJHfZS8cB0cAVh744mS+tR8J0bWreXJl70FWHY5n2NbigpZXg==
X-Received: by 2002:a17:90b:33cc:b0:28a:f2cc:e008 with SMTP id lk12-20020a17090b33cc00b0028af2cce008mr6619129pjb.54.1704232907387;
        Tue, 02 Jan 2024 14:01:47 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:47 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 10/12] riscv: mm: Make asid_bits a local variable
Date: Tue,  2 Jan 2024 14:00:47 -0800
Message-ID: <20240102220134.3229156-11-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable is only used inside asids_init().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index b5170ac1b742..43a8bc2d5af4 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,7 +20,6 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
@@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	unsigned long asid_bits, old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
-- 
2.42.0


