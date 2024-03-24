Return-Path: <linux-kernel+bounces-115708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDE4889BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D09ABB27DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B92A15CD57;
	Mon, 25 Mar 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSCgmPep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4113B787;
	Sun, 24 Mar 2024 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321738; cv=none; b=Wn1H5tK0kzRM0wixhyN/I1Mjv5DSjOrPEyzxctbK/RDrboDg1MeAvT6hA7cWA5kQViq7UvlNgmSX6yX8vyJgTi9xJc8ihbGz54DqynMflMeHfOAT8cxHps6ZM7DVMTeg3AWXtgw8sEfguez5IZ51DEtftu5vJjlUkqen2Hw72pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321738; c=relaxed/simple;
	bh=bgLAqlsnttLg7kNlv60BvhVTkQQ/GGMhQj+OGhBRKN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5UH56f4nqhWdlQ3J5ebU4OGPFDZndf5G+qzaZrgn33e1a/qVZNH/bT3nwUpcSPNWfdkj+S56NMO78wUiMhEAq4oN5aUDl7Vj3AAGKd2ehzx5WJWwxauzXdODy+1hcWoi5bxMAjsqSW4IRczN7huLJThujHNeiQBvg8cO14RMM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSCgmPep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71292C43394;
	Sun, 24 Mar 2024 23:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321737;
	bh=bgLAqlsnttLg7kNlv60BvhVTkQQ/GGMhQj+OGhBRKN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSCgmPep6bYioey7YYYRK8infdBjvoUItIgB2V7HDpAGNu5YbmM1yxBHE+JJZkErM
	 nMEag8F9gOUtlUrMheObUwLmbeQyrOw/8Q/WD+aBxxZKqpt1BWHhUc0jqYZ/edXZku
	 Ef7scgMXtEkLOS6exvQd2q/70OftigIpYIUA+N8+LGQv7pFyXmirF2G1qBzSgcNd3D
	 GPC6lVvNXSjWSlv5zrdS0E/N6EDv4SXt0+2eWaw1q2WJ5hQCnBuJqeUH5vHU26CPgp
	 m2Cx0tGRAbq/xw8ftL7B+KTBASK3/gG0lM2NzvjYbCpmLGfZ3YMklTJq9zeIaZX88f
	 cIBdqrhSyUfOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 465/638] media: ttpci: fix two memleaks in budget_av_attach
Date: Sun, 24 Mar 2024 18:58:22 -0400
Message-ID: <20240324230116.1348576-466-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit d0b07f712bf61e1a3cf23c87c663791c42e50837 ]

When saa7146_register_device and saa7146_vv_init fails, budget_av_attach
should free the resources it allocates, like the error-handling of
ttpci_budget_init does. Besides, there are two fixme comment refers to
such deallocations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ttpci/budget-av.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/ttpci/budget-av.c b/drivers/media/pci/ttpci/budget-av.c
index 230b104a7cdf0..a47c5850ef875 100644
--- a/drivers/media/pci/ttpci/budget-av.c
+++ b/drivers/media/pci/ttpci/budget-av.c
@@ -1463,7 +1463,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1472,9 +1473,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		vv_data.vid_ops.vidioc_s_input = vidioc_s_input;
 
 		if ((err = saa7146_register_device(&budget_av->vd, dev, "knc1", VFL_TYPE_VIDEO))) {
-			/* fixme: proper cleanup here */
-			ERR("cannot register capture v4l2 device\n");
 			saa7146_vv_release(dev);
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
+			ERR("cannot register capture v4l2 device\n");
 			return err;
 		}
 
-- 
2.43.0


