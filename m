Return-Path: <linux-kernel+bounces-114597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B9888B38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67BA2933CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10E232111;
	Sun, 24 Mar 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlh060FQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B6A2319D3;
	Sun, 24 Mar 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322246; cv=none; b=iTar3Tii0QH6VX9PxiSJI9mpIbZBQ351AERfGIHLWcNdFpJS+ydikW5JBwlfJopWVzKWerKAZCQmtphQN+h0HvoS/SDfsbu3wemy/bDadry5I5okOFh26heylAraKRPHP9RDHrtO3IFqvkR2zpAvGeq35EwSVt57O3uMgnBri1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322246; c=relaxed/simple;
	bh=lhrE8fSYga6BlgK6tHslFO927ryv1ls3v3xhZjgfFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R23DL28cNOriLYsia/24k1uUfidGoyV3qjyxY2mNcdABe2koI63A/C2cUMYtPYhK8FXaxxM0dnvHZiMpnJVAHsVgTCA/SxWbC9Tk6FSXtAu86ZMV0lTRk7Bi0W56Snkctt6fcEOHpzR/JczPhLn0Ronsem2Fzizd7PmJHepfNOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlh060FQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E80C433C7;
	Sun, 24 Mar 2024 23:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322245;
	bh=lhrE8fSYga6BlgK6tHslFO927ryv1ls3v3xhZjgfFN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dlh060FQTVDn6XNuUjT5rWxNcqaAuelawX2y8DiPleupOOZJn3M9/38DSCAAF/I0p
	 ra5YTiqeqEsTdQ4u7GYymDbzU4cbNK1vRExNsk506pEP/gJ2Ci54WbeQhtC5qN5ZE4
	 E4be5An8+W0Q3HAeHO2pjPZfZjQKCJon3GwLdhS9LH8vFVAwzK2xeMyePFVkZV8W5L
	 l/61GrD5fBsbC1S1rWm6JlusNtIN6shK6xPBfZfNNx/CGoHQU1KDmsGWwgkw55Ld66
	 8TZLCbz2pAR1EYm8Ql3483krPwhNya8xhDYBT6ytQ40y85SFOOSFjiODstSykvtO4Y
	 HP4d1RoskiWxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 327/451] media: ttpci: fix two memleaks in budget_av_attach
Date: Sun, 24 Mar 2024 19:10:03 -0400
Message-ID: <20240324231207.1351418-328-sashal@kernel.org>
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
 .../staging/media/deprecated/saa7146/ttpci/budget-av.c    | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/deprecated/saa7146/ttpci/budget-av.c b/drivers/staging/media/deprecated/saa7146/ttpci/budget-av.c
index 0c61a2dec2211..81fc4835679f3 100644
--- a/drivers/staging/media/deprecated/saa7146/ttpci/budget-av.c
+++ b/drivers/staging/media/deprecated/saa7146/ttpci/budget-av.c
@@ -1462,7 +1462,8 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
 		budget_av->has_saa7113 = 1;
 		err = saa7146_vv_init(dev, &vv_data);
 		if (err != 0) {
-			/* fixme: proper cleanup here */
+			ttpci_budget_deinit(&budget_av->budget);
+			kfree(budget_av);
 			ERR("cannot init vv subsystem\n");
 			return err;
 		}
@@ -1471,9 +1472,10 @@ static int budget_av_attach(struct saa7146_dev *dev, struct saa7146_pci_extensio
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


