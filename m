Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CDD778884
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjHKHqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHKHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:46:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7F1FDD;
        Fri, 11 Aug 2023 00:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74CB0648F4;
        Fri, 11 Aug 2023 07:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFF5C433C8;
        Fri, 11 Aug 2023 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691740000;
        bh=GuyoCPl/YJ4xO8sOUZZlYV2+Wm0YbUzDtduIENXUP5Q=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=e1diiZqDkCg25FdOmDG287DkAJgVNNQAff+9luMOhmk0PipbY7RrX5yIwP7buDo/A
         yrrEVU9hCyH/fScD5LTtvcoRVU+HMPE3DHBMxiNsKTOsGqHhsj1QTRThfkDZiK4MK3
         jWhSEXxPrQBu6H3G+KEAaE4gxU2HPyVpHFaf2fjEAu3FoMHdaOzo+Zf45gUa/UwejU
         zBdCFsmlUUqeJ92Ba5MRwjmYov++aY+MxhEHW4QB188/xnVIckJhm68PyHf/xTdV0K
         KhbA3TXdbO7n5HQNY9kK3YTgc8Q6YzoI9a0QYgRvGcIC/NGA85aK/sPzYNqvXNmIa1
         3F7KBkmymQvAw==
Message-ID: <58ea6863-53cd-228b-1474-f67b0bb134f0@kernel.org>
Date:   Fri, 11 Aug 2023 10:46:34 +0300
MIME-Version: 1.0
From:   Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH v3 1/3] debugfs: Add write support to debugfs_create_str()
To:     Mike Tipton <quic_mdtipton@quicinc.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org, corbet@lwn.net
Cc:     linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        quic_okukatla@quicinc.com, quic_viveka@quicinc.com,
        peterz@infradead.org, quic_pkondeti@quicinc.com
References: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
 <20230807142914.12480-2-quic_mdtipton@quicinc.com>
Content-Language: en-US
In-Reply-To: <20230807142914.12480-2-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.23 17:29, Mike Tipton wrote:
> Currently, debugfs_create_str() only supports reading strings from
> debugfs. Add support for writing them as well.
> 
> Based on original implementation by Peter Zijlstra [0]. Write support
> was present in the initial patch version, but dropped in v2 due to lack
> of users. We have a user now, so reintroduce it.
> 
> [0] https://lore.kernel.org/all/YF3Hv5zXb%2F6lauzs@hirez.programming.kicks-ass.net/
> 

Hi Greg,

Looks like the original code was reviewed two years ago (not sure if it
counts). But in any case, i need an ack from you to apply this.

There is no build dependency with the rest of the patches (but there is a
functional one). It should be also fine if you apply it directly, if you
prefer so?

Thanks,
Georgi

> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
>   fs/debugfs/file.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index b7711888dd17..87b3753aa4b1 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -904,8 +904,52 @@ EXPORT_SYMBOL_GPL(debugfs_create_str);
>   static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
>   				      size_t count, loff_t *ppos)
>   {
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
>   }
>   
>   static const struct file_operations fops_str = {

