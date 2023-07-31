Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C91A7695E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjGaMQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGaMQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:16:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6631B197
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:16:21 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDxxn3ZpqzVjf2;
        Mon, 31 Jul 2023 20:14:37 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 20:16:18 +0800
Subject: Re: [PATCH V2 5/5] mtd: Add several functions to the fail_function
 list
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
 <20230718085119.3885747-6-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <475deeb5-5517-4784-a9e5-409ef16e42c4@huawei.com>
Date:   Mon, 31 Jul 2023 20:16:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230718085119.3885747-6-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/18 16:51, ZhaoLong Wang Ð´µÀ:
> add mtd_read(), mtd_write(), mtd_erase(), mtd_block_markbad() to
> fail_function list for testing purpose
> 

It could be better if you can provide some examples for how to use these 
error injection interfaces.

> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/mtdcore.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index e00b12aa5ec9..ecf1c5e68479 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -30,6 +30,7 @@
>   #include <linux/debugfs.h>
>   #include <linux/nvmem-provider.h>
>   #include <linux/root_dev.h>
> +#include <linux/error-injection.h>
>   
>   #include <linux/mtd/mtd.h>
>   #include <linux/mtd/partitions.h>
> @@ -1396,6 +1397,7 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_erase);
> +ALLOW_ERROR_INJECTION(mtd_erase, ERRNO);
>   
>   /*
>    * This stuff for eXecute-In-Place. phys is optional and may be set to NULL.
> @@ -1493,6 +1495,7 @@ int mtd_read(struct mtd_info *mtd, loff_t from, size_t len, size_t *retlen,
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_read);
> +ALLOW_ERROR_INJECTION(mtd_read, ERRNO);
>   
>   int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
>   	      const u_char *buf)
> @@ -1509,6 +1512,7 @@ int mtd_write(struct mtd_info *mtd, loff_t to, size_t len, size_t *retlen,
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(mtd_write);
> +ALLOW_ERROR_INJECTION(mtd_write, ERRNO);
>   
>   /*
>    * In blackbox flight recorder like scenarios we want to make successful writes
> @@ -2329,7 +2333,7 @@ int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(mtd_block_markbad);
> -
> +ALLOW_ERROR_INJECTION(mtd_block_markbad, ERRNO);
>   /*
>    * default_mtd_writev - the default writev method
>    * @mtd: mtd device description object pointer
> 

