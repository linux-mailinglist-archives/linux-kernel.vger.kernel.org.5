Return-Path: <linux-kernel+bounces-49808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D20A846FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8226B1C249BA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C413E220;
	Fri,  2 Feb 2024 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu0aN8r/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C1A60270;
	Fri,  2 Feb 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875112; cv=none; b=hqqWfho23h2rjymnFK3FY0IfJ1oCQE45j7aXRYwK8lEShTbCAJcJJ77CnfKpjTAZ7EiG2CFTltRiY94QZpLJvzvfQfKien8FniKyCnG80Bd5X9BgEMFYZYPhEMfS49TDJRRXbjMhIXik+xq7BnumDF5hhWVJRRGHhaBDHqydTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875112; c=relaxed/simple;
	bh=28eVMR5VejBPzOZM439WvuKU/7CA3CIN97T0u0bI17c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlpvtMMdLGc5/GLuDCCnSAUN9e+JTiHOJpYFanZdiuGH+eZ6z04qHhAHc2c5eBDYsPfb3C6wQyBqhNOb+IxyemWkvZp1etdk/FHKxlFZ9lwuchIWNr+r7cyOAP8zzyKGmO+xFE4Npr9QKjtV816UiRbZdu8QfBGJKv5/LyfdBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu0aN8r/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3135C433F1;
	Fri,  2 Feb 2024 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706875111;
	bh=28eVMR5VejBPzOZM439WvuKU/7CA3CIN97T0u0bI17c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iu0aN8r/nNwsnPMpARRPy4agLoGLztKstfqsKYfTb+5rlNKthcKgU9oh3zHdJFQsx
	 cikBsWOOM+4KuaRpCGiYjlCBXnByOz9bDZuR/d9wlewsI8SvaZ2XDA+kaxDWj4D9JW
	 bk5ddYM+MFp5tlhdtrUogWa6gcTsK3wbI2GuChVUK6twv15cfUqZprysCBjFYM3k1J
	 FoaF71I0zDXKVdAB7gjyVp8+Z7zlIlt9cfshpah8KRWfm93dEWPRAXdOyGLmbBuxD3
	 tOoP+Jhjk0KipFO4LQeGDldHsb2PiNSsd6Gvg8y1xyr7rH8ZvKNaVluwMNKgI178kF
	 ll1WNINh93u1w==
Date: Fri, 2 Feb 2024 12:58:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
Message-ID: <20240202-quatsch-hochachtung-c3a41dd551a7@brauner>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-2-stefanb@linux.ibm.com>
 <CAOQ4uxjgdvGU0WE+92ByQE26Jp0j16AgfyCjNyEp7=86akOSsA@mail.gmail.com>
 <20240131-lacht-elend-536d94682370@brauner>
 <05fe58a1-9b2c-4c1f-80a6-4cb5094a2126@linux.ibm.com>
 <20240201-zierpflanzen-allgegenwart-5eb1fa243a61@brauner>
 <CAOQ4uxgfkdX+3VR9sA7SeB7f3BW89iAwF2-JRCcJNsurtune_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgfkdX+3VR9sA7SeB7f3BW89iAwF2-JRCcJNsurtune_g@mail.gmail.com>

On Thu, Feb 01, 2024 at 04:18:32PM +0200, Amir Goldstein wrote:
> On Thu, Feb 1, 2024 at 3:35 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Jan 31, 2024 at 09:56:25AM -0500, Stefan Berger wrote:
> > >
> > >
> > > On 1/31/24 09:25, Christian Brauner wrote:
> > > > On Wed, Jan 31, 2024 at 03:25:29PM +0200, Amir Goldstein wrote:
> > > > > On Tue, Jan 30, 2024 at 11:46 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
> > > > > >
> > > > > > Copying up xattrs is solely based on the security xattr name. For finer
> > > > > > granularity add a dentry parameter to the security_inode_copy_up_xattr
> > > > > > hook definition, allowing decisions to be based on the xattr content as
> > > > > > well.
> > > > > >
> > > > > > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > > ---
> > > > > >   fs/overlayfs/copy_up.c            | 2 +-
> > > > > >   include/linux/evm.h               | 2 +-
> > > > > >   include/linux/lsm_hook_defs.h     | 3 ++-
> > > > > >   include/linux/security.h          | 4 ++--
> > > > > >   security/integrity/evm/evm_main.c | 2 +-
> > > > > >   security/security.c               | 7 ++++---
> > > > > >   security/selinux/hooks.c          | 2 +-
> > > > > >   security/smack/smack_lsm.c        | 2 +-
> > > > > >   8 files changed, 13 insertions(+), 11 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> > > > > > index b8e25ca51016..bd9ddcefb7a7 100644
> > > > > > --- a/fs/overlayfs/copy_up.c
> > > > > > +++ b/fs/overlayfs/copy_up.c
> > > > > > @@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
> > > > > >                  if (ovl_is_private_xattr(sb, name))
> > > > > >                          continue;
> > > > > >
> > > > > > -               error = security_inode_copy_up_xattr(name);
> > > > > > +               error = security_inode_copy_up_xattr(old, name);
> > > > >
> > > > > What do you think about:
> > > > >
> > > > >                       error = security_inode_copy_up_xattr(name, NULL, 0);
> > > > >
> > > > > and then later...
> > > > >
> > > > >                       error = security_inode_copy_up_xattr(name, value, size);
> > > > >
> > > > > I am asking because overlayfs uses mnt_idmap(path->mnt) and you
> > > > > have used nop_mnt_idmap inside evm hook.
> > > > > this does not look right to me?
> > > >
> > > > So it's relevant if they interact with xattrs that care about the
> > > > idmapping and that's POSIX ACLs and fscaps. And only if they perform
> > > > permission checks such as posix_acl_update_mode() or something. IOW, it
> > > > depends on what exactly EVM is doing.
> > >
> > > In 2/5 we are reading the value of security.evm to look at its contents.
> >
> > I'm not sure what this is supposed to be telling me in relation to the
> > original question though. :) security.evm doesn't store any {g,u}id
> > information afaict. IOW, it shouldn't matter?
> 
> But it does. in evm_calc_hmac_or_hash() => hmac_add_misc():
> 
>         hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
>         hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
> 
> I guess as far as EVM is concerned, it should always be interested in the
> absolute uig/gid values of the inode.

There we go, thanks Amir. Yes, these EVM values can't be relative to any
idmappings. If inode->i_uid has kuid 100000 and 100000 maps to zero in
the caller's user namespace then you'd be storing hmac_misc.{g,u}id
zero. That would be problematic as it would give the impression that
real root caused that hmac to be written. So this really needs to store
100000 to make it clear that this was an unprivileged user that created
these values.

