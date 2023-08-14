Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0701877AF12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 02:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjHNA4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 20:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHNA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 20:56:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE1E71
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 17:56:10 -0700 (PDT)
Received: from kwepemi500011.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPGB51ZbRzTmRs;
        Mon, 14 Aug 2023 08:54:05 +0800 (CST)
Received: from [10.67.103.39] (10.67.103.39) by kwepemi500011.china.huawei.com
 (7.221.188.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 08:56:06 +0800
Message-ID: <64D97BA6.3030609@hisilicon.com>
Date:   Mon, 14 Aug 2023 08:56:06 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Arnd Bergmann <arnd@kernel.org>, Huisong Li <lihuisong@huawei.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: kunpeng_hccs: fix size_t format string
References: <20230812172116.3477379-1-arnd@kernel.org>
In-Reply-To: <20230812172116.3477379-1-arnd@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.39]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500011.china.huawei.com (7.221.188.124)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2023/8/13 1:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Printing a size_t using the %lu format string causes a warning on
> architectures that define the type as 'unsigned int':
> 
> In file included from include/linux/device.h:15,
>                  from include/linux/acpi.h:14,
>                  from drivers/soc/hisilicon/kunpeng_hccs.c:25:
> drivers/soc/hisilicon/kunpeng_hccs.c: In function 'hccs_get_bd_info':
> drivers/soc/hisilicon/kunpeng_hccs.c:441:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> 
> Use the correct %zu format instead.
> 
> Fixes: 886bdf9c883bc ("soc: hisilicon: Support HCCS driver on Kunpeng SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I've already applied this one on top of the soc/drivers branch after I
> merged the branch with the new driver and noticed the regression.
> 
>  drivers/soc/hisilicon/kunpeng_hccs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
> index 6864d203c6782..0d6f6bacd3f62 100644
> --- a/drivers/soc/hisilicon/kunpeng_hccs.c
> +++ b/drivers/soc/hisilicon/kunpeng_hccs.c
> @@ -438,7 +438,7 @@ static int hccs_get_bd_info(struct hccs_dev *hdev, u8 opcode,
>  	head = &rsp->rsp_head;
>  	if (head->data_len > buf_len) {
>  		dev_err(hdev->dev,
> -			"buffer overflow (buf_len = %lu, data_len = %u)!\n",
> +			"buffer overflow (buf_len = %zu, data_len = %u)!\n",
>  			buf_len, head->data_len);
>  		return -ENOMEM;
>  	}
> 

Thanks!

Best Regards,
Wei
