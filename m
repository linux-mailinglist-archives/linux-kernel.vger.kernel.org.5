Return-Path: <linux-kernel+bounces-83508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63E5869A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C29A1C2334C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22F5146909;
	Tue, 27 Feb 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBLgjC1d"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF47145B1D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047908; cv=none; b=Xs7h+KZtruHnBkxspM1oAs7QNhBGtrEn9uUjcSGUQ0VMo5V82zFVpFIp+HDD8XpXH4rCHXHn0+0iqFKHbcKR9TdpTr8EHI/3Yonb1cCt5wbx05y/ngLgsnwVMnLOsSEUZXyF5JVtw3M4kKJLGSkzZ9fhL3c8Ga86lSdisQTm/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047908; c=relaxed/simple;
	bh=1dJ5KMO115zjWy3uSjyJd8Z3pSKqxO7u/Ndcu01pUro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvOxWxcnjrat1hxqfyj8+mgSq6MSM+h66wuIzTkizkzMsqBkoUMPBT32Sns2HS/ILESRyqx0nEwdYr4ZidGl9CXQ3VgAf2mKne1aeDoPlwoixmL5x6+QGgArN24steU/wZgLxIQiJtOuFozNWvWXf6sKSqwTqGE1dT1xUDtYTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBLgjC1d; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51316d6e026so196380e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709047905; x=1709652705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wv9SZmk5WjM4EeRmP21EiIvOKib0FvHdz7yfzOH1038=;
        b=uBLgjC1dF9G+iWKmNFJRKgz8tVPRZNOE2nbgWSvYxIJDYJCFDSCGnRAChykoCIzlQ1
         mG5hfbMRyfLH48U0CR160y1+koqFMSvUSiHpFVE/DG/zwn78MW8dwH63UdyC+fYL+WBU
         HDSizMkDTblfxbOkR73mLUI0OM79jlnbJHx2q7k08RPVanH+2PNnRyDf1FHXZ87rtCgq
         MiiMMDzZ2cd4JNb7fdszL57pWZs1BdbUO+oW6OvTDZbuQ1xZhVX+ouS9JXOwKJ06746g
         EsmXaGZozePHIcmDFmfUgEB6ak9cOG+WefcvCEPWHg/clzXzpCLCY011iDz/A5btbN1O
         fbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047905; x=1709652705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wv9SZmk5WjM4EeRmP21EiIvOKib0FvHdz7yfzOH1038=;
        b=ZKMD6K0n1QrpwrToVdA7kh4UwMkmNUaY7G4mHD8rBkwOr4YturSX9R47B+fIzV4Vxd
         rjs7S+sWi3+jKk9K711OKE+WDIC3Th4YL1961TVpi/LvroTxfCz22LjwHbX4K8uAzraV
         wVdf7uT7KQ2zQ5c4rm0Raul3WNsfNBYJZDhXHyiheAPHcC0eNURdtyFy5ZYxGOP1zyop
         4fmesFvzF8DZAsVcb/uVOlvRyTn6tjkujwWZHy5Bs4BXOnCk9D0V6U1/HgdXYLJavUw6
         8QLzrxXWtddRPd5ikNN6l9Npt0GJEttXNCK5J3NExpShDnl7UDT/zkU5DAPQPPU7T/QR
         ZOlA==
X-Gm-Message-State: AOJu0YzzrNOKSNXtq9PlflHBUTnG966sEGXR+21tRghqpamBZNaw20Pj
	95p8LM151uIofMmY1mHKAuyaVDbja48d6/RZVZwf6Gpb+g0rihspf/B872Nm2tIigrrT5fstNZT
	Z
X-Google-Smtp-Source: AGHT+IHNwUqs1cPWaVopSE/f1g19skmrCJLZSyaU451AlUG/Tqwe5uQsCczyUlFRws1vB4qwF9Mj1A==
X-Received: by 2002:a05:6512:2820:b0:512:ba41:51f with SMTP id cf32-20020a056512282000b00512ba41051fmr7593969lfb.50.1709047904687;
        Tue, 27 Feb 2024 07:31:44 -0800 (PST)
Received: from localhost.localdomain (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id h18-20020a19ca52000000b00513003b8ebesm586969lfj.135.2024.02.27.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:31:44 -0800 (PST)
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
Subject: [PATCH v3 2/3] mmc: block: register RPMB partition with the RPMB subsystem
Date: Tue, 27 Feb 2024 16:31:31 +0100
Message-Id: <20240227153132.2611499-3-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227153132.2611499-1-jens.wiklander@linaro.org>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
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

Add a callback to extract the needed device information at registration
to avoid accessing the struct mmc_card at a later stage as we're not
holding a reference counter for this struct.

Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
instead of in mmc_rpmb_chrdev_open(). This is needed by the
route_frames() function pointer in struct rpmb_ops.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/mmc/core/block.c | 153 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 32d49100dff5..f35c99638eb2 100644
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
 
@@ -2672,7 +2675,6 @@ static int mmc_rpmb_chrdev_open(struct inode *inode, struct file *filp)
 
 	get_device(&rpmb->dev);
 	filp->private_data = rpmb;
-	mmc_blk_get(rpmb->md->disk);
 
 	return nonseekable_open(inode, filp);
 }
@@ -2682,7 +2684,6 @@ static int mmc_rpmb_chrdev_release(struct inode *inode, struct file *filp)
 	struct mmc_rpmb_data *rpmb = container_of(inode->i_cdev,
 						  struct mmc_rpmb_data, chrdev);
 
-	mmc_blk_put(rpmb->md);
 	put_device(&rpmb->dev);
 
 	return 0;
@@ -2703,10 +2704,147 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
 {
 	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
 
+	rpmb_dev_unregister(rpmb->rdev);
+	mmc_blk_put(rpmb->md);
 	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
 	kfree(rpmb);
 }
 
+static void free_idata(struct mmc_blk_ioc_data **idata, unsigned int cmd_count)
+{
+	unsigned int n;
+
+	for (n = 0; n < cmd_count; n++)
+		kfree(idata[n]);
+	kfree(idata);
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
+			free_idata(idata, n);
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
+	.route_frames = rpmb_op_mmc_route_frames,
+	.set_dev_info = rpmb_op_mmc_set_dev_info,
+};
+
 static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 				   struct mmc_blk_data *md,
 				   unsigned int part_index,
@@ -2741,6 +2879,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 	rpmb->dev.release = mmc_blk_rpmb_device_release;
 	device_initialize(&rpmb->dev);
 	dev_set_drvdata(&rpmb->dev, rpmb);
+	mmc_blk_get(md->disk);
 	rpmb->md = md;
 
 	cdev_init(&rpmb->chrdev, &mmc_rpmb_fileops);
@@ -2751,6 +2890,14 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
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
@@ -2762,6 +2909,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
 
 	return 0;
 
+out_cdev_device_del:
+	cdev_device_del(&rpmb->chrdev, &rpmb->dev);
 out_put_device:
 	put_device(&rpmb->dev);
 	return ret;
-- 
2.34.1


