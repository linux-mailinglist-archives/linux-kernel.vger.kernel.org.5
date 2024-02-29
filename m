Return-Path: <linux-kernel+bounces-87682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E8386D7AD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C1F1F23318
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBBE14567E;
	Thu, 29 Feb 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gLPBsPMW"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BC74BFE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248946; cv=none; b=RrUJKFnjCQTjklwy7TH3bBJCJjy01Vkpie6jHcDiF/8Y0K2gXIWNyrFQuB/pwdFDDgFduBXS3Y9Eur0nXnxAgQ8SJzsZd4KbhFc13Vszf2eMZMuR46DAzdVZ+GgNfRGAfLuD5eB1a5hz7YxpL4sL5DRVtXU70VNfTlou90jSODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248946; c=relaxed/simple;
	bh=G1BXM2z6rQBc5K4wZw4N6I/e+joRY7yH/Z0Jdaxm+no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgxFmdpuIO+eFqXlFlrSUm9UHNSJex7e9vw4juT0QICltwsr7BDjKs5yNoYS5OLz1IqdKv0xKYpVpT4pQi1tehIPcNF42xDeymVtnVz2y2+FMVjxvA/OjhpysmOlAV0pTGC3rInMrGshY3K5D/T2bas2w7cg/8LUKca1JV8CRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=gLPBsPMW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e55bb75c9eso1336260b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248945; x=1709853745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wFLc5gcnBs285NRnicKVmmQVV53EnA/2rANcUM2uCA=;
        b=gLPBsPMW5tbj3NNZa7yyp9h+BFyIBw958P3oU791RdPlMGHM6i9bHaDXg9MjJQwH8h
         B+9Um0TXzck7yUGL2G6fMNG+GXID+epbq1SDC5PlO0DQpG3scIxABxZIVUI6c90mUd/I
         HFJ67HfX1QSZgxgDASlbHuVyj6tE6TTpLkhT0KJ9a71tmeLcn2vz5H3xrxj/7Xj/3NBR
         sON03IgHbXlNJUtrZk+aWESptb5RIbQkPObsJ1tAQHejb2VjaKjO7BV3Swaz8xW2ZjmD
         YqFkf6jY/GqZDGHyB4r9/9NuwfPKM0ZB0mL84hxVWbZDCgE3nMeIqn8RPA6l6cgIBNm5
         jJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248945; x=1709853745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wFLc5gcnBs285NRnicKVmmQVV53EnA/2rANcUM2uCA=;
        b=wkfv1j3MkB1ZL3M/nxe2es6ls7VD90/PI56q17aESviCqa3i0mchRBshxw9UbR+2qs
         XzY1gBCcrbDHjaP7pgySo+1sv5Oi5ZqnGBDg9RsprUlBymVdLgO9RkxTyhS42nXILaQh
         aFtwpOURs1Nxc4flXQxRUsReoUomnHAb+l+NtDWBm8W5zY4/gnTszQVwK36dgZa5JYpJ
         0tom+AWvAK+0u239eiA8X3Zv+tloS4XvFNrZqG2kyeDIQhqROJTbmtuRLrg1+fVzhLrk
         a5LoUyH7dBgrxENo/FB8bw6Fgl66LgaQ3TirZLckkYkJlCC+3WI4MYf6D3LDkbj7DiUk
         7Z1Q==
X-Gm-Message-State: AOJu0Yw7QqCzI91rJM+y/6gSXh9HXdGJK4IL4o5Uq6xv2NS+ExRBrt7l
	83SLi3+LbsBiS2KcYVxM5aVQ/dYn7jT3ngiE9sdtq9o+0Ggp79Xn2eFtRa9pOHA=
X-Google-Smtp-Source: AGHT+IHQJB+ROn7vFDGIQNWMDCSQS4WpsKXvgO9ytwgYp+s+V0Upk9jrJAXqE3yMlwAjPHhZUdgCcg==
X-Received: by 2002:a05:6a00:3d42:b0:6e4:eee0:5798 with SMTP id lp2-20020a056a003d4200b006e4eee05798mr179957pfb.14.1709248944849;
        Thu, 29 Feb 2024 15:22:24 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:24 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 11/13] riscv: mm: Make asid_bits a local variable
Date: Thu, 29 Feb 2024 15:21:52 -0800
Message-ID: <20240229232211.161961-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable is only used inside asids_init().

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 5315af06cd4d..0bf6d0070a14 100644
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
2.43.1


