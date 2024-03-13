Return-Path: <linux-kernel+bounces-102564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F84087B3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F731F2440C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3875F5FDC6;
	Wed, 13 Mar 2024 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpzC5guv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307056B90
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366464; cv=none; b=sg8NfFzQU1JLIMGc0h/o1wNPr0EjkCD0pF5pqoDXrmTMSqPNO8VcuqCpk2lO7u+XZrr6yJnpLEBeT/ToEZH3KGVbQNomjP/ml+geGk9g9X6/s89DEzPMhI9GHYX7q0Qrh+uZRyFm2zQhLPizQf0dAg7Li3uRn8bkEFB9G9H84T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366464; c=relaxed/simple;
	bh=iQQgqfXsWxx8LbxXDlwC+eVTcKSnHUToAbw1far1TeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rld7jgZe66rou9JsbYyK2rAB1UGkcQOTD+lL9rchtXXXxkVLwLHZ3yaiTLziQbccy3Lp++BXmdhmt609zIxKk1bviksk4oAuPmCRralCeVWUzL4QAs4ha6vCekW/vZrjFYN5majsO3Ws46I8+ntvm9rcN+05M5Ke8b/Vi1+26zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpzC5guv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
	b=dpzC5guvWiwQKeBA1rUJfzGI6xx/Q2D+VfzBhVAv05MWr81xSzaFBnJddCNNI9LFdntpLE
	Dx/A28Mc8j7U/D6RBR8zYwAiVnNn4D5RLzgjg0X28F4v9I6j6uk18gmvBhWRfF96rwAyAK
	Ia63+w9+iWdXzT0G3BiVLOrYjkBrzIo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-KXy2Mk7jNo-EPkQOFJk92g-1; Wed, 13 Mar 2024 17:47:36 -0400
X-MC-Unique: KXy2Mk7jNo-EPkQOFJk92g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690ab2b0de1so1163066d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366456; x=1710971256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0Y+ceGC2u4mzi2lycxKAqHeA0qAqllKwMSRaV+2/Lw=;
        b=ViieFIGvTjxS3rIPbB2ek0Aqtl0LxJudm8jlUwNA3J+U+1Kl0pGE+oo3KVJcd+ZkGu
         rSTaKPSLaOrWf/rqPmmygnHsSgU99zG0vFKE5pCXA3TU80OEGIRaPrKPeQfQH4rAbkAO
         ZIunj3rzfsnV3xXAn9l3HvtllH/4YJSvVOqXAc7gaN4AWt0zuCadKRLkzVEfoShdSV2J
         Me4S8ya/UDKEjsArWtHpZZUYqZZDuOh8HElk3zRVxKrmZno+zZOEtjVOHHiFx6LXKYmt
         TGR0UIEsLVKD3I3ucLUCU2eIV7u3b4D7yo817/oX6lpwzXb6jx2TtAZaq0F2RmLkC1LR
         FFaw==
X-Gm-Message-State: AOJu0YwNpM6rfod1SsoCxFX1MAXHx8QY9KdJuZ4n2G9SMtYB6FyEVqbs
	t8yB41GVsynw/pe+OJRXGuut5Qg/jBm0iAUh5KYMx/RQEmTXQBLFDo1F5bQ4qu8JsBAP+wjZZ0T
	tsQ4clYqKL0tsyvK3WAFhoVRQX6xGPpjy9zUC2XgKCIdQEpMnr2AMQAH63y090SN7dIaybgm9J4
	GS0lkg9R8bAAHYdAO0G5E55jV6IGG+q9Bu3NMyEKcngpg=
X-Received: by 2002:ad4:4c41:0:b0:690:c64d:c2 with SMTP id cs1-20020ad44c41000000b00690c64d00c2mr5759460qvb.2.1710366456369;
        Wed, 13 Mar 2024 14:47:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+HGFdkYe0dzh0k+TaZTCqm6znW50jTd/iFDz8bJGRu/cwrU7vGL7Qd6Yn9XWGaKvseEdKzw==
X-Received: by 2002:ad4:4c41:0:b0:690:c64d:c2 with SMTP id cs1-20020ad44c41000000b00690c64d00c2mr5759436qvb.2.1710366455985;
        Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id dv10-20020ad44eea000000b0069111c5cdd4sm60114qvb.100.2024.03.13.14.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:47:35 -0700 (PDT)
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
Subject: [PATCH 10/13] mm/gup: Merge pXd huge mapping checks
Date: Wed, 13 Mar 2024 17:47:16 -0400
Message-ID: <20240313214719.253873-11-peterx@redhat.com>
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


