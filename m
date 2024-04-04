Return-Path: <linux-kernel+bounces-131834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 237DD898C63
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94AC1B2BBF6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FB7130AE4;
	Thu,  4 Apr 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzHsUmHy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163C130AC7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248654; cv=none; b=T7W1JFWQu3msX6PlJvu81ZSDqgE3ziBmC1WSBCb73VKS10HJnvwEGzv0qWk9E9J+Kkti5PJexlGDSn3WSK6dGT16YDEjH9H0ubdv/P4wFEhYQAXnjo1wKeuG+Zpb4gymqhODS2h1uDWNAiDhYOVojR59/p4NYZGAxjMItfpa/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248654; c=relaxed/simple;
	bh=aCPNbBl5JKNxYSnh7bsg4bMZsFTro2yxg6Wzh277+Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgQSLMOEmobL3fsShHiXQg7/BDPo9PcEsXLbK4+XNTox2DSpBFB3t1z04qku+tuDdxvkr3gblmu6pqzb39MCom29CvPXxdlaF3XChuOzfp/sFq25t716yP3E2pyYCACEZ74W+vjKhbOAscNMVJcvXRulUO4eIlR6j8vRxco/AKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzHsUmHy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712248652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wn9vbDVG4YtRegf5ZBlenhUihh95CLw8Qi8j4juWPxs=;
	b=GzHsUmHyCQoTsB73RAAyHST7A7/syxAUBkvOuoBnPqxte9SXiojxx6yokp62rebPmwSqju
	XnYSCktC7WGrMpCE6O9v8TTJqP22+WBkG4j+OHVVOhwzb11c5qbQRGtl/us0O74y2tMJ26
	uYny28Bq87d0bv68BrFNMfH1hrSSvN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-ZB9ewTULNjmhHBCUXGQC7Q-1; Thu, 04 Apr 2024 12:37:26 -0400
X-MC-Unique: ZB9ewTULNjmhHBCUXGQC7Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D4C688D01A;
	Thu,  4 Apr 2024 16:37:25 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1ADD23C54;
	Thu,  4 Apr 2024 16:37:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 4/5] s390/uv: update PG_arch_1 comment
Date: Thu,  4 Apr 2024 18:36:41 +0200
Message-ID: <20240404163642.1125529-5-david@redhat.com>
In-Reply-To: <20240404163642.1125529-1-david@redhat.com>
References: <20240404163642.1125529-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

We removed the usage of PG_arch_1 for page tables in commit
a51324c430db ("s390/cmma: rework no-dat handling").

Let's update the comment in UV to reflect that.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 9c0113b26735..76fc61333fae 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -471,13 +471,12 @@ int arch_make_page_accessible(struct page *page)
 		return 0;
 
 	/*
-	 * PG_arch_1 is used in 3 places:
-	 * 1. for kernel page tables during early boot
-	 * 2. for storage keys of huge pages and KVM
-	 * 3. As an indication that this small folio might be secure. This can
+	 * PG_arch_1 is used in 2 places:
+	 * 1. for storage keys of hugetlb folios and KVM
+	 * 2. As an indication that this small folio might be secure. This can
 	 *    overindicate, e.g. we set the bit before calling
 	 *    convert_to_secure.
-	 * As secure pages are never huge, all 3 variants can co-exists.
+	 * As secure pages are never large folios, both variants can co-exists.
 	 */
 	if (!test_bit(PG_arch_1, &folio->flags))
 		return 0;
-- 
2.44.0


