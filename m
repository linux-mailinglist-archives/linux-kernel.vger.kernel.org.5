Return-Path: <linux-kernel+bounces-57171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3232A84D4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FD71C22226
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A315CB67;
	Wed,  7 Feb 2024 21:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwX9Yfg4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99CA15B977;
	Wed,  7 Feb 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341153; cv=none; b=Hzvm7UsW4+dvjnsemk0nwAZccHoNZBjAqvYSz4mAxAkpaOf1E+oZ7lIkBNTAF+DamNdN5ZCUEqGuCKFEIFEQEW9LevfQ2Qr+yvjh+LkmfF2g3CchTYS/lcH+/J5oRJajn0+C1xcKtk1jddzKTtoa3ij2zrJS0WWt8U5zdplWUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341153; c=relaxed/simple;
	bh=0m736HT5x3zxAJ7MsSNWQ+HMziYNADUNf1eL8O+UpdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D99PnuGM1wOtQw+P4C/ya/dlCswWS4/zpmi9150xh5v0DDvBppvZNHIBjBIwpHWK7W+Km+75V8py3GzeFN/m/0qoxubn6AEen5wwkE/tl27oK0XXeCWft+CmdGyo2DNmIg5IerrT6I2hESwn/yrWFgpcH2A56wUbxVpQWMWCHJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwX9Yfg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D17C433C7;
	Wed,  7 Feb 2024 21:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341153;
	bh=0m736HT5x3zxAJ7MsSNWQ+HMziYNADUNf1eL8O+UpdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwX9Yfg44symYasP93e11GMzd8qkxwiyThAmewD5u/yDkoyT6SCn/8WqV1fw5jdm2
	 Kwua22/7dBnKPNd55fugb9hpO7HpOeKWyBziw5pcJ3j+UIF/6LrbEFRnsO1liZJxOW
	 fC+GdahMOzuZMWR0tkwh9sJLoMpji0gm+PSgdlws1bZ8daFXmD+VwCCTnw5zzFNi/v
	 zGxpI0tHUwBUBHU/iHqOIm8oA2XA/vIRmrguB1Thf7Qgfx2B+UL8cpjGFK/0WVdecH
	 0Ix0CaLOih6az3Ro+RDbMOwK5kXdE1Xne1+P7WiMlGykQoFfE14Prkg784CySEvqdY
	 MZdhvMEMtA0MA==
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
Subject: [PATCH AUTOSEL 6.1 23/29] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:24:48 -0500
Message-ID: <20240207212505.3169-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index c9ef642313c8..64c26b703860 100644
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


