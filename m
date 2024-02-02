Return-Path: <linux-kernel+bounces-49274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCEF84681C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF0A288C5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534617567;
	Fri,  2 Feb 2024 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hiK/WfK/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FE1754C;
	Fri,  2 Feb 2024 06:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706855880; cv=none; b=W4JuJzvzFdTWTTjCYO6mb8xYVBCYEZqxyHQXewIDAYrtIwtXrdmPn4Z/Ii/fl7A7ykp94lzAxt/zfXtz5DqDQxsSxvEygm2yelV9nQUF5+bespEzjD5FyJW0jtAlH/dkPXsvw3Mz4MeTYf2qc8zOS21+ar4e2GhO6bUR7hZL268=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706855880; c=relaxed/simple;
	bh=NO6aRY+5svoJRq0NRwfuCjWU+uL1flZP5X/b/oDognI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kpuBxTaMao1/rrKGDD62EUKDG0ysdtwho3lcJNS9whwfKwsn8Oe9bsASJrbC/RSnLIPna+5CL6Qtqkm/FDscPPg2Rt0j/gNnlPONKDgUuMJqTw4R6cB7Pzkl9taP2t7h0InoRvFiV78KY9/uMdDn3+s3C6m5V0iwxPpPxghUba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hiK/WfK/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124KV5X024187;
	Fri, 2 Feb 2024 06:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SzXomCEIOJEr4Pg8l4u035/JwBQ6qeb4zNLDT4xhp7E=; b=hi
	K/WfK/ppmCF69GMfuKKack8sTqETfSZZCUjFtz6kCi/njhAX45nhRXpRB7mLgV54
	cYjPToF3dollC/euxPw8MJPgrWDFTRb4O3zUJAhjpN5ykC4XREZuTiGM0IR99HtS
	rxOyo27SUmDARPj2RmlIdF49Qz2kejTb9iHxpLlVO1sz1sOMO3cjPWsAzItWi6qv
	BQsOQC9qU5AfaIErDUw+ESdhtR/d5BwCmf7ckmDZtyPK9dyluJ4Gxru1EHXfR1im
	49KWR6IyXwyyG5XWz4XtzhP8GrheVSEojU9zmLhdAOvENUBFIIG589HqRY3O6L0l
	DEUOiFU/Fx8JDfJnusUQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1rn7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:37:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126bH9G007730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:37:17 GMT
Received: from [10.214.18.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 1 Feb
 2024 22:37:16 -0800
Message-ID: <b643ff62-27be-437f-821f-7ae366f167d9@quicinc.com>
Date: Fri, 2 Feb 2024 12:07:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: mdt_loader: Add Upperbounds check for program
 header access
To: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240131094253.20384-1-quic_audityab@quicinc.com>
 <5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org>
Content-Language: en-US
From: Auditya Bhattaram <quic_audityab@quicinc.com>
In-Reply-To: <5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Oq2nZImckSnpdh0PX4T2FlcoVKEbe0re
X-Proofpoint-ORIG-GUID: Oq2nZImckSnpdh0PX4T2FlcoVKEbe0re
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=958 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047



On 2/1/2024 8:20 PM, Konrad Dybcio wrote:
> On 31.01.2024 10:42, Auditya Bhattaram wrote:
>> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
>> is found. Add an upperbound check to phdrs to access within elf size.
>>
>> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
>> ---
> 
> Could you print an error when this happens? There's a lot of EINVALs
> in the MDT loader codepaths, but you never know which one fired..
> 
> Konrad

Sure, will add error prints

