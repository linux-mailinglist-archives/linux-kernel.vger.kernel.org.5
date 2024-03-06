Return-Path: <linux-kernel+bounces-94299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F17873CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 685E8B210B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB2C137926;
	Wed,  6 Mar 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sV2DtKmZ"
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1409137917
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709744227; cv=none; b=PI9b3oancpoub0sIiuLspZvY1JLEpxC/q+YDImSeD0deliHepFustlAXxzN3CLZ9mv435TL2BXWi4qFjyFQk2GqRI4paxKXolaYtCTiR6c5uP+7FDg55ZGC0guvYWFaHeIiLPOK19kIgV1myJA/GIQpqiRP8r3kTkJXY3iF13Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709744227; c=relaxed/simple;
	bh=DB+sDU/M+USWi3IkAkYPXXij67XzJa642gnHaaSiOns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMGB3l+VIHPdKoIMH+Ap5++7xamxesdtQmENVOBakuIn9YkyfU3XrxvKJvWI73lUlpSvwqwwQloQAgxCa8Uo23vGTRT0ssv4CgPZyBQgzAROo6S7qenwPe+0I/udaahGvAsBoEbZ46lE6HifiGTXcQbS3qSYGAHlwaxlOWdEAvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sV2DtKmZ; arc=none smtp.client-ip=66.163.191.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1709744225; bh=aNAjDWeJw8zalTZ9wVamqZVMgmFVPK14WsEI1ujAZJI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sV2DtKmZjaL+uTYLBLxqOx9SLTVY6RykUqUdzRvsIYKJ2t2YgZnqcQW5lA3JpTGkyBn4vfHV+dGOn6F6tQHpldS0cAo6Xd+DZ9nzFSEeDGRLNaXbf3jmLJGPgJjmRqS2DKrxUY3+1gqhhjX7haST495VT4tRm/vdcQ+ZRg16T0lC5W17wTKroJyqprEKhXueeHg7nEonxLUrW3ypNNICycWUnItSXBFNurO99CufaynGXpTIQpEJbEJspPxpyCB6B65zY0HnymFvInWbcEftLjOmudFGq2JWgE0tnbJykbFAh915xCIxppVVxipb8BmvwtpH2DPYTESgZDGUbqQw+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1709744225; bh=hT99byMjlTQzPqMcbNopNL4TqhusiS8HbWUebtdcOX9=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ajHZ+N6uNm5s+E/fUSYDSrjRrRo5ah2w+QQHlRMOaQonm/z/xWZ3JSXYKiQUyUXv1kJf9CkiymgOMMuq/ExOYYMMcF36VZaS6mNXpDOwfrvhOYxp1HqeZggwKpzwNuX/lKivRbksdvpp2CPK582aDSWIlcvdcZlB6XsVKFILPrR9q0dqdlNDTaU9HxUJrlZgcU9DrZFGZ74sCImLX06KBUBRYOVJXqsUo1xaScwmQxSceUPBrz0Fds2xp+mHSIGlpnRZq7yTQZiX3yPSWIYwSivQ9Yf5aMCu1WaWjjMuBtebzI1f/HFmzMMAIHYG4KdAB+wQnvVDQspS7anZmaAqZg==
X-YMail-OSG: bGf.osIVM1kTnWYb0egr0H0.6XCAHkRpE7FKdQE3BTVHCIfehvfwRRIYzVzZbj6
 TAslbBVQqhpaOCWxumDFKBt8BrKxE0MqJFPqGoek50I6gIy4WAy0VAqEaYZLktXlwULsm.58TOPD
 Ang.fYwEBq5Q.eUgVV0q._.UYebj3c5Pi4GmFlUHxba1QypBJWodTOUjXp_w7zUGc4Nmq7twr35.
 75a5pdJ9u.YZVnOwDH2SOubyCrRb1cXm623Hpud.OGRKnV.FlKAyvpJnZ_raFSAP2ceFrJe6xioj
 Nb2q3O39QMDK_1DbbFGifYU8o57R8quIcpsY.FKAaBJVzB54.BpYnm8eiciy.s1wGAxOCXgnxrNC
 CnnJYO.qX68.3lAszqiob1bs5OSxSGlfcZ5S7I9YP6a3wklYlMBWCZkLfrHXV2Tab5PJWTbP9V2w
 0KmTxNj6aymcR0T9.S7lc3y8y3gM43ElZWrnq8M5FMmg7v0YArckcr0ehm9lrGpQkgZDRpAJxy0Q
 m1Vh0ewRIpT_vgqtZjpYn73bCRFFH39YXB9q7j0S4Y7l_hw8bJIVnbt87dNKQQbeQAH9bRTBJYbO
 RQ1oFoDTyyI0sOzLgqdbjG4xNPbc6pfdbRSP4GNrihv.QaoQrwEpokXlcYAuS74DSbvIoGQfmIU6
 h8vsdhHpDaSwMz2s3Nq2u5UWYzR6ReKsp713_Hq_bJTgyQmwHy_EsvLym9gNjjU.QY6plPT9ldE9
 FqGBiSFNkOT53xW0MrCn9iwKxGmodVuSZsEMg3T3QT2azV9sqh0k29doZQ10f0iWRz4FXW5.cq0F
 Q6X6XqGatQTs.KqH.eFmx8fud7w3UJ2Wh18geOBJbenQivNR4djdmPWZfzAfZP9pm7a_Ttmufrk2
 9Hvush5dDpqpmeokFi6k_ZWg7ixtpbS7WhhBZz7GFxk487RmXkwwqR622IKik6QPBgHUu8eSDv3U
 M_D6x13XlMUuzP1MVpgRzpP6eptmZYeHuDxXQ3wnR8wb5SOqj8Tjaa2WQqP5OgxtvETphl1WKAFS
 IJv_4Z_Z4HLP1Pw0_kXhUZB3zQRq_XCXU_9UMX.eh2tNrErjXb4tkmDv8HDKE7GJyiVQsAzxYbQk
 KTvFkdfVpmsxTzl7aBuG9t1cUg7P7BXhDK_XfFLz61eWq9bxFx_ntt.C_b0txNYCG1SzFu70tvJB
 wSwBFWNNtPizmWRu6OL.GCWP0jjR8WMniItwA2i_7vQLm8pphLeiXWmq49zE5J9e6jlO4TARznU7
 ZWnbQnv.bYvMbIORhxml_wgeOB_v6VAqM_8_5FJsml7KYemCH2IjJVYJKcWR93aG2MWx2fy9Fuuh
 igYCdnOpTqrnMmK.wJ14MuzSMVLzx5ziQs1yNCZ9iP7ucDLPtbmnTc.wT5t7hvXlbrOo3UMKrYX6
 G2v46sjA3FOXVJt3_O8neKpJT1iOiD77NeXC8LjypMAXKijwDd.7kPVb5b_islB.hHvwdCnpaoSM
 Gb8swX_Cte4.nlEQzllzViLpAflUMxnT6lKH6i3c.PzZjzuslS1Y8MsxRzv5sjhBTOcM2TMboFZf
 rZLkTVTB3WUSymoVsctVo1cOuihEVDCU_6jC7_MGoo3.FAnWS5ryfbm.9hF_CsP_JmbrbpEBRbNm
 ZdUU9lcLmEs8_sKkv1j8ldClY60r51VFAcunt7HJO4yX1VvFqPv7pkzya3x_gksv6YX7Wfs_PINm
 uVtk7pNYHHPr4Om85xLTrWsfztg2q1UZqZ7YAG.5guLVx1NDWqKM8gin2hp37sxxmfR.at3c363d
 rS0wR0LxESCofSB3JukhBBXL2gI6CzH0epiKIJCOP5_.ah1XMewQTRK.8cBPHS0PXfoEDfnYsKkF
 beAkXHNUMfSbX25Jk8VZcLy0ONnj9ZlgSip4wxPL5Gmg7xmSZVpAQj.LzAag663p4c.0h1WhamBj
 981WxySdIxLZlI22ZQI7m1.ThV4yuMjQqNMzO1xhHBBNe.bdZShrmwW7w3Ad1m2u.r_1frYZPkfO
 CNIKC3H8e4RBG89NrgB_vNkEliNBpx6dSDhvt0RAjyYnnt6v_636.bg5JgI_8N5SSjhxsycHANUk
 etm.404j_sfJHOZZjp8_cXEwbHwqrg.t_WZr7toIxuHWiIp0zDcyYZfVNxWIapl.bR3wT36d6f6j
 qDE507ELgaIfFQ5PIgXnDIs.5MAhFKEQtQETpXa2wN17njfArJl.TS4JS.peP34uILF5m0o051Hb
 3.ezG8IJFfS3yrB8I60q.7hvrLZv6LMuiskZCcWSZmtO__qfvRZUD2x6_nbDkPkja.StcqYRBJtj
 jRESLtrcr
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8a719fc2-1256-4236-bddd-8849d178ba2e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Mar 2024 16:57:05 +0000
Received: by hermes--production-gq1-5c57879fdf-kht2b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 58294bfc0cc78b4b24de1cb3e48bb175;
          Wed, 06 Mar 2024 16:56:59 +0000 (UTC)
Message-ID: <5c99f987-d359-4366-984f-fe36fcff601b@schaufler-ca.com>
Date: Wed, 6 Mar 2024 08:56:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
 linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net, linux-integrity@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com>
 <d4cbe23822f7fdac900d1ebd5da9865d8bb96977.camel@huaweicloud.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <d4cbe23822f7fdac900d1ebd5da9865d8bb96977.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/6/2024 1:54 AM, Roberto Sassu wrote:
> On Fri, 2023-12-15 at 14:15 -0800, Casey Schaufler wrote:
>> Create real functions for the ima_filter_rule interfaces.
>> These replace #defines that obscure the reuse of audit
>> interfaces. The new functions are put in security.c because
>> they use security module registered hooks that we don't
>> want exported.
> Beginner question: what makes IMA special, that the audit subsystem
> does not need an AUDIT_LSM field to do the same that IMA would do?
>
> In other words, why can't we add the lsm_id parameter to
> security_audit_*() functions, so that IMA can just call those?

I have never liked the reuse of the audit filter functions, especially
the way that they're hidden behind #define. The assumption that the
two facilities (audit and IMA) are going to use them the same way, and
that they will never diverge in their requirements, has always seemed
questionable.

In most cases audit needs an lsmblob rather than a secid+lsm_id pair,
as there is information required about all the LSMs, not just the one
actively involved.

>
> Thanks
>
> Roberto
>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: linux-integrity@vger.kernel.org
>> ---
>>  include/linux/security.h     | 24 ++++++++++++++++++++++++
>>  security/integrity/ima/ima.h | 26 --------------------------
>>  security/security.c          | 21 +++++++++++++++++++++
>>  3 files changed, 45 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 750130a7b9dd..4790508818ee 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *lsmrule)
>>  #endif /* CONFIG_SECURITY */
>>  #endif /* CONFIG_AUDIT */
>>  
>> +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
>> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
>> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
>> +void ima_filter_rule_free(void *lsmrule);
>> +
>> +#else
>> +
>> +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
>> +					   void **lsmrule)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>> +					    void *lsmrule)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void ima_filter_rule_free(void *lsmrule)
>> +{ }
>> +
>> +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
>> +
>>  #ifdef CONFIG_SECURITYFS
>>  
>>  extern struct dentry *securityfs_create_file(const char *name, umode_t mode,
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..560d6104de72 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *modsig)
>>  }
>>  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
>>  
>> -/* LSM based policy rules require audit */
>> -#ifdef CONFIG_IMA_LSM_RULES
>> -
>> -#define ima_filter_rule_init security_audit_rule_init
>> -#define ima_filter_rule_free security_audit_rule_free
>> -#define ima_filter_rule_match security_audit_rule_match
>> -
>> -#else
>> -
>> -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
>> -				       void **lsmrule)
>> -{
>> -	return -EINVAL;
>> -}
>> -
>> -static inline void ima_filter_rule_free(void *lsmrule)
>> -{
>> -}
>> -
>> -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
>> -					void *lsmrule)
>> -{
>> -	return -EINVAL;
>> -}
>> -#endif /* CONFIG_IMA_LSM_RULES */
>> -
>>  #ifdef	CONFIG_IMA_READ_POLICY
>>  #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
>>  #else
>> diff --git a/security/security.c b/security/security.c
>> index d7b15ea67c3f..8e5379a76369 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>>  }
>>  #endif /* CONFIG_AUDIT */
>>  
>> +#ifdef CONFIG_IMA_LSM_RULES
>> +/*
>> + * The integrity subsystem uses the same hooks as
>> + * the audit subsystem.
>> + */
>> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule)
>> +{
>> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
>> +}
>> +
>> +void ima_filter_rule_free(void *lsmrule)
>> +{
>> +	call_void_hook(audit_rule_free, lsmrule);
>> +}
>> +
>> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
>> +{
>> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
>> +}
>> +#endif /* CONFIG_IMA_LSM_RULES */
>> +
>>  #ifdef CONFIG_BPF_SYSCALL
>>  /**
>>   * security_bpf() - Check if the bpf syscall operation is allowed

