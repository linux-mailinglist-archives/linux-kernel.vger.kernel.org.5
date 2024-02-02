Return-Path: <linux-kernel+bounces-50383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0D847848
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0F8F1F2F851
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B81134CF5;
	Fri,  2 Feb 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRaBO2mb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73840134CD9;
	Fri,  2 Feb 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899239; cv=none; b=i+UrBTY3QgDqoNflMolmEeR2DW0iIgPDPjBCXtATNPVkwCRxM6/h7xL1M1jdo64Hun4AR1d1xxtUy6OTQrxvlNbZBFaMHFKX/3HEWVY3x3/Ep+daD6vp7ok3jRj/wCUPNo7LIpQDquLJ/jxIqi+h+gNWBKEqzO9znIgH0iOcakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899239; c=relaxed/simple;
	bh=eZMy0rsC1O2myoC9DEfCEzi+FKFhOhwY9HAwgwyPxHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKACk4P78sfPl3gvg33cVUUxhYTjlQ7+6Ry5gJ45WfYZrfqtGeenBY6TjQl6dh2H8hV0SQXZYg5XAIBJkL8y0UP33qduXQ+j+YXmC9X2RujJmCavSU6oa9wuL+x27OJ4o/ZyglqBsv13hk9jqKKi291GCvtNsnfdJr7at0Pbz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRaBO2mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667BCC433C7;
	Fri,  2 Feb 2024 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899239;
	bh=eZMy0rsC1O2myoC9DEfCEzi+FKFhOhwY9HAwgwyPxHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRaBO2mb9Q3flbCINhKaYt3prpJ5bFzYA/wzNdkfNHmWcTVTcVO5PZKNv6Nf74ze/
	 EMtsnSnDSe/T6uNJjZ0i9jfUPfXy6tAKagnvQZgq22n2i8hAQpQrKg6g4GK/zHuOW7
	 S796TBjdde7W6IFB8ioMSWwm2PBJ++v84uxcjS9xzsVEC6yDhWKaUxq8UJBnsZmsp2
	 8nNVXvs5B9Mq7sjgUcqkxKOcaX3A/7C6RhaVnLS4VYR6MCniVFqAbO0HLH4TdKy3O7
	 nijFTRgTbnBJHlnPVSfJIRiZUAsV/BYS3NizQBuuE2It3isnJWrgJCyelBAMlczO4J
	 g5oSixiS0ZV0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	justin@coraid.com,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/21] aoe: avoid potential deadlock at set_capacity
Date: Fri,  2 Feb 2024 13:40:02 -0500
Message-ID: <20240202184015.540966-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Maksim Kiselev <bigunclemax@gmail.com>

[ Upstream commit e169bd4fb2b36c4b2bee63c35c740c85daeb2e86 ]

Move set_capacity() outside of the section procected by (&d->lock).
To avoid possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
[1] lock(&bdev->bd_size_lock);
                                local_irq_disable();
                            [2] lock(&d->lock);
                            [3] lock(&bdev->bd_size_lock);
   <Interrupt>
[4]  lock(&d->lock);

  *** DEADLOCK ***

Where [1](&bdev->bd_size_lock) hold by zram_add()->set_capacity().
[2]lock(&d->lock) hold by aoeblk_gdalloc(). And aoeblk_gdalloc()
is trying to acquire [3](&bdev->bd_size_lock) at set_capacity() call.
In this situation an attempt to acquire [4]lock(&d->lock) from
aoecmd_cfg_rsp() will lead to deadlock.

So the simplest solution is breaking lock dependency
[2](&d->lock) -> [3](&bdev->bd_size_lock) by moving set_capacity()
outside.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240124072436.3745720-2-bigunclemax@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/aoe/aoeblk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index cf6883756155..37eff1c97451 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -333,6 +333,7 @@ aoeblk_gdalloc(void *vp)
 	struct gendisk *gd;
 	mempool_t *mp;
 	struct blk_mq_tag_set *set;
+	sector_t ssize;
 	ulong flags;
 	int late = 0;
 	int err;
@@ -395,7 +396,7 @@ aoeblk_gdalloc(void *vp)
 	gd->minors = AOE_PARTITIONS;
 	gd->fops = &aoe_bdops;
 	gd->private_data = d;
-	set_capacity(gd, d->ssize);
+	ssize = d->ssize;
 	snprintf(gd->disk_name, sizeof gd->disk_name, "etherd/e%ld.%d",
 		d->aoemajor, d->aoeminor);
 
@@ -404,6 +405,8 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
+	set_capacity(gd, ssize);
+
 	err = device_add_disk(NULL, gd, aoe_attr_groups);
 	if (err)
 		goto out_disk_cleanup;
-- 
2.43.0


