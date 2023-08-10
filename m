Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089CB777CF7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjHJP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbjHJP5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:57:32 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6832715;
        Thu, 10 Aug 2023 08:57:30 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 1DC803F5DF;
        Thu, 10 Aug 2023 15:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691683049;
        bh=afaGiTyx6I6De7+XWpFHjgDbhECkNuyNzAO7e+Z+xJ4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=T9QZKhooTG3JLBECR1pHr3Q/X9eJhwSH4ZCbF/g05BVV9Qkneci9gUWXW7ypnDZer
         KA8uEoA+ESqqdPGQOtz4IT1Pyh1fTPzUfq8Sis2ZVa7GYLuceHs467JJQ9UqnSFrGt
         kRyELVd5cpp/SODYcGYSTfsezom1w8pLtsJ/9ExtmHj3a+obKRcWxXa/YuUOi3hGkD
         nkI1+Vo1DKXJJalUhrLcJ5bjNuj/z+Jl8RYWwigpBnw5+wVIS/gzGXMl9uxvLxaAlB
         TbDmNTE9rA11K4tHXV1jxbJU1ctUE1NbpDn3ZeP7d+AC8MllbmDfT/EEqW7ZnL2sqO
         Ub3lzYc11fJXQ==
Message-ID: <8ec73c4f-bf21-0a8e-648f-b2ccc592aef9@canonical.com>
Date:   Thu, 10 Aug 2023 08:57:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 08/11] Smack: implement setselfattr and getselfattr
 hooks
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-9-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-9-casey@schaufler-ca.com>
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
> Implement Smack support for security_[gs]etselfattr.
> Refactor the setprocattr hook to avoid code duplication.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/smack/smack_lsm.c | 94 ++++++++++++++++++++++++++++++++++++--
>   1 file changed, 89 insertions(+), 5 deletions(-)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f3e4b26c8a87..71c773fff971 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3565,6 +3565,45 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>   	return;
>   }
>   
> +/**
> + * smack_getselfattr - Smack current process attribute
> + * @attr: which attribute to fetch
> + * @ctx: buffer to receive the result
> + * @size: available size in, actual size out
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns 1, the number of attributes, on success, an error code otherwise.
> + */
> +static int smack_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			     size_t *size, u32 flags)
> +{
> +	struct smack_known *skp = smk_of_current();
> +	int total;
> +	int slen;
> +	int rc;
> +
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
> +
> +	slen = strlen(skp->smk_known) + 1;
> +	total = ALIGN(slen + sizeof(*ctx), 8);
> +	if (total > *size)
> +		rc = -E2BIG;
> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, skp->smk_known, slen, LSM_ID_SMACK,
> +				       0);
> +	else
> +		rc = 1;
> +
> +	*size = total;
> +	if (rc >= 0)
> +		return 1;
> +	return rc;
> +}
> +
>   /**
>    * smack_getprocattr - Smack process attribute access
>    * @p: the object task
> @@ -3594,8 +3633,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>   }
>   
>   /**
> - * smack_setprocattr - Smack process attribute setting
> - * @name: the name of the attribute in /proc/.../attr
> + * do_setattr - Smack process attribute setting
> + * @attr: the ID of the attribute
>    * @value: the value to set
>    * @size: the size of the value
>    *
> @@ -3604,7 +3643,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>    *
>    * Returns the length of the smack label or an error code
>    */
> -static int smack_setprocattr(const char *name, void *value, size_t size)
> +static int do_setattr(u64 attr, void *value, size_t size)
>   {
>   	struct task_smack *tsp = smack_cred(current_cred());
>   	struct cred *new;
> @@ -3618,8 +3657,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>   	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
>   		return -EINVAL;
>   
> -	if (strcmp(name, "current") != 0)
> -		return -EINVAL;
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
>   
>   	skp = smk_import_entry(value, size);
>   	if (IS_ERR(skp))
> @@ -3658,6 +3697,49 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>   	return size;
>   }
>   
> +/**
> + * smack_setselfattr - Set a Smack process attribute
> + * @attr: which attribute to set
> + * @ctx: buffer containing the data
> + * @size: size of @ctx
> + * @flags: unused
> + *
> + * Fill the passed user space @ctx with the details of the requested
> + * attribute.
> + *
> + * Returns 0 on success, an error code otherwise.
> + */
> +static int smack_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
> +			     size_t size, u32 flags)
> +{
> +	int rc;
> +
> +	rc = do_setattr(attr, ctx->ctx, ctx->ctx_len);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +/**
> + * smack_setprocattr - Smack process attribute setting
> + * @name: the name of the attribute in /proc/.../attr
> + * @value: the value to set
> + * @size: the size of the value
> + *
> + * Sets the Smack value of the task. Only setting self
> + * is permitted and only with privilege
> + *
> + * Returns the length of the smack label or an error code
> + */
> +static int smack_setprocattr(const char *name, void *value, size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr != LSM_ATTR_UNDEF)
> +		return do_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>   /**
>    * smack_unix_stream_connect - Smack access on UDS
>    * @sock: one sock
> @@ -4970,6 +5052,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>   
>   	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
>   
> +	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
>   	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
>   	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
>   

