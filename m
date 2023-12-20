Return-Path: <linux-kernel+bounces-6252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C32A81965F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C701F26414
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE513AF3;
	Wed, 20 Dec 2023 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jsqoLa3l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DBC1173B;
	Wed, 20 Dec 2023 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lhTjK4akHJ+Vz3JaxhNDk1DJxUnOy4b7vdU1q/Ng7Dk=; b=jsqoLa3lJEBMYbj5zQr0L54nrE
	ZEqXHm+J1m+jJgLa1TVBqFYMbVcbIb5csswAmhVL1gHOPSjWBvKkz0KmqLGQzVQ5Qd3claXbaktwP
	FbzBvw7/9HS7N/HKhDYn1CRVUN1jAeRdd8XO2HWuD24Wfk99Yida4YenirAL04pU8cnNt9/ZH9E8j
	SlvhQWaYQxF2bObXGLpBpogaMMUgMJ/hJZQmDGCN9Lk6O9yrkLjrcN8LORplB4O9p1ERu3hBPc7PW
	idHjigCWQqhvtZHCWjX8ec7EiqK4L6+VbSLvuvogNe+j0zNVnyu+9GEOOqWTuBN+oGdNmv/cFUSqg
	hJAb+uYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rFlTG-00H2m5-2H;
	Wed, 20 Dec 2023 01:34:02 +0000
Date: Wed, 20 Dec 2023 01:34:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the vfs tree with the f2fs tree
Message-ID: <20231220013402.GW1674809@ZenIV>
References: <20231220104734.0979a9f8@canb.auug.org.au>
 <20231220111325.5dd55e47@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220111325.5dd55e47@canb.auug.org.au>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 20, 2023 at 11:13:25AM +1100, Stephen Rothwell wrote:
> Hi Al,
> 
> On Wed, 20 Dec 2023 10:47:34 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the vfs tree got a conflict in:
> > 
> >   fs/f2fs/namei.c
> > 
> > between commit:
> > 
> >   53edb549565f ("f2fs: fix to avoid dirent corruption")
> > 
> > from the f2fs tree and commit:
> > 
> >   7deee77b993a ("f2fs: Avoid reading renamed directory if parent does not change")
> > 
> > from the vfs tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> Then I remembered to look at your suggested resolution and redid it
> like you did (see below).

My suggested resolution had been wrong, actually - the way it's written,
link count drop should be conditional on old_is_dir, cross-directory or
not.

I think the right solution is
	if (old_dir_entry)
		f2fs_set_link(old_inode, old_dir_entry, old_dir_page, new_dir);
        if (old_is_dir)
		f2fs_i_links_write(old_dir, false);


