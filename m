Return-Path: <linux-kernel+bounces-94767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05CF874500
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A00B1F262A0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9ED641;
	Thu,  7 Mar 2024 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="DG3ySLI1"
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54E37E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769972; cv=none; b=kaVMtNl9YbEcFEABwkzTQkuFpP2vFaxaep3X3ge4+G9ONKPV3Z57bUTFP4dUScU+x3TLWWUXWLg14cZfRngVHUCt4d39SFl8JMDfvFE0yPPEmasXU3+R/hfqS6PCU+llayVt2yEQX225g9/o88a3k8bLbieeZejILeMwMLcMNig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769972; c=relaxed/simple;
	bh=kz2eCeEO6lOTYa9mh+hHsLxP6YY9LUeZHpJSSSPDDEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5FykzYDKNubkJfBMK8cbjVk+sm4AIFKIAuxLc98T34lbTZmjO6o9oC/sKWSVAMyTky05SWaYEfytj4/uDnbbiRxuU/UWT6nI0cFkM5Ep2NhpAUZaLv5xyD8QmiOZqjzN5ZYZ6FaGfDlgKEizgVt2jb5Pw3QsRLmxJkcQaWdhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=DG3ySLI1; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426IZslP008609;
	Wed, 6 Mar 2024 22:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	jan2016.eng; bh=9lGiShM8KJAIIqJroksHJTiyzZj4gxT5ZJZvfyYW3To=; b=
	DG3ySLI1eL1/QMp775EcMl7NcpY4VRvJ7xV+ke97E4NyI3gPRpJ79L1DJAWJaPpH
	XfMMywIakkrYp4aHch2maqeG+Etv0CWcP3YVCl//xojgBWj8vbaeE2XUut3Nd5gZ
	xGwyXDMxhfJFjMAAkIIR8B9MfAmB3gDGFlxfzgkMrE2sybKaGQDzoJHcGQiYxjz7
	2C8b5fkqzCwheTKaXFLcO2aY3I6JlgMhOCgNQxFTVvQ6N5gMeqTh6GUdd2lr1pDe
	omBz6yfY3OxRsA/Es3+jgXya+/qbGmiJUKd+5+GZBUe931XbZom0nqWHDeZHt5KL
	NWXmGPDN5LKrQwDXeTWwFg==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 3wnhxwuqtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:40:12 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 426KiaZd007517;
	Wed, 6 Mar 2024 17:40:12 -0500
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 3wm0b23hf2-1;
	Wed, 06 Mar 2024 17:40:11 -0500
Received: from [172.19.35.123] (bos-lpa4700a.bos01.corp.akamai.com [172.19.35.123])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 8990932E9B;
	Wed,  6 Mar 2024 22:40:11 +0000 (GMT)
Message-ID: <8f586bd2-c436-4334-92af-762a284e1101@akamai.com>
Date: Wed, 6 Mar 2024 17:40:11 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug] WARNING in static_key_disable_cpuslocked
Content-Language: en-US
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        xrivendell7@gmail.com, ardb@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CAEkJfYNNZftjpYBpnH4tEnm82orKtQ6SQn9i3sg7YNO-Df3tSQ@mail.gmail.com>
 <20240306105420.6a6bea2c@gandalf.local.home>
 <20240306193101.s2g33o4viqi2azf3@treble>
 <854e523c-c467-47f6-b977-933cbaadeb62@akamai.com>
 <20240306221650.sw3lha7kca2quv63@treble>
From: Jason Baron <jbaron@akamai.com>
In-Reply-To: <20240306221650.sw3lha7kca2quv63@treble>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=517 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060181
X-Proofpoint-GUID: xlQRlCxMYCLpV9SfyJtbU8EamUsfkC6V
X-Proofpoint-ORIG-GUID: xlQRlCxMYCLpV9SfyJtbU8EamUsfkC6V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=330 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403060182



On 3/6/24 5:16 PM, Josh Poimboeuf wrote:
> On Wed, Mar 06, 2024 at 03:12:07PM -0500, Jason Baron wrote:
>>
>>
>> On 3/6/24 2:31 PM, Josh Poimboeuf wrote:
>>> On Wed, Mar 06, 2024 at 10:54:20AM -0500, Steven Rostedt wrote:
>>>> Now I guess the question is, why is something trying to disable something
>>>> that is not enabled? Is the above scenario OK? Or should the users of
>>>> static_key also prevent this?
>>>
>>> Apparently that's an allowed scenario, as the jump label code seems to
>>> be actively trying to support it.  Basically the last one "wins".
>>>
>>> See for example:
>>>
>>>     1dbb6704de91 ("jump_label: Fix concurrent static_key_enable/disable()")
>>>
>>> Also the purpose of the first atomic_read() is to do a quick test before
>>> grabbing the jump lock.  So instead of grabbing the jump lock earlier,
>>> it should actually do the first test atomically:
>>
>> Makes sense but the enable path can also set key->enabled to -1.
> 
> Ah, this code is really subtle :-/
> 
>> So I think a concurrent disable could then see the -1 in tmp and still
>> trigger the WARN.
> 
> I think this shouldn't be possible, for the same reason that
> static_key_slow_try_dec() warns on -1:  key->enabled can only be -1
> during the first enable.  And disable should never be called before
> then.

hmm, right but I think in this case the reproducer is writing to a sysfs 
file to enable/disable randomly so i'm not sure if there is anything 
that would enforce that ordering. I guess you could try the reproducer, 
I haven't really looked at it in any detail.

The code in question here is in mm/vmscan.c which actually already takes 
the local 'state_mutex' for some cases. So that could be extended I 
think easily to avoid this warning.

> 
>> So I think we could change the WARN to be:
>> WARN_ON_ONCE(tmp != 0 && tmp != -1). And also add a similar check
>> for enable if we have enable vs enable racing?
> 
> My patch subtly changed the "key->enabled > 0" to "key->enabled != 0".
> If I change that back then it should be fine.
> 
>> Although it seems like the set key->enabled to -1 while used in the inc/dec
>> API isn't really doing anything in the enable/disable part here?
>> But then the key->enabled I think has to move in front of the
>> jump_label_update() to make that part work right...
> 
> Yeah, this code needs better comments.  Let me turn it into a proper
> patch.
> 

