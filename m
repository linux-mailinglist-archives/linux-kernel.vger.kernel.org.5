Return-Path: <linux-kernel+bounces-100860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3E5879E54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601371C21CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70023144021;
	Tue, 12 Mar 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r0C0C2SI"
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640C143C6A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281883; cv=none; b=vBgg8O3tf5OW0opMTZ7S8u77A0sjDoJ1eTK66CU16B/hVp4NTzT8O7XaJDbmv1SSYqenXQ0LFKUJXr6G7b8mwD3kZmZDI9ZkwyWLvep8eZftGiFpVFOU2jvUVnAPrTOLxK8L9NeHC3v2Z03YHPs+2xUWH4NalKmVeFVVMqzSMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281883; c=relaxed/simple;
	bh=LxBZsL4ZKcp3qAuFjvIpzSZpTTruya38TrtBb2rbClU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V0Y5xf1YxMvI+XfXghqfLfAe4Afy+Y2WYBwLEuDVC3EvBuoWOPDyV3zzssPGWccmGJm/kbk8TQt/ZQbtRnQm4cJfbl4B/e8hqyV2XbLp6c4mGeexj31/MMa5KS6cfv7yraEV4JhTxSj42Js87AuExWoPmcbRkW6j4tlIFEOxnxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r0C0C2SI; arc=none smtp.client-ip=66.163.191.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710281881; bh=cFD7ONlouEHnUtHjfk+IrWvMDGAOr1AAuZlJ0ofkVJg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=r0C0C2SIKPsbUAIYbQ2YjPpYnOO1nsFpYRFu2poPE49kKpHEiOH9Te0yF6zZUvMkTvmkz+L7qSnXS0DqIUM5HlajmyQbAztU0J+WDJ817HpLpOI7jlwFb2hdoDAoMj0lwOt8mkAiSHisFPmfGKgKqJY/I+GFGWQTqbNKDdbiRiYgAXs+Lzo/FnOHxQSs5SwJIvNQeWePBjT2Drixf5RQ2MADDrzuOq7HdYY6cDo6Bycjb8kb+WATx9ZeNhqLZV5Fv9wSTXII1aP0N+PI3wOmlznXPES504rFtE6qZ7AMkfsNnxo4jcink+mJNKgiSOLYgf1yg15K6rN6S7UuwBfwOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710281881; bh=ck9M1Z5SblsUqxjiJgS0BLrX9mk3288KMTcmCY21nI9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mH+69afhWYkow7pv7Rk4J7TyceTqwfCquHdzw6E90uDbP+KSk/uce1ljGx0jkR2kyLzXAdSKzGBtHUcXJKJeGHSA8TzY/W1pGP2dTB1hKfNFLtAz5JOmJfdQyKVKYDDaBv0kLsqzk05rzAu0Y27UmXWum6nOf58ZD0Us4OTYmmYrSqAVX7dINHQlNrCpnQSjaeWav/fcb8yXgxmz2/ANF1HpmbjXHItOIXaqbMR5Zi+zOuLq4nFoZ/d4VHzfch8NfSnQfeP8EYq1pvPi4ugKThTm2wbK8aDNk72YPkAepryAo6wS2sVlWYAUNKDokXY+giwsxJUy+M5bisg5rzJiog==
X-YMail-OSG: QMaYU7AVM1lPRBG8aMEZCazgi5DOyGL3BjGUid9ey3DFW6xtVVwpmJAwbTSCWwF
 J6SALxiiHsLVv74RSJJUlcUbU5N3vNH3mrLjGsYlFJpno2avvbYZldAf4GpjEwkMh5mZaY_TwyQh
 6Gg8eWyghA.NjAlpt9lU_9imjzMQrR0Tpg682yEQHjGymWO3qxLJQWC9bSljGLT4_NwlknhUKarA
 FRYfxhydIWXoS391lQXQShJ6PizNffFHutu_Dqaa2mcosxLZUO8d6VbAE5LZjKExy1mJlI0HQKpf
 UOhObaIGB.thSLgyvYcIlkf5ptzCJ2.FmRocRPXKb8axNosaucAF3H2qg8gt1r6QS0byBm66D_.e
 JQOLshPO7XyKVw3iP5oqfglS38D3bjuKH8UrBFbJORYf.9ffUDNT7A.GQh13ARnp_fE8PcpSUdN1
 WnOQjhZ1IcChc7st0yej6ikRCVFQZav24PDkeZa1B9QVUYFxxx7NO86H0xe7QR_GcCm8o9LjxTkA
 yXHapcsYfHk6Fk2ThsVtJWyD47020D2vEDHM.GElxyzcMk2cLh4ZEyaVdZJJ6tdvHbVLItr.RveV
 4MXz9JnaZSdjFhXklK48fYVAzPzbZf.d6Cgmeyr7eCLRvu_mYqJ1kn8Z.I7GOrYgeqQxKBF9K83V
 lppQdGsQENCxYTNyIZVhnnIvleTiFe.BA0Moy9sv7w0aeX_2YQ5Y9uKxQdY4_Yg67t3MlNksPoiw
 fD9ceWbKkGD8lcBfacl3VpSBUan1IMvQBNJBIhxY6g1NgqmY_Eg3gzpic2vzV14.ehbG8X8Limd7
 mF1IvxXJGUdRzkI3Ayi_uQhiScGS0CAYlpBGfdOwizaNA_nIkiIdU9OUG93e1ONz9KZXfxNq0Zuq
 9v9XClkd9Mrs3hVceBwiAevJxWBHm.eeBo.Gd0GCbo5ANu8KVHlm7AyVwgHmr.hOW48nEEnA9fBa
 IG4vmGnurhXdoJzzeT3XrlCPd_LUv8_jfCSPPAI_JLQrYR.6UlQsbnErJ2CBhH8bOKs.Fthm6M0w
 CcBT7VSaRzdgAguvaMR.zfrC9IhWSBu6VYESwE2P.tRPEEW1nlWL6TKH5DGi2AdWpfgw7h.Hnzcv
 vNU6lcRf8QiF85W7ZRAwIdNg.AuoBEIvw6Fv_Su5NVKRcxjK_TjcRPM7d.v1td3t2ztsQyIMJysg
 LyI9D0FaUEwozBWWzKKbevgOv2gYMZwxUBE9S3nAh3K_wJdjDUnQImgcB.lj4FT8lcI6rcYp6jve
 .gX5IJYM8W_cpT0r0haHnGFPA485gijlZ89Mp0emkuSQW4cBf3nHXncf8_ILo1ecnqUFf4MkN8yW
 6uyJFmwt8xvoGg2kE8VcycgHRwpCcACH06WzVR7TqN.DBCI52kB2UU2j55lza9IfAe4icYo034at
 SPjOKh7hQz49RnEEdSZCsRcZWfcNqrRAo1SwwSYU3LOrB78M6betjMGJgP4gSbPoI1Fc8CtFxKT4
 NXsf8MxkHIDG0JUADEubF6qJkX_ANr05uj7eb0zN4O.NEFocatQAd99UrUB.aCa4_xRL_xCBmcGz
 PMoOVopjfkfTpn0tTbSwf8uZ9tfHX4T2Wf8S63NPtpabeIziyKsTDc0zkRR7tOsJSLD5HM0uJcy1
 7fTC.7h3lY3YluKun0ou._AH8.UVSiRIFFuGdAAicTpyTXzc_9ZQyjvZBFGoDIMYxMPu6UdvjuKI
 eFhKDfZQtsyjHfA3UnhvaBNyVMz0g07PR.UkPaiauV62e2q.gjPtxXvyV8oj1J_E_70zdGwIQzRF
 JBGA0SFcUNTAlxaeZnDa5HQ4cFcGZszojrUOD9F2Y3BJRlaKt8BZYawUSU1Xl0AReBeeORZ4Ygus
 oaYKkzimczyNV1WBVqz9dwhmWmCGWJhO0egsknpriO0L_vrGAJI7PPk2GciGl4bwsw0S8rHzthyM
 guNEfvs5.nclU7nAh7IFpScWQ.wN0wJj_qd0sE4dQBMOkSerJs2UJUpHny8Wi5bKtZpXY6QZovFR
 TJNEHPF3R2P1k5KHe8f1RjJIM02BIdvYRLqwaZiC8TdNlniOgqAQPp2qLBzJY0miv5eEPfY1hypm
 QHvIQjJwrwzdXoZ40DtHQAjJOWKxYtb4UMzcU3Yl8zLogMeK9iE2i9QPnRXn_R0DqHULmUFq791F
 GKe8HV1Dri9pkCcTZSi6HBiiYEr.452SUEKG6VdLJwZMEGAiRgWmWyKwanSMdOXC8viTm23JYOHs
 7l7ovH9cdCBDdjj7YbKOSyGeMoBvcN9nuRvJ9ra7B9d3Tczs9R_384Vx4MQLWKhLw6a5DxWavdz2
 693SIdxbphSZhSb3qof6Z
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 88345881-4a5c-47cc-8a2c-1b5e13162dc8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Mar 2024 22:18:01 +0000
Received: by hermes--production-gq1-5c57879fdf-c7xks (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6b2784b44c0f9833033c3e8816efaad5;
          Tue, 12 Mar 2024 22:17:58 +0000 (UTC)
Message-ID: <ad5333de-0c89-4191-a217-014f3953a1df@schaufler-ca.com>
Date: Tue, 12 Mar 2024 15:17:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, "Dmitry V. Levin" <ldv@strace.io>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
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
 <20240312182820.GA5122@altlinux.org>
 <CAHC9VhTw2h6V3Z4fut8vHf59kOJeYqDrPqbRmRDNtZmVnM4g6Q@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTw2h6V3Z4fut8vHf59kOJeYqDrPqbRmRDNtZmVnM4g6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/12/2024 3:06 PM, Paul Moore wrote:
> On Tue, Mar 12, 2024 at 2:28 PM Dmitry V. Levin <ldv@strace.io> wrote:
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
> You might as well convert all of the size_t parameters, pointers or
> otherwise, in the three syscalls to u32 Casey.

Well, nuts. So much for that coin flip. V2 coming real soon.


