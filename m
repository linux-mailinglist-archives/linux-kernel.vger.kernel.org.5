Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5D7FF665
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345494AbjK3QlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjK3Qkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:40:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89CA1A3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:40:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BAFC433C8;
        Thu, 30 Nov 2023 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701362458;
        bh=eMauWcpoHiWGcXeCJ6n8laJEDioZTrZnYDww6VNDcD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbewMVwKMEOHbYOQLQybblEflNdQip+Ra5frYeqsZTWZAms2Jc3Y7vZ7VASj5Aur8
         2zcpnKl6VXvVqF/kauQ4Iiz6DQt73jk1dO6H+GoLx3lC2Yt97HLA9T/vmzzP3B+03Q
         kPTyK/7HFP2KvQ4SKG0MDkNX4gmfFGIAyQE7Dz22TIRefJZJ/gc0YSFucBeOaMT/67
         f5ls+Y0y+ImdrcDVR/MACxVOCl3kZppNqPy264LpK0ESvaBOEFvkoIHFv8e7NkdBGk
         ZAAtIELOtR5UTdVF1PVhKL5Y6tVrJ43gmuW9DJ9HJXCC6/5leR2WXKhnvL4nNFn4y2
         C3+wHN3tZckhg==
Date:   Thu, 30 Nov 2023 10:40:57 -0600
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
Subject: Re: [PATCH 16/16] vfs: return -EOPNOTSUPP for fscaps from
 vfs_*xattr()
Message-ID: <ZWi7GZoSId2EA1mR@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-16-da5a26058a5b@kernel.org>
 <CAOQ4uxhtJ89LknKjE=tiTgvZXbufmOaqHnhnrz348Ktq2H+yHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhtJ89LknKjE=tiTgvZXbufmOaqHnhnrz348Ktq2H+yHA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:10:15AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:51 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
> > Now that the new vfs-level interfaces are fully supported and all code
> > has been converted to use them, stop permitting use of the top-level vfs
> > xattr interfaces for capabilities xattrs. Unlike with ACLs we still need
> > to be able to work with fscaps xattrs using lower-level interfaces in a
> > handful of places, so only use of the top-level xattr interfaces is
> > restricted.
> 
> Can you explain why?
> Is there an inherent difference between ACLs and fscaps in that respect
> or is it just a matter of more work that needs to be done?

There are a number of differences. ACLs have caching, require additional
permission checks, and require a lot of filesystem-specific handling.
fscaps are simpler by comparison, and most filesystems can rely on a
common implementation that just converts to/from raw disk xattrs.

So at minimum I think the lowest level interfaces,
__vfs_{get,set,remove}xattr(), need to continue to allow fscaps, and
that's where ACL xattrs are blocked. Allowing some of the others to
still work with them is a matter of convenience (e.g. using
vfs_getxattr_alloc()) and trying to reduce code duplication. But as you
pointed out I did miss at least duplicating fsnotify_xattr(), so I'm
going to have another look at how I implemented these.

> 
> >
> > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > ---
> >  fs/xattr.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/fs/xattr.c b/fs/xattr.c
> > index 372644b15457..4b779779ad8c 100644
> > --- a/fs/xattr.c
> > +++ b/fs/xattr.c
> > @@ -540,6 +540,9 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
> >         const void  *orig_value = value;
> >         int error;
> >
> > +       if (!strcmp(name, XATTR_NAME_CAPS))
> > +               return -EOPNOTSUPP;
> > +
> 
> It this is really not expected, then it should be an assert and
> please use an inline helper like is_posix_acl_xattr():
> 
> if (WARN_ON_ONCE(is_fscaps_xattr(name)))

Ack, makes sense.
