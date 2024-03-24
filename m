Return-Path: <linux-kernel+bounces-114556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E70888B09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8AD1F274AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5107C22E81C;
	Sun, 24 Mar 2024 23:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5tJVXog"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6522D892;
	Sun, 24 Mar 2024 23:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322190; cv=none; b=TwU7THRXu/Ps6ky5sR7EpWSY9taGbMZtt/v76cHhlygIudKkSaShSi6WsnpDMZE6qfyJVgltFTras98ogyEeV4wXhce8n9al79XvtHJYkfX70tFbuz+H3Sj24PfOjUxb7wDbv5Hv5MdfVOACEUwF6/AERzUoEXhctj18wVfOB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322190; c=relaxed/simple;
	bh=1ZYJhb7Dsjvq7ZHwirOEFAfxSoZfoOULsYjmuJgi9TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IubV+ae0pidQz4asguhdXl6TetBi9eejoe5rHrj1CPLHa9cBX8QDvuzlH0aoc1pGw5CqI+RbAkeOY3e7YM/Moj/gxgi1R9atkfC1y0qpxcCPKCMgIPRJVVyS+YQSq49nBUYh10pyK/XIrqgSfj49EHvmM74k9y7oB+Pk6QhAo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5tJVXog; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19330C433F1;
	Sun, 24 Mar 2024 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322189;
	bh=1ZYJhb7Dsjvq7ZHwirOEFAfxSoZfoOULsYjmuJgi9TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W5tJVXogMW/xXbZRZsnyxt/YR6FmDk4p7naXXr6Qr9zUMjCrw/gePq3QvufHzm2ux
	 LDJeqlR5tMjN3pOUOqpLgQvuOE1QEjWp5HpkU7jVm/8VAFasklqvzrjVz4CaP8aWr4
	 tGLJ1qRUS89z9E+p2H8gtzaC7wnCKkzaSADJe3HIFJnuqN37xzPDGmqFHoo/6MvArk
	 vRPQpX8ktxNaCRncUx6y1d3Nj2wA73EWwjVcB5iINVNNaUdO2hsrnnzvc3oVXA2jNk
	 wdyADhFUMplTKzaxpwGDwN5aM6z7Pc8/NqJzK360u4gHRTDq7ltFtQzDwpJJsCV+V7
	 vOjg9sxNTm74A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 268/451] media: edia: dvbdev: fix a use-after-free
Date: Sun, 24 Mar 2024 19:09:04 -0400
Message-ID: <20240324231207.1351418-269-sashal@kernel.org>
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
index d352e028491aa..aefee2277254d 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -494,6 +494,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
 		if (!dvbdevfops) {
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -502,6 +503,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		if (!new_node) {
 			kfree(dvbdevfops);
 			kfree(dvbdev);
+			*pdvbdev = NULL;
 			mutex_unlock(&dvbdev_register_lock);
 			return -ENOMEM;
 		}
@@ -535,6 +537,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		}
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
 		return -EINVAL;
@@ -557,6 +560,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
 	}
@@ -575,6 +579,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		dvb_media_device_free(dvbdev);
 		list_del (&dvbdev->list_head);
 		kfree(dvbdev);
+		*pdvbdev = NULL;
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
 	}
-- 
2.43.0


