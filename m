Return-Path: <linux-kernel+bounces-24328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72982BB11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE85289C38
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C139F5D72F;
	Fri, 12 Jan 2024 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmI06ffq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442A5C91A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ecfd153ccfso111528997b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705038789; x=1705643589; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3jQidOKSMiiXlthXl3syuEmjTW2A6fx8EoTn/KG4frI=;
        b=jmI06ffqgLtkLrkFmuLL3CQ5tuHVBBemfT840F8Fm7gXfRcPewemmPxH25ZZw8aYWl
         uyLRVtW4Xy+diazx9eohunng8RfXzbyduFVhaU5DW01G2LEA8NSdEBYHTHGLNpPUc1xc
         V/xnYjVPLtFBcljybTDpt5cYidifoLir8LDNXzKAp2MswJCROXLq/2cEl8KKyzEdPgyX
         K/uFY0DdDfWu7bn7W6PwcwQSTULDmL/nB4s7Lc8Ku/IdvX46eCkTWjrtY59a/tq0RwKI
         sQTxiUbE7C6a0lBTkDu7AzzBGuYzt0RAOHvp8VmFwVGRNHNL/K2HOjQOHCATrxLEsgwb
         tE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705038789; x=1705643589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jQidOKSMiiXlthXl3syuEmjTW2A6fx8EoTn/KG4frI=;
        b=WX1u7B3ARBi5u9K7QETm07+TCcEe6s5+Ymjw4s/Pen+JnfVeSfykuONT6SMjI4lqR4
         o7CCqZcLwPBR3592p5JQu/7Q1m62NCwLwc4+oeXZoXYWZ4O1y0o3TujO7iexCWQeIPGW
         aM1ycEvCf2cDb4+PLp4Og2nqsmDFfcdZD+T0jCcIN7/6/2t69JvNMJTL25wy9U7zbim0
         u/n1hpqoSPrPKGFis9EjF2UOLa+hvL/u66Go+utnDSM8WX8grIvSIKrV2br+oHgV1MA9
         qWJGCd1gr0aPGp2ikhMIqmZjbv4/3v5g20LMZT8QJIkQK2uzAeuPNTcxkZ8G5P4M4K1H
         3DNQ==
X-Gm-Message-State: AOJu0YymoZrm6kCVMFhvZUHQh/pP8yC9TmsG5qys/Tq2n5TPniY3/cge
	mWTQsdq6uSeVeP6aYUWK4DJ8q55Ia2QbxpbyHiYfwbA=
X-Google-Smtp-Source: AGHT+IHKtqhJvPuX99AmjEPzIekAgNij/RFYGidlE8shwCwScd2W0RcK+2eNPVzJk4tEIt4roua9lsBYL0xT4CjS
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:43a4])
 (user=vannapurve job=sendgmr) by 2002:a05:6902:168c:b0:dbd:4683:21da with
 SMTP id bx12-20020a056902168c00b00dbd468321damr154755ybb.8.1705038789001;
 Thu, 11 Jan 2024 21:53:09 -0800 (PST)
Date: Fri, 12 Jan 2024 05:52:49 +0000
In-Reply-To: <20240112055251.36101-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240112055251.36101-1-vannapurve@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240112055251.36101-4-vannapurve@google.com>
Subject: [RFC V1 3/5] x86: CVMs: Enable dynamic swiotlb by default for CVMs
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com, rientjes@google.com, bgardon@google.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, 
	jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com, 
	vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com, 
	michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, andrew.jones@linux.dev, 
	corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com, bp@suse.de, 
	rostedt@goodmis.org, iommu@lists.linux.dev, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

CVMs used SWIOTLB for non-trusted IO using dma_map_* APIs. This series
will ensure that dma_alloc_* API to also allocate from SWIOTLB pools.
Initial size of SWIOTLB pool is decided using heuristics and has been
working with CVM usecases so far.

It's better to allow SWIOTLB to scale up on demand rather than keeping
the size fixed to avoid failures with possibly increased usage of
SWIOTLB with dma_alloc_* APIs allocating from SWIOTLB pools. This should
also help in future with more devices getting used from CVMs for
non-trusted IO.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1566748f16c4..035c8a022c4c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -884,6 +884,7 @@ config INTEL_TDX_GUEST
 	select X86_MEM_ENCRYPT
 	select X86_MCE
 	select UNACCEPTED_MEMORY
+	select SWIOTLB_DYNAMIC
 	help
 	  Support running as a guest under Intel TDX.  Without this support,
 	  the guest kernel can not boot or run under TDX.
@@ -1534,6 +1535,7 @@ config AMD_MEM_ENCRYPT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select UNACCEPTED_MEMORY
+	select SWIOTLB_DYNAMIC
 	help
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
-- 
2.43.0.275.g3460e3d667-goog


