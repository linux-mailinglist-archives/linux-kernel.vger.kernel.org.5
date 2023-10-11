Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36BC7C4F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjJKJrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjJKJrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:47:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B994;
        Wed, 11 Oct 2023 02:47:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39B9ktkt118342;
        Wed, 11 Oct 2023 04:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697017615;
        bh=pWbbzUvKEecylMAuLdNPqtTHRx8uDl4JWSOnleipvD0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=lOPMLHp1U1v8QVRsQ35ngeD1/CpJLOquJHLpuuIWeA8v7MFuOEEfx3sSDmc+npSaz
         li65NJ61uTXHUVCyQV9YnUl6RZQ+VdIag3oU0X/PV6vXLBWKeogsaAZKrLVJwPu6F5
         xu2/2cS1DIqzM+dfBLHTnAmeYSEK3pEmszaq3CHQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39B9ktHk022845
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Oct 2023 04:46:55 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Oct 2023 04:46:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Oct 2023 04:46:55 -0500
Received: from [172.24.227.83] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39B9kppQ031933;
        Wed, 11 Oct 2023 04:46:52 -0500
Message-ID: <3bc32261-fdcf-2cea-cae2-f4dddc147d96@ti.com>
Date:   Wed, 11 Oct 2023 15:16:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix tx_total_bytes count
Content-Language: en-US
To:     MD Danish Anwar <danishanwar@ti.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20231011063700.1824093-1-danishanwar@ti.com>
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20231011063700.1824093-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 12:07 PM, MD Danish Anwar wrote:
> ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
> to this the tx_total_bytes of one interface doesn't match the
> rx_total_bytes of other interface when two ICSSG interfaces are

The errata is on the ICSSG Tx side regardless of which interface it is
connected to. Please rephrase this part of the message to something like,
"rx_total_bytes of the link partner".

> connected with each other. There is no public errata available yet.
> 
> As a workaround to fix this, decrease tx_total_bytes by 8 bytes for every
> tx frame.
> 
> Fixes: c1e10d5dc7a1 ("net: ti: icssg-prueth: Add ICSSG Stats")
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_stats.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> index bb0b33927e3b..dc12edcbac02 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
> @@ -18,6 +18,7 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>  	struct prueth *prueth = emac->prueth;
>  	int slice = prueth_emac_slice(emac);
>  	u32 base = stats_base[slice];
> +	u32 tx_pkt_cnt = 0;
>  	u32 val;
>  	int i;
>  
> @@ -29,7 +30,12 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
>  			     base + icssg_all_stats[i].offset,
>  			     val);
>  
> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_good_frames", ETH_GSTRING_LEN))
> +			tx_pkt_cnt = val;
> +
>  		emac->stats[i] += val;
> +		if (!strncmp(icssg_ethtool_stats[i].name, "tx_total_bytes", ETH_GSTRING_LEN))
> +			emac->stats[i] -= tx_pkt_cnt * 8;
>  	}
>  }
>  

-- 
Regards,
Ravi
