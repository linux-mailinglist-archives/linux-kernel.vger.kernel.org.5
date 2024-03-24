Return-Path: <linux-kernel+bounces-112904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2890887FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E086F1C2114E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740745A0FA;
	Sun, 24 Mar 2024 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCgyDxaC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8759B4A;
	Sun, 24 Mar 2024 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319714; cv=none; b=UgO6e5ZctkRztbsfEjPe48yIZNwnlaAhPnjKCqHows5FZIyvP+Uq2nfKtUAIEoXQy47SyKVd+ncp4MjJvJ0p7pxwiTpacdcJ+HetFYMnXt7V/RC3DAiiWCuksrTijYWRhRXifc3TeAB7kbSGMp7IYiiT+pwOABZ46Uw90H3pTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319714; c=relaxed/simple;
	bh=oVZwtmDcHYvBHMhU9YZMSDC5oMFaskHjpmfI0C7pr9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaWrOCItd37zwX2arrCQqriefagos/qReDVbQk1QmiJr9ZIMnUfonvKPpPQWWnU7+lDVjP2m3rndAb0UzksO8az8Wr/Nh8h2k00nunFevr13h6wZbbG6yUKqFMjTRaisskBb2NOi/icwjf9kLPdZ58N/pvN66Gf3j4Xz4Gl/DCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCgyDxaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBC4C43394;
	Sun, 24 Mar 2024 22:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319714;
	bh=oVZwtmDcHYvBHMhU9YZMSDC5oMFaskHjpmfI0C7pr9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCgyDxaCGYOtfhbTrVyM81alx4oS9oxFc0r5pft3B4wnvUw/Dt3bF715kKUf/a7Az
	 QS9EJoon1Qh0Gx2bjEJgyatMeuzyS1yEsDo0+jUIyGRGzJukJRAjO99HdkEO8Nu3Gq
	 T4n6OAex5chsqxHeKJGtCrZa4DJxjl9FYUkQ7JKxEt+AUdFcGM2TDWa88BwiySS0oL
	 VMM8dy+8sofL/X9yfxY2vCfhp08SQBCfI8M3HqSVZMacXWJNUDV9roi2BUqvAC3Al2
	 g5caA9rwnF4MwGmVf3jKvIUn+1LQpptmJQE6omGidEsNBLSZk66dlWnpuszClFMpY+
	 9xB2CvSXSrwjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miroslav Franc <mfranc@suse.cz>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 017/715] s390/dasd: fix double module refcount decrement
Date: Sun, 24 Mar 2024 18:23:16 -0400
Message-ID: <20240324223455.1342824-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miroslav Franc <mfranc@suse.cz>

[ Upstream commit c3116e62ddeff79cae342147753ce596f01fcf06 ]

Once the discipline is associated with the device, deleting the device
takes care of decrementing the module's refcount.  Doing it manually on
this error path causes refcount to artificially decrease on each error
while it should just stay the same.

Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
Signed-off-by: Miroslav Franc <mfranc@suse.cz>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20240209124522.3697827-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 4a7d70426a6e6..30851faade97b 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3524,12 +3524,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline = base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	/* check_device will allocate block device if necessary */
@@ -3537,8 +3536,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
 			 discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
-- 
2.43.0


