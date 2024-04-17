Return-Path: <linux-kernel+bounces-149247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AFD8A8DAE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 843F31C216ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA764CE8;
	Wed, 17 Apr 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnb3/8a+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566405FBBA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388730; cv=none; b=nvJYWwfdxBBW7vz5kgW9mcqr1z0vUMGxb8XpqfsQ8oWKsoYS2rSTyc3t/66V/msMlIOqSLstxJ5x94RcLIo7EKqIKM3UpYwz9SiMQWVJCr18lr825bzUHPQvWd/LuyTzZkR7t9DkPrVGZdO09ueQDc0m/JT/iPKrNvPW4yWw2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388730; c=relaxed/simple;
	bh=8hBBeVGOfwuGovj1gkEA8TNtFgFkqBM5g9BIRvAXat4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYbmgBHIOMWplMVWrV5PZvkeNo+iLckJUMWZxvPR+a2ECr/hpailClSd/VCqBus87u3nZXZ2VHd1n7+2DwFa/TMhY8q4/tvlposnAwuzI+5PWvoj59dAQFxi42SznngAByzdUN7LW6Vvqnk+BzK7G446c+zY+P6HovOcPRrpSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnb3/8a+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soVIv7S/cFD39BpNRdoqoVyCZSY1hvphkidLWmkZkAI=;
	b=cnb3/8a+81BMW1uIimk7l46EvvvwJEjH31DZUdN5+WuoWU8O07rBnVCh3pk56+pcX/Gxps
	nlkfiUwjx4fEI1dJp8xjnjaR5BGvKyM7nQ8aAZBgOh/FA3RLxhj7QvmAnJBk8Z6ogOoaB8
	c2EBqQFOMGNoYJeoDPXzAsiWBYt8sMw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Ltq2oOU-OTub_ZmQm0mkJw-1; Wed, 17 Apr 2024 17:18:41 -0400
X-MC-Unique: Ltq2oOU-OTub_ZmQm0mkJw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-69b27e4ed7aso609086d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388721; x=1713993521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soVIv7S/cFD39BpNRdoqoVyCZSY1hvphkidLWmkZkAI=;
        b=negv14ERGvPy12QosBzKc0hfZuCMF5iayjjvPwWDg7DkEljFmFjbsvavikK/hBcErE
         NI8wHGgALbmbqYSuLlIoE/Q4C0buSk1JcjuPh/MJ1rvef8uCrFjCQgRppQdDEeNYrXLL
         dYzdNF90LbJjlHaH6ltMMVcTskbs6hsc8nqVQ0gq7lk4qYiSW7G18Ln8o5n5mAN6IsbA
         qBja1QORVBJ+r2W1Wbgmf6y+DHTKg0V9P/Iz1U3gGxlm5hc5cgmCc16X62T/17Wr4J6O
         OfFG9T4F7+YIoyGvEKrNXJF8h9dGByN8Q4dWCDDpF2M0gjfOS3Rvn+1MUiSHN+vPFsxA
         T5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+dieW3D+nOYnhjDuisuq8VzMNA/88JIAWjDFnD92LktmOLIDVr2qBSnw2LZjbUQHb1erICsKIKT7MPLBt6R48pCINoKwyUCdHPk2
X-Gm-Message-State: AOJu0YxSLwSQx+EgWm/0BvfqMRLUHL2YSJsjNxd1MyP3Q98+ZEERuZ6x
	cyWapQcjkvet4HDN1iGKZrY4/vQ72w7f6EmlbWBDgH+0G+fSKQm9q+vI1k0FKhAfKgEhLXAKxpt
	4l7kLZ99UMEOsJQzaPlTN7LGFtSGVmwZ/at+TIfZn4RacWMkHPlSA8r0yOYZh6g==
X-Received: by 2002:a05:620a:40d5:b0:78e:db4f:11e8 with SMTP id g21-20020a05620a40d500b0078edb4f11e8mr665738qko.2.1713388721117;
        Wed, 17 Apr 2024 14:18:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF29e5f56ETIzCUQyLUa1pQN9jUqXmcKYHsWC/k2I1kVI2Yma0QJE36x4pPxkZnbBNtERvaag==
X-Received: by 2002:a05:620a:40d5:b0:78e:db4f:11e8 with SMTP id g21-20020a05620a40d500b0078edb4f11e8mr665713qko.2.1713388720577;
        Wed, 17 Apr 2024 14:18:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b0078d667d1085sm18692qkm.84.2024.04.17.14.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:18:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com,
	linux-stable <stable@vger.kernel.org>
Subject: [PATCH 2/3] mm/hugetlb: Fix missing hugetlb_lock for resv uncharge
Date: Wed, 17 Apr 2024 17:18:35 -0400
Message-ID: <20240417211836.2742593-3-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417211836.2742593-1-peterx@redhat.com>
References: <20240417211836.2742593-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a recent report on UFFDIO_COPY over hugetlb:

https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/

350:	lockdep_assert_held(&hugetlb_lock);

Should be an issue in hugetlb but triggered in an userfault context, where
it goes into the unlikely path where two threads modifying the resv map
together.  Mike has a fix in that path for resv uncharge but it looks like
the locking criteria was overlooked: hugetlb_cgroup_uncharge_folio_rsvd()
will update the cgroup pointer, so it requires to be called with the lock
held.

Looks like a stable material, so have it copied.

Reported-by: syzbot+4b8077a5fccc61c385a1@syzkaller.appspotmail.com
Cc: Mina Almasry <almasrymina@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-stable <stable@vger.kernel.org>
Fixes: 79aa925bf239 ("hugetlb_cgroup: fix reservation accounting")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 26ab9dfc7d63..3158a55ce567 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3247,9 +3247,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 
 		rsv_adjust = hugepage_subpool_put_pages(spool, 1);
 		hugetlb_acct_memory(h, -rsv_adjust);
-		if (deferred_reserve)
+		if (deferred_reserve) {
+			spin_lock_irq(&hugetlb_lock);
 			hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
 					pages_per_huge_page(h), folio);
+			spin_unlock_irq(&hugetlb_lock);
+		}
 	}
 
 	if (!memcg_charge_ret)
-- 
2.44.0


