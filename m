Return-Path: <linux-kernel+bounces-50361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9993A847806
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB821C248BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8DF150993;
	Fri,  2 Feb 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPCKj1Tg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF828592C;
	Fri,  2 Feb 2024 18:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899192; cv=none; b=TS7YT5X9W36JWjf6+yQLCr3XWgv1xH2CHBQffQRpfnVcvEYVlcTUf89xhk1BoERTGpWI2Aphwhfm0mdmsSfzGTKS5qvVfEJUunSUQtr5q0xQ9sMeYdLWeB6RtNPCpwsmI3uK8xuXlxRIPta41BOXTgPmG5X0biIRXBQsGKznnqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899192; c=relaxed/simple;
	bh=eZMy0rsC1O2myoC9DEfCEzi+FKFhOhwY9HAwgwyPxHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAd9bFDpJDpfhLZ2Y4cSs7fNfoyhUJU9UNMGPjf99f5DLvfTMTxp6tQw+5lTgxk9Ov9Upt7Zrz2kXhsAOHPvMU0nupSPufedyu5L89mKYr5pRAKH3V18WxxVbkNrv1/TTLWvbBDyIICbYVgXk7MWVQDTrj6qA/57ao8eyo8Uzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPCKj1Tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C03AC43399;
	Fri,  2 Feb 2024 18:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899191;
	bh=eZMy0rsC1O2myoC9DEfCEzi+FKFhOhwY9HAwgwyPxHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPCKj1Tgd8f9vg8F5m9YXxyeYkqXRoqbVSgDMXUoZeg2qw4ICpcaMnnsNY4QDS7wv
	 frcvW9aFut2pIKLiC9oYIW53oHOMmJ0owe10vLpjjzcDY88ho36op1sPIqow+G4JNd
	 7E6yuiWOoLI+TToE3DDqC5hUjEsslynZQHBbdzKK2VXBo/L1e13hkrBCccCeuRZaNj
	 T6FCHJoIRtpl01S/PnwmSEkOfynpT5RRtoR21GN+uEs6AcMfoy9fLwfYwimXgkZjgh
	 wMV9I/s+aiS71ewZHhWfPNZXDYFFF9BUo3I6oAvGpkzDyswGIKkChiRjZsCr+Ox3IN
	 LvZ2tOHhrxCMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maksim Kiselev <bigunclemax@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	justin@coraid.com,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 16/23] aoe: avoid potential deadlock at set_capacity
Date: Fri,  2 Feb 2024 13:39:12 -0500
Message-ID: <20240202183926.540467-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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


