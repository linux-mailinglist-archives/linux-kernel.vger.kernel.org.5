Return-Path: <linux-kernel+bounces-115110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C79A888E92
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5304B27C34
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E992FC04A;
	Mon, 25 Mar 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDADDOEZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850BA28CE78;
	Sun, 24 Mar 2024 23:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324105; cv=none; b=uztODX3VFsIzqTKGbRt2kNjjqAPnmBRSZc+D0LtPnA4OEO6f0UKN59qmFuptLN7ALbSEqNDt+QjJK7WqHXG0eQGu7gof2KaIEwiyxCJHsQCa3oCVP7DF1Tb0iKnRgkhj6dieNe6pSGC0nS4PgQ4+do15GuANhAyzaD3EZQOQjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324105; c=relaxed/simple;
	bh=hgUpuViv5Aw3BUxglSeTlqPdxDXq6iJ0b43GOvVNMho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X33HbiILHO4VnoxIyiEw/Z515+WGJ9pD2pNCPoinaCciO9g8XXuqTw3vQBE5Z+M+2PfuV17lZrr1l7kJ65CqSPDaG9iy7pS++v7KWCV7kP/ZysvgV9SuguIWw9CjFko/ycAU1fecAs65Fob7Az0bIIQoVxXzHiFjTegr8FGS3tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDADDOEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADA3C433C7;
	Sun, 24 Mar 2024 23:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324105;
	bh=hgUpuViv5Aw3BUxglSeTlqPdxDXq6iJ0b43GOvVNMho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDADDOEZvI45G9tl6WBEoxA4ZvUGIo6O43dB/bSktR7HLtIWJvhTxeBKrdCP7gfSP
	 cBMn2VhUUl+3ixdW2FRMwP4KaTY3ranUdSUKDtJ6z7w7ZZBHdJW3Yf/d5IiX3ooHdX
	 UkWWz2Kks7/RtzcRxe4W9Fmnu037sipkv2ARQL6qE9W8wFf1a37T3Wcozv1gjwXNly
	 6ZddG9mUM/zKjxCLcomt+GAkeXT1Huo10lRc8lO+eqUuaEuCDOuZAnT5f64XqDrgwT
	 vCyFjo226fKNdIv13vqXC2f+5/y+O431tjl7A+WvXXzQDmf4uZG7tawn3ib7M2vBbb
	 x3utDKsAoUE3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 104/183] media: edia: dvbdev: fix a use-after-free
Date: Sun, 24 Mar 2024 19:45:17 -0400
Message-ID: <20240324234638.1355609-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index e7cd7b13fc28c..d4d903a9dc31e 100644
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


