Return-Path: <linux-kernel+bounces-57102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC0C84D40B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682E3284B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02913BE90;
	Wed,  7 Feb 2024 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfnrQX6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97F13B7B0;
	Wed,  7 Feb 2024 21:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340990; cv=none; b=IL1/5IP6IumjTdmxM5nkRYVwNtI/GMay9K4XJF6Lu097LncylfwLTWsCK4TCrjy/AizUMApRq4e7HErB+8T1RJDe0BgbuVFb15xi8VF8CjhWpTzH0b7Bu754LmXbFsjA5Fd1DwaH7bK0944X0Sc2vLlramUIVSjqfm7UOpyMHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340990; c=relaxed/simple;
	bh=jn8CVBM55Gc4xDsM9BKIXkqAVUal6LD7IM+rOMVXPYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjNHUby+2rEpbCmtqWfvLCSFce6YwC31ej6nXr9e6+20ZZE0QefUHAK1yfGIa7/1QzNwZASiWMmPxNVg2yDl2q7h7hn75RJjZKu+6oNf6CzWuMKt71uhWjQD8UzmL9AaHfRggLI6WuInix+LXkNi68WBqHn61HR10FfTUZp6E4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfnrQX6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DDBC43390;
	Wed,  7 Feb 2024 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340989;
	bh=jn8CVBM55Gc4xDsM9BKIXkqAVUal6LD7IM+rOMVXPYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfnrQX6hZjT+JS5EwAdbjFho9pLJC65ElJZQL+EBiXX2oBgEB6aRc6FdeSGvODf8R
	 fsX1xBE08ILpJb/t6bjU1+v1zO/TqMpuaFzC+PCvjUT1mmfrdn7/lOin+Zg3vOG9t3
	 BWQqa3T/Jmb+Mzr/nEuE2rRCUHesetx+iq4gUKnzQlh7ikQySACCLUc436CGdQkcmT
	 SDBR/AsekV0QVf9I90Ymbl0WbKkEAc7mr9kIVcScFi3OBY6kOQhKoJccLBZF0Fn6Nj
	 mPD7o21bvyZrytOdlGTS5aFFLrWy194K3EurbbC1o9IvghxCPo/3/AEqLKXsAIKea2
	 GlixnMH7L+law==
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
Subject: [PATCH AUTOSEL 6.7 36/44] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:21:03 -0500
Message-ID: <20240207212142.1399-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 5fd37e989106..6d111b03d371 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1068,8 +1068,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
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


