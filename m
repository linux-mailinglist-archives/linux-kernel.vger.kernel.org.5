Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530737B6B15
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbjJCOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238344AbjJCOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:09:32 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058FFAF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:09:26 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0KSj1xYdzMq9nw;
        Tue,  3 Oct 2023 14:09:25 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0KSg4WSzzMppDP;
        Tue,  3 Oct 2023 16:09:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696342165;
        bh=m95QP7+DMGADAxzuHLGbl+2nWXxMVw5xU2PPZKu1Yok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pt6yGYXxtlS9ZH0Ws2AYs76zafsRTtrLLom5XSJ/4UhEfpw/dbrAIZ2H7cj5F3vEZ
         q5gAxcUI92vDrvJy+kQhViVaX9g9vJm5JmTUohGwtL2puiFnD2OBLI+wCJbV5d2NoN
         esIeOC9fbyKHinweVnCQSD0ZobBpxDshVIrXGhxI=
Date:   Tue, 3 Oct 2023 16:09:23 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v15 04/11] LSM: syscalls for current process attributes
Message-ID: <20231003.kooghohS2Aiz@digikod.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-5-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912205658.3432-5-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:56:49PM -0700, Casey Schaufler wrote:
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
>  security/security.c                 | 152 ++++++++++++++++++++++++++++
>  10 files changed, 347 insertions(+)
>  create mode 100644 Documentation/userspace-api/lsm.rst
>  create mode 100644 security/lsm_syscalls.c
> 

> diff --git a/security/security.c b/security/security.c
> index a3489c04b783..0d179750d964 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -3837,6 +3837,158 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>  }
>  EXPORT_SYMBOL(security_d_instantiate);
>  
> +/*
> + * Please keep this in sync with it's counterpart in security/lsm_syscalls.c
> + */
> +
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
> +		if (flags != LSM_FLAG_SINGLE)
> +			return -EINVAL;
> +		if (uctx && copy_from_user(&lctx, uctx, sizeof(lctx)))

I'm not sure if we should return -EINVAL or -EFAULT when uctx == NULL.
Because uctx is optional (when LSM_FLAG_SINGLE is not set), I guess
-EINVAL is OK.

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
> +		if (single && lctx.id != hp->lsmid->id)
> +			continue;
> +		entrysize = left;
> +		if (base)
> +			uctx = (struct lsm_ctx __user *)(base + total);
> +		rc = hp->hook.getselfattr(attr, uctx, &entrysize, flags);
> +		if (rc == -EOPNOTSUPP) {
> +			rc = 0;
> +			continue;
> +		}
> +		if (rc == -E2BIG) {
> +			toobig = true;
> +			left = 0;
> +		} else if (rc < 0)
> +			return rc;
> +		else
> +			left -= entrysize;
> +
> +		total += entrysize;
> +		count += rc;

There is a bug if rc == -E2BIG

> +		if (single)
> +			break;
> +	}
> +	if (put_user(total, size))
> +		return -EFAULT;
> +	if (toobig)
> +		return -E2BIG;
> +	if (count == 0)
> +		return LSM_RET_DEFAULT(getselfattr);
> +	return count;
> +}
