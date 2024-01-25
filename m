Return-Path: <linux-kernel+bounces-39185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1B83CC35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B60B23036
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D919B137C4D;
	Thu, 25 Jan 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hptvfnoU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0D135A7C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211188; cv=none; b=K6+S/UTi3Mrej9w/TkIMtUneST3zixpOmbfdArdr3fDC69IOLFuzAEvGTvakZTnuNslIY/QnF9XxUNubm4YrbERoovqQTlgi12mnVio/ZCPYGpwhBaZgbRRsAcowkCAXgWFOzJmMXWlGBHCxW85/zdjGaWlILQeLIQCT/R0WQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211188; c=relaxed/simple;
	bh=5uAgBqwEiFLglbjoaJQbpnDnM9o2m22xBPe3ooue+XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtAiEnb4vdGppPkOSj4WUU7dyK4YxV8nE5RW87eXi6iwVbCRHakTeIq4srh2jn5L8RTdZzLiO4mJy9RU6e3V6ShhEzCzJdjA+57fcPhH9UK19B97L1CBr3XYqGmzRrPW4M5xs5+TX8HbAgaMnAmXNPOY9odpHw6jFfPuSag+RiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hptvfnoU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706211185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xoDgk/IJJhN86dQmOE0uMNXm/1RQ9pxzapPsVBDs3+w=;
	b=hptvfnoUiJel2c4N6KPoRI62f7nNmBG5fOFIxT6a/aonY9g6OreWXaDyxqro+eRiFwcoNu
	RFVVjQ9qbgDAkwIkGYh6HdqrxhgZ2LJXWEj19VQ7Qjr1/dy1x4mhGW9DOeMKugs3Ts5Qke
	v1VdJG9O5SoVp+ojC+sbRJD6fwVMMsY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-Hc8ijM1AMhqR5PNxi6OGOw-1; Thu,
 25 Jan 2024 14:32:59 -0500
X-MC-Unique: Hc8ijM1AMhqR5PNxi6OGOw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F19BD383CCE3;
	Thu, 25 Jan 2024 19:32:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.154])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4BC6B492BC6;
	Thu, 25 Jan 2024 19:32:53 +0000 (UTC)
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
Subject: [PATCH v2 04/15] powerpc/pgtable: define PFN_PTE_SHIFT
Date: Thu, 25 Jan 2024 20:32:16 +0100
Message-ID: <20240125193227.444072-5-david@redhat.com>
In-Reply-To: <20240125193227.444072-1-david@redhat.com>
References: <20240125193227.444072-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

We want to make use of pte_next_pfn() outside of set_ptes(). Let's
simply define PFN_PTE_SHIFT, required by pte_next_pfn().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9224f23065fff..7a1ba8889aeae 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -41,6 +41,8 @@ struct mm_struct;
 
 #ifndef __ASSEMBLY__
 
+#define PFN_PTE_SHIFT		PTE_RPN_SHIFT
+
 void set_ptes(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 		pte_t pte, unsigned int nr);
 #define set_ptes set_ptes
-- 
2.43.0


