Return-Path: <linux-kernel+bounces-142651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0C88A2E51
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB0A1C228E0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29B5786D;
	Fri, 12 Apr 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kw7pa1wE"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592356B64;
	Fri, 12 Apr 2024 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712924993; cv=none; b=U0tQhA1zUnfls4B61OJGK9nvt4uBP9uD6kqjHrljNa4kqUzJ0etVCL/ToxqoH/p5hds8Di43ms6fXDSyrcfYrG7j77QjHCIUwfm1XJw5KyTNs47issfs/ieK3tjUZWQPSrzn5c4VBOqZp6JOLnuBRGJVNEOthfJk7dVCBM5llZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712924993; c=relaxed/simple;
	bh=8h9T0GeTP+vOniNfikiPnfgeGCG1dXcgA4/FtwLyHHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzIzyUEHIHg6ftM73eRyBhiGCMguokWP+v2V1oDTYpkHBIzVpsdJMuYmI6w+dfLy8HplFYcca+7+lJlQTK2biI66C7MkmR6zwrDyYE+qFi03wZ8GloLZ4vrQAdIVct0AXUdIf18F4E+X0Cal19rcydycAMiq3PzU3vBAmcyuF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kw7pa1wE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CC84Or028944;
	Fri, 12 Apr 2024 12:29:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IzaZDBYAW7Ds3k8XifIiNUwmHPCzZYo380zBubpNgSM=;
 b=Kw7pa1wEaLM3LwE0CjUh87mzrGs6+uK+K6hFBJMI5xhltzlxZLvfASU3lFEFCVmQvfVE
 6Nr/sgW9Nvb3VhhjoJvnd5iwP+1LQTmtbJniAmGFK/EVqHEXDTs4eYD6dYRFqQqImUtH
 F3eJIceu7Zv6dCPowXpFJR7MqEW58BjyAhgIu1tcPkJGSDRlMTWxCDw0iUg4yYyC74m9
 jlCqy3Oa9QP3CH9Q4Q7jztflKmEurFW9Yd4i1mA30TaSeJ92WV911Qa13j30ZkyhAP7R
 ijDHq3rLOryBQSCjK0ahEsJwONmBdi7Z/7CHoq+RTOl0iWjisqI7LD0MfP2Fj3/4ZEUm BA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf4pg81pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 12:29:49 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CAm3lK022560;
	Fri, 12 Apr 2024 12:29:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqphsxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 12:29:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CCTjiA44171622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 12:29:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C80AD58055;
	Fri, 12 Apr 2024 12:29:45 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 351B05805D;
	Fri, 12 Apr 2024 12:29:45 +0000 (GMT)
Received: from [9.61.20.106] (unknown [9.61.20.106])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 12:29:45 +0000 (GMT)
Message-ID: <95b551f1-7599-96e1-b528-0701465baf5a@linux.ibm.com>
Date: Fri, 12 Apr 2024 08:29:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 4/5] s390/vfio-ap: Add write support to sysfs attr
 ap_config
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20240326164706.29167-1-jjherne@linux.ibm.com>
 <20240326164706.29167-5-jjherne@linux.ibm.com>
 <ZhP9qHs6tjPbh1/J@tuxmaker.boeblingen.de.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <ZhP9qHs6tjPbh1/J@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6gq9dZi1pChz8kaAM-SzDB43pCdY3NJu
X-Proofpoint-ORIG-GUID: 6gq9dZi1pChz8kaAM-SzDB43pCdY3NJu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404120090

On 4/8/24 10:22 AM, Alexander Gordeev wrote:
> On Tue, Mar 26, 2024 at 12:47:05PM -0400, Jason J. Herne wrote:
> 
> Hi Jason,
> 
> This series still has some issues.
> 
>> +	newbuf = rest = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
> 
> This line triggers a checkpatch warning. Would it make sense
> to turn it into below instead?
> 
> 	newbuf = kstrndup(buf, AP_CONFIG_STRLEN, GFP_KERNEL);
>> +	if (!newbuf)
>> +		return -ENOMEM;
> 	rest = newbuf;

Yes, I can make that change. My checkpatch.pl script does not point this
issue out with --strict. Should I be running checkpatch with --strict?

> Also, please address other checkpatch suggestions.
> 

Yep, I'll run with --strict and address everything.

>> +	/* Save old state */
>> +	/* The volatile cast here is to work around a gcc false positive
>> +	 * Wstringop-overread-warning.
>> +	 */
>> +	ap_matrix_copy(&m_old, (*(struct ap_matrix * volatile *)(&matrix_mdev->matrix)));
> 
> Could you please come up with a different workaround? This issue has already
> been resolved in the past in different ways. See commit 34186b48d29b ("ARM:
> sharpsl_param: work around -Wstringop-overread warning") for example.

Sure, I like this solution way better than using volatile. Thanks for
providing the pointer to this.

