Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA6777CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjHJPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235403AbjHJPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:55:29 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD62D48;
        Thu, 10 Aug 2023 08:55:23 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3BDF53F5DF;
        Thu, 10 Aug 2023 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691682922;
        bh=0/6gigYbqt/Tsc+5o1soyJ99DMfWH50yGGF+egAgaDM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=uykp4SeruazRykyG2BYREuNAKp27/HbDGUpI/APPhWElzXP9nIEJ6y6gA/TpPP7e3
         XY9AmhOlowuPEICFK9hmTPMju63c+16zjThlWGs0B98lGI1y0zSpwttmZ35LK4krE8
         +Xaw4R8GQfpWJaPvrrX6bv2tcWpOlP8QODMpp+eAJt34VqbMD4bcm4jRQa6QkMvwtx
         frNluTxZQEIpjrrUrLoWZEPqNoyaafOugSv6hX6ZMFcViFb1juTwiLezkPwW1W77o+
         nEDsvGRZrSxB4tx0hZLytUWTJ0sOKxokFovS8EIIk2Xlsl+aAynpdB6gCxu2Z/6+LO
         5ZRrcqSwIseLw==
Message-ID: <13764c19-8495-d3eb-dbe4-f178d5dbb001@canonical.com>
Date:   Thu, 10 Aug 2023 08:55:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-5-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-5-casey@schaufler-ca.com>
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
>          __u64 id;
>          __u64 flags;
>          __u64 len;
>          __u64 ctx_len;
>          __u8 ctx[];
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

Reviewed-by: John Johansen <john.johansen@canonical.com>


> ---
>   Documentation/userspace-api/lsm.rst |  70 ++++++++++++++++
>   include/linux/lsm_hook_defs.h       |   4 +
>   include/linux/lsm_hooks.h           |   1 +
>   include/linux/security.h            |  19 +++++
>   include/linux/syscalls.h            |   5 ++
>   include/uapi/linux/lsm.h            |  90 ++++++++++++++++++++
>   kernel/sys_ni.c                     |   2 +
>   security/Makefile                   |   1 +
>   security/lsm_syscalls.c             |  55 ++++++++++++
>   security/security.c                 | 125 ++++++++++++++++++++++++++++
>   10 files changed, 372 insertions(+)
>   create mode 100644 Documentation/userspace-api/lsm.rst
>   create mode 100644 include/uapi/linux/lsm.h
>   create mode 100644 security/lsm_syscalls.c
> 
> diff --git a/Documentation/userspace-api/lsm.rst b/Documentation/userspace-api/lsm.rst
> new file mode 100644
> index 000000000000..f8499f3e2826
> --- /dev/null
> +++ b/Documentation/userspace-api/lsm.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> +.. Copyright (C) 2022 Intel Corporation
> +
> +=====================================
> +Linux Security Modules
> +=====================================
> +
> +:Author: Casey Schaufler
> +:Date: July 2023
> +
> +Linux security modules (LSM) provide a mechanism to implement
> +additional access controls to the Linux security policies.
> +
> +The various security modules may support any of these attributes:
> +
> +``LSM_ATTR_CURRENT`` is the current, active security context of the
> +process.
> +The proc filesystem provides this value in ``/proc/self/attr/current``.
> +This is supported by the SELinux, Smack and AppArmor security modules.
> +Smack also provides this value in ``/proc/self/attr/smack/current``.
> +AppArmor also provides this value in ``/proc/self/attr/apparmor/current``.
> +
> +``LSM_ATTR_EXEC`` is the security context of the process at the time the
> +current image was executed.
> +The proc filesystem provides this value in ``/proc/self/attr/exec``.
> +This is supported by the SELinux and AppArmor security modules.
> +AppArmor also provides this value in ``/proc/self/attr/apparmor/exec``.
> +
> +``LSM_ATTR_FSCREATE`` is the security context of the process used when
> +creating file system objects.
> +The proc filesystem provides this value in ``/proc/self/attr/fscreate``.
> +This is supported by the SELinux security module.
> +
> +``LSM_ATTR_KEYCREATE`` is the security context of the process used when
> +creating key objects.
> +The proc filesystem provides this value in ``/proc/self/attr/keycreate``.
> +This is supported by the SELinux security module.
> +
> +``LSM_ATTR_PREV`` is the security context of the process at the time the
> +current security context was set.
> +The proc filesystem provides this value in ``/proc/self/attr/prev``.
> +This is supported by the SELinux and AppArmor security modules.
> +AppArmor also provides this value in ``/proc/self/attr/apparmor/prev``.
> +
> +``LSM_ATTR_SOCKCREATE`` is the security context of the process used when
> +creating socket objects.
> +The proc filesystem provides this value in ``/proc/self/attr/sockcreate``.
> +This is supported by the SELinux security module.
> +
> +Kernel interface
> +================
> +
> +Set a security attribute of the current process
> +-----------------------------------------------
> +
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_set_self_attr
> +
> +Get the specified security attributes of the current process
> +------------------------------------------------------------
> +
> +.. kernel-doc:: security/lsm_syscalls.c
> +    :identifiers: sys_lsm_get_self_attr
> +
> +Additional documentation
> +========================
> +
> +* Documentation/security/lsm.rst
> +* Documentation/security/lsm-development.rst
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 7308a1a7599b..6dffac59dfe3 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -261,6 +261,10 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
>   LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
>   LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
>   	 struct inode *inode)
> +LSM_HOOK(int, -EOPNOTSUPP, getselfattr, unsigned int attr,
> +	 struct lsm_ctx __user *ctx, size_t *size, u32 flags)
> +LSM_HOOK(int, -EOPNOTSUPP, setselfattr, unsigned int attr,
> +	 struct lsm_ctx *ctx, size_t size, u32 flags)
>   LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
>   	 char **value)
>   LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 5f7d8caacc00..0662e5c2cd06 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -25,6 +25,7 @@
>   #ifndef __LINUX_LSM_HOOKS_H
>   #define __LINUX_LSM_HOOKS_H
>   
> +#include <uapi/linux/lsm.h>
>   #include <linux/security.h>
>   #include <linux/init.h>
>   #include <linux/rculist.h>
> diff --git a/include/linux/security.h b/include/linux/security.h
> index b5fd3f7f4cd3..0d882cb221f4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -60,6 +60,7 @@ struct fs_parameter;
>   enum fs_value_type;
>   struct watch;
>   struct watch_notification;
> +struct lsm_ctx;
>   
>   /* Default (no) options for the capable function */
>   #define CAP_OPT_NONE 0x0
> @@ -470,6 +471,10 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
>   int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
>   			unsigned nsops, int alter);
>   void security_d_instantiate(struct dentry *dentry, struct inode *inode);
> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t __user *size, u32 flags);
> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			 size_t size, u32 flags);
>   int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>   			 char **value);
>   int security_setprocattr(int lsmid, const char *name, void *value, size_t size);
> @@ -1331,6 +1336,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
>   					  struct inode *inode)
>   { }
>   
> +static inline int security_getselfattr(unsigned int attr,
> +				       struct lsm_ctx __user *ctx,
> +				       size_t __user *size, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int security_setselfattr(unsigned int attr,
> +				       struct lsm_ctx __user *ctx,
> +				       size_t size, u32 flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int security_getprocattr(struct task_struct *p, int lsmid,
>   				       const char *name, char **value)
>   {
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 03e3d0121d5e..a3938850752a 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -71,6 +71,7 @@ struct clone_args;
>   struct open_how;
>   struct mount_attr;
>   struct landlock_ruleset_attr;
> +struct lsm_ctx;
>   enum landlock_rule_type;
>   struct cachestat_range;
>   struct cachestat;
> @@ -953,6 +954,10 @@ asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long l
>   asmlinkage long sys_cachestat(unsigned int fd,
>   		struct cachestat_range __user *cstat_range,
>   		struct cachestat __user *cstat, unsigned int flags);
> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +		size_t *size, __u32 flags);
> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +		size_t size, __u32 flags);
>   
>   /*
>    * Architecture-specific system calls
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..eeda59a77c02
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linux Security Modules (LSM) - User space API
> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2022 Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context information
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: LSM specific flags
> + * @len: length of the lsm_ctx struct, @ctx and any other data or padding
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context value
> + *
> + * The @len field MUST be equal to the size of the lsm_ctx struct
> + * plus any additional padding and/or data placed after @ctx.
> + *
> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> + * If @ctx is a string value it should be nul terminated with
> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> + * supported.
> + *
> + * The @flags and @ctx fields SHOULD only be interpreted by the
> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> + */
> +struct lsm_ctx {
> +	__u64 id;
> +	__u64 flags;
> +	__u64 len;
> +	__u64 ctx_len;
> +	__u8 ctx[];
> +};
> +
> +/*
> + * ID tokens to identify Linux Security Modules (LSMs)
> + *
> + * These token values are used to uniquely identify specific LSMs
> + * in the kernel as well as in the kernel's LSM userspace API.
> + *
> + * A value of zero/0 is considered undefined and should not be used
> + * outside the kernel. Values 1-99 are reserved for potential
> + * future use.
> + */
> +#define LSM_ID_UNDEF		0
> +#define LSM_ID_CAPABILITY	100
> +#define LSM_ID_SELINUX		101
> +#define LSM_ID_SMACK		102
> +#define LSM_ID_TOMOYO		103
> +#define LSM_ID_IMA		104
> +#define LSM_ID_APPARMOR		105
> +#define LSM_ID_YAMA		106
> +#define LSM_ID_LOADPIN		107
> +#define LSM_ID_SAFESETID	108
> +#define LSM_ID_LOCKDOWN		109
> +#define LSM_ID_BPF		110
> +#define LSM_ID_LANDLOCK		111
> +
> +/*
> + * LSM_ATTR_XXX definitions identify different LSM attributes
> + * which are used in the kernel's LSM userspace API. Support
> + * for these attributes vary across the different LSMs. None
> + * are required.
> + *
> + * A value of zero/0 is considered undefined and should not be used
> + * outside the kernel. Values 1-99 are reserved for potential
> + * future use.
> + */
> +#define LSM_ATTR_UNDEF		0
> +#define LSM_ATTR_CURRENT	100
> +#define LSM_ATTR_EXEC		101
> +#define LSM_ATTR_FSCREATE	102
> +#define LSM_ATTR_KEYCREATE	103
> +#define LSM_ATTR_PREV		104
> +#define LSM_ATTR_SOCKCREATE	105
> +
> +/*
> + * LSM_FLAG_XXX definitions identify special handling instructions
> + * for the API.
> + */
> +#define LSM_FLAG_SINGLE	0x0001
> +
> +#endif /* _UAPI_LINUX_LSM_H */
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 781de7cc6a4e..8b96cd01b485 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -170,6 +170,8 @@ COND_SYSCALL(landlock_add_rule);
>   COND_SYSCALL(landlock_restrict_self);
>   COND_SYSCALL(fadvise64_64);
>   COND_SYSCALL_COMPAT(fadvise64_64);
> +COND_SYSCALL(lsm_get_self_attr);
> +COND_SYSCALL(lsm_set_self_attr);
>   
>   /* CONFIG_MMU only */
>   COND_SYSCALL(swapon);
> diff --git a/security/Makefile b/security/Makefile
> index 18121f8f85cd..59f238490665 100644
> --- a/security/Makefile
> +++ b/security/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_KEYS)			+= keys/
>   
>   # always enable default capabilities
>   obj-y					+= commoncap.o
> +obj-$(CONFIG_SECURITY) 			+= lsm_syscalls.o
>   obj-$(CONFIG_MMU)			+= min_addr.o
>   
>   # Object file lists
> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> new file mode 100644
> index 000000000000..ee3881159241
> --- /dev/null
> +++ b/security/lsm_syscalls.c
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * System calls implementing the Linux Security Module API.
> + *
> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + *  Copyright (C) 2022 Intel Corporation
> + */
> +
> +#include <asm/current.h>
> +#include <linux/compiler_types.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/security.h>
> +#include <linux/stddef.h>
> +#include <linux/syscalls.h>
> +#include <linux/types.h>
> +#include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> +
> +/**
> + * sys_lsm_set_self_attr - Set current task's security module attribute
> + * @attr: which attribute to set
> + * @ctx: the LSM contexts
> + * @size: size of @ctx
> + * @flags: reserved for future use
> + *
> + * Sets the calling task's LSM context. On success this function
> + * returns 0. If the attribute specified cannot be set a negative
> + * value indicating the reason for the error is returned.
> + */
> +SYSCALL_DEFINE4(lsm_set_self_attr, unsigned int, attr, struct lsm_ctx __user *,
> +		ctx, size_t, size, u32, flags)
> +{
> +	return security_setselfattr(attr, ctx, size, flags);
> +}
> +
> +/**
> + * sys_lsm_get_self_attr - Return current task's security module attributes
> + * @attr: which attribute to set
> + * @ctx: the LSM contexts
> + * @size: size of @ctx, updated on return
> + * @flags: reserved for future use
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
>   }
>   EXPORT_SYMBOL(security_d_instantiate);
>   
> +/**
> + * security_getselfattr - Read an LSM attribute of the current process.
> + * @attr: which attribute to return
> + * @ctx: the user-space destination for the information, or NULL
> + * @size: pointer to the size of space available to receive the data
> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
> + * attributes associated with the LSM identified in the passed @ctx be
> + * reported
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
> +			return -EINVAL;
> +		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
> +			return -EFAULT;
> +		if (lctx.id == LSM_ID_UNDEF)
> +			return -EINVAL;
> +	} else if (flags) {
> +		return -EINVAL;
> +	}
> +
> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
> +			continue;
> +		entrysize = left;
> +		if (base)
> +			ctx = (struct lsm_ctx __user *)(base + total);
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
> +	if (lctx == NULL)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(&lctx, ctx, size))
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
>   /**
>    * security_getprocattr() - Read an attribute for a task
>    * @p: the task

