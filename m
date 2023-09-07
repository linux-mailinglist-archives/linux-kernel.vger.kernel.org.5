Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2754A7978C6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbjIGQyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240084AbjIGQyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:54:41 -0400
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc08])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055491BEB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:54:08 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RhNfN0rB0zMpnS9;
        Thu,  7 Sep 2023 15:37:32 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RhNfM4SjRzMpnPs;
        Thu,  7 Sep 2023 17:37:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1694101052;
        bh=3Y5CnHkV/sAvVC0iHNFm674Ca/+2ssv0lam+xZGQXr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1FydaQ9lhh7gA6qUmG1MRh3WDKBbdkcrx2mzU/51BQlNjfBjJwJuR1zIokcGs4VqS
         e85npZFWqAnv6G8+7xPeyHetXVbvTfw3O7Ev9MNL5zKZ4H/AWEURx3ch9dHyaTXCHt
         xrUfpl4ED2jiKHBnlzlxIK+wzBoz5+L9hUSTMsTA=
Date:   Thu, 7 Sep 2023 17:37:24 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v14 04/11] LSM: syscalls for current process attributes
Message-ID: <20230907.go2eLeCo6ov1@digikod.net>
References: <20230828195802.135055-1-casey@schaufler-ca.com>
 <20230828195802.135055-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828195802.135055-5-casey@schaufler-ca.com>
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

On Mon, Aug 28, 2023 at 12:57:54PM -0700, Casey Schaufler wrote:
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
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  Documentation/userspace-api/lsm.rst |  70 +++++++++++++
>  include/linux/lsm_hook_defs.h       |   4 +
>  include/linux/lsm_hooks.h           |   1 +
>  include/linux/security.h            |  19 ++++
>  include/linux/syscalls.h            |   5 +
>  include/uapi/linux/lsm.h            |  36 +++++++
>  kernel/sys_ni.c                     |   2 +
>  security/Makefile                   |   1 +
>  security/lsm_syscalls.c             |  57 +++++++++++
>  security/security.c                 | 146 ++++++++++++++++++++++++++++
>  10 files changed, 341 insertions(+)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 security/lsm_syscalls.c
> 

> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @uctx: the user-space destination for the information, or NULL
> + * @size: pointer to the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported.
> + *
> + * A NULL value for @uctx can be used to get both the number of attributes
> + * and the size of the data.
> + *
> + * Returns the number of attributes found on success, negative value
> + * on error. @size is reset to the total size of the data.
> + * If @size is insufficient to contain the data -E2BIG is returned.
> + */
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> +			 size_t __user *size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
> +	u8 __user *base = (u8 __user *)uctx;
> +	size_t total = 0;
> +	size_t entrysize;
> +	size_t left;
> +	bool toobig = false;
> +	bool single = false;

Much easier to read with these booleans.

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
> +	if (flags) {
> +		/*
> +		 * Only flag supported is LSM_FLAG_SINGLE
> +		 */
> +		if (flags & LSM_FLAG_SINGLE)
> +			return -EINVAL;
> +		if (uctx &&
> +		    copy_struct_from_user(&lctx, sizeof(lctx), uctx, left))

Again, I'm not sure is copy_struct_from_user() should be used here
because it checks that the user space structures ends with zeros, which
is inconsistent with the case without LSM_FLAG_SINGLE. Anyway, this code
should at least properly handle the copy_struct_from_user() error codes
which includes EFAULT *and* E2BIG.

> +			return -EFAULT;
> +		/*
> +		 * If the LSM ID isn't specified it is an error.
> +		 */
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +		single = true;
> +	}
> +
> +	/*
> +	 * In the usual case gather all the data from the LSMs.
> +	 * In the single case only get the data from the LSM specified.
> +	 */
> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (single) {
> +			if (count > 0)
> +				break;
> +			if (lctx.id != hp->lsmid->id)
> +				continue;
> +		}
> +		entrysize = left;
> +		if (base)
> +			uctx = (struct lsm_ctx __user *)(base + total);
> +		rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
> +		if (rc == -EOPNOTSUPP) {
> +			rc = 0;

Not a big deal but with LSM_FLAG_SINGLE, if the selected LSM doesn't
implement this hook, this will uselessly loop over all LSMs.
I'd add:

if (single)
	/* Still try to write 0 as the total size for consistency. */
	break;

> +			continue;
> +		}
> +		if (rc == -E2BIG) {
> +			toobig = true;
> +			left = 0;
> +			total += entrysize;

I'm not sure what is the desired behavior with LSM_FLAG_SINGLE in this
case but I'd add:

if (single)
	break;

> +			continue;
> +		}
> +		if (rc < 0)
> +			return rc;

I think this should be a break instead of the return rc for consistency
reasons.

> +
> +		left -= entrysize;
> +		total += entrysize;
> +		count += rc;

You could simplify a bit by replacing the first single check with this
one:

if (single)
	break;

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

It would be nice to add a comment before all these three syscall
documentations to keep up-to-date the related user space documentation
in lsm_syscalls.c

> +/**
> + * security_setselfattr - Set an LSM attribute on the current process.
> + * @attr: which attribute to set
> + * @uctx: the user-space source for the information
> + * @size: the size of the data
> + * @flags: reserved for future use, must be 0
> + *
> + * Set an LSM attribute for the current process. The LSM, attribute
> + * and new value are included in @uctx.
> + *
> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
> + * if the user buffer is inaccessible or an LSM specific failure.
> + */
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *uctx,
> +			 size_t size, u32 flags)
> +{
> +	struct security_hook_list *hp;
> +	struct lsm_ctx *lctx;
> +	int rc = LSM_RET_DEFAULT(setselfattr);
> +
> +	if (flags)
> +		return -EINVAL;
> +	if (size < sizeof(*lctx) || size > PAGE_SIZE)

I would be better to return -E2BIG if size > PAGE_SIZE, and update the
(two) documentations accordingly.

> +		return -EINVAL;
> +
> +	lctx = kmalloc(size, GFP_KERNEL);
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(lctx, uctx, size)) {
> +		rc = -EFAULT;
> +		goto free_out;
> +	}
> +
> +	if (size < lctx->len || size < lctx->ctx_len + sizeof(*lctx) ||
> +	    lctx->len < lctx->ctx_len + sizeof(*lctx)) {
> +		rc = -EINVAL;
> +		goto free_out;
> +	}
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
> +		if ((hp->lsmid->id) == lctx->id) {
> +			rc = hp->hook.setselfattr(attr, lctx, size, flags);

There is no need (at least for now) to directly expose lctx->id nor
lctx->flags. It would be simpler to only pass lctx->ctx and
lctx->ctx_len to the hooks.

> +			break;
> +		}
> +
> +free_out:
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
