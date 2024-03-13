Return-Path: <linux-kernel+bounces-102566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0A287B3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB3271C236EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B505C90F;
	Wed, 13 Mar 2024 21:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtBNisYf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BA5F465
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366468; cv=none; b=LniaH0VZX96bRj1v2aCn2tfzXm4XDIv3ISOCb6w34G7SEg6eAHSSCzGTM3dFdJhk3dKzKRHm2FwOQsokldskREDh6JQo6o5BZEphOku4bVHmHY43plD3LJyTeWuDcC0o7h5Dj1YUuakRMk4/2wJAuy0kEe2MXO5+MkWoCnG3pFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366468; c=relaxed/simple;
	bh=OtdxslPn00ut3ZNOwlMQpC8bAo76CW3Q9+JhiTFcwrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC8OogFnivm/j+1r3EWh/thVTu5mtDkKiw06yMJ0VmlnFYlYMwk0jZj5BJmqPmfDQzxGYwcC9EgJWQn5AYLK+23RbVoP5/FjvARpiJhpZjdwQvwExoeJP/XowWOrEG3SSuYDyEDZR/ahBoab9/vHBMCWOYh5fVtEaJRnMmKkFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtBNisYf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
	b=QtBNisYf7XfwYzICx0puyDSv7NCHTQ0Vr0rYjB5gnSkJnBK3UUrk1uxJT25RIZHtO/bfoJ
	QX5RuHcdVe3zSPZUoEsgIxuO4z52n3apo6g26vmTr79sgNYJhpMATW/tAqt6LRlrQjH95/
	rIi7DsrSSvR1wPm24zeojaQC/4iu3NQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-vdUAX53KOCKL7ltj89HGiA-1; Wed, 13 Mar 2024 17:47:42 -0400
X-MC-Unique: vdUAX53KOCKL7ltj89HGiA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-690ab2b0de1so1163216d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366461; x=1710971261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RceLUqudgSYtio91tFrZNJeoSc+POoSD4WuQnIajVyw=;
        b=vKM8DGoh24966REIOTiwJi8G60rvo3kjLPaIexAT5ZLneX0ZXAKDCYqDSNXl97YFX9
         lJDQ0T+WwHarZyo8s0BHpFueE+ztSLY4Omde0xKpvP3AC1JSA5f2VSY+T8Ul7eL01pNI
         trVAhscjF+19tmv3zbj1aQM5oviKCm7j+PLWGoqrAnsELL9IQqbWokbpRHWGuehCg8L6
         mDZqBOjj1i5UBARzJB9cscP5oKG0I8nD2SGiyqfbSLYgdeJoqb/bq7Udym/l3kJrClp9
         70Mqv0Hc33Mxw6q4945J+uUanGJaw5zSzwV9zRLT1vsO6R81+k8u95O+30KWjmukBbcZ
         ljag==
X-Gm-Message-State: AOJu0YwbS5vleOEwRl4eHIkOpQ/lpmKOPiGCo1PGlEFbudiR2vixFbt+
	Y9d0Q67moeIc87qf6YxLUOPoVJl0wFw7lkh/DU6m5HwpiH+4baVVkxZvOl9JHXhRRpgL/ONJdb8
	jgpBejye1RFgR4tUmeniIXxFrjpeXqMtvRCOV7Yidwwf4zcgM9eVJ04VU6PGavmbUmZnu1Mxhs2
	qNEWRPLiR1zSypbVHTpNXRo5WNAZoMKs9dnSOLzm0o6qA=
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id x3-20020a0ceb83000000b0068fe77970f2mr5934061qvo.3.1710366461219;
        Wed, 13 Mar 2024 14:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzQ7u+SJJkcqXmUXcq37q3NbZvmeXcFSg9ZX/No2VaFoCndSeWwMBLZUu/Dqoea36C4ilydg==
X-Received: by 2002:a0c:eb83:0:b0:68f:e779:70f2 with SMTP id x3-20020a0ceb83000000b0068fe77970f2mr5934040qvo.3.1710366460771;
        Wed, 13 Mar 2024 14:47:40 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:39 -0700 (PDT)
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
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 13/13] mm: Document pXd_leaf() API
Date: Wed, 13 Mar 2024 17:47:19 -0400
Message-ID: <20240313214719.253873-14-peterx@redhat.com>
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


