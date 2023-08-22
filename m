Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518237848A3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHVRqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHVRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:46:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC989213E;
        Tue, 22 Aug 2023 10:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6820F6234E;
        Tue, 22 Aug 2023 17:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA9CC433CA;
        Tue, 22 Aug 2023 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692726384;
        bh=+AEJDgQND+MTKWXpZoLOxttSEcb4AQ/a1ssvaTQGP4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJtg7BRliVQUq3lHWyuW+tkwc73Eb8qIWb4ZhDElf0goLMWuSuH0/Pb63EJtmb2Zr
         M8q5eh7a2Rs1nC9ACTvEUt2Et/eGlntqsRIwz51kUAqp5OeDoYICMStpoYuflhRN8Z
         CwzEl8o/nQXt6OwXEaDDHnYatmVsAqv++nrZtLlw=
Date:   Tue, 22 Aug 2023 19:46:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Mike Tipton <quic_mdtipton@quicinc.com>, rafael@kernel.org,
        corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_okukatla@quicinc.com,
        quic_viveka@quicinc.com, peterz@infradead.org,
        quic_pkondeti@quicinc.com
Subject: Re: [PATCH v3 1/3] debugfs: Add write support to debugfs_create_str()
Message-ID: <2023082242-udder-refinish-1f6e@gregkh>
References: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
 <20230807142914.12480-2-quic_mdtipton@quicinc.com>
 <2023081203-happier-mutable-e4f0@gregkh>
 <44a63cb2-1ae5-f52b-19d2-fe03d48fd44d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44a63cb2-1ae5-f52b-19d2-fe03d48fd44d@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 01:05:57PM +0300, Georgi Djakov wrote:
> Hi Greg,
> 
> On 12.08.23 13:40, Greg KH wrote:
> > On Mon, Aug 07, 2023 at 07:29:12AM -0700, Mike Tipton wrote:
> > > Currently, debugfs_create_str() only supports reading strings from
> > > debugfs. Add support for writing them as well.
> > > 
> > > Based on original implementation by Peter Zijlstra [0]. Write support
> > > was present in the initial patch version, but dropped in v2 due to lack
> > > of users. We have a user now, so reintroduce it.
> > > 
> > > [0] https://lore.kernel.org/all/YF3Hv5zXb%2F6lauzs@hirez.programming.kicks-ass.net/
> > > 
> > > Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> > > ---
> > >   fs/debugfs/file.c | 48 +++++++++++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 46 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > index b7711888dd17..87b3753aa4b1 100644
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -904,8 +904,52 @@ EXPORT_SYMBOL_GPL(debugfs_create_str);
> > >   static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
> > >   				      size_t count, loff_t *ppos)
> > >   {
> > > -	/* This is really only for read-only strings */
> > > -	return -EINVAL;
> > > +	struct dentry *dentry = F_DENTRY(file);
> > > +	char *old, *new = NULL;
> > > +	int pos = *ppos;
> > > +	int r;
> > > +
> > > +	r = debugfs_file_get(dentry);
> > > +	if (unlikely(r))
> > > +		return r;
> > > +
> > > +	old = *(char **)file->private_data;
> > > +
> > > +	/* only allow strict concatenation */
> > > +	r = -EINVAL;
> > > +	if (pos && pos != strlen(old))
> > > +		goto error;
> > > +
> > > +	r = -E2BIG;
> > > +	if (pos + count + 1 > PAGE_SIZE)
> > > +		goto error;
> > > +
> > > +	r = -ENOMEM;
> > > +	new = kmalloc(pos + count + 1, GFP_KERNEL);
> > > +	if (!new)
> > > +		goto error;
> > > +
> > > +	if (pos)
> > > +		memcpy(new, old, pos);
> > > +
> > > +	r = -EFAULT;
> > > +	if (copy_from_user(new + pos, user_buf, count))
> > > +		goto error;
> > > +
> > > +	new[pos + count] = '\0';
> > > +	strim(new);
> > > +
> > > +	rcu_assign_pointer(*(char **)file->private_data, new);
> > > +	synchronize_rcu();
> > > +	kfree(old);
> > > +
> > > +	debugfs_file_put(dentry);
> > > +	return count;
> > > +
> > > +error:
> > > +	kfree(new);
> > > +	debugfs_file_put(dentry);
> > > +	return r;
> > >   }
> > 
> > So you just added write support for ALL debugfs files that use the
> > string interface, what did you just allow to break?
> 
> Not true. Write support is added only for debugfs string files that are
> created with +w permissions. All existing files are created as read-only
> and use the fops_str_ro ops.
> 
> > I recommend just using your own debugfs file function instead, as this
> > could cause bad problems, right?  Are you sure that all string calls can
> > handle the variable be freed underneath it like this call will allow to
> > happen?
> > 
> > So I wouldn't recommend doing this, sorry.
> > 
> 
> Maybe you missed the fact that the different file ops are already there
> and are selected based on permissions:
> 
> > static const struct file_operations fops_str = {
> >         .read =         debugfs_read_file_str,
> >         .write =        debugfs_write_file_str,
> >         .open =         simple_open,
> >         .llseek =       default_llseek,
> > };
> > 
> > static const struct file_operations fops_str_ro = {
> >         .read =         debugfs_read_file_str,
> >         .open =         simple_open,
> >         .llseek =       default_llseek,
> > };
> > 
> > static const struct file_operations fops_str_wo = {
> >         .write =        debugfs_write_file_str,
> >         .open =         simple_open,
> >         .llseek =       default_llseek,
> > };
> 
> ...so this patch is doing exactly what you suggested? If you agree,
> could you ack it again please?

Yes, I did miss that, sorry, my appologies for dragging this out so
long:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
