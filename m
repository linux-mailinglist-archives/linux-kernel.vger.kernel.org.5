Return-Path: <linux-kernel+bounces-123606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC95890BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49364299E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676E13BACD;
	Thu, 28 Mar 2024 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9YL/Hgj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3678E13A879
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658426; cv=none; b=PMtpX7JeZZWcPcKCqRXRb7qPqrt3XArnv6ZtlJN+7bkvvYcNpXvNwSnojo0eA+Cr0Z9euSwY0UYLdewWD1/sRJ+aSJ8eT7AhymFZzNmAc14qrkxYVKkCWv2Z4guwl2mCyxfdV11q7oQARa/AkP5hjFKHYvJ6kWKOq5X9kbyw7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658426; c=relaxed/simple;
	bh=9Z6YD6FPCzBTKeIPm1fHe9GnkbXDhxoo7eDcvyUvuCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwwcVYaNileKZAEXDK09ujiq3h4sF9MbeFPG3CALqqdYVfw7HLINB+mSLZyzK3yZNu3M2hRfS7UxxVSYqY/9pAIRP5BTgc+LFu5++FwgjkB4oeF3MY8Xndx8eQt9d0MX3ZOTZ3DtO3BAyNiDUnHpjtzSNJfqDKw4awEtPcFlIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9YL/Hgj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NXXER/zigpP/1IR48CBo1zF8A1UxNQTU4ClNAQkl164=;
	b=Y9YL/HgjjPxfYCZDl767fff+NePAiuupg5PsmF7Ynm8ttbtCXYySJ4Z005lxl7O6AL8iqR
	n4B+Hd+hDFuS+tckyouIuNXd1Wes+Ayz1UqIrh2Kc7K7OLjjUMqt2CusYxW0qXyeRgqlux
	4dOcioqxI6qTGV4uvXdYdkWsb9w/T0Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-5C6a797YMhSPfEhO_58Kmg-1; Thu, 28 Mar 2024 16:40:20 -0400
X-MC-Unique: 5C6a797YMhSPfEhO_58Kmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50E4888905E;
	Thu, 28 Mar 2024 20:40:20 +0000 (UTC)
Received: from localhost (unknown [10.39.194.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 474F3C1576F;
	Thu, 28 Mar 2024 20:40:18 +0000 (UTC)
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
Subject: [RFC 6/9] dm-linear: add llseek(SEEK_HOLE/SEEK_DATA) support
Date: Thu, 28 Mar 2024 16:39:07 -0400
Message-ID: <20240328203910.2370087-7-stefanha@redhat.com>
In-Reply-To: <20240328203910.2370087-1-stefanha@redhat.com>
References: <20240328203910.2370087-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/md/dm-linear.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 2d3e186ca87e3..9b6cdfa4f951d 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -147,6 +147,30 @@ static int linear_report_zones(struct dm_target *ti,
 #define linear_report_zones NULL
 #endif
 
+static loff_t linear_seek_hole_data(struct dm_target *ti, loff_t offset,
+		int whence)
+{
+	struct linear_c *lc = ti->private;
+	loff_t ti_begin = ti->begin << SECTOR_SHIFT;
+	loff_t ti_len = ti->len << SECTOR_SHIFT;
+	loff_t bdev_start = lc->start << SECTOR_SHIFT;
+	loff_t bdev_offset;
+
+	/* TODO underflow/overflow? */
+	bdev_offset = offset - ti_begin + bdev_start;
+
+	bdev_offset = blkdev_seek_hole_data(lc->dev->bdev, bdev_offset,
+					    whence);
+	if (bdev_offset < 0)
+		return bdev_offset;
+
+	offset = bdev_offset - bdev_start;
+	if (offset >= ti_len)
+		return whence == SEEK_DATA ? -ENXIO : ti_begin + ti_len;
+
+	return offset + ti_begin;
+}
+
 static int linear_iterate_devices(struct dm_target *ti,
 				  iterate_devices_callout_fn fn, void *data)
 {
@@ -212,6 +236,7 @@ static struct target_type linear_target = {
 	.direct_access = linear_dax_direct_access,
 	.dax_zero_page_range = linear_dax_zero_page_range,
 	.dax_recovery_write = linear_dax_recovery_write,
+	.seek_hole_data = linear_seek_hole_data,
 };
 
 int __init dm_linear_init(void)
-- 
2.44.0


