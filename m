Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C557694BC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGaLYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjGaLYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:24:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E8DE5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:24:50 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RDwnD1WZBzLnqM;
        Mon, 31 Jul 2023 19:22:08 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 19:24:47 +0800
Subject: Re: [PATCH V2 2/5] ubi: Split io_failures into write_failure and
 erase_failure
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
 <20230718085119.3885747-3-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <bb696f09-a89c-1c16-0154-961c4dabfed9@huawei.com>
Date:   Mon, 31 Jul 2023 19:24:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230718085119.3885747-3-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/18 16:51, ZhaoLong Wang Ð´µÀ:
> The emulate_io_failures debugfs entry controls both write
> failure and erase failure. This patch split io_failures
> to write_failure and erase_failure.
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/debug.c | 13 +++++++++----
>   drivers/mtd/ubi/debug.h | 14 ++++++++------
>   2 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index 9ca584da32c6..7826bc8166e8 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -14,7 +14,8 @@
>   
>   #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
>   static DECLARE_FAULT_ATTR(fault_bitflips_attr);
> -static DECLARE_FAULT_ATTR(fault_io_failures_attr);
> +static DECLARE_FAULT_ATTR(fault_write_failure_attr);
> +static DECLARE_FAULT_ATTR(fault_erase_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_power_cut_attr);
>   
>   #define FAIL_ACTION(name, fault_attr)			\
> @@ -24,7 +25,8 @@ bool should_fail_##name(void)				\
>   }
>   
>   FAIL_ACTION(bitflips,		fault_bitflips_attr)
> -FAIL_ACTION(io_failures,	fault_io_failures_attr)
> +FAIL_ACTION(write_failure,	fault_write_failure_attr)
> +FAIL_ACTION(erase_failure,	fault_erase_failure_attr)
>   FAIL_ACTION(power_cut,		fault_power_cut_attr)
>   #endif
>   
> @@ -245,8 +247,11 @@ static void dfs_create_fault_entry(struct dentry *parent)
>   	fault_create_debugfs_attr("emulate_bitflips", dir,
>   				  &fault_bitflips_attr);
>   
> -	fault_create_debugfs_attr("emulate_io_failures", dir,
> -				  &fault_io_failures_attr);
> +	fault_create_debugfs_attr("emulate_write_failure", dir,
> +				  &fault_write_failure_attr);
> +
> +	fault_create_debugfs_attr("emulate_erase_failure", dir,
> +				  &fault_erase_failure_attr);
>   
>   	fault_create_debugfs_attr("emulate_power_cut", dir,
>   				  &fault_power_cut_attr);
> diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
> index fc4234c9a90a..6bc698b38e35 100644
> --- a/drivers/mtd/ubi/debug.h
> +++ b/drivers/mtd/ubi/debug.h
> @@ -92,10 +92,12 @@ static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
>   /* Emulate bit-flips */
>   #define MASK_BITFLIPS		(1 << 3)
>   /* Emulates -EIO during write/erase */
> -#define MASK_IO_FAILURE		(1 << 4)
> +#define MASK_WRITE_FAILURE	(1 << 4)
> +#define MASK_ERASE_FAILURE	(1 << 5)
>   
>   extern bool should_fail_bitflips(void);
> -extern bool should_fail_io_failures(void);
> +extern bool should_fail_write_failure(void);
> +extern bool should_fail_erase_failure(void);
>   extern bool should_fail_power_cut(void);
>   
>   static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
> @@ -107,15 +109,15 @@ static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
>   
>   static inline bool ubi_dbg_fail_write(const struct ubi_device *ubi)
>   {
> -	if (ubi->dbg.emulate_failures & MASK_IO_FAILURE)
> -		return should_fail_io_failures();
> +	if (ubi->dbg.emulate_failures & MASK_WRITE_FAILURE)
> +		return should_fail_write_failure();
>   	return false;
>   }
>   
>   static inline bool ubi_dbg_fail_erase(const struct ubi_device *ubi)
>   {
> -	if (ubi->dbg.emulate_failures & MASK_IO_FAILURE)
> -		return should_fail_io_failures();
> +	if (ubi->dbg.emulate_failures & MASK_ERASE_FAILURE)
> +		return should_fail_erase_failure();
>   	return false;
>   }
>   
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

