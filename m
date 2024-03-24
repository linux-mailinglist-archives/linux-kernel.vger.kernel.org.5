Return-Path: <linux-kernel+bounces-115466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9B5889BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E38E1C33059
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CD21FA16;
	Mon, 25 Mar 2024 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRmAIQkX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF41E770A;
	Sun, 24 Mar 2024 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320868; cv=none; b=Jh+/67LogiSjFIlJMyixofGXPANAkj6cMaUUucxx975HJN5UtiB+MRR/XsapKLE2CMn1O8V/Dy+Dx1KoWK5MDdr3vZqlSmL+p1qQ9g8Mpm9tEqz4umyYlLV8dQBqrNinsASEgBC4g/pnnMQVQBz6uRwTYOeO+OgzqcVysbdoCpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320868; c=relaxed/simple;
	bh=ScxSW6UgPUsVoztvMsj+KZEAdBvd7VPwubsif2s549w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCIQnSvmccRwxHAxs7nEkkCAlJFHHcMy0dcVRq1DmIYAhlWhIwQxFcTxvv36Rd2pNggd4onhnpK3j5N3TjxgLKn4F+g1eeqh9JcwI4wIdD77MKFR8pN4W4Q60Aip4MPW0meD9KBGqKIYnpqfh9mJV7TiukKNFPAH1SvbUA1wols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRmAIQkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CD5C433F1;
	Sun, 24 Mar 2024 22:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320868;
	bh=ScxSW6UgPUsVoztvMsj+KZEAdBvd7VPwubsif2s549w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRmAIQkX1kmF199ZJLTYueRqF4ZE7LQ0W+VAnQTzq3otYNHt3nnGzVEK6Q1X3AIGW
	 QApx3rOgdxY1tu+RNvZieR3HnHTaCvcvB+JP3ZYUcHDyPVanGPLyGeTAfQMpFr1TYi
	 0WZ/Ow95PoehSjCYd5/6dNm0WfZAvVQBS6AuVyD9MLPojYMx6pBgU3WtrQnEd/JeLZ
	 eWWwMiNolInKn2jlAe6M7outOgqWiou2yRS8S8J8GdWbBG152ff6w05oR7C8I4Rfxf
	 KOy7auM9KzmrLiFrdNbnhw5tIxBMOdH49QxGWnepbVvWv9Nhp71iSacGwHDwqzgRsk
	 V0vNBv3PSc09w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 432/713] media: edia: dvbdev: fix a use-after-free
Date: Sun, 24 Mar 2024 18:42:38 -0400
Message-ID: <20240324224720.1345309-433-sashal@kernel.org>
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

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit 8c64f4cdf4e6cc5682c52523713af8c39c94e6d5 ]

In dvb_register_device, *pdvbdev is set equal to dvbdev, which is freed
in several error-handling paths. However, *pdvbdev is not set to NULL
after dvbdev's deallocation, causing use-after-frees in many places,
for example, in the following call chain:

budget_register
  |-> dvb_dmxdev_init
        |-> dvb_register_device
  |-> dvb_dmxdev_release
        |-> dvb_unregister_device
              |-> dvb_remove_device
                    |-> dvb_device_put
                          |-> kref_put

When calling dvb_unregister_device, dmxdev->dvbdev (i.e. *pdvbdev in
dvb_register_device) could point to memory that had been freed in
dvb_register_device. Thereafter, this pointer is transferred to
kref_put and triggering a use-after-free.

Link: https://lore.kernel.org/linux-media/20240203134046.3120099-1-alexious@zju.edu.cn
Fixes: b61901024776 ("V4L/DVB (5244): Dvbdev: fix illegal re-usage of fileoperations struct")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index 49f0eb7d0b9d3..733d0bc4b4cc3 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -490,6 +490,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
 		if (!dvbdevfops) {
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -498,6 +499,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		if (!new_node) {
 			kfree(dvbdevfops);
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -531,6 +533,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return -EINVAL;
@@ -553,6 +556,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
@@ -571,6 +575,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
-- 
2.43.0


