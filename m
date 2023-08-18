Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D129E78127F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355814AbjHRR7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379395AbjHRR7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:59:19 -0400
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD22D65
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:58:46 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RS8kX3TByzMpnY1;
        Fri, 18 Aug 2023 17:58:44 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RS8kW0C1pzMpnPs;
        Fri, 18 Aug 2023 19:58:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692381524;
        bh=QiaCKflMxQyv8whe2QmamXjPycBAXSujEpnJnRYX2wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yOBi0jhS9hTT8eTtR0tYmCvX5yveEN7k+qg/X8gzh3dMDWl2ycgka3WW2kHBr7H27
         k0WWNUkWjyQww9mhun3BIjRPw+ymcxqc+nZ37mGPdKMhJny4vKof3KoqK6yFnbu+Dp
         YpiX8IUZg7LpI2sgvTvqc806MFhvz7hrUBJcgjWo=
Date:   Fri, 18 Aug 2023 19:58:37 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v13 02/11] LSM: Maintain a table of LSM attribute data
Message-ID: <20230818.aejeiFoop5Ie@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-3-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802174435.11928-3-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:44:25AM -0700, Casey Schaufler wrote:
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
> ---
>  include/linux/security.h |  2 ++
>  security/security.c      | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 32828502f09e..a20a4ceda6d9 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -138,6 +138,8 @@ enum lockdown_reason {
>  };
>  
>  extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
> +extern u32 lsm_active_cnt;
> +extern const struct lsm_id *lsm_idlist[];
>  
>  /* These functions are in security/commoncap.c */
>  extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
> diff --git a/security/security.c b/security/security.c
> index feaae09581dc..87b70a55a028 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -36,6 +36,25 @@
>  /* How many LSMs were built into the kernel? */
>  #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
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
>  /*
>   * These are descriptions of the reasons that can be passed to the
>   * security_locked_down() LSM hook. Placing this array here allows
> @@ -245,6 +264,12 @@ static void __init initialize_lsm(struct lsm_info *lsm)
>  	}
>  }
>  
> +/*
> + * Current index to use while initializing the lsm id list.
> + */
> +u32 lsm_active_cnt __ro_after_init;
> +const struct lsm_id *lsm_idlist[LSM_CONFIG_COUNT] __ro_after_init;

I guess __ro_after_init is superfluous here.

Reviewed-by: Mickaël Salaün <mic@digikod.net>


> +
>  /* Populate ordered LSMs list from comma-separated LSM name list. */
>  static void __init ordered_lsm_parse(const char *order, const char *origin)
>  {
> @@ -521,6 +546,18 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
>  {
>  	int i;
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
>  	for (i = 0; i < count; i++) {
>  		hooks[i].lsmid = lsmid;
>  		hlist_add_tail_rcu(&hooks[i].list, hooks[i].head);
> -- 
> 2.41.0
> 
