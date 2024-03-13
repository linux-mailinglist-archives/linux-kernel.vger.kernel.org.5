Return-Path: <linux-kernel+bounces-102390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27A187B184
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CF528C184
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B91559158;
	Wed, 13 Mar 2024 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rjBx5ITD"
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1A524BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356285; cv=none; b=aqQBiq9SaXSKrK3jE7lT21YikIqsfbAfmRX+9MzbzUZqwG0VbrqcGbcfCWR/0zftEPOgwyFq1jZvoEYs+no0Iv4rJb2hENUhRMsezm/32eYAxfUlhvkGhRTAHQ/s7UdUMWOz44DmPMyU0Cc5S/A0vcQS+juYMwuksk1PlhiJ8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356285; c=relaxed/simple;
	bh=Vf9Ih6YnOrcj0la+uGb2Y6VUBox2tLzmIeU6nmWBAXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSNvSVoU/LcfPgnDjbp0UjtwjG4255rrOPw0zKBrjQ53jT8qEBPpokjijug+fzSLINCbEelL18OzldfYD8wJ68qfJlCzlkfbeJp7R7NJB53qD5nPpRsjByd+D3EujNIVmw80vbmo663QsrH5PhOYQMyL79B1G9/LgFBRXWArF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rjBx5ITD; arc=none smtp.client-ip=66.163.190.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710356277; bh=YyE0bpo7mkqejegnuc3LP+oOeUfGoXtaAdtgfPEkH6U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rjBx5ITDaaI0emvhuR1Y3x1yDZuoarCmeWzUWGTasMkSFUyT6zbwOfBzIu16AlSvz4Lb7dKgUhM2cRipxMT8UmkRprUXWTLsUlHS/VMnoYCUFF0ka2/ardWHN6kokM6NjvHV0CpKroOZ/s8glV36cCiRX9OJj4wgvEnsKptRz+mvjrtPJrp24laP03iVi/20zqfSKKN886QdeYjWsXmyt8IV47qtS6CRj/jTMf8Kcu2vYaNlutIbQOudhb/6erpAnef8vaf2l9J5MzIdR6VA+h7nFTKIFuV1rwGU+p7EA+QXE6cQtR1Z+Yc1FoUE9Dd1IwCQLGTr/JqtiYCH9shZjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710356277; bh=hbwNGNagOIBnzhTRpQZ/bX6erCK3e/FqBKFyEzil0R5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=WwbDlYdpJjI4K7sxLa/AO4oth90ILwPC3m+PVVGjf+V6HiI8bpnobb7y/kgnxac83jdHvnkI8AYvA8GYEdUNhbhloK/mmbHlynIGzmY3M5hVQNCZJJxoShjnBFmdFLkZFI4TU66BVxGSDJfkzSGAUfGzdY33Sd0V0GCssBWnztk7SuKYs2Rm9/cDWlaEciVIpo5YERCORf28Z5TT8dMKjBUXEP4yKxGSlOe4qp5k+7RBmcPrQtmg/pBE6KQglEz3dP9nddfAqqi8X0tqoHrnfUZy8SRvwRFmREuUr9uzL9yRfRIk7lVA+6hUWCPd5UaqjHVH4VzbKt3ySVTyVZEeSg==
X-YMail-OSG: et4lEBUVM1lN3hT.k0bD4MlXn7LnCKaA54TMjd0UF6K7xAjOc8yIM6qRd3O6Mbq
 BLOZIzwNXIvRrMANj01GQaHHI0QG86L_dTlnGQRj7lPqr8fIPYzpkOWO4.hsi8fJlwVd9wAy33jO
 rPHrK.PVdgoKpLFHLrqdJv4gcpf8KaGmTZsDJE4mJL_CCY8JVPG0Tex85TgP8zrNz34H2U09VpX6
 B8hknuJr8GEyZvXBEOPYl_t3IiQYpHhhisTJD7i_gfOKJo3Rm7_jj7fOmIM0oVQx.XgjJumHxmX7
 Hwcr7FTZgcgeXe0raVmQWP4448fXKBjykw7PdLaN95FtXOxuE4lvuoGNw.bGGxI_hyRR7vSJ8xHh
 uyIEeBIXI3HgwqdsB_Ju0QSRXCS9AH1fJeP.GwB7OaDQ43J_K_X_BGleUW.ZW0I6ymVFTYRXRWNt
 wwMcv5LSjS55jKRQ1MP5gXmr4APBHSa2bk1lurdJQVhGFKBet3RcgNg3VHn7_0dnQ9D2aV6MLDgM
 a8m_ioKPpLbIHIMf7xq5ajQgFYrxiRr9diA155PO7ZqdeNKNg2IdBLN8xkhRfFS2rH9Vgn7F1mEY
 Ikyy2wpIKsobVS.DemUAI.2Uk.WdI.kxAsjiPWUWJCuXZheHmGtuPyyXi.fFLen4E7IoZcb3yRKz
 mcrTJ_5Ur72Lgh5nbEIPkwC4wq.8rD__abd3JMPXUKJS43bbAIykOHeF66cfm343FMB_7WvbfJfk
 EW9iH.43ZBQl55g7EcCq_lq.6_2vdEOLEIXVti.1uKl4ngUo7shRricSi5OFiPzoLfoLH251a1px
 qVZs_vPto1Kbbs.9FfRtuWHplli8FX5kJ0StMl4zEMInLlu8Z2jR4LqIBD3r200Jp6y7P_0GZvIP
 3RmX__hb23ADotgwsdhScfYou0_BIRlS3XHWB6IRahuGjePVOL3Aj7s54FwDwDXWNqwkeWCBjf5B
 JtDe_.xKsUsh3xg_UTjpq1I4goOGCLRitj13byb68cn68jZQ24PH2C1J_Uil_nTtFOyl84rPw987
 AFpVtIAlM9ZsImDKCudUDfpCS.JI6qLrRDeIvk0urB9bbzAsZna9.V.TMPNLV7S8QsIuT_iLyw_R
 tJHGJ.wwn9NfZhxg1s1Trx4xGcTEOhC0NLq1zKGSzdTXZqfVTGaJtnEPET9bY9FvYdAkgDQ76WWz
 6NeNJ_v667zTRdiz3ltxtfg8bn.9uj0kN8ZRLEP8RyCfD0yRLXlyPrC9jndTfSfLBPGTgvAmZ0VQ
 IUy9YJyiSWGRAxuxtElc_nDbKQYgiMvOB0ogsDnRaXSo4U4HN4_ArvOqOub8i96P01K_QDOx54U_
 qZuw_l5fCQAFmiKKdlHHol9Jx2vWx7fWnM4tNvceeVVAup2oXYwAU4ETzsBPPtKu76FZXyfxTAMv
 wfz1_9GB7yq_cbM25XvNkPRDiyl1cDZx.oArOAYYzAuYfSeA.8nvDqJBYgKn2ehlFe7OL6NkwnJk
 5bjVfw3072oWMwh.nQ21cuipaWu3U17E1MO8grLWff_retZJ8jsRpoihMPKe3yumhiyrLuDKTEBi
 47gjwDxejt8dvdCkYUM4yMlLPrQaIlfbgJevjINBYjJunpoWk_vTcTHdYR_pkKPRsm_J9uDn9Rak
 CdWH9Sg95rxqChTcZvGdD90L3HHx6mxMnr6.KWDRw1zXJBCvrQRUYGrgFBj6hlF1qbI4huMQvW1v
 7wzaynADtoMDMhp_pAV9V9B8rtdRKs0MhAaRVQ3N9p35jqX9CSdE24hhZCeN6HrWJlS4ER0lBDt9
 I8ntmIdg7V1Sh4UHaGrJkg28K86wXTXazK25B2RXaalyb208ahUjfS5gNZsTtOPhVIrcHxhYVqZU
 CV8DI_LwZdMJEVh7Oe1nqJwMwCZTKxux2BhzTfJTsarV5f1cCaKtj4reLWD0NHO7OSr0CBgnTETh
 iOGYNrvULDd0GUHsPQSUs.1lA1cNIsOP3GVzmKW7PO6Wpuki4m0xAObUx414Ay4VFd2Le.ow_wdZ
 fFFx4Br0L5XDsI0rW.HogpQYLC1JEfb2reZtfoVPQH9dej9dCjVpZwG59NYlgKsLMzKkRRLa5NAc
 kVftwrdUD2ITKLu3ny8HSbNtAOiU853_IYbimDHppcffYiAoaULf.9KZcFHV0H_X0P2KcEnmRLUF
 U.YanBqq2cMybMHm4UW2.v8LCqvLt5P0IRuANbvrjX6_e8WFAnRcIanDy0kipVq31MfMGI3WEL7O
 5NgOb1HWxasp5jAyielmhcl5Coa8FU5459nkZUEdApcWM668fttchwZrxmSxyR8nbuna.rH.1Enu
 oucfzmuqrPiqXZW43sQU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 491f6f51-7db3-4805-871c-f68815c1f07a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Mar 2024 18:57:57 +0000
Received: by hermes--production-gq1-5c57879fdf-vxz7c (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0a4b546e8a707589b2da10e2ab30b66d;
          Wed, 13 Mar 2024 18:57:52 +0000 (UTC)
Message-ID: <5a1cf6bc-ac51-44e3-b3d3-ade727781cf6@schaufler-ca.com>
Date: Wed, 13 Mar 2024 11:57:52 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] LSM: use 32 bit compatible data types in LSM syscalls.
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
References: <045f54ea-4057-43b8-81e2-5cc1b3966d04@schaufler-ca.com>
 <6353ba2abd868cd83186f54e7b71c840@paul-moore.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6353ba2abd868cd83186f54e7b71c840@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/13/2024 11:46 AM, Paul Moore wrote:
> On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
>> LSM: use 32 bit compatible data types in LSM syscalls.
>>
>> Change the size paramters in lsm_list_modules(), lsm_set_self_attr()
> s/paramters/parameters/
>
>> and lsm_get_self_attr() from size_t to u32. This avoids the need to
>> have different interfaces for 32 and 64 bit systems.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> We should add the following 'Fixes:' tags as well as a stable marking:
>
>   Cc: stable@vger.kernel.org
>   Fixes: a04a1198088a ("LSM: syscalls for current process attributes")
>   Fixes: ad4aff9ec25f ("LSM: Create lsm_list_modules system call")
>
>> ---
>>  include/linux/lsm_hook_defs.h                        |  4 ++--
>>  include/linux/security.h                             |  8 ++++----
>>  security/apparmor/lsm.c                              |  4 ++--
>>  security/lsm_syscalls.c                              | 10 +++++-----
>>  security/security.c                                  | 14 +++++++-------
>>  security/selinux/hooks.c                             |  4 ++--
>>  security/smack/smack_lsm.c                           |  4 ++--
>>  tools/testing/selftests/lsm/common.h                 |  6 +++---
>>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 12 ++++++------
>>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
>>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
>>  11 files changed, 40 insertions(+), 40 deletions(-)
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 7035ee35a393..a0f9caf89ae1 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -810,7 +810,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, size_t *uctx_len,
>>  	nctx->ctx_len = val_len;
>>  	memcpy(nctx->ctx, val, val_len);
>>  
>> -	if (copy_to_user(uctx, nctx, nctx_len))
>> +	if (uctx && copy_to_user(uctx, nctx, nctx_len))
>>  		rc = -EFAULT;
> Hey, where did that @uctx check come from?
>
> I'm trying to work through if that is a good/bad change, but regardless
> of if we want to make that change, it really should be in a separate
> patch as it has nothing to do with the syscall parameter changes.
>
>> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>> index e0e313d9047a..288302a444e0 100644
>> --- a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>> @@ -76,8 +76,8 @@ TEST(flags_zero_lsm_get_self_attr)
>>  {
>>  	const long page_size = sysconf(_SC_PAGESIZE);
>>  	struct lsm_ctx *ctx = calloc(page_size, 1);
>> -	__u64 *syscall_lsms = calloc(page_size, 1);
>> -	size_t size;
>> +	__u32 *syscall_lsms = calloc(page_size, 1);
> I believe that should remain a __u64 pointer as we didn't change the
> first parameter to lsm_list_modules().  I'm guessing this was an victim
> of an overzealous /u64/u32/ search-n-replace going from v1 to v2.
>
>> +	__u32 size;
>>  	int lsmcount;
>>  	int i;
>>  
> In the interest of speeding things along, I'm happy to make the above
> changes while merging Casey, but if you would prefer to do a respin
> that's fine with me - let me know either way so I can plan accordingly.

I'll respin. Shouldn't take very long.


