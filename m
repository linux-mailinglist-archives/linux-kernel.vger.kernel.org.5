Return-Path: <linux-kernel+bounces-106599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF83587F0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA8F1284361
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957459B42;
	Mon, 18 Mar 2024 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYpBgvBF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144445821B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792256; cv=none; b=WFuv9i1Tu15f1k17IOum8BN5HIziMojCv8YHe9X1FwEGUurK5JLbNNrfqN8J2pFbC5jQxVTYk6y900tX46SDbl928DTYEV5yL1+qYjlQ6+mecSJrhgdTrsUCMIncPeCe2jKtErfA4fbvRTtV9FSDQJzdALhhIHKxXBeepsKlDWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792256; c=relaxed/simple;
	bh=XKAmzhpmXEAjAsa42PYgBQQ2HzrzYrw3Lh5/ehBy8nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J24YHZOnudDb8KLcqGVr0KwAXx6sV+cSvyFwFG9nyyvLRsZBG1A0Y67JZ9CmVmhTGnVpdIY/FQVSKo32Rz0Jix6jLx56pIGmWGwz7SUcp7S0O6AlTOYMivvQ8JA5ouXVO3+CKM3EmuzfdRUCPIN5sXCSi6muAdKHEKlEFyjgVqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYpBgvBF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
	b=CYpBgvBFBU7+pUOX2fRSsN+iwKKjs5LAFpibov9hLuYTaX6SyA6c4pIjn2RD12StG0eT3b
	+bh0VC7tgFbLc154GOo9pqtDWBSBwL+k2r5KylW+n7Ij96OjNTBBqvFZJQuOIet8jbFjpC
	sFoty/bJiHt5QJXYwXNd40P3BhAKpZE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-qVsjrnXYP1CgWOBHWBTaWQ-1; Mon, 18 Mar 2024 16:04:11 -0400
X-MC-Unique: qVsjrnXYP1CgWOBHWBTaWQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-430b4572a97so17522751cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792251; x=1711397051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OThRyXZFMjugEtcpgf//pX/PpGcoxbD3wNFnQts0Kco=;
        b=jKe+zlehpdU6c+Vkm8FPxBNj2bnr2ymoN5IugdU3lhYAR/mATMz0qVeqnhVcT5WgOG
         cD88dyrlpAtzgyeplDzY5TP8Gr94Hu2nNoKpqaqSBCcJ09YBrUs1vrrCisM66lLCS6fi
         rEOHeBH4xJyR104ThqVtWlO5rRgZ/Bn3KhpPFjv/c1QGuqV5gJJJ8budvgD5370WEsfg
         F5oCMx04oc8RI5K0jwPpl/Rqg3GH/gg7wUrhkqUs6e9I6eZF62L79b88Wo27vIRRB0f9
         Bkr/zcIAwhNx89MkZSP5r0owMUrqAtT05RGROKQiuFuu646gNX+YzO8yZZ4Zb1Zxivdz
         XBpg==
X-Gm-Message-State: AOJu0Yw/2zd8vjFRbEiCBc25Swyt/cxvMRFI8Myyb0jeLLQ6PYxCOqdv
	P7jmTv37/VIlBnzQIO5n+PWTCYTdlIdRPfI3jrSBllDjyg4+rWUyLVXWvpgB/ch4yQnrooAWqrX
	Jm+LKSkGtVN9oxZTf5HJJvnp5iySQhG8WvXzBL15hIIb1ffv+QyJd0ggAhXriDtxGWCiNYxR5gG
	htz8+NW4IRuYD5qL4GT+TBcG06Ix8YJB20q2nQ9nqwt1M=
X-Received: by 2002:a05:622a:100b:b0:430:ace8:9801 with SMTP id d11-20020a05622a100b00b00430ace89801mr13041024qte.1.1710792250936;
        Mon, 18 Mar 2024 13:04:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3lB75/Xyi/Yr3FGp4iv8P5rE4DSC0aUJAJLEw6DejnKFtl7A4ZV0qXSchssNp4WRDw4IDoQ==
X-Received: by 2002:a05:622a:100b:b0:430:ace8:9801 with SMTP id d11-20020a05622a100b00b00430ace89801mr13040968qte.1.1710792250407;
        Mon, 18 Mar 2024 13:04:10 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:09 -0700 (PDT)
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
	peterx@redhat.com
Subject: [PATCH v2 03/14] mm/gup: Check p4d presence before going on
Date: Mon, 18 Mar 2024 16:03:53 -0400
Message-ID: <20240318200404.448346-4-peterx@redhat.com>
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

Currently there should have no p4d swap entries so it may not matter much,
however this may help us to rule out swap entries in pXd_huge() API, which
will include p4d_huge().  The p4d_present() checks make it 100% clear that
we won't rely on p4d_huge() for swap entries.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 69a777f4fc5c..802987281b2f 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -776,7 +776,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
 
 	p4dp = p4d_offset(pgdp, address);
 	p4d = READ_ONCE(*p4dp);
-	if (p4d_none(p4d))
+	if (!p4d_present(p4d))
 		return no_page_table(vma, flags);
 	BUILD_BUG_ON(p4d_huge(p4d));
 	if (unlikely(p4d_bad(p4d)))
@@ -3069,7 +3069,7 @@ static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned lo
 		p4d_t p4d = READ_ONCE(*p4dp);
 
 		next = p4d_addr_end(addr, end);
-		if (p4d_none(p4d))
+		if (!p4d_present(p4d))
 			return 0;
 		BUILD_BUG_ON(p4d_huge(p4d));
 		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
-- 
2.44.0


