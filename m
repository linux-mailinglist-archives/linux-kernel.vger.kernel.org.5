Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003687C67F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347244AbjJLIEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbjJLIEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:04:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622DA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:04:05 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S5hsz26cqzrTG0;
        Thu, 12 Oct 2023 16:01:27 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 16:04:02 +0800
Message-ID: <a8a2dc17-7a7a-e725-8ae2-e7e0146150f0@huawei.com>
Date:   Thu, 12 Oct 2023 16:04:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     Zhihao Cheng <chengzhihao1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231010142925.545238-1-wangzhaolong1@huawei.com>
 <9f96baf1-962e-d595-0e4f-797315cd0348@huawei.com>
 <b972f615-3882-18cf-5b44-7ec021f92e0a@huawei.com>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <b972f615-3882-18cf-5b44-7ec021f92e0a@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm very happy to receive a reply to the review.

> 2. fd = open(/dev/ubi0_0, O_WRONLY)
>      ubi_open_volume  // vol->writers = 1
> 
>           P1                    P2
>     gluebi_create -> mtd_device_register -> add_mtd_device:
>     device_register   // dev/mtd1 is visible
> 
>                       fd = open(/dev/mtd1, O_WRONLY)
>                        gluebi_get_device
>                         gluebi->desc = ubi_open_volume
>                          gluebi->desc = ERR_PTR(EBUSY)
> 
>     ftl_add_mtd
>      mtd_read
>       gluebi_read
>        gluebi->desc is ERR_PTR       (√)

The reproduction steps for situations 2 and 3 have been added to link[1].
Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]

> 3.         P1                    P2
>     gluebi_create -> mtd_device_register -> add_mtd_device:
>     device_register   // dev/mtd1 is visible
> 
>                       fd = open(/dev/mtd1, O_WRONLY)
>                        gluebi_get_device
>                         gluebi->desc = ubi_open_volume
> 
>     ftl_add_mtd
>      mtd_read
>       gluebi_read
>        gluebi->desc is not ERR_PTR/NULL
> 
>                      close(fd)
>                       gluebi_put_device
>                        ubi_close_volume
>                         kfree(desc)
>        ubi_read(gluebi->desc)   // UAF  (×)
> 

Yes, it's also a problem. Perhaps it should be set to NULL after
destroying gluebi->desc.

> 
> No need to modify 'gluebi_write' and 'gluebi_erase'.
> 

The patch is as follows:

diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index 1b980d15d9fb..8fc6017d1155 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -85,6 +85,7 @@ static int gluebi_get_device(struct mtd_info *mtd)
  {
  	struct gluebi_device *gluebi;
  	int ubi_mode = UBI_READONLY;
+	struct ubi_volume_desc *vdesc;

  	if (mtd->flags & MTD_WRITEABLE)
  		ubi_mode = UBI_READWRITE;
@@ -109,12 +110,14 @@ static int gluebi_get_device(struct mtd_info *mtd)
  	 * This is the first reference to this UBI volume via the MTD device
  	 * interface. Open the corresponding volume in read-write mode.
  	 */
-	gluebi->desc = ubi_open_volume(gluebi->ubi_num, gluebi->vol_id,
+	vdesc = ubi_open_volume(gluebi->ubi_num, gluebi->vol_id,
  				       ubi_mode);
-	if (IS_ERR(gluebi->desc)) {
+	if (IS_ERR(vdesc)) {
+		gluebi->desc = NULL;
  		mutex_unlock(&devices_mutex);
-		return PTR_ERR(gluebi->desc);
+		return PTR_ERR(vdesc);
  	}
+	gluebi->desc = vdesc;
  	gluebi->refcnt += 1;
  	mutex_unlock(&devices_mutex);
  	return 0;
@@ -134,8 +137,10 @@ static void gluebi_put_device(struct mtd_info *mtd)
  	gluebi = container_of(mtd, struct gluebi_device, mtd);
  	mutex_lock(&devices_mutex);
  	gluebi->refcnt -= 1;
-	if (gluebi->refcnt == 0)
+	if (gluebi->refcnt == 0) {
  		ubi_close_volume(gluebi->desc);
+		gluebi->desc = NULL;
+	}
  	mutex_unlock(&devices_mutex);
  }

@@ -154,9 +159,26 @@ static int gluebi_read(struct mtd_info *mtd, loff_t 
from, size_t len,
  		       size_t *retlen, unsigned char *buf)
  {
  	int err = 0, lnum, offs, bytes_left;
-	struct gluebi_device *gluebi;
+	struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
+						    mtd);
+	int isnt_get = unlikely(gluebi->desc == NULL) ? 1 : 0;
+
+	/**
+	 * In normal case, the UBI volume desc has been initialized by
+	 * ->_get_device(). However, in the ftl notifier process, the
+	 * ->_get_device() is not executed in advance and the MTD device
+	 * is directly scanned  which cause null pointe dereference.
+	 * Therefore, try to get the MTD device here.
+	 */
+	if (unlikely(isnt_get)) {
+		err = __get_mtd_device(mtd);
+		if (err) {
+			err_msg("cannot get MTD device %d, UBI device %d, volume %d, error %d",
+				mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
+			return err;
+		}
+	}

-	gluebi = container_of(mtd, struct gluebi_device, mtd);
  	lnum = div_u64_rem(from, mtd->erasesize, &offs);
  	bytes_left = len;
  	while (bytes_left) {
@@ -176,6 +198,9 @@ static int gluebi_read(struct mtd_info *mtd, loff_t 
from, size_t len,
  	}

  	*retlen = len - bytes_left;
+
+	if (unlikely(isnt_get))
+		__put_mtd_device(mtd);
  	return err;
  }



