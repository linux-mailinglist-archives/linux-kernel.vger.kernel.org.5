Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89DD7FC8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjK1Vdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Vdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:33:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214B2CC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:33:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E63C433C7;
        Tue, 28 Nov 2023 21:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701207226;
        bh=0y0x3HeNVaPz4M/ZlU2XszvPzKuo0CxoGX3FIFfMi8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBQZ66AmVpr8uvTcU1bD28+iYbg3ktmiGd87sNJMM9JdcHsAYoyYr2iXJ+LuKFH/0
         wyWSfEL0qR3h/Jhuub4iMGXY07SHCVUCdW4B1wLkkv6FdAbvd1Ocl08eWIur6Ua2CZ
         5xLZlTByC6iCTVgGdFVElS3zDx+Dm3u5Z3SfWQiY4OhPz+I+M11Fn5fbIpLVm4wzEn
         nvg2IY8KCEO+IG0ON9JNergQfb5kpcC9WP3D8Ht356FFI5xKhjt5H/RceXuyN/j59t
         nUh2WLBmjXlw1pJNJHKPG4GhIDp+Vi3lzxy+/0UzY8HYVIxaR9wWlXFYcHcvvi/BiO
         tv8+IP0l/60Og==
Date:   Tue, 28 Nov 2023 14:33:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        David Sterba <dsterba@suse.com>, Jan Kara <jack@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the btrfs
 tree
Message-ID: <20231128213344.GA3423530@dev-arch.thelio-3990X>
References: <20231127092001.54a021e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127092001.54a021e8@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen (and other maintainers),

On Mon, Nov 27, 2023 at 09:20:01AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
> 
>   fs/btrfs/super.c
> 
> between commit:
> 
>   2f2cfead5107 ("btrfs: remove old mount API code")
> 
> from the btrfs tree and commit:
> 
>   ead622674df5 ("btrfs: Do not restrict writes to btrfs devices")
> 
> from the vfs-brauner tree.
> 
> I fixed it up (the former removed the funtion updated by the latter, but
> a further fix may be required to implement the intent of the latter?)

Yes, the lack of ead622674df5 appears to cause issues with mounting
btrfs volumes on at least next-20231128 due to the presence of commit
6f861765464f ("fs: Block writes to mounted block devices"). In QEMU, I
can see:

  :: running early hook [udev]
  Warning: /lib/modules/6.7.0-rc3-next-20231128/modules.devname not found - ignoring
  Starting systemd-udevd version 252.5-1-arch
  :: running hook [udev]
  :: Triggering uevents...
  :: running hook [keymap]
  :: Loading keymap...kbd_mode: KDSKBMODE: Inappropriate ioctl for device
  done.
  :: performing fsck on '/dev/vda2'
  :: mounting '/dev/vda2' on real root
  mount: /new_root: wrong fs type, bad option, bad superblock on /dev/vda2, missing codepage or helper program, or other error.
         dmesg(1) may have more information after failed mount system call.
  You are now being dropped into an emergency shell.
  sh: can't access tty; job control turned off
  [rootfs ]#

The following diff allows my VM to boot properly but I am not sure if
there is a better or more proper fix (I am already out of my element
heh). If a proper merge solution cannot be found quickly, can
6f861765464f be reverted in the meantime so that all my machines with
btrfs can boot properly? :)

Cheers,
Nathan

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 99d10a25a579..23db0306b8ef 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -299,6 +299,7 @@ static int btrfs_parse_param(struct fs_context *fc,
 	case Opt_device: {
 		struct btrfs_device *device;
 		blk_mode_t mode = sb_open_mode(fc->sb_flags);
+		mode &= ~BLK_OPEN_RESTRICT_WRITES;
 
 		mutex_lock(&uuid_mutex);
 		device = btrfs_scan_one_device(param->string, mode, false);
@@ -1801,6 +1802,8 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	blk_mode_t mode = sb_open_mode(fc->sb_flags);
 	int ret;
 
+	mode &= ~BLK_OPEN_RESTRICT_WRITES;
+
 	btrfs_ctx_to_info(fs_info, ctx);
 	mutex_lock(&uuid_mutex);
 
