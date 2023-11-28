Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556F47FB002
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbjK1CTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbjK1CTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:19:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287F71B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:19:14 -0800 (PST)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SfQxp1QDPzMnTd;
        Tue, 28 Nov 2023 10:14:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 Nov 2023 10:19:11 +0800
Subject: Re: [PATCH v2] ubi: don't decrease ubi->ref_count on detach error
To:     Daniel Golle <daniel@makrotopia.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <771902199.32600.1701116758852.JavaMail.zimbra@nod.at>
 <8d48839a1bf928886e86de8fdc09dc0676fc187f.1701132215.git.daniel@makrotopia.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <f55da3cf-47ca-e942-0713-1133279eab46@huawei.com>
Date:   Tue, 28 Nov 2023 10:18:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8d48839a1bf928886e86de8fdc09dc0676fc187f.1701132215.git.daniel@makrotopia.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2023/11/28 8:45, Daniel Golle Ð´µÀ:
> If attempting to detach a UBI device while it is still busy, detaching
> is refused. However, the reference counter is still being decreased
> despite the error. Rework detach function to only decrease the reference
> counter once all conditions for detachment are met.
>
> Fixes: cdfa788acd13 ("UBI: prepare attach and detach functions")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: also catch negative ref_count and add ubi_assert as suggested
>
>   drivers/mtd/ubi/build.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

>
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 7d4ff1193db6f..2316f6014c7f5 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1099,16 +1099,17 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
>   
>   	spin_lock(&ubi_devices_lock);
>   	put_device(&ubi->dev);
> -	ubi->ref_count -= 1;
> -	if (ubi->ref_count) {
> +	if (ubi->ref_count != 1) {
>   		if (!anyway) {
>   			spin_unlock(&ubi_devices_lock);
>   			return -EBUSY;
>   		}
>   		/* This may only happen if there is a bug */
>   		ubi_err(ubi, "%s reference count %d, destroy anyway",
> -			ubi->ubi_name, ubi->ref_count);
> +			ubi->ubi_name, ubi->ref_count - 1);
>   	}
> +	ubi->ref_count -= 1;
> +	ubi_assert(ubi->ref_count == 0);
>   	ubi_devices[ubi_num] = NULL;
>   	spin_unlock(&ubi_devices_lock);
>   


