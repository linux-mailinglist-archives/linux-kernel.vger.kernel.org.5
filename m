Return-Path: <linux-kernel+bounces-56619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414B784CCBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A69289BBA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DE07E564;
	Wed,  7 Feb 2024 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lI5a/wVj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92657CF24;
	Wed,  7 Feb 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316026; cv=none; b=mvZZZTotqZetveKzdvn8mKX8rFpG+WYNj4+rrkOSgdpq/max1UGbmpJLjPAh/hp2xQu8Wr3xszx37B9WrMf9i8b7P4OUF8KKjo9SROaDxYW7yKCqIZBxuHEIUrHquD5ESrWy0XuAOhrqqnF9odHPEdAtnHSepPdCVwCsqR96a1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316026; c=relaxed/simple;
	bh=2RU6ecwvwpj7XkTwgh+rq7eFoMgidQfwzGpuxMhjwCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cLfYqCzdEhDsyfbp+kmNYxgGQhktnM8YFF1ykZAzTxb//9ZJu+8l9r6bzOUTCsuIrrPnUc/5cA68kdfUe1ke+eZlgF0O2eTn9mInYX7IicRslS5xh41yI8/+nnNnp4be53GQ89SIvtvMDH8joDLuSAbMxN9WM4sKsHSB27wVfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lI5a/wVj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417B9FXi003395;
	Wed, 7 Feb 2024 14:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=56dI8angvNGkFV+K065e/Uxx2IJmqo4mMZ34YBNZr30=; b=lI
	5a/wVjbqCPP96LWur9ehj7i41QxTOGGdQDnEAI1r56P1TZYIp1+ozoVNVePt2g5F
	aWNKF+q8NSF2XTlfZedvV2rVw99j62NRheN14UNtVCOXlFcqRr/gIX2lKClieIMh
	hhf1QkFkkOIblW/06Dj9Z3dWiD7fzU+RTGHxgut5Abnf9lxsNKWsvNUPIAa+FhYw
	73zIFO1Z7Udu2n0dbI4Yz/KpcpkL8644IoJqWYTrmUw22BSw+arV8ZKQ8x36cd8Q
	bqrROU0Xw2zIQNf0ZNMc8pGL209HTPfpF9caHaGthvKqe8K4pMLbeEREwUxZ71DV
	HDOHHbG4jCng+yjmbzEA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w46r80mka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 14:26:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 417EQo2P029635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Feb 2024 14:26:50 GMT
Received: from [10.216.9.205] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 7 Feb
 2024 06:26:47 -0800
Message-ID: <9ba9c4fa-3fa9-c6c4-ce77-0c6cd5e23680@quicinc.com>
Date: Wed, 7 Feb 2024 19:56:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH 1/1] iommu: Avoid races around default domain allocations
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "Robin
 Murphy" <robin.murphy@arm.com>,
        Charan Teja Kalla
	<quic_charante@quicinc.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <e605b38a2d40b1e7589e10110c6d3ece35f6af4e.1705571894.git.quic_nprakash@quicinc.com>
 <139a9abe-75d8-3bda-3ec9-a14a493eb2a9@quicinc.com>
 <20240201162317.GI50608@ziepe.ca>
Content-Language: en-US
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <20240201162317.GI50608@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XS2JtNc24MCAbwrtdj1SJiyuNZV7xRJ9
X-Proofpoint-ORIG-GUID: XS2JtNc24MCAbwrtdj1SJiyuNZV7xRJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=773
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402070107



On 2/1/2024 9:53 PM, Jason Gunthorpe wrote:
> On Mon, Jan 29, 2024 at 01:29:12PM +0530, Nikhil V wrote:
> 
>> Gentle ping to have your valuable feedback. This fix is helping us
>> downstream without which we see a bunch of kernel crashes.
> 
> What are you expecting here? This was fixed in Linus's tree some time
> ago now
> 
> Are you asking for the stable team to put something weird in 6.1? I
> don't think they generally do that?
> 
> Jason


Hi @Jason,

Considering that the issue is reported on 6.1, which is an __LTS 
kernel__, any suggestion to fix this issue cleanly would help us a lot. 
Right thing here would have been propagating the changes from 6.6 (like 
for any stability issue), but considering the intrusiveness of them, is 
it even possible?

Just to be open about reproducibility of the issue, a bunch of them are 
reported, both internally and by customers.

Thanks
Nikhil V

