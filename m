Return-Path: <linux-kernel+bounces-107417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBF687FC2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668741F224B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA17EF06;
	Tue, 19 Mar 2024 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DO0T/veh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDB7E588;
	Tue, 19 Mar 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845375; cv=none; b=jZAm2bV2hTNz9wU3LUn3QbJ/fZ1Cy0Plu8yncZ/NM0/j9wSFhO/jADpvCfzpDcAm8flUQptOOGlxu1svFUxWMsv31KhxXpfurgVqGsHuTD9W8zARM6MQfpUPz4rP2n2JdSMj6Psjtg53WcmTL7Em2AJqb2J112pMk2M2AkxWxYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845375; c=relaxed/simple;
	bh=+2+hlQeVCNe/+OvCDgO7BBlv6P43RD46BVGfCKuEOtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HcTddbVFZbWLCpy92Ll+a7trWsvjJ2W3Ad9Da74vGo2uISAr+cvjM0+D424TMFUiazHve0VL8QydsA+Kwc4lUqEcQf6TvDVVDkiAfvRHc5Dk9c2fN5DVsKHUoydpxbaZLWcrGe5lC5PE/Bqz0/rkm1W8MD4DIHmVV1WVJoE447I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DO0T/veh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42J6wnvW032363;
	Tue, 19 Mar 2024 10:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TXmOXKzV/bRduRmg70uERLPSV0dZISDGvpH1DiR0zGA=; b=DO
	0T/vehIZQLRGbC5Dc1wJ29z2VnaRX+IZJ5eOFfLHASUU+o1qsP0GA2JtH+o+NsBi
	d9flvb+2a7lrCnISDroGeb99Gw3q6V1SiqL+AtSiVNTtqd8a1t26mIwkIJWxMqMO
	tpECqivvUHK6lnQ+1uT8T8kBSGFbPzM19fsqSOP6IdUpwtnk/UQUAO3r5IFKa1yz
	83PawNcUpNEcDHCJNfj/mMiO5LL82oP4SLZ8i3MWTJYIh4QTVqDr+J2fef3PzNnw
	1RRVUOhu+6RYgoLYMA/OlD+KdfRiYiOvJE/29IgkvZuaI4Skbr3zOLlrmK4srpqX
	9cOW506tiqNTD+o9DO7Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wy5ws0h34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:49:24 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JAn3Jf014757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 10:49:03 GMT
Received: from [10.218.47.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 03:48:59 -0700
Message-ID: <06ab4347-3ed0-432a-cc36-49837d8a28de@quicinc.com>
Date: Tue, 19 Mar 2024 16:18:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
To: Amit Kucheria <amitk@kernel.org>
CC: Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_manafm@quicinc.com>
References: <20240227160928.2671-1-quic_priyjain@quicinc.com>
 <CAHLCerModb=01WX=q6XU0XO8dr5EaSQ5RaBoFLFc_=vpOGAgaw@mail.gmail.com>
Content-Language: en-US
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <CAHLCerModb=01WX=q6XU0XO8dr5EaSQ5RaBoFLFc_=vpOGAgaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M5ZQHBwoEQiAAhbIUMXytZ9qa59Mg8I-
X-Proofpoint-GUID: M5ZQHBwoEQiAAhbIUMXytZ9qa59Mg8I-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190083



On 3/17/2024 1:37 AM, Amit Kucheria wrote:
> On Tue, Feb 27, 2024 at 9:40 PM Priyansh Jain <quic_priyjain@quicinc.com> wrote:
>>
>> As part of suspend to RAM, tsens hardware will be turned off.
>> While resume callback, re-initialize tsens hardware.
>>
>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>> ---
>> V2 -> V3: Remove suspend callback & interrupt enablement part from
>> resume callback.
>> V1 -> V2: Update commit text to explain the necessity of this patch
>>
>>   drivers/thermal/qcom/tsens-v2.c |  1 +
>>   drivers/thermal/qcom/tsens.c    | 40 +++++++++++++++++++++++++++++++++
>>   drivers/thermal/qcom/tsens.h    |  6 +++++
>>   3 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
>> index 29a61d2d6ca3..0cb7301eca6e 100644
>> --- a/drivers/thermal/qcom/tsens-v2.c
>> +++ b/drivers/thermal/qcom/tsens-v2.c
>> @@ -107,6 +107,7 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>   static const struct tsens_ops ops_generic_v2 = {
>>          .init           = init_common,
>>          .get_temp       = get_temp_tsens_valid,
>> +       .resume         = tsens_resume_common,
>>   };
> 
> Please add resume callbacks for the other tsens hardware too and make
> sure that your reinit function handles them too.
> 
We have discussed internally on this and we think that if someone wants 
to extend the support (and do the validation) of one of those old 
platforms they can add the resume ops for that platform. There are many 
versions of tsens hardware so we are bit skeptical to add reinit support
for all these platforms with any validations(since S2R mode is not 
enabled for all these older platforms so it is not possible to validate).

Regards,
Priyansh
>>
>>   struct tsens_plat_data data_tsens_v2 = {
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 6d7c16ccb44d..396c1cd71351 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/pm.h>
>>   #include <linux/regmap.h>
>>   #include <linux/slab.h>
>> +#include <linux/suspend.h>
>>   #include <linux/thermal.h>
>>   #include "../thermal_hwmon.h"
>>   #include "tsens.h"
>> @@ -1193,6 +1194,45 @@ static int tsens_register_irq(struct tsens_priv *priv, char *irqname,
>>          return ret;
>>   }
>>
>> +#ifdef CONFIG_SUSPEND
>> +static int tsens_reinit(struct tsens_priv *priv)
>> +{
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&priv->ul_lock, flags);
>> +
>> +       /* in VER_0 TSENS need to be explicitly enabled */
>> +       if (tsens_version(priv) == VER_0)
>> +               regmap_field_write(priv->rf[TSENS_EN], 1);
>> +
>> +       /*
>> +        * Re-enable the watchdog, unmask the bark.
>> +        * Disable cycle completion monitoring
>> +        */
>> +       if (priv->feat->has_watchdog) {
>> +               regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
>> +               regmap_field_write(priv->rf[CC_MON_MASK], 1);
>> +       }
>> +
>> +       /* Re-enable interrupts */
>> +       if (tsens_version(priv) >= VER_0_1)
>> +               tsens_enable_irq(priv);
>> +
>> +       spin_unlock_irqrestore(&priv->ul_lock, flags);
>> +
>> +       return 0;
>> +}
>> +
>> +int tsens_resume_common(struct tsens_priv *priv)
>> +{
>> +       if (pm_suspend_target_state == PM_SUSPEND_MEM)
>> +               tsens_reinit(priv);
>> +
>> +       return 0;
>> +}
>> +
>> +#endif /* !CONFIG_SUSPEND */
>> +
>>   static int tsens_register(struct tsens_priv *priv)
>>   {
>>          int i, ret;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index cb637fa289ca..7a147d9d8544 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -635,6 +635,12 @@ int init_common(struct tsens_priv *priv);
>>   int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp);
>>   int get_temp_common(const struct tsens_sensor *s, int *temp);
>>
>> +#ifdef CONFIG_SUSPEND
>> +int tsens_resume_common(struct tsens_priv *priv);
>> +#else
>> +#define tsens_resume_common            NULL
>> +#endif
>> +
>>   /* TSENS target */
>>   extern struct tsens_plat_data data_8960;
>>
>> --
>> 2.17.1
>>

