Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8A807FED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjLGFDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjLGFDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:03:52 -0500
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A1D5C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:03:58 -0800 (PST)
Date:   Thu, 7 Dec 2023 00:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701925436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+VAtdw+VBXAf4egJulQBl5F+jTniBZVDEdNWU+PevM=;
        b=jbA7IPByemD/cql2BiX6j7iBa9QLHJMtHJVuGstf9MSlWE9JOEjKXyhrh7iLfZfKFgS3LZ
        mfLfdxAOUw7H5nxtn4jTY/0cJJ93iah32/r7tTObyMpuDY3DgEIj4tv9duHXd5joiAaGUZ
        /R990PcU4rYx83ds2Q+QUu0pq3QZQhI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-cachefs@redhat.com,
        dhowells@redhat.com, gfs2@lists.linux.dev,
        dm-devel@lists.linux.dev, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 03/11] vfs: Use dlock list for superblock's inode list
Message-ID: <20231207050351.gg74kg6jumik36gs@moria.home.lan>
References: <20231206060629.2827226-1-david@fromorbit.com>
 <20231206060629.2827226-4-david@fromorbit.com>
 <20231207024024.GU1674809@ZenIV>
 <ZXFRHo3mcbKfoC8v@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXFRHo3mcbKfoC8v@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 03:59:10PM +1100, Dave Chinner wrote:
> On Thu, Dec 07, 2023 at 02:40:24AM +0000, Al Viro wrote:
> > On Wed, Dec 06, 2023 at 05:05:32PM +1100, Dave Chinner wrote:
> > 
> > > @@ -303,6 +303,7 @@ static void destroy_unused_super(struct super_block *s)
> > >  	super_unlock_excl(s);
> > >  	list_lru_destroy(&s->s_dentry_lru);
> > >  	list_lru_destroy(&s->s_inode_lru);
> > > +	free_dlock_list_heads(&s->s_inodes);
> > >  	security_sb_free(s);
> > >  	put_user_ns(s->s_user_ns);
> > >  	kfree(s->s_subtype);
> > 
> > Umm...  Who's going to do that on normal umount?
> 
> Huh. So neither KASAN nor kmemleak has told me that s->s-inodes was
> being leaked.  I'm guessing a rebase sometime in the past silently
> dropped a critical hunk from deactivate_locked_super() in the bit
> bucket, but as nothing since whenever that happened has failed or
> flagged a memory leak I didn't notice.
> 
> Such great tools we have......

kmemleak has always seemed flakey to me (as one would expect, it's
difficult code to test). If we can ever get memory allocation profiling
merged - it won't be a direct replacement but it'll be more reliable.
