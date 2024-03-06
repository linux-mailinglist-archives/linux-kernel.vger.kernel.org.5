Return-Path: <linux-kernel+bounces-93677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2E3873328
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303811C23C5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487D5FB8A;
	Wed,  6 Mar 2024 09:54:33 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941845EE6D;
	Wed,  6 Mar 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718872; cv=none; b=oegBaSk3x3IIcKHESo3v9QzsgV1fu5OeIQirszMZgMuRJYX3UyHGV/VTxd9+nTOcT+67Dj5BzCBlUCXTaBY1fW4LZ1e0w6EeEaA1KTigdp2iGfKCNwdthsXvMDy/C+DTBOFXN/PxpRHaRP9lyO5eLP/X99CzQSE4cFD3n+Dd6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718872; c=relaxed/simple;
	bh=g5A8q0i+It4r0YbTVK+/ai6RQon457tpMoqkr4b3F24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ae0qMT081II5VP3nmRXs4Rm456GeOy9geqzbUDBB6v8r7Ytht8NIKi7ACKUUIpgRFZv0hQLcvGXadd1P5pgl/vIz4GjFyu5Kvo8urb+u7DuXRsjrRtTCnRWEBZz8ptwBh2k6i2Cx+rUGiAWw0NPuytQ5dp5iEO2I/rJCICT1jh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TqS6v3bwyz9yFFy;
	Wed,  6 Mar 2024 17:38:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6B530140412;
	Wed,  6 Mar 2024 17:54:26 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3bhdIPehlyA3RAw--.489S2;
	Wed, 06 Mar 2024 10:54:25 +0100 (CET)
Message-ID: <d4cbe23822f7fdac900d1ebd5da9865d8bb96977.camel@huaweicloud.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from
 security_audit_rule
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net,  linux-integrity@vger.kernel.org
Date: Wed, 06 Mar 2024 10:54:12 +0100
In-Reply-To: <20231215221636.105680-2-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-2-casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB3bhdIPehlyA3RAw--.489S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1fKryxKFyrtFWxJr15twb_yoWrCw45pF
	WDKF47Cry8XFyxGr9akw17u3ZaqrWrGw1Duws8C34qyFnxJw1DJr1ayr48u39Yq3y0yr1S
	vF1xWr4akw4Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5cHVQAAs8

On Fri, 2023-12-15 at 14:15 -0800, Casey Schaufler wrote:
> Create real functions for the ima_filter_rule interfaces.
> These replace #defines that obscure the reuse of audit
> interfaces. The new functions are put in security.c because
> they use security module registered hooks that we don't
> want exported.

Beginner question: what makes IMA special, that the audit subsystem
does not need an AUDIT_LSM field to do the same that IMA would do?

In other words, why can't we add the lsm_id parameter to
security_audit_*() functions, so that IMA can just call those?

Thanks

Roberto

> Acked-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: linux-integrity@vger.kernel.org
> ---
>  include/linux/security.h     | 24 ++++++++++++++++++++++++
>  security/integrity/ima/ima.h | 26 --------------------------
>  security/security.c          | 21 +++++++++++++++++++++
>  3 files changed, 45 insertions(+), 26 deletions(-)
>=20
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 750130a7b9dd..4790508818ee 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2009,6 +2009,30 @@ static inline void security_audit_rule_free(void *=
lsmrule)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_AUDIT */
> =20
> +#if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> +void ima_filter_rule_free(void *lsmrule);
> +
> +#else
> +
> +static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> +					   void **lsmrule)
> +{
> +	return 0;
> +}
> +
> +static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> +					    void *lsmrule)
> +{
> +	return 0;
> +}
> +
> +static inline void ima_filter_rule_free(void *lsmrule)
> +{ }
> +
> +#endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> +
>  #ifdef CONFIG_SECURITYFS
> =20
>  extern struct dentry *securityfs_create_file(const char *name, umode_t m=
ode,
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c29db699c996..560d6104de72 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -420,32 +420,6 @@ static inline void ima_free_modsig(struct modsig *mo=
dsig)
>  }
>  #endif /* CONFIG_IMA_APPRAISE_MODSIG */
> =20
> -/* LSM based policy rules require audit */
> -#ifdef CONFIG_IMA_LSM_RULES
> -
> -#define ima_filter_rule_init security_audit_rule_init
> -#define ima_filter_rule_free security_audit_rule_free
> -#define ima_filter_rule_match security_audit_rule_match
> -
> -#else
> -
> -static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -				       void **lsmrule)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline void ima_filter_rule_free(void *lsmrule)
> -{
> -}
> -
> -static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					void *lsmrule)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_IMA_LSM_RULES */
> -
>  #ifdef	CONFIG_IMA_READ_POLICY
>  #define	POLICY_FILE_FLAGS	(S_IWUSR | S_IRUSR)
>  #else
> diff --git a/security/security.c b/security/security.c
> index d7b15ea67c3f..8e5379a76369 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5350,6 +5350,27 @@ int security_audit_rule_match(u32 secid, u32 field=
, u32 op, void *lsmrule)
>  }
>  #endif /* CONFIG_AUDIT */
> =20
> +#ifdef CONFIG_IMA_LSM_RULES
> +/*
> + * The integrity subsystem uses the same hooks as
> + * the audit subsystem.
> + */
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e)
> +{
> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +}
> +
> +void ima_filter_rule_free(void *lsmrule)
> +{
> +	call_void_hook(audit_rule_free, lsmrule);
> +}
> +
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +{
> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +}
> +#endif /* CONFIG_IMA_LSM_RULES */
> +
>  #ifdef CONFIG_BPF_SYSCALL
>  /**
>   * security_bpf() - Check if the bpf syscall operation is allowed


