Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D507EEAFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjKQCHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:07:14 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D55FBC;
        Thu, 16 Nov 2023 18:07:10 -0800 (PST)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SWgCB2PGWzMn5P;
        Fri, 17 Nov 2023 10:02:30 +0800 (CST)
Received: from [10.67.120.153] (10.67.120.153) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 17 Nov 2023 10:07:07 +0800
Subject: Re: [PATCH] crypto: hisilicon - Add check for pci_find_ext_capability
To:     Chen Ni <nichen@iscas.ac.cn>, <wangzhou1@hisilicon.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <xuzaibo@huawei.com>, <tanshukun1@huawei.com>
References: <20231109021308.1859881-1-nichen@iscas.ac.cn>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Weili Qian <qianweili@huawei.com>
Message-ID: <6eeced40-7951-ca0d-1bcd-62e1d329ca96@huawei.com>
Date:   Fri, 17 Nov 2023 10:07:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20231109021308.1859881-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.120.153]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000009.china.huawei.com (7.193.23.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/9 10:13, Chen Ni wrote:
> Add check for pci_find_ext_capability() and return the error if it
> fails in order to transfer the error.
> 
> Fixes: 6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/crypto/hisilicon/qm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
> index 18599f3634c3..adbab1286d4a 100644
> --- a/drivers/crypto/hisilicon/qm.c
> +++ b/drivers/crypto/hisilicon/qm.c
> @@ -3967,6 +3967,9 @@ static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
>  	int i;
>  
>  	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
> +	if (!pos)
> +		return -ENODEV;
> +

Thanks for your patch. The function qm_set_vf_mse() is called only after SRIOV
is enabled, so function pci_find_ext_capability() does not return 0. This check
makes no sense.

Thanks,
Weili
>  	pci_read_config_word(pdev, pos + PCI_SRIOV_CTRL, &sriov_ctrl);
>  	if (set)
>  		sriov_ctrl |= PCI_SRIOV_CTRL_MSE;
> 
