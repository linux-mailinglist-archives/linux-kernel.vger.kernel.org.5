Return-Path: <linux-kernel+bounces-106609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3395987F0E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613D61C21C28
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3214B5C60A;
	Mon, 18 Mar 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4Ep7v3T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09F65C03D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792271; cv=none; b=ZmkMw5KajThPkBpyWqNvgdDEdue1cgNaU0j2jRcg3F2S3YTEFY+wmEz7UXP3FNmW1x2o7Yhzc+remIZD+5TAn0o7KNHP3dIhRqfTiRlJEpvDIj08s/P87HRZd9EIOehN2dZyF8vW86dDu53g5qFkwPxRv8jCKHgb97TsGj8l22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792271; c=relaxed/simple;
	bh=ojVmr5RD35FTPLpAqjeK88wQPTEg2L/XUu1gv37ZNsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYxNGr8Txa1TI27i+k2+DdqmyQ4hNDh4WtB1RxU/nAkfFYZ8Nt8mT/Ex6Vh0FO9ws+Lm+pk+oxPFvWHj6h1km6yA6NZ+SOmn4+F6JxG6CN+fcT6cLGIKruDrXXZcoCqH2t50ty8RGuggKNIMR+AQPVGuEo15nYwULiloDQFbOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4Ep7v3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXDMCLhq+SpXi29RlzCNqEUhIAFpzfV1ImIXAFsvuS0=;
	b=L4Ep7v3TjjUmVZvPyHytKh9PvQ1IHGfW6QsXsWdGxwfFi5vdZkhcKDDHhlHP2cIBdnGHre
	svhSUe6vsX2b3BXxzqs41/INLYooaCOwzAuCsX3yXe6zqfr6N9wIJ0gJqbA9WbbQwhYmxN
	VIruHyyG8J3Ub2jfDX/ttuxN230cvJE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-2pk3gYkzMgK9sh7u--y8WA-1; Mon, 18 Mar 2024 16:04:27 -0400
X-MC-Unique: 2pk3gYkzMgK9sh7u--y8WA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-430b9ee6bfbso6674891cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792266; x=1711397066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXDMCLhq+SpXi29RlzCNqEUhIAFpzfV1ImIXAFsvuS0=;
        b=Zl0d4gm87esGYI6GzRhk7Uk4xBERi8yHTlGSil5FTAqRF0+/LXaouoB+hOqCSTo2QA
         LBwfLvHKSQlT10jlOg7BTkNoPyDH2gK1XPiidPzzh28m1GVWO41Ku3ZdWsyR5Ug/yKeQ
         ++F0Uz8XaELpftyrN0LHc9LKdylUYqEdx15D+5yrEeu7/t+Tv2OvTNw8MTByKQaCv8ay
         bDtMgJSWyBwRkw0+WT1WnEb/6gwT7z7TPPufiEHTTndBddhk6ahEYnPhMN72s2g17HVk
         5+urrCln5InbH+UMSePpwowBVOq2PnAMUkNnro5YcYEAprRb3lN/Qr6ciSNGz/DcvODi
         sn3g==
X-Gm-Message-State: AOJu0Yw4GLRbOeUPlm00foG8YJ4H9X7SrmImIbOSUGH2M1T8o/FbPoj1
	kmiSs5Kc1JqTm64WX61gBAK7mLj4bdd1hzxflr/du8gT5b1+1nawrGgQz4NyeN/Gp3qXqIfaHLu
	oWFxJ1rBhzoJeTRq3XEPMek/oITemIzOAzK7xCsJlUHjSy7J2d3QFImSyB826hPMBglglLT9zp8
	hYOCj6HH4MmNRba8Va4S6gUsRJjH02FqcCop6kl0OsR2w=
X-Received: by 2002:ac8:5f91:0:b0:430:c2dc:a5ef with SMTP id j17-20020ac85f91000000b00430c2dca5efmr447862qta.2.1710792266608;
        Mon, 18 Mar 2024 13:04:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBYHTFmkqNiU+ToXou6wXh4FVDhWI9gJPxxfj+3GqwNDwAz7q/kbYXHDobvjaQIuNomZFyOQ==
X-Received: by 2002:ac8:5f91:0:b0:430:c2dc:a5ef with SMTP id j17-20020ac85f91000000b00430c2dca5efmr447812qta.2.1710792266091;
        Mon, 18 Mar 2024 13:04:26 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:25 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	sparclinux@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org,
	peterx@redhat.com,
	Mark Salter <msalter@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2 13/14] mm/arm: Remove pmd_thp_or_huge()
Date: Mon, 18 Mar 2024 16:04:03 -0400
Message-ID: <20240318200404.448346-14-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318200404.448346-1-peterx@redhat.com>
References: <20240318200404.448346-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

ARM/ARM64 used to define pmd_thp_or_huge().  Now this macro is completely
redundant.  Remove it and use pmd_leaf().

Cc: Mark Salter <msalter@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
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
 arch/arm/include/asm/pgtable-2level.h | 1 -
 arch/arm/include/asm/pgtable-3level.h | 1 -
 arch/arm/lib/uaccess_with_memcpy.c    | 4 ++--
 arch/arm64/include/asm/pgtable.h      | 2 --
 4 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 4245c2e74720..6b5392e20f41 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -241,7 +241,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
  * define empty stubs for use by pin_page_for_write.
  */
 #define pmd_hugewillfault(pmd)	(0)
-#define pmd_thp_or_huge(pmd)	(0)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 9e3c44f0aea2..fa5939eb9864 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -190,7 +190,6 @@ static inline pte_t pte_mkspecial(pte_t pte)
 #define pmd_dirty(pmd)		(pmd_isset((pmd), L_PMD_SECT_DIRTY))
 
 #define pmd_hugewillfault(pmd)	(!pmd_young(pmd) || !pmd_write(pmd))
-#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define pmd_trans_huge(pmd)	(pmd_val(pmd) && !pmd_table(pmd))
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 2f6163f05e93..c0ac7796d775 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -56,10 +56,10 @@ pin_page_for_write(const void __user *_addr, pte_t **ptep, spinlock_t **ptlp)
 	 * to see that it's still huge and whether or not we will
 	 * need to fault on write.
 	 */
-	if (unlikely(pmd_thp_or_huge(*pmd))) {
+	if (unlikely(pmd_leaf(*pmd))) {
 		ptl = &current->mm->page_table_lock;
 		spin_lock(ptl);
-		if (unlikely(!pmd_thp_or_huge(*pmd)
+		if (unlikely(!pmd_leaf(*pmd)
 			|| pmd_hugewillfault(*pmd))) {
 			spin_unlock(ptl);
 			return 0;
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c4efa47fed5f..a580068a6564 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -512,8 +512,6 @@ static inline pmd_t pmd_mkinvalid(pmd_t pmd)
 	return pmd;
 }
 
-#define pmd_thp_or_huge(pmd)	(pmd_leaf(pmd) || pmd_trans_huge(pmd))
-
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
 
 #define pmd_mkhuge(pmd)		(__pmd(pmd_val(pmd) & ~PMD_TABLE_BIT))
-- 
2.44.0


