Return-Path: <linux-kernel+bounces-116126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EE8895AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25A3CB2ECC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF93AD1A3;
	Mon, 25 Mar 2024 03:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdyeCg25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFE17A39D;
	Sun, 24 Mar 2024 23:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323660; cv=none; b=iguVXZRgKB+xQyi1t0qpgscAXUIp/PMYx4EGTzRb+mnuq3vb2semPduwERaIm66ca1U/tfN+DnlrSL7a7jybXZUjc6jBAoBZwTd1ed1hZbMYrG+hPeIi6B+Jd2L7ZwXG9KAFunn5wgJD9dhwy7xwYCShhIaNL1zv6R5MdQ6KNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323660; c=relaxed/simple;
	bh=EvF6yk0rVIb8AReax+xdLMBHydsrlD1ehkezoEOOnWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiLoL/OSXh7vD3IpnRXhdVZviQSK5hDzZhYUo+LXIB+x8X81eKk3jekfeuMDdIewIAbERh34bvsfEoeDAmKS4efa3bnb1I/IUvVTuRCboST4mMd0yUtGKaYh9WTdwmwmM0ohVv6JrdMcXXJODvC0pPorvSCvobH0OpL8Z+R4C6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdyeCg25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A27C433B2;
	Sun, 24 Mar 2024 23:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323660;
	bh=EvF6yk0rVIb8AReax+xdLMBHydsrlD1ehkezoEOOnWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AdyeCg25p2rL5CKYilX8cdFD5P/8DR5BdPkB1zLnBrvrDfQiM86qTR96bvgjV/A0i
	 0SieehzSoBvfnj9gwG36oLddjWK/SGG67OCAER5dvOPqHQq7SSXJai10YhcGA72Buv
	 A2zqbCiEuoMJhMnUk/OHxSIbgf9XSmmjYVYBaLZxYsZCoRpn9IciHV0Ht3xF8nk3M5
	 EdmuJwmkq8wUZAm5EFmEbsklkie+serjO1aWxy+jPkcSkEkoyl2Ywknlmyl97Dt1zQ
	 lcBOtoOhDXF/skYlp79AgAIvEp6kNDtpxmutx7rCy8Ncxm4ENS5jIQcOTsuHdr7CSG
	 M2CgPosJp+puQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 032/238] block: add a new set_read_only method
Date: Sun, 24 Mar 2024 19:37:00 -0400
Message-ID: <20240324234027.1354210-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit e00adcadf3af7a8335026d71ab9f0e0a922191ac ]

Add a new method to allow for driver-specific processing when setting or
clearing the block device read-only state.  This allows to replace the
cumbersome and error-prone override of the whole ioctl implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 9674f54e41ff ("md: Don't clear MD_CLOSING when the raid is about to stop")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c          | 5 +++++
 include/linux/blkdev.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index e7eed7dadb5cf..24f8042f12b60 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -405,6 +405,11 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		return ret;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
+	if (bdev->bd_disk->fops->set_read_only) {
+		ret = bdev->bd_disk->fops->set_read_only(bdev, n);
+		if (ret)
+			return ret;
+	}
 	set_device_ro(bdev, n);
 	return 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 98fdf5a31fd66..583824f111079 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1883,6 +1883,7 @@ struct block_device_operations {
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	int (*set_read_only)(struct block_device *bdev, bool ro);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
-- 
2.43.0


