Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE832777CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjHJPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjHJPyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:54:38 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422D2D65;
        Thu, 10 Aug 2023 08:54:35 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DE1123F5DF;
        Thu, 10 Aug 2023 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691682874;
        bh=X3c2GGn/eSUQZahV8jMYvTZLbSX/dn6AUwnI9IP7Nws=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Bi1OMg8tQRhRtRzOmp8DcH3gMlpCFAsdSHE4YQ8a+v7VMEs3lfVOVLsWyEVCrsDjv
         XC9mHBCD8iQl5KlOGNMDF3zylymzSsFyynIoqyTY9VVw37sOIKupayHCtYwcgOLBE5
         nvhd3E3S13vhkcE4vL4UQ/NRVWXO+HEjuILa2vnrjx4BjrVVy+1NqmFuowdu9jHTZl
         KkbKQxHbKGir7hYirONpqa+ba247k6nFja8ni+uiqj7+jpgfFJF4IZ9gHa/i3Zaf+k
         yND6sub7m32od2jUUKTG1xt0hoPaBZ0jIcezYCvHkdKGMXMzgh0Acg7LN3NSzqtUA4
         V+g2DDgFSgoig==
Message-ID: <b68e0d6f-3559-dfd7-5511-2c9df6b8a27e@canonical.com>
Date:   Thu, 10 Aug 2023 08:54:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 02/11] LSM: Maintain a table of LSM attribute data
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-3-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-3-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 10:44, Casey Schaufler wrote:
> As LSMs are registered add their lsm_id pointers to a table.
> This will be used later for attribute reporting.
> 
> Determine the number of possible security modules based on
> their respective CONFIG options. This allows the number to be
> known at build time. This allows data structures and tables
> to use the constant.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/security.h |  2 ++
>   security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 32828502f09e..a20a4ceda6d9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -138,6 +138,8 @@ enum lockdown_reason {
>   };
>   
>   extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> +extern u32 lsm_active_cnt;
> +extern const struct lsm_id *lsm_idlist[];
>   
>   /* These functions are in security/commoncap.c */
>   extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> diff --git a/security/security.c b/security/security.c
> index feaae09581dc..87b70a55a028 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -36,6 +36,25 @@
>   /* How many LSMs were built into the kernel? */
>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>   
> +/*
> + * How many LSMs are built into the kernel as determined at
> + * build time. Used to determine fixed array sizes.
> + * The capability module is accounted for by CONFIG_SECURITY
> + */
> +#define LSM_CONFIG_COUNT ( \
> +	(IS_ENABLED(CONFIG_SECURITY) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SELINUX) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SMACK) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_TOMOYO) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_IMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_APPARMOR) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_YAMA) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LOADPIN) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_SAFESETID) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LOCKDOWN_LSM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_BPF_LSM) ? 1 : 0) + \
> +	(IS_ENABLED(CONFIG_SECURITY_LANDLOCK) ? 1 : 0))
> +
>   /*
>    * These are descriptions of the reasons that can be passed to the
>    * security_locked_down() LSM hook. Placing this array here allows
> @@ -245,6 +264,12 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>   	}
>   }
>   
> +/*
> + * Current index to use while initializing the lsm id list.
> + */
> +u32 lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;
> +
>   /* Populate ordered LSMs list from comma-separated LSM name list. */
>   static void __init ordered_lsm_parse(const char *order, const char *origin)
>   {
> @@ -521,6 +546,18 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>   {
>   	int i;
>   
> +	/*
> +	 * A security module may call security_add_hooks() more
> +	 * than once during initialization, and LSM initialization
> +	 * is serialized. Landlock is one such case.
> +	 * Look at the previous entry, if there is one, for duplication.
> +	 */
> +	if (lsm_active_cnt == 0 || lsm_idlist[lsm_active_cnt - 1] != lsmid) {
> +		if (lsm_active_cnt >= LSM_CONFIG_COUNT)
> +			panic("%s Too many LSMs registered.\n", __func__);
> +		lsm_idlist[lsm_active_cnt++] = lsmid;
> +	}
> +
>   	for (i = 0; i < count; i++) {
>   		hooks[i].lsmid = lsmid;
>   		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);

