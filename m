Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69CE785E88
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbjHWR1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbjHWR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:27:51 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFF410CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:27:46 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RWCpT0kvnzMq7yK;
        Wed, 23 Aug 2023 17:27:45 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RWCpS4XtNzMpnPg;
        Wed, 23 Aug 2023 19:27:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692811665;
        bh=Af92qxekJvnIMxE2huAbL4crBOgqYOL6Fa4l2jIwrRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cnQhU/5MAOPdwJJ4S0jVmYsdf4yX45TNkxLPr3Qpuyqe9QY6R2kocp1kmKnWyrsTT
         7NKdedEyl6WzmmgXXdfxAhopYJjhcwLB05bFRwXUIiwjvEmWbOhE+h+I3pYHLg3HG1
         Jx58yJItV9lxAGo/GQzapLvv7ZTsqf8U4KVWhyis=
Date:   Wed, 23 Aug 2023 19:27:43 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v13 04/11] LSM: syscalls for current process attributes
Message-ID: <20230823.dohCegee9die@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-5-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:44:27AM -0700, Casey Schaufler wrote:
> Create a system call lsm_get_self_attr() to provide the security
> module maintained attributes of the current process.
> Create a system call lsm_set_self_attr() to set a security
> module maintained attribute of the current process.
> Historically these attributes have been exposed to user space via
> entries in procfs under /proc/self/attr.
> 
> The attribute value is provided in a lsm_ctx structure. The structure
> identifies the size of the attribute, and the attribute value. The format
> of the attribute value is defined by the security module. A flags field
> is included for LSM specific information. It is currently unused and must
> be 0. The total size of the data, including the lsm_ctx structure and any
> padding, is maintained as well.
> 
> struct lsm_ctx {
>         __u64 id;
>         __u64 flags;
>         __u64 len;
>         __u64 ctx_len;
>         __u8 ctx[];
> };
> 
> Two new LSM hooks are used to interface with the LSMs.
> security_getselfattr() collects the lsm_ctx values from the
> LSMs that support the hook, accounting for space requirements.
> security_setselfattr() identifies which LSM the attribute is
> intended for and passes it along.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  Documentation/userspace-api/lsm.rst |  70 ++++++++++++++++
>  include/linux/lsm_hook_defs.h       |   4 +
>  include/linux/lsm_hooks.h           |   1 +
>  include/linux/security.h            |  19 +++++
>  include/linux/syscalls.h            |   5 ++
>  include/uapi/linux/lsm.h            |  90 ++++++++++++++++++++
>  kernel/sys_ni.c                     |   2 +
>  security/Makefile                   |   1 +
>  security/lsm_syscalls.c             |  55 ++++++++++++
>  security/security.c                 | 125 ++++++++++++++++++++++++++++
>  10 files changed, 372 insertions(+)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 include/uapi/linux/lsm.h
>  create mode 100644 security/lsm_syscalls.c

> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to set
> + * @ctx: the user-space source for the information
> + * @size: the size of the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @ctx.
> + *
> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
> + * if the user buffer is inaccessible or an LSM specific failure.
> + */
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx *lctx;
> +	int rc = LSM_RET_DEFAULT(setselfattr);
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (size < sizeof(*ctx))
> +		return -EINVAL;
> +
> +	lctx = kmalloc(size, GFP_KERNEL);
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(&lctx, ctx, size))

This should be copy_from_user(lctx, ctx, size)

> +		return -EFAULT;
> +
> +	if (size < lctx->len || size < lctx->ctx_len + sizeof(ctx) ||
> +	    lctx->len < lctx->ctx_len + sizeof(ctx))
> +		return -EINVAL;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx->id) {
> +			rc = hp->hook.setselfattr(attr, lctx, size, flags);
> +			break;
> +		}
> +
> +	kfree(lctx);
> +	return rc;
> +}
> +
>  /**
>   * security_getprocattr() - Read an attribute for a task
>   * @p: the task
> -- 
> 2.41.0
> 
