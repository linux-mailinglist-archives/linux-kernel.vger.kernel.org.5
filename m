Return-Path: <linux-kernel+bounces-144214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18458A433C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 16:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35135B20E6F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158FE134742;
	Sun, 14 Apr 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pimdMKwy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CE364BF;
	Sun, 14 Apr 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713106382; cv=none; b=jG8BJ4vnBtuyEpslgfwMMOUlOcy++V+i4ZdPL670kXL/fYI12CFSCwJwLBCvN8yn4qAnGkxZFB9YBJ1+XKE9xW3BcF9pyOaQ5svC+VbYsJtOE8H5OHikUUbA3JHTSFLbfpiMamKsGceD6z7Hz/y8ErL5fbFwQlftPD8WPFr78OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713106382; c=relaxed/simple;
	bh=cWAebCGmyhzie5/QiR3suKBycookZfKNe1eWu4+4FQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TqGiklbUUWtIXHsSBgAfAbP6qUs/LV3hLF0+ErQNG51guu08omUTVRHhYvsWw8rQTUUpoavb3onx0g1fVbYOSbaQVXy0+tqQcUZBbZXOlqd2x+TKJ2lofwub9FBfVCJRefIrk1iFPMBEJHZ59BEnR1KnzaVIMOlcXfdcEZimyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pimdMKwy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43EEoKQJ013403;
	Sun, 14 Apr 2024 14:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=68mVWSW7A1H1vgKnHISFRNUy/s6fqpVN8Q+NKU/SusA=; b=pi
	mdMKwySYyUrOWvDP1XRAhpsix3ADWnozSlp23PAM9qy0SYmx9Lsr3B+bkVGSflHk
	Pj5Nsn6azoSNP5v34rpXLU8UB/M81ZioKq9N6cI6MUMN1ASDg/OhPGBefmcZWjOi
	YS2r7CQBSXxpP25VCGRFth9uXVaJiKVMjSxk6A7YHkq56fKtC+R1bup+WW7W3MgJ
	1abpu7pULqP7OZ3ec3EvA1DjvyDtGmpH4f0xmYWQOh8B0oJL09I0gcn1uKM52mYJ
	TD4pBFJsRijnVOIgNEm1XKq+tjrgWkiKj9rscAWwJWE8CMg+fafZYCaOQUDtpu9T
	P2SLQsVEU1dMJLvcaDeA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xfkbdhx7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 14:52:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43EEqlZ3005406
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Apr 2024 14:52:47 GMT
Received: from [10.216.31.249] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 14 Apr
 2024 07:52:37 -0700
Message-ID: <b96ef82c-4033-43e0-9c1e-347ffb500751@quicinc.com>
Date: Sun, 14 Apr 2024 20:22:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 RESEND 5/5] venus: pm_helpers: Use
 dev_pm_genpd_set_hwmode to switch GDSC mode on V6
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen
 Boyd" <sboyd@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek
	<pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Andy
 Gross" <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        "Satya Priya
 Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240413152013.22307-1-quic_jkona@quicinc.com>
 <20240413152013.22307-6-quic_jkona@quicinc.com>
 <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
Content-Language: en-US
From: Jagadeesh Kona <quic_jkona@quicinc.com>
In-Reply-To: <5c78ad52-524b-4ad7-b149-0e7252abc2ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: veCuhAHTmxkcbsZpphBoC4DzPmYdR7Dv
X-Proofpoint-GUID: veCuhAHTmxkcbsZpphBoC4DzPmYdR7Dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-14_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404140107



On 4/14/2024 6:09 PM, Bryan O'Donoghue wrote:
> On 13/04/2024 16:20, Jagadeesh Kona wrote:
>> The Venus driver requires vcodec GDSC to be ON in SW mode for clock
>> operations and move it back to HW mode to gain power benefits. Earlier,
>> as there is no interface to switch the GDSC mode from GenPD framework,
>> the GDSC is moved to HW control mode as part of GDSC enable callback and
>> venus driver is writing to its POWER_CONTROL register to keep the GDSC ON
>> from SW whereever required. But the POWER_CONTROL register addresses
>> are not constant and can vary across the variants.
>>
>> Also as per the HW recommendation, the GDSC mode switching needs to be
>> controlled from respective GDSC register and this is a uniform approach
>> across all the targets. Hence use dev_pm_genpd_set_hwmode() API which
>> controls GDSC mode switching using its respective GDSC register.
>>
>> In venus V6 variants, the vcodec gdsc gets enabled in SW mode by default
>> with new HW_CTRL_TRIGGER flag and there is no need to switch it to SW
>> mode again after enable, hence add check to avoid switching gdsc to SW 
>> mode
>> again after gdsc enable. Similarly add check to avoid switching GDSC 
>> to HW
>> mode before disabling the GDSC, so GDSC gets enabled in SW mode in the 
>> next
>> enable.
>>
>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>> ---
> 
> When I tested this out on sm8250 a few months ago it was broken.
> 
> I don't quite see in your commit logs, how the breakage was addressed.
> 
> Can you provide some details ?
> 

Thanks Bryan for your review!

In earlier series, venus driver is switching the vcodec GDSC to HW 
control mode before disabling the GDSC by invoking 
vcodec_control_v4(..., false) in poweroff_coreid(). Due to this, the 
subsequent GDSC enable from venus driver is failing while polling for 
GDSC power ON status, since GDSC is under HW control mode and HW can 
keep the GDSC in disabled state.

Now a check is added in poweroff_coreid() to avoid switching the GDSC to 
HW control mode before disabling the GDSC for Venus V6 variants that use 
this new API. Hence during the next GDSC enable, GDSC will be in SW mode 
and GDSC will powerup properly.

Thanks,
Jagadeesh

> ---
> bod
> 

