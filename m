Return-Path: <linux-kernel+bounces-57197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72E584D504
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E19F1F237C1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409CE692FD;
	Wed,  7 Feb 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQZwmWRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C105692EC;
	Wed,  7 Feb 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341206; cv=none; b=qgpRI5+XyY7tEqgX7IBDcG1Hb8fCgkUANZey7OQgdyDVAk5avCMNGWbQ0JQl+7Cm2iMOWQVSXovjf54Z5E6ygOVsTWyES+vBj7BlnBJB3h/mKJ9IVKtiIvI++Q0I/3FJevWyOOOb2f/ynaqP+VbnWGKkJoswRosEKEoyn8hpQ8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341206; c=relaxed/simple;
	bh=hoHS8WJ1bCxJD7223y6b4qAhyH6ShPuiSM0HyRAfLpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPPRDkn1Ra4UOZ9Xjpj21dvnVRjDvXzdd0rMTQjGwHwXQlCoS4Px0A3ckYmxIxQozd2geBVqQtbUjmCqgzxDdUaPdwzjmzV0IJDYri7lYsiKZCviodTVWj6EVAg65eloZ/ho9hnE0ofxQYi/BqPIKxPuA516v/GbydmPDKbCz3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQZwmWRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E1DC43390;
	Wed,  7 Feb 2024 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341206;
	bh=hoHS8WJ1bCxJD7223y6b4qAhyH6ShPuiSM0HyRAfLpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQZwmWRc8+dE0TbLlCyF8fOkXI9CVrdB7puTRVIICaz1Y9/Kg2UnnIgRnrMuWszwE
	 YVeg8t3zvLlwBnZpVMPLd8n+CqgDJQ1UtEEcVtZLfsaCqKOgmcuwrw1+nNFgKD+DaP
	 hJ98ElW/VVp4/KmCnV2MZN9k6XjxXXElIFTqz8eR11TzY+ltZpS/YKDp5uNbqpnIFI
	 JhSaSpdRyXRWbdQiDVLay7E+lrEgx/qg6+WiG5vbBPmGfxntLBptHA0qg7kNH1/kOw
	 k+QKKTYFZdbjp2swKg//1Qsr/VpiXrlBXZpLO3P5Xep0Q0Rx2UwOTAX7U5VbAnCnE1
	 toWjVdpu8nXGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 18/23] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:25:59 -0500
Message-ID: <20240207212611.3793-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit ca121a0f7515591dba0eb5532bfa7ace4dc153ce ]

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 97f4ec37f36d..06d11bb7b944 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1069,8 +1069,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


