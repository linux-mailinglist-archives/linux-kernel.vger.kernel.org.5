Return-Path: <linux-kernel+bounces-60126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AF3850028
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E64E284F3E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4928370;
	Fri,  9 Feb 2024 22:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jxahf/z6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD31E4AD
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518414; cv=none; b=QzQAcqranLNqFeO4c1NS0YYwObvX7OkpWFNj0h9CMKWi1QxYj2BB1ojOKC51p6jpR9lycOc42YF0rM5aNXthauPDdvKTALczr3O9le8mzxVVnuryozI7nnStwYVLycYx3xaclM5G/jHNAzJ5ECBNgi8ICnpSNa7PiHQrrP8+EU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518414; c=relaxed/simple;
	bh=6j+LVFkEKihPX4DewYRiGQc5v6xpaxu/+qjohBVCTQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apUpTTXZjYOj/BntjKklzi/XJPEn9kWlNdjSO98teiFovJJhEDj0YuWP+x2gvzQ67pxEpkEelxDGHEyLhALsBCd9Iq+Qoiz06wqhJDNGUWud4Z5/UAVaQ9kcrbUz3GGYpC/WWzAUs3FcKwjcGQkNKGNjyVZR/mju5COwl17iWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jxahf/z6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 419LvH9k006347;
	Fri, 9 Feb 2024 22:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6j+LVFkEKihPX4DewYRiGQc5v6xpaxu/+qjohBVCTQo=;
 b=jxahf/z6pUFetP3uU4Q42iWsI9bOBIidbVsdq81/7aBbEaLfiCMRp+hgkzXskEUOgpoK
 E+C12mltWGtpB4wDiW6A8sm21zgXhdU86alqLPmw3XrHkZmh7t1MUiRxKLTEax6dUU3v
 +YI2JNrBDmqdGpHI2F/sVF68cmSCzkDMclFq/KI+Wgu6zFFfpTKYZN7ykG3+jJ7czCoL
 WsWdm4V6mcZa749GaUhXw/nFFo6aJqTxdakO5KUcR8uuX4fpRoakCR9v5+qk7V1kQ5FL
 x5320qk8t2KzAijgoE3HKC2sViIejMmxdegOp6Rxv2ztWq4p+zf/FqGfelHvpAw9NfBJ Qw== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5vdqgx3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 22:39:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 419JpGC8005756;
	Fri, 9 Feb 2024 22:39:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w21am5t35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 22:39:51 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419Mdnbx6226616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 22:39:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE644581B8;
	Fri,  9 Feb 2024 22:39:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C160A581B0;
	Fri,  9 Feb 2024 22:39:48 +0000 (GMT)
Received: from [9.61.164.98] (unknown [9.61.164.98])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Feb 2024 22:39:48 +0000 (GMT)
Message-ID: <09d32259-ee80-4a52-aaac-eedb7589ab1e@linux.ibm.com>
Date: Fri, 9 Feb 2024 16:39:48 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: core: make fsi_bus_type const
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>, linux-fsi@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20240208-bus_cleanup-fsi-v1-1-0f13d4a4f920@marliere.net>
 <2024020948-xerox-exhaust-fb35@gregkh>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <2024020948-xerox-exhaust-fb35@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OgM7eALHKo5MTX74jXD_uHwUnyRlf6lZ
X-Proofpoint-ORIG-GUID: OgM7eALHKo5MTX74jXD_uHwUnyRlf6lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=808 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402090165


On 2/9/24 04:31, Greg Kroah-Hartman wrote:
> On Thu, Feb 08, 2024 at 05:05:29PM -0300, Ricardo B. Marliere wrote:
>> Now that the driver core can properly handle constant struct bus_type,
>> move the fsi_bus_type variable to be a constant structure as well,
>> placing it into read-only memory which can not be modified at runtime.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>


Thanks.

Reviewed-by: Eddie James <eajames@linux.ibm.com>


> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

