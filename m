Return-Path: <linux-kernel+bounces-106606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BE787F0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D2AB2373D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73B75B688;
	Mon, 18 Mar 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jpv8PxWJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C351C5B5C1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792266; cv=none; b=VpnEBzEjKiaSXlC0XdB8fW8YNZJQhInDpkfrojADusBsNWiWC18e0OBtpZITwhJF5NXrzyDJas+KZ5OJqX0Z6zNNM2BDd8rXxfNKQosnubuxGWD2uYbTE9WxCPsk+Bv9xAQ1I/NVLYKe2hjALwquyGm+l5UTpuYMhQVKmsjwhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792266; c=relaxed/simple;
	bh=iQQgqfXsWxx8LbxXDlwC+eVTcKSnHUToAbw1far1TeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p8kxN/liqTBypE7L/dDgFWuyMDfOqvAe4CTzH3PY39rNNZfQh+JuHjq+WYxSioWVpt0oEtTuLuiX54ImJ/g827Lrys4DbwFY89T0IgZB4obeWXHh2cXQCFi4Sb5wNzTcSh/WGnKLqOmsKZgUszIXj1mFdvWJFztioKytnNbl5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jpv8PxWJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710792263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
	b=Jpv8PxWJQZKZ1IYVe15VrpiUDORHnFCxDPRbj7iLMce03wnLpBVVBsu4860HTjYgz+y1As
	VLJn46csO+VBKepkhO+s+lyspsmnnW3he32J7W4QrPKQlu54YJxqcLKUlDqf63rsMcRyfZ
	AvYt6wdzv9RNSU8xGUeUdjkvAPWjr3M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-bRwYtrB2M5KSKKFXxEvceQ-1; Mon, 18 Mar 2024 16:04:22 -0400
X-MC-Unique: bRwYtrB2M5KSKKFXxEvceQ-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-430c76df729so6673221cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792262; x=1711397062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
        b=Jc+IuFA5dzxNPUyV7TbspOiDF8J59y5aSpq3dwnrVQ/dOcPfgr1BcjmWtVjuMqiTiW
         sWgX0PVbeu56L8rbg08kkU2TFJg0XPP4xUTW2V3ltrUUIfeq9/UigZ5IE6HhflOa+BQM
         NAY0dNXlHbPTR6oSzKU5zsbONDBXSeVFQO4T+TuDPzYuLVUEqeZKBrutstmKNbrqJCDe
         /i9UIhYQdSVKkZ9ArYTdq3FCyk5ID2gtzz1pe5yl8FtyXv7izxD5rUp+a89nrJrVPaMA
         9nibTQWCmQSUOyqccUHGR/0ooX0AnRS5YJoezpsMAKZ1sjkF3P4iwopg+5hnW9JhuBLP
         HHdw==
X-Gm-Message-State: AOJu0Yw0MRYKzqCaoAAJ2hfiVcEl8clpK42SfwsV+Hyf37J7+mftsjcM
	BmxDkBB5PyVZRHZTygK4QjG7Ma1EzZObgLKSVTRkxv0AojU3xLEp5fVUlbrZsn+sgRw2gHP7lAA
	rTdV7zr2MK4JA22h3zRlr0nOluwgCIHu5yVLLjLQjqiYDVbsyowHb/2lP1F7Yz8+DC6fXHFyArw
	pYNiqKARo1nWv5s38rDQeS6z3QdmFuwkyTlkGtfKYJD1w=
X-Received: by 2002:a05:622a:15c8:b0:430:ae0a:c08f with SMTP id d8-20020a05622a15c800b00430ae0ac08fmr12238091qty.6.1710792261614;
        Mon, 18 Mar 2024 13:04:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQhMJRmPtSMLbLztL+aVkPHyOJfqD1JG0yGIJ+aGiheaz6nxeexYpcIdXvqwuavYhzTjiHrw==
X-Received: by 2002:a05:622a:15c8:b0:430:ae0a:c08f with SMTP id d8-20020a05622a15c800b00430ae0ac08fmr12238049qty.6.1710792261015;
        Mon, 18 Mar 2024 13:04:21 -0700 (PDT)
Received: from x1n.. ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id hj10-20020a05622a620a00b0042ebbc1196fsm3484491qtb.87.2024.03.18.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 13:04:20 -0700 (PDT)
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
Subject: [PATCH v2 10/14] mm/gup: Merge pXd huge mapping checks
Date: Mon, 18 Mar 2024 16:04:00 -0400
Message-ID: <20240318200404.448346-11-peterx@redhat.com>
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

Huge mapping checks in GUP are slightly redundant and can be simplified.

pXd_huge() now is the same as pXd_leaf().  pmd_trans_huge() and
pXd_devmap() should both imply pXd_leaf(). Time to merge them into one.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 802987281b2f..e2415e9789bc 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3005,8 +3005,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
 		if (!pmd_present(pmd))
 			return 0;
 
-		if (unlikely(pmd_trans_huge(pmd) || pmd_huge(pmd) ||
-			     pmd_devmap(pmd))) {
+		if (unlikely(pmd_leaf(pmd))) {
 			/* See gup_pte_range() */
 			if (pmd_protnone(pmd))
 				return 0;
@@ -3043,7 +3042,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
 		next = pud_addr_end(addr, end);
 		if (unlikely(!pud_present(pud)))
 			return 0;
-		if (unlikely(pud_huge(pud) || pud_devmap(pud))) {
+		if (unlikely(pud_leaf(pud))) {
 			if (!gup_huge_pud(pud, pudp, addr, next, flags,
 					  pages, nr))
 				return 0;
@@ -3096,7 +3095,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
 			return;
-		if (unlikely(pgd_huge(pgd))) {
+		if (unlikely(pgd_leaf(pgd))) {
 			if (!gup_huge_pgd(pgd, pgdp, addr, next, flags,
 					  pages, nr))
 				return;
-- 
2.44.0


