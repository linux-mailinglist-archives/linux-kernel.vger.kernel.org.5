Return-Path: <linux-kernel+bounces-23332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E309082AB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73635B26F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4E12E5A;
	Thu, 11 Jan 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r80Gwdip"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B612E59
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2HZhy6w8gpDC4mT19yv0E28LcZ7bJIquaKWzJ4wbSLc=; b=r80GwdipBsSE89YZ5JymRb9hOZ
	OPiJmNAnH9l6b9p4hd0smTknZaRBfQm6H/yxDy18ajkS9dCADATV65sJ5WupT82g/jIx5QB4nh0b5
	CNsd/9GGCdQBiVOoelDWB9OZOKLPSF1cGKwuUqx4GwNWzYEzqYFUmEmdAQXTqnVUFxecSFX+b/hUe
	KpwPcdXXA6oZmJm36ovZ2WeXUohgaVoUPXZBrJN3RMgEPoXREY9J9iHPDkmy8a/Pb+DEpu25NonWO
	mVxE66leexPfuaIk77g2Ewr74O3va7MBgGUhwxGillVjmpm6WT1A8Ejq3hEPg//InjDCzxmjZc6lG
	m+J0mOuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rNreZ-00C7IA-1B;
	Thu, 11 Jan 2024 09:47:11 +0000
Date: Thu, 11 Jan 2024 09:47:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Kees Cook <kees@kernel.org>,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [GIT PULL] execve updates for v6.8-rc1
Message-ID: <20240111094711.GT1674809@ZenIV>
References: <202401081028.0E908F9E0A@keescook>
 <CAHk-=wgznerM-xs+x+krDfE7eVBiy_HOam35rbsFMMOwvYuEKQ@mail.gmail.com>
 <D01C78AC-830C-4D73-9E9F-7FD38CEF2E82@kernel.org>
 <ZZ2W_xzCSyOgltad@localhost>
 <CAHk-=wi75tFVtZdzFRr4hsDeUKmeACbgD46rLe+2bcd=4mHBBw@mail.gmail.com>
 <ZZ3_Jmb1sb2wQWO_@localhost>
 <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf9qLO8ipps4QhmS0BkM8mtWJhvnuDSdtw5gFjhzvKNA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 09, 2024 at 07:54:30PM -0800, Linus Torvalds wrote:

> Al, comments? We *could* just special-case the execve() code not to
> use do_filp_open() and avoid this issue that way, but it does feel
> like even the regular open() case is pessimal with that whole RCU
> situation.

Two things, both related to ->atomic_open():
	* we pass struct file to ->atomic_open(), so that it either opens
the sucker _or_ stores the resulting dentry in it (if ->atomic_open() bails
and tells us to use such-and-such dentry, other than the one it had been
given).
	* cleanup logics becomes interesting if we try to keep struct
file from pass to pass.  Sure, if it had never been touched _or_ if it had
only been fed to finish_no_open() (i.e. ->atomic_open() bailout path) -
no problem, we can reuse it.  But once it has hit do_dentry_open(), the
things get fishy.  We *must* fput() it if we got to setting FMODE_OPENED -
no plausible way around that.  But what about the case when we fail
e.g. inside ->open()?  Currently we undo just enough for fput() to do
the right thing without FMODE_OPENED, but e.g. security_file_open() has
no undoing for it.  Having it called twice on the same struct file might
or might not work on all LSMs, but they hadn't been exposed to that until
now.

We could pass struct file ** to path_openat(), with
	file = *fp;
	if (!file) {
		file = alloc_empty_file(op->open_flag, current_cred());
		if (IS_ERR(file))
			return file;
		*fp = file;
	}
in the beginning and have an extra flag that would be
set as soon as we hit do_dentry_open().  Then we could make the fput()
in path_openat() failure handling conditional upon that flag.

Doable, but really not pretty, especially since we'd need to massage
the caller as well...  Less painful variant is
	if (error == -ECHILD && (flags & LOOKUP_RCU))
		return ERR_PTR(-ECHILD); // keep file for non-rcu pass
	*fp = NULL;
	fput(file);
	...
on the way out; that won't help with -ESTALE side of things, but if we
hit *that*, struct file allocation overhead is really noise.

PS: apologies for late reply - had been sick since Saturday, just got more
or less back to normal.

