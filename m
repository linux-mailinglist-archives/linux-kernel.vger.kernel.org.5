Return-Path: <linux-kernel+bounces-116010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F3889569
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572D529818C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C71317AFB8;
	Mon, 25 Mar 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2Eo4NcG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157572745CC;
	Sun, 24 Mar 2024 23:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323339; cv=none; b=MNweMFpuAmZUXRmdj8ZvNM+ZxaT5Asp2iQRE+d6eT41aN8bXiq9Em/U6NlsAQhP9Vo79il67Y6Ca/kO4OWT1yJ/gt+T8MV/SV0n9rWlfG+6RtKM/SLh7rAlVO1o8w4DNBKnTvZTgdNB2kNQDiznxAlIWq5M0cSeW2T4SwOf67xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323339; c=relaxed/simple;
	bh=hwIpP3qFl5s5BGxFTDGp89V5e0EC0KgQIiH23cBoz3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTxnz1QHyI/aeYrKO4DZW3TFQWlW9OIf9WFsuOYSPYHX/7cwb67YjeZBjDla//qYtxuJCBI7UnhXbaIRmleTiqGGEwAPawaIEwEUL0fG+zmGZ0JOgfklviLceUQ5BR/C9PoDGyz60yN08F4hA4N9f/xzqvp2PWSjKvOK/LUXIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2Eo4NcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0AC433F1;
	Sun, 24 Mar 2024 23:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323338;
	bh=hwIpP3qFl5s5BGxFTDGp89V5e0EC0KgQIiH23cBoz3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i2Eo4NcGzA/T3wcROh2KYKsjDLcjRf3eGUG2MlSowtBSkMHe1T/OhS72om/3GsNvE
	 CotWsUFNjioOPP7BHowrJ33qbQHuoNxYsm7Gycfxq5+H85q/lkv56quaTm3XTfZIST
	 Fy2e4jRDBTOj+mj/tT5BmNPWNY0CEzfvnKdvX5NvTbX+501zfI7nN1XpZuW7ZsFFAH
	 kANRkewje0gBQW1bXggtQ4/gCc0S7g3W5j21eP0tNFI5Oi4fu/43wpxowdsaRYxvkX
	 b/+3dhuRPWhVHxSIpTJ0lK7u12tY98TPKPDNy0VGZ1aoQ+pCVBBjwx5hUa4C3ymrna
	 Q/qrd3LwfgN0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miroslav Franc <mfranc@suse.cz>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 038/317] s390/dasd: fix double module refcount decrement
Date: Sun, 24 Mar 2024 19:30:18 -0400
Message-ID: <20240324233458.1352854-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index f13f76fe3f2e2..fc33474271115 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3573,12 +3573,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3586,8 +3585,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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


