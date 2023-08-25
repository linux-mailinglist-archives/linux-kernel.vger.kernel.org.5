Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F50788C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343856AbjHYPAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343895AbjHYPAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:00:35 -0400
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [IPv6:2001:1600:4:17::42ae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B242126
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 08:00:33 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RXNRd51XGzMrDCp;
        Fri, 25 Aug 2023 15:00:29 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RXNRb5dkbzMpp9w;
        Fri, 25 Aug 2023 17:00:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692975629;
        bh=MWLOkIhU3cieHE64ijsQJbZNvf/Q/VzrZFdssdSQjKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+ZeYvz28WWNongStm5hgbg6AHbg7VkeNBZtvNctX7lxyL5OBaAEvtzx/j81YghU8
         9CXjUZLgbiz0HBzcd7Z65EArbgm5/gY8Ykou6xLcwrZod/JpUGMyoka/iU4+/2zmeF
         AUj1i/cyJPzocJ2pI+kNXBuwQl4OG8NChoP4+wPk=
Date:   Fri, 25 Aug 2023 17:00:24 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v13 10/11] SELinux: Add selfattr hooks
Message-ID: <20230825.iQuae1shaifo@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-11-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-11-casey@schaufler-ca.com>
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

On Wed, Aug 02, 2023 at 10:44:33AM -0700, Casey Schaufler wrote:
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 136 +++++++++++++++++++++++++++++++--------
>  1 file changed, 109 insertions(+), 27 deletions(-)

> +static int selinux_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
> +			       size_t *size, u32 flags)
> +{
> +	char *value;
> +	size_t total_len;
> +	int len;
> +	int rc;
> +
> +	len = selinux_lsm_getattr(attr, current, &value);
> +	if (len < 0)
> +		return len;
> +
> +	total_len = ALIGN(struct_size(ctx, ctx, len), 8);
> +
> +	if (total_len > *size)

It looks a bit weird that size must be greater than all the LSM
attributes even when ctx is NULL. Same for other getselfattr hook
implementations.

> +		rc = -E2BIG;
> +	else if (ctx)
> +		rc = lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +	else
> +		rc = 1;

Agreed with Paul, we should initialize rc to zero.

> +
> +	kfree(value);
> +	*size = total_len;
> +	if (rc < 0)
> +		return rc;
> +	return 1;
> +}
> +
> +static int selinux_setselfattr(unsigned int __user attr, struct lsm_ctx *ctx,
> +			       size_t __user size, u32 __user flags)

This __user attribute is dedicated to user pointers, not values.

> +{
> +	int rc;
> +

Good to see this refactoring!

> +	rc = selinux_lsm_setattr(attr, ctx->ctx, ctx->ctx_len);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +static int selinux_getprocattr(struct task_struct *p,
> +			       const char *name, char **value)
> +{
> +	unsigned int attr = lsm_name_to_attr(name);
> +	int rc;
> +
> +	if (attr) {
> +		rc = selinux_lsm_getattr(attr, p, value);
> +		if (rc != -EOPNOTSUPP)
> +			return rc;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int selinux_setprocattr(const char *name, void *value, size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)
> +		return selinux_lsm_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>  static int selinux_ismaclabel(const char *name)
>  {
>  	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
> @@ -7080,6 +7160,8 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
>  
>  	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
>  
> +	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>  
> -- 
> 2.41.0
> 
