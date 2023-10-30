Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B894E7DB803
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjJ3KZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjJ3KZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:25:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C81996
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:25:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A40C433C9;
        Mon, 30 Oct 2023 10:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698661501;
        bh=HwZC9pP22kn0OW2U98JRm5leuqIjcFYJqSB6SiV2Igo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMQoW8NTpxWDJGXQJQUyW78lIpBQ7gAE0+SzCObomFGyGRsggebsZMp8JkGKRtTbT
         2Wb++X6JGoGFycht3sxazi53zoDfSN8j8yNlrIYVhS2+jCaBQdmkNKxucl0/Xz5Ija
         g+W4kzcozgxzag64nxmFIhoO0NeOCQkjmxII85cj1u3wIzZwA3nWHccuAMMqaKCAxc
         5FLDoX0vi15Ot4EjT5fwFAaR1uuGNsIdjxKHbqfP3TYftwgEOgC4LIj/xf3L65z9aN
         MbyzOSwJl9cfXPKSSid7UaeE+L/k4gCtiZUjPA2Il6rNMZwLCocMesmWhsqoDwhgZn
         1ZZtTnI7WwEnQ==
Date:   Mon, 30 Oct 2023 11:24:57 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill O'Donnell <bodonnel@redhat.com>
Subject: Re: [GIT PULL for v6.7] autofs updates
Message-ID: <20231030-imponieren-tierzucht-1d1ef70bce3f@brauner>
References: <20231027-vfs-autofs-018bbf11ed67@brauner>
 <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43ea4439-8cb9-8b0d-5e04-3bd5e85530f4@themaw.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 03:54:52PM +0800, Ian Kent wrote:
> On 27/10/23 22:33, Christian Brauner wrote:
> > Hey Linus,
> > 
> > /* Summary */
> > This ports autofs to the new mount api. The patchset has existed for
> > quite a while but never made it upstream. Ian picked it back up.
> > 
> > This also fixes a bug where fs_param_is_fd() was passed a garbage
> > param->dirfd but it expected it to be set to the fd that was used to set
> > param->file otherwise result->uint_32 contains nonsense. So make sure
> > it's set.
> > 
> > One less filesystem using the old mount api. We're getting there, albeit
> > rather slow. The last remaining major filesystem that hasn't converted
> > is btrfs. Patches exist - I even wrote them - but so far they haven't
> > made it upstream.
> 
> Yes, looks like about 39 still to be converted.
> 
> 
> Just for information, excluding btrfs, what would you like to see as the
> 
> priority for conversion (in case me or any of my colleagues get a chance
> 
> to spend a bit more time on it)?

I think one way to prioritize them is by how likely they are to have
(more than a couple) active users.

So recently I've done overlayfs because aside from btrfs that was
probably one of the really actively used filesystems that hadn't yet
been converted. And that did surface some regression

So 9p, fat, devpts, f2fs, zonefs, ext2 are pretty obvious targets.
Judging from experience, the more mount options a filesystem has the
bigger the conversion patch will usually be.

Another way is by function. For example, we expose mount_bdev() which is
basically the legacy version of get_tree_bdev(). And they sort of are
almost copies of each other. So converting all callers to the new mount
api means we can get rid of mount_bdev(). But that's like 25 of the
remaining 39.

But in the end any filesystem that is converted is great.
