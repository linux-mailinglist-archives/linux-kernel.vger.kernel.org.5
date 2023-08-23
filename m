Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA84784FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjHWEoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWEoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:44:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F070CF1;
        Tue, 22 Aug 2023 21:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B61816247A;
        Wed, 23 Aug 2023 04:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AEEC433C7;
        Wed, 23 Aug 2023 04:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692765850;
        bh=8CvW6+DHMGM4jQjRh+e/lZ0vGVC2YWC3ofmoFroiV2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQJFP7Yp44oYzLYP7EdQK8/1jdmC4EIXUPFOvyeV+cGAzcFYrAhqgETQcWBaC60/o
         I7ks6bbKu7LZqT2+r4n+I1bII/acwq17Mo/DiySag5nvEo7ty/DmM+5cgY0jZBh+2L
         HoeBs7BuvZWrKvVChDe28Km75yQBX4Xa1T2602E6YlBBKGWGZTc5X5JGmOlBT1dEz4
         FMRM8j4phsQV6GiCQcbJSQaQ4xCRov5nD0itVpSb84HlmMLnuzO57G40/dUiCl+7Jr
         PfvBeBhxwWNfnRDVsjAq1VbAJRZeraDnbUrIn7yLrtBhFH7Fk0mliw4XhA7oH+mQlr
         uVcvUziugOSzQ==
Date:   Tue, 22 Aug 2023 21:44:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the xfs
 tree
Message-ID: <20230823044409.GF11286@frogsfrogsfrogs>
References: <20230823093852.7bf03b7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823093852.7bf03b7e@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:38:52AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
> 
>   fs/xfs/xfs_super.c
> 
> between commit:
> 
>   a76dba3b248c ("xfs: create scaffolding for creating debugfs entries")
> 
> from the xfs tree and commit:
> 
>   35a93b148b03 ("xfs: close the external block devices in xfs_mount_free")
> 
> from the vfs-brauner tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/xfs/xfs_super.c
> index 09638e8fb4ee,c79eac048456..000000000000
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@@ -760,7 -772,17 +774,18 @@@ static voi
>   xfs_mount_free(
>   	struct xfs_mount	*mp)
>   {
> + 	/*
> + 	 * Free the buftargs here because blkdev_put needs to be called outside
> + 	 * of sb->s_umount, which is held around the call to ->put_super.
> + 	 */
> + 	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
> + 		xfs_free_buftarg(mp->m_logdev_targp);
> + 	if (mp->m_rtdev_targp)
> + 		xfs_free_buftarg(mp->m_rtdev_targp);
> + 	if (mp->m_ddev_targp)
> + 		xfs_free_buftarg(mp->m_ddev_targp);
> + 
>  +	debugfs_remove(mp->m_debugfs);
>   	kfree(mp->m_rtname);
>   	kfree(mp->m_logname);
>   	kmem_free(mp);
> @@@ -1538,18 -1537,11 +1556,18 @@@ xfs_fs_fill_super
>   
>   	error = xfs_open_devices(mp);
>   	if (error)
> - 		goto out_free_names;
> + 		return error;
>   
>  +	if (xfs_debugfs) {
>  +		mp->m_debugfs = xfs_debugfs_mkdir(mp->m_super->s_id,
>  +						  xfs_debugfs);
>  +	} else {
>  +		mp->m_debugfs = NULL;
>  +	}
>  +

Yep, this looks correct.

--D

>   	error = xfs_init_mount_workqueues(mp);
>   	if (error)
> - 		goto out_close_devices;
> + 		goto out_shutdown_devices;
>   
>   	error = xfs_init_percpu_counters(mp);
>   	if (error)


