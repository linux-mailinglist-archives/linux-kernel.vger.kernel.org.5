Return-Path: <linux-kernel+bounces-113986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023BE8887C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9611F264D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CFA221927;
	Sun, 24 Mar 2024 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TszrOKqw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C812D760;
	Sun, 24 Mar 2024 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321133; cv=none; b=Pr1+cUpfgXm0G3a4+nlt6SXnscdiMD9bKG3EmgPBRXrCfRZeTZ08e+LullDAYy1/2gzlpBw7kMgrcgslq1FkjUTrnXBXyRMnz1p9eKYCt7Dx9qFZJ11jWoF8Mo3ZtCI0SfPQoTZTuAYo7ovtYA6Me8ukdRTIy1TJZVXjzmTvdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321133; c=relaxed/simple;
	bh=D0aVCUchj4fSjHjaibxfDzG7yWzsW9jxSYg7diF+IBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXSSSG/pafnOOcHAbSRoOadlfYa2PP2fuSd/j2Vdnly1hCyeauNkricjs+Jb0/XrXj3XYwQ/2h/t9Hn63XPm9MaJDTrpme81lTjgpESAB9PuNMALw/MJLaU7qUXIxc6c4D4luNGUaPj3RBzT3FKY0GmMw0Ih3LiBQQk31v1bcy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TszrOKqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C24C433F1;
	Sun, 24 Mar 2024 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321132;
	bh=D0aVCUchj4fSjHjaibxfDzG7yWzsW9jxSYg7diF+IBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TszrOKqwTYdRgLaH3FpL5xHgnWQmzvY24SD/LKhEWpqnPPfNdLx/+iWr7cE4yYpon
	 Tjkd6u7Lj8WIEh6fD/NNNgtZ+85xJTequKKy2qSR3EvtaPzYyV6+DHx7voEF+ajLxh
	 S45mQ6zCTAxCSrpGDD3bkjV3NEU649pfgMsMd1eFYVEGX5JA4x8B+Ye9hQPtDbq2YZ
	 IsPyUWFUMxxD28pH7f8oEUp26tk7n+JjZB45w+eZseLl5SKy8ES8KZn8/t3X7vbZpO
	 qSbqlYycw00DidiMxtPnrNiwQ1HF2t7jTPaqp0gA8G0GNqkxmhikvKSFQNQ+zhRcjX
	 N5NUieQrY/d5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 693/713] octeontx2-pf: Send UP messages to VF only when VF is up.
Date: Sun, 24 Mar 2024 18:46:59 -0400
Message-ID: <20240324224720.1345309-694-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Subbaraya Sundeep <sbhatta@marvell.com>

[ Upstream commit dfcf6355f53b1796cf7fd50a4f27b18ee6a3497a ]

When PF sending link status messages to VF, it is possible
that by the time link_event_task work function is executed
VF might have brought down. Hence before sending VF link
status message check whether VF is up to receive it.

Fixes: ad513ed938c9 ("octeontx2-vf: Link event notification support")
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index f85d38fab3211..b40bd0e467514 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -3122,6 +3122,9 @@ static void otx2_vf_link_event_task(struct work_struct *work)
 	vf_idx = config - config->pf->vf_configs;
 	pf = config->pf;
 
+	if (config->intf_down)
+		return;
+
 	mutex_lock(&pf->mbox.lock);
 
 	dwork = &config->link_event_work;
-- 
2.43.0


