Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6854F784FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjHWEqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHWEq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EE5CF1;
        Tue, 22 Aug 2023 21:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC83617C5;
        Wed, 23 Aug 2023 04:46:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A54C433C8;
        Wed, 23 Aug 2023 04:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692765986;
        bh=ZAS+Zle6kFj+lIQtoOw17wUR9w24uTrKVt7ERrEduKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A91UIGoFcWwn3mB7g+M/Ygp+ujkP55hkUkaRZ8DbZz3dAJfSqsgj9dZz3Zr8OU4fg
         M64muu8wqbk/JCFYbcjG40fbNVAvnWiDQYH9Ik6uja+DgLdkhRqJzCxqLzmNV5SKGC
         lejiT+YyGMn7MI+6C1YFPlYGU8l8RqoKuczwYbPflMRrsHiHJ0tDZ3G/9L3L/ePFtc
         kKSTHAsvpcszCR1VVkG3nzNc7/nT4k2Ncy9y56XR5V0qK/VJ7VZABk3aay/DSRtIGR
         OOUfTz6cOOrKS3qNyGEUivQraHS8OQWQDkZ/nswNsxX2DH+rZBe6Ucmaa9Dp5bREia
         tlPJ2kSbbPmXw==
Date:   Tue, 22 Aug 2023 21:46:26 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the djw-vfs tree with the xfs tree
Message-ID: <20230823044626.GG11286@frogsfrogsfrogs>
References: <20230823093347.775f3857@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823093347.775f3857@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 09:33:47AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the djw-vfs tree got a conflict in:
> 
>   fs/xfs/scrub/scrub.c
> 
> between commit:
> 
>   526aab5f5790 ("xfs: implement online scrubbing of rtsummary info")
> 
> from the xfs tree and commit:
> 
>   ce85a1e04645 ("xfs: stabilize fs summary counters for online fsck")
> 
> from the djw-vfs tree.
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
> diff --cc fs/xfs/scrub/scrub.c
> index e92129d74462,a0fffbcd022b..000000000000
> --- a/fs/xfs/scrub/scrub.c
> +++ b/fs/xfs/scrub/scrub.c
> @@@ -178,16 -178,16 +178,18 @@@ xchk_teardown
>   	}
>   	if (sc->ip) {
>   		if (sc->ilock_flags)
>  -			xfs_iunlock(sc->ip, sc->ilock_flags);
>  -		if (sc->ip != ip_in &&
>  -		    !xfs_internal_inum(sc->mp, sc->ip->i_ino))
>  -			xchk_irele(sc, sc->ip);
>  +			xchk_iunlock(sc, sc->ilock_flags);
>  +		xchk_irele(sc, sc->ip);
>   		sc->ip = NULL;
>   	}
> - 	if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
> + 	if (sc->flags & XCHK_HAVE_FREEZE_PROT) {
> + 		sc->flags &= ~XCHK_HAVE_FREEZE_PROT;
>   		mnt_drop_write_file(sc->file);
> + 	}

Yep, I changed the mnt_drop_write_file conditional to be an explicit
flag instead of implied by the XFS_SCRUB_IFLAG_REPAIR coming from
userspace.  You've correctly resolved both conflicts, thank you.

(And apologies for things being way messier than is traditional.)

--D

>  +	if (sc->xfile) {
>  +		xfile_destroy(sc->xfile);
>  +		sc->xfile = NULL;
>  +	}
>   	if (sc->buf) {
>   		if (sc->buf_cleanup)
>   			sc->buf_cleanup(sc->buf);


