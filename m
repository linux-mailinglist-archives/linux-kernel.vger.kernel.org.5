Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474018011DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378940AbjLARib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:38:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EA6194
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:38:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733D4C433C8;
        Fri,  1 Dec 2023 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701452315;
        bh=Dz0B5fxn/oqyZ4YCUdxRSHvWd24ECZxBcKDsdAS+OP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8XQxclsI+SfocWX7pLQg4yTcgnoloNmJKFzNin3DuEOugJh6FR9HozYzAHV3NTwh
         +3ZjARg0I6K6FNsw7aF4/04ubGHDL9VORUBV3a5oydbq9Jz6LcqULE6mTTiv2pELXa
         Qi58qBD5KnMEvY+VEffgOPWBYOuSj8TVjtzBi4YZguMJl9PBI2ueUi9rqiqFIgNIiT
         qtn4Z/loHTRwmOgKYcpX7SPoBfgz4E5035z6IMV1rEjT3C0jvvYimsU+eUqEraINyZ
         B2kChFVseZHPmy1CLml9Q0M0DNC/mRetdSHHKQMjdErEtwviYgUDS54kZUsN3VNRvH
         Te6+37vaI5zGw==
Date:   Fri, 1 Dec 2023 11:38:33 -0600
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <ZWoaGU6xpF3S793+@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
 <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 06:02:55PM +0100, Christian Brauner wrote:
> On Wed, Nov 29, 2023 at 03:50:25PM -0600, Seth Forshee (DigitalOcean) wrote:
> > Add inode operations for getting, setting and removing filesystem
> > capabilities rather than passing around raw xattr data. This provides
> > better type safety for ids contained within xattrs.
> > 
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  include/linux/fs.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 98b7a7a8c42e..a0a77f67b999 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2002,6 +2002,11 @@ struct inode_operations {
> >  				     int);
> >  	int (*set_acl)(struct mnt_idmap *, struct dentry *,
> >  		       struct posix_acl *, int);
> > +	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> > +			  struct vfs_caps *);
> > +	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> > +			  const struct vfs_caps *, int flags);
> 
> If it's really a flags argument, then unsigned int, please,

This is the flags for setxattr, which is an int everywhere. Or almost
everywhere; I just noticed that it is actually an unsigned int in struct
xattr_ctx. But for consistency I think it makes sense to have it be an
int here too. Though maybe naming it setxattr_flags would be helpful for
clarity.
