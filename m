Return-Path: <linux-kernel+bounces-93799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47DE8734A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1307A1C20988
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4733860EFD;
	Wed,  6 Mar 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JnPj9dUJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBE260892
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721826; cv=none; b=HvE5Rb8YRNYKpJ8Pn0WwyLKhn/VWHcTSSPmENKUY1rjNtc86KuT6MgqW8YfXC0u4dfc5B0LYufXNO4TzQNTJC27/Nn2A6980O442YvVtPKA6FSEPy6xohBUt72sr8K4ctcPgbUMOLLxEgbz9mgcrHTvc+OVXJ1fz22E94tXVTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721826; c=relaxed/simple;
	bh=c49fwyRKoS6wfKvCgxkRGT+RfTOSzCUnQcMvkubeAHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4FH3N/gpcSw322YZ2XXYSgIqyUhB0k42jjo8ZQ+sUwuoOg+ISNfMBdbccGBBXvjhqhfsnVChQ3FHbvnMgloSpUbl34yD9q56her5z0N7t2cy8+cDWpEf0Siowh6ojDA8xqlgk8OZ17WFKzEqBrBIt6dIN1D4lXdN2AfezlY3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JnPj9dUJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EszM++ZyWA4F0AEHMeW0S6yDLENEL5nIwjErtg69nlA=;
	b=JnPj9dUJW5civc0vmQUjHJKZzGo0vQZZR6gTdJEWqfRLQUfq02sW485cSNUBjWHRwjaJ7H
	h3henowujFD0mx6HvPDDmfstYJrKOzXAYymjS6RDZ38EGorX6rE2YDRqaotcndbB8a+pKe
	dOBv4blpPYNuOblsUFhnwUVLppuClks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-so8_Bz8AP0eINzkAwxTEYA-1; Wed, 06 Mar 2024 05:43:38 -0500
X-MC-Unique: so8_Bz8AP0eINzkAwxTEYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BD8284B0C5;
	Wed,  6 Mar 2024 10:43:38 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A13A3111DD02;
	Wed,  6 Mar 2024 10:43:31 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 13/13] mm: Document pXd_leaf() API
Date: Wed,  6 Mar 2024 18:41:47 +0800
Message-ID: <20240306104147.193052-14-peterx@redhat.com>
In-Reply-To: <20240306104147.193052-1-peterx@redhat.com>
References: <20240306104147.193052-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Peter Xu <peterx@redhat.com>

There's one small section already, but since we're going to remove
pXd_huge(), that comment may start to obsolete.

Rewrite that section with more information, hopefully with that the API is
crystal clear on what it implies.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/pgtable.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 85fc7554cd52..6b0d222a7fad 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1770,11 +1770,25 @@ typedef unsigned int pgtbl_mod_mask;
 #endif
 
 /*
- * p?d_leaf() - true if this entry is a final mapping to a physical address.
- * This differs from p?d_huge() by the fact that they are always available (if
- * the architecture supports large pages at the appropriate level) even
- * if CONFIG_HUGETLB_PAGE is not defined.
- * Only meaningful when called on a valid entry.
+ * pXd_leaf() is the API to check whether a pgtable entry is a huge page
+ * mapping.  It should work globally across all archs, without any
+ * dependency on CONFIG_* options.  For architectures that do not support
+ * huge mappings on specific levels, below fallbacks will be used.
+ *
+ * A leaf pgtable entry should always imply the following:
+ *
+ * - It is a "present" entry.  IOW, before using this API, please check it
+ *   with pXd_present() first. NOTE: it may not always mean the "present
+ *   bit" is set.  For example, PROT_NONE entries are always "present".
+ *
+ * - It should _never_ be a swap entry of any type.  Above "present" check
+ *   should have guarded this, but let's be crystal clear on this.
+ *
+ * - It should contain a huge PFN, which points to a huge page larger than
+ *   PAGE_SIZE of the platform.  The PFN format isn't important here.
+ *
+ * - It should cover all kinds of huge mappings (e.g., pXd_trans_huge(),
+ *   pXd_devmap(), or hugetlb mappings).
  */
 #ifndef pgd_leaf
 #define pgd_leaf(x)	false
-- 
2.44.0


