Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7167CF93E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345647AbjJSMpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbjJSMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:45:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046AFA4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:45:07 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SB6mq4Xs6z15NVP;
        Thu, 19 Oct 2023 20:42:19 +0800 (CST)
Received: from [10.67.120.218] (10.67.120.218) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 19 Oct 2023 20:45:03 +0800
Subject: Re: [PATCH 1/3] coresight: ultrasoc-smb: fix sleep while close
 preempt in enable_smb
To:     Yicong Yang <yangyicong@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
 <20231012094706.21565-2-hejunhao3@huawei.com>
 <f09e4d9f-c02c-7a2a-7b38-a23a72a03242@huawei.com>
CC:     <suzuki.poulose@arm.com>, <james.clark@arm.com>,
        <yangyicong@hisilicon.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>
From:   hejunhao <hejunhao3@huawei.com>
Message-ID: <ea4724da-bb96-b1d2-a00a-a972bf085c5c@huawei.com>
Date:   Thu, 19 Oct 2023 20:45:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <f09e4d9f-c02c-7a2a-7b38-a23a72a03242@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.218]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,


On 2023/10/19 11:05, Yicong Yang wrote:
> On 2023/10/12 17:47, Junhao He wrote:
>
>
> Use spinlock replace mutex to control driver data access to one at a
> time. But the function copy_to_user() may sleep so spinlock do not to
> lock it.
>
> Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> ---
>   drivers/hwtracing/coresight/ultrasoc-smb.c | 36 ++++++++++------------
>   drivers/hwtracing/coresight/ultrasoc-smb.h |  6 ++--
>   2 files changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
> index e9a32a97fbee..b08a619d1116 100644
> --- a/drivers/hwtracing/coresight/ultrasoc-smb.c
> +++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
> @@ -99,7 +99,7 @@ static int smb_open(struct inode *inode, struct file *file)
>   					struct smb_drv_data, miscdev);
>   	int ret = 0;
>   
> -	mutex_lock(&drvdata->mutex);
> +	spin_lock(&drvdata->spinlock);
>   
>   	if (drvdata->reading) {
>   		ret = -EBUSY;
> @@ -115,7 +115,7 @@ static int smb_open(struct inode *inode, struct file *file)
>   
>   	drvdata->reading = true;
>   out:
> -	mutex_unlock(&drvdata->mutex);
> +	spin_unlock(&drvdata->spinlock);
>   
>   	return ret;
>   }
> @@ -132,10 +132,8 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>   	if (!len)
>   		return 0;
>   
> -	mutex_lock(&drvdata->mutex);
> -
>   	if (!sdb->data_size)
> -		goto out;
> +		return 0;
>   
>   	to_copy = min(sdb->data_size, len);
>   
> @@ -145,20 +143,18 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
>   
>   	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
>   		dev_dbg(dev, "Failed to copy data to user\n");
> -		to_copy = -EFAULT;
> -		goto out;
> +		return -EFAULT;
>   	}
>   
> +	spin_lock(&drvdata->spinlock);
>   	*ppos += to_copy;
> -
>   	smb_update_read_ptr(drvdata, to_copy);
>   
> -	dev_dbg(dev, "%zu bytes copied\n", to_copy);
> -out:
>   	if (!sdb->data_size)
>   		smb_reset_buffer(drvdata);
> -	mutex_unlock(&drvdata->mutex);
> +	spin_unlock(&drvdata->spinlock);
> Do we still need the lock here? If we get here, we should have the exclusive
> access to the file, which is protected in open(). Or any other cases?

This is something I've also considered. If someone opens an SMB device
and reads it using multithreading, The SMB device will got out of sync.
I've seen other coresight sink drivers such as etb do not use locks in
the read function.
Maybe it's not necessary here, the buffer synchronization
is guaranteed by the user.

Best regards,
Junhao.


