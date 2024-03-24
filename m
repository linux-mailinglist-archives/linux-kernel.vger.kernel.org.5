Return-Path: <linux-kernel+bounces-113383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567838883E4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F991C22BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BF21A0B01;
	Sun, 24 Mar 2024 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2IRfJNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1B1A0AE6;
	Sun, 24 Mar 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320184; cv=none; b=W6EtVjxhp8gHkVkXaAHyP2h2dX3JDqqf1WMCy4LbFShExsclEPEw4zgI4K30gCnbFkwj2Z0kFUYDz/+CkdB8BTBo32TG6C5n7+Xza6QPK8Dn8P+NQ+NpmBkP2Wb8BCc211x8dWNQOxN0pFf46Q+E0SPELtL8WXhDnM37Ttebbrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320184; c=relaxed/simple;
	bh=bgLAqlsnttLg7kNlv60BvhVTkQQ/GGMhQj+OGhBRKN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQFf8TlANq474aTRNAbqv+OZp5B33GwkJdcj43tKGhRXxh33rGcmXTTxibZ8jCZVo4Y+QeciWKey0ruP6nfkvpA78Dw/nLIgtjODyX0wpqjy4RBSM4Hxj66/CgH7FR8p0ruzDMu7o3lfhPqDIHoQFiaPmivUZVSuJQJt/mqyziw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2IRfJNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B3CC43390;
	Sun, 24 Mar 2024 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320184;
	bh=bgLAqlsnttLg7kNlv60BvhVTkQQ/GGMhQj+OGhBRKN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2IRfJNfoCQFZzsFT424uCazjNhPsQGAE1sbM8U+HwZK3oP7zT8+KCz8ABrNaiCpV
	 n1jatyI2TNorI5zRI2KI1WhDUHYT/ze9EViQWykurj8LRM+zZF9pV0r75Ub8zUgFwE
	 CoOsHyPcCS9U2IUxqC3C4y1kOYCp1HNzPAIQ0w2MeYfFfoHNFY9hBr+IHVxDa/u3C3
	 7iiic0BUvMZszMbVHKKat+4tPxVyXDgzYmQj2yp11qy3LoDSFeFC3UnACK2n1CXNJO
	 gdaKheQL3MdjbJw4g9d/EF5ELX6+fIKGhbGF9/9+FxBmlSna9prcq/6fqirZMsi04y
	 v5zYWxbpPEhgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 492/715] media: ttpci: fix two memleaks in budget_av_attach
Date: Sun, 24 Mar 2024 18:31:11 -0400
Message-ID: <20240324223455.1342824-493-sashal@kernel.org>
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


