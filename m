Return-Path: <linux-kernel+bounces-108363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60DA8809A7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA62844E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EE911187;
	Wed, 20 Mar 2024 02:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="fpxVAfG7"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FE6EBE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902545; cv=none; b=Y2d5WnufB81Mp71d+JUjkUICAoD/Yb+/pQHFjTOVBZJRYLRzi8JHOrrmmktkqPhB+8mBxNgCc1aYoSPNW+PHsTJh0j+rq6gte8DGjcm/vjpXBVWGaKFP0ErNv7lJO9fnMoOZvPam/VBp2rkx2Ip1083KINqImTOo16JAwoNJApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902545; c=relaxed/simple;
	bh=4+7yeBDlIlNtfsyPypA/l8wWYe8jf74m2alVOvnIZy8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=E5mcblp9pHQgInGf5kGeGoy3KCUCHmHf9d9ov/0zaqx5g3DzGJaMtRi8EfIgH9AiViXo7I/+/6MgGEHtHCCDLu87scXKwSmcK+JfMFvjYWUGWP6rj25cE2mI/HLnjAjTsRVyhnMpSuqfsSq5IWg59Eaq49jHotqCrS+VTX2c7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=fpxVAfG7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78a2093cd44so16734085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902540; x=1711507340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aRK0SnsjbBEzd2IgwEwXrYJHhbyBxAabDsSn4vosIOI=;
        b=fpxVAfG76tNrYIdga8oKjClWQbQ2W46FZh43ra98aqsNG+MRUhyVV8xo44ghP32rpN
         VmPYM93F91/UWC6d+kDX2T7/PvWo4t9R72x+kLXHjbzCh+314bRtH4awmpUjGNAtnS1J
         /+gCBg8TpfrJYNHgnGr5ToUjPGJM035v8CY7SZA63uU3oWEwZihzgMiaG9OsxeqQnfDW
         CGYPFa+XwST6Kg/coNoxw6yA0FUvR0iViosoWCPpM4yUFPyH7LGDh5YgqSihnHXr9IkC
         W+6qzXlMn1aHHz/xGpQTA36DvOscVPyK9qF8DgzRktNuQuaX86meRo6/4NRkNaWLuU9F
         YTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902540; x=1711507340;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRK0SnsjbBEzd2IgwEwXrYJHhbyBxAabDsSn4vosIOI=;
        b=GnwRNW0HwzyXDEeELfWHfpBtg8oJe7adAJDphdAR50BPsBDgDCqo0YSbqbPPfyAndb
         Gec4FXZFfiDmRMyc58gMw/Y4RzobdCL+Guh1/u0J1cTYCaxpWYuSPVYp8IyKXBP631VP
         JEvSQmy7dvT4vg7m1iJqXOcu9OOOuI0QGsc5I2hEg8cCoIjrVyEKzKo8mU1gR+CO8rdc
         ydqm72BKx/gTd/eRXXnKE3f0YUiWdBzy6LVygB32MJPvKvoTDLEZmAXoEvwsWvmbeCmp
         WNRpRK+KcK+Ppgry4du21/xIHzwTbNpgZhCi5d2po0Lojv1fqK3rh0nRMs/95tuptcfX
         ZsTw==
X-Forwarded-Encrypted: i=1; AJvYcCXQnPNjkQ+IHpmqlNspbbVOPLhD09++qPPnbyoS6z5UGC1eODZlY+XAV0xuVeHYhRqmEJO19N+EivrRDRmnRACLAjZEFmiNSgjQOfxc
X-Gm-Message-State: AOJu0Yz6XkrW2TLh6ZK7DLdIg5rGLeZGTrXFrGYFUYCB7agTIOfecegp
	HS26eJ2eznDYuTf32O/p+piRJe+2T7yLjACrVlOENmme79t3aazqvDTLy8RT3w==
X-Google-Smtp-Source: AGHT+IGgxtyHCap0WgtUTDWfNpHXPVzQPhVtb+cu0B/hsTClonwVi3lULn0a8bMbCW01NLLOrkZnxw==
X-Received: by 2002:ae9:e70f:0:b0:787:f739:9836 with SMTP id m15-20020ae9e70f000000b00787f7399836mr17633769qka.52.1710902540034;
        Tue, 19 Mar 2024 19:42:20 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id x6-20020a05620a448600b0078824c140b7sm6140238qkp.27.2024.03.19.19.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:19 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 0/7] mm: providing ample physical memory contiguity by confining unmovable allocations 
Date: Wed, 20 Mar 2024 02:42:11 +0000
Message-Id: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Memory capacity has increased dramatically over the last decades.
Meanwhile, TLB capacity has stagnated, causing a significant virtual
address translation overhead. As a collaboration between Carnegie Mellon
University and Meta, we investigated the issue at Meta’s datacenters and
found that about 20% of CPU cycles are spent doing page walks [1], and
similar results are also reported by Google [2]. 

To tackle the overhead, we need widespread uses of huge pages. And huge
pages, when they can actually be created, work wonders: they provide up
to 18% higher performance for Meta’s production workloads in our
experiments [1].

However, we observed that huge pages through THP are unreliable because
sufficient physical contiguity may not exist and compaction to recover
from memory fragmentation frequently fails. To ensure workloads get a
reasonable number of huge pages, Meta could not rely on THP and had to
use reserved huge pages. Proposals to add 1GB THP support [5] are even
more dependent on ample availability of physical contiguity.

A major reason for the lack of physical contiguity is the mixing of
unmovable and movable allocations, causing compaction to fail. Quoting
from [3], “in a broad sample of Meta servers, we find that unmovable
allocations make up less than 7% of total memory on average, yet occupy
34% of the 2M blocks in the system. We also found that this effect isn't
correlated with high uptimes, and that servers can get heavily
fragmented within the first hour of running a workload.”

Our proposed solution is to confine the unmovable allocations to a
separate region in physical memory. We experimented with using a CMA
region for the movable allocations, but in this version we use
ZONE_MOVABLE for movable and all other zones for unmovable allocations.
Movable allocations can temporarily reside in the unmovable zones, but
will be proactively moved out by compaction.

To resize ZONE_MOVABLE, we still rely on memory hotplug interfaces. We
export the number of pages scanned on behalf of movable or unmovable
allocations during reclaim to approximate the memory pressure in two
parts of physical memory, and a userspace tool can monitor the metrics
and make resizing decisions. Previously we augmented the PSI interface
to break down memory pressure into movable and unmovable allocation
types, but that approach enlarges the scheduler cacheline footprint.
From our preliminary observations, just looking at the per-allocation
type scanned counters and with a little tuning, it is sufficient to tell
if there is not enough memory for unmovable allocations and make
resizing decisions.

This patch extends the idea of migratetype isolation at pageblock
granularity posted earlier [3] by Johannes Weiner to an
as-large-as-needed region to better support huge pages of bigger sizes
and hardware TLB coalescing. We’re looking for feedback on the overall
direction, particularly in relation to the recent THP allocator
optimization proposal [4].

The patches are based on 6.4 and are also available on github at
https://github.com/magickaiyang/kernel-contiguous/tree/per_alloc_type_reclaim_counters_oct052023

Kaiyang Zhao (7):
  sysfs interface for the boundary of movable zone
  Disallows high-order movable allocations in other zones if
    ZONE_MOVABLE is populated
  compaction accepts a destination zone
  vmstat counter for pages migrated across zones
  proactively move pages out of unmovable zones in kcompactd
  pass gfp mask of the allocation that waked kswapd to track number of
    pages scanned on behalf of each alloc type
  exports the number of pages scanned on behalf of movable/unmovable
    allocations

 drivers/base/memory.c         |   2 +-
 drivers/base/node.c           |  32 ++++++
 include/linux/compaction.h    |   4 +-
 include/linux/memory.h        |   1 +
 include/linux/mmzone.h        |   1 +
 include/linux/vm_event_item.h |   6 +
 mm/compaction.c               | 209 ++++++++++++++++++++++++++--------
 mm/internal.h                 |   1 +
 mm/page_alloc.c               |  10 ++
 mm/vmscan.c                   |  28 ++++-
 mm/vmstat.c                   |  14 ++-
 11 files changed, 249 insertions(+), 59 deletions(-)

-- 
2.40.1


