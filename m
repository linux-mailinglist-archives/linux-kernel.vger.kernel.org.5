Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB717D0B27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376552AbjJTJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376523AbjJTJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:10:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87AD51
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:10:04 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SBdvs5h7zzYskL;
        Fri, 20 Oct 2023 17:05:13 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 20 Oct 2023 17:09:59 +0800
Subject: Re: [PATCH v3 3/5] ubi: Add six fault injection type for testing
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
References: <20231020064803.643399-1-wangzhaolong1@huawei.com>
 <20231020064803.643399-4-wangzhaolong1@huawei.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <cec45406-85b6-d964-fede-8d16a457308d@huawei.com>
Date:   Fri, 20 Oct 2023 17:09:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20231020064803.643399-4-wangzhaolong1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/10/20 14:48, ZhaoLong Wang Ð´µÀ:
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
>   drivers/mtd/ubi/debug.c |  30 +++++++
>   drivers/mtd/ubi/debug.h | 170 ++++++++++++++++++++++++++++++++++++++--
>   drivers/mtd/ubi/io.c    |  76 +++++++++++++++++-
>   drivers/mtd/ubi/ubi.h   |  30 ++++---
>   4 files changed, 286 insertions(+), 20 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

One small nit below.

[...]

> diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
> index ffa7bbf27bc2..803e2b7f1d17 100644
> --- a/drivers/mtd/ubi/io.c
> +++ b/drivers/mtd/ubi/io.c
> @@ -195,7 +195,19 @@ int ubi_io_read(const struct ubi_device *ubi, void *buf, int pnum, int offset,
>   
>   		if (ubi_dbg_is_bitflip(ubi)) {
>   			dbg_gen("bit-flip (emulated)");
> -			err = UBI_IO_BITFLIPS;
> +			return  UBI_IO_BITFLIPS;

There are 2 spaces between 'return' and 'UBI_IO_BITFLIPS'.

> +		}
> +
> +		if (ubi_dbg_is_read_failure(ubi, MASK_READ_FAILURE)) {
> +			ubi_warn(ubi, "cannot read %d bytes from PEB %d:%d (emulated)",
> +				 len, pnum, offset);
> +			return -EIO;
> +		}
> +
> +		if (ubi_dbg_is_eccerr(ubi)) {
> +			ubi_warn(ubi, "ECC error (emulated) while reading %d bytes from PEB %d:%d, read %zd bytes",
> +				 len, pnum, offset, read);
> +			return -EBADMSG;
>   		}
>   	}
>   
