Return-Path: <linux-kernel+bounces-113586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31239888582
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66461F23E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685EE1CADD1;
	Sun, 24 Mar 2024 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjQ5Onp6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910AE1CADB7;
	Sun, 24 Mar 2024 22:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320389; cv=none; b=g1PIVYGQapMjheGjftMz5A1PBozzW4eQLiupJDo1+tlQYrMNtwtypzSMMXPfrUCs5oEeEj+quVjVZ1zD7MW5NG282QKBs1lPPZQHqEnqyqf1ggfWrTcXWfRKZHamMqRLWotw+1TvkpX0whWllIRjalMc21Ig/EA/YaHSCl7GBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320389; c=relaxed/simple;
	bh=D0aVCUchj4fSjHjaibxfDzG7yWzsW9jxSYg7diF+IBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMAOAe1MNV28XxvYRoItd4ArlxbVkmN7+9n1Cju6CIi4eEm5kbCsQdH6Jh5ZfqCXdYmjbrZ+nuMALG0JNk+pUSKm0YhlzLwDx63iB1GNkUEUVWNuYJGpyVXVifqvY2GRi5jP7IWmbreuGn4ioxukPevWeyT8tiOUwdbSkBWBfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjQ5Onp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4270C433A6;
	Sun, 24 Mar 2024 22:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320389;
	bh=D0aVCUchj4fSjHjaibxfDzG7yWzsW9jxSYg7diF+IBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fjQ5Onp6zRW/LL1ph1dGOTY0Z2NJYnI2NMOB4QLaWk0l9ub/Lf/MrF2jZy1SSzvdO
	 vk5cJHWTHX7hMkjw56ZRiAIaKnMMtj2hbim9uerf4KRDK8CF53vgeoaoDaKEv5g2bu
	 nHkK59QcyjfCRzLwW1hNKqoI7CvvupM5FezCmAz98Hjb6QL7eGyVBHoVaHGdxXmLpF
	 btXo8UvlTZP969rqx3KOm6q7GzOKZSaWe8bTb+YOa6OeYqrMdorTiWFbsFSLI3Ose+
	 JM5sZ0mGfXUZCTnTS6OYNNak4LJ+AoxDqnIm9t8d734oMUHbpgllQ3opgjcqpfEqnJ
	 vtqZwjNRuuKZA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 695/715] octeontx2-pf: Send UP messages to VF only when VF is up.
Date: Sun, 24 Mar 2024 18:34:34 -0400
Message-ID: <20240324223455.1342824-696-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


