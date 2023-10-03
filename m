Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EB67B6B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240056AbjJCO2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjJCO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:28:24 -0400
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2ADAC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:28:21 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S0KtW2q00zMqQ4j;
        Tue,  3 Oct 2023 14:28:19 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S0KtV662VzMpnPj;
        Tue,  3 Oct 2023 16:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1696343299;
        bh=bxaiRwZbRP+DCPlU5RWsMgsAK1wN3CIFf3Qiv5AVhuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vqLFDImQ8xlJXyunnrGj/aBs+Um6iRfp/wEYXbhsbuo8uZ38WevLSkTHttQHw0TNW
         KUZWXP5okxlZd64fnzah1YJYlJjj61RZ/umSOImtjLQeXwXjiaqJNKmCqdiThgRQ4j
         rho/pZXMQaW/mD3BMVOQh/RdNhDLQ6BXPB0j0kNg=
Date:   Tue, 3 Oct 2023 16:28:19 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v15 08/11] Smack: implement setselfattr and getselfattr
 hooks
Message-ID: <20231003.uva7zohqueNu@digikod.net>
References: <20230912205658.3432-1-casey@schaufler-ca.com>
 <20230912205658.3432-9-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912205658.3432-9-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 01:56:53PM -0700, Casey Schaufler wrote:
> Implement Smack support for security_[gs]etselfattr.
> Refactor the setprocattr hook to avoid code duplication.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> ---
>  security/smack/smack_lsm.c | 95 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 5 deletions(-)
> 
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index f73f9a2834eb..12160d060cc1 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -3626,6 +3626,46 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
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
> + * Returns the number of attributes on success, an error code otherwise.
> + * There will only ever be one attribute.
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

Can we move these checks into lsm_fill_user_ctx()? They are similar for
AppArmor and SELinux.

> +
> +	*size = total;
> +	if (rc >= 0)
> +		return 1;
> +	return rc;
> +}
