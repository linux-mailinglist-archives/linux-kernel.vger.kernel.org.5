Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635657781D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbjHJTvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjHJTve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:51:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A68272C;
        Thu, 10 Aug 2023 12:51:30 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AJmgGU024332;
        Thu, 10 Aug 2023 19:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ON17pte0fAWnNDXQvwTNTiMcKz70Djo11ZzU/VVTxV0=;
 b=aH7oRT4jQWTjU/OYJm4vKIlq4k78K1q70kAbO4RGdScN65fIss5rX6OUDacw+GngDWKX
 Z7oF7tgR4nVSIwPMnB6Kn5dtu7cCyFiBBe2SV0L5EN6/lG0ENmJqQQ5kCvo/xu71a0jb
 z1iaIGAzo0LEutI5wV4tpUHLT6o6FmDwwGPkyUWmkUGIopJUSzNrNlt5fQyy5MJKSA8o
 JSP+8hWJuO8bAoVVoxeT6cBEAnT4zEnl44AR0PxD9MZYE7B90E6xf7frU2mG6Q0cQx3D
 g1P+qeR4UrtQEN9A06D3LwekUUd3SxKtcTkWa2XB4qlfG0hmEX/4Z7pK4V90Cmv4iHw4 zA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scx4vscq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 19:50:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37AJoJwD006158
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 19:50:19 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 12:50:17 -0700
Message-ID: <fcf9fb85-0e78-21db-ee73-aee5193f37ce@quicinc.com>
Date:   Thu, 10 Aug 2023 13:50:16 -0600
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
 <23575f97-332b-0392-fc20-0a52775d03b9@quicinc.com>
 <868ee2b6-3b48-4d32-9614-fa9b3e057257@linaro.org>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <868ee2b6-3b48-4d32-9614-fa9b3e057257@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LNS1hyyiaTAfk4vw9rA0AZEOHVvgjMGC
X-Proofpoint-GUID: LNS1hyyiaTAfk4vw9rA0AZEOHVvgjMGC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=993 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100172
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/2023 12:46 PM, Konrad Dybcio wrote:
> On 10.08.2023 20:20, Jeffrey Hugo wrote:
>> On 8/9/2023 1:20 PM, Konrad Dybcio wrote:
>>> The SMMU GDSC doesn't have to be ALWAYS-ON and shouldn't feature the
>>> HW_CTRL flag (it's separate from hw_ctrl_addr).  In addition to that,
>>> it should feature a cxc entry for bimc_smmu_axi_clk and be marked as
>>> votable.
>>
>> I appear to have confused HW_CTRL with hw_ctrl_addr.  Thanks for fixing that.
>>
>> I recall I made it always-on for display handoff.  The bootloader on the laptops will enable the display, which means the MDP is active and using the SMMU.  The SMMU is powered by the GDSC as you know.  The MDP is going to be polling a framebuffer in DDR, which EFI services (efifb) is going to be updating.  All of this is active during linux boot, which is how the kernel bootlog gets printed on screen.
> This is essentially a missing / mis-configuration from the linux/dt POV and
> I think the consensus for using display without describing it properly with
> mdss has been to do one of:
> 
> - adding a simple-framebuffer node with all the necessary clocks/pds
> - adding "clk_ignore_unused pd_ignore_unused" to your cmdline
> 
>>
>> If I remember right, the GDSC will be registered.  When it is done probing, there will be no consumers.  So the Linux framework will step in and turn it off before the consumers come up.  This kills power to the SMMU.  If the SMMU doesn't come back on before the MDP polls DDR again, you get a bus hang and a crash.
> Yep
> 
>> I assumed that any msm8998 device would be using the MDP/GPU and thus the SMMU would pretty much always be powered on.
> This flag however bans putting it to sleep when not in use.
> 
>>
>> I expected this patch to break the laptop.  It does not in my testing. However, I see that I disabled the MMCC node in DT with a todo about the display.  So the GDSC is never registered, and then never gets turned off.  I believe that todo is pending some updates I need to make to the TI DSI/eDP bridge because the I2C port on the bridge is not wired up.  I should really dust that off and complete it.
> Right, so what you have now is a third, untold "solution" to the problem
> described above.. not really a supported configuration as it's not "correct"
> 
> I'd happily see you wire up the bridge et al though!
> 
> 
>> Regardless, even with the todo addressed, I think removing always-on will still break the laptops unless the bootloader handoff of display was solved and I missed it.
>>
>> I get that for your usecase, a phone where the bootloader does not init the display, always-on has the potential to burn extra power.  I'm not sure how to make both of us happy through.
>>
>> Do you have any suggestions?
> Hope my replies above are enough.

I still think there is an issue, but my setup is not as complete as your 
on mainline.  I'll clean things up and we'll solve the issues when we 
get to them.

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

