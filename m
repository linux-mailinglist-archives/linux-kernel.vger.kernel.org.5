Return-Path: <linux-kernel+bounces-121496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFB488E8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7525A30875D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DFF12FB08;
	Wed, 27 Mar 2024 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGDahIFo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95C312EBC6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553024; cv=none; b=TQptzZrcxwDmhGVoZJ+qmVikYf+oQhZagQDNsw2RTa+hm4fHk+B3E6AihoOTBUfScfz+LYTCb6i7AK//Fn4MjSblPrI8ZKds2EvnIk/DHeXD0yBT2QMCaY4IcEWE8sq35UUPG9RvfMsikBaQi7kipFHjcKwOSBYG+1KS+FS1jW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553024; c=relaxed/simple;
	bh=aHfZvZI3hblnvK7sGliw4vracY8c0yNtRNBxsmY5Mag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fvl/1KB1OZZbrEn+atZu6QtODCrRa06qJZUYLtzFXvkdnlQC32QC8aQ5hT64DxANOoWHYNU75AVOgzGaOShEgNjP5KkOZwlj6xF+Knc2NPNreeglwCJgPWq5UjfOUaXoT3/N/TqPCm8nSj2hFQ+W8aQSMtMHBtvNaqSZi2z6/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGDahIFo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711553021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bzTkuuEUZ2f7C9YouF2ORWZwnTLSeJ8Y5AJhy7kkISQ=;
	b=BGDahIFoPuVsn+WJw7MzPr1lguopRuaJIGufIPvhfVq/Cb24W6PZK4i0AXEsGc/tFb4kd0
	kdlPqae/xmnF0i36Db1WSh3T8rCN8hMBxoDaaXQ0/Z43gpZ2SLy/ga6vuR4tTS8Vq6knLO
	yeEqVUqAG+nOz3aSGttl6cThtIbMByY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-aEx9VzKFM6qBASRHlOTsow-1; Wed, 27 Mar 2024 11:23:38 -0400
X-MC-Unique: aEx9VzKFM6qBASRHlOTsow-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-69152af7760so25772106d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711553017; x=1712157817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzTkuuEUZ2f7C9YouF2ORWZwnTLSeJ8Y5AJhy7kkISQ=;
        b=cygjNSyVT56ddR2hV8AQqsZJ/irXhjRMnpynvghABPAy8i5V5XlJdR5DU3mjDVAVNd
         PGzGHciCXyjE3tfS/W/7EiOXk7xtwQP/oqOI89W5ZjC7W47+XhjqlAXKEAQ/9X0l5zos
         jvGKdYjp/65WmfPceRkAJxhKtn6GB6oaI2205F+dI2AvgbRuiUXL7+Dj+zd0WNrUAGay
         Q7SmlBhxFSk5PBcJdkYqvnkqHCUwaI2Sjz+OQ//BofxDfn9BgIBNvI4JbaSsb+sJy30H
         T3+priIyl336N8nV8c9GasW81/8ah3STwAkjn7ra7U38VGiNJHHDGXepd5IjQ/ewsvDR
         UpqA==
X-Forwarded-Encrypted: i=1; AJvYcCUwt5cJpRxElktue7NXHfjcxCMn5jCKPG0Y3C48KRGzWA6EVrDupWNLtZ3TOtYAWO8H0EVfnr19JDmf/FxIg/3B2YCSV4wUDAelUfYr
X-Gm-Message-State: AOJu0YwsIubhBNGZKy8D51lXhCl0haRs5tEnD7IjTTh23B0IFrbOVSiv
	AvM42Zp9mK5i9oXnOo0yJlBKWZraEEeaadr4B/vMgepyxkyyuP4dbcZEyYpAYEFFPIISh0w7rEe
	x97C2eys2lqDzOHkaIX48OlSG/wFgW/5P9q+digBm2EJF5pJzRyPZPz0hvgJXLA==
X-Received: by 2002:a05:6214:5d11:b0:690:3c85:c5b with SMTP id me17-20020a0562145d1100b006903c850c5bmr14918731qvb.3.1711553017580;
        Wed, 27 Mar 2024 08:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFplzIHsd2VycAjj5oUNWAa5qW9RFPqJwKtRaT5aqzv2S9fkhcwA1AKc/2h1PXS7yh/3x/6aw==
X-Received: by 2002:a05:6214:5d11:b0:690:3c85:c5b with SMTP id me17-20020a0562145d1100b006903c850c5bmr14918682qvb.3.1711553016992;
        Wed, 27 Mar 2024 08:23:36 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hu4-20020a056214234400b00690dd47a41csm6412639qvb.86.2024.03.27.08.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:23:36 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yang Shi <shy828301@gmail.com>,
	"Kirill A . Shutemov" <kirill@shutemov.name>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	peterx@redhat.com,
	Andrew Jones <andrew.jones@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Rik van Riel <riel@surriel.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrea Arcangeli <aarcange@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v4 01/13] mm/Kconfig: CONFIG_PGTABLE_HAS_HUGE_LEAVES
Date: Wed, 27 Mar 2024 11:23:20 -0400
Message-ID: <20240327152332.950956-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152332.950956-1-peterx@redhat.com>
References: <20240327152332.950956-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Introduce a config option that will be selected as long as huge leaves are
involved in pgtable (thp or hugetlbfs).  It would be useful to mark any
code with this new config that can process either hugetlb or thp pages in
any level that is higher than pte level.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index b924f4a5a3ef..497cdf4d8ebf 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -850,6 +850,12 @@ config READ_ONLY_THP_FOR_FS
 
 endif # TRANSPARENT_HUGEPAGE
 
+#
+# The architecture supports pgtable leaves that is larger than PAGE_SIZE
+#
+config PGTABLE_HAS_HUGE_LEAVES
+	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
+
 #
 # UP and nommu archs use km based percpu allocator
 #
-- 
2.44.0


