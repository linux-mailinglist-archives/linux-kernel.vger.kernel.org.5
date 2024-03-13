Return-Path: <linux-kernel+bounces-102535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848E87B37A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1FE1F24C24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F0756770;
	Wed, 13 Mar 2024 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fRXPGmQQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DA85644A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365475; cv=none; b=jB+uOw7WELD73fHoSWPrNmiXN7pfRfze+Vuy+yG6wS9fyaKNGJyuJRbbhZiw9PljLyVAzb6dWWYkXnmsBPNhb8QkkUh+xZ7fif7K5rHW9emik6oD39vflsI1ZQdRq4nEhoVoNVdE8sukQkg9ftmirhQ9l8Ir7wHqh1Opz7q/PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365475; c=relaxed/simple;
	bh=C4SiVF7VAkuKfOAhkvM2NmHIdqvfL77sde5+3WxGz8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVRxsTwHackFuQLCGObWKLsuOLGe/5qi/3+83g+iAmN4LXpyHns58DUDj6AVv712ZE2sTKmIzxw2VfnYuZnrsYHjgA84AsrfmIdCVP4k+LkFF5ZBpAbyEMZDxHaujgPGWazArUFKIzBAuznfQZyIxC9IBT1VbHayFTwsAuQzjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fRXPGmQQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710365472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zSHMA3F9Ys9+S9b2CLlCHNAI2GjKD9Vh5g00AYRvICU=;
	b=fRXPGmQQzO10p4KXye30H6T33KEQMmVJfqy4V/7NyZr3lidw+bGj/dTyXJzvoKbwmumlL0
	sxOuoHhqqSllsgYsfAqaAoOt84bHyO9+OTe5Hg1N3nwGVNdXxklLt1QbzONSKPWB05L+YL
	I8h2KC7YwOeEwdF0s/ojxIavR+ALjDE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-jSviFq-aPSi9QHj-6V6vfQ-1; Wed, 13 Mar 2024 17:31:10 -0400
X-MC-Unique: jSviFq-aPSi9QHj-6V6vfQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-690c19ee50bso948116d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:31:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710365470; x=1710970270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zSHMA3F9Ys9+S9b2CLlCHNAI2GjKD9Vh5g00AYRvICU=;
        b=EI8jO/THmOwh+5KlE6Qxrio8g+EGnQiev6B5zWFDw4zdCJCl/aPsX6YlUVQWWdu6Hn
         6m3D3deK1U1m8QaUly3/96qyOrHEE3FNmvOtRaSkiYAAGK9CVjsiR12HUkgZ9UN8ZWfM
         WigX/AtuzrMSIBbMSx1qONuuIYfzzC8GFyHIqKJNG9fDuJqK9a2PqgH/l1CJ6SsEey2x
         k9JoUwJFANVXFtkzo+qevSQ0k3JySAVVGPs+SFz4XEReir0UFe5WqUCnUBJ6zUyP10jJ
         ICanLHCocxsjSlAJCiu8/mNGFqJgSg9zyx7FJiOK/P0dJid+p84M4FyuBuD3aE8vVaSr
         CilQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg9s+YFjDdcId7wonTbegJCiwg87YqO9docMed2q9TkvcBnKW3o+9sVqh1x7ZqSAz8B1jHunVehLUC5MFDJslOdz2i06MY9BIzqxNb
X-Gm-Message-State: AOJu0Yz8V+ap/t6o0NFw9hl4NYM7TVp+nnmVNBVcQfL4XYBJYdT3p++6
	yIA7hALJE67mGq54bh2CsgVSZywQ/CloN7ce9LuSaO7uZ73CWRiZj3aqyVlG+kHDMeYpMa+Cy3M
	5lY9ZGdNMCEWCDQQlAIEjyTT8HLFIkHOgfbr71actO6+i1n/b3En7WXN4hxDrXblgaNWcVQ==
X-Received: by 2002:a0c:eac3:0:b0:691:2524:2d87 with SMTP id y3-20020a0ceac3000000b0069125242d87mr2283295qvp.2.1710365469660;
        Wed, 13 Mar 2024 14:31:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsLh8aQhtPreOjP5bc4Hiwu2Giqo97Es+TwECM0aBYGuG0Rd6UIY+m2f6qoD6cxMewmR3UBA==
X-Received: by 2002:a0c:eac3:0:b0:691:2524:2d87 with SMTP id y3-20020a0ceac3000000b0069125242d87mr2283267qvp.2.1710365469157;
        Wed, 13 Mar 2024 14:31:09 -0700 (PDT)
Received: from x1n.redhat.com ([99.254.121.117])
        by smtp.gmail.com with ESMTPSA id f7-20020a0562141d2700b00690f23c8605sm57087qvd.23.2024.03.13.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:31:08 -0700 (PDT)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/memory: Fix missing pte marker for !page on pte zaps
Date: Wed, 13 Mar 2024 17:31:07 -0400
Message-ID: <20240313213107.235067-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Xu <peterx@redhat.com>

Commit 0cf18e839f64 of large folio zap work broke uffd-wp.  Now mm's uffd
unit test "wp-unpopulated" will trigger this WARN_ON_ONCE().

The WARN_ON_ONCE() asserts that an VMA cannot be registered with
userfaultfd-wp if it contains a !normal page, but it's actually possible.
One example is an anonymous vma, register with uffd-wp, read anything will
install a zero page.  Then when zap on it, this should trigger.

What's more, removing that WARN_ON_ONCE may not be enough either, because
we should also not rely on "whether it's a normal page" to decide whether
pte marker is needed.  For example, one can register wr-protect over some
DAX regions to track writes when UFFD_FEATURE_WP_ASYNC enabled, in which
case it can have page==NULL for a devmap but we may want to keep the marker
around.

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: David Hildenbrand <david@redhat.com>
Fixes: 0cf18e839f64 ("mm/memory: handle !page case in zap_present_pte() separately")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f2bc6dd15eb8..904f70b99498 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1536,7 +1536,9 @@ static inline int zap_present_ptes(struct mmu_gather *tlb,
 		ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
 		arch_check_zapped_pte(vma, ptent);
 		tlb_remove_tlb_entry(tlb, pte, addr);
-		VM_WARN_ON_ONCE(userfaultfd_wp(vma));
+		if (userfaultfd_pte_wp(vma, ptent))
+			zap_install_uffd_wp_if_needed(vma, addr, pte, 1,
+						      details, ptent);
 		ksm_might_unmap_zero_page(mm, ptent);
 		return 1;
 	}
-- 
2.44.0


