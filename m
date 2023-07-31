Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2C7689C4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjGaCCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGaCCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:02:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF5810C6;
        Sun, 30 Jul 2023 19:02:02 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RDhKn0hzmz1GC28;
        Mon, 31 Jul 2023 10:01:01 +0800 (CST)
Received: from [10.67.110.48] (10.67.110.48) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 10:01:59 +0800
Message-ID: <f899f0af-6aea-7cd6-cd44-a2082cb267cb@huawei.com>
Date:   Mon, 31 Jul 2023 10:01:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/9] selinux: avoid implicit conversions in services
 code
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        <selinux@vger.kernel.org>
CC:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        <linux-kernel@vger.kernel.org>
References: <20230728155501.39632-1-cgzones@googlemail.com>
 <20230728155501.39632-5-cgzones@googlemail.com>
From:   Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <20230728155501.39632-5-cgzones@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.48]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/07/28 23:54, Christian Göttsche wrote:
> Use u32 as the output parameter type in security_get_classes() and
> security_get_permissions(), based on the type of the symtab nprim
> member.
> 
> Declare the read-only class string parameter of
> security_get_permissions() const.
> 
> Avoid several implicit conversions by using the identical type for the
> destination.
> 
> Use the type identical to the source for local variables.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Reviewed-by: GONG, Ruiqi <gongruiqi1@huawei.com>

> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/include/security.h |  4 ++--
>  security/selinux/selinuxfs.c        |  7 ++++---
>  security/selinux/ss/services.c      | 23 ++++++++++++-----------
>  3 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 668e393a9709..074d439fe9ad 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -312,9 +312,9 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
>  				 u32 *peer_sid);
>  
>  int security_get_classes(struct selinux_policy *policy,
> -			 char ***classes, int *nclasses);
> +			 char ***classes, u32 *nclasses);
>  int security_get_permissions(struct selinux_policy *policy,
> -			     char *class, char ***perms, int *nperms);
> +			     const char *class, char ***perms, u32 *nperms);
>  int security_get_reject_unknown(void);
>  int security_get_allow_unknown(void);
>  
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index f79e96f0f221..b969e87fd870 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1798,7 +1798,8 @@ static int sel_make_perm_files(struct selinux_policy *newpolicy,
>  			char *objclass, int classvalue,
>  			struct dentry *dir)
>  {
> -	int i, rc, nperms;
> +	u32 i, nperms;
> +	int rc;
>  	char **perms;
>  
>  	rc = security_get_permissions(newpolicy, objclass, &perms, &nperms);
> @@ -1868,8 +1869,8 @@ static int sel_make_classes(struct selinux_policy *newpolicy,
>  			    struct dentry *class_dir,
>  			    unsigned long *last_class_ino)
>  {
> -
> -	int rc, nclasses, i;
> +	u32 i, nclasses;
> +	int rc;
>  	char **classes;
>  
>  	rc = security_get_classes(newpolicy, &classes, &nclasses);
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index cf4b87ec4a0e..3a03243f52e7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -856,7 +856,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
>  	struct sidtab *sidtab;
>  	struct sidtab_entry *old_entry, *new_entry;
>  	struct type_datum *type;
> -	int index;
> +	u32 index;
>  	int rc;
>  
>  	if (!selinux_initialized())
> @@ -1511,7 +1511,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>  		return -ENOMEM;
>  
>  	if (!selinux_initialized()) {
> -		int i;
> +		u32 i;
>  
>  		for (i = 1; i < SECINITSID_NUM; i++) {
>  			const char *s = initial_sid_to_string[i];
> @@ -2821,7 +2821,6 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
>  {
>  	struct policydb *policydb = &policy->policydb;
>  	struct sidtab *sidtab = policy->sidtab;
> -	int len;
>  	u16 sclass;
>  	struct genfs *genfs;
>  	struct ocontext *c;
> @@ -2843,7 +2842,7 @@ static inline int __security_genfs_sid(struct selinux_policy *policy,
>  		return -ENOENT;
>  
>  	for (c = genfs->head; c; c = c->next) {
> -		len = strlen(c->u.name);
> +		size_t len = strlen(c->u.name);
>  		if ((!c->v.sclass || sclass == c->v.sclass) &&
>  		    (strncmp(c->u.name, path, len) == 0))
>  			break;
> @@ -3331,7 +3330,7 @@ static int get_classes_callback(void *k, void *d, void *args)
>  {
>  	struct class_datum *datum = d;
>  	char *name = k, **classes = args;
> -	int value = datum->value - 1;
> +	u32 value = datum->value - 1;
>  
>  	classes[value] = kstrdup(name, GFP_ATOMIC);
>  	if (!classes[value])
> @@ -3341,7 +3340,7 @@ static int get_classes_callback(void *k, void *d, void *args)
>  }
>  
>  int security_get_classes(struct selinux_policy *policy,
> -			 char ***classes, int *nclasses)
> +			 char ***classes, u32 *nclasses)
>  {
>  	struct policydb *policydb;
>  	int rc;
> @@ -3357,7 +3356,8 @@ int security_get_classes(struct selinux_policy *policy,
>  	rc = hashtab_map(&policydb->p_classes.table, get_classes_callback,
>  			 *classes);
>  	if (rc) {
> -		int i;
> +		u32 i;
> +
>  		for (i = 0; i < *nclasses; i++)
>  			kfree((*classes)[i]);
>  		kfree(*classes);
> @@ -3371,7 +3371,7 @@ static int get_permissions_callback(void *k, void *d, void *args)
>  {
>  	struct perm_datum *datum = d;
>  	char *name = k, **perms = args;
> -	int value = datum->value - 1;
> +	u32 value = datum->value - 1;
>  
>  	perms[value] = kstrdup(name, GFP_ATOMIC);
>  	if (!perms[value])
> @@ -3381,10 +3381,11 @@ static int get_permissions_callback(void *k, void *d, void *args)
>  }
>  
>  int security_get_permissions(struct selinux_policy *policy,
> -			     char *class, char ***perms, int *nperms)
> +			     const char *class, char ***perms, u32 *nperms)
>  {
>  	struct policydb *policydb;
> -	int rc, i;
> +	u32 i;
> +	int rc;
>  	struct class_datum *match;
>  
>  	policydb = &policy->policydb;
> @@ -3599,7 +3600,7 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
>  /* Check to see if the rule contains any selinux fields */
>  int selinux_audit_rule_known(struct audit_krule *rule)
>  {
> -	int i;
> +	u32 i;
>  
>  	for (i = 0; i < rule->field_count; i++) {
>  		struct audit_field *f = &rule->fields[i];
