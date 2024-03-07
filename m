Return-Path: <linux-kernel+bounces-95785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BAC875293
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8410A1C232DF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B012EBCC;
	Thu,  7 Mar 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iKjuyOrZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0812D754;
	Thu,  7 Mar 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823703; cv=none; b=hhlWKob9Q8MvR4/qKBnQdgJ5P80Bd/3ZCPdA5mL1q8lc9KvpDKWX7f3FayhIZkov0GCdsDIG5zTwKdIIpTp48SsmzV5CDL25TiSxTP57wk8ZVLY6XnOUvOEUXwsqidycCvmnd8Qz/9KHj7XYXRsPcTVHo5z6Jte17XgytLlr44M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823703; c=relaxed/simple;
	bh=eNFxKcWlEdHQbJlCDhgLyCDMNEl0/5OPCQ3E9Gp/e7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv9ejwsSUEuf8kA2qEnAXyLi+AspATzqIOSge5lBeXn+dGie6F6+TQ4D19KZ53SovueVR33IobJcnw59ETEvHutCRKz8Acst8jHXLDB0Q/4L4Jrc9vdaBmUCEDtCn54d7EoN4kGABTx2rx6/K2yE8sBJVIA9zVJ3rcIYEWWXBLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iKjuyOrZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 427EhKq9004082;
	Thu, 7 Mar 2024 15:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=INNS7wXY+uyGYWsmpIcvwWMcJdOC94K2KLNkCD8oXrw=;
 b=iKjuyOrZKMPHy2SF+lj9F/lmlcc6wGtxI0ycOrUXbPhxvo2QviUOEh6nO2wFQc0TYwX8
 JXqnzuIsAaN9wqvUYnN7ADJzYDwlPejigzgf+xNXFzBqa1kJxkdQATBrho3gZhQe7A9f
 oa+K7yu94VYC7tzzqmENMzwN0S8Mbjsqs592UnH3AOhJ6zcM1Gixpv/9j5BzX8OOwvY8
 ugdB9lJvPqOWylDPoaVl/nphLBYg300PchNfUiY3JdbEU4ZUF5W+HdAVoViFpBmt877b
 c33MDOx//7i/9j3QJVEAMzK2Y4tlaCDGTQdCRqQwv9NECNfZamwM+c0eWRPvd1umlABx Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqfdkhmw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:01:20 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 427EX8eu019521;
	Thu, 7 Mar 2024 15:01:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqfdkhm9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:01:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 427CLCic006046;
	Thu, 7 Mar 2024 15:00:58 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmeetegms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 15:00:58 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 427F0s7017498850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Mar 2024 15:00:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F36058064;
	Thu,  7 Mar 2024 15:00:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C712C5806F;
	Thu,  7 Mar 2024 15:00:53 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Mar 2024 15:00:53 +0000 (GMT)
Message-ID: <90a14b5f-6976-4941-a623-ae31dfa33899@linux.ibm.com>
Date: Thu, 7 Mar 2024 10:00:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tpm: of: If available Use linux,sml-log to get the
 log and its size
Content-Language: en-US
To: Michael Ellerman <mpe@ellerman.id.au>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, rnsastry@linux.ibm.com,
        peterhuewe@gmx.de, viparash@in.ibm.com
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <20240306155511.974517-3-stefanb@linux.ibm.com> <87h6hinwzw.fsf@mail.lhotse>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <87h6hinwzw.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Gv38LkoCS3PkLxRFplGlkVvN24IeWssB
X-Proofpoint-ORIG-GUID: GqBNiazuMisAY30rZktBh8dnkqQY6ci-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=917 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2403070087



On 3/7/24 05:42, Michael Ellerman wrote:
> Stefan Berger <stefanb@linux.ibm.com> writes:
>> If linux,sml-log is available use it to get the TPM log rather than the
>> pointer found in linux,sml-base. This resolves an issue on PowerVM and KVM
>> on Power where after a kexec the memory pointed to by linux,sml-base may
>> have been corrupted. Also, linux,sml-log has replaced linux,sml-base and
>> linux,sml-size on these two platforms.
> 
> It would be good to mention that powernv platforms (sometimes called
> Open Power or bare metal) still use linux,sml-base/size, via skiboot.

Will do in v2.

