Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7E87B6CC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbjJCO2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjJCO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:28:09 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F69E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:28:05 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0Kt91BckzMqNvw;
        Tue,  3 Oct 2023 14:28:01 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0Kt84ZdCz15j;
        Tue,  3 Oct 2023 16:28:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696343281;
        bh=8o3s6lqVYJhqJeJSLA9BJ9VB8l+K54dTRhe+K/XEuVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zzZPeVIaH+aUbgllGiHU3YcMDmgUGtdAH8tj7sxHnOfHNGOFBh4+L/Cs+WA4tgBYy
         9GXySQdjdaU/g6OCYzgUgWF/J1GAElx5BB5O2qv1lj9648mn8X4l6XEYB11Rd/Eruz
         vyMpy4SmevYspiw34alBZyRKvuKT2iILwyiFh1eY=
Date:   Tue, 3 Oct 2023 16:28:01 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v15 07/11] LSM: Helpers for attribute names and filling
 lsm_ctx
Message-ID: <20231003.Ic1FohLoc8Ph@digikod.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-8-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912205658.3432-8-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:56:52PM -0700, Casey Schaufler wrote:
> Add lsm_name_to_attr(), which translates a text string to a
> LSM_ATTR value if one is available.
> 
> Add lsm_fill_user_ctx(), which fills a struct lsm_ctx, including
> the trailing attribute value.
> 
> Both are used in module specific components of LSM system calls.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> ---
>  include/linux/security.h | 14 ++++++++++++++
>  security/lsm_syscalls.c  | 24 +++++++++++++++++++++++
>  security/security.c      | 41 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 79 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 8831d7cf0a6b..e567f910a1c2 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -32,6 +32,7 @@
>  #include <linux/string.h>
>  #include <linux/mm.h>
>  #include <linux/sockptr.h>
> +#include <uapi/linux/lsm.h>
>  
>  struct linux_binprm;
>  struct cred;
> @@ -264,6 +265,7 @@ int unregister_blocking_lsm_notifier(struct notifier_block *nb);
>  /* prototypes */
>  extern int security_init(void);
>  extern int early_security_init(void);
> +extern u64 lsm_name_to_attr(const char *name);
>  
>  /* Security operations */
>  int security_binder_set_context_mgr(const struct cred *mgr);
> @@ -490,6 +492,8 @@ int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
>  int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
>  int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
>  int security_locked_down(enum lockdown_reason what);
> +int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +		      size_t context_size, u64 id, u64 flags);
>  #else /* CONFIG_SECURITY */
>  
>  static inline int call_blocking_lsm_notifier(enum lsm_event event, void *data)
> @@ -507,6 +511,11 @@ static inline  int unregister_blocking_lsm_notifier(struct notifier_block *nb)
>  	return 0;
>  }
>  
> +static inline u64 lsm_name_to_attr(const char *name)
> +{
> +	return LSM_ATTR_UNDEF;
> +}
> +
>  static inline void security_free_mnt_opts(void **mnt_opts)
>  {
>  }
> @@ -1415,6 +1424,11 @@ static inline int security_locked_down(enum lockdown_reason what)
>  {
>  	return 0;
>  }
> +static inline int lsm_fill_user_ctx(struct lsm_ctx __user *ctx, void *context,
> +				    size_t context_size, u64 id, u64 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_SECURITY */
>  
>  #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 329aaca5efc0..5d391b1f7e69 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -17,6 +17,30 @@
>  #include <linux/lsm_hooks.h>
>  #include <uapi/linux/lsm.h>
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
>  /**
>   * sys_lsm_set_self_attr - Set current task's security module attribute
>   * @attr: which attribute to set
> diff --git a/security/security.c b/security/security.c
> index 0d179750d964..9136a4c3b0bc 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -771,6 +771,47 @@ static int lsm_superblock_alloc(struct super_block *sb)
>  	return 0;
>  }
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
>  /*
>   * The default value of the LSM hook is defined in linux/lsm_hook_defs.h and
>   * can be accessed with:
> -- 
> 2.41.0
> 
