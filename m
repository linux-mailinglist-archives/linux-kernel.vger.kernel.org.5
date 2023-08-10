Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8991F777CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHJP4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjHJP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:56:19 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A672112;
        Thu, 10 Aug 2023 08:56:19 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 927C93F5DF;
        Thu, 10 Aug 2023 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691682978;
        bh=xXs67xX5eSem2DETtWFAM143oEDYupG/6NmY4oyGPuU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=kjhBUMlEKOL2vJHymABDSXeLBoUmIOk7iLA4A02yBkPjHaYm362FlhNjxDeyYIZp4
         UpiGCO6H9r2G71WK4PBUcwMrLxeb3D8EBqRFAZ/shdc4OxiosE6Mhjm/wmgQeZI/s0
         6NoHUwAWq/M36eseVH+yPAdr92uLxeJ7HkvQ41TL3Go85Jd0Uj1X7r8Qgo2T5wmvX0
         8B9NFBmCFxBkv1lUcthSNfUXOwodeTB5Jnzce0mnthkSeA9Nq6fWqViP8ThDWP2nqZ
         QWJHeQ+7iMx4X2+07llB6gxZqYc5NA/FtLcdJSW/limd/GMwLo2hRpoDuYGUmZ0vkb
         YOOg3JyKwCCNw==
Message-ID: <8aaac853-719b-f182-4a66-e4422de2cdf0@canonical.com>
Date:   Thu, 10 Aug 2023 08:55:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 05/11] LSM: Create lsm_list_modules system call
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-6-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-6-casey@schaufler-ca.com>
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

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>   Documentation/userspace-api/lsm.rst |  3 +++
>   include/linux/syscalls.h            |  1 +
>   kernel/sys_ni.c                     |  1 +
>   security/lsm_syscalls.c             | 39 +++++++++++++++++++++++++++++
>   4 files changed, 44 insertions(+)
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> index f8499f3e2826..a76da373841b 100644
> --- a/Documentation/userspace-api/lsm.rst
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -63,6 +63,9 @@ Get the specified security attributes of the current process
>   .. kernel-doc:: security/lsm_syscalls.c
>       :identifiers: sys_lsm_get_self_attr
>   
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_list_modules
> +
>   Additional documentation
>   ========================
>   
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a3938850752a..4e1596b5c300 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -958,6 +958,7 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>   		size_t *size, __u32 flags);
>   asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>   		size_t size, __u32 flags);
> +asmlinkage long sys_lsm_list_modules(u64 *ids, size_t *size, u32 flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 8b96cd01b485..7663ef16c07e 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -172,6 +172,7 @@ COND_SYSCALL(fadvise64_64);
>   COND_SYSCALL_COMPAT(fadvise64_64);
>   COND_SYSCALL(lsm_get_self_attr);
>   COND_SYSCALL(lsm_set_self_attr);
> +COND_SYSCALL(lsm_list_modules);
>   
>   /* CONFIG_MMU only */
>   COND_SYSCALL(swapon);
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> index ee3881159241..f03f2d17ab49 100644
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -53,3 +53,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, attr, struct lsm_ctx __user *,
>   {
>   	return security_getselfattr(attr, ctx, size, flags);
>   }
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

