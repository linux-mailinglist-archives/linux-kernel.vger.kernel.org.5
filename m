Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E894779F0F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbjHLKkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:40:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32D1720;
        Sat, 12 Aug 2023 03:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2629B60C36;
        Sat, 12 Aug 2023 10:40:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0118C433C7;
        Sat, 12 Aug 2023 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691836803;
        bh=FFptfCtf+waW/3p6NKc2ompsRkv2J2bQvCJ3CBn2rCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRmRKXiOVfml49KX2SPH4faT6O7B3g+bksu0JLFhLDF2HU365jAMatz6CWE/virlY
         29YeDfhsGZIsiJj2vHPO6KuEh1tiyw6mkJwo9oqS4PDjouw/TWkJXEaQXklHgdvyEd
         Wwqk3ULNn8BZnDtBm4K28HYMw9m5V0vFAclkSM6o=
Date:   Sat, 12 Aug 2023 12:40:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     djakov@kernel.org, rafael@kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_okukatla@quicinc.com, quic_viveka@quicinc.com,
        peterz@infradead.org, quic_pkondeti@quicinc.com
Subject: Re: [PATCH v3 1/3] debugfs: Add write support to debugfs_create_str()
Message-ID: <2023081203-happier-mutable-e4f0@gregkh>
References: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
 <20230807142914.12480-2-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807142914.12480-2-quic_mdtipton@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 07:29:12AM -0700, Mike Tipton wrote:
> Currently, debugfs_create_str() only supports reading strings from
> debugfs. Add support for writing them as well.
> 
> Based on original implementation by Peter Zijlstra [0]. Write support
> was present in the initial patch version, but dropped in v2 due to lack
> of users. We have a user now, so reintroduce it.
> 
> [0] https://lore.kernel.org/all/YF3Hv5zXb%2F6lauzs@hirez.programming.kicks-ass.net/
> 
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
>  fs/debugfs/file.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index b7711888dd17..87b3753aa4b1 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -904,8 +904,52 @@ EXPORT_SYMBOL_GPL(debugfs_create_str);
>  static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
>  				      size_t count, loff_t *ppos)
>  {
> -	/* This is really only for read-only strings */
> -	return -EINVAL;
> +	struct dentry *dentry = F_DENTRY(file);
> +	char *old, *new = NULL;
> +	int pos = *ppos;
> +	int r;
> +
> +	r = debugfs_file_get(dentry);
> +	if (unlikely(r))
> +		return r;
> +
> +	old = *(char **)file->private_data;
> +
> +	/* only allow strict concatenation */
> +	r = -EINVAL;
> +	if (pos && pos != strlen(old))
> +		goto error;
> +
> +	r = -E2BIG;
> +	if (pos + count + 1 > PAGE_SIZE)
> +		goto error;
> +
> +	r = -ENOMEM;
> +	new = kmalloc(pos + count + 1, GFP_KERNEL);
> +	if (!new)
> +		goto error;
> +
> +	if (pos)
> +		memcpy(new, old, pos);
> +
> +	r = -EFAULT;
> +	if (copy_from_user(new + pos, user_buf, count))
> +		goto error;
> +
> +	new[pos + count] = '\0';
> +	strim(new);
> +
> +	rcu_assign_pointer(*(char **)file->private_data, new);
> +	synchronize_rcu();
> +	kfree(old);
> +
> +	debugfs_file_put(dentry);
> +	return count;
> +
> +error:
> +	kfree(new);
> +	debugfs_file_put(dentry);
> +	return r;
>  }

So you just added write support for ALL debugfs files that use the
string interface, what did you just allow to break?

I recommend just using your own debugfs file function instead, as this
could cause bad problems, right?  Are you sure that all string calls can
handle the variable be freed underneath it like this call will allow to
happen?

So I wouldn't recommend doing this, sorry.

greg k-h
