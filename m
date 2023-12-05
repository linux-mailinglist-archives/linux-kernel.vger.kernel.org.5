Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F003B80537B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347060AbjLELug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347041AbjLELu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:50:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49AAD7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:50:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414B1C433C8;
        Tue,  5 Dec 2023 11:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701777034;
        bh=1vi7lpWvyIlRPEOS8id0JlbcXrkUDYmCKkyVbkLEO/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m3r7E0Ft/sNzRLXx9KPMN7wMK8H8PLP4BMf4GbJ85C0HONRDECADPNUDARiPaxc9J
         9xmUAysv2FKUw4XeM/ClU/Y8ooaDZxUFAnzPn8c/w1s/gbXMDZmWWnIeP824av6jyb
         AwW5ZLSKUow+R8KxgaBbbmYTJw8Vp9gLcJYg/v6I9XmArk3eooyu7Wn0B7lIKw33GM
         shZiD1i8sf8dLaSUExtpjIcrnSrIrrl17uN7+qP40f+Y0Hr+vaJVqKjzWb7hg0FtHW
         3mr1JsR2rqGHtfmtEjLIlAh4vKrVsYfBiHy6mCQkU2iKv0h0TPLsax/oq/DdQSjB8I
         1mys7ZBCphkmQ==
Date:   Tue, 5 Dec 2023 12:50:28 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
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
Message-ID: <20231205-frettchen-weltoffen-16e63df530a7@brauner>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
 <20231201-drohnen-ausverkauf-61e5c94364ca@brauner>
 <ZWoaGU6xpF3S793+@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWoaGU6xpF3S793+@do-x1extreme>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 11:38:33AM -0600, Seth Forshee (DigitalOcean) wrote:
> On Fri, Dec 01, 2023 at 06:02:55PM +0100, Christian Brauner wrote:
> > On Wed, Nov 29, 2023 at 03:50:25PM -0600, Seth Forshee (DigitalOcean) wrote:
> > > Add inode operations for getting, setting and removing filesystem
> > > capabilities rather than passing around raw xattr data. This provides
> > > better type safety for ids contained within xattrs.
> > > 
> > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > ---
> > >  include/linux/fs.h | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 98b7a7a8c42e..a0a77f67b999 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2002,6 +2002,11 @@ struct inode_operations {
> > >  				     int);
> > >  	int (*set_acl)(struct mnt_idmap *, struct dentry *,
> > >  		       struct posix_acl *, int);
> > > +	int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> > > +			  struct vfs_caps *);
> > > +	int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> > > +			  const struct vfs_caps *, int flags);
> > 
> > If it's really a flags argument, then unsigned int, please,
> 
> This is the flags for setxattr, which is an int everywhere. Or almost

Ah right. Ugh, we should clean that up but not necessarily in this
series.
