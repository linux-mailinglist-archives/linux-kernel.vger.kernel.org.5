Return-Path: <linux-kernel+bounces-102556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64D87B3D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197551F240D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEE55D749;
	Wed, 13 Mar 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2IlR0K8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB85B5B3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366454; cv=none; b=tXYT307L3756Iui4bXVGlDU8KOjwiws/IiSEUC3QwCbijggC2yWg4AMN26JP2YGagdAjplwe9bOMuLBq8oaM+4sq7xhr7TBsp/G6xkNHQoQlTjSutCcnpgeoUfbXG8INjKqE5H7dYsxqngG95W8DFkQLRI8J0wdvowZh7b2gWQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366454; c=relaxed/simple;
	bh=iHHSvsdkBOFub0mcOT/89y75sePdz9RiRVPlZT5QMlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs0jdTS/5TLzBATcQZOeD9hjYppZooAQMGYwydHIpPMs+WVpT3EIRkmwTYtcRUQOwIPiSQacfI6YERCiRyYPwW73N0RWsgp8Y+lfpp9pXSRCiFaPJ/iNPCBg9TCpiCV6+6st8oo5F0RQUbCGEqCs7LNbyjzXT5+ZvXxVLfU7YAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P2IlR0K8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
	b=P2IlR0K84nDCgmP1WJjwbOsn+gTdiQILbzCsPKvOobYhmTwi7kYaKk9Yoe9mczZZL1WyYu
	DpIt/fh8L44JjLiQfLkxdRNRjliaEHOWUDBKER4tejwcPRs1bEwFY3othnzVESqutzVp2k
	m/PrkAszulQGftaNChH0SxP+53NDNvQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-_co-MWh7O4qEweJqzb9u7A-1; Wed, 13 Mar 2024 17:47:29 -0400
X-MC-Unique: _co-MWh7O4qEweJqzb9u7A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6818b8cb840so989136d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366449; x=1710971249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXyJDuJosTa0kFBnhKvW1aqbtapsaxz0OHU+bPr+fnc=;
        b=MNyIXYIxtzXQgcFOKyjk1GK9ACK/eCho5j3khh7Wn1K/F49ETcr4H6CqyhQtqDpe/2
         /KteVrQlwSde3nHN+F5E2PK6M2rzgi/jA4vnf9pev4/SxK4CNo8QO18pjcPm5yUQfJDy
         bMq7H5WWw9ylPhCA6PB66Eo7HrmeeHH3mNGzTKu0GMP7rJ1Uu/KrWZZqj3ati0gbnKRz
         2QswKTviNa4uLO7EnePUNSatjtTI1dcufnEJDeKNPMEUL9dXXusL8Y0+fpafVutuShV+
         W/a0/CNGkWyeKBhXGns3mjP4hrI8vlKOkEcCPrH70bHZe/2mTSW6iSvqnvzMCgd2BNcA
         5MRg==
X-Gm-Message-State: AOJu0YwLYeWJeE9ikVzlxd+5AcCpzDmLt8Nu8IhEFjzHdSLsNVP7rND8
	rGIVJZ2KZLweC2vq8++oNcVgfDkNMGc1bS2NhsklA7+32KTndZn0BW5jgK4aFLiyXjjLbAQ+9FE
	ghWndXIbJLyiF35qQUS/WphYfq6zkERlRs9VZ3Q2nqQgOAACZJcHNYFqhPQ/YA/6EnQPCq+55t2
	QkgaOX8nr4DbT3EGfZBcS+R5wiRe4Y0s3ZgBEkjQq1g5o=
X-Received: by 2002:a05:6214:aa7:b0:690:d74d:7e6d with SMTP id ew7-20020a0562140aa700b00690d74d7e6dmr2881514qvb.3.1710366449061;
        Wed, 13 Mar 2024 14:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELbWWxNSgYU6xiV6giMb0Xazy3M+lqNjbyiI8S6tM3m0hmfGtXABqH+Dtrq87Nz5UyrTDJQA==
X-Received: by 2002:a05:6214:aa7:b0:690:d74d:7e6d with SMTP id ew7-20020a0562140aa700b00690d74d7e6dmr2881487qvb.3.1710366448612;
        Wed, 13 Mar 2024 14:47:28 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:28 -0700 (PDT)
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
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Subject: [PATCH 05/13] mm/sparc: Change pXd_huge() behavior to exclude swap entries
Date: Wed, 13 Mar 2024 17:47:11 -0400
Message-ID: <20240313214719.253873-6-peterx@redhat.com>
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

Please refer to the previous patch on the reasoning for x86.  Now sparc is
the only architecture that will allow swap entries to be reported as
pXd_huge().  After this patch, all architectures should forbid swap entries
in pXd_huge().

Cc: David S. Miller <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/hugetlbpage.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index b432500c13a5..d31c2cec35c9 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -409,14 +409,12 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 
 int pmd_huge(pmd_t pmd)
 {
-	return !pmd_none(pmd) &&
-		(pmd_val(pmd) & (_PAGE_VALID|_PAGE_PMD_HUGE)) != _PAGE_VALID;
+	return pmd_leaf(pmd);;
 }
 
 int pud_huge(pud_t pud)
 {
-	return !pud_none(pud) &&
-		(pud_val(pud) & (_PAGE_VALID|_PAGE_PUD_HUGE)) != _PAGE_VALID;
+	return pud_leaf(pud);
 }
 
 static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
-- 
2.44.0


