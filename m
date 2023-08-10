Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3136B7779D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 15:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjHJNqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 09:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjHJNp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 09:45:58 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604B2132;
        Thu, 10 Aug 2023 06:45:57 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AClM6D009211;
        Thu, 10 Aug 2023 15:45:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=qd8558qevje9CkFMuo6OGsMVLyIAZeqVXdpJae7LwQA=; b=Gu
        3DsyFZQM4ymh8/EvcOJDwKyajC82pfjwqSpEXAJKYZVsLYCTfravJgbpoo/yBnyT
        eyDEJ1WqdavyVJ89rBUHzeAxlOgEmlBmA/beSMclOPEmu7hTfmyFxTMjUKIN1FAX
        vBgF8v0MeyMgAPcQNos3ckvvNlIx1V91u0yNsSD8IjiVBvb/xqKcEAjF9/X94uuC
        BA76ExfKpsJXtdiBUb/3qfQYoud9jJ9pk71VTFAGOLZQVUlJ0d5429JwWmlPZ2E4
        Sq9VGbkvCVuEqsr8zkXTvzSK4hUmscg7YZeFNne0GkFYLPdA5d2Ur9PaYzkyqdu7
        Qu6Sq2NqX+2jjweK9bcg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sd0730afe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 15:45:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A7CBA100053;
        Thu, 10 Aug 2023 15:45:36 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E18321BF73;
        Thu, 10 Aug 2023 15:45:36 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 10 Aug
 2023 15:45:35 +0200
Message-ID: <cebcf6a6-8a29-c67a-6dbf-5c561a8c0eb3@foss.st.com>
Date:   Thu, 10 Aug 2023 15:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v3 01/10] net: stmmac: correct RX COE parsing for
 xgmac
Content-Language: en-US
To:     Jisheng Zhang <jszhang@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Jose Abreu <joabreu@synopsys.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230809165007.1439-1-jszhang@kernel.org>
 <20230809165007.1439-2-jszhang@kernel.org>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230809165007.1439-2-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 18:49, Jisheng Zhang wrote:
> xgmac can support RX COE, but there's no two kinds of COE, I.E type 1
> and type 2 COE.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index e1f1c034d325..15ed3947361b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6271,7 +6271,7 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>   	seq_printf(seq, "\tAV features: %s\n", (priv->dma_cap.av) ? "Y" : "N");
>   	seq_printf(seq, "\tChecksum Offload in TX: %s\n",
>   		   (priv->dma_cap.tx_coe) ? "Y" : "N");
> -	if (priv->synopsys_id >= DWMAC_CORE_4_00) {
> +	if (priv->synopsys_id >= DWMAC_CORE_4_00 || priv->plat->has_xgmac) {
>   		seq_printf(seq, "\tIP Checksum Offload in RX: %s\n",
>   			   (priv->dma_cap.rx_coe) ? "Y" : "N");
>   	} else {
> @@ -7013,7 +7013,7 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
>   	if (priv->plat->rx_coe) {
>   		priv->hw->rx_csum = priv->plat->rx_coe;
>   		dev_info(priv->device, "RX Checksum Offload Engine supported\n");
> -		if (priv->synopsys_id < DWMAC_CORE_4_00)
> +		if (priv->synopsys_id < DWMAC_CORE_4_00 && !priv->plat->has_xgmac)
>   			dev_info(priv->device, "COE Type %d\n", priv->hw->rx_csum);
>   	}
>   	if (priv->plat->tx_coe)

Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

Regards
Alex

