Return-Path: <linux-kernel+bounces-42222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEA083FE2A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C8C28112B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B234CE18;
	Mon, 29 Jan 2024 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZHvgzaJA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1144CDE7;
	Mon, 29 Jan 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706509253; cv=none; b=WVowOWrMOXSnPQREM0U1ofkjYtOMgPeb7LLn49d1I/uVLcBBTManHcEgOoWtSnh1wII/vkI2SsFnWV2vfvxNiPrDadFc0VuGdWiUt7OUdB7LEjBxftoY/rBY4iFneQ3VgspHIMyFHbFuNOx3TNCqOi10Tgh0uor1J9mb/JHPH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706509253; c=relaxed/simple;
	bh=qw/DP9PETNrIhcO6gljeKYbbK08PVRuQsY8yGpNxvlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cz7x0TTVi28m6SaZm2lPbEMGeVUROHHWmyPXFbDnv1x2Nl7ZSynuz2ngpKXRpS7/bVruwWWsBePV7KRA2E5hqZRH95vfgDO4I9PPzwF9MclnT2SsDhz59pOa2wyZqlKe7Y/yXDxAIm8pXC2f8Ulra3+M1onjB7bVA3ywolvXDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZHvgzaJA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T4ro2U007142;
	Mon, 29 Jan 2024 06:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tuVzaSE0q/q50xp0AxYrUAe66nQO9Sqbqhz7iRe9JuA=; b=ZH
	vgzaJAq+sQ+MYdIFTbYYRb4b+abxB49TmqTfxGkjWdLAn3hUa9vEAbCNt8UyJHyT
	LwykJTTiDYkXe56ykMHKsDQJAjUfdZGXtq0/XjIKF+4vOBOw87OoADePlxNjp3/x
	VlZDbf5Bkxo24GXPm3sYP65stBEl1hG4T8MwT+v8vowLJ2oa7OpiEM1BUqbB3VqU
	yVNb3SYTa9GiwAOADk3FqS+pzNVnNlvV3yV7g0tklSm3EMqksopLm+wbZcbZrL1Q
	+goyg1lzRpnCuFIuz7/Th/W6Y/qyYLlAgNljohYRDCtYsYV64OfJYC3jmHByoafE
	9wI1lXZDaIjNo6q20Nnw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvrubaxua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:20:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6KjXm030220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:20:45 GMT
Received: from [10.217.198.224] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 28 Jan
 2024 22:20:43 -0800
Message-ID: <589dddd8-0ed2-4138-a617-402aa28c79da@quicinc.com>
Date: Mon, 29 Jan 2024 11:50:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
To: Bjorn Andersson <andersson@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_eberman@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_lsrao@quicinc.com>
References: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
 <xjcefuurfbv7oquotsmm4iv4pnwzoone7jxrm42vjsnpfcgk4z@mnrsxec43bhp>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <quic_mkshah@quicinc.com>
In-Reply-To: <xjcefuurfbv7oquotsmm4iv4pnwzoone7jxrm42vjsnpfcgk4z@mnrsxec43bhp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1XsAPNs6ynOh5yrHSKpwwnuGQNC831UY
X-Proofpoint-GUID: 1XsAPNs6ynOh5yrHSKpwwnuGQNC831UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_02,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290044

Hi,

On 1/28/2024 9:13 AM, Bjorn Andersson wrote:
> On Fri, Jan 19, 2024 at 01:56:54PM +0530, Maulik Shah wrote:

>>
>> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> The s-o-b chain doesn't look right.

I will fix in v3.

> 
>> ---
>>   
>> +#define ACCL_TYPE(addr)			FIELD_GET(GENMASK(19, 16), addr)
> 
> Command DB is there so we don't have to make assumptions about the
> addresses of resources. As such, I dislike this define.

sure i will consider querying command db for resource type.

> 
>> +#define VREG_ADDR(addr)			FIELD_GET(GENMASK(19, 4), addr)
>> +
>> +enum {
>> +	HW_ACCL_CLK = 0x3,
>> +	HW_ACCL_VREG,
>> +	HW_ACCL_BUS,
> 
> We already define these in the kernel, but with different names:
> CMD_DB_HW_ARC, CMD_DB_HW_VRM, CMD_DB_HW_BCM. I see no reason to use
> different names for the same thing.
> 
>> +};

Right, I missed it, With querying cmd-db would not need this enum.

>> +
>>   /*
>>    * Here's a high level overview of how all the registers in RPMH work
>>    * together:
>> @@ -557,7 +568,15 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>>   		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>>   			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
>>   			for (k = 0; k < msg->num_cmds; k++) {
>> -				if (addr == msg->cmds[k].addr)
>> +				/*
>> +				 * Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte
>> +				 * aligned addresses associated with it. Ignore the offset to check
>> +				 * for in-flight VREG requests.
>> +				 */
>> +				if (ACCL_TYPE(msg->cmds[k].addr) == HW_ACCL_VREG &&
>> +				    VREG_ADDR(msg->cmds[k].addr) == VREG_ADDR(addr))
> 
> I'm sure this work, at least for some targets, but I don't fancy
> encoding this information here. It feels like a hack.
> 
> Furthermore, I really would like TP_printk() of trace_rpmh_send_msg() to
> be able to resolve the symbolic names for VRMs as well, and it would
> need the same information...

I can update in separate patch for trace_() to resolve symbolic names.

> 
> Please consider how we can query command db for the type and/or grouping
> information.

Sure, i will update in v3 to query command db for the type.

Thanks,
Maulik

