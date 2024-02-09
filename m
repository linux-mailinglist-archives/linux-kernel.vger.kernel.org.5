Return-Path: <linux-kernel+bounces-59926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8788984FD6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF901F24C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EED91272BD;
	Fri,  9 Feb 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q0bPlVgL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D98612E;
	Fri,  9 Feb 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707509877; cv=none; b=EZioHG73FBfx1whB6y4tBDvbdas25FPDYgZUpZJG2GPN5/04yQA4rECe1qHYviRiRzOx6ebP7P1uHSucO7YsK0metAu3kVRhWSPpihHoXkjuPCsubN2+ydGts+EtwKRC2m6QWF1XSI1mJe80DRz001SXAWlzVsrZTlmkwcVPhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707509877; c=relaxed/simple;
	bh=+/17/Db5shJjnPhbTOpDSpi82+ZeQT5HopLWnhvUjJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eERugvmyTxC36L66wrqQ+HzcSYL3JdribIv2aOvTBfpoowV6jDzv13PtmCsgjQyeLETfV402yBsG0+Lc1GWxpOjVBjqTqJISHCKCxK/H+3YR+KI29Ebda750nbS1UM2OZQcaC9goMACRXoG51YUUvuVA+gq14dY8Ou56NNU0Spw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q0bPlVgL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419HPEcx028228;
	Fri, 9 Feb 2024 20:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DyZ0r0Lg0UTbWRFEP73ovi8ryhS6b6PAgg6sp6Ed11c=; b=Q0
	bPlVgL2EMWqwq0wWrmZ1VhOaE6o1QZ//a5Q/Z/8cM+Rbi8lsxlKe3TcVJIu65BxP
	sK/QgWZQJIeBp17iUzCSpWt2ZSks5sm5IqXSkaeD2NCwC4dbB+53cPss8U6gkpp8
	YFBy/hVqjmBobNjMnAe2UWZF+wkS4U9fMVxKOWVOmpnGoYnc1zAwPZ6ImIYwJowS
	GQBQHxeKZV+1hpmfKITTiqXLbbsg9sG4kZlX2UfObbqys6p3dwXra//JjETG6DN6
	zsfdN0mFM8w4R9zlthxb1+v2D00VL1ziK8vhXqn4YPTCBpEhbTQlmwUWNXBKb/Aj
	u+bV3EWmt5cpyQkiIEWQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4rk84yr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 20:17:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419KHHBc030175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 20:17:17 GMT
Received: from [10.110.93.252] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 12:17:16 -0800
Message-ID: <4468011b-11df-1f4a-63cf-45a4c3b27c80@quicinc.com>
Date: Fri, 9 Feb 2024 12:16:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v14 01/53] xhci: fix possible null pointer dereference at
 secondary interrupter removal
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <20240208231406.27397-2-quic_wcheng@quicinc.com>
 <2024020931-unelected-scribble-50f4@gregkh>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <2024020931-unelected-scribble-50f4@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: prGZxwGmsmmYeBpoiaBaCIrcHnl6Y4eg
X-Proofpoint-ORIG-GUID: prGZxwGmsmmYeBpoiaBaCIrcHnl6Y4eg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090146

Hi Greg,

On 2/9/2024 2:22 AM, Greg KH wrote:
> On Thu, Feb 08, 2024 at 03:13:14PM -0800, Wesley Cheng wrote:
>> From: Mathias Nyman <mathias.nyman@linux.intel.com>
>>
>> Don't try to remove a secondary interrupter that is known to be invalid.
>> Also check if the interrupter is valid inside the spinlock that protects
>> the array of interrupters.
>>
>> Found by smatch static checker
>>
>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>> Closes: https://lore.kernel.org/linux-usb/ffaa0a1b-5984-4a1f-bfd3-9184630a97b9@moroto.mountain/
>> Fixes: c99b38c41234 ("xhci: add support to allocate several interrupters")
>> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
>> Link: https://lore.kernel.org/r/20240125152737.2983959-2-mathias.nyman@linux.intel.com
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Wait, this is already in my tree, right?  Why keep sending it?
> 

Sorry, I noticed this yesterday night as well when I was preparing some 
changes to push elsewhere.  Will remove the ones I saw that were already 
present on usb-next.

Thanks
Wesley Cheng

