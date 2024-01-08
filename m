Return-Path: <linux-kernel+bounces-19083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E5C8267A3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4993A1C217E3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E039A4C8C;
	Mon,  8 Jan 2024 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nVN9p1fv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFA10FF;
	Mon,  8 Jan 2024 04:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4084dYRd001533;
	Mon, 8 Jan 2024 04:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=wn0KpzyETGzgK82KXrmO0siRS+V7lvyHUVEVDqjKIJE=; b=nV
	N9p1fvjUkKSEx0C/Nq/H9h0mImY0D6aTlxzEHASQ95zoMjWt1TVrvcMEJFkK3j0w
	m/ZFLK+0p/Mhm2/ev4pkRrV+Eo30+cqbFFYNnhGVsCWorheWNwGVtsPAjx3/6LC5
	xhb+Hs7i2OIwVG7k7PBmBJci1iCQp28vQL1iwK7eo7+i4+l++NWJdZ2JYRVZygDW
	odTsxC7kXba6WEDFmQ8q0cpA2KHMSSYL5UZ5toXuYZQzBkSxZVyqtzWbBspJbIFt
	Z7pTT6pMIwdEVMwO7XYpyvp0EDKh5QHbfzVQHZ3buyzEjqTZd8Gfz08G7iCQW2QO
	yBIfwqQBU8UkqOS3QVqQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vg8nwr61x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 04:50:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4084on8R012621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 04:50:49 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 7 Jan
 2024 20:50:47 -0800
Message-ID: <7cebe5e1-4ac1-4c3d-a2f8-b283cde82105@quicinc.com>
Date: Mon, 8 Jan 2024 10:20:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Udipto Goswami <quic_ugoswami@quicinc.com>
Subject: Re: [PATCH] usb: core: Prevent null pointer dereference in
 update_port_device_state
To: Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240104102616.20120-1-quic_ugoswami@quicinc.com>
 <2024010447-sprite-shelter-0743@gregkh>
 <eade09eb-4454-460f-9ce6-87da986c5acf@quicinc.com>
 <2024010432-fifth-shakable-0d84@gregkh>
 <1fafda18-8806-4036-bcc1-ac08e2d3b9cd@rowland.harvard.edu>
Content-Language: en-US
In-Reply-To: <1fafda18-8806-4036-bcc1-ac08e2d3b9cd@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SOpyAHagGmRSPVRBfoZjz2s6w0EHiRGJ
X-Proofpoint-ORIG-GUID: SOpyAHagGmRSPVRBfoZjz2s6w0EHiRGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=994 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080036

Hi Greg, Alan,

On 1/4/2024 8:26 PM, Alan Stern wrote:
> On Thu, Jan 04, 2024 at 02:13:51PM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Jan 04, 2024 at 06:35:38PM +0530, Udipto Goswami wrote:
>>> Hi Greg,
>>>
>>> On 1/4/2024 4:14 PM, Greg Kroah-Hartman wrote:
>>>> On Thu, Jan 04, 2024 at 03:56:16PM +0530, Udipto Goswami wrote:
>>>>> Currently,the function update_port_device_state gets the usb_hub from
>>>>> udev->parent by calling usb_hub_to_struct_hub.
>>>>> However, in case the actconfig or the maxchild is 0, the usb_hub would
>>>>> be NULL and upon further accessing to get port_dev would result in null
>>>>> pointer dereference.
>>>>
>>>> Is this true for any real (or fake) hardware?
>>>
>>> We saw this in our QCOM hardwares where lvstest.c was calling
>>> get_dev_desc_store:
>>>
>>> 	usb_set_device_state+0x128/0x17c
>>> 	create_lvs_device+0x60/0xf8 [lvstest]
>>> 	get_dev_desc_store+0x94/0x18c [lvstest]
>>> 	dev_attr_store+0x30/0x48
>>>
>>> I think the part of the test procedure is to first unbind the hub driver
>>> which calls hub_disconnect setting the maxchild = 0.
>>
>> Are you sure lvstest is correct here?
By the commit description of lvstest driver this seems to be the procedure:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/drivers/usb/misc/lvstest.c?h=v6.6.9&id=ce21bfe603b3401c258c415456c915634998e133

As you can see it mentions unbind is necessary before further steps 
carried out. Also, since the test was passing before 
update_port_device_state was introduced, wasn't doubting this.

Either way, usb_hub_to_struct_hub() can potentially return NULL not only 
for maxchild == 0, but other cases like actconfig == NULL or hdev == 
NULL as well, so it isn't wise to access the hub in subsequent line.

> 
> This is what happens when people work behind the hub driver's back.  :-(
> 
> If you can't find another way to fix the problem, you should at least
> change the patch to include a comment before the "if (hub)" test,
> explaining why it is necessary.  Otherwise somebody in the future will
> remove the test, because under normal circumstances hub would never be
> NULL here.
Thanks for the review Alan. Sure I'll put a comment here stating the 
necessity of the check for clarity in the next version.

I agree under normal conditions this won't fail for example even in this 
case we unbinded 2-1. Since 1-1 wasn't unbinded that therefore usb1 has 
a maxchild still present.

Thanks,
-Udipto


