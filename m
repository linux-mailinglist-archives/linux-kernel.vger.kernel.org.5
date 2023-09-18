Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980817A4A58
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbjIRM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242072AbjIRM72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:59:28 -0400
Received: from out-215.mta1.migadu.com (out-215.mta1.migadu.com [IPv6:2001:41d0:203:375::d7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FD718B
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:58:35 -0700 (PDT)
Message-ID: <dfcf35c3-8208-48fc-5492-97dd3b1c83fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695041913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8TGZ1zhD+1NdgEmlywX2v8A/+/SyL1sLef3z5XEdzE=;
        b=wSocDqPCurNOioYCGcGjGpygHbiwp+6t8V18LVCVBdq9X4Jdcy81br8I42eKvNZpJuVtdN
        JNCkQQoPa0qBFBQ0CguahQJcKmP/JIYmuT8929uXheZRxAT+/Dg5+p+PRg2jG9XNyw36Yy
        Fm3jDQJb2WAUZFTYE5q3Q9SXbgBpNCA=
Date:   Mon, 18 Sep 2023 13:58:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: hinic: Fix warning-hinic_set_vlan_fliter() warn:
 variable dereferenced before check 'hwdev'
Content-Language: en-US
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230918123401.6951-1-cai.huoqing@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230918123401.6951-1-cai.huoqing@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 13:34, Cai Huoqing wrote:
> Fix warning, 'hwdev' is checked too late

I cannot find any spot where hwdev will be NULL. Other functions in the 
driver assume that hwdev points to proper structure always. I believe 
the proper fix will be to remove redundant check.

> 
> Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
>   drivers/net/ethernet/huawei/hinic/hinic_port.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
> index 9406237c461e..bf920c709f82 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
> @@ -450,8 +450,8 @@ int hinic_set_rx_vlan_offload(struct hinic_dev *nic_dev, u8 en)
>   int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
>   {
>   	struct hinic_hwdev *hwdev = nic_dev->hwdev;
> -	struct hinic_hwif *hwif = hwdev->hwif;
> -	struct pci_dev *pdev = hwif->pdev;
> +	struct hinic_hwif *hwif;
> +	struct pci_dev *pdev;
>   	struct hinic_vlan_filter vlan_filter;
>   	u16 out_size = sizeof(vlan_filter);
>   	int err;
> @@ -459,6 +459,9 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
>   	if (!hwdev)
>   		return -EINVAL;
>   
> +	hwif = hwdev->hwif;
> +	pdev = hwif->pdev;
> +
>   	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
>   	vlan_filter.enable = en;
>   

