Return-Path: <linux-kernel+bounces-114070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DE288883B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C273F28A7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC967234509;
	Sun, 24 Mar 2024 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="desb2Z4D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B251FEC6B;
	Sun, 24 Mar 2024 23:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321359; cv=none; b=lbAEBNF1biCCV7ACM72SlQHhoN6aXXWk4jy9Vq2grYPSsb1IpAwlvCe20BrsBHZFSc8fb+AG5MNvDdFasleZdGjP1E8170K/GOUybKPhmjSKFAhh3LOjZ/PYzOcrdx0TtbYk7bYL/Q9AFLCGmOhZ8HoYXsTcX76eGHN9wBz+ErA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321359; c=relaxed/simple;
	bh=aArt0ecVKv1x3uKidFVlDH6gZHaPAKnhEVj+hI42SJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BS7cyl9k4uk/l+FbT5dqlrvKlPtkOJEIzXX10b4xj9Y/BMNfRi+DHODdYiVCVBGRXuzZxgVk3JKRC+83uGo1+zgn9bLnWgiNnhhjjXrngnWjUhNV0HTKhpm6limviRUE92dGzRCAqgBICFGGkZHN8PndKA+POcTO2SM7fELfqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=desb2Z4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2E2C433F1;
	Sun, 24 Mar 2024 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321358;
	bh=aArt0ecVKv1x3uKidFVlDH6gZHaPAKnhEVj+hI42SJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=desb2Z4D+n08KZ5yEuE49wRBZ3D0d4ic1zW8srWRoc1JLog0+qDcip6LDpNaQ2Tso
	 pgvxuVCgWzr1gLUJ/kai6jBRFbSrcL7qUvtw8OVhx+uJbAM4KduWtcZgdLdNOblDHq
	 AKMqMra1Mw9CaevsnRaPiAHzMzqH+oNvLVn0rCeoba3THQudkiLpy16Nn5DV0lHgA4
	 DLiwXkSfLwJtlgIQ+sFWvQ8Px9WBSfR4TcukH6MhhTK1Blf0di2ae/VEAyCgeQvxNc
	 lDEPABvonfFj1FAnuOtX2JrO9/PlyoNLu7U7ErGo86XwBN6cncKga2LX62nFX2yre6
	 lGUYwDIkxRnSA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miroslav Franc <mfranc@suse.cz>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 083/638] s390/dasd: fix double module refcount decrement
Date: Sun, 24 Mar 2024 18:52:00 -0400
Message-ID: <20240324230116.1348576-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 96f4c94865846..6f97456798917 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3528,12 +3528,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3541,8 +3540,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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


