Return-Path: <linux-kernel+bounces-50401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD02847882
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DD7287C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D6813C979;
	Fri,  2 Feb 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cN1QimUr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBC4154C0A;
	Fri,  2 Feb 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899276; cv=none; b=LZ116eCIRUdAJv78ehl+2kPMrK+u/rYx73xSglk/IethzO9eJTXYbGS+MwVbXznGEI1gjHVy+SfEkqKCQa3HtSBVLoH0+UH7MnqGtetyiofdsG3paxyktbvuggnMlVobwv8PaBchd0VDNdW6z1ayg/sjHo7Omjdz/UYyOGt6gvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899276; c=relaxed/simple;
	bh=YVpL7t6pZJgdqqlPYak/MV4nc9wyw/DUmAflRoDdquU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+g35MAQjldILADUdjxRq6btWCEzX9zz9x1TaK0hoy5ZLaxkVMnGCdh+xvAzKx2lgmM5gMVcgPryK26RTCOCJdc0oB0sivpN+ohulbX/QfrpkHtnoWV+/CLxj/5mhqvlXLtfbVXGZor56ply66DsCIcSPCYVDMBteaH3yp4bM1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cN1QimUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9292AC43399;
	Fri,  2 Feb 2024 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899276;
	bh=YVpL7t6pZJgdqqlPYak/MV4nc9wyw/DUmAflRoDdquU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cN1QimUrSQIjnJLEgZeRtnwNKwxpQ3QIABsx/93KxqpRAsAgInhTQvsxtVyQWon0W
	 qlGSk5wkM9od2cMVd2fiqc2DYZQexnNnpVeEA2KYyWATCQI3M77ssmxqJ87kpY4ir5
	 V4ell+IpsXkcEckYUi8g9BTqhDFe+Ov0ye25FlXwr2xcGJ29AdowhbBmftFm5Gz8Jg
	 5foIwvMldr72mGwa0XVkwqF6TON9A9bIiPJhYWarc8wVUKqNyI75mS1LnDQbqH5ljC
	 T7kq5SVBrRlycpz7zh9ZGhWjKnrwklHkirjxGM627qwB9i0tdVZKgCTetAlySZBaGS
	 KpfBrBW5Qd3LQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	justin@coraid.com,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/15] aoe: avoid potential deadlock at set_capacity
Date: Fri,  2 Feb 2024 13:40:48 -0500
Message-ID: <20240202184057.541411-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
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
index 128722cf6c3c..827802e418dd 100644
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


