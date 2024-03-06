Return-Path: <linux-kernel+bounces-93713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A02518733AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505EE282973
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C678C5F847;
	Wed,  6 Mar 2024 10:10:10 +0000 (UTC)
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE6C23772;
	Wed,  6 Mar 2024 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719809; cv=none; b=YMjQsZCrD86wjqXV7faasTZ7TrQSA/zyT1GxzVug/7394/UgMWaoBN6AN3hwj+aKJ968+XfWps8ucyDEU63IvdRybTvfmDwvEexHF6m1wGjq07hAhkhdMUqSX9F3zRFUkNknTOiB7L91z7ipEz+kDAzdGGh5Yz7WNtZHDY+K0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719809; c=relaxed/simple;
	bh=6VX3qfy07qJwhOAc2oun6EUUZ3CqsFWndiHi6GS6jpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afHMggTymaVy/SOVquyXVOer4b3HvYvtDPBL+i4o7OB7W8wZuIilxAU465nu7GN5AR/tTyV0qmkTpxd/nDbBM1LiBj26lSQawI1jQxWARJ5woJYyX5/lzFPL3TZyRWbr8IJ/Y4HihkpLFO9S9kQNEPUtNk5psA9qiQY+kakqWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4TqSN53MHSz9xxd7;
	Wed,  6 Mar 2024 17:50:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E28941405A0;
	Wed,  6 Mar 2024 18:09:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAnEyfhQOhl1GbIAw--.64487S2;
	Wed, 06 Mar 2024 11:09:46 +0100 (CET)
Message-ID: <c764944e8dad89fd88129168b7fc19fd9948e37a.camel@huaweicloud.com>
Subject: Re: [PATCH v39 04/42] IMA: avoid label collisions with stacked LSMs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com, 
	linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
 john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
 stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
 mic@digikod.net
Date: Wed, 06 Mar 2024 11:09:33 +0100
In-Reply-To: <20231215221636.105680-5-casey@schaufler-ca.com>
References: <20231215221636.105680-1-casey@schaufler-ca.com>
	 <20231215221636.105680-5-casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAnEyfhQOhl1GbIAw--.64487S2
X-Coremail-Antispam: 1UD129KBjvAXoWftr4kKF4xJFWrZrW8JrykuFg_yoW8Kr4xGo
	Wxt397AF48GF1fCw40kF4DJ3yxZa4fXrsFvF1Yqrs8J3WaqrnxKrWUJr1fXFZ5Wr4kXa1I
	9as7A3yFva18t3s5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAOBF1jj5cHfgAAsX

On Fri, 2023-12-15 at 14:15 -0800, Casey Schaufler wrote:
> Integrity measurement may filter on security module information
> and needs to be clear in the case of multiple active security
> modules which applies. Provide a boot option ima_rules_lsm=3D to
> allow the user to specify an active security module to apply
> filters to. If not specified, use the first registered module
> that supports the audit_rule_match() LSM hook. Allow the user
> to specify in the IMA policy an lsm=3D option to specify the
> security module to use for a particular rule.

I was hoping somehow that we can rely on the concept of default LSM
from the LSM infrastructure, so that the extra option would not be
needed.

Roberto

> This requires adding the LSM of interest as a parameter
> to three of the audit hooks.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: linux-integrity@vger.kernel.org
> To: audit@vger.kernel.org
> ---
>  Documentation/ABI/testing/ima_policy |  8 +++-
>  include/linux/lsm_hook_defs.h        |  7 +--
>  include/linux/security.h             | 26 +++++++---
>  security/apparmor/audit.c            | 15 ++++--
>  security/apparmor/include/audit.h    |  7 +--
>  security/integrity/ima/ima_policy.c  | 71 ++++++++++++++++++++++++----
>  security/security.c                  | 64 +++++++++++++++++++++----
>  security/selinux/include/audit.h     | 10 ++--
>  security/selinux/ss/services.c       | 15 ++++--
>  security/smack/smack_lsm.c           | 12 ++++-
>  10 files changed, 192 insertions(+), 43 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/tes=
ting/ima_policy
> index c2385183826c..a59291b97c24 100644
> --- a/Documentation/ABI/testing/ima_policy
> +++ b/Documentation/ABI/testing/ima_policy
> @@ -26,7 +26,7 @@ Description:
>  				[uid=3D] [euid=3D] [gid=3D] [egid=3D]
>  				[fowner=3D] [fgroup=3D]]
>  			lsm:	[[subj_user=3D] [subj_role=3D] [subj_type=3D]
> -				 [obj_user=3D] [obj_role=3D] [obj_type=3D]]
> +				 [obj_user=3D] [obj_role=3D] [obj_type=3D] [lsm=3D]]
>  			option:	[digest_type=3D] [template=3D] [permit_directio]
>  				[appraise_type=3D] [appraise_flag=3D]
>  				[appraise_algos=3D] [keyrings=3D]
> @@ -138,6 +138,12 @@ Description:
> =20
>  			measure subj_user=3D_ func=3DFILE_CHECK mask=3DMAY_READ
> =20
> +		It is possible to explicitly specify which security
> +		module a rule applies to using lsm=3D.  If the security
> +		module specified is not active on the system the rule
> +		will be rejected.  If lsm=3D is not specified the first
> +		security module registered on the system will be assumed.
> +
>  		Example of measure rules using alternate PCRs::
> =20
>  			measure func=3DKEXEC_KERNEL_CHECK pcr=3D4
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index c925a0d26edf..2159013890aa 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -392,10 +392,11 @@ LSM_HOOK(int, 0, key_getsecurity, struct key *key, =
char **buffer)
> =20
>  #ifdef CONFIG_AUDIT
>  LSM_HOOK(int, 0, audit_rule_init, u32 field, u32 op, char *rulestr,
> -	 void **lsmrule)
> +	 void **lsmrule, int lsmid)
>  LSM_HOOK(int, 0, audit_rule_known, struct audit_krule *krule)
> -LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *l=
smrule)
> -LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule)
> +LSM_HOOK(int, 0, audit_rule_match, u32 secid, u32 field, u32 op, void *l=
smrule,
> +	 int lsmid)
> +LSM_HOOK(void, LSM_RET_VOID, audit_rule_free, void *lsmrule, int lsmid)
>  #endif /* CONFIG_AUDIT */
> =20
>  #ifdef CONFIG_BPF_SYSCALL
> diff --git a/include/linux/security.h b/include/linux/security.h
> index d4103b6cd3fc..2320ed78c4de 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -286,6 +286,8 @@ int unregister_blocking_lsm_notifier(struct notifier_=
block *nb);
>  extern int security_init(void);
>  extern int early_security_init(void);
>  extern u64 lsm_name_to_attr(const char *name);
> +extern u64 lsm_name_to_id(const char *name);
> +extern const char *lsm_id_to_name(u64 id);
> =20
>  /* Security operations */
>  int security_binder_set_context_mgr(const struct cred *mgr);
> @@ -536,6 +538,16 @@ static inline u64 lsm_name_to_attr(const char *name)
>  	return LSM_ATTR_UNDEF;
>  }
> =20
> +static inline u64 lsm_name_to_id(const char *name)
> +{
> +	return LSM_ID_UNDEF;
> +}
> +
> +static inline const char *lsm_id_to_name(u64 id)
> +{
> +	return NULL;
> +}
> +
>  static inline void security_free_mnt_opts(void **mnt_opts)
>  {
>  }
> @@ -2030,25 +2042,27 @@ static inline void security_audit_rule_free(void =
*lsmrule)
>  #endif /* CONFIG_AUDIT */
> =20
>  #if defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY)
> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e);
> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule);
> -void ima_filter_rule_free(void *lsmrule);
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e,
> +			 int lsmid);
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
> +			  int lsmid);
> +void ima_filter_rule_free(void *lsmrule, int lsmid);
> =20
>  #else
> =20
>  static inline int ima_filter_rule_init(u32 field, u32 op, char *rulestr,
> -					   void **lsmrule)
> +				       void **lsmrule, int lsmid)
>  {
>  	return 0;
>  }
> =20
>  static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
> -					    void *lsmrule)
> +					void *lsmrule, int lsmid)
>  {
>  	return 0;
>  }
> =20
> -static inline void ima_filter_rule_free(void *lsmrule)
> +static inline void ima_filter_rule_free(void *lsmrule, int lsmid)
>  { }
> =20
>  #endif /* defined(CONFIG_IMA_LSM_RULES) && defined(CONFIG_SECURITY) */
> diff --git a/security/apparmor/audit.c b/security/apparmor/audit.c
> index 45beb1c5f747..0a9f0019355a 100644
> --- a/security/apparmor/audit.c
> +++ b/security/apparmor/audit.c
> @@ -206,10 +206,12 @@ struct aa_audit_rule {
>  	struct aa_label *label;
>  };
> =20
> -void aa_audit_rule_free(void *vrule)
> +void aa_audit_rule_free(void *vrule, int lsmid)
>  {
>  	struct aa_audit_rule *rule =3D vrule;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_APPARMOR)
> +		return;
>  	if (rule) {
>  		if (!IS_ERR(rule->label))
>  			aa_put_label(rule->label);
> @@ -217,10 +219,13 @@ void aa_audit_rule_free(void *vrule)
>  	}
>  }
> =20
> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +		       int lsmid)
>  {
>  	struct aa_audit_rule *rule;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_APPARMOR)
> +		return 0;
>  	switch (field) {
>  	case AUDIT_SUBJ_ROLE:
>  		if (op !=3D Audit_equal && op !=3D Audit_not_equal)
> @@ -240,7 +245,7 @@ int aa_audit_rule_init(u32 field, u32 op, char *rules=
tr, void **vrule)
>  				     GFP_KERNEL, true, false);
>  	if (IS_ERR(rule->label)) {
>  		int err =3D PTR_ERR(rule->label);
> -		aa_audit_rule_free(rule);
> +		aa_audit_rule_free(rule, LSM_ID_APPARMOR);
>  		return err;
>  	}
> =20
> @@ -264,12 +269,14 @@ int aa_audit_rule_known(struct audit_krule *rule)
>  	return 0;
>  }
> =20
> -int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
> +int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsm=
id)
>  {
>  	struct aa_audit_rule *rule =3D vrule;
>  	struct aa_label *label;
>  	int found =3D 0;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_APPARMOR)
> +		return 0;
>  	label =3D aa_secid_to_label(sid);
> =20
>  	if (!label)
> diff --git a/security/apparmor/include/audit.h b/security/apparmor/includ=
e/audit.h
> index acbb03b9bd25..a75c45dd059f 100644
> --- a/security/apparmor/include/audit.h
> +++ b/security/apparmor/include/audit.h
> @@ -199,9 +199,10 @@ static inline int complain_error(int error)
>  	return error;
>  }
> =20
> -void aa_audit_rule_free(void *vrule);
> -int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
> +void aa_audit_rule_free(void *vrule, int lsmid);
> +int aa_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule,
> +		       int lsmid);
>  int aa_audit_rule_known(struct audit_krule *rule);
> -int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule);
> +int aa_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, int lsm=
id);
> =20
>  #endif /* __AA_AUDIT_H */
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index f69062617754..a563e0478cc6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -117,6 +117,8 @@ struct ima_rule_entry {
>  		void *rule;	/* LSM file metadata specific */
>  		char *args_p;	/* audit value */
>  		int type;	/* audit type */
> +		int lsm_id;	/* which LSM rule applies to */
> +		bool lsm_specific;	/* true if lsm is specified */
>  	} lsm[MAX_LSM_RULES];
>  	char *fsname;
>  	struct ima_rule_opt_list *keyrings; /* Measure keys added to these keyr=
ings */
> @@ -309,6 +311,25 @@ static int __init default_appraise_policy_setup(char=
 *str)
>  }
>  __setup("ima_appraise_tcb", default_appraise_policy_setup);
> =20
> +static int default_rules_lsm __ro_after_init =3D LSM_ID_UNDEF;
> +
> +static int __init ima_rules_lsm_init(char *str)
> +{
> +	int newdrl;
> +
> +	newdrl =3D lsm_name_to_id(str);
> +	if (newdrl >=3D 0) {
> +		default_rules_lsm =3D newdrl;
> +		return 1;
> +	}
> +
> +	pr_err("default ima rule lsm \"%s\" not registered, value unchanged.",
> +		str);
> +
> +	return 1;
> +}
> +__setup("ima_rules_lsm=3D", ima_rules_lsm_init);
> +
>  static struct ima_rule_opt_list *ima_alloc_rule_opt_list(const substring=
_t *src)
>  {
>  	struct ima_rule_opt_list *opt_list;
> @@ -380,7 +401,8 @@ static void ima_lsm_free_rule(struct ima_rule_entry *=
entry)
>  	int i;
> =20
>  	for (i =3D 0; i < MAX_LSM_RULES; i++) {
> -		ima_filter_rule_free(entry->lsm[i].rule);
> +		ima_filter_rule_free(entry->lsm[i].rule,
> +				     entry->lsm[i].lsm_id);
>  		kfree(entry->lsm[i].args_p);
>  	}
>  }
> @@ -425,7 +447,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struc=
t ima_rule_entry *entry)
> =20
>  		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
>  				     nentry->lsm[i].args_p,
> -				     &nentry->lsm[i].rule);
> +				     &nentry->lsm[i].rule,
> +				     entry->lsm[i].lsm_id);
>  		if (!nentry->lsm[i].rule)
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				nentry->lsm[i].args_p);
> @@ -451,7 +474,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry =
*entry)
>  	 * be owned by nentry.
>  	 */
>  	for (i =3D 0; i < MAX_LSM_RULES; i++)
> -		ima_filter_rule_free(entry->lsm[i].rule);
> +		ima_filter_rule_free(entry->lsm[i].rule,
> +				     entry->lsm[i].lsm_id);
>  	kfree(entry);
> =20
>  	return 0;
> @@ -650,14 +674,16 @@ static bool ima_match_rules(struct ima_rule_entry *=
rule,
>  			security_inode_getsecid(inode, &osid);
>  			rc =3D ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
>  						   Audit_equal,
> -						   lsm_rule->lsm[i].rule);
> +						   lsm_rule->lsm[i].rule,
> +						   lsm_rule->lsm[i].lsm_id);
>  			break;
>  		case LSM_SUBJ_USER:
>  		case LSM_SUBJ_ROLE:
>  		case LSM_SUBJ_TYPE:
>  			rc =3D ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
>  						   Audit_equal,
> -						   lsm_rule->lsm[i].rule);
> +						   lsm_rule->lsm[i].rule,
> +						   lsm_rule->lsm[i].lsm_id);
>  			break;
>  		default:
>  			break;
> @@ -680,7 +706,8 @@ static bool ima_match_rules(struct ima_rule_entry *ru=
le,
>  out:
>  	if (rule_reinitialized) {
>  		for (i =3D 0; i < MAX_LSM_RULES; i++)
> -			ima_filter_rule_free(lsm_rule->lsm[i].rule);
> +			ima_filter_rule_free(lsm_rule->lsm[i].rule,
> +					     lsm_rule->lsm[i].lsm_id);
>  		kfree(lsm_rule);
>  	}
>  	return result;
> @@ -1073,7 +1100,7 @@ enum policy_opt {
>  	Opt_digest_type,
>  	Opt_appraise_type, Opt_appraise_flag, Opt_appraise_algos,
>  	Opt_permit_directio, Opt_pcr, Opt_template, Opt_keyrings,
> -	Opt_label, Opt_err
> +	Opt_lsm, Opt_label, Opt_err
>  };
> =20
>  static const match_table_t policy_tokens =3D {
> @@ -1121,6 +1148,7 @@ static const match_table_t policy_tokens =3D {
>  	{Opt_pcr, "pcr=3D%s"},
>  	{Opt_template, "template=3D%s"},
>  	{Opt_keyrings, "keyrings=3D%s"},
> +	{Opt_lsm, "lsm=3D%s"},
>  	{Opt_label, "label=3D%s"},
>  	{Opt_err, NULL}
>  };
> @@ -1140,7 +1168,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry =
*entry,
>  	entry->lsm[lsm_rule].type =3D audit_type;
>  	result =3D ima_filter_rule_init(entry->lsm[lsm_rule].type, Audit_equal,
>  				      entry->lsm[lsm_rule].args_p,
> -				      &entry->lsm[lsm_rule].rule);
> +				      &entry->lsm[lsm_rule].rule,
> +				      entry->lsm[lsm_rule].lsm_id);
>  	if (!entry->lsm[lsm_rule].rule) {
>  		pr_warn("rule for LSM \'%s\' is undefined\n",
>  			entry->lsm[lsm_rule].args_p);
> @@ -1878,6 +1907,23 @@ static int ima_parse_rule(char *rule, struct ima_r=
ule_entry *entry)
>  						 &(template_desc->num_fields));
>  			entry->template =3D template_desc;
>  			break;
> +		case Opt_lsm: {
> +			int i;
> +
> +			result =3D lsm_name_to_id(args[0].from);
> +			if (result < 0) {
> +				for (i =3D 0; i < MAX_LSM_RULES; i++)
> +					entry->lsm[i].args_p =3D NULL;
> +				result =3D -EINVAL;
> +				break;
> +			}
> +			for (i =3D 0; i < MAX_LSM_RULES; i++) {
> +				entry->lsm[i].lsm_id =3D result;
> +				entry->lsm[i].lsm_specific =3D true;
> +			}
> +			result =3D 0;
> +			break;
> +			}
>  		case Opt_err:
>  			ima_log_string(ab, "UNKNOWN", p);
>  			result =3D -EINVAL;
> @@ -1923,6 +1969,7 @@ ssize_t ima_parse_add_rule(char *rule)
>  	struct ima_rule_entry *entry;
>  	ssize_t result, len;
>  	int audit_info =3D 0;
> +	int i;
> =20
>  	p =3D strsep(&rule, "\n");
>  	len =3D strlen(p) + 1;
> @@ -1940,6 +1987,11 @@ ssize_t ima_parse_add_rule(char *rule)
> =20
>  	INIT_LIST_HEAD(&entry->list);
> =20
> +	for (i =3D 0; i < MAX_LSM_RULES; i++) {
> +		entry->lsm[i].lsm_id =3D default_rules_lsm;
> +		entry->lsm[i].lsm_specific =3D false;
> +	}
> +
>  	result =3D ima_parse_rule(p, entry);
>  	if (result) {
>  		ima_free_rule(entry);
> @@ -2251,6 +2303,9 @@ int ima_policy_show(struct seq_file *m, void *v)
>  					   entry->lsm[i].args_p);
>  				break;
>  			}
> +			if (entry->lsm[i].lsm_specific)
> +				seq_printf(m, pt(Opt_lsm),
> +				    lsm_id_to_name(entry->lsm[i].lsm_id));
>  			seq_puts(m, " ");
>  		}
>  	}
> diff --git a/security/security.c b/security/security.c
> index 0a51e3d23570..cdf9ee12b064 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -271,6 +271,46 @@ static void __init initialize_lsm(struct lsm_info *l=
sm)
>  u32 lsm_active_cnt __ro_after_init;
>  const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT];
> =20
> +/**
> + * lsm_name_to_id - get the LSM ID for a registered LSM
> + * @name: the name of the LSM
> + *
> + * Returns the LSM ID associated with the named LSM or
> + * LSM_ID_UNDEF if the name isn't recongnized.
> + */
> +u64 lsm_name_to_id(const char *name)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < LSM_CONFIG_COUNT; i++) {
> +		if (!lsm_idlist[i]->name)
> +			return LSM_ID_UNDEF;
> +		if (!strcmp(name, lsm_idlist[i]->name))
> +			return lsm_idlist[i]->id;
> +	}
> +	return LSM_ID_UNDEF;
> +}
> +
> +/**
> + * lsm_id_to_name - get the LSM name for a registered LSM ID
> + * @id: the ID of the LSM
> + *
> + * Returns the LSM name associated with the LSM ID or
> + * NULL if the ID isn't recongnized.
> + */
> +const char *lsm_id_to_name(u64 id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < LSM_CONFIG_COUNT; i++) {
> +		if (!lsm_idlist[i]->name)
> +			return NULL;
> +		if (id =3D=3D lsm_idlist[i]->id)
> +			return lsm_idlist[i]->name;
> +	}
> +	return NULL;
> +}
> +
>  /* Populate ordered LSMs list from comma-separated LSM name list. */
>  static void __init ordered_lsm_parse(const char *order, const char *orig=
in)
>  {
> @@ -5336,7 +5376,8 @@ int security_key_getsecurity(struct key *key, char =
**buffer)
>   */
>  int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **ls=
mrule)
>  {
> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
> +			     LSM_ID_UNDEF);
>  }
> =20
>  /**
> @@ -5362,7 +5403,7 @@ int security_audit_rule_known(struct audit_krule *k=
rule)
>   */
>  void security_audit_rule_free(void *lsmrule)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	call_void_hook(audit_rule_free, lsmrule, LSM_ID_UNDEF);
>  }
> =20
>  /**
> @@ -5380,7 +5421,8 @@ void security_audit_rule_free(void *lsmrule)
>   */
>  int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrul=
e)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
> +			     LSM_ID_UNDEF);
>  }
>  #endif /* CONFIG_AUDIT */
> =20
> @@ -5389,19 +5431,23 @@ int security_audit_rule_match(u32 secid, u32 fiel=
d, u32 op, void *lsmrule)
>   * The integrity subsystem uses the same hooks as
>   * the audit subsystem.
>   */
> -int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e)
> +int ima_filter_rule_init(u32 field, u32 op, char *rulestr, void **lsmrul=
e,
> +			 int lsmid)
>  {
> -	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule);
> +	return call_int_hook(audit_rule_init, 0, field, op, rulestr, lsmrule,
> +			     lsmid);
>  }
> =20
> -void ima_filter_rule_free(void *lsmrule)
> +void ima_filter_rule_free(void *lsmrule, int lsmid)
>  {
> -	call_void_hook(audit_rule_free, lsmrule);
> +	call_void_hook(audit_rule_free, lsmrule, lsmid);
>  }
> =20
> -int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule)
> +int ima_filter_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
> +			  int lsmid)
>  {
> -	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule);
> +	return call_int_hook(audit_rule_match, 0, secid, field, op, lsmrule,
> +			     lsmid);
>  }
>  #endif /* CONFIG_IMA_LSM_RULES */
> =20
> diff --git a/security/selinux/include/audit.h b/security/selinux/include/=
audit.h
> index d5495134a5b9..59468baf0c91 100644
> --- a/security/selinux/include/audit.h
> +++ b/security/selinux/include/audit.h
> @@ -21,21 +21,24 @@
>   *	@op: the operator the rule uses
>   *	@rulestr: the text "target" of the rule
>   *	@rule: pointer to the new rule structure returned via this
> + *	@lsmid: the relevant LSM
>   *
>   *	Returns 0 if successful, -errno if not.  On success, the rule structu=
re
>   *	will be allocated internally.  The caller must free this structure wi=
th
>   *	selinux_audit_rule_free() after use.
>   */
> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rul=
e);
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **rul=
e,
> +			    int lsmid);
> =20
>  /**
>   *	selinux_audit_rule_free - free an selinux audit rule structure.
>   *	@rule: pointer to the audit rule to be freed
> + *	@lsmid: which LSM this rule relates to
>   *
>   *	This will free all memory associated with the given rule.
>   *	If @rule is NULL, no operation is performed.
>   */
> -void selinux_audit_rule_free(void *rule);
> +void selinux_audit_rule_free(void *rule, int lsmid);
> =20
>  /**
>   *	selinux_audit_rule_match - determine if a context ID matches a rule.
> @@ -43,11 +46,12 @@ void selinux_audit_rule_free(void *rule);
>   *	@field: the field this rule refers to
>   *	@op: the operator the rule uses
>   *	@rule: pointer to the audit rule to check against
> + *	@lsmid: the relevant LSM
>   *
>   *	Returns 1 if the context id matches the rule, 0 if it does not, and
>   *	-errno on failure.
>   */
> -int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule);
> +int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *rule, int=
 lsmid);
> =20
>  /**
>   *	selinux_audit_rule_known - check to see if rule contains selinux fiel=
ds.
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
> index 1eeffc66ea7d..a9fe8d85acae 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3487,17 +3487,20 @@ struct selinux_audit_rule {
>  	struct context au_ctxt;
>  };
> =20
> -void selinux_audit_rule_free(void *vrule)
> +void selinux_audit_rule_free(void *vrule, int lsmid)
>  {
>  	struct selinux_audit_rule *rule =3D vrule;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_SELINUX)
> +		return;
>  	if (rule) {
>  		context_destroy(&rule->au_ctxt);
>  		kfree(rule);
>  	}
>  }
> =20
> -int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vru=
le)
> +int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vru=
le,
> +			    int lsmid)
>  {
>  	struct selinux_state *state =3D &selinux_state;
>  	struct selinux_policy *policy;
> @@ -3511,6 +3514,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char=
 *rulestr, void **vrule)
> =20
>  	*rule =3D NULL;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_SELINUX)
> +		return 0;
>  	if (!selinux_initialized())
>  		return -EOPNOTSUPP;
> =20
> @@ -3592,7 +3597,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char=
 *rulestr, void **vrule)
> =20
>  err:
>  	rcu_read_unlock();
> -	selinux_audit_rule_free(tmprule);
> +	selinux_audit_rule_free(tmprule, LSM_ID_SELINUX);
>  	*rule =3D NULL;
>  	return rc;
>  }
> @@ -3622,7 +3627,7 @@ int selinux_audit_rule_known(struct audit_krule *ru=
le)
>  	return 0;
>  }
> =20
> -int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule)
> +int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule, in=
t lsmid)
>  {
>  	struct selinux_state *state =3D &selinux_state;
>  	struct selinux_policy *policy;
> @@ -3631,6 +3636,8 @@ int selinux_audit_rule_match(u32 sid, u32 field, u3=
2 op, void *vrule)
>  	struct selinux_audit_rule *rule =3D vrule;
>  	int match =3D 0;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_SELINUX)
> +		return 0;
>  	if (unlikely(!rule)) {
>  		WARN_ONCE(1, "selinux_audit_rule_match: missing rule\n");
>  		return -ENOENT;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cd44f7f3f393..4342947f51d8 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4672,16 +4672,20 @@ static int smack_post_notification(const struct c=
red *w_cred,
>   * @op: required testing operator (=3D, !=3D, >, <, ...)
>   * @rulestr: smack label to be audited
>   * @vrule: pointer to save our own audit rule representation
> + * @lsmid: the relevant LSM
>   *
>   * Prepare to audit cases where (@field @op @rulestr) is true.
>   * The label to be audited is created if necessay.
>   */
> -static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void =
**vrule)
> +static int smack_audit_rule_init(u32 field, u32 op, char *rulestr, void =
**vrule,
> +				 int lsmid)
>  {
>  	struct smack_known *skp;
>  	char **rule =3D (char **)vrule;
>  	*rule =3D NULL;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_SMACK)
> +		return 0;
>  	if (field !=3D AUDIT_SUBJ_USER && field !=3D AUDIT_OBJ_USER)
>  		return -EINVAL;
> =20
> @@ -4726,15 +4730,19 @@ static int smack_audit_rule_known(struct audit_kr=
ule *krule)
>   * @field: audit rule flags given from user-space
>   * @op: required testing operator
>   * @vrule: smack internal rule presentation
> + * @lsmid: the relevant LSM
>   *
>   * The core Audit hook. It's used to take the decision of
>   * whether to audit or not to audit a given object.
>   */
> -static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vr=
ule)
> +static int smack_audit_rule_match(u32 secid, u32 field, u32 op, void *vr=
ule,
> +				  int lsmid)
>  {
>  	struct smack_known *skp;
>  	char *rule =3D vrule;
> =20
> +	if (lsmid !=3D LSM_ID_UNDEF || lsmid !=3D LSM_ID_SMACK)
> +		return 0;
>  	if (unlikely(!rule)) {
>  		WARN_ONCE(1, "Smack: missing rule\n");
>  		return -ENOENT;


