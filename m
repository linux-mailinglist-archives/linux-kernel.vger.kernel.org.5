Return-Path: <linux-kernel+bounces-114278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA4888984
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012421C25BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9B20DB6F;
	Sun, 24 Mar 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbZxKwRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50420DD56;
	Sun, 24 Mar 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321657; cv=none; b=DBuHHcblmmxfs6wy8Cr1Fymkzx90+cKTRCSDU/cWaK9NZUMwtan1t5Dhxgr1f8nHn5Vnsxd7JdRGqQ452SD6TSiIR3JEI4e4tzsQ32FMExqdIt4PtKHAzTjImdSVC+Eqpf5o/SfR6zW0gRfkyNpYJSSUfICioKpkmw4KLZbv8HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321657; c=relaxed/simple;
	bh=ScxSW6UgPUsVoztvMsj+KZEAdBvd7VPwubsif2s549w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XR/03zSpXM3bo5XmzNoXZpjBM5MNAw4HorrlkyVqde7AqRFfzFmx34QSHC1PrGzc6izewjYwKu0gqZK+Ne+Ir8S4CY2up+AHNzihk97x2OQdibaHpWDMDnPoeqyUM8coW18ZVayA74wRrjy5TZmjsqfyg6Hzpttu5uZuwQjJvfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbZxKwRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF91C43394;
	Sun, 24 Mar 2024 23:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321656;
	bh=ScxSW6UgPUsVoztvMsj+KZEAdBvd7VPwubsif2s549w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbZxKwRyCBTrQqQYHxNDHJfmqjqI4+6vyZrdkV2HxhciMVGOhO6us9rXp32JSWPP8
	 dCaNvjz37L74qlCf4o+VWA3t+oFCa2LahM45lyq7EsamWEmKTjxepXFgTBgfUBRLFd
	 75cPujZY9B6OT1uZzQy8d7ssiag5CL8ZkoCxS0hfwVsty94XDcwII0Hthrluuf7zIH
	 OMzhv2P8j/BeiuoTBy16uoyQrC73y776QK9153xoA/vrp6gDjqSlhV0Hn6Zi/Z9vkK
	 eCSsymiM+B1dNy3eRdNJogRVZF5+aX7SNSjpxld4MAKgnyhuzCDkRA2Eg0WT8R6ZT9
	 WExR1peD+HlMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 385/638] media: edia: dvbdev: fix a use-after-free
Date: Sun, 24 Mar 2024 18:57:02 -0400
Message-ID: <20240324230116.1348576-386-sashal@kernel.org>
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


