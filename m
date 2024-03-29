Return-Path: <linux-kernel+bounces-124244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05FC689144C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5F3628758C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E737446C9;
	Fri, 29 Mar 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KorUyFD7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F43FBBC;
	Fri, 29 Mar 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697156; cv=none; b=le2zLKfqJF6Xkmbm6Prg1J15hyD/43ECTyFOlYml3IFbP4BDYh8a0OBzhRZxK51Swa/Gu7dg7mcsJ812+EPwrjl0HWX3XPUTfLezM3fJRU7oYm3FySLofQwzw5VNS65gynSe7/RVwkN5c6lqSAFuEBNsYejf+IG4khcfanVOp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697156; c=relaxed/simple;
	bh=KIvMNu9WkvQCofweVAwnulcFxwRN34Ifb8Ui/THsKiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H9HoCjbMj+ymaK4/1p3YydB8/sgHknzioO9lkA12Sf/hAUOkheJIg+WtCI/aGnPH9lgaqKbatK5JNeBTiFYiekDtfLKOIpsYNXiRJqyXeEjwkMmLbACkItuCobHPsOxv3pcUSpjJeSUR6XaXNrfzGpQcGoUCFzb+o0Yay9kUugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KorUyFD7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T5Oxx7005595;
	Fri, 29 Mar 2024 07:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=VwtuCx9Ufi24zRIKC72QCsInTwX8ii5rSOdpOxqX2IM=; b=Ko
	rUyFD7gjzxZO1x3O+Y9QJ+7IYsSlInk+VG+uP1Rj4tslboz9Bnuy1xHjxsaz/Rte
	o96qQjdWfpYrGiu53P+Ox6eJN1x7M/gBRMtDZwyAm21k/InoFjoie1H8y5NtRbHW
	9BaB7qVBQOhkZzqd6NbeD0F1xxEfpyyDhHXZtDhdJDVHqd/btGYghzj9vO+vsqXi
	LFsAt1p9Mw87oYrgn4M8MQLSQ/nkyzIvQJ7ODXICBe0lnGRc//fJABJulXTua8SW
	+UhSsfXVgNlDhs0RFphHfwd5J36VOFxK/+OdpS17aIupVfh2vfslLWYzhkm0znwX
	bNLBjAy8+GV1+7QIqNaQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aquj33f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:25:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T7Ploa011843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:25:47 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 00:25:43 -0700
Message-ID: <c03abbbd-faa5-4fdc-b7c3-5554a90c3419@quicinc.com>
Date: Fri, 29 Mar 2024 12:55:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
To: Johan Hovold <johan@kernel.org>
CC: <patchwork-bot+bluetooth@kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>, <luiz.dentz@gmail.com>,
        <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <quic_mohamull@quicinc.com>, <quic_hbandi@quicinc.com>
References: <20240314084412.1127-1-johan+linaro@kernel.org>
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
 <124a7d54-5a18-4be7-9a76-a12017f6cce5@quicinc.com>
 <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <ZgWLeo5KSLurLDhK@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n7zlYDUH6iL-6q2llIRA2Ne01Ovvu-fw
X-Proofpoint-GUID: n7zlYDUH6iL-6q2llIRA2Ne01Ovvu-fw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1011 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290062



On 3/28/2024 8:53 PM, Johan Hovold wrote:
Hi Johan,
Thanks for the valuable inputs.
> [ Please wrap your emails at 72 columns or so. ]
>

Noted.

> On Thu, Mar 28, 2024 at 08:25:16PM +0530, Janaki Ramaiah Thota wrote:
>> We made this change to configure the device which supports persistent
>> memory for the BD-Address
> 
> Can you say something more about which devices support persistent
> storage for the address? Is that all or just some of the chip variants?
> 

Most of the devices support persistent storage, and bd-address storage
is chosen based on the OEM and Target.

>> So to make device functional in both scenarios we are adding a new
>> property in dts file to distinguish persistent and non-persistent
>> support of BD Address and set HCI_QUIRK_USE_BDADDR_PROPERTY bit
>> accordingly
> 
> Depending on the answer to my questions above, you may be able to infer
> this from the compatible string and/or you can read out the address from
> the device and only set the quirk if it's set to the default address.
> 
> You should not need to add a new property for this.
> 
> Johan

As per my understanding, altering the compatible string may cause duplicate
configuration, right ?

Thanks,
JanakiRam

  


