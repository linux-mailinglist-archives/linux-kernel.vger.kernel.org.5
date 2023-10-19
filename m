Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3E7CFB35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbjJSNf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345619AbjJSNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:35:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC811D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:35:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB7vl5PP2z6H7w9;
        Thu, 19 Oct 2023 21:33:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 14:35:50 +0100
Date:   Thu, 19 Oct 2023 14:35:48 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Junhao He <hejunhao3@huawei.com>, <linuxarm@huawei.com>
CC:     <suzuki.poulose@arm.com>, <james.clark@arm.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <yangyicong@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 2/3] coresight: ultrasoc-smb: simplify the code for
 check to_copy valid
Message-ID: <20231019143530.00004c75@huawei.com>
In-Reply-To: <20231012094706.21565-3-hejunhao3@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
        <20231012094706.21565-3-hejunhao3@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 17:47:05 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> We only need to check once when before using the to_copy variable
> to simplify the code.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>

I'm not convinced this one is an improvement. Sometimes it's easier to just
see the individual conditions checked even if we could combine them.
It's easy to understand we don't copy data if:
a) We ask for 0 data.
b) There is 0 data

Less easy to establish that with the extra wrap around code in there
(even though that has no impact on to_copy if it is 0)

Jonathan


> ---
>  drivers/hwtracing/coresight/ultrasoc-smb.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index b08a619d1116..e78edc3480ce 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -127,20 +127,15 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>  					struct smb_drv_data, miscdev);
>  	struct smb_data_buffer *sdb = &drvdata->sdb;
>  	struct device *dev = &drvdata->csdev->dev;
> -	ssize_t to_copy = 0;
> -
> -	if (!len)
> -		return 0;
> -
> -	if (!sdb->data_size)
> -		return 0;
> -
> -	to_copy = min(sdb->data_size, len);
> +	ssize_t to_copy = min(sdb->data_size, len);
>  
>  	/* Copy parts of trace data when read pointer wrap around SMB buffer */
>  	if (sdb->buf_rdptr + to_copy > sdb->buf_size)
>  		to_copy = sdb->buf_size - sdb->buf_rdptr;
>  
> +	if (!to_copy)
> +		return 0;
> +
>  	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
>  		dev_dbg(dev, "Failed to copy data to user\n");
>  		return -EFAULT;

