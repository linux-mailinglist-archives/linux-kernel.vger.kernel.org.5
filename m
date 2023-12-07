Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CBC808AE2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443338AbjLGOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjLGOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:42:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356E128
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:43:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1F1C433C7;
        Thu,  7 Dec 2023 14:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701960180;
        bh=cQep9CNYbdGvrYQCRNGMIqjTSZXsMZr211akzg6LsV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLxoBSw/8zR9WkDXX1UNVxvj/L8lU6ROUUegSoGsptHGsdpbda3X7LdvyjbRvF8C6
         MUHZ01pUD6HrpHGczZTYrgDolAPVc3C6TJLMi/AgRRuR/PJIKRgbA4+znthKyKoEnd
         mhIkF5hTjXB9R7BNHY0pMyjRDTKuKsbQy5uFSzLlUisLTZIqE1zlCzj/lJecRDJP9k
         DiTpRJskSwHQmOeGSlvmF/6OEqmANZHTVoI0sf3ICeuHIn6EJvfjE12wPlFO9AmiVm
         rVmTpGAU5SyYQD9/rmI1In0D4CY6F53P9z5kA9uEarFC59qJcNjG890sgSlJ5XI543
         YZ9/r7DenQi3Q==
Date:   Thu, 7 Dec 2023 08:42:58 -0600
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
Message-ID: <ZXHZ8uNEg1IK5WMW@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-9-da5a26058a5b@kernel.org>
 <20231201-reintreten-gehalt-435a960f80ed@brauner>
 <ZWojWE7/HRnByRb+@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWojWE7/HRnByRb+@do-x1extreme>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding Mimi for insights on EVM questions]

On Fri, Dec 01, 2023 at 12:18:00PM -0600, Seth Forshee (DigitalOcean) wrote:
> On Fri, Dec 01, 2023 at 06:39:18PM +0100, Christian Brauner wrote:
> > > +/**
> > > + * vfs_set_fscaps - set filesystem capabilities
> > > + * @idmap: idmap of the mount the inode was found from
> > > + * @dentry: the dentry on which to set filesystem capabilities
> > > + * @caps: the filesystem capabilities to be written
> > > + * @flags: setxattr flags to use when writing the capabilities xattr
> > > + *
> > > + * This function writes the supplied filesystem capabilities to the dentry.
> > > + *
> > > + * Return: 0 on success, a negative errno on error.
> > > + */
> > > +int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> > > +		   const struct vfs_caps *caps, int flags)
> > > +{
> > > +	struct inode *inode = d_inode(dentry);
> > > +	struct inode *delegated_inode = NULL;
> > > +	struct vfs_ns_cap_data nscaps;
> > > +	int size, error;
> > > +
> > > +	/*
> > > +	 * Unfortunately EVM wants to have the raw xattr value to compare to
> > > +	 * the on-disk version, so we need to pass the raw xattr to the
> > > +	 * security hooks. But we also want to do security checks before
> > > +	 * breaking leases, so that means a conversion to the raw xattr here
> > > +	 * which will usually be reduntant with the conversion we do for
> > > +	 * writing the xattr to disk.
> > > +	 */
> > > +	size = vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps,
> > > +				 sizeof(nscaps));
> > > +	if (size < 0)
> > > +		return size;
> > 
> > Oh right, I remember that. Slight eyeroll. See below though...
> > 
> > > +
> > > +retry_deleg:
> > > +	inode_lock(inode);
> > > +
> > > +	error = xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRITE);
> > > +	if (error)
> > > +		goto out_inode_unlock;
> > > +	error = security_inode_setxattr(idmap, dentry, XATTR_NAME_CAPS, &nscaps,
> > > +					size, flags);
> > > +	if (error)
> > > +		goto out_inode_unlock;
> > 
> > For posix acls I added dedicated security hooks that take the struct
> > posix_acl stuff and then plumb that down into the security modules. You
> > could do the same thing here and then just force EVM and others to do
> > their own conversion from in-kernel to xattr format, instead of forcing
> > the VFS to do this.
> > 
> > Because right now we make everyone pay the price all the time when
> > really EVM should pay that price and this whole unpleasantness.
> 
> Good point, I'll do that.

I've been reconsidering various approaches here. One thing I noticed is
that for the non-generic case (iow overlayfs) I missed calling
security_inode_post_setxattr(), where EVM also wants the raw xattr, so
that would require another conversion. That got me wondering whether the
setxattr security hooks really matter when writing fscaps to overlayfs.
And it seems like they might not: the LSMs only look for their own
xattrs, and IMA doesn't do anything with fscaps xattrs. EVM does, but
what it does for a xattr write to an overlayfs indoe seems at least
partially if not completely redundant with what it will do when the
xattr is written to the upper filesystem.

So could we push these security calls down to the generic fscaps
implementations just before/after writing the raw xattr data and just
skip them for overlayfs? If so we can get away with doing the vfs_caps
to xattr conversion only once.

The trade offs are that filesystems which implement fscaps inode
operations become responsible for calling the security hooks if needed,
and if something changes such that we need to call those security hooks
for fscaps on overlayfs this solution would no longer work.
