Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EB788C07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjHYPAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343876AbjHYO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:59:54 -0400
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93610212B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 07:59:52 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RXNQq22tPzMrC82;
        Fri, 25 Aug 2023 14:59:47 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RXNQn3WsBzMpnPs;
        Fri, 25 Aug 2023 16:59:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692975587;
        bh=pgXqAQEfMdYtItpmJ8SvYTkfIe5iua0p6R8EphH1UQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tDCH7pUENgYg8N2iPaG/ZHYgf2LlVr7z4vfoG+0FbHJeTv6sS1BYuEL/o2rOEgIVC
         MV2am+bFd9maCmY+5iHl2/KaDR++cfhQZVa0ojEFnJgPiU0dpK8q9XHkqdrSB7uCci
         +/PeYYKQBf7PTPUoajf2HpBRZgQn+P0TGulnhIzk=
Date:   Fri, 25 Aug 2023 16:59:42 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v13 04/11] LSM: syscalls for current process attributes
Message-ID: <20230825.xoo1uu1Ohsh4@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-5-casey@schaufler-ca.com>
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
> + * sys_lsm_get_self_attr - Return current task's security module attributes
> + * @attr: which attribute to set
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: reserved for future use

This documentation is out-of-sync with the LSM hook doc, especially the
flags.

> + *
> + * Returns the calling task's LSM contexts. On success this
> + * function returns the number of @ctx array elements. This value
> + * may be zero if there are no LSM contexts assigned. If @size is
> + * insufficient to contain the return data -E2BIG is returned and
> + * @size is set to the minimum required size. In all other cases
> + * a negative value indicating the error is returned.
> + */
> +SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> +		ctx, size_t __user *, size, u32, flags)
> +{
> +	return security_getselfattr(attr, ctx, size, flags);
> +}
> diff --git a/security/security.c b/security/security.c
> index 5e9cd548dd95..cde7f3a13e7c 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3798,6 +3798,131 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space destination for the information, or NULL
> + * @size: pointer to the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported

The final dot is missing.

> + *
> + * A NULL value for @ctx can be used to get both the number of attributes
> + * and the size of the data.
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t __user *size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> +	u8 __user *base = (u8 __user *)ctx;
> +	size_t total = 0;
> +	size_t entrysize;
> +	size_t left;
> +	bool toobig = false;
> +	int count = 0;
> +	int rc;
> +
> +	if (attr == LSM_ATTR_UNDEF)
> +		return -EINVAL;
> +	if (size == NULL)
> +		return -EINVAL;
> +	if (get_user(left, size))
> +		return -EFAULT;
> +
> +	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
> +		if (!ctx)

This doesn't fit with the documenation. I guess it should handle NULL
ctx in both cases.

This cases should be tested.

I'm now wondering if this LSM_FLAG_SINGLE makes sense though.

> +			return -EINVAL;
> +		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))

This check looks good but it looks inconsistent with the
non-LSM_FLAG_SINGLE loop which doesn't check that the arrays only
contain zeros.

> +			return -EFAULT;
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +	} else if (flags) {

This check is not correct. It should test if there is no value other
than LSM_FLAG_SINGLE.

Please add a test with something like this:
lsm_get_self_attr(valid_attr, valid_ctx, valid_size, LSM_FLAG_SINGLE | 1 << 9)

> +		return -EINVAL;
> +	}
> +

Please add a comment to highlight that only LSM_FLAG_SINGLE is handled
for this loop.

> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
> +			continue;
> +		entrysize = left;
> +		if (base)
> +			ctx = (struct lsm_ctx __user *)(base + total);

To be consistent with the previous copy_struct_from_user() call, we
should at least check that the ctx arrays contain zeros too.

We should add a test for this case.

> +		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
> +		if (rc == -EOPNOTSUPP) {
> +			rc = 0;
> +			continue;
> +		}
> +		if (rc == -E2BIG) {
> +			toobig = true;
> +			left = 0;
> +			continue;
> +		}
> +		if (rc < 0)
> +			return rc;
> +
> +		left -= entrysize;
> +		total += entrysize;
> +		count += rc;
> +	}
> +	if (put_user(total, size))
> +		return -EFAULT;
> +	if (toobig)
> +		return -E2BIG;
> +	if (count == 0)
> +		return LSM_RET_DEFAULT(getselfattr);
> +	return count;
> +}
> +
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

We should not allow user space to allocate arbitrary kernel buffer size.
Limiting to PAGE_SIZE seems reasonable.

> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(&lctx, ctx, size))
> +		return -EFAULT;
> +
> +	if (size < lctx->len || size < lctx->ctx_len + sizeof(ctx) ||

Because we only handle one LSM at a time, size should be equal to
lctx->len right?

> +	    lctx->len < lctx->ctx_len + sizeof(ctx))
> +		return -EINVAL;
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx->id) {
> +			rc = hp->hook.setselfattr(attr, lctx, size, flags);

It seems that there is no (shared) check that the whole ctx is used. It
would be nice for the LSM hook implementations to return the processed
size and let this code check that there is no remaining data left, or at
least that it only contains zeros.

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
