Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2102480EB2E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346383AbjLLMC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLLMCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:02:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318959F;
        Tue, 12 Dec 2023 04:03:00 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBhcpo030173;
        Tue, 12 Dec 2023 12:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=5dgNDef/VauTo8ML4Wks5f0L5liCw7szp7E/BOWeZV4=; b=Wr
        zvZHRn6vwAsmQ1cQEzxvKo3qVhnozeaQgs21V1RlKe9/3rIhjKGIrkVjAPLy7nG+
        CIknWdcPD5GslMdSB2OTKUSJ/KYYqQiy6AsG1rB7gJzHAh5eWAigcL4cra3fZdUb
        GJpUmSYEVJJ/gJc8EhC00JNe4AigISdoGBb3dCvdstcvvZ9fZqKsAIoITw3djjEP
        8k9v9wZngqXEeftm/hp9G8/8sy00Hw/2SDORZ9fjutF1UWv6PzuT7uqP/dJxHtqW
        KJ9lOsbuf9M6KOrlnuYno2J3E2LwkYjJedeUN+GT1uvG1s9/Ibjq6CydKjjo07At
        pcnpghV++mSmwvJxG9Vg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxa901neu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 12:02:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCC2jWt031088
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 12:02:45 GMT
Received: from [10.216.62.2] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Dec
 2023 04:02:33 -0800
Message-ID: <d500225b-ef2c-4c2f-908a-7438f5e40e30@quicinc.com>
Date:   Tue, 12 Dec 2023 17:32:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/3] net: stmmac: Add driver support for
 DWMAC5 safety IRQ support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Rob Herring <robh@kernel.org>, <kernel@quicinc.com>
References: <20231211080153.3005122-1-quic_jsuraj@quicinc.com>
 <20231211080153.3005122-4-quic_jsuraj@quicinc.com>
 <fa362vwmgtfs2iofwteuk3mwh22eu7nds4dh2rw3cax5edh4kp@gf3bhl526yla>
From:   Suraj Jaiswal <quic_jsuraj@quicinc.com>
In-Reply-To: <fa362vwmgtfs2iofwteuk3mwh22eu7nds4dh2rw3cax5edh4kp@gf3bhl526yla>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JwpVLA1GkQ6kbSlB7wT-KFcJtt2jaDW2
X-Proofpoint-ORIG-GUID: JwpVLA1GkQ6kbSlB7wT-KFcJtt2jaDW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120096
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Serge,
Taken care of below comment in the next version . Please review 

Thanks
Suraj

On 12/11/2023 7:25 PM, Serge Semin wrote:
> Hi Suraj
> 
>> [PATCH net-next v5 3/3] net: stmmac: Add driver support for DWMAC5 safety IRQ support
> On Mon, Dec 11, 2023 at 01:31:53PM +0530, Suraj Jaiswal wrote:
>> Add IRQ support to listen HW safety IRQ like ECC(error
>> correction code), DPP(data path parity), FSM(finite state
>> machine) fault and print the fault information in the kernel
>> log.
> 
> I guess the subject and the patch log are a bit misleading. Safety
> IRQs have been supported by the kernel since commit 8bf993a5877e
> ("net: stmmac: Add support for DWMAC5 and implement Safety Features").
> Meanwhile based on the patch body what you are doing here is adding
> the common safety IRQ line support. Please fix it.
> 
>>
>> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
>>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
>>  .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
>>  4 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
>> index 721c1f8e892f..cb9645fe16d8 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
>> @@ -347,6 +347,7 @@ enum request_irq_err {
> 
>>  	REQ_IRQ_ERR_SFTY_UE,
>>  	REQ_IRQ_ERR_SFTY_CE,
>>  	REQ_IRQ_ERR_LPI,
>> +	REQ_IRQ_ERR_SAFETY,
> 
> 1. For the sake of unification please use the REQ_IRQ_ERR_SFTY id
> instead, since the individual UE and CE IRQs have already been defined
> that way.
> 
> 2. For readability please group up the IRQs of the same type. Like
> this:
> +	REQ_IRQ_ERR_SFTY,
>   	REQ_IRQ_ERR_SFTY_UE,
>  	REQ_IRQ_ERR_SFTY_CE,
> * Note it would be also better to have the common IRQ ID being defined
> * above the individual ones.
> 
>>  	REQ_IRQ_ERR_WOL,
>>  	REQ_IRQ_ERR_MAC,
>>  	REQ_IRQ_ERR_NO,
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> index 9f89acf31050..aa2eda6fb927 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> @@ -33,6 +33,7 @@ struct stmmac_resources {
>>  	int irq;
>>  	int sfty_ce_irq;
>>  	int sfty_ue_irq;
> 
>> +	int safety_common_irq;
> 
> ditto:
> 
> +	int sfty_irq;
>  	int sfty_ce_irq;
>  	int sfty_ue_irq;
> 
> Note there is no need in the "common" word in the name, just sfty_irq
> is enough to infer that it's a common IRQ number.
> 
>>  	int rx_irq[MTL_MAX_RX_QUEUES];
>>  	int tx_irq[MTL_MAX_TX_QUEUES];
>>  };
>> @@ -299,6 +300,7 @@ struct stmmac_priv {
>>  	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
> 
>>  	int sfty_ce_irq;
>>  	int sfty_ue_irq;
>> +	int safety_common_irq;
> 
> ditto:
> +	int sfty_irq;
>  	int sfty_ce_irq;
>  	int sfty_ue_irq;
> 
>>  	int rx_irq[MTL_MAX_RX_QUEUES];
>>  	int tx_irq[MTL_MAX_TX_QUEUES];
>>  	/*irq name */
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 47de466e432c..e4a0d9ec8b3f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -3592,6 +3592,10 @@ static void stmmac_free_irq(struct net_device *dev,
>>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
>>  			free_irq(priv->wol_irq, dev);
>>  		fallthrough;
> 
>> +	case REQ_IRQ_ERR_SAFETY:
>> +		if (priv->safety_common_irq > 0 && priv->safety_common_irq != dev->irq)
>> +			free_irq(priv->safety_common_irq, dev);
> 
> s/SAFETY/SFTY
> s/common_//
> s/safety/sfty
> 
>> +		fallthrough;
>>  	case REQ_IRQ_ERR_WOL:
>>  		free_irq(dev->irq, dev);
>>  		fallthrough;
>> @@ -3798,6 +3802,18 @@ static int stmmac_request_irq_single(struct net_device *dev)
>>  		}
>>  	}
>>  
> 
>> +	if (priv->safety_common_irq > 0 && priv->safety_common_irq != dev->irq) {
> 
> s/common_//
> s/safety/sfty
> 
>> +		ret = request_irq(priv->safety_common_irq, stmmac_safety_interrupt,
> 
> s/safety_common_irq/sfty_irq
> 
>> +				  0, "safety", dev);
> 
> The rest of the IRQ names are determined as:
> 
> 		int_name = priv->int_name_sfty;
> 		sprintf(int_name, "%s:%s", dev->name, "safety");
> 		ret = request_irq(priv->sfty_irq,
> 				  stmmac_safety_interrupt,
> 				  0, int_name, dev);
> 
> For maintainability it would be better to keep the code unified and
> have the same pattern implemented here too.
> 
>> +		if (unlikely(ret < 0)) {
>> +			netdev_err(priv->dev,
>> +				   "%s: alloc safety failed %d (error: %d)\n",
> 
>> +				   __func__, priv->safety_common_irq, ret);
>> +			irq_err = REQ_IRQ_ERR_SAFETY;
> 
> s/common_//
> s/safety/sfty
> s/SAFETY/SFTY
> 
>> +			goto irq_error;
>> +		}
>> +	}
>> +
>>  	return 0;
>>  
>>  irq_error:
>> @@ -7464,6 +7480,8 @@ int stmmac_dvr_probe(struct device *device,
>>  	priv->lpi_irq = res->lpi_irq;
>>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>>  	priv->sfty_ue_irq = res->sfty_ue_irq;
> 
>> +	priv->safety_common_irq = res->safety_common_irq;
>> +
> 
> s/common_//
> s/safety/sfty
> 
>>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
>>  		priv->rx_irq[i] = res->rx_irq[i];
>>  	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> index 1ffde555da47..41a4a253d75b 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
>> @@ -726,6 +726,15 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>>  	}
>>  
> 
>> +	stmmac_res->safety_common_irq =
>> +		platform_get_irq_byname_optional(pdev, "safety");
> 
> Please define the IRQ resource name as "sfty" to be looking as the
> individual safety IRQ names.
> 
>> +
>> +	if (stmmac_res->safety_common_irq < 0) {
>> +		if (stmmac_res->safety_common_irq == -EPROBE_DEFER)
> 
> s/common_//
> s/safety/sfty
> 
> -Serge(y)
> 
>> +			return -EPROBE_DEFER;
>> +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
>> +	}
>> +
>>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>>  
>>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
>> -- 
>> 2.25.1
>>
>>
