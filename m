Return-Path: <linux-kernel+bounces-103523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2787C091
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE65284818
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C471B5E;
	Thu, 14 Mar 2024 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="NCdKil5s"
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E271723
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431117; cv=none; b=PcCvY7EhUBi8SSlJLIjGu0y+pi6DQ4KZJcSgXkKq8nKQeXqxRBffrQX5ohybQILIssKgIFavEEgpUkuURg1C8i6OlA1r3Z9/1zM6pjrowWeT/Rno46qsIJqdUbnBkE1kIaK8fdy0WlnO3RlcjL/MXqLPAL6OLJ5/zXH9u7lGitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431117; c=relaxed/simple;
	bh=X6GVf77QHFHhrmJdArapDFzCy+gK/1Zhmshh68BMYQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EV7xY5EVyZWCoQvPGFcQAZ4CfF4c7aO8ltBoaBSuS8G5AX1msxiAFVxtZCoWY9b21t9krehq92DHi+VpBe66zuartVs8f1LlMZ5o6vN4cF6NmPx0cV/2J2Z3hNvZoyzARZ4mJ4b4ZHnKTzYT3NEUfBwJ0aYpliJyH5BR7TrKJJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=NCdKil5s; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710431114; bh=8EdGV2Ns74qItVMaHvWmbG1wZxhXh/FfHvPHV0OlpOc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=NCdKil5sEtfvyvhM5af1/zqWMUswzlPPEX4/aqiL5QlQGvxd2rZJRHgdEg3Shzm1xaAEU9BgAZHCSsKd563AK87wH/s/MPQr8k8kQJyNjR657Zy24SSC2+F1L/ELTlyOKooWyHYSWCHnOBKdSjlVpAMfleIbLaG1LDXhiDAgaLA8GP6eaKusdxG6AmouRYfVYhGvDu6yWjb6EY9TpjhcpPaA/XEemrUTmjhbRAERuRMxg81i8TSGgl/itWXf1PNwG9jLIaWre6mT4rCIfAEQ6/Y5Pndr+sJ4nbFdgsK+3fmI2ptJUd2F1HCMkz56fgM9laCd3h8ZBL0NxcHZWkCgnQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710431114; bh=BRi+Xj8uw/pP48hQAO/VOLHbt298B27x+mDkZuyEXYC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hngavXBPi+5u/51/rw7rwEJo+216xHHh01wAc9/QCTHXzscMukav1tehCReKPQDflP0ViBrRgsZpLvqlGwQyY+88iIl5HSim83VB8wHSYLGumcjKxBMCiRoMGqN5uz8jt75/X0Df4CoZU2MQybQ9oYzU/WxtYGHXiwdqeY2MvLzsngpRPcoS6tuTmtpCYP+ZFbNAVCCjsFxenu4lFc9JaCsHSD6lTBH43wEz0a4vpf9PQN50oUhMZKzam4l+bEqCXsvm+gc9Y9W3+AnIfQn1wlQmZ32FQwAHyHmBNj0r1VL+58rYJUUj2qho7srW7ZfdZ2DXUKIkDsIown9AWtc9iA==
X-YMail-OSG: OswY.MEVM1lw2YJNbe9jOi94L8qZp2dTKN1PX8OmM9C7h5zz86qA28zh2ztwhYi
 XaRl1TpWTNfUW30jCCA6BDZ87u.9da6mlwy98blU0i90rQpZTfHPpt20KmyE0BfDbliTpx6LKIz4
 U9eOWhr5QBEHheoCXIrOYJwWZmu3phRWKlKabjDLadqYdRB8K4WH5au1bf.WYe1zvyIqi_OpCjbI
 TwQz8slGTaLiI0N0OQx2cFd3As5fQ1diqJKMG_QHW9zzGcKfubJg8TU7pHfxZq7sGqkxKNLgaOQI
 qkZUxhaCMinrqubPT4Rxcxikd5RZL5wj9FDFdK5wHYOAzkE9AJIETnVB0uImMHYbc6n_rVKFr9f.
 4mRNz2uWmVsa2DaZu5oGo6IKd71Vi403ns2tj15iJ30ucoMS54J7rtQgADw6EvxSMuXrj7lSa_kC
 QtZHpf9Wuv6llt7WjdWGcKgphz4mfjZFBHbM6P5b7UPF5XnlayUSxUrYau_Bl9X7h.zooQl2yQBS
 4xLuusnKbu74Gs294BZYGqiaWdWHKsRFCFos2xgUMs07wpW7l7.m_iR7N6GXDe8DGDghA6BgfTur
 TpoTXNldsM9bMH7CJR0ZBzQ0axevPwJCiUmI7CK6iYzTq6t0w6n0BSDYI9kznXEMBSHxIH1y7Oo3
 PoKL1Og0_IUTYi9Q3xE8B_7PotnBHtkIwSU9aHzi6U7pYBiOHALzHRASKex753xeIiwt8BZNy6Me
 kY2RjKai3S4P9vB7HjUKPltOHjutpFfhzP2mkuC3eI1ou4s6B6QKpHDGU.EvVKewvuOFMIW3v6sf
 6GibJd6eEel04Si4oP_NqiGBrtl2cT1N6Yh5u0_iEdAKC4EH8o7cTR2I.OKTxEeRcODCiACl.bbG
 as1gHxkmcG7OytqDBuwglluv5bn9mk5nDopRHDgvyAf5goTTkOeSQ27_HD3lkHHrI_z.vlu7c_kJ
 5w3XR8agxNFPKwjcaJzvWpMx7LG0mniRHTo2p6HwEUPAjhG43aLnp1jPIQTIrnN_zYX.ePBsY7KI
 9KvOBdiMWP1JBOoKh2DGCKeM6gOdrUCPWFi4Kppyw2I0O9MDdjEkQvYr6mP_qq.lsQBQoK7I1o8x
 pWJZBXVP7d8rJ.gH92OUAvWY6lmoQCc8U9Tget44tKUMtWUbNgBTxs1yiXN0ECGBCwq63XJNIwcu
 xnUvwxRjvtXjmojF2mwHzDb.XMwEx9T8DbAq.mwTGYrsmMtjdBSTPrgwMtw1vw8ioNyWDNX1XxVM
 Uc2rEp24FFHrGou429zqm2OhXW5DQbzplMR_qSCrnlbRrZul.O5GhZfHQesCuMrQpmnRbWp5Ol9M
 0OdOjAVMQq5bAwXNeVKBTeDUdoPhaMzBEfbDwmizm9Vi4JN1CIruUjO8XsqrKXzzceIcFG0uJPuV
 R.Ra0v98Q4.hgVtCa6IRu5IZqPXOziol9V6fgJ499pcBDDDYRtMbfDG8.RNjCrARhh5o7ZnqPg8c
 QaHX5lSvpylbUm9J21QHjKpBCXNoBIGKNWgdYQs_YxLRr1GCl5OWZowKQdb014YAGrEFTaTxSmxR
 trhbqVNbKinaX55X6.eGyhgyhOsEz8GraA2DRk4qIxvRsuOJnEzLhe3Iq5ZuBGhplsUiCfn9U5qw
 423tQF_Req52FgbW72CuWIdoqZr_S9SM1oIXBVtQ9LM7fN.dBftLWErwMPZVown8NZ0EgPeDIbba
 JkNVltdPjjiYgslE6w.nuRgHu5GYrS7w1q1W4EHIDG2zlKuBVb8kNUAgdG3e2JiQgw5jAQV_EWLA
 pbOWh178kKgKGgXywSnYK.J1QdGCQRUqPXigSDApS1_M94TsK5xbPTv6P2VXkuIQpMXyiR1mLLkL
 TmZm_ZknP2PuqUdXqxANc_6ibrBZpsJ4CbXuO3AFS.tsm0d8dMNdAA9SSBsEYCZ9hBRRsnG1b5sk
 dpYJloyzgpjEKP69A9Y11gs0mgpPKQgMdnUQY3KisjwIM1xkjPPf8SWkIVbipyqDEp6F0eOJhkuB
 ha07IZyH6Be_Qjp6.2xxMxOTUj93DO2X6PIsyvIYZxbpvXQ1jYCoXV7bgU7EG5T4Lz5dO6KFRg24
 Z_3_qZ1PMyBrUeB5hPG1ydLGk3xmxlOWCT67IZxLDXl40bOfoN2kg7Asgb.KJxpT.fH5zewS3y2o
 IPZc3pK1ma4J0krJUUC1TSclXNN2h_wbBduCdDPmKEAQmGagxoKrq8lha9eOxLL36RMfqt3d2qMz
 s1hU6SxAkfgNPaRGk9iJCZc.as1sLneRk.w4PGpxxum4_an5RUJ7vjeyePImQpI1CFLDBypMo6De
 srvd2DlOIcJtSKNIBt9I-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8795c96f-0b92-45b7-bdeb-0068ece329e6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 Mar 2024 15:45:14 +0000
Received: by hermes--production-gq1-5c57879fdf-tnlsv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6288dba7af8c7caaec0833e884a1eb80;
          Thu, 14 Mar 2024 15:45:10 +0000 (UTC)
Message-ID: <22cc14d6-0c5f-47d7-9505-44c595d67a29@schaufler-ca.com>
Date: Thu, 14 Mar 2024 08:45:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, "Dmitry V. Levin" <ldv@strace.io>,
 LSM List <linux-security-module@vger.kernel.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
 linux-api@vger.kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, James Morris <jmorris@namei.org>,
 Serge Hallyn <serge@hallyn.com>, John Johansen
 <john.johansen@canonical.com>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
 <ef972e0088964722adffc596d38b0463@paul-moore.com>
 <CAHC9VhQc-DEf=kSxbG-Mvz8jq-gxkaCe2jHb2a9LsJLQydj1zQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQc-DEf=kSxbG-Mvz8jq-gxkaCe2jHb2a9LsJLQydj1zQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/14/2024 8:30 AM, Paul Moore wrote:
> On Wed, Mar 13, 2024 at 4:07 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> LSM: use 32 bit compatible data types in LSM syscalls.
>>>
>>> Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
>>> and lsm_get_self_attr() from size_t to u32. This avoids the need to
>>> have different interfaces for 32 and 64 bit systems.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
>>> Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
>>> ---
>>>  include/linux/lsm_hook_defs.h                        |  4 ++--
>>>  include/linux/security.h                             |  8 ++++----
>>>  security/apparmor/lsm.c                              |  4 ++--
>>>  security/lsm_syscalls.c                              | 10 +++++-----
>>>  security/security.c                                  | 12 ++++++------
>>>  security/selinux/hooks.c                             |  4 ++--
>>>  security/smack/smack_lsm.c                           |  4 ++--
>>>  tools/testing/selftests/lsm/common.h                 |  6 +++---
>>>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
>>>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
>>>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
>>>  11 files changed, 38 insertions(+), 38 deletions(-)
>> Okay, this looks better, I'm going to merge this into lsm/stable-6.9
>> and put it through the usual automated testing as well as a kselftest
>> run to make sure everything there is still okay.  Assuming all goes
>> well and no one raises any objections, I'll likely send this up to
>> Linus tomorrow.
> I had to squash the code snippet below into the patch to address a
> build problem identified by the kernel build robot.  I'm going to keep
> Casey's sign-off and Dmitry's reported-reviewed tag as I feel this
> change is minor, but if anyone has any objections please let me know
> soon.

Looks fine to me. Thank you.

>
> [NOTE: cut-n-paste'd into email, likely whitespace damage, but you get the idea]
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 77eb9b0e7685..e619ac10cd23 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -960,10 +960,10 @@ asmlinkage long sys_cachestat(unsigned int fd,
>                struct cachestat __user *cstat, unsigned int flags);
> asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, un
> signed int flags);
> asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> -                                     size_t *size, __u32 flags);
> +                                     u32 *size, u32 flags);
> asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> -                                     size_t size, __u32 flags);
> -asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
> +                                     u32 size, u32 flags);
> +asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
>
> /*
>  * Architecture-specific system calls
>

