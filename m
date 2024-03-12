Return-Path: <linux-kernel+bounces-100436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFC879788
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12260284543
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213917C6D0;
	Tue, 12 Mar 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HLp8TxPN"
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC87C0AD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257287; cv=none; b=WXjGbvi78U49MY85XQUXvz937sWFgGLNB0KLZ/+M3cslDoQrAuSIJk3iwA6YnIUn31GfMvAX1Veb2fG2qA7qz61qa6tC/ZxBKGU2AhSDnnLXveGyasNdSKDZJlKgwhMTKvPK89AtJv/KUK8+k17XI0dc4Bi2x4JMO4o+jngCGog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257287; c=relaxed/simple;
	bh=5MJYpTNTNhUetTcUdghPwxeLV+FyZFcY1u3AGIcpjZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeWIH3vkZgME+5u76tw5VGFe9uADz4sbFbj1NSi+7fHeYpCumo8HFbCJs2vWLhhyjFGiZyUINjoPobiwMmUa4Iga0DdPNlK44A4D/2HngkpMw7xVpHXlqbRSbL3acdbcO1UA9xTZPCGoTBGP3EkkL2UUCWTxJRac+yRgKmTOM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HLp8TxPN; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710257277; bh=eGVPF7E1Lj3mHWTls/amPaEcn2mVOw9rawL5hlgBYKk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HLp8TxPNIJPkz69Ui9a1WEYC+4KHxartu8SSitkH+R/E0rOxA/cQZTqH5pzOdagGyB+e02y2NzwkI7zbRgYXHpJYhwNhNWjh/14TUFeZzchzvA0dMGdZ4b0qOy81pSGgy22H04sEGQP3gLFQl080UOxKBNVMLws76XL1HxdwJyk2yH65/cEAnTndAS/8AyaF8SURHLZ8ue3RtiwE+5mjhCBDk/XubHX7h6sJxNqpJchakr4Vz1hFrzf65HEhNJjH+YiGnLN5aTjMEkjJX8uNWjSIgBK9VRnLz+Y2V25IXBTOe6BuWSHpkothLXri+htAXK9KEwQIzW+4JdhsMbcBPQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710257277; bh=pmU62dXCIh+9gCpNR5ZrCUiEvNUy09Rq4Fk7k3ky77b=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=IbuCwWkdw2pyEaY6b8p0eBRXRtuLHgDRqAgkiQnLqsCi/h1nxl5FihYR8wRqMEVa+33Lg+sUEcDkb3Ix4fOnLAu9gZBQkbQyEUz/eQcp52ksdvzVmq/BTcQ6UOvfkqHALF8cc/12SXdTulwnrLyKzOptH3T7/+pWDtv0c3mH3vOKkTekbsnlhr7at4fdseqasoITf5SigDuayrW784FG0QpvNAJGoLGuoYl2d0LEUXkY/OeldpsUDhw0e4aoNVA6Ep2YIBZVFcMeqbylTgOroUmiQGTryKT3S8aefteJH8gdK2eOVUBJmdB2EsGrsPY1olZyj6od5np7c7snbIMffw==
X-YMail-OSG: b7OktG4VM1lWpvB9IRXTkQhMZIpWJbBRSPqfCu7rii1FCDHMrOQyacOsWI6kFL4
 d.n4mdfaGo15ZDP63JchbdRxwpTD0TFbCWHBroKr3YhStRtM4jlNfvZyhdGCfiw9Ufz.i3qb7f.a
 S5pbrvqQtiAtJqDbz9TPEstRy9zUb3Bij.4tVZkW392UIkU0NAAtz9gB6XmjyH1Gqk_92rh2VeuW
 ZZwwpCPcHuNcfrMSihoYuH_Z3_fS8NLJM66Vffgxcpx5eUVDtRh02sbWpxkbaZEodJhN5.eAodp0
 grjw89tSagGTMt.Aq8qOvnIStaBm0toWJM9PqkyB47IP7fgwC3GoIgkV.bcQXgSe9IjAOZ2hyj6V
 AcdOQbP5D8cbAOdLIk7ycTjxLu4uej.B6VVKshzGEXFYCNcnuryxHJhLFIqIgLqcQtaS2mRqyzrv
 Jse4FtX_8qMeGjB7Whdj7Y3VzJDtvhnE.nq31sWrtluTm57JZK715xaGEOmcwpHiJDEmb2cV5qIe
 7LuQuB03QygjGfcJmJz340rZmbacVmIGtkKgNC4Rgc7YzMdTPuZEVYYcuDijGXDlQQS3rzCY.LFQ
 v120AEm46e6W7W60kotgGaw_9uAXcMgvFDaYKkkwo7XOfqg7pI01NMFIaqGaMI6LGbwX004627PQ
 RsL3YbUsEHe281Q1iRw9EQunJftNJEO7SaTMUmJgVUWBBWUht87D9oZls3NfmhAlPeSGA65BAsbs
 wumr9l997vQc6EUO.cxVkq0a9gbVD1lQSTcDQB3cy4_B2LlN4Pti95p75jYS2ZXVRrbWMVOQkyEP
 TZ8kO3GjlegHX3oykL.4qPvfSpiYzNYO4VNQqn_Cu0rG16EsZwowoMt1Pug6ddjfFjGROrwbk82q
 xgLigTsllzzy4P3K3KX7HnAsC5IhQAMVkKAG7CgPsfbuPdjHu_1_ZRwBRsssUq3aNfFvSPXmO0_m
 5EZvN9GynKBiCuqlWfcTKArswzRWOzUtMfGIS1IjSsivu5TE3LAEs.y9ZSpdZLjTzF0q7WAYTerl
 1mi3hnGGgg6PS53F3uvZoGekTV3KArEmY66hKhpYoVvlWiwdcZzBIB4uDqJAepQWtR9iVOl5CJry
 X8JSUM1U.QWL0iK2ScNmzw4ho_sS9FvRHv6O7Jhr.mkEiuof8ZAatTpWo4pIrCKPeYHjHHRIzES8
 L45GivdLxKXQgvofmZFj7lHbjjdqYCALHWoPIEj8lqUoziSq4n1IFJw6AgOfcAT5uY9UiNvjew3P
 m4sbRHMCo1RBdIAP5yMlYnbV3ZGFajmVkeC6Sgom8E03sNADJA.Mz5g_eyRlnKKMW4tAAeztJY5u
 uGP6GyLPfaCjg.cBdTrDQDMJnr1Rqh7mU_usugKuqeQ2BVIeAKhRYXqDQNtCAYwgDQYKhpyqYxYQ
 LACd7qBzaB2zYoZLzNir3DlSziAuPUg06GH0ePfrDslsSywn4rFCJQDY9EAp1ynLzSpZ7qDtUdFO
 1WOHojMRtzQ8a2pW32Kp7KiShk1IqLifoVREndrJ2Z1JPshLZVjDxaa32hZ1JOlUkBAtv9RXacfX
 0IY_hqTfk7x8._xPxhsbgSXmRh4NA1CHrcvg7OlGnZhU0n3IvizlcND_uDAveImQqZzs1NTcZIWo
 WF02mLOKXDs7q18lbT_FtDfvDTCdusq8PuzQB3mmUgtmxjeddACvrGfGSvgslqQKqKyDvq9HlTNf
 rO95FjMuel.nsayWHv.TZWrla4dNuyaaKYWxt1rTMWhmxmWTx03qtgYHio.YS9CKtnmgv1kdMBGD
 zyZP5z.GW6DS.SjtmpX2.cZP6KEvmLgTM4M9WnS3VNTWyWy4W3aTmdIYgV870iWcSgXgdUGOdv5M
 sjBWZ449ZmXQlfl5ORf.Hae48jFQONt73MlEyL8zyLr1TSEAq4dARuqVHbEcy3vuh4J30I2K2EZt
 edkfJVHsoKMqsY5zr_ZXJnmwczRe7DwC1vPOkwer1k56xEx2nsRTKRKIoo3gEGPA5EubtVWDQpNn
 vDRKqTY0cLeMZxp2.eJQonIvD5omO_qp3Jtj5ijMRYlrUTxDlrbyzD09PuMv7lOMejSRnwVdBB3r
 I.zO1CjXgBNLhWyMaK4wgKSSX5VqQMBbbmj6JY.46s9.3vdAI6DFdAFKvIFmq.sWNDnaEwfIT5jo
 681ZiWJASXFwl6g6gefVkdDObqrl_hcl.Lj_VsoyK9eX0YihdjNhCC6W0_WeaHgwTem9slhfBDmv
 WoQ68vyp98ovW2FFD9AhbMVBdXLQazOA_Z__NET8IuMayknlK2wPxqvQkF438XLs1SR5UT4GM6zy
 M6GMHB5Mz5p_lXwWh7_A-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 67f0e72b-458e-49c0-991a-8ad2498ed3aa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 Mar 2024 15:27:57 +0000
Received: by hermes--production-gq1-5c57879fdf-hrd4s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fcf6ea82c067483bfc22e1d02e0654ff;
          Tue, 12 Mar 2024 15:27:51 +0000 (UTC)
Message-ID: <f122b3a9-1208-4c0b-9289-73eb070a8337@schaufler-ca.com>
Date: Tue, 12 Mar 2024 08:27:49 -0700
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
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/12/2024 6:25 AM, Paul Moore wrote:
> On Tue, Mar 12, 2024 at 6:16 AM Dmitry V. Levin <ldv@strace.io> wrote:
>> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
>> [...]
>>> --- a/security/lsm_syscalls.c
>>> +++ b/security/lsm_syscalls.c
>>> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>>>  {
>>>       return security_getselfattr(attr, ctx, size, flags);
>>>  }
>>> +
>>> +/**
>>> + * sys_lsm_list_modules - Return a list of the active security modules
>>> + * @ids: the LSM module ids
>>> + * @size: pointer to size of @ids, updated on return
>>> + * @flags: reserved for future use, must be zero
>>> + *
>>> + * Returns a list of the active LSM ids. On success this function
>>> + * returns the number of @ids array elements. This value may be zero
>>> + * if there are no LSMs active. If @size is insufficient to contain
>>> + * the return data -E2BIG is returned and @size is set to the minimum
>>> + * required size. In all other cases a negative value indicating the
>>> + * error is returned.
>>> + */
>>> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
>>> +             u32, flags)
>> I'm sorry but the size of userspace size_t is different from the kernel one
>> on 32-bit compat architectures.
> D'oh, yes, thanks for pointing that out.  It would have been nice to
> have caught that before v6.8 was released, but I guess it's better
> than later.
>
>> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ...)
>> now.  Other two added lsm syscalls also have this issue.
> Considering that Linux v6.8, and by extension these syscalls, are only
> a few days old, I think I'd rather see us just modify the syscalls and
> avoid the compat baggage.  I'm going to be shocked if anyone has
> shifted to using the new syscalls yet, and even if they have (!!),
> moving from a "size_t" type to a "u64" should be mostly transparent
> for the majority of native 64-bit systems.  Those running the absolute
> latest kernels on 32-bit systems with custom or bleeding edge
> userspace *may* see a slight hiccup, but I think that user count is in
> the single digits, if not zero.
>
> Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
> compat shim if we can.
>
> Casey, do you have time to put together a patch for this (you should
> fix the call chains below the syscalls too)?  If not, please let me
> know and I'll get a patch out ASAP.

Grumble. Yes, I'll get right on it.

>
> Thanks all.
>

