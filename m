Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6A7E7633
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345571AbjKJBB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJBBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:01:52 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F413C01
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:01:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1295125b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699578110; x=1700182910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpIlXDAK836nj2ayS4Px4IQ+M7LfyqBN0RSk77HlWk0=;
        b=k/XOAW1f2zktIdEXBUiXfdYhwhgWtVlr87eGvmwU2ejrxqU+850JvCg1XcwvC1mEYW
         gP5WDvEj97Obv35crFQ95piifEtQrhQ8GNo+TtEfJCUXdqbq+MD3M8I63sFfMoWdvBrp
         MoTNeKUtOhbfWib9M55IFaaDAZ1z1pPuhkdGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699578110; x=1700182910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpIlXDAK836nj2ayS4Px4IQ+M7LfyqBN0RSk77HlWk0=;
        b=WHYv0jIFlDagiQhsg+wusot8itXP3QeIK6pcqmkQgQnrRqdOWiuaIKzmnUzZNsxtwK
         AIR0XqG4XYV0nmNDjFGHMMF8NFn8o4RHEX1+Hyglo5TJUz+K0WIOZyhkTyCa1Vt44lSy
         qcwpvobO0kG08UbIeMcNedpxyKqOg2KbqsvSDkb4lc82l8OK8zFNRALZtaKs2tJciuQu
         f2L88//gQjfjm5vTnUFsgtqoAh468WdXYf3brBUTdU+s5ojFvinn+W0lbBbDoZetB900
         1Q+UECItSMMPenOq41Nl/PX5eLLEjQKjZ/22HfE3j8tr27EFoJM7RcX9tEzjrp3wEvvG
         k4yQ==
X-Gm-Message-State: AOJu0Yye8HWFM5UY/pD2shRaAZ+MSbEMKABb0IseVVR7sXAdf5JMSt43
        z7mgyXo0DnEafSBy/VaCTAFCLw==
X-Google-Smtp-Source: AGHT+IFs9+3vv5SiURWJQfxLcqgU9CLjws5ou3tIHtJ9h+cXOfzdemON/fbHWOOjBj5e21c6QxkEEw==
X-Received: by 2002:a05:6a00:6592:b0:6bf:15fb:4b32 with SMTP id hd18-20020a056a00659200b006bf15fb4b32mr1401432pfb.8.1699578110109;
        Thu, 09 Nov 2023 17:01:50 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:e584:25c0:d29c:54c])
        by smtp.gmail.com with UTF8SMTPSA id k76-20020a636f4f000000b005b529d633b7sm5224838pgc.14.2023.11.09.17.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:01:49 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v9 2/3] dm: Add block provisioning support
Date:   Thu,  9 Nov 2023 17:01:37 -0800
Message-ID: <20231110010139.3901150-3-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add block provisioning support for device-mapper targets.
dm-crypt and dm-linear will, by default, passthrough REQ_OP_PROVISION
requests to the underlying device, if supported.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-crypt.c         |  4 +++-
 drivers/md/dm-linear.c        |  1 +
 drivers/md/dm-table.c         | 23 +++++++++++++++++++++++
 drivers/md/dm.c               |  7 +++++++
 include/linux/device-mapper.h | 17 +++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 6de107aff331..1d18926ae801 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3365,6 +3365,8 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		cc->tag_pool_max_sectors <<= cc->sector_shift;
 	}
 
+	ti->num_provision_bios = 1;
+
 	ret = -ENOMEM;
 	cc->io_queue = alloc_workqueue("kcryptd_io/%s", WQ_MEM_RECLAIM, 1, devname);
 	if (!cc->io_queue) {
@@ -3419,7 +3421,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	 * - for REQ_OP_DISCARD caller must use flush if IO ordering matters
 	 */
 	if (unlikely(bio->bi_opf & REQ_PREFLUSH ||
-	    bio_op(bio) == REQ_OP_DISCARD)) {
+	    bio_op(bio) == REQ_OP_DISCARD || bio_op(bio) == REQ_OP_PROVISION)) {
 		bio_set_dev(bio, cc->dev->bdev);
 		if (bio_sectors(bio))
 			bio->bi_iter.bi_sector = cc->start +
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 2d3e186ca87e..8d2dc9dfe93e 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->num_provision_bios = 1;
 	ti->private = lc;
 	return 0;
 
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 198d38b53322..f29100fc1a60 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1877,6 +1877,26 @@ static bool dm_table_supports_write_zeroes(struct dm_table *t)
 	return true;
 }
 
+static int device_provision_capable(struct dm_target *ti, struct dm_dev *dev,
+				    sector_t start, sector_t len, void *data)
+{
+	return bdev_max_provision_sectors(dev->bdev);
+}
+
+static bool dm_table_supports_provision(struct dm_table *t)
+{
+	for (unsigned int i = 0; i < t->num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(t, i);
+
+		if (ti->provision_supported ||
+		    (ti->type->iterate_devices &&
+		    ti->type->iterate_devices(ti, device_provision_capable, NULL)))
+			return true;
+	}
+
+	return false;
+}
+
 static int device_not_nowait_capable(struct dm_target *ti, struct dm_dev *dev,
 				     sector_t start, sector_t len, void *data)
 {
@@ -2010,6 +2030,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (!dm_table_supports_write_zeroes(t))
 		q->limits.max_write_zeroes_sectors = 0;
 
+	if (!dm_table_supports_provision(t))
+		q->limits.max_provision_sectors = 0;
+
 	dm_table_verify_integrity(t);
 
 	/*
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 23c32cd1f1d8..2e207fa0b0f4 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1609,6 +1609,7 @@ static bool is_abnormal_io(struct bio *bio)
 		case REQ_OP_DISCARD:
 		case REQ_OP_SECURE_ERASE:
 		case REQ_OP_WRITE_ZEROES:
+		case REQ_OP_PROVISION:
 			return true;
 		default:
 			break;
@@ -1645,6 +1646,12 @@ static blk_status_t __process_abnormal_io(struct clone_info *ci,
 		if (ti->max_write_zeroes_granularity)
 			max_granularity = max_sectors;
 		break;
+	case REQ_OP_PROVISION:
+		num_bios = ti->num_provision_bios;
+		max_sectors = limits->max_provision_sectors;
+		if (ti->max_provision_granularity)
+			max_granularity = max_sectors;
+		break;
 	default:
 		break;
 	}
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 772ab4d74d94..c1d674d32444 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -333,6 +333,12 @@ struct dm_target {
 	 */
 	unsigned int num_write_zeroes_bios;
 
+	/*
+	 * The number of PROVISION bios that will be submitted to the target.
+	 * The bio number can be accessed with dm_bio_get_target_bio_nr.
+	 */
+	unsigned int num_provision_bios;
+
 	/*
 	 * The minimum number of extra bytes allocated in each io for the
 	 * target to use.
@@ -357,6 +363,11 @@ struct dm_target {
 	 */
 	bool discards_supported:1;
 
+	/* Set if this target needs to receive provision requests regardless of
+	 * whether or not its underlying devices have support.
+	 */
+	bool provision_supported:1;
+
 	/*
 	 * Set if this target requires that discards be split on
 	 * 'max_discard_sectors' boundaries.
@@ -375,6 +386,12 @@ struct dm_target {
 	 */
 	bool max_write_zeroes_granularity:1;
 
+	/*
+	 * Set if this target requires that provisions be split on
+	 * 'max_provision_sectors' boundaries.
+	 */
+	bool max_provision_granularity:1;
+
 	/*
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
-- 
2.39.2

