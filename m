Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2967E7638
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345617AbjKJBCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345565AbjKJBBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:01:55 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2223C0E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:01:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6be0277c05bso1449793b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 17:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699578112; x=1700182912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b06Vj9lOHSb9sRVpxi+IgZjFW0xvb2n47gh9duK5vpM=;
        b=fHml8pM0AZqFsHLx+G5hKygpabuUGZhXqEWwK0EDYq+U9uDwfT66khW1/BemKVcBTS
         57wmby0t8H9qFsAxUeeMgbOJ8PTa6kl9uha4/RefDxHWwqfNNoeO7BXUApmzLFyYppAW
         8T17yTp5UHFVbNEeUZvVxqonMIRZ6Lm4F+OsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699578112; x=1700182912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b06Vj9lOHSb9sRVpxi+IgZjFW0xvb2n47gh9duK5vpM=;
        b=Hxgy5cvceG4x1v3Qs8hv14uDX5+3QFV2x2/R0Dw+/3fyUW6NKv+V+PfJ6E9d2BG/K8
         EKnbOBsnmnin12RbLvr4iG11HotyojsDCg1lfZsshl70bk6GLjPMj+UXpIpiAUzGrdYf
         HLAXKdj7UXmDdVkQ6ZbGNFbW/9UvrXnoYcgRZb6ZGl4W2yzYN0Dx/3mdyIPoT0ZvAAet
         Ipsh8PfGw8ficPBRZItEJ1ZnQGTmRZ1Zv7Hq7GqnxhqZ/ghkzQVNE1xYfD/sBv+uW+1O
         esFYwl/i5oDZhMYZCihiK8nNSYMwY+RsQybkz7dWAoJavimX/oaRxvpw3dOscHURp8bz
         oMSg==
X-Gm-Message-State: AOJu0YweZ1u7MktJwfBM4opOaqxF2feztYXjranc3FPxYj/HYXGDLDg8
        MKHMtW5dIF8gUKAUJqe0mZrsBQ==
X-Google-Smtp-Source: AGHT+IEcUrMoRB4M3cFIJYYG0U9EFFBVtRT/665jkYTpjvDYxK5d5N79MHBfBn5NU+hQE8l3/c87lA==
X-Received: by 2002:aa7:88d6:0:b0:6c3:1b90:8554 with SMTP id k22-20020aa788d6000000b006c31b908554mr6534965pff.12.1699578112454;
        Thu, 09 Nov 2023 17:01:52 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:e584:25c0:d29c:54c])
        by smtp.gmail.com with UTF8SMTPSA id m15-20020a056a00080f00b006c4db182074sm82725pfk.196.2023.11.09.17.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 17:01:52 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH v9 3/3] loop: Add support for provision requests
Date:   Thu,  9 Nov 2023 17:01:38 -0800
Message-ID: <20231110010139.3901150-4-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for provision requests to loopback devices. Loop devices
will configure provision support based on whether the underlying block
device/file can support the provision request and, upon receiving a
provision bio, will map it to the backing device/storage. For loop devices
over files, a REQ_OP_PROVISION request will translate to an fallocate()
mode 0 call on the backing file.

Caveat: For filesystems with copy-on-write semantics, REQ_OP_PROVISION
will guarantee the success of only the next write to the provisioned range
with a ENOSPC.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/block/loop.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f2d412fc560..c84d4acdb18c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -311,16 +311,20 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 {
 	/*
 	 * We use fallocate to manipulate the space mappings used by the image
-	 * a.k.a. discard/zerorange.
+	 * a.k.a. discard/provision/zerorange.
 	 */
 	struct file *file = lo->lo_backing_file;
 	int ret;
 
-	mode |= FALLOC_FL_KEEP_SIZE;
+	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE) &&
+	    !bdev_max_discard_sectors(lo->lo_device))
+		return -EOPNOTSUPP;
 
-	if (!bdev_max_discard_sectors(lo->lo_device))
+	if (mode == 0 && !bdev_max_provision_sectors(lo->lo_device))
 		return -EOPNOTSUPP;
 
+	mode |= FALLOC_FL_KEEP_SIZE;
+
 	ret = file->f_op->fallocate(file, mode, pos, blk_rq_bytes(rq));
 	if (unlikely(ret && ret != -EINVAL && ret != -EOPNOTSUPP))
 		return -EIO;
@@ -488,6 +492,13 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 				FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
+	case REQ_OP_PROVISION:
+		/*
+		 * fallocate() guarantees that the next writes to the
+		 * provisioned range will succeed without ENOSPC but does not
+		 * guarantee that every write to this range will succeed.
+		 */
+		return lo_fallocate(lo, rq, pos, 0);
 	case REQ_OP_WRITE:
 		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, ITER_SOURCE);
@@ -754,6 +765,25 @@ static void loop_sysfs_exit(struct loop_device *lo)
 				   &loop_attribute_group);
 }
 
+static void loop_config_provision(struct loop_device *lo)
+{
+	struct file *file = lo->lo_backing_file;
+	struct inode *inode = file->f_mapping->host;
+
+	/*
+	 * If the backing device is a block device, mirror its provisioning
+	 * capability.
+	 */
+	if (S_ISBLK(inode->i_mode)) {
+		blk_queue_max_provision_sectors(lo->lo_queue,
+			bdev_max_provision_sectors(I_BDEV(inode)));
+	} else if (file->f_op->fallocate) {
+		blk_queue_max_provision_sectors(lo->lo_queue, UINT_MAX >> 9);
+	} else {
+		blk_queue_max_provision_sectors(lo->lo_queue, 0);
+	}
+}
+
 static void loop_config_discard(struct loop_device *lo)
 {
 	struct file *file = lo->lo_backing_file;
@@ -1092,6 +1122,7 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	blk_queue_io_min(lo->lo_queue, bsize);
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
 	loop_sysfs_init(lo);
@@ -1304,6 +1335,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	}
 
 	loop_config_discard(lo);
+	loop_config_provision(lo);
 
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
@@ -1857,6 +1889,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
+	case REQ_OP_PROVISION:
 		cmd->use_aio = false;
 		break;
 	default:
-- 
2.39.2

