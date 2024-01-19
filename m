Return-Path: <linux-kernel+bounces-31085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BA8328B1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A22E1C22715
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5C34C629;
	Fri, 19 Jan 2024 11:22:35 +0000 (UTC)
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C841C94
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705663354; cv=none; b=fZht+i89gW4IURtfXkDJFjhu1l6+SYE/58PTYjPwF7WB7PiFNSKQ7NVrObeL58Zim9oBgUnFCmU7m47Njq3Ju+/aeiGLu34gAHIyDF/1AhkRfN2bOWcF/2Q7nkiVLuLa+LdjUKc+lLC2xbsN/b77rGR3ByItNZesBD1EeQSLY60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705663354; c=relaxed/simple;
	bh=7VNhAqJoyAKSD/hQmtRytM/nCkvMMCR+Dhb06spZMzE=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=OjJnK/IzHg3AQD5U3xRQ8L69TlCOImTLFlyUvOLLwIKJqN6lUG5rWX0eyjlQLrXMmj1W6B8QwU7ZujkAF9+XMTd0TN1MoApJmti7aYjRl5CQybXFV9U9toJGLkKIeFktFsW6/mvtWhgfaag4ToaZU0ODFAk9H9AYh3c4QzeHOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v2 0/2] mm/zswap: optimize the scalability of zswap rb-tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAG1bqmUC/4WNQQ6CMBBFr0Jm7Zi2FJu48h7GRVsGmQgtaREDhLvbeAFXP+8n7/8dMiWmDNdqh0
 QLZ46hgDpV4HsbnoTcFgYllBZSGnQat/yxEw7RvzBOM4+8EWpNwkgva60MFNnZTOiSDb4vengPQyl7
 znNM6+9skSXuf3cXiQJV3V2o66gxprm5daa27NLZxxEex3F8AdSXtlPFAAAA
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Fri, 19 Jan 2024 11:22:21 +0000
Message-Id: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Chris Li <chriscli@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
 Chengming Zhou <zhouchengming@bytedance.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705663348; l=1884;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=7VNhAqJoyAKSD/hQmtRytM/nCkvMMCR+Dhb06spZMzE=;
 b=akpgee1fXkr61CWEO40WVSuXwdZrA981o4Nml3McnVIZ+zr6NdpD3PGRLWNPhgGRQNVjyVdbh
 3HfD7od0hZmCnhoGo15Elt10ueJlVkwt2zAVES5vITd8tjKnz2itDZA
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Changes in v2:
- Change swap_zswap_tree() to static inline function.
- Collect Acked-by tags.
- Link to v1: https://lore.kernel.org/r/20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com

When testing the zswap performance by using kernel build -j32 in a tmpfs
directory, I found the scalability of zswap rb-tree is not good, which
is protected by the only spinlock. That would cause heavy lock contention
if multiple tasks zswap_store/load concurrently.

So a simple solution is to split the only one zswap rb-tree into multiple
rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea is
from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks").

Although this method can't solve the spinlock contention completely, it
can mitigate much of that contention. Below is the results of kernel build
in tmpfs with zswap shrinker enabled:

     linux-next  zswap-lock-optimize
real 1m9.181s    1m3.820s
user 17m44.036s  17m40.100s
sys  7m37.297s   4m54.622s

So there are clearly improvements. And it's complementary with the ongoing
zswap xarray conversion by Chris. Anyway, I think we can also merge this
first, it's complementary IMHO. So I just refresh and resend this for
further discussion.

Thanks for review and comment!

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (2):
      mm/zswap: make sure each swapfile always have zswap rb-tree
      mm/zswap: split zswap rb-tree

 include/linux/zswap.h |  7 +++--
 mm/swapfile.c         | 10 +++++--
 mm/zswap.c            | 76 +++++++++++++++++++++++++++++++++------------------
 3 files changed, 61 insertions(+), 32 deletions(-)
---
base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
change-id: 20240117-b4-zswap-lock-optimize-44e071c13427

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

