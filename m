Return-Path: <linux-kernel+bounces-102614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5384787B497
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F34B214EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71B5CDE1;
	Wed, 13 Mar 2024 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CQQhi+DH"
Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4805B698
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710370125; cv=none; b=BrsmXUnz2hGPZiWSPyDsVNeWTgyqQXqG7DeHc7Ze3yXGdy9ZiOnj8AcVELdEYNG60b86zPtKoUIfiTN6sthxoR9/ZgvSUgTz2vUvRAx4+TEnMclHVsbLCLjJBnVA7Sck1oF9JRjxnIETwpcbz8qHvFcXE98kmK3LXsfyaeWWQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710370125; c=relaxed/simple;
	bh=PyIOdhdZkqJVPJaxodCHSPWUJMB0XNUnKXDY2PM6CN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g94vvCuy14HOPX5K6fWi1j7x9OJqZixMSSxkt06k90jDJMqlxryOIALO0ZQggzSPNFCz6iH1CRJRdLppV9QHe0NyPtr9TxCCuElcfLoR+qx6u3ps+/LSKeyRcI4mLDg5FpXulUuzLDKzwsTqytrYTTjxEA4FLLEmIMEzoYjWZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CQQhi+DH; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710370121; bh=z9S5aNIbF5R8F8pTxplTgt6vTEckDoQattE+/knS+kg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CQQhi+DHf1flxAh0HOOgFdBAHW8cTqZpnuRw1D/F5yz03v3CigiHHyaHjP+HSJpkoSvAnKNcZfCgVihRVBxmb/ezhzGJr94hJgOAQgItM4T69FpyGOWVNxAXh7SUnk9DD7lMohdvEK2glY8TXNnQz79cUlia1BjKs8oWQcoI1Z93DzPXxwbQqKgsgTQL803bUROLhAl0KDT5vNggCPZw65lWaWApsXBBrz94JPxy4PDmu77+038Kat0gX8FZI+57TZdGpeLsT6My/vv7btAFou3T2DmWkH3on0a0+bNsEPQj5ZePZOyT5BqIHx9mD+5fITvhYcg41BE4rps/weCoOQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710370121; bh=ljoL8v2vJCbDJtdu4pF+iRbQbojj0OwRcUYNsKQPaH+=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IuhA+hql+9lQyaQAMxtZ++uW0DTyOfM0VunGWiCyfS/21smYgWA5Q7Gd+iPmTfX7N4I5sv0YaC2HCsVLfEr9M1rnJCQj92bXMrqunMaUldlns6WlWl5JeYQIrtOZTvIa/gz2GU2EFU6xowj/RnoVrXY7ypi9ZiWobJcY45H4wNdaPAq1xQo5ldpQPsh4u8qH2Lm5DZ/+yuvl3fNqsTsrQ5AhxdHVcz/+KFfUk+9T4oAKhVLLt23Fpe9195qCXnBvkKZcN+hZhRDZhs5Krko5JfdblZOxOqjLBVI0l4aqz4jNMDvGJ/vUHZ/AVddh0bNzyivZsAwx5vtUnHAB5BD/qg==
X-YMail-OSG: A8aHJgUVM1khfUo9iwkTjejN3UxcGK_Ds_wKaPOiqJpoWzf_Bio8hbIEsDm0AY6
 F2iXh_TPtYAi1EJn0af3PtqtS8kXJZ4BNZEnsfvU3j_VwQyjkVCm43MpxfsUIc0jLvNSU9VQryBQ
 19zNc.Z6tdStYeGmV6zDxS.FKxnWsEKtPWx1qbggcablKEuuG3.Jket9XAce1jU6Ik2Bmx8s0jLs
 .OJF6e3rEOLQGjnhf3C7p3wDvVgOx8PrDzNZJlaeQSrmQ9KjKq5z2vpZhmYIwuqNVYLU2aAqtO.z
 96mRGuwnV9N_lP76l6t2RaRIjRvlq96ESMz8wUjC327TLCFlLpf9e4ONdJz2oPJZEx2MA5J59W0_
 hVupUvh4JwGogp7cd_q2_ULWU17RHW5ixG4nHkV8cJYmuG6fGDffriCSf7RHTJXmwFxbMzv2OqSd
 9lE_uyq3xMowagcz9t0RauIAD925quHkYIg_X4VqpAYhVooo_srN1cxIQCXIMDEVVra.DezE9XIE
 wrV5Fg.3C.vjAefA2bSpLRUEzI14oWD2i6V4hjMyvEjTohQn_eRd_uD_M653WkDqyKnfB7xOYl._
 hz676XKkaBs8yzKmlKcS54GB2NvevrwiRmylUlEYKJWWZmqqTUHx803436Mc4RHNET2IMkXDQj9B
 hLl4yRabFMZT71SklyVKoTck3UISCDD0Hq9ig5RkS72RQlvJaNixDJcwUAGkHMuq_KfeJRO3scw6
 Ob_LAiEwK5pml3qIoMXAh1meHDVYis_9rwAYqg.kyvDa.u7pZQx_6KR88JI8sDYpL0OJ6eJv_hcQ
 GmjRNcRxzjrZEuCaBqM6qfOtrWfkVHJfjTjol6Ob8XAR1pwOL.k0MwDBixIfJ7Sw5wWap_1iKd7I
 kyN6U47sRVq_o9DTYQju8NmZSVqlc7Yc2_0fjBVcdW45XtUw1YygYgA3Mgy0RgIgcT6IdAbW4q0j
 .Fx8B6jhbQuvs8_znY8IMzTkBMwwDTdgMSb3ROTFN4HWgPosLcbxwRnq___f3DLY70240xxztum9
 TiPqszOvmjtjEWq93BvtPOox_mu6WqbclrZcj9Ke3if.TPY7I_IStRYk.WIGeqJtMnr3VcsMa_GG
 9HbGS59HK_tNnbyjiFFXSRnO6qkU5Z.STjrjFZ7PDals6oeJseoeVV7YMXF04RRNx6Brs.493mnB
 WHbmwDx.Pk9IFpY7MTbsPwgjQFmqgVxN7NJghrBys_jFeiMauAoZj.J9sd1oDuT.bec8MpZ_fAyE
 CdKzcR7VT1TrhnMMF4cz0QAcexUgKM8.7puaOSlnQzI4pGYET6oAWsRxLtPtNYIYjdQGYeGvZdus
 FbF7AmMVE4yB7RCqT_s9nsnFHn574yLGVDLP0FugiJiShve3HcKmTQib49znrffOB6A39o2rcN2A
 2FbHkzMvgL702R4oQ5EY3ZTSXJjrxsg2sQbM6d7fjTPqXcgY17cYR9eyFrjoX8H1qTsZ_KE0aXAu
 paIyf17ZtDuVpFUWAVeoUZR5aZ2ySbq9crAu30k26ntsNXCHaLKF8LP5pKnJOAwO0fJDuXngimK4
 IJzbcs2lHYIpKtJ_1VBVoI50QTEz0P2syT8oKIVShLor6Jvw.GZZDvF9hAeO4O85A6ZJnM8zqIw1
 nKfLwNXADpz_A0GDI6zMNjO1xAXdjvSAlJ0SP5_qwZfo.YMfA9rTy.QMki_ZcpKoS1HjdD9VhMlL
 ExE9WmTdJovRMH_t12QhSPJU4VaU8y6ilGc82LCMaA8w6udTnlHf3JysXVDNj_Qr47qQlOI_WAMB
 jsjWhziCetg936ksseYWFGEAJcbi7iLFEN3oSufP2WA5WREGc9mMH4eYyQFQhBOw1tgSvYknwQPZ
 LeDKRRm_PmzXCbRLOQyM86w0i1A1DT4s8enAVNxPC1DKGBPoAHDlIqaZ1oRP9.Hzz9J17qRhOSRs
 28byVM.PaBRxQer69j2aZmMdXlKt1JdvfmATVwJzq5MlHpLIbvUOqwzzBxkO94C4.KFLIgK8Ad54
 GDFzd4O4RwcfjspZeAhgUMOhsjcxwXLR7fnybJ2djl22WJFBiyEv2_lxD0aHuCNExrjYkPvRud5K
 TbtVHcX.p82vPCPFwaZQwIoYD7DecZyl1xULSzjfC9S4HWvWW6oSNUdDgC5gohuB3RtF.Mj_wzrr
 cbdzS4r_hgqfzam7xbkfIdNQOfhTq2ulr5PNy6rkOSLL1jGuvlRQvTa6fKBS6MStien5WYviPObo
 7.bgAhV61DYSOMCc_94hhkOhdrFp2MZdSvOHSQH6j
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 620a23b5-a15e-4b8d-afa5-6a5509c0d503
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Mar 2024 22:48:41 +0000
Received: by hermes--production-gq1-5c57879fdf-tnlsv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1755cffa5cc96e26b368b5bbd8d41f0a;
          Wed, 13 Mar 2024 22:48:38 +0000 (UTC)
Message-ID: <b5ebbb40-0dda-4595-a058-d5c3a6e800df@schaufler-ca.com>
Date: Wed, 13 Mar 2024 15:48:37 -0700
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
 <CAHC9VhTkvyWpvkejbFf-VJoTvUKVDGxBDYkKFdNrdgq4jy5i_w@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTkvyWpvkejbFf-VJoTvUKVDGxBDYkKFdNrdgq4jy5i_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/13/2024 3:37 PM, Paul Moore wrote:
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
>>
>> Thanks everyone!
> Unfortunately it looks like we have a kselftest failure (below).  I'm
> pretty sure that this was working at some point, but it's possible I
> missed it when I ran the selftests previously.  I've got to break for
> a personal appt right now, but I'll dig into this later tonight.

In v2:

diff --git a/security/security.c b/security/security.c
index 7035ee35a393..a0f9caf89ae1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -810,7 +810,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
 	nctx->ctx_len = val_len;
 	memcpy(nctx->ctx, val, val_len);
 
-	if (copy_to_user(uctx, nctx, nctx_len))
+	if (uctx && copy_to_user(uctx, nctx, nctx_len))
 		rc = -EFAULT;
 
 out:

This addresses the case where NULL is passed in the call to lsm_get_self_attr()
to get the buffer size required.


>
> # timeout set to 45
> # selftests: lsm: lsm_get_self_attr_test
> # TAP version 13
> # 1..6
> # # Starting 6 tests from 1 test cases.
> # #  RUN           global.size_null_lsm_get_self_attr ...
> # #            OK  global.size_null_lsm_get_self_attr
> # ok 1 global.size_null_lsm_get_self_attr
> # #  RUN           global.ctx_null_lsm_get_self_attr ...
> # # lsm_get_self_attr_test.c:49:ctx_null_lsm_get_self_attr:Expected -1 (-1) != r
> c (-1)
> # # ctx_null_lsm_get_self_attr: Test terminated by assertion
> # #          FAIL  global.ctx_null_lsm_get_self_attr
> # not ok 2 global.ctx_null_lsm_get_self_attr
> # #  RUN           global.size_too_small_lsm_get_self_attr ...
> # #            OK  global.size_too_small_lsm_get_self_attr
> # ok 3 global.size_too_small_lsm_get_self_attr
> # #  RUN           global.flags_zero_lsm_get_self_attr ...
> # #            OK  global.flags_zero_lsm_get_self_attr
> # ok 4 global.flags_zero_lsm_get_self_attr
> # #  RUN           global.flags_overset_lsm_get_self_attr ...
> # #            OK  global.flags_overset_lsm_get_self_attr
> # ok 5 global.flags_overset_lsm_get_self_attr
> # #  RUN           global.basic_lsm_get_self_attr ...
> # #            OK  global.basic_lsm_get_self_attr
> # ok 6 global.basic_lsm_get_self_attr
> # # FAILED: 5 / 6 tests passed.
> # # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 1 selftests: lsm: lsm_get_self_attr_test # exit=1
>

