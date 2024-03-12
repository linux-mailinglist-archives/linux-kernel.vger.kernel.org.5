Return-Path: <linux-kernel+bounces-99927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F8E878F48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A432847E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2CA6997D;
	Tue, 12 Mar 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mqT7zjqC"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049C69D00;
	Tue, 12 Mar 2024 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230112; cv=none; b=IWL6cmYSUMLfGvIPCWwzmOfvNXx9vjSNf7A2HXr/jTNIsRIAXdlVSueBT24kKInQ8umqkgHZ4QkJ5Fp1COfhpy2x5PU+nvAyuOGPNzkfyhcEaQD5/YK7HLixEYgKGp2glZdrx0yXhy0EhTRB117VTQ//RSW8OMYANtMIAFnqDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230112; c=relaxed/simple;
	bh=nW54QLvxLUE86tN4pbBK4afc+iEkoEeu461+c2/5ZnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mzcz/bVlXGNh2483Ff2d3HgoK5NqUjitepLWpFpvo6413JQNYR1V7hG5mqMNXyKBCFdL7y3wKwoVPAoIG4eoBmm/+Lt3ZxkXIFHIbgA1u2Ip4bxTB/fefecT1aAwvotLJxVRaLxeZMkLnOf1XelXDm5LZ2XNT8NrmKOxywPQQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mqT7zjqC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42C7lMZ4027833;
	Tue, 12 Mar 2024 07:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=o7LxOeWqm1j/kchabVECauOS2s34gMo+ClRG1T94Dwo=;
 b=mqT7zjqCnyR2F08mJRj3tzxGfRCrVj4L3FM1d2i6gzwTjPUy4bEG9G50YVV8/aNgFS+T
 H1unTaQFp+UWHYAXu2mMmL2ixhiDeW9VPKY61UPlsPtbOgumwzGr1dgexv8b1YOnAkDs
 /VmVU+QKGfxTx67IbXceE7EIa+uADjCMQd51rkcS+wCwhLd7T1gcm0Lgj0gWKKNYpEfL
 vq9sEZ+kXTC0OdK8EATFbes4Co9ToVLU5kgdV1H9098Q66pjjNbz7x8dvsMMrVDKZylI
 9xx5OS5NHWnIDVABxq6ufvLQ4R1Fa3EgKPNIgOpkal1F+Ssv9RoT6TagitDzV5KKTFi2 oA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtjyag3eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:54:53 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42C7nPaf003131;
	Tue, 12 Mar 2024 07:54:53 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wtjyag3ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:54:52 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42C6qVFJ020437;
	Tue, 12 Mar 2024 07:54:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ws3kkwj8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 07:54:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42C7slMM37486896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Mar 2024 07:54:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78A3A2004D;
	Tue, 12 Mar 2024 07:54:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 370F52004B;
	Tue, 12 Mar 2024 07:54:47 +0000 (GMT)
Received: from [9.152.224.118] (unknown [9.152.224.118])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Mar 2024 07:54:47 +0000 (GMT)
Message-ID: <fd7e4c2f-0d8f-4b1c-86af-9bf472cb7d0f@linux.ibm.com>
Date: Tue, 12 Mar 2024 08:54:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/smc: Avoid -Wflex-array-member-not-at-end
 warnings
To: Wen Gu <guwen@linux.alibaba.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <ZeIhOT44ON5rjPiP@neat>
 <71aa847b-2edc-44a2-beb7-3610bf744937@linux.alibaba.com>
 <1cb9a110-c877-4420-9b23-1e7980f1300a@linux.ibm.com>
 <82c1dc9e-d5b6-40e3-9d81-d18cc270724b@embeddedor.com>
 <d145d2c7-5cbd-4da5-be14-b25d00baad19@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <d145d2c7-5cbd-4da5-be14-b25d00baad19@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NByB9XodbPGvXpdRdzVkkLmBTagFQ-jG
X-Proofpoint-GUID: qXaI_Ah3RyMXBY4DUhIKKhqD2zXuQRoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_06,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403120060



On 11/03/2024 11:59, Wen Gu wrote:
> 
> 
> On 2024/3/8 07:46, Gustavo A. R. Silva wrote:
>>
>>
>> On 3/7/24 02:17, Jan Karcher wrote:
>>>
>>>
>>> On 04/03/2024 10:00, Wen Gu wrote:
>>>>
>>>>
>>>> On 2024/3/2 02:40, Gustavo A. R. Silva wrote:
>>>>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>>>>> ready to enable it globally.
>>>>>
>>>>> There are currently a couple of objects in `struct 
>>>>> smc_clc_msg_proposal_area`
>>>>> that contain a couple of flexible structures:
>>>>>
>>>
>>> Thank you Gustavo for the proposal.
>>> I had to do some reading to better understand what's happening and 
>>> how your patch solves this.
>>>
>>>>> struct smc_clc_msg_proposal_area {
>>>>>     ...
>>>>>     struct smc_clc_v2_extension             pclc_v2_ext;
>>>>>     ...
>>>>>     struct smc_clc_smcd_v2_extension        pclc_smcd_v2_ext;
>>>>>     ...
>>>>> };
>>>>>
>>>>> So, in order to avoid ending up with a couple of flexible-array 
>>>>> members
>>>>> in the middle of a struct, we use the `struct_group_tagged()` 
>>>>> helper to
>>>>> separate the flexible array from the rest of the members in the 
>>>>> flexible
>>>>> structure:
>>>>>
>>>>> struct smc_clc_smcd_v2_extension {
>>>>>          struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>>>>>                              u8 system_eid[SMC_MAX_EID_LEN];
>>>>>                              u8 reserved[16];
>>>>>          );
>>>>>          struct smc_clc_smcd_gid_chid gidchid[];
>>>>> };
>>>>>
>>>>> With the change described above, we now declare objects of the type of
>>>>> the tagged struct without embedding flexible arrays in the middle of
>>>>> another struct:
>>>>>
>>>>> struct smc_clc_msg_proposal_area {
>>>>>          ...
>>>>>          struct smc_clc_v2_extension_hdr        pclc_v2_ext;
>>>>>          ...
>>>>>          struct smc_clc_smcd_v2_extension_hdr    pclc_smcd_v2_ext;
>>>>>          ...
>>>>> };
>>>>>
>>>>> We also use `container_of()` when we need to retrieve a pointer to the
>>>>> flexible structures.
>>>>>
>>>>> So, with these changes, fix the following warnings:
>>>>>
>>>>> In file included from net/smc/af_smc.c:42:
>>>>> net/smc/smc_clc.h:186:49: warning: structure containing a flexible 
>>>>> array member is not at the end of another structure 
>>>>> [-Wflex-array-member-not-at-end]
>>>>>    186 |         struct smc_clc_v2_extension             pclc_v2_ext;
>>>>>        |                                                 ^~~~~~~~~~~
>>>>> net/smc/smc_clc.h:188:49: warning: structure containing a flexible 
>>>>> array member is not at the end of another structure 
>>>>> [-Wflex-array-member-not-at-end]
>>>>>    188 |         struct smc_clc_smcd_v2_extension pclc_smcd_v2_ext;
>>>>>        |                                                 
>>>>> ^~~~~~~~~~~~~~~~
>>>>>
>>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>>> ---
>>>>>   net/smc/smc_clc.c |  5 +++--
>>>>>   net/smc/smc_clc.h | 24 ++++++++++++++----------
>>>>>   2 files changed, 17 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
>>>>> index e55026c7529c..3094cfa1c458 100644
>>>>> --- a/net/smc/smc_clc.c
>>>>> +++ b/net/smc/smc_clc.c
>>>>> @@ -853,8 +853,9 @@ int smc_clc_send_proposal(struct smc_sock *smc, 
>>>>> struct smc_init_info *ini)
>>>>>       pclc_smcd = &pclc->pclc_smcd;
>>>>>       pclc_prfx = &pclc->pclc_prfx;
>>>>>       ipv6_prfx = pclc->pclc_prfx_ipv6;
>>>>> -    v2_ext = &pclc->pclc_v2_ext;
>>>>> -    smcd_v2_ext = &pclc->pclc_smcd_v2_ext;
>>>>> +    v2_ext = container_of(&pclc->pclc_v2_ext, struct 
>>>>> smc_clc_v2_extension, _hdr);
>>>>> +    smcd_v2_ext = container_of(&pclc->pclc_smcd_v2_ext,
>>>>> +                   struct smc_clc_smcd_v2_extension, hdr);
>>>>>       gidchids = pclc->pclc_gidchids;
>>>>>       trl = &pclc->pclc_trl;
>>>>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>>>>> index 7cc7070b9772..5b91a1947078 100644
>>>>> --- a/net/smc/smc_clc.h
>>>>> +++ b/net/smc/smc_clc.h
>>>>> @@ -134,12 +134,14 @@ struct smc_clc_smcd_gid_chid {
>>>>>                */
>>>>>   struct smc_clc_v2_extension {
>>>>> -    struct smc_clnt_opts_area_hdr hdr;
>>>>> -    u8 roce[16];        /* RoCEv2 GID */
>>>>> -    u8 max_conns;
>>>>> -    u8 max_links;
>>>>> -    __be16 feature_mask;
>>>>> -    u8 reserved[12];
>>>>> +    struct_group_tagged(smc_clc_v2_extension_hdr, _hdr,
>>>>> +        struct smc_clnt_opts_area_hdr hdr;
>>>>> +        u8 roce[16];        /* RoCEv2 GID */
>>>>> +        u8 max_conns;
>>>>> +        u8 max_links;
>>>>> +        __be16 feature_mask;
>>>>> +        u8 reserved[12];
>>>>> +    );
>>>>>       u8 user_eids[][SMC_MAX_EID_LEN];
>>>>>   };
>>>>> @@ -159,8 +161,10 @@ struct smc_clc_msg_smcd {    /* SMC-D GID 
>>>>> information */
>>>>>   };
>>>>>   struct smc_clc_smcd_v2_extension {
>>>>> -    u8 system_eid[SMC_MAX_EID_LEN];
>>>>> -    u8 reserved[16];
>>>>> +    struct_group_tagged(smc_clc_smcd_v2_extension_hdr, hdr,
>>>>> +        u8 system_eid[SMC_MAX_EID_LEN];
>>>>> +        u8 reserved[16];
>>>>> +    );
>>>>>       struct smc_clc_smcd_gid_chid gidchid[];
>>>>>   };
>>>>> @@ -183,9 +187,9 @@ struct smc_clc_msg_proposal_area {
>>>>>       struct smc_clc_msg_smcd            pclc_smcd;
>>>>>       struct smc_clc_msg_proposal_prefix    pclc_prfx;
>>>>>       struct smc_clc_ipv6_prefix 
>>>>> pclc_prfx_ipv6[SMC_CLC_MAX_V6_PREFIX];
>>>>> -    struct smc_clc_v2_extension        pclc_v2_ext;
>>>>> +    struct smc_clc_v2_extension_hdr        pclc_v2_ext;
>>>>>       u8            user_eids[SMC_CLC_MAX_UEID][SMC_MAX_EID_LEN];
>>>>> -    struct smc_clc_smcd_v2_extension    pclc_smcd_v2_ext;
>>>>> +    struct smc_clc_smcd_v2_extension_hdr    pclc_smcd_v2_ext;
>>>>>       struct smc_clc_smcd_gid_chid
>>>>>                   pclc_gidchids[SMCD_CLC_MAX_V2_GID_ENTRIES];
>>>>>       struct smc_clc_msg_trail        pclc_trl;
>>>>
>>>> Thank you! Gustavo. This patch can fix this warning well, just the name
>>>> '*_hdr' might not be very accurate, but I don't have a good idea ATM.
>>>
>>> I agree. Should we chose this option we should come up for a better 
>>> name.
>>>
>>>>
>>>> Besides, I am wondering if this can be fixed by moving
>>>> user_eids of smc_clc_msg_proposal_area into smc_clc_v2_extension,
>>>> and
>>>> pclc_gidchids of smc_clc_msg_proposal_area into 
>>>> smc_clc_smcd_v2_extension.
>>>>
>>>> so that we can avoid to use the flexible-array in smc_clc_v2_extension
>>>> and smc_clc_smcd_v2_extension.
>>>
>>> I like the idea and put some thought into it. The only thing that is 
>>> not perfectly clean IMO is the following:
>>> By the current definition it is easily visible that we are dealing 
>>> with a variable sized array. If we move them into the structs one 
>>> could think they are always at their MAX size which they are not.
>>> E.g.: An incoming proposal can have 0 UEIDs indicated by the eid_cnt.
>>> That said nothing a comment can't fix.
>>>
>>>  From what i have seen the offset and length calculations regarding 
>>> the "real" size of those structs is fine with your proposal.
>>>
>>> Can you verify that your changes also resolve the warnings?
>>
>> I can confirm that the changes Wen Gu is proposing also resolve the 
>> warnings.
>>
>> Wen,
>>
>> If you send a proper patch, you can include the following tags:
>>
>> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Build-tested-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
> 
> Hi Gustavo, thank you for the confirmation that my proposal can fix the 
> warning.
> 
> But I found that I may have something missed in my proposal when I think 
> further.
> My proposal changed the sizes of struct smc_clc_v2_extension and 
> smc_clc_smcd_v2_extension,
> and some places in SMC need them, such as the fill of kvec in 
> smc_clc_send_proposal().
> 
> So my proposal may involve more changes to current SMC code, and I think 
> it is
> not as clean as your solution. So I perfer yours now.

Hi Wen Gu,

you're right. I missed that the offset calculation is broken with your 
proposal since the full size of the array is already included in this 
case which means we would have to subtract the empty slots instead of 
adding the full ones.
My bad. Thinking about adding a testcase to sxplicit check the size of 
the CLC Messages send in the future.

> 
> And as for the name, I think maybe we can use '*_elems' as a suffix, at 
> least it
> is unambiguous. So it will be smc_clc_v2_extension_elems and 
> smc_clc_smcd_v2_extension_elems.
> 
> 
> Jan, what do you think of the name '*_elems' ?

Hmm... I think it is way better than priv. One more proposal from my 
side would be *_fixed since this is the fixed content and not variable. 
I'm open for both.

Which one would you prefer more?

> 
> Thanks!
> 
>> Thanks!
>> -- 
>> Gustavo
>>
>>>
>>> [...]
>>>
>>>>   };
>>>>
>>>>
>>>> Thanks!
>>>> Wen Gu
>>>
>>> Thanks you
>>> - Jan

