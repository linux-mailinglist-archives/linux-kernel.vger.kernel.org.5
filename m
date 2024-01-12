Return-Path: <linux-kernel+bounces-24358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87B482BB80
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD821C236F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ECB5D725;
	Fri, 12 Jan 2024 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W2B/Y4R4"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB45C900
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VCEqIivkHRIrYsw4MOEaXLZlutGhQyNEOuISiki+wOM=; b=W2B/Y4R4AIGJarjY9sQq+lbTg7
	pqy5MthOXo0dJ1LTA4vrqeusN7lE70iX9dKDy5UTb7u31UkcQdzjpV+NIv19GbcENjkjQpsnDGu/K
	NVnI0M1bSS8WMMwupiu+VZapWMag7LrIehc0IWqTDeMev0+JreCdd/uJR0kSAyvRZaZ3+QeJjvLVG
	6AF1r5uLxS6AdEbaMEsfnLiAJcICBjI0FkhpmIIChPCLRlgMVEE0/cUz6S23h1rwv+93cS4tdTYZQ
	Y0KFmHsbeNZQ3eTcDXGCPLBLMNNebOc1OELp4DwVB6bMnw8CY5Lfd4VqhuZiSdiyGQZFLd2oeYL1w
	6Imo4YMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rOBic-00E5Wm-1r;
	Fri, 12 Jan 2024 07:12:42 +0000
Date: Fri, 12 Jan 2024 07:12:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [GIT PULL] f2fs update for 6.8-rc1
Message-ID: <20240112071242.GA1674809@ZenIV>
References: <ZaAzOgd3iWL0feTU@google.com>
 <CAHk-=wgTbey3-RCz8ZpmTsMhUGf02YVV068k3OzrmOvJPowXfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgTbey3-RCz8ZpmTsMhUGf02YVV068k3OzrmOvJPowXfw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 11, 2024 at 09:05:51PM -0800, Linus Torvalds wrote:
> On Thu, 11 Jan 2024 at 10:28, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.8-rc1
> 
> Hmm. I got a somewhat confusing conflict in f2fs_rename().
> 
> And honestly, I really don't know what the right resolution is. What I
> ended up with was this:
> 
>         if (old_is_dir) {
>                 if (old_dir_entry)
>                         f2fs_set_link(old_inode, old_dir_entry,
>                                                 old_dir_page, new_dir);
>                 else
>                         f2fs_put_page(old_dir_page, 0);

Where would you end up with old_dir_page != NULL and old_dir_entry == NULL?
old_dir_page is initialized to NULL and the only place where it's altered
is
                old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
Which is immediately followed by
                if (!old_dir_entry) {
                        if (IS_ERR(old_dir_page))
                                err = PTR_ERR(old_dir_page);
                        goto out_old;
                }
so we are *not* going to end up at that if (old_is_dir) in that case.

Original would have been more clear as
	if (old_is_dir) {
		if (old_dir != new_dir) {
			/* we have .. in old_dir_page/old_dir_entry */
			if (!whiteout)
	                        f2fs_set_link(old_inode, old_dir_entry,
                                                old_dir_page, new_dir);
			else
	                        f2fs_put_page(old_dir_page, 0);
		}
                f2fs_i_links_write(old_dir, false);
	}
- it is equivalent to what that code used to do.  And "don't update ..
if we are leaving a whiteout behind" was teh bug fixed by commit
in f2fs tree...

The bottom line: your variant is not broken, but only because
f2fs_put_page() starts with
static inline void f2fs_put_page(struct page *page, int unlock)
{
        if (!page)
                return;

IOW, you are doing f2fs_put_page(NULL, 0), which is an explicit no-op.

