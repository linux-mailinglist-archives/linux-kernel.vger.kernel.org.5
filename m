Return-Path: <linux-kernel+bounces-46923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E394844665
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5B728641D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED29012F5B0;
	Wed, 31 Jan 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrNEXOcW"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7D12F580
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706723050; cv=none; b=ndghu8HNautfNfZtr8FGgX7KJ9OYjthQNQ1iCQ8LwpuJ5eXf7u6wY24t+M9ckAARUxzkFJbPBF+Bg66CF50NeG5n3VmCEzfcXsXYpA8ZqCwxVVJ86kPdO+MfwbT546Qi75QiQgQ1a9l33/jP4sGPpxBE1cbxo2WlpuQPYsfC7Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706723050; c=relaxed/simple;
	bh=VSk1r76xIi4SMeq0I2cI7qMzmqTAXAADCa74sT2EN4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ug+42roZFmyDq9BXhVJLOn4i/qO+ToNwfZMyeXPFYHASfDhAQhiu3csDtJ7qiyJLqCQVoMr+9jzP87LLqd6Bh69coz7p1EU/wrpQuCyvsSbZFVpulR3MtEz304WQhSTjvtwaZJB4hhjMBa0vy0hrjPy3BLkV7WtjRXXHucgTS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrNEXOcW; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so1805a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706723046; x=1707327846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHCmvQ4HM3HYtffO/xIE+CYy/jMxpzrFI5HM00j5Odk=;
        b=VrNEXOcWoaLkqto0DOZcoCS01+0CziPzB66kE9b3hyUICZto7bDQpgFBjpx1enpgAW
         YlrUBmBemYK8SQmOYClBNyRDAqjzf71O05BnMgmSrkQbA73Bt/q0HuPd3e5zR4gTv9n+
         DjhXRJ9CwTbxmuJ6og+8T025w8xapZ6/9FqRcm0+AVYWKJAt3inS/OHOvdgBaGroaNDX
         0cGQS3AI2aM8cualcUT1u5ECXLa6OSh0nTNaLYC4FyXT055nHbJz4IP68wlFx0KB0XUu
         UvPYUm8Tf3LJtlyKk9LvSpkAkIQek14inAUiqJP9Mgh29YvNfRHqkEy+qGLD0zr//WqD
         kmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706723046; x=1707327846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHCmvQ4HM3HYtffO/xIE+CYy/jMxpzrFI5HM00j5Odk=;
        b=mELmJ3asO2ffE1jLBBMgJwCK+SsGsAgsk27mskHPI1fStFsEj57WQUL4pgCV23aez9
         VXCry54IQVNIv/mJHLaERa/qX8u8u8tY007WHEiUlLrgOI6daJtPVrut8QkF43uORziP
         o/bE81zLLTx+KDpHKbrSQKQB9768W1fhJktJFd1KvULduhFM9wMo11ifp7hsDW1S5YNK
         GCAKOTtL1bQatUO8YP1g+XXGLWPlvQ+FIXARXI3u9pynDMGZBaejOZ3oBKEvVZZioGv+
         /VrwIeu51X0SFBTjvYwSsHmIEhf4/6m1h8lqio/WXVjWscN1FHVwUjq4Vgn8GnbnAfDH
         Pvew==
X-Gm-Message-State: AOJu0YyatuCDddZsgE+3OwNBY899biKdq7oX+j0XbnDWP30f4UkyqiWX
	fp7qmaebbEkVO7kqeYp1QHZamuZoICkY1PDqZRiX7HPufHo1r982fndVGqa8DDTWgG829mXl4SD
	u
X-Google-Smtp-Source: AGHT+IG+Dlp3UcNaPdBJ5YqZRO0VX0UEA3ZPfxNnGLMgoVOPUHkzeZsuVzX7hJtCIMv33ZqZK9iryA==
X-Received: by 2002:a50:cd4b:0:b0:55f:6b8:b2fc with SMTP id d11-20020a50cd4b000000b0055f06b8b2fcmr1807622edj.2.1706723045922;
        Wed, 31 Jan 2024 09:44:05 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id o11-20020a056402444b00b0055d3d1653b3sm5712985edb.31.2024.01.31.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 09:44:05 -0800 (PST)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v2 2/3] mmc: block: register RPMB partition with the RPMB subsystem
Date: Wed, 31 Jan 2024 18:43:46 +0100
Message-Id: <20240131174347.510961-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131174347.510961-1-jens.wiklander@linaro.org>
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register eMMC RPMB partition with the RPMB subsystem and provide
an implementation for the RPMB access operations abstracting
the actual multi step process.

Add callbacks for getting and putting the needed resources, that is, the
RPMB data and the RPMB disk.

Add a callback to extract the needed device information at registration
to avoid accessing the struct mmc_card at a later stage as we're not
holding a reference counter for this struct.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/mmc/core/block.c | 177 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..5286e0b3a5a2 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -33,6 +33,7 @@
 #include <linux/cdev.h>
 #include <linux/mutex.h>
 #include <linux/scatterlist.h>
+#include <linux/string.h>
 #include <linux/string_helpers.h>
 #include <linux/delay.h>
 #include <linux/capability.h>
@@ -40,6 +41,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/idr.h>
 #include <linux/debugfs.h>
+#include <linux/rpmb.h>
 
 #include <linux/mmc/ioctl.h>
 #include <linux/mmc/card.h>
@@ -163,6 +165,7 @@ struct mmc_rpmb_data {
 	int id;
 	unsigned int part_index;
 	struct mmc_blk_data *md;
+	struct rpmb_dev *rdev;
 	struct list_head node;
 };
 
@@ -2707,6 +2710,169 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
 	kfree(rpmb);
 }
 
+static void rpmb_op_mmc_get_resources(struct device *dev)
+{
+	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
+
+	/*
+	 * When the MMC card is removed rpmb_dev_unregister() is called
+	 * from mmc_blk_remove_rpmb_part(). That removes references to the
+	 * devices in struct mmc_rpmb_data and rpmb->md. Since struct
+	 * rpmb_dev can still reach those structs we must hold a reference
+	 * until struct rpmb_dev also is released.
+	 *
+	 * This is analogous to what's done in mmc_rpmb_chrdev_open() and
+	 * mmc_rpmb_chrdev_release() below.
+	 */
+	get_device(dev);
+	mmc_blk_get(rpmb->md->disk);
+}
+
+static void rpmb_op_mmc_put_resources(struct device *dev)
+{
+	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
+
+	mmc_blk_put(rpmb->md);
+	put_device(dev);
+}
+
+static struct mmc_blk_ioc_data **alloc_idata(struct mmc_rpmb_data *rpmb,
+					     unsigned int cmd_count)
+{
+	struct mmc_blk_ioc_data **idata;
+	unsigned int n;
+
+	idata = kcalloc(cmd_count, sizeof(*idata), GFP_KERNEL);
+	if (!idata)
+		return NULL;
+
+	for (n = 0; n < cmd_count; n++) {
+		idata[n] = kcalloc(1, sizeof(**idata), GFP_KERNEL);
+		if (!idata[n]) {
+			kfree(idata);
+			return NULL;
+		}
+		idata[n]->rpmb = rpmb;
+	}
+
+	return idata;
+}
+
+static void set_idata(struct mmc_blk_ioc_data *idata, u32 opcode,
+		      int write_flag, u8 *buf, unsigned int buf_bytes)
+{
+	idata->ic.opcode = opcode;
+	idata->ic.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+	idata->ic.write_flag = write_flag;
+	idata->ic.blksz = sizeof(struct rpmb_frame);
+	idata->ic.blocks = buf_bytes /  idata->ic.blksz;
+	idata->buf = buf;
+	idata->buf_bytes = buf_bytes;
+}
+
+static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
+{
+	unsigned int n;
+
+	for (n = 0; n < cmd_count; n++)
+		kfree(idata[n]);
+	kfree(idata);
+}
+
+static int rpmb_op_mmc_route_frames(struct device *dev, bool write, u8 *req,
+				    unsigned int req_len, u8 *resp,
+				    unsigned int resp_len)
+{
+	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
+	struct mmc_blk_data *md = rpmb->md;
+	struct mmc_blk_ioc_data **idata;
+	unsigned int cmd_count;
+	struct request *rq;
+	int ret;
+
+	if (write)
+		cmd_count = 3;
+	else
+		cmd_count = 2;
+
+	if (IS_ERR(md->queue.card))
+		return PTR_ERR(md->queue.card);
+
+	idata = alloc_idata(rpmb, cmd_count);
+	if (!idata)
+		return -ENOMEM;
+
+	if (write) {
+		struct rpmb_frame *frm = (struct rpmb_frame *)resp;
+
+		/* Send write request frame(s) */
+		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
+			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
+
+		/* Send result request frame */
+		memset(frm, 0, sizeof(*frm));
+		frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
+		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
+			  resp_len);
+
+		/* Read response frame */
+		set_idata(idata[2], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
+	} else {
+		/* Send write request frame(s) */
+		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK, 1, req, req_len);
+
+		/* Read response frame */
+		set_idata(idata[1], MMC_READ_MULTIPLE_BLOCK, 0, resp, resp_len);
+	}
+
+	rq = blk_mq_alloc_request(md->queue.queue, REQ_OP_DRV_OUT, 0);
+	if (IS_ERR(rq)) {
+		ret = PTR_ERR(rq);
+		goto out;
+	}
+
+	req_to_mmc_queue_req(rq)->drv_op = MMC_DRV_OP_IOCTL_RPMB;
+	req_to_mmc_queue_req(rq)->drv_op_result = -EIO;
+	req_to_mmc_queue_req(rq)->drv_op_data = idata;
+	req_to_mmc_queue_req(rq)->ioc_count = cmd_count;
+	blk_execute_rq(rq, false);
+	ret = req_to_mmc_queue_req(rq)->drv_op_result;
+
+	blk_mq_free_request(rq);
+
+out:
+	free_idata(idata, cmd_count);
+	return ret;
+}
+
+static int rpmb_op_mmc_set_dev_info(struct device *dev, struct rpmb_dev *rdev)
+{
+	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
+	struct mmc_card *card = rpmb->md->queue.card;
+	unsigned int n;
+	u32 cid[4];
+
+	for (n = 0; n < 4; n++)
+		cid[n] = be32_to_cpu(card->raw_cid[n]);
+
+	rdev->dev_id = kmemdup(cid, sizeof(cid), GFP_KERNEL);
+	if (!rdev->dev_id)
+		return -ENOMEM;
+	rdev->dev_id_len = sizeof(cid);
+	rdev->reliable_wr_count = card->ext_csd.raw_rpmb_size_mult;
+	rdev->capacity = card->ext_csd.rel_sectors;
+
+	return 0;
+}
+
+static struct rpmb_ops rpmb_mmc_ops = {
+	.type = RPMB_TYPE_EMMC,
+	.get_resources = rpmb_op_mmc_get_resources,
+	.put_resources = rpmb_op_mmc_put_resources,
+	.route_frames = rpmb_op_mmc_route_frames,
+	.set_dev_info = rpmb_op_mmc_set_dev_info,
+};
+
 static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 				   struct mmc_blk_data *md,
 				   unsigned int part_index,
@@ -2751,6 +2917,14 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 		goto out_put_device;
 	}
 
+	rpmb->rdev = rpmb_dev_register(&rpmb->dev, &rpmb_mmc_ops);
+	if (IS_ERR(rpmb->rdev)) {
+		pr_err("%s: could not register RPMB device\n", rpmb_name);
+		ret = PTR_ERR(rpmb->rdev);
+		rpmb->rdev = NULL;
+		goto out_cdev_device_del;
+	}
+
 	list_add(&rpmb->node, &md->rpmbs);
 
 	string_get_size((u64)size, 512, STRING_UNITS_2,
@@ -2762,6 +2936,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 
 	return 0;
 
+out_cdev_device_del:
+	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
 out_put_device:
 	put_device(&rpmb->dev);
 	return ret;
@@ -2770,6 +2946,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
 
 {
+	rpmb_dev_unregister(rpmb->rdev);
 	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
 	put_device(&rpmb->dev);
 }
-- 
2.34.1


