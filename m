Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E87B7FD530
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjK2LM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjK2LMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:12:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37053270;
        Wed, 29 Nov 2023 03:09:32 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AE1501F8B3;
        Wed, 29 Nov 2023 11:09:30 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A36581376F;
        Wed, 29 Nov 2023 11:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id RTDeJ+obZ2VXcQAAn2gu4w
        (envelope-from <jack@suse.cz>); Wed, 29 Nov 2023 11:09:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 51515A07DC; Wed, 29 Nov 2023 12:09:30 +0100 (CET)
Date:   Wed, 29 Nov 2023 12:09:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231129110930.qncvzm63xjg4ucky@quack3>
References: <20231127092001.54a021e8@canb.auug.org.au>
 <20231128213344.GA3423530@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128213344.GA3423530@dev-arch.thelio-3990X>
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Queue-Id: AE1501F8B3
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 14:33:44, Nathan Chancellor wrote:
> Hi Stephen (and other maintainers),
> 
> On Mon, Nov 27, 2023 at 09:20:01AM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> > 
> >   fs/btrfs/super.c
> > 
> > between commit:
> > 
> >   2f2cfead5107 ("btrfs: remove old mount API code")
> > 
> > from the btrfs tree and commit:
> > 
> >   ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> > 
> > from the vfs-brauner tree.
> > 
> > I fixed it up (the former removed the funtion updated by the latter, but
> > a further fix may be required to implement the intent of the latter?)
> 
> Yes, the lack of ead622674df5 appears to cause issues with mounting
> btrfs volumes on at least next-20231128 due to the presence of commit
> 6f861765464f ("fs: Block writes to mounted block devices"). In QEMU, I
> can see:
> 
>   :: running early hook [udev]
>   Warning: /lib/modules/6.7.0-rc3-next-20231128/modules.devname not found - ignoring
>   Starting systemd-udevd version 252.5-1-arch
>   :: running hook [udev]
>   :: Triggering uevents...
>   :: running hook [keymap]
>   :: Loading keymap...kbd_mode: KDSKBMODE: Inappropriate ioctl for device
>   done.
>   :: performing fsck on '/dev/vda2'
>   :: mounting '/dev/vda2' on real root
>   mount: /new_root: wrong fs type, bad option, bad superblock on /dev/vda2, missing codepage or helper program, or other error.
>          dmesg(1) may have more information after failed mount system call.
>   You are now being dropped into an emergency shell.
>   sh: can't access tty; job control turned off
>   [rootfs ]#
> 
> The following diff allows my VM to boot properly but I am not sure if
> there is a better or more proper fix (I am already out of my element
> heh). If a proper merge solution cannot be found quickly, can
> 6f861765464f be reverted in the meantime so that all my machines with
> btrfs can boot properly? :)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 99d10a25a579..23db0306b8ef 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -299,6 +299,7 @@ static int btrfs_parse_param(struct fs_context *fc,
>  	case Opt_device: {
>  		struct btrfs_device *device;
>  		blk_mode_t mode = sb_open_mode(fc->sb_flags);
> +		mode &= ~BLK_OPEN_RESTRICT_WRITES;
>  
>  		mutex_lock(&uuid_mutex);
>  		device = btrfs_scan_one_device(param->string, mode, false);
> @@ -1801,6 +1802,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>  	blk_mode_t mode = sb_open_mode(fc->sb_flags);
>  	int ret;
>  
> +	mode &= ~BLK_OPEN_RESTRICT_WRITES;
> +
>  	btrfs_ctx_to_info(fs_info, ctx);
>  	mutex_lock(&uuid_mutex);

This looks like the proper resolution. Basically btrfs needs to strip
BLK_OPEN_RESTRICT_WRITES from the mode provided by sb_open_mode(). Thanks
for writing it!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
