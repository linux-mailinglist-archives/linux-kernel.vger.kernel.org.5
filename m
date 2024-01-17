Return-Path: <linux-kernel+bounces-28722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE5783023F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F546285FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CAE14AA2;
	Wed, 17 Jan 2024 09:23:49 +0000 (UTC)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7814A8E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705483429; cv=none; b=idBrDgoAJog/Gry/xPcHZSQ5ysVfddPJgWpNCrvmJWsWXgdzghB4cSGhLZma03C2Z4h3M4ukRZh1+edMBojsv7pJhQ40uZz8TBDVu1Q73RUZY9aWCst2imTXeUzPlavSPDPPZq3o7BNTTPflyNNnpG/S1d4f0kS5HHqm6/+3kGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705483429; c=relaxed/simple;
	bh=clwC7ehDjjgIdT3ugd8uEArThiV73YZzLeU9DE/pKIE=;
	h=Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-b4-tracking:X-Report-Abuse:From:Date:Message-Id:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Migadu-Flow; b=XeiOCIWulni6LkSX1U2/Rw7mmcxPjzd2cpQ4EfaRNsNwP0MRro7UadaoLEUx1yYHyNwjanFy6DJyBhS84UsKUoS1RNzwvwGJyR7IBdyfUI6CZi3QJj8to7//dZ8olG/BQjL+F/fjh+osMgTwDjI0qfy+HVIqwRg/ZetoE+yzzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/2] mm/zswap: optimize the scalability of zswap rb-tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAIWcp2UC/w3LUQrDIAwA0KuUfDdgXEDYbdSGNcxpMe0GLb37/Hwf7wKTrmLwnC7o8lXTVgdoni
 Cvsb4EdRkG7zw7ooCJ8bRf3LC0/Ma27frRU5BZXKBMD/YBRk7RBFOPNa+j16OU+/4DWfTtvG0AAAA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 17 Jan 2024 09:23:17 +0000
Message-Id: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705483421; l=1680;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=clwC7ehDjjgIdT3ugd8uEArThiV73YZzLeU9DE/pKIE=;
 b=HqTFINfUAwt7GkI4Tqp4Be3g6BZ2NL7GR/khpO5sbZCsMZ8N4CnC97mwpT5phVZk4V40/Nxzk
 S6xcqcZ4vpwCWp2BmFZbHEqJu+90vlYssIkCMSa/5vQg3dLfUoZAvwL
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

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
 mm/swapfile.c         | 10 ++++---
 mm/zswap.c            | 74 ++++++++++++++++++++++++++++++++-------------------
 3 files changed, 59 insertions(+), 32 deletions(-)
---
base-commit: ab27740f76654ed58dd32ac0ba0031c18a6dea3b
change-id: 20240117-b4-zswap-lock-optimize-44e071c13427

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

