Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F23778025
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjHJSVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjHJSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:21:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E52123;
        Thu, 10 Aug 2023 11:21:47 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AI93Eh026442;
        Thu, 10 Aug 2023 18:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ukrqfV2YUvYfMWjhzsjdbKVW5b+Mds/+5rEtr/ovKWY=;
 b=bhb/Je+mXjgiLM7esjYip9LGHiYRTLsn8dpM2C/Tk4XL0I6P5INhr/dIqi9qhS9/jULe
 Oo8WXng8vYQZv8dtA4Sd9pJu+p7vLDEzcPnz4xQaBoid9VF9n48197DIU5b2DG+kIUMh
 VpRcyoaUeFu5foCgbSnErBjfD41rMwYgIMkAqvZb4YNetdLKvETJsjFtynb5hfgNgK/x
 Aq9Enk69dFP0LWNIquFAF3kaKG99LywiiSTDmNR5dhcP4t23MyY/Up+mmLpEaXYowkjq
 0yYU1uAAUnMxXCBcZKGV9GJzKSaymbOcwoaokXB1QiEaNG8i91DAftTt9/DGTKeq2Bci mA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd4wer0td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:20:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AIKkal025174
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 18:20:46 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 11:20:44 -0700
Message-ID: <23575f97-332b-0392-fc20-0a52775d03b9@quicinc.com>
Date:   Thu, 10 Aug 2023 12:20:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 5/6] clk: qcom: mmcc-msm8998: Fix the SMMU GDSC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <20230531-topic-8998_mmssclk-v3-0-ba1b1fd9ee75@linaro.org>
 <20230531-topic-8998_mmssclk-v3-5-ba1b1fd9ee75@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230531-topic-8998_mmssclk-v3-5-ba1b1fd9ee75@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mMM1gaGwCQBYLNlAqVSkrpOzJ6YJuJ3q
X-Proofpoint-GUID: mMM1gaGwCQBYLNlAqVSkrpOzJ6YJuJ3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_14,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 mlxlogscore=867 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100158
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/2023 1:20 PM, Konrad Dybcio wrote:
> The SMMU GDSC doesn't have to be ALWAYS-ON and shouldn't feature the
> HW_CTRL flag (it's separate from hw_ctrl_addr).  In addition to that,
> it should feature a cxc entry for bimc_smmu_axi_clk and be marked as
> votable.

I appear to have confused HW_CTRL with hw_ctrl_addr.  Thanks for fixing 
that.

I recall I made it always-on for display handoff.  The bootloader on the 
laptops will enable the display, which means the MDP is active and using 
the SMMU.  The SMMU is powered by the GDSC as you know.  The MDP is 
going to be polling a framebuffer in DDR, which EFI services (efifb) is 
going to be updating.  All of this is active during linux boot, which is 
how the kernel bootlog gets printed on screen.

If I remember right, the GDSC will be registered.  When it is done 
probing, there will be no consumers.  So the Linux framework will step 
in and turn it off before the consumers come up.  This kills power to 
the SMMU.  If the SMMU doesn't come back on before the MDP polls DDR 
again, you get a bus hang and a crash.

I assumed that any msm8998 device would be using the MDP/GPU and thus 
the SMMU would pretty much always be powered on.

I expected this patch to break the laptop.  It does not in my testing. 
However, I see that I disabled the MMCC node in DT with a todo about the 
display.  So the GDSC is never registered, and then never gets turned 
off.  I believe that todo is pending some updates I need to make to the 
TI DSI/eDP bridge because the I2C port on the bridge is not wired up.  I 
should really dust that off and complete it.

Regardless, even with the todo addressed, I think removing always-on 
will still break the laptops unless the bootloader handoff of display 
was solved and I missed it.

I get that for your usecase, a phone where the bootloader does not init 
the display, always-on has the potential to burn extra power.  I'm not 
sure how to make both of us happy through.

Do you have any suggestions?

> 
> Fix all of these issues.
> 
> Fixes: d14b15b5931c ("clk: qcom: Add MSM8998 Multimedia Clock Controller (MMCC) driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/mmcc-msm8998.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
> index d0a5440e2291..4fdc41e7d2a8 100644
> --- a/drivers/clk/qcom/mmcc-msm8998.c
> +++ b/drivers/clk/qcom/mmcc-msm8998.c
> @@ -2627,11 +2627,13 @@ static struct gdsc camss_cpp_gdsc = {
>   static struct gdsc bimc_smmu_gdsc = {
>   	.gdscr = 0xe020,
>   	.gds_hw_ctrl = 0xe024,
> +	.cxcs = (unsigned int []){ 0xe008 },
> +	.cxc_count = 1,
>   	.pd = {
>   		.name = "bimc_smmu",
>   	},
>   	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = HW_CTRL | ALWAYS_ON,
> +	.flags = VOTABLE,
>   };
>   
>   static struct clk_regmap *mmcc_msm8998_clocks[] = {
> 

