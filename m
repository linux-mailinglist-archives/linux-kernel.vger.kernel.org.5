Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74378777CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235232AbjHJPxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjHJPxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:53:20 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C334D1994;
        Thu, 10 Aug 2023 08:53:19 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 226CC3F5DF;
        Thu, 10 Aug 2023 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691682798;
        bh=HKQ1qSHJQOwPObqSGRjhcW1MXr6/YHktZSg3rEnC1aU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FCwCp7SM8rEIp4+OU9foE5HIdoXKRKHT8bkT3YHTU6JLD7XS7SWXgRChPg2nAbrJ/
         12M7YbMKMAbJocP34cEZRJNJkAZKCW/0ilG77O41BxVz6tSoMrn24yEkD9NWI2HU5+
         LQ3Z4u3nsx5E02yYNdgwTtUiFVUwaFaNIyf2rUI4MKr43eL4Rp3//9GuST9NZ2hKzG
         rcrh6WBvXK1okLHiRZ0E3pUhJfyWEFMVQyOf21nt0xr+aWJnqBBS48XbQzHqNjrDWC
         TRR+pEuhAebindNNvoVA2S9ikcwXt/ICWC7QvGPVCdHulFmXXynProbmObN+hUupUb
         KM9rbnJ99P+8Q==
Message-ID: <e078b560-28da-3f69-c563-38f69932ee0d@canonical.com>
Date:   Thu, 10 Aug 2023 08:53:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v13 09/11] AppArmor: Add selfattr hooks
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-10-casey@schaufler-ca.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <20230802174435.11928-10-casey@schaufler-ca.com>
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
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: John Johansen <john.johansen@canonical.com>
Acked-by: John Johansen <john.johansen@canonical.com>

> ---
>   security/apparmor/include/procattr.h |  2 +-
>   security/apparmor/lsm.c              | 91 ++++++++++++++++++++++++++--
>   security/apparmor/procattr.c         | 10 +--
>   3 files changed, 92 insertions(+), 11 deletions(-)
> 
> diff --git a/security/apparmor/include/procattr.h b/security/apparmor/include/procattr.h
> index 31689437e0e1..03dbfdb2f2c0 100644
> --- a/security/apparmor/include/procattr.h
> +++ b/security/apparmor/include/procattr.h
> @@ -11,7 +11,7 @@
>   #ifndef __AA_PROCATTR_H
>   #define __AA_PROCATTR_H
>   
> -int aa_getprocattr(struct aa_label *label, char **string);
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline);
>   int aa_setprocattr_changehat(char *args, size_t size, int flags);
>   
>   #endif /* __AA_PROCATTR_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index bfd049c3fd22..cd54e5ecb46a 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -630,6 +630,55 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
>   	return error;
>   }
>   
> +static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
> +				size_t *size, u32 flags)
> +{
> +	int error = -ENOENT;
> +	struct aa_task_ctx *ctx = task_ctx(current);
> +	struct aa_label *label = NULL;
> +	size_t total_len = 0;
> +	char *value;
> +
> +	switch (attr) {
> +	case LSM_ATTR_CURRENT:
> +		label = aa_get_newest_label(cred_label(current_cred()));
> +		break;
> +	case LSM_ATTR_PREV:
> +		if (ctx->previous)
> +			label = aa_get_newest_label(ctx->previous);
> +		break;
> +	case LSM_ATTR_EXEC:
> +		if (ctx->onexec)
> +			label = aa_get_newest_label(ctx->onexec);
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	if (label) {
> +		error = aa_getprocattr(label, &value, false);
> +		if (error > 0) {
> +			total_len = ALIGN(struct_size(lx, ctx, error), 8);
> +			if (total_len > *size)
> +				error = -E2BIG;
> +			else if (lx)
> +				error = lsm_fill_user_ctx(lx, value, error,
> +							  LSM_ID_APPARMOR, 0);
> +			else
> +				error = 1;
> +		}
> +		kfree(value);
> +	}
> +
> +	aa_put_label(label);
> +
> +	*size = total_len;
> +	if (error < 0)
> +		return error;
> +	return 1;
> +}
> +
>   static int apparmor_getprocattr(struct task_struct *task, const char *name,
>   				char **value)
>   {
> @@ -649,7 +698,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
>   		error = -EINVAL;
>   
>   	if (label)
> -		error = aa_getprocattr(label, value);
> +		error = aa_getprocattr(label, value, true);
>   
>   	aa_put_label(label);
>   	put_cred(cred);
> @@ -657,8 +706,7 @@ static int apparmor_getprocattr(struct task_struct *task, const char *name,
>   	return error;
>   }
>   
> -static int apparmor_setprocattr(const char *name, void *value,
> -				size_t size)
> +static int do_setattr(u64 attr, void *value, size_t size)
>   {
>   	char *command, *largs = NULL, *args = value;
>   	size_t arg_size;
> @@ -689,7 +737,7 @@ static int apparmor_setprocattr(const char *name, void *value,
>   		goto out;
>   
>   	arg_size = size - (args - (largs ? largs : (char *) value));
> -	if (strcmp(name, "current") == 0) {
> +	if (attr == LSM_ATTR_CURRENT) {
>   		if (strcmp(command, "changehat") == 0) {
>   			error = aa_setprocattr_changehat(args, arg_size,
>   							 AA_CHANGE_NOFLAGS);
> @@ -704,7 +752,7 @@ static int apparmor_setprocattr(const char *name, void *value,
>   			error = aa_change_profile(args, AA_CHANGE_STACK);
>   		} else
>   			goto fail;
> -	} else if (strcmp(name, "exec") == 0) {
> +	} else if (attr == LSM_ATTR_EXEC) {
>   		if (strcmp(command, "exec") == 0)
>   			error = aa_change_profile(args, AA_CHANGE_ONEXEC);
>   		else if (strcmp(command, "stack") == 0)
> @@ -724,13 +772,42 @@ static int apparmor_setprocattr(const char *name, void *value,
>   
>   fail:
>   	aad(&sa)->label = begin_current_label_crit_section();
> -	aad(&sa)->info = name;
> +	if (attr == LSM_ATTR_CURRENT)
> +		aad(&sa)->info = "current";
> +	else if (attr == LSM_ATTR_EXEC)
> +		aad(&sa)->info = "exec";
> +	else
> +		aad(&sa)->info = "invalid";
>   	aad(&sa)->error = error = -EINVAL;
>   	aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
>   	end_current_label_crit_section(aad(&sa)->label);
>   	goto out;
>   }
>   
> +static int apparmor_setselfattr(unsigned int attr, struct lsm_ctx *ctx,
> +				size_t size, u32 flags)
> +{
> +	int rc;
> +
> +	if (attr != LSM_ATTR_CURRENT && attr != LSM_ATTR_EXEC)
> +		return -EOPNOTSUPP;
> +
> +	rc = do_setattr(attr, ctx->ctx, ctx->ctx_len);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +static int apparmor_setprocattr(const char *name, void *value,
> +				size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)
> +		return do_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>   /**
>    * apparmor_bprm_committing_creds - do task cleanup on committing new creds
>    * @bprm: binprm for the exec  (NOT NULL)
> @@ -1253,6 +1330,8 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
>   	LSM_HOOK_INIT(file_lock, apparmor_file_lock),
>   	LSM_HOOK_INIT(file_truncate, apparmor_file_truncate),
>   
> +	LSM_HOOK_INIT(getselfattr, apparmor_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, apparmor_setselfattr),
>   	LSM_HOOK_INIT(getprocattr, apparmor_getprocattr),
>   	LSM_HOOK_INIT(setprocattr, apparmor_setprocattr),
>   
> diff --git a/security/apparmor/procattr.c b/security/apparmor/procattr.c
> index 197d41f9c32b..e3857e3d7c6c 100644
> --- a/security/apparmor/procattr.c
> +++ b/security/apparmor/procattr.c
> @@ -20,6 +20,7 @@
>    * aa_getprocattr - Return the label information for @label
>    * @label: the label to print label info about  (NOT NULL)
>    * @string: Returns - string containing the label info (NOT NULL)
> + * @newline: indicates that a newline should be added
>    *
>    * Requires: label != NULL && string != NULL
>    *
> @@ -27,7 +28,7 @@
>    *
>    * Returns: size of string placed in @string else error code on failure
>    */
> -int aa_getprocattr(struct aa_label *label, char **string)
> +int aa_getprocattr(struct aa_label *label, char **string, bool newline)
>   {
>   	struct aa_ns *ns = labels_ns(label);
>   	struct aa_ns *current_ns = aa_get_current_ns();
> @@ -57,11 +58,12 @@ int aa_getprocattr(struct aa_label *label, char **string)
>   		return len;
>   	}
>   
> -	(*string)[len] = '\n';
> -	(*string)[len + 1] = 0;
> +	if (newline)
> +		(*string)[len++] = '\n';
> +	(*string)[len] = 0;
>   
>   	aa_put_ns(current_ns);
> -	return len + 1;
> +	return len;
>   }
>   
>   /**

