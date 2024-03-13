Return-Path: <linux-kernel+bounces-102563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456B987B3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9535B21DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32F5FF0C;
	Wed, 13 Mar 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvkLCuhf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEA956B63
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366464; cv=none; b=aWJXkif0RSY3OSyvmZ2QjWvy3ONu4AImZbwQADrWX3FjZuwMAL/MIHTd9DOdHwj5i7FOs980nkKFX6gNNJIGjbH/6fRgWGjpjb0Oev+MZhoQznsPCNZP2jMHOZzgKWMdcDKhF1xlGP3PDSPsdvvTuBteZHpGr7Vq2GeXm4WJgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366464; c=relaxed/simple;
	bh=5RHxSgtdvJKVCp5Pr7PrdSJPxWg3TC/UA6xoLVOm0PY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpkSGIYCN7Ng/po/qIA+e3wyXIpsWbtukOFfYZTzyD4vxJgoIEIKNydAqp7Tzg6bO1IDKWN5wVaQWPtuGnuEUqwnZzrg/xKvS5BeOmGYKXsd+Mvq5i+0SSQwZpnQoD9jxKr2Grt6D+Y3VVSfm3UuKXS8G+YyRU42RHEVixiYWcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvkLCuhf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4C+lWpN1qDfU+nymiqOVXkY7IqPiijqTb8F5rFjpmTU=;
	b=CvkLCuhfHj10UsAbNOF0GxbqJ02o24rPrbqA06g6qi120ZmnMyegWhYc1HiGVeFmY4Idhd
	j+E2Sjzh6DRcIvGGjwEl5zxhprVrzMebiR1MhGvBNjGbS2jd5LcnLhXEaz8nWXD4Rgz5p0
	XNpWG0HExl06/LKJ5tGBhxfHn6OoV98=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-ztdw1ycQP2eJ8of9CtVaAA-1; Wed, 13 Mar 2024 17:47:35 -0400
X-MC-Unique: ztdw1ycQP2eJ8of9CtVaAA-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7dba4d44c1dso75278241.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366452; x=1710971252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C+lWpN1qDfU+nymiqOVXkY7IqPiijqTb8F5rFjpmTU=;
        b=TeQk+gPjAgMTTreT6CSuqbpLGyYkbaF/ZCXE2juORWRWg00ppC8gS5AO4qMxl8OWI4
         PAGHm51rTu/spz8EgkFsCbUnEIkOIleo3gz/jk6Ph7FZLw48chs7rtXySr+P2gjuFXMz
         24I/hYUSoSKvTJgkAtCTWHuGq8I6+U6LrEQVl5/nO1kZuQoezHnkLmyOz30l0yKWjgwi
         AqTd/IglY96i5A92sX7yZB1KZVkccZu/7eRIcw9dJMPrRlAmNhyw8fbE0+opXzGS/D1R
         JZu8nkqAaqkUY1pGUwkek+LRZI0wM+nc6MAUZGBafK8PNfDrpvC2hKiHR4xREpMn1WpZ
         9H8w==
X-Gm-Message-State: AOJu0YwO0iDvcSN/GsN+DXGFFv+/B5jXVWufMF4VRF966WEVwr/ptQYu
	CCBPCsCfiiAZaCt/klu4TOY5aXRP98rAxGTwMjG+JV30n0Pac+al+nfzPxXVdiyU3k6pdDBLE0/
	sN57s73aCyD+3WVef0YzwxDsYnA3jYgqqWeBpmk26Qp1YQ8Izw+JmvR4O3eUETMne4vzZHosErs
	tPVP3hEpjbHV85chBXUBqOD4wXVTIk+nYQKFm20lMaBUI=
X-Received: by 2002:a05:6102:22c3:b0:474:974a:9262 with SMTP id a3-20020a05610222c300b00474974a9262mr178636vsh.2.1710366452329;
        Wed, 13 Mar 2024 14:47:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHbMJFgovzI2kAdigpD7SPTonoPokqIJ0+3R0neH2rsizaH6LOW92IcmRgIzS4nmmpWup5Ig==
X-Received: by 2002:a05:6102:22c3:b0:474:974a:9262 with SMTP id a3-20020a05610222c300b00474974a9262mr178595vsh.2.1710366451805;
        Wed, 13 Mar 2024 14:47:31 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:31 -0700 (PDT)
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
Subject: [PATCH 07/13] mm/arm: Redefine pmd_huge() with pmd_leaf()
Date: Wed, 13 Mar 2024 17:47:13 -0400
Message-ID: <20240313214719.253873-8-peterx@redhat.com>
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

Most of the archs already define these two APIs the same way.  ARM is more
complicated in two aspects:

  - For pXd_huge() it's always checking against !PXD_TABLE_BIT, while for
    pXd_leaf() it's always checking against PXD_TYPE_SECT.

  - SECT/TABLE bits are defined differently on 2-level v.s. 3-level ARM
    pgtables, which makes the whole thing even harder to follow.

Luckily, the second complexity should be hidden by the pmd_leaf()
implementation against 2-level v.s. 3-level headers.  Invoke pmd_leaf()
directly for pmd_huge(), to remove the first part of complexity.  This
prepares to drop pXd_huge() API globally.

When at it, drop the obsolete comments - it's outdated.

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
 arch/arm/mm/hugetlbpage.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index dd7a0277c5c0..c2fa643f6bb5 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -18,11 +18,6 @@
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
 
-/*
- * On ARM, huge pages are backed by pmd's rather than pte's, so we do a lot
- * of type casting from pmd_t * to pte_t *.
- */
-
 int pud_huge(pud_t pud)
 {
 	return 0;
@@ -30,5 +25,5 @@ int pud_huge(pud_t pud)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_leaf(pmd);
 }
-- 
2.44.0


