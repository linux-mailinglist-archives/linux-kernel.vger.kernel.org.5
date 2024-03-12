Return-Path: <linux-kernel+bounces-100852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A076879E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1004F2815FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD1F143738;
	Tue, 12 Mar 2024 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WkIx9Ovq"
Received: from sonic312-30.consmr.mail.ne1.yahoo.com (sonic312-30.consmr.mail.ne1.yahoo.com [66.163.191.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6C143732
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281192; cv=none; b=arCcOcimmGRc+xpJDUiBa9dBN8Ip3YZBPhHx6N8bESTqJZXgfU6l1AW5kBQk1BIg9hTUPUTMq310OMEoBy2TvvaIV0Y60Eu/DpZEo/SHnxZnKN8a8dtPm5Y24ljsL0ZrjA7TDfdYc687j5aa1XOe8iagOmmh9whAZOMIOlyad5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281192; c=relaxed/simple;
	bh=LdXJJFs4qSOOpFP9I4+FQpoOujdvQkOvq276ZIGnPWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPixv/V5BBFhWOnWRmiyFQwMTYNKjncPZUgqD35p9QNO1OiHxJhcFMqTo2NcMeffmEuBmc5JdBSqAPA0rKHeRoB1P2wnr0V8KpdvvjCLb2vmJK0PySWz9Fb8Rn2Cgw5vckIj/GWX3mgJoocnYax3rnxlDrIm8fX9w7MYuxVaAow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WkIx9Ovq; arc=none smtp.client-ip=66.163.191.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710281183; bh=wzTiQcs2q+/m1BYmXPnQm/E3S/2D4u67gFitJdXshx8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WkIx9OvqFKllLMDIQaghFBQPLjvmF6TzynOhuS+jYI5YRAIeePQPJ/MEKRZX/X5b+ObzeYtnnM8s0uWZ9/FFbaBJfutRqD99PjauvXZLmzdkAawR4Ai71BgZVj8v0WiZKZwBbxyhHxc/cUJokJSJyZzbtSS9SC9jKNfowShuZzepMgHlFTlsjO395pAum/cNskRmP6II2qqS76qTpHequenqlYJA8cbdoh1iE4m/I1pEeC2FCOeZGnzYC1ULxy2xus9CO3GzkRNyRKGzTwTjBTiAQGnv1Rc5LHPHweHjFyu5UEq49SqvVwFnAbWoy7bqUFzg9iXiQmT076r9nanCxw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710281183; bh=COd99fFltcqHI+CyyqoDLC4f7wrx3wG3d9USKHMrAOW=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=aN565CdCRarXlLb6R+FlNXhvUSsL8fmgkm9ZqEgdTvUc4hndGZKm+DzyULaKafM0l8RmvPMTDobilG7SVymcTEFcI7gE2IHUG7b1dz65+85aqZ3Iieoonv2zNGbxtjf/xjLC+1JUemWTrtWv0+NkjjFMmvHr976btvHopAqfWyeBSV3EQCnTsi9jnxINb7Ve2bG6RNwVUhZnrr8PY1u6Fo5MxcYcPGOhZ4b/4OMuuZMdhJj9CsTj4Jet64bMOY+GG/+gTd5mup3E3to0+w19VlDRylj+Gk6xwk65wbgpp4KUbz9J9MSH3qUcV5wzSJgIdAR0pMaz/SIM6i6CJrenqQ==
X-YMail-OSG: eooziQgVM1likdHA4ydNJB2okntis5p80vOPQE7QMH3AW8UGrfAtUHlqq7PCrji
 fSwfiziS2IMvNVJPScocKHvLDIjgQDo6a8t5EgXsUR2YY8F4fg_t.s1RZxvcMAASw4Fstxct1tUd
 8SHr4Ym1npVASZ8RevmkbxADN0KKVTlCyhpP.OLwgzIgTDjTHmU4Z8mYOu_Yz4.rrbXXML9fqK2N
 BTHtriOgskXjHAbhAL9OdWeD8Bjm5GbUO46lfeMsDCIC6sptYslCKwYRhQF4B8DZ8tQpFRUQ418m
 DtPJORrKGyuT1CXvKmgUcoC92A.YYoc_MbizWF8g8wRrPzM4oCsiZDZs8ohR14jUtsm.8Q190Jmn
 .2SIjM0xzv3pJiX5jAgUhvawwonPQ4pOXavCKnqAYvDHeR2dhk7ITP9RDqNp4FEMKc2IQgLmHa5q
 GHkom8..kdDgcyvQ8ve6f2HLeaKBNUKNiVg7prb9N4cubY.aHDcT.8l0p62U7HKR5AXXyFhKigVP
 _ClHB7u4KhsIwb03fK.qcXjNeTvo1.B2ak4UBDCvUj5qOtxK1Mf6ypqxSHs.6EbkQL7h8va.wBPz
 wBYHCodsJeFmA0fVGqrD09xJ_nZbIN.RSaqv5L.H.O5vX78FMXv.odOinRLTAfDIDz9xiLpaRk7t
 DQGQSNuz2c61iwa2B2Z2sf24peXuwfxID9RzXOHHthwOZIQBfmE5YflP4k.M_7cZuGutIM.byNhM
 AY3Mgs6C.ok6uTuWP2Mo6x39mCtQsbUGm1g5VcuQKzUhDQwgkxx6vNKHLwIPR_Lccxnt8kkIazQD
 NplQeQslonmt5jOWzA3azbDDR.Hdoj1pJsKP.DW3HS.oyga_.UnMezBVW0ZE0s6OYv13eWIFgui3
 40zs03WoXxx3bAu_frOPtLGuNt0TsUkwgJyPvm.tn9CFwlJGIShThGnTdh4APKWiPRC.bg8d.6I2
 i2Jk7UiFFOywXMuQFfAbtdgC05LZ0edpfJjX5R2cEBPjGCRdYPYwYL05dVa5BrLRTEjcwwyehHhm
 rtz.tTv.8QfSnK1y.i6QTEba4MGxCJtlr7e0MkuftisLsZr4FJpvgQavypNo4JCyORbjzfcZkbrK
 lGeIk5pwIkXABTgETPS_i27b9b76B7mlffnHX5kTY2ol0aGiwIMhKWw6vrYACrldBcLu3qd7g7sw
 bJvcb6YLuu9KTVHgw5JkU41jnwUi.F9ZbR4CRF0TXaTqpg3gAnnchafI7CvbJjVZg1B_YxjGCMaI
 inw2bSZB3zuCQBTSy2Pm1Vk1TZBbYEt93whxh1aMOTnNT4ArqZ1YVFW4qOTaXS4qTu_opUPdSodj
 qQ4lKUK47EeXg_oTOceE6y1pJK4.VJS6K.uowvUiHwJNbJXIFvkgsifv4FxAFEuTkgvemE_5VtQI
 wqOjvO4IauVg.N.VNiHqMGe7fptjH_m2.R2DGqQ8CpJ6JETQo4SfFCcPPu26YoRKBolJiZxhCIR8
 OBHzAS0hUi6vCCW9_6.axbnffVkvQCVZG1ZPpeXkxQ7f3bZZs56iMzEk7Ev5unZJGgi21.VmgFCk
 sk.sesrA6UQsa91csutgCpQTGQeXbTnnvSZNeenGAZ2vin_8Du4f1WTJLPVmk_QFiu2cQdNrJOj3
 EiHVUGot79HyC9vzrIDnXtiXdOldxB6ddeJhRSsA33ZlIEW.BXi_kUydl86M7S0UcwvNKB2sKdmn
 BJ_3leHP8_mPJSOlknDIKfUksqkbSF8oSazVcM82aps9nl86tcNgQebSrgxmdQhvIAkfUQQOsZ8t
 xw05Fpn3QMhjYTf6sSUZQaCNMvMGoRFPh1CIcUPEV8NPLQ7UAOD7x0tFMLHbOgxEREz0w75Uowa1
 ZDeAp_2plQYNhrSw0z20a4ArjB7fovduFg7k5mroRJSDYceHzFp3hTyMrIi6MCVDFyqGhHsvtxCg
 wFNiAox7KES9O6Rwf8nAGF2IgSWKvjOwhIiKkIGYmNiOqrnhXp9J20OPReXm2lt8Ugo91EXQjpgM
 ROysdZADV4TX_Umztt1jfuBuXg7W66Nzy6bReJsgiDKi40Q7WetzkHlCnhuoFYnesyyexKHVztY1
 DgnOjbdtx6wZfCTQzrAr.glKZMUI9NtoyB7s0P73fNk9GdywX2I3RNvWGQNKsCnXSQ.KQlSRR20C
 Oi8cUZDW3ChL.cMC8R2q87YAeST0eL7gVL6GmFsjKWstaQ92nfSSC_XXaN.YfIQhC9vYX8VPrgTa
 TlwFBqAKitmhD6x8BAS0r6Zt5dzwN10ciHK09bxZKjsUBMNb7PcB40DI4pqVLgFSEb0xUjWx6DFC
 SsRTobZwfr0BddlaGPVHY9A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d7b29419-6940-4dec-a2d7-7057e00a668f
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Mar 2024 22:06:23 +0000
Received: by hermes--production-gq1-5c57879fdf-qprqq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d3e47be27afe79697a153ed669661014;
          Tue, 12 Mar 2024 22:06:18 +0000 (UTC)
Message-ID: <a5a8a298-b3f9-4b94-97fb-97da492f036c@schaufler-ca.com>
Date: Tue, 12 Mar 2024 15:06:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, "Dmitry V. Levin" <ldv@strace.io>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org>
 <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
 <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
 <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
 <20240312182820.GA5122@altlinux.org> <202403121449.17AB66665@keescook>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <202403121449.17AB66665@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/12/2024 2:50 PM, Kees Cook wrote:
> On Tue, Mar 12, 2024 at 08:28:20PM +0200, Dmitry V. Levin wrote:
>> On Tue, Mar 12, 2024 at 10:44:38AM -0700, Casey Schaufler wrote:
>>> On 3/12/2024 10:06 AM, Paul Moore wrote:
>>>> On Tue, Mar 12, 2024 at 11:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 3/12/2024 6:25 AM, Paul Moore wrote:
>>>>>> On Tue, Mar 12, 2024 at 6:16 AM Dmitry V. Levin <ldv@strace.io> wrote:
>>>>>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
>>>>>>> [...]
>>>>>>>> --- a/security/lsm_syscalls.c
>>>>>>>> +++ b/security/lsm_syscalls.c
>>>>>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>>>>>>>>  {
>>>>>>>>       return security_getselfattr(attr, ctx, size, flags);
>>>>>>>>  }
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * sys_lsm_list_modules - Return a list of the active security modules
>>>>>>>> + * @ids: the LSM module ids
>>>>>>>> + * @size: pointer to size of @ids, updated on return
>>>>>>>> + * @flags: reserved for future use, must be zero
>>>>>>>> + *
>>>>>>>> + * Returns a list of the active LSM ids. On success this function
>>>>>>>> + * returns the number of @ids array elements. This value may be zero
>>>>>>>> + * if there are no LSMs active. If @size is insufficient to contain
>>>>>>>> + * the return data -E2BIG is returned and @size is set to the minimum
>>>>>>>> + * required size. In all other cases a negative value indicating the
>>>>>>>> + * error is returned.
>>>>>>>> + */
>>>>>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
>>>>>>>> +             u32, flags)
>>>>>>> I'm sorry but the size of userspace size_t is different from the kernel one
>>>>>>> on 32-bit compat architectures.
>>>>>> D'oh, yes, thanks for pointing that out.  It would have been nice to
>>>>>> have caught that before v6.8 was released, but I guess it's better
>>>>>> than later.
>>>>>>
>>>>>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ..)
>>>>>>> now.  Other two added lsm syscalls also have this issue.
>>>>>> Considering that Linux v6.8, and by extension these syscalls, are only
>>>>>> a few days old, I think I'd rather see us just modify the syscalls and
>>>>>> avoid the compat baggage.  I'm going to be shocked if anyone has
>>>>>> shifted to using the new syscalls yet, and even if they have (!!),
>>>>>> moving from a "size_t" type to a "u64" should be mostly transparent
>>>>>> for the majority of native 64-bit systems.  Those running the absolute
>>>>>> latest kernels on 32-bit systems with custom or bleeding edge
>>>>>> userspace *may* see a slight hiccup, but I think that user count is in
>>>>>> the single digits, if not zero.
>>>>>>
>>>>>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
>>>>>> compat shim if we can.
>>>>>>
>>>>>> Casey, do you have time to put together a patch for this (you should
>>>>>> fix the call chains below the syscalls too)?  If not, please let me
>>>>>> know and I'll get a patch out ASAP.
>>>>> Grumble. Yes, I'll get right on it.
>>>> Great, thanks Casey.
>>> Look like lsm_get_self_attr() needs the same change. lsm_set_self_attr()
>>> doesn't, need it, but I'm tempted to change it as well for consistency.
>>> Thoughts?
>> As lsm_get_self_attr() has the same issue, it needs the same treatment.
>>
>> lsm_set_self_attr() could be left unchanged.  In fact, changing the type
>> of syscall arguments from size_t to an explicit 64-bit type would be
>> problematic because 32-bit syscalls cannot have 64-bit arguments.
> Using u32 should be totally fine for both. Nearly ever kernel internal
> limits sizes to INT_MAX anyway. :)

My initial patch changes the size_t pointers in lsm_list_modules()
and lsm_get_self_attr() to __u64 pointers. I could change them to
__u32 pointers and include lsm_set_self_attr() as well. Let's see
who screams how loudly.


