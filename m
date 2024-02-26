Return-Path: <linux-kernel+bounces-81223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F138673AE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87FB1B370DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3441CFA0;
	Mon, 26 Feb 2024 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W7cQKTeY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131DB1CD20
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944748; cv=none; b=rkIhWaooABSpjaax2D37/b9mcJgA2fn2zd6G+qAfUes53qkFdW9hPMAQh4nlcOIct1U8bxQ+/wn819VyJB5hITGs29eWiYq4L/MCfeYyqy2hEkvtppJCtDUWiabKwngDp4oEbaGy8tafcfTUPGZJzF32Q/shSbeExJJr4dkylSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944748; c=relaxed/simple;
	bh=c2O6WDeP39XIZazWyx1wY6XcxEQhb4xcHnEnf5E886M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=chUAOGSWDJQs8s32JB17jIaC7A6SKhrhO+6WObIOt7GAnXYUP53bCpWQ2JkhitAtBdx/fRjZB7DMKi2o+Ake6CBiQAa4ucEeSakSpE/UV0UZlCcwrSKddaUiaj66AFEzipz9SLeFfVVY8TmVo0z2pZSLk7tMi/S/TDdKQ3/C3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W7cQKTeY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q8sQa8030056;
	Mon, 26 Feb 2024 10:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tSxTylspEkmta+cjGIRyssujpelcjhz64guZWj8zSXA=; b=W7
	cQKTeYk7gudTUnhseXNBIZ4UhieYnX2h7Ct3G4N+LfO3lMi/kIhfF8Yb1kTpE9ZS
	wZILKh1Qc1EC0rd1b7oeC1EItPOZr+O7PQLYReevdKFGPlhQusMhTXvCIyPfB9hl
	4La7b4aj4scjXRND0+rTmUTgUPuYxI7Dz0D3LevQNuw8dsms+eGYeISBi2Oihf1A
	orVo+Nl0JN0gbDWHv6WbTCYpVm5L6sJ9Eqw+iWwkFLNlnPUpiYBMYijb/TvXf3k8
	/BUHpG96mS3uXfxbiDUeMUy22DbMuG2CQjQxEflkLmYHwAZccrJDg/b8IL61+Pkt
	qW6BtOReSFyqmprMmayQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq0nrf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:52:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QAqEkh001408
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 10:52:14 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 02:52:12 -0800
Message-ID: <ed9f2b75-38d3-8562-0476-2200e201d4c9@quicinc.com>
Date: Mon, 26 Feb 2024 16:22:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH vRFC 3/8] treewide: rename firmware_request_platform()
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>
CC: <russ.weight@linux.dev>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <cocci@systeme.lip6.fr>
References: <20240222180033.23775-1-quic_mojha@quicinc.com>
 <20240222180033.23775-4-quic_mojha@quicinc.com>
 <2024022347-ribcage-clench-37c4@gregkh>
 <Zdi2odoYPBWywOXn@bombadil.infradead.org>
 <2024022323-accustom-eradicate-8af4@gregkh>
 <Zdj1K28NBfGfSJ-0@bombadil.infradead.org>
 <2024022452-unwilling-pancake-3b2a@gregkh>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <2024022452-unwilling-pancake-3b2a@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kPn3zhOb-JH6bxccqXXZAzVAWZqKUM-l
X-Proofpoint-GUID: kPn3zhOb-JH6bxccqXXZAzVAWZqKUM-l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=952 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260082



On 2/24/2024 11:06 AM, Greg KH wrote:
> On Fri, Feb 23, 2024 at 11:42:35AM -0800, Luis Chamberlain wrote:
>> On Fri, Feb 23, 2024 at 04:33:40PM +0100, Greg KH wrote:
>>> On Fri, Feb 23, 2024 at 07:15:45AM -0800, Luis Chamberlain wrote:
>>>> On Fri, Feb 23, 2024 at 07:21:31AM +0100, Greg KH wrote:
>>>>> On Thu, Feb 22, 2024 at 11:30:28PM +0530, Mukesh Ojha wrote:
>>>>>> Rename firmware_request_platform() to request_firmware_platform()
>>>>>> to be more concrete and align with the name of other request
>>>>>> firmware family functions.
>>>>>
>>>>> Sorry, but no, it should be "noun_verb" for public functions.
>>>>
>>>> News to me, do we have this documented somewhere?
>>>
>>> Not really, but searching makes it nicer.
>>>
>>> And yes, I violated this in the past in places, and have regretted it...
>>
>> Care to share a few examples of regret?
> 
> 	get_device()
> 	put_device()
> 	kill_device()
> 
> vs. a saner:
> 	kobject_get()
> 	kobject_put()
> 	kobject_del()
> 
> Learn from the mistakes of my youth please :)

Thanks for the history.,
In that case, should we fix this verb_noun cases ?

request_firmware()
request_firmware_into_buf()
request_firmware_nowarn()
request_firmware_direct()
request_firmware_cache()
request_partial_firmware_into_buf()
release_firmware()

-Mukesh

> 
> thanks,
> 
> greg k-h

