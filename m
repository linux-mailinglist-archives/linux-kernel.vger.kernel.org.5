Return-Path: <linux-kernel+bounces-100618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF1C879ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C441F22292
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091EB1386BE;
	Tue, 12 Mar 2024 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GZt60d2e"
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1401384B8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710265488; cv=none; b=CX7p5AA5IxTBOREj7XOM3Wlwrnen+Fi6C0NXHJvdjreTzShsqJAlnioNGYO90pj7VijivV4e7Bf0mEIXRtUeYeaV8cSIUKRWqvPMvHb/A/0NSfDQpGObkq74q3MKjtLZMYeNf2ZDzuHNDyLuUT7vJixzqivXS8ufmSaKD5oE3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710265488; c=relaxed/simple;
	bh=o9TiYG0Zc9byDG9zfXuLX03xTQqB+5mUXZC678l+X6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEsO1N9fVBeN/Sxayg0+VtZ1mKGjeDNymX40QqNOWG3k31QECsqTpqeU7LdpiwrdXuqHIzSk7aJAeL0my9whgUmibFlTaOGygEZae27vEcUD5OUD4elhe8WH0kbNzp9bRcFVKb3aQwd2ZbYgWSko0Ut9aAve6endsL6dX2aGHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GZt60d2e; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710265484; bh=5IOlws87NG5tmdrmnvfWLOgo38WKByqjjsAJfn5pzhc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GZt60d2eDMrQxQfY9Q8grtE/cs9DFN28tRLmKtfVgSJLQBkljFGLVGLzVGhblhoQ8VpvGKfSFWHg8JFA2o3FzFw/D2G8GdfX/0WpYC776xgRaBaRXEfF2Fuc0DVF9+aMZ8vR0+nsntGWDKYIbaLLQjY2gFbLIsOoGCkr3b1WjJPIJz+NUsGY2CBqQy6i8wmvINvAWH9mEkk94otchLr85h54Cvqk8KsMk4kvBp75nmXqB4+Xw8/lHVICZkgqQwem0K9g7rtz2hcKe8Kv9uBQddWnL+As6bwCDlASx8eYYUHJALCgYpV86HuDt/fAjOq1Ow6rAwH26aPikHYHNvPOhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710265484; bh=kvZoNoQPqEzjnFJ/aEmJyxaS3QQI/lVoRfJy/T1H/9B=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OQJAw8Hrk8POE+yMtExMByoDKN+zVqIaVPj0t8Ru9tkOdrhtTVK8BApwwqrzlOMoI1uTQCni/dNR71i6GAGWNnNWPZ2d/dhEYIDPSto1+yK0IdQc5RuG8XKFxRdHkhRgJ8XfLg5ukM7t/YwQGPu7EdoCy5zzdwXYZ7nKND1nIFD1tgOqgKeIHLvsJPegVbN36iyGZrHExa0pwxH+5GSzO6PyUBRHHahdYLWs+v8szbr00bbe2yKCYHkfmVy+H/fNA0bZAbh1wvC/1QmdtqJMKVXvZX7w1C+APzrCWkoyr9XX4VwFdqQrxEW/u0pDz3fj3xPe4KqGx16nVA8dN7T/NA==
X-YMail-OSG: P8OVLL4VM1mwotbaP_Cg0luRDPFa8y41l5rW3Gi92Dx029i36UgkqUro_9upcd1
 NerCAAiHl.VRyaFxFgQbkSfZb3_qe3OA25Gaxl61fSrvJRZ1xr.iBK3hhSVIER8daaAvXAeLXAZz
 o9urOzA6w.OE.5Mpzdkxcub7f48UORNfvccjcHptwy2G70UH5L1VqxsKmJdUIqWHBwJ0RSPa48FC
 GuPNfTFSFFkSWT1AcbRapLwOmTxLxGPQhbu4TyJ64vUKBNQZh.CHhyhuTUVJWzkOM6KI10meJJdW
 .dJXULVfuOBzxblfZM03MQRwuVkZZLnRvwauNsmAckHlzLXdCxiYVSRb0GnmcHPNN9P0ag1mdh06
 UONds7GFSokpC6Aq2Qke.T_KkrnidEPakQoUdue.KttNxMumC8QGSdZSCICsF0dybeISB4Kf5rsL
 gWBQi3PHTIbhV92O1HDCzNF77MMrGi2CUcXTVAx8EAHXcHLQzPcmKZ8HehN681rZTleLvdsSIJCD
 _jJ5mYF6EaJHg2vXLORTmntnaLj9flOR56SYHa68haT0TlL8w6NH6W4ah1HBcOifbeQ6Gk26f1cJ
 AeGzMCN8ttAE1LIQ50eoma.Mu1TX8KkUoXWbfs4Nxihlxqu8oOo2B_Dr9rCsVStHR8WFXfKFxrO8
 wdrShigU52ZsjlVj8_mEzeLjsDr2oUZ7oB4X04T5RxgMrfztUiQ3morb9rFOJsULX6QcZXQHWl7D
 wom9BMV4xvTuqMv5Uk5.RjTfnJYUel4.wA.mGHTi06iO4tQtP0vW7n13iVSUK_6P8Q.agLzAFszv
 qsCPWShd9XfjsHHlxjdr.YiP5ixtFbA97Z7sqg3kmRMh2JGVuax7jl2wd5ANqbYEv.905GPMo6ZS
 qhuIRVfK13NLpziydeIda_w0MVzQW3yew4q.0W6Zk3Jz1H_X8_D1F52.s1ZBfJH18dDm1Rxanl0h
 NTeOE2QX9glD1mE_FYi3dRYcCL4R4.TIkCp4Ll6HRxCmHBo7VLqfJSSLDnkeudt4vohoKi1zxQbl
 tmAuynA1oBCd4G10JhZQIFlngCLScK.bsduTGbOAfz5SR5ZoZwnBTv7d57pQ4P4BeQ5L1Q9wGpS7
 8H2DgdKbA951AuGygWmf92hprF928mNYgKfCizRnbsFYDcv1wVu_25.xwEJfc5._bTbaSLoAcrHT
 qgeIAl.jOuRpbBZA8Z40VhhxR7Z.ZpgFL1cxiOfk7DMjjH68e_gWWmjUtg42PTYp8zqjCRQDSDPO
 vpyF14f5tHCvput_UbU98NDaCa9hMCY9_2gFrI_dTq5QHwTXCWAcuu9SCsgK0VeO2gcjxHToF4A_
 O27fa1QNpLsojpCJ7_CNm5Rv6Ck4lUuZUWsOWlfNRgrWbDM1CCwMQ2T5QbBUg91pLEnc78gHk43_
 S10FzRaZ.03rIuUBo3Ts28ka7WwOscbKdzSyNTLs2KEHQ.K4F4pGveH5Hg_yyQGFi7i_eMXUeML5
 krHT8F6ZZwV9Vp3x2gLauyFkEssNiukMLoR6ejLMFlf2n9jznPbMTpo54LdByAOYaCePaKlnyWND
 ktTl2nZxB3B5vkmFUxJ8WeUZYc_TfhxV_Utef0OgqE7WqPomEGDSTX1919vC3l6U05P.VD_Ej2Ur
 3X5Io3Ffxf_z5uG1JsVCj4h0hcDRXttsHXPktTYhtzfGmVO7l8CmE.SM_AnWes_Ge.geyhaJrEFK
 ildXcCR9.3F9yNanRxbcDhmpHUi0rYaIgbpPok_aB85mHzRAYdqwHVGIwGgvciPlTDphlHrojaFV
 SJJPNxPoOyDFgo4m2fmtc5Ic8vpFJTP9_PTUqnqXe3BstFuuwpjeL5k4ASFEEv0pbS3sSTeGAxlN
 Ss8OrehXAKA_t7SxITe81CN51Pk0grYQlNMTKJMQ2gU5fE8X454cDGsT7fym5vaQ.8vfRgrYhVJo
 5z1LtM3SNwcbCxIQaHDFxsHwvLBw8jfWLQiqak86QeJSC34OWYxxp9vT2idtXhgO_3RvlTy_yujM
 uY6UQm8G9MuGfmtDlxPZhVgknAqXsvGypGV04A9xjJd.BVLJfyuKknS3brVNNJY7myJZEfcLzYD7
 gjMVCHudlaRz1YI9GnisO3BGpKZzrgEd4uQm3nL675vp17oi2x90Fk9XZuVTZAaxcrcViwRQ9LE4
 O0oqfzKThAHy0Ok3Pse81DpG1kQ_ktJc2DaxfqWoQnoQ_q1vLs_wm.14Aqxc0CUg.uo0qHFMmtdA
 6yBvmXM5VIwRONOMfNjqMu9vuTHScXh7ZFNQMYIDcrLPy1WB0hoKf8CKFWMe0U__ya1JWoNa5sUP
 fs6ACFN3r3D3YvA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cc61f50f-88ad-4c85-965e-e8c63009379b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Mar 2024 17:44:44 +0000
Received: by hermes--production-gq1-5c57879fdf-nxlqc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 42b496c5feca52dd66810a39fac58910;
          Tue, 12 Mar 2024 17:44:40 +0000 (UTC)
Message-ID: <f4f5d993-552b-483a-9a3e-1be99ea48757@schaufler-ca.com>
Date: Tue, 12 Mar 2024 10:44:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, linux-security-module@vger.kernel.org,
 jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, mic@digikod.net,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org>
 <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
 <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
 <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRfwjsGiHXBRcWA6S9+H_kj0vMdQC0gyHr3ZnX-u7KzRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/12/2024 10:06 AM, Paul Moore wrote:
> On Tue, Mar 12, 2024 at 11:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/12/2024 6:25 AM, Paul Moore wrote:
>>> On Tue, Mar 12, 2024 at 6:16 AM Dmitry V. Levin <ldv@strace.io> wrote:
>>>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
>>>> [...]
>>>>> --- a/security/lsm_syscalls.c
>>>>> +++ b/security/lsm_syscalls.c
>>>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>>>>>  {
>>>>>       return security_getselfattr(attr, ctx, size, flags);
>>>>>  }
>>>>> +
>>>>> +/**
>>>>> + * sys_lsm_list_modules - Return a list of the active security modules
>>>>> + * @ids: the LSM module ids
>>>>> + * @size: pointer to size of @ids, updated on return
>>>>> + * @flags: reserved for future use, must be zero
>>>>> + *
>>>>> + * Returns a list of the active LSM ids. On success this function
>>>>> + * returns the number of @ids array elements. This value may be zero
>>>>> + * if there are no LSMs active. If @size is insufficient to contain
>>>>> + * the return data -E2BIG is returned and @size is set to the minimum
>>>>> + * required size. In all other cases a negative value indicating the
>>>>> + * error is returned.
>>>>> + */
>>>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
>>>>> +             u32, flags)
>>>> I'm sorry but the size of userspace size_t is different from the kernel one
>>>> on 32-bit compat architectures.
>>> D'oh, yes, thanks for pointing that out.  It would have been nice to
>>> have caught that before v6.8 was released, but I guess it's better
>>> than later.
>>>
>>>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ..)
>>>> now.  Other two added lsm syscalls also have this issue.
>>> Considering that Linux v6.8, and by extension these syscalls, are only
>>> a few days old, I think I'd rather see us just modify the syscalls and
>>> avoid the compat baggage.  I'm going to be shocked if anyone has
>>> shifted to using the new syscalls yet, and even if they have (!!),
>>> moving from a "size_t" type to a "u64" should be mostly transparent
>>> for the majority of native 64-bit systems.  Those running the absolute
>>> latest kernels on 32-bit systems with custom or bleeding edge
>>> userspace *may* see a slight hiccup, but I think that user count is in
>>> the single digits, if not zero.
>>>
>>> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
>>> compat shim if we can.
>>>
>>> Casey, do you have time to put together a patch for this (you should
>>> fix the call chains below the syscalls too)?  If not, please let me
>>> know and I'll get a patch out ASAP.
>> Grumble. Yes, I'll get right on it.
> Great, thanks Casey.

Look like lsm_get_self_attr() needs the same change. lsm_set_self_attr()
doesn't, need it, but I'm tempted to change it as well for consistency.
Thoughts?

>

