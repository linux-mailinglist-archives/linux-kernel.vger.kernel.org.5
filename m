Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C83780EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378084AbjHRPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378146AbjHRPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:15:07 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C654490;
        Fri, 18 Aug 2023 08:14:38 -0700 (PDT)
Received: from jerom (unknown [128.107.241.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 7061E746;
        Fri, 18 Aug 2023 10:14:15 -0500 (CDT)
Date:   Fri, 18 Aug 2023 10:14:12 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v13 08/11] Smack: implement setselfattr and getselfattr
 hooks
Message-ID: <ZN+KxAMILtSvlKdK@jerom>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-9-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-9-casey@schaufler-ca.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:44:31AM -0700, Casey Schaufler wrote:
> Implement Smack support for security_[gs]etselfattr.
> Refactor the setprocattr hook to avoid code duplication.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  security/smack/smack_lsm.c | 94 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 89 insertions(+), 5 deletions(-)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f3e4b26c8a87..71c773fff971 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3565,6 +3565,45 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
>  	return;
>  }
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

This comment is confusing.  is it saying that 1 is always the number
of attributes?  Because the "if (rc >= 0) return 1;" ensure that
it only ever returns 1 or < 0.

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
>  /**
>   * smack_getprocattr - Smack process attribute access
>   * @p: the object task
> @@ -3594,8 +3633,8 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>  }
>  
>  /**
> - * smack_setprocattr - Smack process attribute setting
> - * @name: the name of the attribute in /proc/.../attr
> + * do_setattr - Smack process attribute setting
> + * @attr: the ID of the attribute
>   * @value: the value to set
>   * @size: the size of the value
>   *
> @@ -3604,7 +3643,7 @@ static int smack_getprocattr(struct task_struct *p, const char *name, char **val
>   *
>   * Returns the length of the smack label or an error code
>   */
> -static int smack_setprocattr(const char *name, void *value, size_t size)
> +static int do_setattr(u64 attr, void *value, size_t size)
>  {
>  	struct task_smack *tsp = smack_cred(current_cred());
>  	struct cred *new;
> @@ -3618,8 +3657,8 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	if (value == NULL || size == 0 || size >= SMK_LONGLABEL)
>  		return -EINVAL;
>  
> -	if (strcmp(name, "current") != 0)
> -		return -EINVAL;
> +	if (attr != LSM_ATTR_CURRENT)
> +		return -EOPNOTSUPP;
>  
>  	skp = smk_import_entry(value, size);
>  	if (IS_ERR(skp))
> @@ -3658,6 +3697,49 @@ static int smack_setprocattr(const char *name, void *value, size_t size)
>  	return size;
>  }
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
>  /**
>   * smack_unix_stream_connect - Smack access on UDS
>   * @sock: one sock
> @@ -4970,6 +5052,8 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
>  
>  	LSM_HOOK_INIT(d_instantiate, smack_d_instantiate),
>  
> +	LSM_HOOK_INIT(getselfattr, smack_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, smack_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, smack_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, smack_setprocattr),
>  
> -- 
> 2.41.0
> 
> 
