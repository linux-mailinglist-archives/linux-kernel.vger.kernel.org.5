Return-Path: <linux-kernel+bounces-114689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF2888BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6286F296562
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF662B8509;
	Mon, 25 Mar 2024 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ/RjUPI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCEB15FA64;
	Sun, 24 Mar 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322351; cv=none; b=NBL1GhxOY1u42w1/Ia9ap9LaYIPPKRI5RPBNmuBRsYf/fN7px0T4eLX8UVk9B9JSvnpIg+1d2DGeKCxrgJ8sLhcShqmpHRtCh7ZWwXd+sVw7vkI0B2SV43dKMKA3c2PCaqBUy8EA49x7EbNBWS6N2yDiIyQe5IFGODfN7A3JJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322351; c=relaxed/simple;
	bh=D3t/h4cU9xGd0/TqJ899dIcJhh3AC3fyHdtPtypVFXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVJum1w3dnv9EDpohPQ/3FPuqL9Kud99tf2dK5di/81eqz/wqEeHJx/gE0YueOjht4oVrFmpX7Ro7OkUA0x38XEDoY/aKJNN/DJjPAa3JhP/OtlAlNWcitF8HnBjSCLx5p/hCWO58KY4OwieRmGBAMjpJhvowNiwLC0/FCzoreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ/RjUPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C74C433C7;
	Sun, 24 Mar 2024 23:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322351;
	bh=D3t/h4cU9xGd0/TqJ899dIcJhh3AC3fyHdtPtypVFXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJ/RjUPIXNAVv3xnHrkg74uV6hNdoTjadDFhH/K3/G9h5yZmlmNyqg6uycdP300j5
	 bPtV6j9d+3YmgXAgApwsq7bKBR4yZvCAJpv8NffSAdlMAnjbl0Ca+2UVOkqFXMJHZC
	 9w9kbndtA71YnA0wzuHVswzCUWvdFLJLFh2+1QnSrSHKV9j6xKvh2xJBcRo4GUbcCT
	 uGH4mCtkDThkB37vbkVxgo3IROj29FYeRe7WXrMZr5WCLYq+MdG95AaXU8ciPRvgDQ
	 wswjB2Q3jE5dpVnRaw0jikvRJKC8O7VStSFIEa47CtMOuHKiqw9HCxmBVJY/x2Ge1/
	 bzK3Ll4w2xVhg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Sunil Goutham <sgoutham@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Srujana Challa <schalla@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	netdev@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 433/451] net: octeontx2: Use alloc_ordered_workqueue() to create ordered workqueues
Date: Sun, 24 Mar 2024 19:11:49 -0400
Message-ID: <20240324231207.1351418-434-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 289f97467480266f9bd8cac7f1e05a478d523f79 ]

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Sunil Goutham <sgoutham@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: Srujana Challa <schalla@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org
Stable-dep-of: 7558ce0d974c ("octeontx2-pf: Use default max_active works instead of one")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c     |  5 ++---
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c    | 13 +++++--------
 .../net/ethernet/marvell/octeontx2/nic/otx2_vf.c    |  5 ++---
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 59e6442ddf4a4..a7965b457bee9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3055,9 +3055,8 @@ static int rvu_flr_init(struct rvu *rvu)
 			    cfg | BIT_ULL(22));
 	}
 
-	rvu->flr_wq = alloc_workqueue("rvu_afpf_flr",
-				      WQ_UNBOUND | WQ_HIGHPRI | WQ_MEM_RECLAIM,
-				       1);
+	rvu->flr_wq = alloc_ordered_workqueue("rvu_afpf_flr",
+					      WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!rvu->flr_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 05ee55022b92c..3f044b161e8bf 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -272,8 +272,7 @@ static int otx2_pf_flr_init(struct otx2_nic *pf, int num_vfs)
 {
 	int vf;
 
-	pf->flr_wq = alloc_workqueue("otx2_pf_flr_wq",
-				     WQ_UNBOUND | WQ_HIGHPRI, 1);
+	pf->flr_wq = alloc_ordered_workqueue("otx2_pf_flr_wq", WQ_HIGHPRI);
 	if (!pf->flr_wq)
 		return -ENOMEM;
 
@@ -584,9 +583,8 @@ static int otx2_pfvf_mbox_init(struct otx2_nic *pf, int numvfs)
 	if (!pf->mbox_pfvf)
 		return -ENOMEM;
 
-	pf->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
-					   WQ_UNBOUND | WQ_HIGHPRI |
-					   WQ_MEM_RECLAIM, 1);
+	pf->mbox_pfvf_wq = alloc_ordered_workqueue("otx2_pfvf_mailbox",
+						   WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!pf->mbox_pfvf_wq)
 		return -ENOMEM;
 
@@ -1088,9 +1086,8 @@ static int otx2_pfaf_mbox_init(struct otx2_nic *pf)
 	int err;
 
 	mbox->pfvf = pf;
-	pf->mbox_wq = alloc_workqueue("otx2_pfaf_mailbox",
-				      WQ_UNBOUND | WQ_HIGHPRI |
-				      WQ_MEM_RECLAIM, 1);
+	pf->mbox_wq = alloc_ordered_workqueue("otx2_pfaf_mailbox",
+					      WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!pf->mbox_wq)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index 68fef947ccced..dcb8190de2407 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -308,9 +308,8 @@ static int otx2vf_vfaf_mbox_init(struct otx2_nic *vf)
 	int err;
 
 	mbox->pfvf = vf;
-	vf->mbox_wq = alloc_workqueue("otx2_vfaf_mailbox",
-				      WQ_UNBOUND | WQ_HIGHPRI |
-				      WQ_MEM_RECLAIM, 1);
+	vf->mbox_wq = alloc_ordered_workqueue("otx2_vfaf_mailbox",
+					      WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!vf->mbox_wq)
 		return -ENOMEM;
 
-- 
2.43.0


