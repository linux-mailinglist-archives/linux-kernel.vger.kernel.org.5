Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D6F7FF445
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346537AbjK3QBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346538AbjK3QBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:01:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8039D10EF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:01:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C86CC433C9;
        Thu, 30 Nov 2023 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701360107;
        bh=P1tgJCfx+/eYHr6lVSMer5D6r86hKqyzpid4w5V5wSI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dAq0CegDdEqHoQZfJ8W1aMO90ZIwjqd5LeM/I2oqNmD8jFb1y/kl0DbXbBWpSt0W4
         geumHI9+z2y4C1PUH9d7gvIIF1a9kZO33d776l9e5mYAcI02L0/bItE7C+IfgCuoz+
         y0GjIo0fG12Ht3m0xsrvPKp73R9SK8RsLu0BviFNmEz7pdhYrR/NxclLudM8aRpzBk
         M9FChtuqRnCTXAz5aOG//b+1GCfJEA00b0XUzx0aBB1ihcOjb9kNPVk61ypo20bvtS
         bl+hseWo3G7t2GqVL33eQF+XMhhTxVHJoLtZij8zscHDPXog59hO8VyDofve2rRAPy
         aCi4Kp+a6f3Yw==
Date:   Thu, 30 Nov 2023 10:01:46 -0600
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 11/16] ovl: add fscaps handlers
Message-ID: <ZWix6vjvMXgpbQRD@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-11-da5a26058a5b@kernel.org>
 <CAOQ4uxiuFmvaA6yd59WMGxWAGKc6JBono3oNp4XndYcfWVhUxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiuFmvaA6yd59WMGxWAGKc6JBono3oNp4XndYcfWVhUxw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 07:56:48AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:50 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Add handlers which read fs caps from the lower or upper filesystem and
> > write/remove fs caps to the upper filesystem, performing copy-up as
> > necessary.
> >
> > While it doesn't make sense to use fscaps on directories, nothing in the
> > kernel actually prevents setting or getting fscaps xattrs for directory
> > inodes. If we omit fscaps handlers in ovl_dir_inode_operations then the
> > generic handlers will be used. These handlers will use the xattr inode
> > operations, bypassing any idmapping on lower mounts, so fscaps handlers
> > are also installed for ovl_dir_inode_operations.
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  fs/overlayfs/dir.c       |  3 ++
> >  fs/overlayfs/inode.c     | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/overlayfs/overlayfs.h |  6 ++++
> >  3 files changed, 93 insertions(+)
> >
> > diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> > index aab3f5d93556..d9ab3c9ce10a 100644
> > --- a/fs/overlayfs/dir.c
> > +++ b/fs/overlayfs/dir.c
> > @@ -1303,6 +1303,9 @@ const struct inode_operations ovl_dir_inode_operations = {
> >         .get_inode_acl  = ovl_get_inode_acl,
> >         .get_acl        = ovl_get_acl,
> >         .set_acl        = ovl_set_acl,
> > +       .get_fscaps     = ovl_get_fscaps,
> > +       .set_fscaps     = ovl_set_fscaps,
> > +       .remove_fscaps  = ovl_remove_fscaps,
> >         .update_time    = ovl_update_time,
> >         .fileattr_get   = ovl_fileattr_get,
> >         .fileattr_set   = ovl_fileattr_set,
> > diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> > index c63b31a460be..82fc6e479d45 100644
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -568,6 +568,87 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >  }
> >  #endif
> >
> > +int ovl_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +                  struct vfs_caps *caps)
> > +{
> > +       int err;
> > +       const struct cred *old_cred;
> > +       struct path realpath;
> > +
> > +       ovl_path_real(dentry, &realpath);
> > +       old_cred = ovl_override_creds(dentry->d_sb);
> > +       err = vfs_get_fscaps(mnt_idmap(realpath.mnt), realpath.dentry, caps);
> > +       revert_creds(old_cred);
> > +       return err;
> > +}
> > +
> > +int ovl_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +                  const struct vfs_caps *caps, int flags)
> > +{
> > +       int err;
> > +       struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> > +       struct dentry *upperdentry = ovl_dentry_upper(dentry);
> > +       struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> > +       const struct cred *old_cred;
> > +
> > +       err = ovl_want_write(dentry);
> > +       if (err)
> > +               goto out;
> > +
> > +       if (!upperdentry) {
> > +               err = ovl_copy_up(dentry);
> > +               if (err)
> > +                       goto out_drop_write;
> > +
> > +               realdentry = ovl_dentry_upper(dentry);
> > +       }
> > +
> > +       old_cred = ovl_override_creds(dentry->d_sb);
> > +       err = vfs_set_fscaps(ovl_upper_mnt_idmap(ofs), realdentry, caps, flags);
> > +       revert_creds(old_cred);
> > +
> > +       /* copy c/mtime */
> > +       ovl_copyattr(d_inode(dentry));
> > +
> > +out_drop_write:
> > +       ovl_drop_write(dentry);
> > +out:
> > +       return err;
> > +}
> > +
> > +int ovl_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
> > +{
> > +       int err;
> > +       struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
> > +       struct dentry *upperdentry = ovl_dentry_upper(dentry);
> > +       struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> > +       const struct cred *old_cred;
> > +
> > +       err = ovl_want_write(dentry);
> > +       if (err)
> > +               goto out;
> > +
> > +       if (!upperdentry) {
> > +               err = ovl_copy_up(dentry);
> > +               if (err)
> > +                       goto out_drop_write;
> > +
> > +               realdentry = ovl_dentry_upper(dentry);
> > +       }
> > +
> 
> This construct is peculiar.
> Most of the operations just do this unconditionally:
> 
> err = ovl_copy_up(dentry);
> if (err)
>         goto out_drop_write;
> 
> and then use ovl_dentry_upper(dentry) directly, because a modification
> will always be done on the upper dentry, regardless of the state before
> the operation started.
> 
> I was wondering where you copied this from and I found it right above
> in ovl_set_or_remove_acl().
> In that case, there was also no justification for this construct.

Yes, I did use ovl_set_or_remove_acl() as a reference here. But looking
around at some of the other code, I see what you mean, so I'll rework
this code.

> There is also no justification for open coding:
>    struct dentry *realdentry = upperdentry ?: ovl_dentry_lower(dentry);
> when later on, ovl_path_lower(dentry, &realpath) is called anyway.
> 
> The only reason to do anything special in ovl_set_or_remove_acl() is:
> 
>         /*
>          * If ACL is to be removed from a lower file, check if it exists in
>          * the first place before copying it up.
>          */
> 
> Do you not want to do the same for ovl_remove_fscaps()?

Yes, I will add this.

> Also, the comparison to remove_acl API bares the question,
> why did you need to add a separate method for remove_fscaps?
> Why not use set_fscaps(NULL), just like setxattr() and set_acl() APIs?

I had started on these patches a while back and then picked them up
again recently, and honestly I don't remember why I did that originally.
I don't see a need for it now though, so I can change that.
