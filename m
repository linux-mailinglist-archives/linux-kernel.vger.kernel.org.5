Return-Path: <linux-kernel+bounces-109274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452A881716
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D3A1C20D6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E19B6AF99;
	Wed, 20 Mar 2024 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uJdypPhT"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BFC6A8C3
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957896; cv=none; b=Hz1qmtzOSyOolruF21o20J8Bs8nSr+4e6pdzcQyK0xlPQ8j2l7Q6S1b0QqjxPOd4WAe5PHVNnbZGpY1WcszUnV3t95QMI6dPTksl3KGb4xkTTMXX0V+gA2N1dV3avGE7u9LxYrA8M/5cMosNjDJ3ubIUIHzi/mmSxBFzxIUnG0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957896; c=relaxed/simple;
	bh=/g99FMCyF1VsqnwHUognHDndYjr+OUIU78FiVGrUc8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qlv1MaHD6W1gHGvcr/PYGTaPzB69294XjPpRiE7at2yaaVLOnlB8IiRKi1jsKloce0iimjy4S8dy/7i+bTZuCNIjeACaenjeh9oweuTlbzFyoOJcw1gG0bZTrmbfv3OLnqAZHYN4QN9qSAf24J8dj5dyijpyvliETlQVV4jLlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uJdypPhT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430acf667afso984571cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957891; x=1711562691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hok1is7g7Zb/3Dq95nz5gC21SpgfU8OMT2/ZL0zycfk=;
        b=uJdypPhToY2hzQdSHFONvOzNzLNfQ9WNPnyQCD/e5Wakur607TPAb/nq2/O4ZaD8oX
         S1cPYEnbh41hhWnQFsiUUAM9RHmWg/v1k+Bbe5cq7BnIPcszUHfHK+iRPthsspWs0ZNf
         Pbo4cxfA08A4VRZlmtx/Znsnyjo44RS2XXWWiQKu3lOuqtcLU75yHAuHLATbzVHomDHz
         n3y30P8CgyR4/7ydP/oRmOn07Zr+cK/2bBTSnY8SiOYHAxh0zqqpLs1y9xxI5f3SB09j
         LQwjaRELa3b6AC21/oLs/dNmqZhYLDjKMKoYKgc3ZTJLi0A5AnTaS9o4FzFnwgvgglv8
         SroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957891; x=1711562691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hok1is7g7Zb/3Dq95nz5gC21SpgfU8OMT2/ZL0zycfk=;
        b=wl71UV6rwaZLG4Shzwo2KTgHaLSOFSvZHq7WJoIgRvEsN+wKG6JcBUTW6tuqmoXvbc
         J+mRyrJhEVdGpqnK7cUHQY2GZ+5Kv6iFXbSFM9OXB7WCCr2EAMj1WYDLmUNCuhHr7l3O
         4efF3vx0bi4EOgnpb+Y4IhnZj6X0iiHhcOTixTtyqtrrfAaO+ky9BcjGv+x/n7hsxq5x
         l6kaI/zYbrrBREUHdfIQcXRLwhhS9o3dS6EOSdeHUqoXUvLe0tkXq/eJIxQ81PN3sBkn
         +fynmqF0jzc8d3d+Uly4EYc3ZR7B/Nmf/Kfv4DS613OYdSzuw176c++QZ70MPcABDTrv
         0Yzg==
X-Forwarded-Encrypted: i=1; AJvYcCXPE+Xh1T66k5ilIIB5PkMPVHg3BFz4KXIpW8H/1+6zYCtL1TVbOY0jeznsaVNfWTwwHM6KHklghA8Kfe3YpkmFItgU+h9i/WcbSWtx
X-Gm-Message-State: AOJu0YzZ7IhRovvXeFyUlrpT4jH9QASN2ZXbXc4i5sJsZMMvOexfI40P
	/eWlgVo2KiAc4korXnpq8Fi2qmXzBdsT7sb0ldvqLDFpjUCfXiuGRzIwT9Ewhg9Jyul6Xf1xlV9
	7
X-Google-Smtp-Source: AGHT+IFw5Y6Fl0V5Gpoz4wStEblDo0MiKsqpxBMt3xu4UrsKdUC5SoTseBm34qKf4NrikAG0kBhbrA==
X-Received: by 2002:ac8:5809:0:b0:430:ddc3:d559 with SMTP id g9-20020ac85809000000b00430ddc3d559mr7217593qtg.12.1710957891149;
        Wed, 20 Mar 2024 11:04:51 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id cn7-20020a05622a248700b00430b60698e9sm6156005qtb.32.2024.03.20.11.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:04:50 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 00/10] mm: page_alloc: freelist migratetype hygiene
Date: Wed, 20 Mar 2024 14:02:05 -0400
Message-ID: <20240320180429.678181-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V4:
- fixed !pcp_order_allowed() case in free_unref_folios()
- reworded the patch 0 changelog a bit for the git log
- rebased to mm-everything-2024-03-19-23-01
- runtime-tested again with various CONFIG_DEBUG_FOOs enabled

---

The page allocator's mobility grouping is intended to keep unmovable
pages separate from reclaimable/compactable ones to allow on-demand
defragmentation for higher-order allocations and huge pages.

Currently, there are several places where accidental type mixing
occurs: an allocation asks for a page of a certain migratetype and
receives another. This ruins pageblocks for compaction, which in turn
makes allocating huge pages more expensive and less reliable.

The series addresses those causes. The last patch adds type checks on
all freelist movements to prevent new violations being introduced.

The benefits can be seen in a mixed workload that stresses the machine
with a memcache-type workload and a kernel build job while
periodically attempting to allocate batches of THP. The following data
is aggregated over 50 consecutive defconfig builds:

                                                        VANILLA                 PATCHED
Hugealloc Time mean                      165843.93 (    +0.00%)  113025.88 (   -31.85%)
Hugealloc Time stddev                    158957.35 (    +0.00%)  114716.07 (   -27.83%)
Kbuild Real time                            310.24 (    +0.00%)     300.73 (    -3.06%)
Kbuild User time                           1271.13 (    +0.00%)    1259.42 (    -0.92%)
Kbuild System time                          582.02 (    +0.00%)     559.79 (    -3.81%)
THP fault alloc                           30585.14 (    +0.00%)   40853.62 (   +33.57%)
THP fault fallback                        36626.46 (    +0.00%)   26357.62 (   -28.04%)
THP fault fail rate %                        54.49 (    +0.00%)      39.22 (   -27.53%)
Pagealloc fallback                         1328.00 (    +0.00%)       1.00 (   -99.85%)
Pagealloc type mismatch                  181009.50 (    +0.00%)       0.00 (  -100.00%)
Direct compact stall                        434.56 (    +0.00%)     257.66 (   -40.61%)
Direct compact fail                         421.70 (    +0.00%)     249.94 (   -40.63%)
Direct compact success                       12.86 (    +0.00%)       7.72 (   -37.09%)
Direct compact success rate %                 2.86 (    +0.00%)       2.82 (    -0.96%)
Compact daemon scanned migrate          3370059.62 (    +0.00%) 3612054.76 (    +7.18%)
Compact daemon scanned free             7718439.20 (    +0.00%) 5386385.02 (   -30.21%)
Compact direct scanned migrate           309248.62 (    +0.00%)  176721.04 (   -42.85%)
Compact direct scanned free              433582.84 (    +0.00%)  315727.66 (   -27.18%)
Compact migrate scanned daemon %             91.20 (    +0.00%)      94.48 (    +3.56%)
Compact free scanned daemon %                94.58 (    +0.00%)      94.42 (    -0.16%)
Compact total migrate scanned           3679308.24 (    +0.00%) 3788775.80 (    +2.98%)
Compact total free scanned              8152022.04 (    +0.00%) 5702112.68 (   -30.05%)
Alloc stall                                 872.04 (    +0.00%)    5156.12 (  +490.71%)
Pages kswapd scanned                     510645.86 (    +0.00%)    3394.94 (   -99.33%)
Pages kswapd reclaimed                   134811.62 (    +0.00%)    2701.26 (   -98.00%)
Pages direct scanned                      99546.06 (    +0.00%)  376407.52 (  +278.12%)
Pages direct reclaimed                    62123.40 (    +0.00%)  289535.70 (  +366.06%)
Pages total scanned                      610191.92 (    +0.00%)  379802.46 (   -37.76%)
Pages scanned kswapd %                       76.36 (    +0.00%)       0.10 (   -98.58%)
Swap out                                  12057.54 (    +0.00%)   15022.98 (   +24.59%)
Swap in                                     209.16 (    +0.00%)     256.48 (   +22.52%)
File refaults                             17701.64 (    +0.00%)   11765.40 (   -33.53%)

Huge page success rate is higher, allocation latencies are shorter and
more predictable.

Stealing (fallback) rate is drastically reduced. Notably, while the
vanilla kernel keeps doing fallbacks on an ongoing basis, the patched
kernel enters a steady state once the distribution of block types is
adequate for the workload. Steals over 50 runs:

VANILLA         PATCHED
1504.0		227.0
1557.0		6.0
1391.0		13.0
1080.0		26.0
1057.0		40.0
1156.0		6.0
805.0		46.0
736.0		20.0
1747.0		2.0
1699.0		34.0
1269.0		13.0
1858.0		12.0
907.0		4.0
727.0		2.0
563.0		2.0
3094.0		2.0
10211.0		3.0
2621.0		1.0
5508.0		2.0
1060.0		2.0
538.0		3.0
5773.0		2.0
2199.0		0.0
3781.0		2.0
1387.0		1.0
4977.0		0.0
2865.0		1.0
1814.0		1.0
3739.0		1.0
6857.0		0.0
382.0		0.0
407.0		1.0
3784.0		0.0
297.0		0.0
298.0		0.0
6636.0		0.0
4188.0		0.0
242.0		0.0
9960.0		0.0
5816.0		0.0
354.0		0.0
287.0		0.0
261.0		0.0
140.0		1.0
2065.0		0.0
312.0		0.0
331.0		0.0
164.0		0.0
465.0		1.0
219.0		0.0

Type mismatches are down too. Those count every time an allocation
request asks for one migratetype and gets another. This can still
occur minimally in the patched kernel due to non-stealing fallbacks,
but it's quite rare and follows the pattern of overall fallbacks -
once the block type distribution settles, mismatches cease as well:

VANILLA:        PATCHED:
182602.0	268.0
135794.0	20.0
88619.0		19.0
95973.0		0.0
129590.0	0.0
129298.0	0.0
147134.0	0.0
230854.0	0.0
239709.0	0.0
137670.0	0.0
132430.0	0.0
65712.0		0.0
57901.0		0.0
67506.0		0.0
63565.0		4.0
34806.0		0.0
42962.0		0.0
32406.0		0.0
38668.0		0.0
61356.0		0.0
57800.0		0.0
41435.0		0.0
83456.0		0.0
65048.0		0.0
28955.0		0.0
47597.0		0.0
75117.0		0.0
55564.0		0.0
38280.0		0.0
52404.0		0.0
26264.0		0.0
37538.0		0.0
19671.0		0.0
30936.0		0.0
26933.0		0.0
16962.0		0.0
44554.0		0.0
46352.0		0.0
24995.0		0.0
35152.0		0.0
12823.0		0.0
21583.0		0.0
18129.0		0.0
31693.0		0.0
28745.0		0.0
33308.0		0.0
31114.0		0.0
35034.0		0.0
12111.0		0.0
24885.0		0.0

Compaction work is markedly reduced despite much better THP rates.

In the vanilla kernel, reclaim seems to have been driven primarily by
watermark boosting that happens as a result of fallbacks. With those
all but eliminated, watermarks average lower and kswapd does less
work. The uptick in direct reclaim is because THP requests have to
fend for themselves more often - which is intended policy right
now. Aggregate reclaim activity is lowered significantly, though.

---

V3:
- fixed freelist type violations from non-atomic page isolation
  updates (Zi Yan)
- fixed incorrect migratetype update ordering during merge (Vlastimil Babka)
- reject moving a zone-straddling block altogether (Vlastimil Babka)
- fixed freelist type violations from lockless migratetype lookups in
  cornercase freeing paths (Vlastimil Babka)
- fixed erroneous WARN in the bulk freeing path that was intended to catch
  mistakes in the now-removed pcpcache (Mike Kravetz)
- fixed typo in patch 1's changelog (Zi Yan)
- optimized migratetype lookup in free_unref_page_list() (Vlastimil Babka)
- batched vmstat updates in page merging hot path (Vlastimil Babka)
- rebased to mm-everything-2024-03-05-20-43 (v6.8-rc5+)

V2:
- dropped the get_pfnblock_migratetype() optimization
  patchlet since somebody else beat me to it (thanks Zi)
- broke out pcp bypass fix since somebody else reported the bug:
  https://lore.kernel.org/linux-mm/20230911181108.GA104295@cmpxchg.org/
- fixed the CONFIG_UNACCEPTED_MEMORY build (lkp)
- rebased to v6.6-rc1

 include/linux/mm.h             |  18 +-
 include/linux/page-isolation.h |   5 +-
 include/linux/vmstat.h         |   8 -
 mm/debug_page_alloc.c          |  12 +-
 mm/internal.h                  |   9 -
 mm/page_alloc.c                | 650 +++++++++++++++++++++------------------
 mm/page_isolation.c            | 122 +++-----
 7 files changed, 415 insertions(+), 409 deletions(-)

Based on mm-everything-2024-03-19-23-01.


