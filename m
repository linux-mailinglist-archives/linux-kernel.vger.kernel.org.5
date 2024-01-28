Return-Path: <linux-kernel+bounces-41629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F9783F598
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 14:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C470D1C210F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E92324B57;
	Sun, 28 Jan 2024 13:29:03 +0000 (UTC)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125024208
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 13:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706448543; cv=none; b=qMjEyeYL5WfY2up4A74Pf7PlWN+qdwDLvjyEK8Bq/JX/qtEkpEhMXvaWkW+yv5/RfNkuzc1JsN3ql2hRobz2EydcChKDH7Q2zTRbGQi2W2qscaLOqPih7IbVpm/I+5f8Ebp0T74y1TV2T6b8WjwkT15c+Nu8iJr/8aXJir2Wqq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706448543; c=relaxed/simple;
	bh=dWbGtbEMBMFYMR3C/ud22kaKap4o7b4BCbU9hiNRVfI=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=Rq8P5cPsA5HhRmgB01ADl8t6TFOLdVCjz5NBU9CaLDov6g6FMqOtviCkXWez+DM+QgItw9wE+cAVI5CRbRJ0cSyW8Tq8TDd68b9GmLedY0Y0rLmN6M+76J20qbPLzMomBS+TQklDg6WLbNVgQL12x1z/Rlz5AUMU5EWz8OdGWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH v2 0/3] mm/zswap: fix race between lru writeback and swapoff
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAJBWtmUC/w3LQQqEMAwAwK9IzhuoURT8TVqDBqVKoiso/t0e5zAPuJiKw1A9YPJX1y0X0K+CNH
 OeBHUsBgrUhpo6vP3iHS/TQyKnBY2TIPV9EyVww2MLpUZ2wWic01xyPtf1fT81pNc3awAAAA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 28 Jan 2024 13:28:48 +0000
Message-Id: <20240126-zswap-writeback-race-v2-0-b10479847099@bytedance.com>
To: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chriscli@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Migadu-Flow: FLOW_OUT

This is based on mm-unstable and the "mm: zswap: fix missing folio cleanup
in writeback race path" patch [1].

Changes in v2:
- Append a patch to remove list_lru_putback() since its only user
  in zswap has gone, per Nhat.
- Improve the commit messages per Johannes.
- Add comments about the lru rotate in shrink_memcg_cb() per Johannes.
- Collect tags.
- Link to v1: https://lore.kernel.org/all/20240126083015.3557006-1-chengming.zhou@linux.dev/

This series mainly fix the race problem between lru writeback and swapoff,
which is spotted by Yosry [2]. Please see the commits for details.

Thanks for review and comments!

[1] https://lore.kernel.org/all/20240125085127.1327013-1-yosryahmed@google.com/
[2] https://lore.kernel.org/all/CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (3):
      mm/zswap: don't return LRU_SKIP if we have dropped lru lock
      mm/zswap: fix race between lru writeback and swapoff
      mm/list_lru: remove list_lru_putback()

 include/linux/list_lru.h |  16 -------
 mm/list_lru.c            |  14 ------
 mm/zswap.c               | 120 ++++++++++++++++++++---------------------------
 3 files changed, 51 insertions(+), 99 deletions(-)
---
base-commit: 13d63cb513841433b69564b07614169e61113720
change-id: 20240126-zswap-writeback-race-2773be0a3ad4

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

