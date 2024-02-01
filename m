Return-Path: <linux-kernel+bounces-48243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6925845903
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AEC71F2615E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333CE5CDD3;
	Thu,  1 Feb 2024 13:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5F2NmDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF053385;
	Thu,  1 Feb 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794545; cv=none; b=Lyk0uM+Hc2dQP9LkSS75tQp+NCI7nzBMiqbT30Qn6xyj9IvD6DcDyheeMmUI++FBZcGT2LLqc65t+0nmbaoM49aCxsy+J3WpANygV9ZmQiCr4OT5QAeL8fHF7LdozCFJYp06hN6fsGVELTiuKNctxCCPGbP6yNFjrqICEmTeQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794545; c=relaxed/simple;
	bh=FrMa1KXy4wo5v3lpglu0QSvWx8klxylH4PN3PwoE658=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4605oyuCn89LKgWxpp+dkptOaPqXPr9XOj/tIrT7dZQFdfhoDTFSBgrPwpkdZ7HZGsrutLo9o72+pXTH+E7+1Hb+/mhz3xKI2GUnnFQzvVYdmihU9QF/mSmqkwiv423Pkh0vu0yLfF9zYf0MqWKPRcj6GCCiNJoGjUA7B6Zqoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5F2NmDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E302FC43394;
	Thu,  1 Feb 2024 13:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794545;
	bh=FrMa1KXy4wo5v3lpglu0QSvWx8klxylH4PN3PwoE658=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5F2NmDGkqnzwc8+ZOKOrK2ssRGf/YI+ir4DFbAVNSlthTkXWps8PJ9btyZVHeKuL
	 WfvsuTelS4MNleFEj2U3qRWeJlYvuyyGEcKWMyOSsw22QanTdoKOdkA6PFyfJgeAHi
	 BlaFruhJSsqpdyxPKsBAHRGev1MK6ioM6JYgl0bbqC6UcMRBf/UFxPAtLjtJCkq2a/
	 iO27nD6ncG17QodBAMVrZeQw+UNIpHnCnvNJf/8PJGISb0ZgPXtWlKBDHxjoq6UdV+
	 L0lgWVPcoiC9BYKTGK9aS6dcSZbwtTgk90VwiLpOZrk03uKJfuhsNmK4ouDz70Y0aP
	 5s8+8pASmcANg==
Date: Thu, 1 Feb 2024 14:35:39 +0100
From: Christian Brauner <brauner@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
Message-ID: <20240201-zierpflanzen-allgegenwart-5eb1fa243a61@brauner>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-2-stefanb@linux.ibm.com>
 <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
 <20240131-lacht-elend-536d94682370@brauner>
 <05fe58a1-9b2c-4c1f-80a6-4cb5094a2126@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05fe58a1-9b2c-4c1f-80a6-4cb5094a2126@linux.ibm.com>

On Wed, Jan 31, 2024 at 09:56:25AM -0500, Stefan Berger wrote:
> 
> 
> On 1/31/24 09:25, Christian Brauner wrote:
> > On Wed, Jan 31, 2024 at 03:25:29PM +0200, Amir Goldstein wrote:
> > > On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> > > > 
> > > > Copying up xattrs is solely based on the security xattr name. For finer
> > > > granularity add a dentry parameter to the security_inode_copy_up_xattr
> > > > hook definition, allowing decisions to be based on the xattr content as
> > > > well.
> > > > 
> > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > ---
> > > >   fs/overlayfs/copy_up.c            | 2 +-
> > > >   include/linux/evm.h               | 2 +-
> > > >   include/linux/lsm_hook_defs.h     | 3 ++-
> > > >   include/linux/security.h          | 4 ++--
> > > >   security/integrity/evm/evm_main.c | 2 +-
> > > >   security/security.c               | 7 ++++---
> > > >   security/selinux/hooks.c          | 2 +-
> > > >   security/smack/smack_lsm.c        | 2 +-
> > > >   8 files changed, 13 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > > > index b8e25ca51016..bd9ddcefb7a7 100644
> > > > --- a/fs/overlayfs/copy_up.c
> > > > +++ b/fs/overlayfs/copy_up.c
> > > > @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
> > > >                  if (ovl_is_private_xattr(sb, name))
> > > >                          continue;
> > > > 
> > > > -               error = security_inode_copy_up_xattr(name);
> > > > +               error = security_inode_copy_up_xattr(old, name);
> > > 
> > > What do you think about:
> > > 
> > >                       error = security_inode_copy_up_xattr(name, NULL, 0);
> > > 
> > > and then later...
> > > 
> > >                       error = security_inode_copy_up_xattr(name, value, size);
> > > 
> > > I am asking because overlayfs uses mnt_idmap(path->mnt) and you
> > > have used nop_mnt_idmap inside evm hook.
> > > this does not look right to me?
> > 
> > So it's relevant if they interact with xattrs that care about the
> > idmapping and that's POSIX ACLs and fscaps. And only if they perform
> > permission checks such as posix_acl_update_mode() or something. IOW, it
> > depends on what exactly EVM is doing.
> 
> In 2/5 we are reading the value of security.evm to look at its contents.

I'm not sure what this is supposed to be telling me in relation to the
original question though. :) security.evm doesn't store any {g,u}id
information afaict. IOW, it shouldn't matter?

