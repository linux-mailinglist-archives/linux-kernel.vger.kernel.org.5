Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922C67F25C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjKUGbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUGbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:31:36 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C680ACB;
        Mon, 20 Nov 2023 22:31:32 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL5X1Rt011112;
        Tue, 21 Nov 2023 06:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V/jXUps7FcsW7n1gITRfSYCcyq9bPOJPSdFvCTOoZyU=;
 b=n5fe3PahwlP97eR0BFHP9EKMfDO0ae7g+VY+7VkPP0PTjqGj55UcM+0V6ig19ESYHPpR
 OiJt2NOsuhkvaC3z3tz5ovYM3YyAKo48H+C+QfhyaqvK4AI2xARZfiosHCmEWhbHPsSs
 Yk/fCJ2R5Tz4UQHJ0tMp/rW+FpW05gBiGytHbjZubx3EhsPhfgLD/zHmGkgoytSbixHg
 ZPqFVvkW/oEymc1YmlLA0rGvWwHOyi/r5yQBcaDg+5Tj+Cistyf9AC90IZXEILY5TFg/
 SqytzmptIJNT/VHfSm818EM78Kffkx0egAA33V9d2J6VduDuBAXM+7etHovZ9T1gVKZ4 7g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugcqs19dc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 06:31:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL6VLSg010308
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 06:31:21 GMT
Received: from [10.50.58.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 22:31:18 -0800
Message-ID: <5540adcd-4ba6-53e7-c7fe-b7116e6403ca@quicinc.com>
Date:   Tue, 21 Nov 2023 12:01:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v6 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230916140046.7878-1-ansuelsmth@gmail.com>
 <20230916140046.7878-3-ansuelsmth@gmail.com>
 <419b0e85-5479-30b0-d6a9-b2697d057c55@quicinc.com>
 <655bca09.050a0220.bac1.aa06@mx.google.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <655bca09.050a0220.bac1.aa06@mx.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jEAffWjfJ59uQ5y7mFhjEzWiZm6AHet4
X-Proofpoint-GUID: jEAffWjfJ59uQ5y7mFhjEzWiZm6AHet4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210049
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2023 11:44 PM, Christian Marangi wrote:
> On Mon, Nov 20, 2023 at 03:51:50PM +0530, Devi Priya wrote:
>>
>>
>> On 9/16/2023 7:30 PM, Christian Marangi wrote:
>>> Some RCG frequency can be reached by multiple configuration.
>>>
>>> Add clk_rcg2_fm_ops ops to support these special RCG configurations.
>>>
>>> These alternative ops will select the frequency using a CEIL policy.
>>>
>>> When the correct frequency is found, the correct config is selected by
>>> calculating the final rate (by checking the defined parent and values
>>> in the config that is being checked) and deciding based on the one that
>>> is less different than the requested one.
>>>
>>> These check are skipped if there is just on config for the requested
>>> freq.
>>>
>>> qcom_find_freq_multi is added to search the freq with the new struct
>>> freq_multi_tbl.
>>> __clk_rcg2_select_conf is used to select the correct conf by simulating
>>> the final clock.
>>> If a conf can't be found due to parent not reachable, a WARN is printed
>>> and -EINVAL is returned.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    drivers/clk/qcom/clk-rcg.h  |   1 +
>>>    drivers/clk/qcom/clk-rcg2.c | 167 ++++++++++++++++++++++++++++++++++++
>>>    drivers/clk/qcom/common.c   |  18 ++++
>>>    drivers/clk/qcom/common.h   |   2 +
>>>    4 files changed, 188 insertions(+)
>>>
>>> diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
>>> index c81458db6ce4..dc9a77965e68 100644
>>> --- a/drivers/clk/qcom/clk-rcg.h
>>> +++ b/drivers/clk/qcom/clk-rcg.h
>>> @@ -190,6 +190,7 @@ struct clk_rcg2_gfx3d {
>>>    extern const struct clk_ops clk_rcg2_ops;
>>>    extern const struct clk_ops clk_rcg2_floor_ops;
>>> +extern const struct clk_ops clk_rcg2_fm_ops;
>>>    extern const struct clk_ops clk_rcg2_mux_closest_ops;
>>>    extern const struct clk_ops clk_edp_pixel_ops;
>>>    extern const struct clk_ops clk_byte_ops;
>>> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
>>> index e22baf3a7112..617e7ff0f6a3 100644
>>> --- a/drivers/clk/qcom/clk-rcg2.c
>>> +++ b/drivers/clk/qcom/clk-rcg2.c
>>> @@ -266,6 +266,116 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>>>    	return 0;
>>>    }
>>> +static const struct freq_conf *
>>> +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
>>> +		       unsigned long req_rate)
>>> +{
>>> +	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
>>> +	const struct freq_conf *conf, *best_conf;
>>> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
>>> +	const char *name = clk_hw_get_name(hw);
>>> +	unsigned long parent_rate, rate;
>>> +	struct clk_hw *p;
>>> +	int index, i;
>>> +
>>> +	/* Init best_conf to the first conf */
>>> +	best_conf = f->confs;
>>> +
>>> +	/* Exit early if only one config is defined */
>>> +	if (f->num_confs == 1)
>>> +		goto exit;
>>> +
>>> +	/* Search in each provided config the one that is near the wanted rate */
>>> +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
>>> +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
>>> +		if (index < 0)
>>> +			continue;
>>> +
>>> +		p = clk_hw_get_parent_by_index(hw, index);
>>> +		if (!p)
>>> +			continue;
>>> +
>>> +		parent_rate =  clk_hw_get_rate(p);
>>> +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
>>> +
>>> +		if (rate == req_rate) {
>>> +			best_conf = conf;
>>> +			goto exit;
>>> +		}
>>> +
>>> +		rate_diff = abs(req_rate - rate);
>>> +		if (rate_diff < best_rate_diff) {
>>> +			best_rate_diff = rate_diff;
>>> +			best_conf = conf;
>>> +		}
>>> +	}
>>> +
>>> +	/*
>>> +	 * Very unlikely. Warn if we couldn't find a correct config
>>> +	 * due to parent not found in every config.
>>> +	 */
>>> +	if (unlikely(i == f->num_confs)) {
>>> +		WARN(1, "%s: can't find a configuration for rate %lu.",
>>> +		     name, req_rate);
>>> +		return ERR_PTR(-EINVAL);
>>> +	}
>> Hi Christian,
>>
>> Thanks a lot for the patch!
>> We have incorporated these changes along with the corresponding clock driver
>> changes & tested it on IPQ9574 & IPQ5332 targets.
>>
>> When setting the clk rate for the nss port clocks, for the requested
>> frequency the correct config gets selected and the
>> clk rate is set properly.
>> We see the WARN getting printed for other frequencies (rate * i where
>> i=2 to maxdiv) that is requested by the clk_hw_round_rate function.
>>
>> Upon analysis, we see that the for loop in clk_divider_bestdiv iterates
>> until the maxdiv value and requests (rate*i) via the clk_hw_round_rate
>> API to find the bestdiv and best_parent_rate. For frequencies which are
>> multiples of the requested frequency (rate*i where i=2 to maxdiv), it
>> seems unlikely to see the WARN being printed.
>>
>> Can you please help us understand when the WARN is likely to be printed
>> & Looking forward to your suggestions on how this WARN could
>> be suppressed in the afore mentioned scenario!
>>
> 
> Hi,
> 
> thanks a lot for testing this. Maybe was a small oversight by me.
> 
> I attached an alternative patch. Can you test it and tell me if the WARN
> is still printed? (the WARN must be printed only when the parent is not
> found, I don't think it's your case)
> 
Hi Christian,

WARN does not get printed with the attached patchset.
Thanks much!

Regards,
Devi Priya
