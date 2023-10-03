Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3B27B6B73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbjJCO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239588AbjJCO1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:27:25 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [84.16.66.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B383B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:27:22 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0KsN41jnzMqC3b;
        Tue,  3 Oct 2023 14:27:20 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0KsM6bbVzMpnPd;
        Tue,  3 Oct 2023 16:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696343240;
        bh=yAEIoTr6l2tLvcrDC5MmIpC19R8Zk4Yb4VeYz7AYcuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ntgd2Sy8SXQN4Z57NA0nzGulazOW4rdlYMLFGPTqI2wtR7qZR0lWv5Xa82KbojMCB
         1y+UOJgad30xrsi1MucSi28+JcjAhDFqKvx77aFD79ElIS2R8n6odlNAPIRGOBGGER
         LFJrEx0fqvE1F/+TWBJvAT8qBpb6j2HE9DfNT1bs=
Date:   Tue, 3 Oct 2023 16:27:20 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
Message-ID: <20231003.Aijii7zienoi@digikod.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-6-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912205658.3432-6-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> Create a system call to report the list of Linux Security Modules
> that are active on the system. The list is provided as an array
> of LSM ID numbers.
> 
> The calling application can use this list determine what LSM
> specific actions it might take. That might include choosing an
> output format, determining required privilege or bypassing
> security module specific behavior.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>

Reviewed-by: Mickaël Salaün <mic@digikod.net>

> ---
>  Documentation/userspace-api/lsm.rst |  3 +++
>  include/linux/syscalls.h            |  1 +
>  kernel/sys_ni.c                     |  1 +
>  security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>  4 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index f8499f3e2826..a76da373841b 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -63,6 +63,9 @@ Get the specified security attributes of the current process
>  .. kernel-doc:: security/lsm_syscalls.c
>      :identifiers: sys_lsm_get_self_attr
>  
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_list_modules
> +
>  Additional documentation
>  ========================
>  
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 8637287bd39d..323ef5e2667d 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -945,6 +945,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>  				      size_t *size, __u32 flags);
>  asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>  				      size_t size, __u32 flags);
> +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index f81f2468c0ce..738ca470fcce 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -172,6 +172,7 @@ COND_SYSCALL(fadvise64_64);
>  COND_SYSCALL_COMPAT(fadvise64_64);
>  COND_SYSCALL(lsm_get_self_attr);
>  COND_SYSCALL(lsm_set_self_attr);
> +COND_SYSCALL(lsm_list_modules);
>  
>  /* CONFIG_MMU only */
>  COND_SYSCALL(swapon);
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index 226ae80d9683..329aaca5efc0 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>  {
>  	return security_getselfattr(attr, ctx, size, flags);
>  }
> +
> +/**
> + * sys_lsm_list_modules - Return a list of the active security modules
> + * @ids: the LSM module ids
> + * @size: pointer to size of @ids, updated on return
> + * @flags: reserved for future use, must be zero
> + *
> + * Returns a list of the active LSM ids. On success this function
> + * returns the number of @ids array elements. This value may be zero
> + * if there are no LSMs active. If @size is insufficient to contain
> + * the return data -E2BIG is returned and @size is set to the minimum
> + * required size. In all other cases a negative value indicating the
> + * error is returned.
> + */
> +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, size,
> +		u32, flags)
> +{
> +	size_t total_size = lsm_active_cnt * sizeof(*ids);
> +	size_t usize;
> +	int i;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (get_user(usize, size))
> +		return -EFAULT;
> +
> +	if (put_user(total_size, size) != 0)
> +		return -EFAULT;
> +
> +	if (usize < total_size)
> +		return -E2BIG;
> +
> +	for (i = 0; i < lsm_active_cnt; i++)
> +		if (put_user(lsm_idlist[i]->id, ids++))
> +			return -EFAULT;
> +
> +	return lsm_active_cnt;
> +}
> -- 
> 2.41.0
> 
