Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3395D77A021
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjHLNZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 09:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHLNZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 09:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C312D;
        Sat, 12 Aug 2023 06:25:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A515616C0;
        Sat, 12 Aug 2023 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5EEC433C8;
        Sat, 12 Aug 2023 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691846726;
        bh=acH4iXVTyH8arS/ZaHuARQxhgHeP/BeIYrb55TADdkU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jAiS+JBekZTpk11e3gPdsoJbBUwLcAk1BW7fhTrlvoEpXh1oHTasqLgyWGfcZPSzz
         4/ibQ9r78l0t5JL+dg6qjHC3AzfI/Md+HLbZVAkEyHIn8MKPtfdb+DLqIIZwr30hZp
         cG+easCVHSQevriIlAyaxuy5/S3A/ww2WWJ5593CgthT3siQLb3Cxz+xPzaUwXZ1Fo
         brm+K7/WXhcp2THjIIXfHj5b8Q4mtzIe1ae67QJ5gbUppBdUYakj8BHhkoAlDo51s1
         buIH8ZeLnl+FPQe+VWTCEKaRx5fKCspy1uALEsuSEImjrjNAeJ9UiYUgJnW9Tu8RTp
         f28LAOd2evR2w==
Message-ID: <7c045f1e-4d20-b798-bd74-8e8b9d8ea7e6@kernel.org>
Date:   Sat, 12 Aug 2023 16:25:21 +0300
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

Thanks for the comments!

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

Not really. According to the existing code, the write support for strings
is enabled only when the file is created with +w permissions. For read-only
files, we use fops_str_ro, which is the case for all existing string files:

$ git grep -w debugfs_create_str | egrep -v "fs/debugfs/file.c|include/linux/debugfs.h"
drivers/firmware/arm_scmi/driver.c:	debugfs_create_str("instance_name", 0400, top_dentry,
drivers/firmware/arm_scmi/driver.c:	debugfs_create_str("type", 0400, trans, (char **)&dbg->type);
drivers/opp/debugfs.c:	debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);

For fops_str_ro, the .write function is not implemented, so nothing should break?

> I recommend just using your own debugfs file function instead, as this
> could cause bad problems, right?

Agree, and that should be exactly what this patch does.

> Are you sure that all string calls can
> handle the variable be freed underneath it like this call will allow to
> happen?

Looks fine, at least for this patch-set.

Thanks,
Georgi
