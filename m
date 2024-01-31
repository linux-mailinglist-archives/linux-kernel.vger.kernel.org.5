Return-Path: <linux-kernel+bounces-46602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C798441D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BCF2899B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC6180BEC;
	Wed, 31 Jan 2024 14:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbOKxxCe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEF982886;
	Wed, 31 Jan 2024 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706711139; cv=none; b=KraX4U3/haNpNgG61BG6rnzkUQLYWbOzFbf5v9/XMLZPDC4zbIjYxuVUYqOzPjalQO1b+U6jY/Pizu5LvxSCmYsV/VQzKBy1QY5xNR8VaUd/qJ9LA1zGzj3EDCeuABiPCQjQsuK0f0OHXFziYbx7AMEM+lVjgnge5OrwkdCA1dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706711139; c=relaxed/simple;
	bh=OYIebYlAw7S0p992aaP/mpC7lN+bDzKspkekfONLIXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJDlINdUaQF++GRHJb3C2gdrUBQ77UnFj4vwlH/2BYLnchYe0z3C6c9Wrz2o7Xm0nxG1crsWmMlMIc09ZXYJhaoYqb8rg4gvY2AbNmB7EBcN5+XZlFhZwD8GJ6thHP0st3uywLPCKMKRB8jakVgLjuMxSC/3HIEP4Rp166p/thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbOKxxCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA53C43390;
	Wed, 31 Jan 2024 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706711138;
	bh=OYIebYlAw7S0p992aaP/mpC7lN+bDzKspkekfONLIXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbOKxxCe7LLdszUKJ6gqFU85V1F9KsTEni4EqaiaJyNN4AQq7ZbbJ1XJS5iNbHaCn
	 Uunk1FrgPVF5cZmHwshfWunPMjARZREk+GXLho7Wb2bNkC/6W/lskYsng6MKTHncnC
	 GTHLENhg/Z31cBppgwtpqoMt68XRXcr+sWD8jiPHnLVTtwxtYoxwnz2c+Aeln9zIbN
	 IHVTPkuqeHrhJh52yEl8bm3JjEQUp09J9G8WeH226HtBaLYvF6YCywPXc3BbIs6lMN
	 ZK2uGRcXY4GAc0l87b9m4EWvZXwJvyS/m02MftyvRXXMBpAb9CYZJfXjQwxdWNM/Ag
	 zutQk5P9aNfnA==
Date: Wed, 31 Jan 2024 15:25:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
Message-ID: <20240131-lacht-elend-536d94682370@brauner>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-2-stefanb@linux.ibm.com>
 <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>

On Wed, Jan 31, 2024 at 03:25:29PM +0200, Amir Goldstein wrote:
> On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> >
> > Copying up xattrs is solely based on the security xattr name. For finer
> > granularity add a dentry parameter to the security_inode_copy_up_xattr
> > hook definition, allowing decisions to be based on the xattr content as
> > well.
> >
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  fs/overlayfs/copy_up.c            | 2 +-
> >  include/linux/evm.h               | 2 +-
> >  include/linux/lsm_hook_defs.h     | 3 ++-
> >  include/linux/security.h          | 4 ++--
> >  security/integrity/evm/evm_main.c | 2 +-
> >  security/security.c               | 7 ++++---
> >  security/selinux/hooks.c          | 2 +-
> >  security/smack/smack_lsm.c        | 2 +-
> >  8 files changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > index b8e25ca51016..bd9ddcefb7a7 100644
> > --- a/fs/overlayfs/copy_up.c
> > +++ b/fs/overlayfs/copy_up.c
> > @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
> >                 if (ovl_is_private_xattr(sb, name))
> >                         continue;
> >
> > -               error = security_inode_copy_up_xattr(name);
> > +               error = security_inode_copy_up_xattr(old, name);
> 
> What do you think about:
> 
>                      error = security_inode_copy_up_xattr(name, NULL, 0);
> 
> and then later...
> 
>                      error = security_inode_copy_up_xattr(name, value, size);
> 
> I am asking because overlayfs uses mnt_idmap(path->mnt) and you
> have used nop_mnt_idmap inside evm hook.
> this does not look right to me?

So it's relevant if they interact with xattrs that care about the
idmapping and that's POSIX ACLs and fscaps. And only if they perform
permission checks such as posix_acl_update_mode() or something. IOW, it
depends on what exactly EVM is doing.

IIRC, I already added custom security_*() hooks specifically for POSIX
ACLs as they can't be retrieved through vfs_xattr*() helpers anymore.

