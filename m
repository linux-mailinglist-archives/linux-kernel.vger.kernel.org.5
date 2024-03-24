Return-Path: <linux-kernel+bounces-114846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D2E889243
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26E2B25D26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFEA1BA680;
	Mon, 25 Mar 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ5LT+6O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D11774E1;
	Sun, 24 Mar 2024 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323482; cv=none; b=uAKkKMorPYuGEBlcqBBe4oOlXuThUUDdlLcDiU4DGTqbTCCD/hyo2q1J5sngm8EVuaQv7aE+v14YfbufcyqWnVR23oecxL37wpgUjr2JQ4IsSeaPdBpqhA88o0qOB8QsfssGeutlyYFKpbqd1uprx8b6PYakeeA2HaaKlTwSGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323482; c=relaxed/simple;
	bh=AMhjcr4iHcg/uPkM3R5hsZYfMAcH9jNbS1n+IIKneoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVGWIgvRJwbV1sfwXGhzvO/a79q/GJK7VR28/ye8vD6yE+n6g1I8jkyc1HOf/gFOsa81fA9viv0L6utmh7Pp/GHW6gbAyCzIB9ei72txHWDJr0Jfue0ksvFgsMQ9CuxK7+DzZlvdDC0oBWUAzY4UydORMxwvcfVOHFanBxGSQIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ5LT+6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85ABC43390;
	Sun, 24 Mar 2024 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323481;
	bh=AMhjcr4iHcg/uPkM3R5hsZYfMAcH9jNbS1n+IIKneoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ5LT+6OVBHYn2+3sR8fwiUkj3d+quS/yVUVQjnj4nUTXHEa8c4chuDuBGHR2Ff/e
	 TP6rhF8Hdk9BBrkMKe1Gi0+trvnEDnmR7RiXJim4P5Gu5gevgY2SJAqNk4h62vtnEv
	 0AO5tOhMP9xSMnWyJzcUePh68XNwtVUEacJM5gJq80f1GGf+9FY0mwBbLnebMErcvt
	 t9ScEq/WAQprCAJkLmMgwdAMnXXXB9PXl/nnIP7L24bIcPnS+Lut70NbEULfDPhosb
	 y8ADSFyiy8lWjYulHT9SV/CDFuUg4IoYvgNAcYvguBIV1+u6q0nrfN3wAmqWwo5dBg
	 pAQf0v3JDCWVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 186/317] media: edia: dvbdev: fix a use-after-free
Date: Sun, 24 Mar 2024 19:32:46 -0400
Message-ID: <20240324233458.1352854-187-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 3a83e8e092568..23a0c209744dc 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -504,6 +504,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
 		if (!dvbdevfops) {
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -512,6 +513,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		if (!new_node) {
 			kfree(dvbdevfops);
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -545,6 +547,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return -EINVAL;
@@ -567,6 +570,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
@@ -585,6 +589,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
-- 
2.43.0


