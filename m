Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3876961E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjGaMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjGaMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:22:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FF4171B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:21:43 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RDy4H4s8KzrS1d;
        Mon, 31 Jul 2023 20:20:15 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 20:21:15 +0800
Subject: Re: [PATCH V2 3/5] ubi: Add six fault injection type for testing
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
 <20230718085119.3885747-4-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <187349d2-89b4-6b7d-3c68-e21dd9aeb168@huawei.com>
Date:   Mon, 31 Jul 2023 20:21:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230718085119.3885747-4-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/7/18 16:51, ZhaoLong Wang Ð´µÀ:
> This commit adds six fault injection type for testing to cover the
> abnormal path of the UBI driver.
> 
> Inject the following faults when the UBI reads the LEB:
>   +----------------------------+-----------------------------------+
>   |    Interface name          |       emulate behavior            |
>   +----------------------------+-----------------------------------+
>   |  emulate_eccerr            | ECC error                         |
>   +----------------------------+-----------------------------------+
>   |  emulate_read_failure      | read failure                      |
>   |----------------------------+-----------------------------------+
>   |  emulate_io_ff             | read content as all FF            |
>   |----------------------------+-----------------------------------+
>   |  emulate_io_ff_bitflips    | content FF with MTD err reported  |
>   +----------------------------+-----------------------------------+
>   |  emulate_bad_hdr           | bad leb header                    |
>   |----------------------------+-----------------------------------+
>   |  emulate_bad_hdr_ebadmsg   | bad header with ECC err           |
>   +----------------------------+-----------------------------------+
> 
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>   drivers/mtd/ubi/debug.c |  30 +++++++++
>   drivers/mtd/ubi/debug.h | 132 ++++++++++++++++++++++++++++++++++++++--
>   drivers/mtd/ubi/io.c    |  75 ++++++++++++++++++++++-
>   drivers/mtd/ubi/ubi.h   |  31 ++++++----
>   4 files changed, 248 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index 7826bc8166e8..016a861c5029 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -13,10 +13,16 @@
>   #include <linux/fault-inject.h>
>   
>   #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +static DECLARE_FAULT_ATTR(fault_eccerr_attr);
>   static DECLARE_FAULT_ATTR(fault_bitflips_attr);
> +static DECLARE_FAULT_ATTR(fault_read_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_write_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_erase_failure_attr);
>   static DECLARE_FAULT_ATTR(fault_power_cut_attr);
> +static DECLARE_FAULT_ATTR(fault_io_ff_attr);
> +static DECLARE_FAULT_ATTR(fault_io_ff_bitflips_attr);
> +static DECLARE_FAULT_ATTR(fault_bad_hdr_attr);
> +static DECLARE_FAULT_ATTR(fault_bad_hdr_ebadmsg_attr);
>   
>   #define FAIL_ACTION(name, fault_attr)			\
>   bool should_fail_##name(void)				\
> @@ -24,10 +30,16 @@ bool should_fail_##name(void)				\
>   	return should_fail(&fault_attr, 1);		\
>   }
>   
> +FAIL_ACTION(eccerr,		fault_eccerr_attr)
>   FAIL_ACTION(bitflips,		fault_bitflips_attr)
> +FAIL_ACTION(read_failure,	fault_read_failure_attr)
>   FAIL_ACTION(write_failure,	fault_write_failure_attr)
>   FAIL_ACTION(erase_failure,	fault_erase_failure_attr)
>   FAIL_ACTION(power_cut,		fault_power_cut_attr)
> +FAIL_ACTION(io_ff,		fault_io_ff_attr)
> +FAIL_ACTION(io_ff_bitflips,	fault_io_ff_bitflips_attr)
> +FAIL_ACTION(bad_hdr,		fault_bad_hdr_attr)
> +FAIL_ACTION(bad_hdr_ebadmsg,	fault_bad_hdr_ebadmsg_attr)
>   #endif
>   
>   /**
> @@ -244,6 +256,12 @@ static void dfs_create_fault_entry(struct dentry *parent)
>   		return;
>   	}
>   
> +	fault_create_debugfs_attr("emulate_eccerr", dir,
> +				  &fault_eccerr_attr);
> +
> +	fault_create_debugfs_attr("emulate_read_failure", dir,
> +				  &fault_read_failure_attr);
> +
>   	fault_create_debugfs_attr("emulate_bitflips", dir,
>   				  &fault_bitflips_attr);
>   
> @@ -255,6 +273,18 @@ static void dfs_create_fault_entry(struct dentry *parent)
>   
>   	fault_create_debugfs_attr("emulate_power_cut", dir,
>   				  &fault_power_cut_attr);
> +
> +	fault_create_debugfs_attr("emulate_io_ff", dir,
> +				  &fault_io_ff_attr);
> +
> +	fault_create_debugfs_attr("emulate_io_ff_bitflips", dir,
> +				  &fault_io_ff_bitflips_attr);
> +
> +	fault_create_debugfs_attr("emulate_bad_hdr", dir,
> +				  &fault_bad_hdr_attr);
> +
> +	fault_create_debugfs_attr("emulate_bad_hdr_ebadmsg", dir,
> +				  &fault_bad_hdr_ebadmsg_attr);
>   }
>   #endif
>   
> diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
> index 6bc698b38e35..29fbd971964a 100644
> --- a/drivers/mtd/ubi/debug.h
> +++ b/drivers/mtd/ubi/debug.h
> @@ -85,20 +85,47 @@ static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
>    * precisely control the type and process of fault injection.
>    */
>   /* Emulate a power cut when writing EC/VID header */
> -#define MASK_POWER_CUT_EC	(1 << 1)
> -#define MASK_POWER_CUT_VID	(1 << 2)
> +#define MASK_POWER_CUT_EC		(1 << 0)
> +#define MASK_POWER_CUT_VID		(1 << 1)
>   
>   #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
> +/* Emulate a power cut when writing data*/
> +#define MASK_POWER_CUT_DATA		(1 << 2)
>   /* Emulate bit-flips */
> -#define MASK_BITFLIPS		(1 << 3)
> -/* Emulates -EIO during write/erase */
> -#define MASK_WRITE_FAILURE	(1 << 4)
> -#define MASK_ERASE_FAILURE	(1 << 5)
> +#define MASK_BITFLIPS			(1 << 3)
> +/* Emulate ecc error */
> +#define MASK_ECCERR			(1 << 4)
> +/* Emulates -EIO during data read */
> +#define MASK_READ_FAILURE		(1 << 5)
> +#define MASK_READ_FAILURE_EC		(1 << 6)
> +#define MASK_READ_FAILURE_VID		(1 << 7)
> +/* Emulates -EIO during data write */
> +#define MASK_WRITE_FAILURE		(1 << 8)
> +/* Emulates -EIO during erase a PEB*/
> +#define MASK_ERASE_FAILURE		(1 << 9)
> +/* Return UBI_IO_FF when reading EC/VID header */
> +#define MASK_IO_FF_EC			(1 << 10)
> +#define MASK_IO_FF_VID			(1 << 11)
> +/* Return UBI_IO_FF_BITFLIPS when reading EC/VID header */
> +#define MASK_IO_FF_BITFLIPS_EC		(1 << 12)
> +#define MASK_IO_FF_BITFLIPS_VID		(1 << 13)
> +/* Return UBI_IO_BAD_HDR when reading EC/VID header */
> +#define MASK_BAD_HDR_EC			(1 << 14)
> +#define MASK_BAD_HDR_VID		(1 << 15)
> +/* Return UBI_IO_BAD_HDR_EBADMSG when reading EC/VID header */
> +#define MASK_BAD_HDR_EBADMSG_EC		(1 << 16)
> +#define MASK_BAD_HDR_EBADMSG_VID	(1 << 17)
>   

Now, you add many types of fault injections, it's better to make 
dfs_file_read display human-readable context for 'd->emulate_failures', 
for example:
value:17409
POWER_CUT_EC,MASK_IO_FF_EC,MASK_BAD_HDR_EC

value:0
None
