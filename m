Return-Path: <linux-kernel+bounces-24890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2382C448
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D227A283740
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A591B5B0;
	Fri, 12 Jan 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT6zVPJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FE81B5A5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3ABC43390;
	Fri, 12 Jan 2024 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079340;
	bh=GDl6p3UZsPjLAqZ6riRDVB5aigv9wH3zVmTnLWIcCLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oT6zVPJ1R4hpGcq1aYlIz3BQCRh9WApN8ONK8zmQdxhnpvQ4qnEitpsH/OaFXD7Lv
	 pQYWqm+0WDhpeJreemXvrlAuK7AU4Hc4uIa4nlQpz0d9OLm0gGEjjyuSO4bLv48gNO
	 wBpO2MgUt2REUjD9v8uQbuBBLgFkt9lh8NTLS8FdPZ7WLpCskAkiT3zi21d7UqBtVn
	 JS1S7XlfxIALEhlgXbbrghvQDmBraimE2YU1/uOKIyP/EdEnD3lIBU9TDoZp54fiW3
	 BjRIr4aEZruzFNycr5wKIvzaDW8rkO23ZZAW9/S2AOwa7o5iLpehdKKUeZX6/SHQtS
	 MMuYRYDBwcCZw==
Date: Fri, 12 Jan 2024 09:08:58 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs update for 6.8-rc1
Message-ID: <ZaFyKl-iqh9J64du@google.com>
References: <ZaAzOgd3iWL0feTU@google.com>
 <CAHk-=wgTbey3-RCz8ZpmTsMhUGf02YVV068k3OzrmOvJPowXfw@mail.gmail.com>
 <20240112071242.GA1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112071242.GA1674809@ZenIV>

On 01/12, Al Viro wrote:
> On Thu, Jan 11, 2024 at 09:05:51PM -0800, Linus Torvalds wrote:
> > On Thu, 11 Jan 2024 at 10:28, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.8-rc1
> > 
> > Hmm. I got a somewhat confusing conflict in f2fs_rename().
> > 
> > And honestly, I really don't know what the right resolution is. What I
> > ended up with was this:
> > 
> >         if (old_is_dir) {
> >                 if (old_dir_entry)
> >                         f2fs_set_link(old_inode, old_dir_entry,
> >                                                 old_dir_page, new_dir);
> >                 else
> >                         f2fs_put_page(old_dir_page, 0);
> 
> Where would you end up with old_dir_page != NULL and old_dir_entry == NULL?
> old_dir_page is initialized to NULL and the only place where it's altered
> is
>                 old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
> Which is immediately followed by
>                 if (!old_dir_entry) {
>                         if (IS_ERR(old_dir_page))
>                                 err = PTR_ERR(old_dir_page);
>                         goto out_old;
>                 }
> so we are *not* going to end up at that if (old_is_dir) in that case.

It seems [1] changed the condition of getting old_dir_page reference as below,
which made f2fs_put_page(old_dir_page, 0) voided.

-       if (S_ISDIR(old_inode->i_mode)) {
+       if (old_is_dir && old_dir != new_dir) {
                old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
                if (!old_dir_entry) {
                        if (IS_ERR(old_dir_page))

[1] 7deee77b993a ("f2fs: Avoid reading renamed directory if parent does not change")

> 
> Original would have been more clear as
> 	if (old_is_dir) {
> 		if (old_dir != new_dir) {
> 			/* we have .. in old_dir_page/old_dir_entry */
> 			if (!whiteout)
> 	                        f2fs_set_link(old_inode, old_dir_entry,
>                                                 old_dir_page, new_dir);
> 			else
> 	                        f2fs_put_page(old_dir_page, 0);
> 		}
>                 f2fs_i_links_write(old_dir, false);
> 	}
> - it is equivalent to what that code used to do.  And "don't update ..
> if we are leaving a whiteout behind" was teh bug fixed by commit
> in f2fs tree...
> 
> The bottom line: your variant is not broken, but only because
> f2fs_put_page() starts with
> static inline void f2fs_put_page(struct page *page, int unlock)
> {
>         if (!page)
>                 return;
> 
> IOW, you are doing f2fs_put_page(NULL, 0), which is an explicit no-op.

