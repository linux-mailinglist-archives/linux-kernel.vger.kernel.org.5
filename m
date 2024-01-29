Return-Path: <linux-kernel+bounces-42720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06C840588
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB65D28620E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08064AB5;
	Mon, 29 Jan 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmaNglse"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF963500
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532460; cv=none; b=cqqbzFdeBTPq2jUWlpNE6rtWfjmU/+dskxz0gTl4xa+kujrxmaPK6eiqipfc6lIGf/p4N1FresxpiIdu9rYektsomvZ09YuH+jhYUm5/3Dz6qczxJnS+Higxh46F7gjF03NjQg1mzz6tHwW123MG2Ubj4KALMIK2d2vJ2dvf8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532460; c=relaxed/simple;
	bh=IaFQMczO4hkkUgLS4AhA2SVxrlGS1xTOsrJGXYuJFIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtQSX4yfpkvxxfCsEIx2nogseQBTLcXxpd77MhjFjgi+6ZmS1+rwRwS4640OB/rCthHkhJUtw/4qwpINWxuP+EEWtIrGYUTbtzGV3JmdPQwSCEjeaZLC/D3/4DWRX2GWJODxCwvVS5D7y8SSO994JbHOpx4+kQvLAcoeI1qIjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmaNglse; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706532457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q4tnrwU9nMLq/XRgt5SnLvg5SSqAxaQfTq+KC4Tr5Rw=;
	b=TmaNglseSx373K6jvLJcNeByjoiACIczb2yqndCRGWPBeqbvHdhQyqvr/jmDi5NiIbsSpb
	xn0Xwe7lw7eHqu98RDm2U72Oqh6YsXSgxTjSWGLt9OG95WzrtXJzaOjJs8FjQ3WmRimHJH
	iQHnWErluT0NcqSaze9zLQBBNGn0qjU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-0qzEMwiFPS-I-NbcZuBhSg-1; Mon,
 29 Jan 2024 07:47:34 -0500
X-MC-Unique: 0qzEMwiFPS-I-NbcZuBhSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 208913814E8C;
	Mon, 29 Jan 2024 12:47:33 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.46])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C9928B;
	Mon, 29 Jan 2024 12:47:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v3 06/15] s390/pgtable: define PFN_PTE_SHIFT
Date: Mon, 29 Jan 2024 13:46:40 +0100
Message-ID: <20240129124649.189745-7-david@redhat.com>
In-Reply-To: <20240129124649.189745-1-david@redhat.com>
References: <20240129124649.189745-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

We want to make use of pte_next_pfn() outside of set_ptes(). Let's
simply define PFN_PTE_SHIFT, required by pte_next_pfn().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 1299b56e43f6..4b91e65c85d9 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1316,6 +1316,8 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
 #define pgprot_writethrough	pgprot_writethrough
 pgprot_t pgprot_writethrough(pgprot_t prot);
 
+#define PFN_PTE_SHIFT		PAGE_SHIFT
+
 /*
  * Set multiple PTEs to consecutive pages with a single call.  All PTEs
  * are within the same folio, PMD and VMA.
-- 
2.43.0


