Return-Path: <linux-kernel+bounces-102557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB287B3D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA372878A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EABF5E083;
	Wed, 13 Mar 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1m7E5Et"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899995C8FF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366455; cv=none; b=m0aPMWd1anvX2ktaqfquHNvbKc7S66LxKjm2euN+4I6eJzw9jE5Cu8VCq55wUfOCL7HMR1InD16u76WS9TJntXGT340g0tN/NAy83hxetrjJM+0kca04GNPwWaAZR5qiAurL7Nkwag5fu46HcBZler7so/LUJQE7+AGbFe1QUNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366455; c=relaxed/simple;
	bh=udgt5BojDZ8EVWkeL4uhl2LfvjHvU9M2T020easV1nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8cI9zjZ7G9Lcolr8HGnntdneiC2bD5uC9v9CrBvAFCxCjUqS1I43JxAIidUFsZ+ED036Fm2nTRvnpklr7MOeWym+dGc92S1yb7qHUW4Zi5vlOLb57KHfNKcGt/bMSm53rS/wCvrrb+kUSVdw3cyyKVmDd1LLAXPoP6e5Y3jEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1m7E5Et; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXv9WADGZnpW9LG755UO1HRR+yBh/xYRmZG+iRDILn4=;
	b=N1m7E5EtoD45RmFLL1vaVjkpqyolkGFwfJo7NpA8diw6gJMRPPpWuSLArHe1r/2JcFPz7H
	McUh9aC6+ZCxTe2oru++pBkikRyuKCNTRmGG7lMq86TgKxVmml/QLBUcJoGYR/9167nn7c
	ecCecrp7oGvrLCyOCUrc5eTB/vgo64g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-ehrb1XLuPpKqOLu5N0exqg-1; Wed, 13 Mar 2024 17:47:31 -0400
X-MC-Unique: ehrb1XLuPpKqOLu5N0exqg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690d3f5af86so1063866d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366451; x=1710971251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXv9WADGZnpW9LG755UO1HRR+yBh/xYRmZG+iRDILn4=;
        b=hUsfKYuk1ER4KcwZsvNrBbQOiCGzOZJGugZcofh8JnP5dtoRWIzyNF2N7T3aHfW7QL
         bcNBfekXI6zkjaxVlI4ueIxHmlK4pFGvY4kVFMqPOJ608NQEC+93SmmBFUW6Ugpnephv
         9SLY1HxmcKy2LoxMlIrRhm252Qg8vmskN1kgixLjwVrFDMhDTjBhsATAUistfTuwD6xL
         iB6TUUx01nlF5uYb60ncO50+EpnZgPOJMeK7bgMyus8iRM5JFrDWAhCIfKMGmy8E1nBO
         cnG7aI0aO65k1rKmVrNk8PrKme3czOix3xt9NacOMNWGlrQg5sTvxG9taqxT4UGykzzr
         jaHA==
X-Gm-Message-State: AOJu0YzNaFrtQyNurAONLydsqi3yH+/gG8Z1MQbiHbyuSqgHE7iQBQYI
	wZl87RzNTr2JU34XLBptlatJ88z/EtXO940k7xinTMyxETSLjneqjkXPkPb7V31ih7vVI74S9By
	X+5C0tc3DiXWvSCcBLyAp0q59JutRVaOmjTllz9g0aRsoePO96GQhEhxzuSOeC5AvT89PFxeQKK
	p+deXW6DruXWuApPADZ42GBNVyaAM+4KWxzyK9+zAWOPY=
X-Received: by 2002:a05:6214:ca1:b0:690:ca31:f070 with SMTP id s1-20020a0562140ca100b00690ca31f070mr2870237qvs.2.1710366450742;
        Wed, 13 Mar 2024 14:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7R1Abf8N+n3Ay4Ttv5JPf4Xs41/taFQJ/1rB/5tSFgWpT6oJW7WbEayo47shzOXV0M53hEQ==
X-Received: by 2002:a05:6214:ca1:b0:690:ca31:f070 with SMTP id s1-20020a0562140ca100b00690ca31f070mr2870205qvs.2.1710366450230;
        Wed, 13 Mar 2024 14:47:30 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:29 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org,
	Matthew Wilcox <willy@infradead.org>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	peterx@redhat.com,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 06/13] mm/arm: Use macros to define pmd/pud helpers
Date: Wed, 13 Mar 2024 17:47:12 -0400
Message-ID: <20240313214719.253873-7-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313214719.253873-1-peterx@redhat.com>
References: <20240313214719.253873-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

It's already confusing that ARM 2-level v.s. 3-level defines SECT bit
differently on pmd/puds.  Always use a macro which is much clearer.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Fabio Estevam <festevam@denx.de>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/include/asm/pgtable-2level.h       | 4 ++--
 arch/arm/include/asm/pgtable-3level-hwdef.h | 1 +
 arch/arm/include/asm/pgtable-3level.h       | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index b0a262566eb9..4245c2e74720 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -213,8 +213,8 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define pmd_pfn(pmd)		(__phys_to_pfn(pmd_val(pmd) & PHYS_MASK))
 
-#define pmd_leaf(pmd)		(pmd_val(pmd) & 2)
-#define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_leaf(pmd)		(pmd_val(pmd) & PMD_TYPE_SECT)
+#define pmd_bad(pmd)		pmd_leaf(pmd)
 #define pmd_present(pmd)	(pmd_val(pmd))
 
 #define copy_pmd(pmdpd,pmdps)		\
diff --git a/arch/arm/include/asm/pgtable-3level-hwdef.h b/arch/arm/include/asm/pgtable-3level-hwdef.h
index 2f35b4eddaa8..e7b666cf0060 100644
--- a/arch/arm/include/asm/pgtable-3level-hwdef.h
+++ b/arch/arm/include/asm/pgtable-3level-hwdef.h
@@ -14,6 +14,7 @@
  * + Level 1/2 descriptor
  *   - common
  */
+#define PUD_TABLE_BIT		(_AT(pmdval_t, 1) << 1)
 #define PMD_TYPE_MASK		(_AT(pmdval_t, 3) << 0)
 #define PMD_TYPE_FAULT		(_AT(pmdval_t, 0) << 0)
 #define PMD_TYPE_TABLE		(_AT(pmdval_t, 3) << 0)
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 4b1d9eb3908a..e7aecbef75c9 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -112,7 +112,7 @@
 #ifndef __ASSEMBLY__
 
 #define pud_none(pud)		(!pud_val(pud))
-#define pud_bad(pud)		(!(pud_val(pud) & 2))
+#define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
 #define pud_present(pud)	(pud_val(pud))
 #define pmd_table(pmd)		((pmd_val(pmd) & PMD_TYPE_MASK) == \
 						 PMD_TYPE_TABLE)
@@ -137,7 +137,7 @@ static inline pmd_t *pud_pgtable(pud_t pud)
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
 
-#define pmd_bad(pmd)		(!(pmd_val(pmd) & 2))
+#define pmd_bad(pmd)		(!(pmd_val(pmd) & PMD_TABLE_BIT))
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
-- 
2.44.0


