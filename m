Return-Path: <linux-kernel+bounces-113630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C1888E17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE811C2AB93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD281D5641;
	Sun, 24 Mar 2024 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJnAQJko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50A81AB3;
	Sun, 24 Mar 2024 22:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320536; cv=none; b=IWHJUZ9/54Pkh0PeGjzPVLi2eAI7WK+fnbvk+wzucxDtag28Vnjjldik5qtAWxXVzU8VH+o4WpG6p+BNP+KWiRUe9LUQWxEUTkdK91GcOaS3hBdM7aQNPoA9XtTBUp5LoL7e9J5W5plwUT3mFzDfaLJR7dnC6gRlJB5nVC5SQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320536; c=relaxed/simple;
	bh=AwyNxaZOvXSXnp4f0s/g9Unj9WcJWoQ1M+XXVbWtZNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aM1V0d/5yb+wE4WgeSLwd8WLGmXDq5U7KP+sZ8wT4tZzNj5fxwJLfrBD3sAEcthEbcISV7MQbhD9qDyi8Hm/kuh7Oq00W+tFggt+/yseoWWerFzQosD1qVLZMS6DI3BuHr22Pu5YTFOqOSNM7wSFGRjj8BhwVWYCJtFX3LygsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJnAQJko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13DAC433C7;
	Sun, 24 Mar 2024 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320535;
	bh=AwyNxaZOvXSXnp4f0s/g9Unj9WcJWoQ1M+XXVbWtZNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJnAQJkoCSylrbxMUIe4PK6DrxgctchyW/FE2cZHjsV6PwBe+guEhY3xbeo2gxpGy
	 hLjDAr+6lDPrJbKPuCzat2fck1CZ14YF4H7Lcr0e5XWmuEo+VwFrBLwZXpLpZZaP4q
	 U3Mngkg7gwRq7T6fcRnuSzEZduh949g2TPkjabMRGagWNc8NHljVfIGmujm0nSj1Dk
	 P7Wz1ogw4sRydYPn5Tl1epp5mZO4ZOrdZMFAq2MTitUvC6CNG91QMceKa8MVZCbn0j
	 voOrghEReZkiB7hUAiaW+n0ZdFJZLe00l61tUABLMmJyR+K3ZsT1dWvHV14Q3VHyD0
	 3iXdje5US5oAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miroslav Franc <mfranc@suse.cz>,
	=?UTF-8?q?Jan=20H=C3=B6ppner?= <hoeppner@linux.ibm.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 097/713] s390/dasd: fix double module refcount decrement
Date: Sun, 24 Mar 2024 18:37:03 -0400
Message-ID: <20240324224720.1345309-98-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 0eac1ae4f4acb..0eea5afe9e9ea 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3530,12 +3530,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3543,8 +3542,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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


