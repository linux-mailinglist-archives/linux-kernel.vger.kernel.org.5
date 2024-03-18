Return-Path: <linux-kernel+bounces-106610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD16887F0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4271C212EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453F5CDC5;
	Mon, 18 Mar 2024 20:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xsx88nhx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0A5C8EA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792274; cv=none; b=FYWaonQGvRFvmsVsGoEOXKnMSFsP28UNpGNspvNhhQOwIlo148v2Va1emfQMJI9dN6Ju3kfTX4KpQCJb5/CJ6GKmlZtDdJbVydwC2Sj30dHC2Ilx4doJZlFdySeNyF/tCD6Jluwoz+ptV6lLTsiznlIQIeHFEYC4MvCriAVwPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792274; c=relaxed/simple;
	bh=OtdxslPn00ut3ZNOwlMQpC8bAo76CW3Q9+JhiTFcwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewHokDbMn87F1tZKClzRQQXfOM/jXLzx+6ilMpITxueT0P1Vj+HrCaz8GDEkwkW+B6SK3K1DEXC90XV1//xjfBNs7RtKIQBJtQM+KcOdJ9WHtHHyHXmWEhHI9dmRIGuqBEAjdhU8MplMMaG3ojD9K/l9fA7vpPsqaOQ7elR+9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xsx88nhx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
	b=Xsx88nhxMF/DcgSyDpu9CDVBBvkqgGOL2ei9k9ANdJyTwau522QPNuwYKYgOW4V6xYPHiR
	XXeBOPYu58c4l+sxpqASOgNH5fvgXxeyQSn+b3oRNeDr80dO9V7QGWCo71Mqx/5epRw0Jf
	4i9g7zzFURsKFb+24R2MbQoFp9oBGzs=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-Xy61K1HcMNCKmynbQTEGww-1; Mon, 18 Mar 2024 16:04:29 -0400
X-MC-Unique: Xy61K1HcMNCKmynbQTEGww-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6dea8b7e74aso1769401a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792268; x=1711397068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
        b=q+wEUSAoEKeZb65/vwI4hyRqawtnX/u6ilal8iG5MRRfOhMDbzcKYflljgILSWQaoY
         t1sy/ggcVXGYueXbRrmTCVWJhk47l+GZiGk0gqFljfUl4VJJ4via7aU/J5D1O3asnTwy
         hHYrjmFZ3IawRuhaXCgYCnzxnMOCg9109uEWjnnz1CCRTjVE4nocJO4OD2P+Cp+nWUTa
         2ZCYkj30YozfphYc7MbQOjyT6D6s4YN1LZOswJ8l33ESyJH2avgbNJYMWfq+LWh7Nq9m
         CRXeTtB3CAMCKuHvSrmK1obh3lVsSlA1dM8vqR9XWjNCzW58kmDhFEj08quOHjP8XzLT
         01dw==
X-Gm-Message-State: AOJu0YwPBN9nvg56MpRX3o2Qz7lS/OBdVlAzOUnXxl6OUEglDKLzB3wJ
	Tbw8nzERBTWosLJYJzYbGd+VXdJ9kEv5F3YgdeP6bt/uI0R/0y7TKWbMszMUB29a+5cdF6VEdsp
	xX2+GEBf325jC6oX6aKPI2/c83qnr0DwGBGMpf0EIaHvb71EorRJJCrbADXfpHUu8ZsKgE0s5xk
	oWsqLDTVHH885X9EE7yo++ArhjoehsNTar5T2kjO8L4sA=
X-Received: by 2002:a05:6358:65a5:b0:17e:b905:ae1a with SMTP id x37-20020a05635865a500b0017eb905ae1amr174651rwh.0.1710792268217;
        Mon, 18 Mar 2024 13:04:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGISjMhnC6jpMGGK6QBF7/frbKYlLqkW40smiDqxegPdY+XDqO7mpvYlvBe3yHbKZyIwRsTRA==
X-Received: by 2002:a05:6358:65a5:b0:17e:b905:ae1a with SMTP id x37-20020a05635865a500b0017eb905ae1amr174607rwh.0.1710792267562;
        Mon, 18 Mar 2024 13:04:27 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:27 -0700 (PDT)
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
Subject: [PATCH v2 14/14] mm: Document pXd_leaf() API
Date: Mon, 18 Mar 2024 16:04:04 -0400
Message-ID: <20240318200404.448346-15-peterx@redhat.com>
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

There's one small section already, but since we're going to remove
pXd_huge(), that comment may start to obsolete.

Rewrite that section with more information, hopefully with that the API is
crystal clear on what it implies.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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


