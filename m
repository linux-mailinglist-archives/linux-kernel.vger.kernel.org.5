Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4147E8051
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbjKJSJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjKJSFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C99EEC;
        Fri, 10 Nov 2023 00:33:18 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gBBN011899;
        Fri, 10 Nov 2023 08:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0g31E2AhP85G9hfjyKxjq/sbrz0JScFMKaVi/mJsAwo=;
 b=jDuAgLMb6c32yAx6FjS3JGSfRmlrNRsKOoCfcnRQwC0xryPBhmI3ezbjJuBTBQ3FsqJx
 YFz00HKaP7FqQRGQ9x+Dc7mCvG9mdick2sYXrBrG1XPvwsAbegGfICSTmHXdcLB4E40i
 /vDandvS1lusgMEsUZFRkFInmlIPV7u/gQK9GPpiFQj/kuzfZCbCVo8xno+9OJ4Dq2/j
 L0bX/MoZVKvzXC67CGlPXHesrM5MKUUwszLdyy+NKO7ccN4jlC/ap3Y6zgZ5Sh+rxJMG
 ndS8YjqUSynipDsCgN3wIcfM7MA1dEY7AJ9PvD34+rTprS8US6LVGD7pedmxXvAsdmEq Ww== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u93tq9pes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:33:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8XA7e016922
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 08:33:10 GMT
Received: from [10.217.216.47] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 00:33:01 -0800
Message-ID: <5b3315fe-f59b-cdf3-b980-a5a68bceb6a9@quicinc.com>
Date:   Fri, 10 Nov 2023 14:02:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RESEND v3 3/5] clk: qcom: gdsc: Add set and get hwmode
 callbacks to switch GDSC mode
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Taniya Das <tdas@qti.qualcomm.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-media@vger.kernel.org>
References: <20231101-gdsc-hwctrl-v3-0-0740ae6b2b04@linaro.org>
 <20231101-gdsc-hwctrl-v3-3-0740ae6b2b04@linaro.org>
 <CAA8EJpqTafxkXfAZXdTCat1VphvHUTTWe1TUjbpMvqta1Jf+Cw@mail.gmail.com>
From:   Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <CAA8EJpqTafxkXfAZXdTCat1VphvHUTTWe1TUjbpMvqta1Jf+Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0yWIBZBRQecYYPSMJiHBmWTOIVmjEPrP
X-Proofpoint-ORIG-GUID: 0yWIBZBRQecYYPSMJiHBmWTOIVmjEPrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100071
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2023 2:58 AM, Dmitry Baryshkov wrote:
> On Wed, 1 Nov 2023 at 11:06, Abel Vesa <abel.vesa@linaro.org> wrote:
>>
>> From: Jagadeesh Kona <quic_jkona@quicinc.com>
>>
>> Add support for set and get hwmode callbacks to switch the GDSC between
>> SW and HW modes. Currently, the GDSC is moved to HW control mode
>> using HW_CTRL flag and if this flag is present, GDSC is moved to HW
>> mode as part of GDSC enable itself. The intention is to keep the
>> HW_CTRL flag functionality as is, since many older chipsets still use
>> this flag.
>>
>> Introduce a new HW_CTRL_TRIGGER flag to switch the GDSC back and forth
>> between HW/SW modes dynamically at runtime. If HW_CTRL_TRIGGER flag is
>> present, register set_hwmode_dev callback to switch the GDSC mode which
>> can be invoked from consumer drivers using dev_pm_genpd_set_hwmode
>> function. Unlike HW_CTRL flag, HW_CTRL_TRIGGER won't move the GDSC to HW
>> control mode as part of GDSC enable itself, GDSC will be moved to HW
>> control mode only when consumer driver explicity calls
>> dev_pm_genpd_set_hwmode to switch to HW mode. Also add the
>> dev_pm_genpd_get_hwmode to allow the consumers to read the actual
>> HW/SW mode from hardware.
> 
> Can we add two new flags:
> - HW_CTRL_TRIGGER
> - DEFAULT_HW_TRIGGER
> 
> And then define HW_CTRL as HW_CTRL_TRIGGER | DEFAULT_HW_TRIGGER ?
> 
> This way older platforms will keep existing behaviour, but can
> gradually migrate to the new callbacks?
> 

Thanks Dmitry for your review,

The current usecases we have for GDSC's are either use the existing 
HW_CTRL flag to switch the GDSC to HW mode in gdsc_enable() and back to 
SW mode in gdsc_disable(). The second usecase is don't switch GDSC mode 
in gdsc_enable() & gdsc_disable() at all, and switch the GDSC mode only 
in new callbacks when consumers explicitly request it using 
dev_pm_genpd_set_hwmode(), this can be achieved using the new 
HW_CTRL_TRIGGER flag.

By defining HW_CTRL as HW_CTRL_TRIGGER | DEFAULT_HW_TRIGGER, it switches 
the GDSC mode both in enable & disable callbacks and in new callbacks as 
well. But we currently don't have any usecase that requires this behaviour.

Thanks,
Jagadeesh

>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
>>   drivers/clk/qcom/gdsc.c | 32 ++++++++++++++++++++++++++++++++
>>   drivers/clk/qcom/gdsc.h |  1 +
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
>> index 5358e28122ab..c763524cd5da 100644
>> --- a/drivers/clk/qcom/gdsc.c
>> +++ b/drivers/clk/qcom/gdsc.c
>> @@ -363,6 +363,34 @@ static int gdsc_disable(struct generic_pm_domain *domain)
>>          return 0;
>>   }
>>
>> +static int gdsc_set_hwmode(struct generic_pm_domain *domain, struct device *dev, bool mode)
>> +{
>> +       struct gdsc *sc = domain_to_gdsc(domain);
>> +
>> +       if (sc->rsupply && !regulator_is_enabled(sc->rsupply)) {
>> +               pr_err("Cannot set mode while parent is disabled\n");
>> +               return -EIO;
>> +       }
>> +
>> +       return gdsc_hwctrl(sc, mode);
>> +}
>> +
>> +static bool gdsc_get_hwmode(struct generic_pm_domain *domain, struct device *dev)
>> +{
>> +       struct gdsc *sc = domain_to_gdsc(domain);
>> +       u32 val;
>> +       int ret;
>> +
>> +       ret = regmap_read(sc->regmap, sc->gdscr, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val & HW_CONTROL_MASK)
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>>   static int gdsc_init(struct gdsc *sc)
>>   {
>>          u32 mask, val;
>> @@ -451,6 +479,10 @@ static int gdsc_init(struct gdsc *sc)
>>                  sc->pd.power_off = gdsc_disable;
>>          if (!sc->pd.power_on)
>>                  sc->pd.power_on = gdsc_enable;
>> +       if (sc->flags & HW_CTRL_TRIGGER) {
>> +               sc->pd.set_hwmode_dev = gdsc_set_hwmode;
>> +               sc->pd.get_hwmode_dev = gdsc_get_hwmode;
>> +       }
>>
>>          ret = pm_genpd_init(&sc->pd, NULL, !on);
>>          if (ret)
>> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
>> index 803512688336..1e2779b823d1 100644
>> --- a/drivers/clk/qcom/gdsc.h
>> +++ b/drivers/clk/qcom/gdsc.h
>> @@ -67,6 +67,7 @@ struct gdsc {
>>   #define ALWAYS_ON      BIT(6)
>>   #define RETAIN_FF_ENABLE       BIT(7)
>>   #define NO_RET_PERIPH  BIT(8)
>> +#define HW_CTRL_TRIGGER        BIT(9)
>>          struct reset_controller_dev     *rcdev;
>>          unsigned int                    *resets;
>>          unsigned int                    reset_count;
>>
>> --
>> 2.34.1
>>
> 
> 
