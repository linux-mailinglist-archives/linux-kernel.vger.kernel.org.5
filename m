Return-Path: <linux-kernel+bounces-99517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11888878984
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13D92821B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7785C433CC;
	Mon, 11 Mar 2024 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PyrLLxCS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365FCA47;
	Mon, 11 Mar 2024 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189219; cv=none; b=YOPDPwbwOCnCJsIMH3sx5d9ATrsSxadrfWe8NVtzFFqxvtUby3oRqyIW3xeU5DIdaUHzP09V2jXd4cUc1z01a3XXzTJrX8ozwokH8X64HERbghEtZ7ja+QF/7OHI/gymeQxVje1W16MFn3HhieBQ6jpWTHQePoVCI8/XwHly6SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189219; c=relaxed/simple;
	bh=p6NY3TH8C+93105l9cgG/APZLkrvK91XHirdtc2MYlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HK2lV7zETppLJ+xZuOmvRa+FQJbj1Q03kNGPtjMeBA8RBVM7nVVlncysdtgRjKY5woa4YBBv90oNnImshcMqT5G5jFJ807NZakyi+zVO2X/3pN08dWra9R9bd88Jr+pTmPkxvBI3bLUrlEpp5031C6Hc2518mOZZdyhncyQ+h4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PyrLLxCS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BKRknK026132;
	Mon, 11 Mar 2024 20:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sXFr27bQDiRiOge2BNvqQUpm9MexS3FoxPTB1IZaFlE=;
 b=PyrLLxCSSUAQExJl8o+7Er/W6Tmef9K100zzQRCrn++6d2mORuoaha8dvwv+IOA0hhDp
 PqouCRPlOrKB4s5+L2rDFxqknjc4jjhQrXGJ3heieGiL4lcHnR4OCdwtd+XLR6j70tuA
 gCTtS/XGcqTapdQOyXLhT8HrSnFY8U948usCprnl8dexMwK28ZxRtllarEFIVQLHW+5Z
 5wTmwa0Xv/WI1coVSnbDypqZhp10ZZAVOfuwWMOPlBlVb11r83DSeREXjRci0XiDijgt
 RX2xmZf+gYtfnA9+ZIBtO8CpV8uWHAUmv0MrPIy2JRuttMrvBtalDhDwbqGyu0PaH+W4 vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt90x83b5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 20:33:23 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42BKV23Z003321;
	Mon, 11 Mar 2024 20:33:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wt90x83ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 20:33:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42BJhkIC020435;
	Mon, 11 Mar 2024 20:33:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kktr6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 20:33:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42BKXIPG29425932
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Mar 2024 20:33:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9116458066;
	Mon, 11 Mar 2024 20:33:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8337858063;
	Mon, 11 Mar 2024 20:33:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Mar 2024 20:33:17 +0000 (GMT)
Message-ID: <916fb19b-daf8-4c1b-bc25-f071d2b3ae33@linux.ibm.com>
Date: Mon, 11 Mar 2024 16:33:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/3] tpm: of: If available use linux,sml-log to get
 the log and its size
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, mpe@ellerman.id.au,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
        viparash@in.ibm.com, devicetree@vger.kernel.org, jsnitsel@redhat.com
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-4-stefanb@linux.ibm.com>
 <CZR7B45P71XS.53XNZD9FWZSL@kernel.org>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CZR7B45P71XS.53XNZD9FWZSL@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -jVqDx0V8NJBMzGIKWEGNVFA9ho9AuWn
X-Proofpoint-ORIG-GUID: 8JcFWMEzsYR8oR4fF6-zlEthl9OmVA-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110157



On 3/11/24 16:25, Jarkko Sakkinen wrote:
> On Mon Mar 11, 2024 at 3:20 PM EET, Stefan Berger wrote:
>> If linux,sml-log is available use it to get the TPM log rather than the
>> pointer found in linux,sml-base. This resolves an issue on PowerVM and KVM
>> on Power where after a kexec the memory pointed to by linux,sml-base may
>> have become inaccessible or corrupted. Also, linux,sml-log has replaced
>> linux,sml-base and linux,sml-size on these two platforms.
>>
>> Keep the handling of linux,sml-base/sml-size for powernv platforms that
>> provide the two properties via skiboot.
>>
>> Fixes: c5df39262dd5 ("drivers/char/tpm: Add securityfs support for event log")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> I'm worried about not being up to date and instead using "cached" values
> when verifying anything from a security chip. Does this guarantee that
> TPM log is corrupted and will not get updated somehow?


What do you mean 'guarantee that TPM log is corrupted'?

The TPM was handed over from the firmware to Linux and the firmware then 
freed all memory associated with the log and will then not create a new 
log or touch the TPM or do anything that would require an update to the 
handed-over log. Linux also does not append to the firmware log. So 
whatever we now find in linux,sml-log would be the latest firmware log 
and the state of the 'firmware PCRs' computed from it should correspond 
to the current state of the 'firmware PCRs'.

> 
> BR, Jarkko
> 

