Return-Path: <linux-kernel+bounces-149244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5AE8A8DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646D11F2165A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158984C63D;
	Wed, 17 Apr 2024 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cg+Ynwgf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFAD262A3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388723; cv=none; b=Q1gZHIW9QrwGH+N4xSMbbSi0m9mX2ZQ8R/a80nPC7SV4lAUF9Y4AziUTNqn8wBAxzDQgMSRnStEY9znSWkvwvAbVrTBZr8CD0cJFFJLqxHXXX4RCiaV2VhU7ZNT2N12c4ZQ/hzTWgnV+4gL665S8fEF6UfAJLMh1OZAAgnBrcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388723; c=relaxed/simple;
	bh=oc41hs0syZx7x+SmN0G1ExsP1ItElsWVWxavc0ZAxT4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=itKmyWlCgWh7XqDWth+28zrPlE/D3WUafDlDfBAyhf0NQKcLOkJ7FtCr8h7YMEjfK9aOcjQsC+meT6nPmSIjNR0Bmc5MZl4tk/+y61xJirxJQYBzR3FWX3HQe65Lwuc7bYtq5pJQVHmwFDbBjz5A2F+d/oxSy+RefMyj0hCul3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cg+Ynwgf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713388720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vTu3anhq0IZZILMeBvCmREvzv00DpkjjYXZaTD+Neb0=;
	b=cg+YnwgfNgE/8foqKYbg9q6/4LG1qW+j/LwzF6nXoHYwvVAhpQtFwIeVi1yIlM8hqSFsW3
	wJWvEvl5xVZS8HynQBBQqGjoUSTBlGn3geJjzOAYS4a8+CUlDH7a31bm1I57J18oILP2uY
	Rao7sK1JDazdyd3L2ZoJ4VlBYFydFeY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-ZoAHdBWxM6qjwtgIfEqD_Q-1; Wed, 17 Apr 2024 17:18:39 -0400
X-MC-Unique: ZoAHdBWxM6qjwtgIfEqD_Q-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-437972269edso195351cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713388718; x=1713993518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTu3anhq0IZZILMeBvCmREvzv00DpkjjYXZaTD+Neb0=;
        b=fusp3o9iNhmA0sJ8xxBFTHQdjPRse3ipLTWtoV0+FW6buK+DIvxnSCHwrg+hDDy250
         RoCFi88JzdetEqEq+lX3fSLtTOo/iGo0zy/egSapir0nVhtfVwj2CZbRGeMFf1C/6WvE
         /J69iZnB+CYqe3+TeqyZ3goX/iknxNklciU5/qoZA993zY2BXDTDmCb8VpWN2JiYkfrZ
         Bgeo7uZkm5fTx0R/eN7J5lBjCPNFDHNAa2DmvfgOXwbsBmoHScSRPzjxP3NSjXaZE1co
         OZNm1K5/CaSKrKqZhx8NErtoDK8gJo4NtGl5+MDwPBFZ1ch9dGBLMQ6fVI7DGEQ5ePlv
         9h5w==
X-Forwarded-Encrypted: i=1; AJvYcCWIQU8y8ZiIbIRphufXraipeftW1ZB2+TtGnigHsnJSBivF2jf8+0l1awwMmSno95a6vod8fc88PnOxKyzWb+TwntKVlKJpnH4CGTE7
X-Gm-Message-State: AOJu0YxLzUHtdeNbFYGJLOu+n9pVQrhXqg/G7PWRhM6jOH8Dwtkgj+no
	OSbkylAG1v4FeM7B7qw4VVYCbC48DaeiVMXCDshKDcAr1VrqRq/VFgW7HrjqG+w5O6U4PAKQXZN
	YnoM7BFVV/dMNUD/0+09I7WemWoqJ4JhnWBeHmMw57WBhp1MLrSlhFEbp2YvGSg==
X-Received: by 2002:a05:620a:2947:b0:78e:e679:23d2 with SMTP id n7-20020a05620a294700b0078ee67923d2mr680219qkp.7.1713388718579;
        Wed, 17 Apr 2024 14:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7dVDWbsvq+PzxW8rqrQUPsjQ4Sop260aGt90/roha0tRoR1SLlb/5RadorHAHoqKgMKleDQ==
X-Received: by 2002:a05:620a:2947:b0:78e:e679:23d2 with SMTP id n7-20020a05620a294700b0078ee67923d2mr680190qkp.7.1713388717929;
        Wed, 17 Apr 2024 14:18:37 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id c10-20020a37e10a000000b0078d667d1085sm18692qkm.84.2024.04.17.14.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:18:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH 0/3] mm/hugetlb: Fix missing hugetlb_lock for memcg resv uncharge
Date: Wed, 17 Apr 2024 17:18:33 -0400
Message-ID: <20240417211836.2742593-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Should fix the recent syzbot report for:

https://lore.kernel.org/all/000000000000ee06de0616177560@google.com/

Patch 1 is a small fixup where I notice mm-unstable crashes with the new
hugetlb memcg accounting when testing the changes.

Patch 2 should be the fix to the reported issue.

Patch 3 is an oneliner to add an assertion similar to what found the issue
in patch 2.

Only smoke tested over a bunch of hugetlb unit tests.  Reviews welcomed.

Thanks,

Peter Xu (3):
  fixup! mm: always initialise folio->_deferred_list
  mm/hugetlb: Fix missing hugetlb_lock for resv uncharge
  mm/hugetlb: Assert hugetlb_lock in __hugetlb_cgroup_commit_charge

 mm/hugetlb.c        | 5 ++++-
 mm/hugetlb_cgroup.c | 2 +-
 mm/memcontrol.c     | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.44.0


