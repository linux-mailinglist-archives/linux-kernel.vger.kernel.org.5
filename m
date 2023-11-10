Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995D67E8288
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346350AbjKJTYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjKJTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:24:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708128252
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:02:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3A3C433C7;
        Fri, 10 Nov 2023 03:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699588565;
        bh=IMcSxWrdruVQfP9e7fEBYYE2MC9+wNXShHGyUH6KxwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfeFyRH08ET2E+W5qX5XYRwEVUQqsY4RUP6Ef3UW6qr7You7M4p/XZfItRT4NwYBx
         CBelaxZt0DI2YKjkU5cMpfZ3djhZORuXyXkb2xmKCeM1fwdNXYjNkiUJ3THXFsuGsc
         Wxdj6Q62sapBwk1plBuu8pjQsIaLj7lNTWyXBloU=
Date:   Fri, 10 Nov 2023 04:56:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nicolai Stange <nicstange@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
Message-ID: <2023111055-gratitude-prance-6074@gregkh>
References: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 04:06:40PM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> debugfs_create_automount() can store a function pointer in
> d_fsdata, and for directories it may be NULL. The commit
> 7c8d469877b1 ("debugfs: add support for more elaborate
> ->d_fsdata") ignored that, and while freeing NULL is just
> fine, if an automount is ever removed we'd attempt to
> kfree() the function pointer. This currently never happens
> since the only user (tracing) will never remove the
> automount dir.
> 
> Later patches changed the logic here again to store the
> real fops, and store the allocation only after a debugfs
> file reference is obtained via debugfs_file_get().
> 
> Remove debugfs_release_dentry() so we won't attempt to
> do anything common with the different uses of d_fsdata,
> and put the freeing of the allocated data where it's last
> possibly used, in __debugfs_file_removed(), which is only
> called for regular files.
> 
> Also check in debugfs_file_get() that it gets only called
> on regular files, just to make things clearer.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  fs/debugfs/file.c  |  3 +++
>  fs/debugfs/inode.c | 14 +++++---------
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index 1f971c880dde..1a20c7db8e11 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -84,6 +84,9 @@ int debugfs_file_get(struct dentry *dentry)
>  	struct debugfs_fsdata *fsd;
>  	void *d_fsd;
>  
> +	if (WARN_ON(!d_is_reg(dentry)))
> +		return -EINVAL;

Note, the huge majority of Linux systems in the world run with "panic on
warn" enabled, so if this is something that could actually happen,
please just handle it and return the error, don't throw up a WARN()
splat as that will reboot the system, causing you to have grumpy users.

thanks,

greg k-h
