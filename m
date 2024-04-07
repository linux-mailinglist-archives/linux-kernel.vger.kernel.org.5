Return-Path: <linux-kernel+bounces-134113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECC89ADC5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BEB1F214CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDC3A3F;
	Sun,  7 Apr 2024 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h1Oz8pKL"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DD629
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712450908; cv=none; b=XLrB0J8BR2PJFuG93c0PT1oX6Ion0+ruchmzd5ow1l8AsQ6LWvWf9nsEjzdFJOYComeE8qv56bwD/ZXYi9G4SFOca98/da9o+qHYrllhF1Djs0zLAei2mX/70uKGha8O/ALvb6/MvWouvRvtTrEC08J06Iwd+z8R0hG71ojaYw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712450908; c=relaxed/simple;
	bh=FBHKp5FQpdZLkw+aEa5kkI/IrUkADBFdgBb0Md7Se0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXttxfgCDJ2rg5ZyH66FkqBlHM35kVPyxm8RbmZz4656k+bkd0npPDXlMcrfRRwFBvlLDG28OZ0wmNX9fouo8h1wYqKfMBH/YQ2wUy3KCbRXGk9JgetkSTyjXaSnpnLJXOk0iEn1p63SL+tJl6bhtYJNpJmez8KhLLA7mJnwwac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=h1Oz8pKL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NH8FGATjNZMKFA2j1ChrD8++DfQvm6Mdd8wyVkY1Wow=; b=h1Oz8pKL3/TB7pVRJlfnh2U3kq
	tej5jyB5mBRgqogowICMiUl5ObvIWlPitqVgP570y0pMkxdoHBAwyUyGd0rVjb2EFb/bVmvzPbtvv
	l2RF5s0S4h3HEuMh4VOKEz4wtB54J/sWOLqezXdxExk2vugkJfaUdNVJsoFVwVl2OFGoLq6wS+B5q
	zp+64U2zULzTRhcCArHtMGr8AFtP4eNmlorFWcwIetTh7Mb5VaJ1YlhnUTopjJKfC+6rzJGkp/hug
	lB2/Plp9UuctRWGld1sFdnPwgNhdoFXN5v6ugTzsr6GqvPQ9stfuHQz+9fphZ6VWYBi4pH5LTVMkl
	L2WIqlRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rtGhk-007VDz-1C;
	Sun, 07 Apr 2024 00:48:16 +0000
Date: Sun, 7 Apr 2024 01:48:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>,
	amir73il@gmail.com, linux-kernel@vger.kernel.org, miklos@szeredi.hu,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
Message-ID: <20240407004816.GE538574@ZenIV>
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
 <000000000000107743061568319c@google.com>
 <20240406082351.1213-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406082351.1213-1-hdanton@sina.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 06, 2024 at 04:23:51PM +0800, Hillf Danton wrote:
> On Sat, 6 Apr 2024 08:11:30 +0100 Al Viro <viro@ftp.linux.org.uk>
> > On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:
> > > commit:         3398bf34 kernfs: annotate different lockdep class for ..
> > > git tree:       https://github.com/amir73il/linux/ vfs-fixes
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c5cda112a8438056
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
c > > 
> > > Note: no patches were applied.
> > 
> > How about the same test on 6c6e47d69d821047097909288b6d7f1aafb3b9b1?
> > 
> JFYI it works [1]
> 
> [1] https://lore.kernel.org/lkml/000000000000a386f2061562ba6a@google.com/

It works on top of v6.8-8951-gfe46a7dd189e; boot failures on top
of v6.9-rc2-387-g6c6e47d69d82 and on top of v6.9-rc1.  See
https://lore.kernel.org/lkml/00000000000039026a06155b3a12@google.com/
and
https://lore.kernel.org/lkml/000000000000107743061568319c@google.com/
resp.  Both hit refcount_t underflow in virtio_scsi probing, with
very similar call chains (if not outright identical ones - hadn't
checked in details).

I don't believe that this patch introduces a boot failure, let alone
this one - all of that is likely to be shared with the corresponding
points on mainline.

Might be interesting to try and figure out what that is, but that's
a separate bug.

