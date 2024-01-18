Return-Path: <linux-kernel+bounces-29678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B295183119F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 04:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29A3E1F228CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32500566D;
	Thu, 18 Jan 2024 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fvm0Zspz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512F433D3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705547160; cv=none; b=uvOP186jsuq3Oe5xAoTSzAq5jRSI5qnBBZDsoJOde+92Xf/xp9mWbm5FUeBwAkF+qXzHri6RIUhYldHQPzd1QaZksi2cjyJLgB3oH4zfJLAdqhwF1l+3bVGLVYyxAXCvuK3OQu2f9sRL+ZroLdhKXc6CYTXzzjlbihQkPxtV2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705547160; c=relaxed/simple;
	bh=OKgJl85PBzkDLOECRXoBFZ9nSFWwN6N+G8E0iFDjg2w=;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:
	 X-Mailer; b=my8pc5nSg/9xbLzk5SqNgDyZwIF0DmbXB3i4Lw0oKedvX6gGvwcRIi8CzLhpzwPWlfA8E9yfItn/bV02j9hBmjHU5bcQzWXBzcYWaIhVNIKCKd8AKlhkVhbqrsfwZ0NUQHFzd5SMUC57f+MowRllVVwumROkqOWS5dsgdez8xeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fvm0Zspz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80460C433C7;
	Thu, 18 Jan 2024 03:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705547159;
	bh=OKgJl85PBzkDLOECRXoBFZ9nSFWwN6N+G8E0iFDjg2w=;
	h=From:Subject:Date:To:Cc:From;
	b=Fvm0Zspz/CNN5KQ3c3PT8DPP7tlnCcuqAG6lVMLeHgcYHdXPeaRYafbaM/Pzef+/8
	 xp40ZaUpHNnFQ64XyvwdFxQTxYv06XkirXjv1wIP3xzceM5JeJvnPzsJxcILCgDQdK
	 5A35efQm7HP3sbTsfzPNzXUWuXLbs01LJwU9cbrHvM+WEDtZc3B1XKqGUnL7kp3TIv
	 kUrL8+dVI52kKeUSWHpc+zOINfEWIrsKvSc+44O+tuxjfu30lIDCGh22daQAxhyLS2
	 XIAhV78mkrVxgPzR5OMIFBpu32N2pO8rDmMds48kRbY4LRjyUTfqFBtCMy5QIa8rU4
	 AGn97B1AvF4sw==
From: Chris Li <chrisl@kernel.org>
Subject: [PATCH 0/2] RFC: zswap tree use xarray instead of RB tree
Date: Wed, 17 Jan 2024 19:05:40 -0800
Message-Id: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAISVqGUC/x3MQQqAIBBA0avIrBPUzKCrRAupqWZjMkJZ0t2Tl
 m/xf4GETJhgEAUYT0p0hArdCJh3HzaUtFSDUcYqrax80uWjzJ7Z37LXzjiFndXYQk0i40r5343
 T+36OfBucXgAAAA==
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 =?utf-8?q?Wei_Xu=EF=BF=BC?= <weixugc@google.com>, 
 Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, 
 Chun-Tse Shao <ctshao@google.com>, 
 =?utf-8?q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
 Yosry Ahmed <yosryahmed@google.com>, Brain Geffon <bgeffon@google.com>, 
 Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Kairui Song <kasong@tencent.com>, 
 Zhongkun He <hezhongkun.hzk@bytedance.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Barry Song <v-songbaohua@oppo.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Joel Fernandes <joel@joelfernandes.org>, 
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.3

The RB tree shows some contribution to the swap fault
long tail latency due to two factors:
1) RB tree requires re-balance from time to time.
2) The zswap RB tree has a tree level spin lock protecting
the tree access.

The swap cache is using xarray. The break down the swap
cache access does not have the similar long time as zswap
RB tree.

Moving the zswap entry to xarray enable read side
take read RCU lock only.

The first patch adds the xarray alongside the RB tree.
There is some debug check asserting the xarray agrees with
the RB tree results.

The second patch removes the zwap RB tree.

I expect to merge the zswap rb tree spin lock with the xarray
lock in the follow up changes.

I can surely use some help in reviewing and testing.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Chris Li (2):
      mm: zswap.c: add xarray tree to zswap
      mm: zswap.c: remove RB tree

 mm/zswap.c | 120 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 59 insertions(+), 61 deletions(-)
---
base-commit: d7ba3d7c3bf13e2faf419cce9e9bdfc3a1a50905
change-id: 20240104-zswap-xarray-716260e541e3

Best regards,
-- 
Chris Li <chrisl@kernel.org>


