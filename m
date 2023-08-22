Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1723B78382D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 04:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjHVCv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 22:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHVCvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 22:51:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5711D;
        Mon, 21 Aug 2023 19:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A2526293D;
        Tue, 22 Aug 2023 02:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C07C433C8;
        Tue, 22 Aug 2023 02:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692672681;
        bh=TNG3BZOaJN/SnmLDM9Q93VC2ownruXoF9y+zGS4rmeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvRRrMChbl1y15zODE7kSmkmrNTpNl9PZTbPOaJlv33OshJhMlc16xb9WqNXDEZCR
         MhBmz9rsdg3cxIc9vFZlsjSU2J2adOvNBcrUvOvrosZleo0A57oC7vlf2UOs3eqAvV
         aiY3gqj5O2KzWh7dB/hwjc6NPkWHsfCIEqjKqLeqpyjg47VVmd9fSy9VBKkbSQsWzN
         cZpwkH0SlP0+MTaKt5jOEMVi/yGFmapuEMDWr6RP2rC/qXRG01EB6goVEtUS/Zsh54
         Da38utjrYKYT60HQJ7jyt29Om52cG9qAUJHzXzZYxfe5XvmcjvoB7nsWBDlR6qhQme
         Y90qdUuJMG/BQ==
Date:   Mon, 21 Aug 2023 19:51:20 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 djw-vfs tree
Message-ID: <20230822025120.GA11286@frogsfrogsfrogs>
References: <20230822110551.6386dd5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822110551.6386dd5d@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 11:05:51AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
> 
>   fs/super.c
> 
> between commits:
> 
>   880b9577855e ("fs: distinguish between user initiated freeze and kernel initiated freeze")
>   59ba4fdd2d1f ("fs: wait for partially frozen filesystems")
> 
> from the djw-vfs tree and commits:
> 
>   0ed33598ddf3 ("super: use locking helpers")
>   5e8749141521 ("super: wait for nascent superblocks")
> 
> from the vfs-brauner tree.
> 
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

That looks correct, thank you.

Christian: I've been planning to merge the {freeze,thaw}_super @who
changes for 6.6; do you think more 'cooperating with the maintainer' is
needed, or shall I simply push my branch to Linus with a note that
s/down_write/super_lock_excl/ s/up_write/super_unlock_excl is needed to
resolve the merge the conflict?

--D

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc fs/super.c
> index da68584815e4,a00e9f706f0f..000000000000
> --- a/fs/super.c
> +++ b/fs/super.c
> @@@ -1027,12 -1196,13 +1196,13 @@@ void emergency_remount(void
>   
>   static void do_thaw_all_callback(struct super_block *sb)
>   {
> - 	down_write(&sb->s_umount);
> - 	if (sb->s_root && sb->s_flags & SB_BORN) {
> + 	bool born = super_lock_excl(sb);
> + 
> + 	if (born && sb->s_root) {
>   		emergency_thaw_bdev(sb);
>  -		thaw_super_locked(sb);
>  +		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
>   	} else {
> - 		up_write(&sb->s_umount);
> + 		super_unlock_excl(sb);
>   	}
>   }
>   
> @@@ -1644,24 -1836,6 +1836,24 @@@ static void sb_freeze_unlock(struct sup
>   		percpu_up_write(sb->s_writers.rw_sem + level);
>   }
>   
>  +static int wait_for_partially_frozen(struct super_block *sb)
>  +{
>  +	int ret = 0;
>  +
>  +	do {
>  +		unsigned short old = sb->s_writers.frozen;
>  +
> - 		up_write(&sb->s_umount);
> ++		super_unlock_excl(sb);
>  +		ret = wait_var_event_killable(&sb->s_writers.frozen,
>  +					       sb->s_writers.frozen != old);
> - 		down_write(&sb->s_umount);
> ++		__super_lock_excl(sb);
>  +	} while (ret == 0 &&
>  +		 sb->s_writers.frozen != SB_UNFROZEN &&
>  +		 sb->s_writers.frozen != SB_FREEZE_COMPLETE);
>  +
>  +	return ret;
>  +}
>  +
>   /**
>    * freeze_super - lock the filesystem and force it into a consistent state
>    * @sb: the super to lock
> @@@ -1711,34 -1874,10 +1903,34 @@@ int freeze_super(struct super_block *sb
>   	int ret;
>   
>   	atomic_inc(&sb->s_active);
> - 	down_write(&sb->s_umount);
> + 	__super_lock_excl(sb);
>  +
>  +retry:
>  +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
>  +		if (sb->s_writers.freeze_holders & who) {
>  +			deactivate_locked_super(sb);
>  +			return -EBUSY;
>  +		}
>  +
>  +		WARN_ON(sb->s_writers.freeze_holders == 0);
>  +
>  +		/*
>  +		 * Someone else already holds this type of freeze; share the
>  +		 * freeze and assign the active ref to the freeze.
>  +		 */
>  +		sb->s_writers.freeze_holders |= who;
> - 		up_write(&sb->s_umount);
> ++		super_unlock_excl(sb);
>  +		return 0;
>  +	}
>  +
>   	if (sb->s_writers.frozen != SB_UNFROZEN) {
>  -		deactivate_locked_super(sb);
>  -		return -EBUSY;
>  +		ret = wait_for_partially_frozen(sb);
>  +		if (ret) {
>  +			deactivate_locked_super(sb);
>  +			return ret;
>  +		}
>  +
>  +		goto retry;
>   	}
>   
>   	if (!(sb->s_flags & SB_BORN)) {
> @@@ -1748,10 -1887,8 +1940,10 @@@
>   
>   	if (sb_rdonly(sb)) {
>   		/* Nothing to do really... */
>  +		sb->s_writers.freeze_holders |= who;
>   		sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  +		wake_up_var(&sb->s_writers.frozen);
> - 		up_write(&sb->s_umount);
> + 		super_unlock_excl(sb);
>   		return 0;
>   	}
>   
> @@@ -1795,11 -1930,9 +1987,11 @@@
>   	 * For debugging purposes so that fs can warn if it sees write activity
>   	 * when frozen is set to SB_FREEZE_COMPLETE, and for thaw_super().
>   	 */
>  +	sb->s_writers.freeze_holders |= who;
>   	sb->s_writers.frozen = SB_FREEZE_COMPLETE;
>  +	wake_up_var(&sb->s_writers.frozen);
>   	lockdep_sb_freeze_release(sb);
> - 	up_write(&sb->s_umount);
> + 	super_unlock_excl(sb);
>   	return 0;
>   }
>   EXPORT_SYMBOL(freeze_super);
> @@@ -1814,24 -1941,8 +2006,24 @@@ static int thaw_super_locked(struct sup
>   {
>   	int error;
>   
>  -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
>  +	if (sb->s_writers.frozen == SB_FREEZE_COMPLETE) {
>  +		if (!(sb->s_writers.freeze_holders & who)) {
> - 			up_write(&sb->s_umount);
> ++			super_unlock_excl(sb);
>  +			return -EINVAL;
>  +		}
>  +
>  +		/*
>  +		 * Freeze is shared with someone else.  Release our hold and
>  +		 * drop the active ref that freeze_super assigned to the
>  +		 * freezer.
>  +		 */
>  +		if (sb->s_writers.freeze_holders & ~who) {
>  +			sb->s_writers.freeze_holders &= ~who;
>  +			deactivate_locked_super(sb);
>  +			return 0;
>  +		}
>  +	} else {
> - 		up_write(&sb->s_umount);
> + 		super_unlock_excl(sb);
>   		return -EINVAL;
>   	}
>   
> @@@ -1867,19 -1974,13 +2059,19 @@@ out
>   /**
>    * thaw_super -- unlock filesystem
>    * @sb: the super to thaw
>  + * @who: context that wants to freeze
>    *
>  - * Unlocks the filesystem and marks it writeable again after freeze_super().
>  + * Unlocks the filesystem and marks it writeable again after freeze_super()
>  + * if there are no remaining freezes on the filesystem.
>  + *
>  + * @who should be:
>  + * * %FREEZE_HOLDER_USERSPACE if userspace wants to thaw the fs;
>  + * * %FREEZE_HOLDER_KERNEL if the kernel wants to thaw the fs.
>    */
>  -int thaw_super(struct super_block *sb)
>  +int thaw_super(struct super_block *sb, enum freeze_holder who)
>   {
> - 	down_write(&sb->s_umount);
> + 	__super_lock_excl(sb);
>  -	return thaw_super_locked(sb);
>  +	return thaw_super_locked(sb, who);
>   }
>   EXPORT_SYMBOL(thaw_super);
>   


