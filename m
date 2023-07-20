Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D375A557
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjGTFHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGTFHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:07:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAC9BE;
        Wed, 19 Jul 2023 22:07:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K3OwUZ019810;
        Thu, 20 Jul 2023 05:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0QJyCvh/MFbjPdpLadzjz1UKlzbXi9w2Jw8V1eoZ7I4=;
 b=Yn8gDOo+s/A36RSdsA4yRepXaHQtvxybxaAzJzbkqNaD5TIc7wQij07JViyBuqao3HAj
 41SwLsaTWenHYKJ4sOhqqwj9bkTVanOqIwId11ikts/feZeeDbsEQR57RIybZANa8vlY
 ncNmtCbkFbhsYpLDymqWVZ27PWhlx7QLGItQipe+OFBFizTwFUUSjARVQejNHn4BMDdW
 raG3/ze2qjBO/sA+WA2nSou5xUDuHb8QUi9Vx1bFQcZFfOs+uEt/kqH7Qa4Rx2qBE9gh
 4wexRZ/KNDZe7wrTea1tIamKMhu7TLojGIvwKy6EqQDJYnXatVBhmD2jy0PbO9/bxB+p DQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxt188dcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 05:07:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36K57SMw004801
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 05:07:28 GMT
Received: from [10.216.26.184] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 22:07:23 -0700
Message-ID: <f4d6f3d3-568a-c3ee-3c87-9b0a65ad2912@quicinc.com>
Date:   Thu, 20 Jul 2023 10:36:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Use determine_rate instead of
 round_rate
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_saahtoma@quicinc.com>
References: <20230710093206.18894-1-quic_devipriy@quicinc.com>
 <f726290fe0678217f2e17b6a68c20d42.sboyd@kernel.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <f726290fe0678217f2e17b6a68c20d42.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aPGJfiqPoxV_2knw5irdosx8OoLbHadh
X-Proofpoint-GUID: aPGJfiqPoxV_2knw5irdosx8OoLbHadh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=990 adultscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200041
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 1:34 AM, Stephen Boyd wrote:
> Quoting Devi Priya (2023-07-10 02:32:06)
>> @@ -1094,25 +1099,25 @@ static const struct clk_div_table clk_alpha_2bit_div_table[] = {
>>          { }
>>   };
>>   
>> -static long
>> -clk_alpha_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
>> -                                unsigned long *prate)
>> +static int clk_alpha_pll_postdiv_determine_rate(struct clk_hw *hw,
>> +                                               struct clk_rate_request *req)
>>   {
>>          struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
>>          const struct clk_div_table *table;
>> +       unsigned long rate = req->rate;
>>   
>>          if (pll->width == 2)
>>                  table = clk_alpha_2bit_div_table;
>>          else
>>                  table = clk_alpha_div_table;
>>   
>> -       return divider_round_rate(hw, rate, prate, table,
>> -                                 pll->width, CLK_DIVIDER_POWER_OF_TWO);
>> +       req->rate = divider_round_rate(hw, rate, &req->best_parent_rate, table,
> 
> Can you use divider_determine_rate() instead?

Sure, okay
> 
>> +                                      pll->width, CLK_DIVIDER_POWER_OF_TWO);
>> +       return 0;
>>   }
>>   
>> -static long
>> -clk_alpha_pll_postdiv_round_ro_rate(struct clk_hw *hw, unsigned long rate,
>> -                                   unsigned long *prate)
>> +static int clk_alpha_pll_postdiv_determine_ro_rate(struct clk_hw *hw,
>> +                                                  struct clk_rate_request *req)
>>   {
>>          struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
>>          u32 ctl, div;
> [...]
>> @@ -1452,14 +1459,16 @@ clk_trion_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
>>          return (parent_rate / div);
>>   }
>>   
>> -static long
>> -clk_trion_pll_postdiv_round_rate(struct clk_hw *hw, unsigned long rate,
>> -                                unsigned long *prate)
>> +static int
>> +clk_trion_pll_postdiv_determine_rate(struct clk_hw *hw,
>> +                                    struct clk_rate_request *req)
>>   {
>>          struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
>>   
>> -       return divider_round_rate(hw, rate, prate, pll->post_div_table,
>> -                                 pll->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +       req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
> 
> divider_determine_rate()?
Sure
> 
>> +                                      pll->post_div_table, pll->width,
>> +                                      CLK_DIVIDER_ROUND_CLOSEST);
>> +       return 0;
>>   };
>>   
>>   static int
>> @@ -1485,18 +1494,21 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
>>   
>>   const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
>>          .recalc_rate = clk_trion_pll_postdiv_recalc_rate,
>> -       .round_rate = clk_trion_pll_postdiv_round_rate,
>> +       .determine_rate = clk_trion_pll_postdiv_determine_rate,
>>          .set_rate = clk_trion_pll_postdiv_set_rate,
>>   };
>>   EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
>>   
>> -static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
>> -                               unsigned long rate, unsigned long *prate)
>> +static int
>> +clk_alpha_pll_postdiv_fabia_determine_rate(struct clk_hw *hw,
>> +                                          struct clk_rate_request *req)
>>   {
>>          struct clk_alpha_pll_postdiv *pll = to_clk_alpha_pll_postdiv(hw);
>>   
>> -       return divider_round_rate(hw, rate, prate, pll->post_div_table,
>> -                               pll->width, CLK_DIVIDER_ROUND_CLOSEST);
>> +       req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
>> +                                      pll->post_div_table, pll->width,
>> +                                       CLK_DIVIDER_ROUND_CLOSEST);
> 
> divider_determine_rate()?
Sure

Thanks,
Devi Priya
