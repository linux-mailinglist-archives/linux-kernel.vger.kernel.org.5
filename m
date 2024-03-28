Return-Path: <linux-kernel+bounces-123599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053A890B93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621461C302C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF5C13AD12;
	Thu, 28 Mar 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEZ1G5FZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EDA13A3E7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658393; cv=none; b=FhbI493x39Nohwa261lbC7UAHmLI2ho69qUV6yhnSiFWc7LvsDacX6DnJzcgqayU0J996ItfOqJ32MUDTBsOHTbsS0KxkKKAmiws1JD7J/HfQ3tuydFz/rIHGKcZX+pcLmVwyayvdL1ISBcrPBNsshTbmrvYa107zPQJmc++n2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658393; c=relaxed/simple;
	bh=Z/9BALdmqq/q3tmjj2QgJEd4wnfZA9Ii706QeBSvW/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=McWFrD6XiM+Y7FMby4Z6DAaFZXBrM3kIqC2SrHBMZX84tNJkWCXS+bjfmT5Yu1n11bYZXoUOu5UY/dDrESKa7n3BXVp79gKZsPz3hmAo1C2aLwXY3GWOB2NSLvcHJF0Kn3HHfRCd4lr4+WOndrxaSEZ8crfHD/gwuKD1GlOymSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEZ1G5FZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifdaXHJafNhgJEodv1uxro7ZmRQAOz8+u7BNkXOalBo=;
	b=QEZ1G5FZ2vWF9jfR84zg1Rvli180LBl1uvUGYmw5BbSAGIQvdphmUSZUiJOnQFok0DweJB
	autHHgHYoPl8HVi8ooQuWy/uLT9FqAf1p76ymFeiWxMCKKVwCIqRFxXf8eERfxccchhnLX
	4FYv46cyIND5SRki7Gzvvk7hR473rFI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-EC1kfjvMNx-NTQDJ-Tmc6A-1; Thu,
 28 Mar 2024 16:39:46 -0400
X-MC-Unique: EC1kfjvMNx-NTQDJ-Tmc6A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAC9A1C2CDF2;
	Thu, 28 Mar 2024 20:39:45 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C12A3492BDA;
	Thu, 28 Mar 2024 20:39:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	eblake@redhat.com,
	Alasdair Kergon <agk@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	David Teigland <teigland@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Joe Thornber <ejt@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 1/9] block: add llseek(SEEK_HOLE/SEEK_DATA) support
Date: Thu, 28 Mar 2024 16:39:02 -0400
Message-ID: <20240328203910.2370087-2-stefanha@redhat.com>
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

The SEEK_HOLE/SEEK_DATA interface is used by userspace applications to
detect sparseness. This makes copying and backup applications faster and
reduces space consumption because only ranges that do not contain data
can be skipped.

Handle SEEK_HOLE/SEEK_DATA for block devices. No block drivers implement
the new callback yet so the entire block device will appear to contain
data. Later patches will add support to drivers so this actually becomes
useful.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/linux/blkdev.h |  7 +++++++
 block/fops.c           | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be9..eecfbf9c27fc4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -332,6 +332,9 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_op op,
 int blk_revalidate_disk_zones(struct gendisk *disk,
 		void (*update_driver_data)(struct gendisk *disk));
 
+loff_t blkdev_seek_hole_data(struct block_device *bdev, loff_t offset,
+		int whence);
+
 /*
  * Independent access ranges: struct blk_independent_access_range describes
  * a range of contiguous sectors that can be accessed using device command
@@ -1432,6 +1435,10 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
+
+	/* Like llseek(SEEK_HOLE/SEEK_DATA). This callback may be NULL. */
+	loff_t (*seek_hole_data)(struct block_device *bdev, loff_t offset,
+			int whence);
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe82..8ffbfec6b4c25 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -523,6 +523,43 @@ const struct address_space_operations def_blk_aops = {
 };
 #endif /* CONFIG_BUFFER_HEAD */
 
+/* Like llseek(SEEK_HOLE/SEEK_DATA) */
+loff_t blkdev_seek_hole_data(struct block_device *bdev, loff_t offset,
+		int whence)
+{
+	const struct block_device_operations *fops = bdev->bd_disk->fops;
+	loff_t size;
+
+	if (fops->seek_hole_data)
+		return fops->seek_hole_data(bdev, offset, whence);
+
+	size = bdev_nr_bytes(bdev);
+
+	switch (whence) {
+	case SEEK_DATA:
+		if ((unsigned long long)offset >= size)
+			return -ENXIO;
+		return offset;
+	case SEEK_HOLE:
+		if ((unsigned long long)offset >= size)
+			return -ENXIO;
+		return size;
+	default:
+		return -EINVAL;
+	}
+}
+
+static loff_t blkdev_llseek_hole_data(struct file *file, loff_t offset,
+		int whence)
+{
+	struct block_device *bdev = file_bdev(file);
+
+	offset = blkdev_seek_hole_data(bdev, offset, whence);
+	if (offset >= 0)
+		offset = vfs_setpos(file, offset, bdev_nr_bytes(bdev));
+	return offset;
+}
+
 /*
  * for a block special file file_inode(file)->i_size is zero
  * so we compute the size by hand (just as in block_read/write above)
@@ -533,7 +570,11 @@ static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
 	loff_t retval;
 
 	inode_lock(bd_inode);
-	retval = fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
+	if (whence == SEEK_HOLE || whence == SEEK_DATA)
+		retval = blkdev_llseek_hole_data(file, offset, whence);
+	else
+		retval = fixed_size_llseek(file, offset, whence,
+					   i_size_read(bd_inode));
 	inode_unlock(bd_inode);
 	return retval;
 }
-- 
2.44.0


