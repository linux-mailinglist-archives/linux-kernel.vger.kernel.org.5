Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF267FF3B0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346318AbjK3Pgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjK3Pgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:36:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208E10C2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:36:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED53FC433C7;
        Thu, 30 Nov 2023 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701358597;
        bh=IuyTo/SqtMXTfOfDJB4gGYsTQYZhhJVyRktybDYXRIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/ylpSyc9vHCYJYK+PI9TH6o4AxCANtjq/SDm3RtWDQZJMymqlXqGtI6x1aMB+nXo
         WN96cL2pW6gCjBvM5V2Yu39UXl85WEQo4uCLYALsmBBONAdr0uIFrzGRwF7FY/bZYd
         RqjrYpP7XHCKvQWSOBmZTNIvnWaJrYPCRQwoNNgumOsi4UYuuXlWjfYGeuvdiJO+Lu
         /Ft+F55LVl7YM+uIRFL/tDCuvDTf9i9etnhDGU7AmnVlqZkPidlAIkCWGqdYacdaAK
         RO7YwB9+n7gRsChyBLHoRDaxmG3BhCPwiseVd1svwlCmEzsKiCg3LxWrE7Yq0SsHAI
         huqcdUxGNgbRQ==
Date:   Thu, 30 Nov 2023 09:36:35 -0600
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
Subject: Re: [PATCH 07/16] fs: add inode operations to get/set/remove fscaps
Message-ID: <ZWisA4miKciDEhE6@do-x1extreme>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
 <20231129-idmap-fscap-refactor-v1-7-da5a26058a5b@kernel.org>
 <CAOQ4uxiz+ng5qEY4qkE_q8Gv3jrd6b7mZnppkDoJthhD+Ud4Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiz+ng5qEY4qkE_q8Gv3jrd6b7mZnppkDoJthhD+Ud4Ow@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 07:32:19AM +0200, Amir Goldstein wrote:
> On Wed, Nov 29, 2023 at 11:51 PM Seth Forshee (DigitalOcean)
> <sforshee@kernel.org> wrote:
> >
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
> >                                      int);
> >         int (*set_acl)(struct mnt_idmap *, struct dentry *,
> >                        struct posix_acl *, int);
> > +       int (*get_fscaps)(struct mnt_idmap *, struct dentry *,
> > +                         struct vfs_caps *);
> > +       int (*set_fscaps)(struct mnt_idmap *, struct dentry *,
> > +                         const struct vfs_caps *, int flags);
> > +       int (*remove_fscaps)(struct mnt_idmap *, struct dentry *);
> >         int (*fileattr_set)(struct mnt_idmap *idmap,
> >                             struct dentry *dentry, struct fileattr *fa);
> >         int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
> >
> 
> Please document in Documentation/filesystems/{vfs,locking}.rst

Done for v2.
