Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CBE7FF3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346346AbjK3Ph7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346334AbjK3Ph6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:37:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C6810C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:38:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A9FC433C7;
        Thu, 30 Nov 2023 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701358685;
        bh=TYH67YY/vrV7LCaHvewMgY+OV3nAVb1Ax/9cHSFKzoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuppY99F8p1LDyn+nSkuEYzAS+YVKpAhQxNpDdUjTgsoDe6BTntotyOg8I0NpXbs3
         7K6zIDKIBLTZk/DbWA81w1Q9qoEd+l6w2kKNfOouBPx3d10zvSbhzAEMp/U+O6EdHe
         nkj3cz7G23WGV6UPExAS+M+5hWgqO7RFReEWtVUJ4Nd4Kl12d4nolLDeG+QYZT9CYR
         hntPSnx+3+diLqCdBPHx0dFk+OSND3/PXkkPsbOEikaGZ2U1HjXTyE3NfPjUdfa+MY
         8mF1juW8ISvVagOeSxOsh+fZCPLKlCOQodVkZyd0pC6AxQ/BVTR6ruDUf3JZ51rfYX
         uslOgzqOWGqYg==
Date:   Thu, 30 Nov 2023 09:38:03 -0600
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
Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
Message-ID: <ZWisW4g7RgTe958F@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-9-da5a26058a5b@kernel.org>
 <CAOQ4uxjhFKmHSUKiFOraDZojD0qGC=ChJJwtfrncuvTYi9NTKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjhFKmHSUKiFOraDZojD0qGC=ChJJwtfrncuvTYi9NTKw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:01:55AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:50 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Provide a type-safe interface for setting filesystem capabilities and a
> > generic implementation suitable for most filesystems.
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  fs/xattr.c         | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/fs.h |  2 ++
> >  2 files changed, 89 insertions(+)
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 3abaf9bef0a5..03cc824e4f87 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -247,6 +247,93 @@ int vfs_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> >  }
> >  EXPORT_SYMBOL(vfs_get_fscaps);
> >
> > +static int generic_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +                             const struct vfs_caps *caps, int flags)
> > +{
> > +       struct inode *inode = d_inode(dentry);
> > +       struct vfs_ns_cap_data nscaps;
> > +       int size;
> > +
> > +       size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps,
> > +                                &nscaps, sizeof(nscaps));
> > +       if (size < 0)
> > +               return size;
> > +
> > +       return __vfs_setxattr_noperm(idmap, dentry, XATTR_NAME_CAPS,
> > +                                    &nscaps, size, flags);
> > +}
> > +
> > +/**
> > + * vfs_set_fscaps - set filesystem capabilities
> > + * @idmap: idmap of the mount the inode was found from
> > + * @dentry: the dentry on which to set filesystem capabilities
> > + * @caps: the filesystem capabilities to be written
> > + * @flags: setxattr flags to use when writing the capabilities xattr
> > + *
> > + * This function writes the supplied filesystem capabilities to the dentry.
> > + *
> > + * Return: 0 on success, a negative errno on error.
> > + */
> > +int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > +                  const struct vfs_caps *caps, int flags)
> > +{
> > +       struct inode *inode = d_inode(dentry);
> > +       struct inode *delegated_inode = NULL;
> > +       struct vfs_ns_cap_data nscaps;
> > +       int size, error;
> > +
> > +       /*
> > +        * Unfortunately EVM wants to have the raw xattr value to compare to
> > +        * the on-disk version, so we need to pass the raw xattr to the
> > +        * security hooks. But we also want to do security checks before
> > +        * breaking leases, so that means a conversion to the raw xattr here
> > +        * which will usually be reduntant with the conversion we do for
> > +        * writing the xattr to disk.
> > +        */
> > +       size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
> > +                                sizeof(nscaps));
> > +       if (size < 0)
> > +               return size;
> > +
> > +retry_deleg:
> > +       inode_lock(inode);
> > +
> > +       error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
> > +       if (error)
> > +               goto out_inode_unlock;
> > +       error = security_inode_setxattr(idmap, dentry, XATTR_NAME_CAPS, &nscaps,
> > +                                       size, flags);
> > +       if (error)
> > +               goto out_inode_unlock;
> > +
> > +       error = try_break_deleg(inode, &delegated_inode);
> > +       if (error)
> > +               goto out_inode_unlock;
> > +
> > +       if (inode->i_opflags & IOP_XATTR) {
> > +               if (inode->i_op->set_fscaps)
> > +                       error = inode->i_op->set_fscaps(idmap, dentry, caps, flags);
> > +               else
> > +                       error = generic_set_fscaps(idmap, dentry, caps, flags);
> 
> I think the non-generic case is missing fsnotify_xattr().
> 
> See vfs_set_acl() for comparison.

Good catch. I'm going to have another look at some of this in light of
some of your other feedback, but I'll get it fixed one way or another in
v2.
