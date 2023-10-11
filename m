Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66F7C47D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 04:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344828AbjJKCc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 22:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344584AbjJKCcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 22:32:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1CCF4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 19:32:48 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4xZD1CKBzrTDX;
        Wed, 11 Oct 2023 10:30:12 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 10:32:45 +0800
Message-ID: <9f96baf1-962e-d595-0e4f-797315cd0348@huawei.com>
Date:   Wed, 11 Oct 2023 10:32:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH RFC] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
References: <20231010142925.545238-1-wangzhaolong1@huawei.com>
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
In-Reply-To: <20231010142925.545238-1-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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


> This patch assumes that the gluebi module is not designed to work with
> the ftl module. In this case, the patch only needs to prevent the ftl
> notifier operation.
> 
> Add some correctness check for gluebi->desc in gluebi_read/write/erase(),
> If the pointer is invalid, the -EINVAL is returned.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/gluebi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
> index 1b980d15d9fb..189ecc0eacd1 100644
> --- a/drivers/mtd/ubi/gluebi.c
> +++ b/drivers/mtd/ubi/gluebi.c
> @@ -157,6 +157,9 @@ static int gluebi_read(struct mtd_info *mtd, loff_t from, size_t len,
>   	struct gluebi_device *gluebi;
>   
>   	gluebi = container_of(mtd, struct gluebi_device, mtd);
> +	if (IS_ERR_OR_NULL(gluebi->desc))
> +		return -EINVAL;
> +
>   	lnum = div_u64_rem(from, mtd->erasesize, &offs);
>   	bytes_left = len;
>   	while (bytes_left) {
> @@ -197,6 +200,9 @@ static int gluebi_write(struct mtd_info *mtd, loff_t to, size_t len,
>   	struct gluebi_device *gluebi;
>   
>   	gluebi = container_of(mtd, struct gluebi_device, mtd);
> +	if (IS_ERR_OR_NULL(gluebi->desc))
> +		return -EINVAL;
> +
>   	lnum = div_u64_rem(to, mtd->erasesize, &offs);
>   
>   	if (len % mtd->writesize || offs % mtd->writesize)
> @@ -242,6 +248,8 @@ static int gluebi_erase(struct mtd_info *mtd, struct erase_info *instr)
>   	lnum = mtd_div_by_eb(instr->addr, mtd);
>   	count = mtd_div_by_eb(instr->len, mtd);
>   	gluebi = container_of(mtd, struct gluebi_device, mtd);
> +	if (IS_ERR_OR_NULL(gluebi->desc))
> +		return -EINVAL;
>   
>   	for (i = 0; i < count - 1; i++) {
>   		err = ubi_leb_unmap(gluebi->desc, lnum + i);


This modification attempts another solution. Always check the validity
of gluebi->desc. If the gluebi->desc pointer is invalid, try to get MTD
device.


diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index 1b980d15d9fb..f1a74ccf1718 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -154,9 +154,19 @@ static int gluebi_read(struct mtd_info *mtd, loff_t 
from, size_t len,
  		       size_t *retlen, unsigned char *buf)
  {
  	int err = 0, lnum, offs, bytes_left;
-	struct gluebi_device *gluebi;
+	struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
+						    mtd);
+	int not_get = IS_ERR_OR_NULL(gluebi->desc);
+
+	if (not_get) {
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
@@ -176,6 +186,9 @@ static int gluebi_read(struct mtd_info *mtd, loff_t 
from, size_t len,
  	}

  	*retlen = len - bytes_left;
+
+	if (not_get)
+		__put_mtd_device(mtd);
  	return err;
  }

@@ -194,9 +207,19 @@ static int gluebi_write(struct mtd_info *mtd, 
loff_t to, size_t len,
  			size_t *retlen, const u_char *buf)
  {
  	int err = 0, lnum, offs, bytes_left;
-	struct gluebi_device *gluebi;
+	struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
+						    mtd);
+	int not_get = IS_ERR_OR_NULL(gluebi->desc);
+
+	if (not_get) {
+		err = __get_mtd_device(mtd);
+		if (err) {
+			err_msg("cannot get MTD device %d, UBI device %d, volume %d, error %d",
+				mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
+			return err;
+		}
+	}

-	gluebi = container_of(mtd, struct gluebi_device, mtd);
  	lnum = div_u64_rem(to, mtd->erasesize, &offs);

  	if (len % mtd->writesize || offs % mtd->writesize)
@@ -220,6 +243,9 @@ static int gluebi_write(struct mtd_info *mtd, loff_t 
to, size_t len,
  	}

  	*retlen = len - bytes_left;
+
+	if (not_get)
+		__put_mtd_device(mtd);
  	return err;
  }

@@ -234,14 +260,24 @@ static int gluebi_write(struct mtd_info *mtd, 
loff_t to, size_t len,
  static int gluebi_erase(struct mtd_info *mtd, struct erase_info *instr)
  {
  	int err, i, lnum, count;
-	struct gluebi_device *gluebi;
+	struct gluebi_device *gluebi = container_of(mtd, struct gluebi_device,
+						    mtd);
+	int not_get = IS_ERR_OR_NULL(gluebi->desc);
+
+	if (not_get) {
+		err = __get_mtd_device(mtd);
+		if (err) {
+			err_msg("cannot get MTD device %d, UBI device %d, volume %d, error %d",
+				mtd->index, gluebi->ubi_num, gluebi->vol_id, err);
+			return err;
+		}
+	}

  	if (mtd_mod_by_ws(instr->addr, mtd) || mtd_mod_by_ws(instr->len, mtd))
  		return -EINVAL;

  	lnum = mtd_div_by_eb(instr->addr, mtd);
  	count = mtd_div_by_eb(instr->len, mtd);
-	gluebi = container_of(mtd, struct gluebi_device, mtd);

  	for (i = 0; i < count - 1; i++) {
  		err = ubi_leb_unmap(gluebi->desc, lnum + i);
@@ -259,10 +295,14 @@ static int gluebi_erase(struct mtd_info *mtd, 
struct erase_info *instr)
  	if (err)
  		goto out_err;

+	if (not_get)
+		__put_mtd_device(mtd);
  	return 0;

  out_err:
  	instr->fail_addr = (long long)lnum * mtd->erasesize;
+	if (not_get)
+		__put_mtd_device(mtd);
  	return err;
  }

-- 
2.31.1


