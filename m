Return-Path: <linux-kernel+bounces-112205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F058876E8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672CCB225CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D254A12;
	Sat, 23 Mar 2024 03:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPwF9yn2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B742137E
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 03:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711164799; cv=none; b=qurE7CNZU7ykK/1Nne7MUOeZP21eylSGS0glpUcair7qauC/5IBaPYjAS5QiUicc0qALU+xu6Ut1ERorZYyB5exJtcJTQ91w0L/cE7w9T0KocrM9AUiJMGX5b2kFd08ZoZHKoWx6v9nWPmVqNh6H8J2ZsyykVd+NKPpmzeR0MYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711164799; c=relaxed/simple;
	bh=R+3W/lqDRivVSXlpp1Pv3tLz3bw9l7+pp43IX9IDg2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAhiyRSnVPnT6d1yXwJk/XKsb5+9YtcdVcq7r+kyPb4Be6g7a9a/+kg9xtjJtKd9L1bRTPXAQkYjko19wceaxzP+nunlUlEi/yaoYYHLPbP3YrjgSYJLbM2cTJ01MIvqCDPiOVywhM04cUSxJtVq8AKdFUmdK9mZyrZlAtefn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPwF9yn2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711164796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bPSu+W7vT4RKbhScarttkkMbTdfZ3qbP2U3+RXyUi8=;
	b=cPwF9yn2fSduJfMqwwsOhADr3QaSeHST5XT4Y5vsRIFC1i9T97k0ygv5PMEdCg4v6IATD9
	8NiadRquJ6iety8xne4VXeseJdn4wWT3nb6rsJ6BJre7IsivRzi9++d2xc9oxIWcvGHiX2
	zdXZQpQdVkpgzLIf9L/9tvj3EA8W0g8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-j97yGQ-6NvWAr_0lGeY6QA-1; Fri, 22 Mar 2024 23:33:14 -0400
X-MC-Unique: j97yGQ-6NvWAr_0lGeY6QA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4311dd10102so10554861cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 20:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711164794; x=1711769594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bPSu+W7vT4RKbhScarttkkMbTdfZ3qbP2U3+RXyUi8=;
        b=iSCoj4zUcaahZOYGRxn8MY1UNgUyFAgwv6NyS8m6TGZn4NOdWDl1c46EdBAjbRsKqW
         iUdn1z2uRSYT5AijcPweLKPztGn3vIYKVyLGNEJYclzWxWWPb/qOWFhT9t7xFRdw+tDP
         X+oakP6MDp35TRkRBmosJdoO+s9evogghhrDhk5Drlcjc3eGfsC7rM3HC7Hx1uj/6TJt
         X3x2Yo/BfmKptqCHTZeFgyQH5T7X/F54BqIrZSNsvxuam6JIQcRHTm0gGMtY85bWnXEx
         hPlDGa/rcmA9RzEHYPdEBua+KCtCehI3DqAUCihE9i/zACokCAwzNOrDvuUvzjIl/1sE
         1Obw==
X-Gm-Message-State: AOJu0YxcIMWRDNKm3OfDH4UD7KWHbupCBiZD9Fkz01oxu6pk2d4fE5q/
	6tbMtfWdFmPerjB14DpAnJC/S3K4j4dJgptyAZzLidWwvmhR+IsbGhSJJYf5ZmxWfSOjSv57cXp
	Fof6URJ4kspCdY6gMqrKO6uX9KUA0nNp5X4BIJ2ndBn7xS+L9rZtNycnpV0O3+2eOZv0bxiM2fC
	YUI6hGAABIWyKL3R0umxULLrR1DVtv/2jTuH7fS6Rb6qY=
X-Received: by 2002:a05:6214:4608:b0:691:2524:2d87 with SMTP id oq8-20020a056214460800b0069125242d87mr1398482qvb.2.1711164793972;
        Fri, 22 Mar 2024 20:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLCFa/0D8xCoreHcECO/ArQZLiTfxOdYRCzMwFUL7ykul7taqLyoq/q98gRwf22Obq5Gw9sQ==
X-Received: by 2002:a05:6214:4608:b0:691:2524:2d87 with SMTP id oq8-20020a056214460800b0069125242d87mr1398465qvb.2.1711164793308;
        Fri, 22 Mar 2024 20:33:13 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id j12-20020a05621419cc00b006910e7edfedsm1698198qvc.62.2024.03.22.20.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 20:33:12 -0700 (PDT)
From: peterx@redhat.com
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	peterx@redhat.com
Subject: [PATCH 1/2] fixup! mm: make HPAGE_PXD_* macros even if !THP
Date: Fri, 22 Mar 2024 23:33:09 -0400
Message-ID: <20240323033310.971447-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240323033310.971447-1-peterx@redhat.com>
References: <20240323033310.971447-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

[To be squashed into the corresponding patch]

I initially wanted to simply cover all macros to be under
PGTABLE_HAS_HUGE_LEAVES, but I found that it won't work, we must define
HPAGE_PMD_SHIFT even if PMD_SHIFT is not defined (!MMU case)..

The only solution is use the old trick of "({ BUILD_BUG(); 0; })".

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f451f0bdab97..d210c849ab7a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -84,17 +84,23 @@ extern struct kobj_attribute shmem_enabled_attr;
 #define thp_vma_allowable_order(vma, vm_flags, smaps, in_pf, enforce_sysfs, order) \
 	(!!thp_vma_allowable_orders(vma, vm_flags, smaps, in_pf, enforce_sysfs, BIT(order)))
 
+#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
 #define HPAGE_PMD_SHIFT PMD_SHIFT
-#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
-#define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
+#define HPAGE_PUD_SHIFT PUD_SHIFT
+#else
+#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
+#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
+#endif
+
 #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
+#define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
+#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
 
-#define HPAGE_PUD_SHIFT PUD_SHIFT
-#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
-#define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 #define HPAGE_PUD_ORDER (HPAGE_PUD_SHIFT-PAGE_SHIFT)
 #define HPAGE_PUD_NR (1<<HPAGE_PUD_ORDER)
+#define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
+#define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-- 
2.44.0


