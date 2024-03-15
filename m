Return-Path: <linux-kernel+bounces-104536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC9687CF64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DA0281C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8715A3FB32;
	Fri, 15 Mar 2024 14:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RZMhk+ah"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F31E86A;
	Fri, 15 Mar 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513996; cv=none; b=SHWIrwGOE7muY2D6nKwvAASUAPpPd+EcjY+/pQIkm/uFTSIyWmRBQCjCXLYrxzalZifE8NiEDd9maDE9bKgUAHbn3M6o/d5wG90dMJFycFgSvhmFtoww5qJQTowhbNqu28sBPaEPJsYCufLgly1sbahRgq57owdyqX/Cy7gRSzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513996; c=relaxed/simple;
	bh=2OC9SsMETMwmKRWPH18JYnxB66dCu1KF9aOCh6FNqog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSnsMIw3yAez0Dv4wB2/ZB2N2aWUlh69T9sdU+hEObm5rm6N40Gx/1LuPl8+/8olPtZGuEwS7TWND3SA15QHIHfTI5+PkBwSGeUXyiXdytGZ/PdT4tDc++ryZ+fJ19SusjzwkhKF+EqtxKCNIT6/OnogeXm7z/IbQtHQqgSGCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RZMhk+ah; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FEOClQ025650;
	Fri, 15 Mar 2024 14:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rPMUA5RtrQ+BR1Xr4kcuIPeEbPzpQvuuy/C4aihL9DM=;
 b=RZMhk+ah9tHYjDu/zZfXXQjUeMWMFOIW8AP6+emqkPX6IJmKw8CW91QJbcGZOf+2x92E
 oMkg2vqHwx3UBZk85oEQmHd/WRWNbF7hEt49cd/BfywiiETcVgMW3libgJDCwoBgv5iu
 VNItc5UWd7ohxyyA9Qe7jGpTFkSQFWpzXU8VWow4I4WoOMbqRzwY8hIRwXh/y1kSuRFO
 cHcV0sdK47VcmAWM/K3OTV/7emsr+OftedqJpIIwzO3CY1X80CraW4yqczFxY3DUE5Mu
 p6Q/K4U+bgIp5t5O0dX+ZXWg9IyYm775TsON7owPkw+Og2W4OoegogXFABf774lRvP7o OA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvqnarmr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:46:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FDl6Fe015028;
	Fri, 15 Mar 2024 14:46:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws33pcdse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 14:46:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FEkT2N23396880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 14:46:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0E4F5805E;
	Fri, 15 Mar 2024 14:46:28 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0BB58056;
	Fri, 15 Mar 2024 14:46:28 +0000 (GMT)
Received: from [9.61.180.144] (unknown [9.61.180.144])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 14:46:28 +0000 (GMT)
Message-ID: <f958624b-5f26-4088-8a26-87aaa5cdf5b9@linux.ibm.com>
Date: Fri, 15 Mar 2024 10:46:28 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] docs: Update s390 vfio-ap doc for ap_config sysfs
 attribute
Content-Language: en-US
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240313205807.30554-1-jjherne@linux.ibm.com>
 <20240313205807.30554-6-jjherne@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20240313205807.30554-6-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jb2Ix2YJn2hWARwHrcZqHewzULk_OPBY
X-Proofpoint-ORIG-GUID: Jb2Ix2YJn2hWARwHrcZqHewzULk_OPBY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_02,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403150119

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

On 3/13/24 4:58 PM, Jason J. Herne wrote:
> A new sysfs attribute, ap_config, for the vfio_ap driver is
> documented.
>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>   Documentation/arch/s390/vfio-ap.rst | 30 +++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
> index 929ee1c1c940..6056a50ee841 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst
> @@ -380,6 +380,36 @@ matrix device.
>       control_domains:
>         A read-only file for displaying the control domain numbers assigned to the
>         vfio_ap mediated device.
> +    ap_config:
> +        A read/write file that, when written to, allows all three of the
> +        vfio_ap mediated device's ap matrix masks to be replaced in one shot.
> +        Three masks are given, one for adapters, one for domains, and one for
> +        control domains. If the given state cannot be set then no changes are
> +        made to the vfio-ap mediated device.
> +
> +        The format of the data written to ap_config is as follows:
> +        {amask},{dmask},{cmask}\n
> +
> +        \n is a newline character.
> +
> +        amask, dmask, and cmask are masks identifying which adapters, domains,
> +        and control domains should be assigned to the mediated device.
> +
> +        The format of a mask is as follows:
> +        0xNN..NN
> +
> +        Where NN..NN is 64 hexadecimal characters representing a 256-bit value.
> +        The leftmost (highest order) bit represents adapter/domain 0.
> +
> +        For an example set of masks that represent your mdev's current
> +        configuration, simply cat ap_config.
> +
> +        Setting an adapter or domain number greater than the maximum allowed for
> +        the system will result in an error.
> +
> +        This attribute is intended to be used by automation. End users would be
> +        better served using the respective assign/unassign attributes for
> +        adapters, domains, and control domains.
>   
>   * functions:
>   

