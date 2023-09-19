Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA07A5F06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjISKGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjISKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:06:42 -0400
Received: from out-230.mta1.migadu.com (out-230.mta1.migadu.com [IPv6:2001:41d0:203:375::e6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290BE8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:06:36 -0700 (PDT)
Message-ID: <8d8f2aee-ce64-166d-b13d-9791e8d47036@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695117994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z13/olEq8GyW2EUlZpY3hnsJroKO32II25IDBVJXOTs=;
        b=ed9hcfrJ7JmwZfShPsWjCFY5zQAzN1IPjlyXGSNFlfp1CQGWD6e780HtKR64q1UBkPHSrE
        GM8q+2axy/e2IFaabfNVTkInuF8evswQ/LfkWwBoWmwPIbwP2n9Pf5cp6b91Tg2B1Zdoln
        V0GcDwmDpEh+2T9NIFLDq1XFRH3nxO4=
Date:   Tue, 19 Sep 2023 11:06:28 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] net: hinic: Fix warning-hinic_set_vlan_fliter() warn:
 variable dereferenced before check 'hwdev'
Content-Language: en-US
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230919022715.6424-1-cai.huoqing@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230919022715.6424-1-cai.huoqing@linux.dev>
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

On 19/09/2023 03:27, Cai Huoqing wrote:
> 'hwdev' is checked too late and hwdev will not be NULL, so remove the check
> 
> Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
> Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
> ---
> v1->v2: Remove 'hwdev' check directly
> v1 link: https://lore.kernel.org/lkml/20230918123401.6951-1-cai.huoqing@linux.dev/
> 
>   drivers/net/ethernet/huawei/hinic/hinic_port.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
> index 9406237c461e..f81a43d2cdfc 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
> @@ -456,9 +456,6 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
>   	u16 out_size = sizeof(vlan_filter);
>   	int err;
>   
> -	if (!hwdev)
> -		return -EINVAL;
> -
>   	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
>   	vlan_filter.enable = en;
>   

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
