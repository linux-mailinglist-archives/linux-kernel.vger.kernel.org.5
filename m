Return-Path: <linux-kernel+bounces-50520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1C0847A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8288B29BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1FBD65E04;
	Fri,  2 Feb 2024 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gOIyoq78"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B712C807;
	Fri,  2 Feb 2024 19:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903974; cv=none; b=Wh287U6hRWRl8uSnmIcSTvCyBJa8aQBO5UkOWEFWr7QLJ24BDg0N0sCPbWBlYXxT+12M8wNdycjqVhvFT/sZ/MMpXUEjVVLiB0n+8UvHDVv/vkQVZ38HaHd203a7Y9xcYN8nwGn67dbLFqnXR9c4fHaNOlLtGurxHro4+oYO3ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903974; c=relaxed/simple;
	bh=bpC0G979XkzDX4Y0eVxoG/7PEvPhZ3F+aUerWOq9iSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kmxkqqb8xPIUhf36U5x/+XxyELEOg+1Cg1O89/bSYPS7EaoeTP2wNflWoUKit4LsSkjMP7LBGTnafgcT7oD2m3SA1UCni/KJtBakz5M0ACtazhYAr5W1X2Z48nsSD568B0NgjMz6YyT5g6frXeQCajd/lTybjRnljZX6k6L/ppU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gOIyoq78; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412GAW0q015164;
	Fri, 2 Feb 2024 19:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jK/PuBrL8qdEn+vnj8xyXaG53+FI1WP9iOTek0QM9/s=; b=gO
	Iyoq78viZa10Iwp0GWBGNL57mkyYumSfL8cM1mjYgLVF7iptzdsFsym9/KnojHBr
	wrBggytE+3WopcAX7x9ZG2kLuQ5SIa0DS9xFiIfQdSczGsk5jhfQrSNBVT5VX+Up
	RYPM1uRz5tdpAG2REr7LFFHU1qlB6XwgL8TXdAMAdP9DjUBrVCtqivr0r7kgKprz
	2sKx6Gq8bcEDdgKnMMv5Qt3v99iOdveL5weotPSlWiT+Ekq35AEBUQk5WRk7ORDX
	Jya3l9ekW20Njno6xU36nnsLADQTc3+gVF+jPTQd6wUv8JjWzSZX7eP6KMkFl9SI
	uu+ZPhhwOkCRH0OzH76A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptxja4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 19:59:30 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412JxTbr003739
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 19:59:29 GMT
Received: from [10.110.44.7] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 11:59:26 -0800
Message-ID: <09629681-4eec-4522-8b66-4a3bd2b7be91@quicinc.com>
Date: Fri, 2 Feb 2024 11:59:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Check return value on Broadcast_OR reg
 read
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
References: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
 <5ba42ywqwi2ix2hyo4ysdgo2onyrhm6rtvpow626r7kctoixz6@xrens4w3k7ar>
Content-Language: en-US
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <5ba42ywqwi2ix2hyo4ysdgo2onyrhm6rtvpow626r7kctoixz6@xrens4w3k7ar>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WawzztJwW5neqFJ1hwlsJYxIQLFae9wn
X-Proofpoint-GUID: WawzztJwW5neqFJ1hwlsJYxIQLFae9wn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_13,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020146



On 2/2/2024 11:56 AM, Elliot Berman wrote:
> On Fri, Feb 02, 2024 at 11:47:43AM -0800, Unnathi Chalicheemala wrote:
>> Commit a3134fb09e0b ("drivers: soc: Add LLCC driver") didn't
>> check return value after Broadcast_OR register read in
>> llcc_update_act_ctrl(), add it.
>>
> 
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> You'll probably want to add:
> 
> Fixes: a3134fb09e0b ("drivers: soc: Add LLCC driver")
> 

Ack. Missed it, thanks Elliot!

>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>> ---
>>  drivers/soc/qcom/llcc-qcom.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 4ca88eaebf06..cbef0dea1d5d 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>>  	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>>  				      slice_status, !(slice_status & status),
>>  				      0, LLCC_STATUS_READ_DELAY);
>> +	if (ret)
>> +		return ret;
>>  
>>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>>  		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
>>
>> ---
>> base-commit: 021533194476035883300d60fbb3136426ac8ea5
>> change-id: 20240202-fix_llcc_update_act_ctrl-64908aed9450
>>
>> Best regards,
>> -- 
>> Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>>

