Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323C7777CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbjHJP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjHJP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:57:06 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEEF270D;
        Thu, 10 Aug 2023 08:57:05 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id C9A223F5DF;
        Thu, 10 Aug 2023 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691683024;
        bh=HGk1f9A48c1SVgjiWbb6flbA8/fFnreu1mLt0itT0tA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=p5xwVtgffgi97UvqHy7cK45bijh+yJjqfopt0ObYGsv3W/n84WNW58s3bHmKBTYU6
         KX2M+EyQkiCstA3WFOyogsLagEwQqMAHvIsjbPu3XHAHp0N/QSe80tIo0Lfo7iQY6F
         LwRYM70zUBssR8pdNTlQ9ZwnLYC0fOT0mkxekr1InXbT4zrBaQkQIDxT2o8ygP9Jkl
         8yuiFkV/ceCzCpTSIren+3fqzwBlaA1LU/g1IFSNR2azU8ZCZBtuaS++Hlt0Zi6rGX
         0jDbSmDUOMcio2qSXctuzUV2LCPYeo1BwjnFaYk5wDVkPkqXYe3XjTfXkUWxKIWFtC
         5I72TbYqezxuQ==
Message-ID: <84384a02-8b22-7d21-891a-c1c373bdb51b@canonical.com>
Date:   Thu, 10 Aug 2023 08:57:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-8-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-8-casey@schaufler-ca.com>
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
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> Both are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   include/linux/security.h | 14 ++++++++++++++
>   security/lsm_syscalls.c  | 24 +++++++++++++++++++++++
>   security/security.c      | 41 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 79 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0d882cb221f4..817cf28dbf8a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -32,6 +32,7 @@
>   #include <linux/string.h>
>   #include <linux/mm.h>
>   #include <linux/sockptr.h>
> +#include <uapi/linux/lsm.h>
>   
>   struct linux_binprm;
>   struct cred;
> @@ -263,6 +264,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>   /* prototypes */
>   extern int security_init(void);
>   extern int early_security_init(void);
> +extern u64 lsm_name_to_attr(const char *name);
>   
>   /* Security operations */
>   int security_binder_set_context_mgr(const struct cred *mgr);
> @@ -488,6 +490,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>   int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>   int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>   int security_locked_down(enum lockdown_reason what);
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags);
>   #else /* CONFIG_SECURITY */
>   
>   static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -505,6 +509,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>   	return 0;
>   }
>   
> +static inline u64 lsm_name_to_attr(const char *name)
> +{
> +	return LSM_ATTR_UNDEF;
> +}
> +
>   static inline void security_free_mnt_opts(void **mnt_opts)
>   {
>   }
> @@ -1408,6 +1417,11 @@ static inline int security_locked_down(enum lockdown_reason what)
>   {
>   	return 0;
>   }
> +static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +				    size_t context_size, u64 id, u64 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif	/* CONFIG_SECURITY */
>   
>   #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index f03f2d17ab49..bc22f05e2d8c 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,30 @@
>   #include <linux/lsm_hooks.h>
>   #include <uapi/linux/lsm.h>
>   
> +/**
> + * lsm_name_to_attr - map an LSM attribute name to its ID
> + * @name: name of the attribute
> + *
> + * Returns the LSM attribute value associated with @name, or 0 if
> + * there is no mapping.
> + */
> +u64 lsm_name_to_attr(const char *name)
> +{
> +	if (!strcmp(name, "current"))
> +		return LSM_ATTR_CURRENT;
> +	if (!strcmp(name, "exec"))
> +		return LSM_ATTR_EXEC;
> +	if (!strcmp(name, "fscreate"))
> +		return LSM_ATTR_FSCREATE;
> +	if (!strcmp(name, "keycreate"))
> +		return LSM_ATTR_KEYCREATE;
> +	if (!strcmp(name, "prev"))
> +		return LSM_ATTR_PREV;
> +	if (!strcmp(name, "sockcreate"))
> +		return LSM_ATTR_SOCKCREATE;
> +	return LSM_ATTR_UNDEF;
> +}
> +
>   /**
>    * sys_lsm_set_self_attr - Set current task's security module attribute
>    * @attr: which attribute to set
> diff --git a/security/security.c b/security/security.c
> index cde7f3a13e7c..f1038686ebd0 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -770,6 +770,47 @@ static int lsm_superblock_alloc(struct super_block *sb)
>   	return 0;
>   }
>   
> +/**
> + * lsm_fill_user_ctx - Fill a user space lsm_ctx structure
> + * @ctx: an LSM context to be filled
> + * @context: the new context value
> + * @context_size: the size of the new context value
> + * @id: LSM id
> + * @flags: LSM defined flags
> + *
> + * Fill all of the fields in a user space lsm_ctx structure.
> + * Caller is assumed to have verified that @ctx has enough space
> + * for @context.
> + *
> + * Returns 0 on success, -EFAULT on a copyout error, -ENOMEM
> + * if memory can't be allocated.
> + */
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags)
> +{
> +	struct lsm_ctx *lctx;
> +	size_t locallen = struct_size(lctx, ctx, context_size);
> +	int rc = 0;
> +
> +	lctx = kzalloc(locallen, GFP_KERNEL);
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	lctx->id = id;
> +	lctx->flags = flags;
> +	lctx->ctx_len = context_size;
> +	lctx->len = locallen;
> +
> +	memcpy(lctx->ctx, context, context_size);
> +
> +	if (copy_to_user(ctx, lctx, locallen))
> +		rc = -EFAULT;
> +
> +	kfree(lctx);
> +
> +	return rc;
> +}
> +
>   /*
>    * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>    * can be accessed with:

