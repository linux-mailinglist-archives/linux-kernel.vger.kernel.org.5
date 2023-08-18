Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAF7809B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349612AbjHRKIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376327AbjHRKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1893A4200;
        Fri, 18 Aug 2023 03:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDEA467A7A;
        Fri, 18 Aug 2023 10:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343CDC433C7;
        Fri, 18 Aug 2023 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692353165;
        bh=Sk8448M+cFRW8iS+/8IE71HSsgEjv+78Z0JrCd8+1l4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=puZK4MXbVoBW0rP82R5fWoGDIsQ67wY5+gVIuWiVRRHQpl5IhhRbX6bntVWUxxUEs
         sZObfeFpA4GG84pIyjZMYb6zi5wUvSjX+stNXScet+xO54WRKneAvLhqdDGJx9QImH
         A9qVAbY6Rn0dR/jCYW3b9GvRhFY/ECnfqYVP4cij5KWuH6xJ4wl6FjmZOjUaxqdM4F
         HnLXGkl0lCnfSksKVuWa19m+/0QT0QJMx0JhvH8NCA9MS4T1NNTOTJpASDGHEWaOA+
         yQUpL++fJSGcht+sDz3Ax0aFvfIZ+XPMwrwyi/17xnKB80f22hvh9R5bQz8B5Xhl0o
         u1DpwGDxjJ+/Q==
Message-ID: <44a63cb2-1ae5-f52b-19d2-fe03d48fd44d@kernel.org>
Date:   Fri, 18 Aug 2023 13:05:57 +0300
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] debugfs: Add write support to debugfs_create_str()
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     rafael@kernel.org, corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_okukatla@quicinc.com,
        quic_viveka@quicinc.com, peterz@infradead.org,
        quic_pkondeti@quicinc.com
References: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
 <20230807142914.12480-2-quic_mdtipton@quicinc.com>
 <2023081203-happier-mutable-e4f0@gregkh>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <2023081203-happier-mutable-e4f0@gregkh>
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

Hi Greg,

On 12.08.23 13:40, Greg KH wrote:
> On Mon, Aug 07, 2023 at 07:29:12AM -0700, Mike Tipton wrote:
>> Currently, debugfs_create_str() only supports reading strings from
>> debugfs. Add support for writing them as well.
>>
>> Based on original implementation by Peter Zijlstra [0]. Write support
>> was present in the initial patch version, but dropped in v2 due to lack
>> of users. We have a user now, so reintroduce it.
>>
>> [0] https://lore.kernel.org/all/YF3Hv5zXb%2F6lauzs@hirez.programming.kicks-ass.net/
>>
>> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
>> ---
>>   fs/debugfs/file.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
>> index b7711888dd17..87b3753aa4b1 100644
>> --- a/fs/debugfs/file.c
>> +++ b/fs/debugfs/file.c
>> @@ -904,8 +904,52 @@ EXPORT_SYMBOL_GPL(debugfs_create_str);
>>   static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
>>   				      size_t count, loff_t *ppos)
>>   {
>> -	/* This is really only for read-only strings */
>> -	return -EINVAL;
>> +	struct dentry *dentry = F_DENTRY(file);
>> +	char *old, *new = NULL;
>> +	int pos = *ppos;
>> +	int r;
>> +
>> +	r = debugfs_file_get(dentry);
>> +	if (unlikely(r))
>> +		return r;
>> +
>> +	old = *(char **)file->private_data;
>> +
>> +	/* only allow strict concatenation */
>> +	r = -EINVAL;
>> +	if (pos && pos != strlen(old))
>> +		goto error;
>> +
>> +	r = -E2BIG;
>> +	if (pos + count + 1 > PAGE_SIZE)
>> +		goto error;
>> +
>> +	r = -ENOMEM;
>> +	new = kmalloc(pos + count + 1, GFP_KERNEL);
>> +	if (!new)
>> +		goto error;
>> +
>> +	if (pos)
>> +		memcpy(new, old, pos);
>> +
>> +	r = -EFAULT;
>> +	if (copy_from_user(new + pos, user_buf, count))
>> +		goto error;
>> +
>> +	new[pos + count] = '\0';
>> +	strim(new);
>> +
>> +	rcu_assign_pointer(*(char **)file->private_data, new);
>> +	synchronize_rcu();
>> +	kfree(old);
>> +
>> +	debugfs_file_put(dentry);
>> +	return count;
>> +
>> +error:
>> +	kfree(new);
>> +	debugfs_file_put(dentry);
>> +	return r;
>>   }
> 
> So you just added write support for ALL debugfs files that use the
> string interface, what did you just allow to break?

Not true. Write support is added only for debugfs string files that are
created with +w permissions. All existing files are created as read-only
and use the fops_str_ro ops.

> I recommend just using your own debugfs file function instead, as this
> could cause bad problems, right?  Are you sure that all string calls can
> handle the variable be freed underneath it like this call will allow to
> happen?
> 
> So I wouldn't recommend doing this, sorry.
> 

Maybe you missed the fact that the different file ops are already there
and are selected based on permissions:

> static const struct file_operations fops_str = {
>         .read =         debugfs_read_file_str,
>         .write =        debugfs_write_file_str,
>         .open =         simple_open,
>         .llseek =       default_llseek,
> };
> 
> static const struct file_operations fops_str_ro = {
>         .read =         debugfs_read_file_str,
>         .open =         simple_open,
>         .llseek =       default_llseek,
> };
> 
> static const struct file_operations fops_str_wo = {
>         .write =        debugfs_write_file_str,
>         .open =         simple_open,
>         .llseek =       default_llseek,
> };

...so this patch is doing exactly what you suggested? If you agree,
could you ack it again please?

Thanks,
Georgi
