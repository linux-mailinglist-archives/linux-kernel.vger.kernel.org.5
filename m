Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894747D886A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjJZSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjJZSfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 14:35:48 -0400
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CD11BE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:35:45 -0700 (PDT)
Date:   Thu, 26 Oct 2023 14:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698345343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UuVoNTYhbITUfFOGLvMFeLczeQvlcN8jPRyBtSles1Q=;
        b=fQEEVZqFoU8NZaXy/Q3Sb10MB7uODDWX3ry14+4fQtoxLJwdxRRTitEP3k6UZcFjmEFkWY
        bnx53winRLGLAP+SlZpKKuKvyQjErJNFq2GJXwmulVumv7hY80LK6bzEAvInp/R/GntvH3
        OXKYODWHDU7+lWX7e1uxxUS7EFULJIY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Christian Brauner <brauner@kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 bcachefs tree
Message-ID: <20231026183539.cffe6uljmnjgacxq@moria.home.lan>
References: <20231026100157.735d7dee@canb.auug.org.au>
 <CAOQ4uxjmRena4AB3yMQhBJ58c6DRtkDJJrnTgFe=gWsadSdbQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjmRena4AB3yMQhBJ58c6DRtkDJJrnTgFe=gWsadSdbQw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 08:16:14AM +0300, Amir Goldstein wrote:
> On Thu, Oct 26, 2023 at 2:02 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > Today's linux-next merge of the vfs-brauner tree got a conflict in:
> >
> >   include/linux/exportfs.h
> >
> > between commit:
> >
> >   85e95ca7cc48 ("bcachefs: Update export_operations for snapshots")
> >
> > from the bcachefs tree and commit:
> >
> >   2560fa66d2ac ("exportfs: define FILEID_INO64_GEN* file handle types")
> >
> > from the vfs-brauner tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> 
> [adding exportfs maintainers]
> 
> >
> > diff --cc include/linux/exportfs.h
> > index be9900cc8786,21bae8bfeef1..000000000000
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@@ -98,12 -98,17 +98,23 @@@ enum fid_type
> >          */
> >         FILEID_FAT_WITH_PARENT = 0x72,
> >
> >  +      /*
> >  +       * 64 bit inode number, 32 bit subvolume, 32 bit generation number:
> >  +       */
> >  +      FILEID_BCACHEFS_WITHOUT_PARENT = 0x80,
> >  +      FILEID_BCACHEFS_WITH_PARENT = 0x81,
> >  +
> > +       /*
> > +        * 64 bit inode number, 32 bit generation number.
> > +        */
> >  -      FILEID_INO64_GEN = 0x81,
> > ++      FILEID_INO64_GEN = 0x82,
> > +
> > +       /*
> > +        * 64 bit inode number, 32 bit generation number,
> > +        * 64 bit parent inode number, 32 bit parent generation.
> > +        */
> >  -      FILEID_INO64_GEN_PARENT = 0x82,
> > ++      FILEID_INO64_GEN_PARENT = 0x83,
> > +
> 
> This is wrong.
> Those are filesystem defined constants.
> Please don't change them.
> 
> 0x81/0x82 have been used by xfs and fuse for years,
> even though neither defined a constant in this enum so far.

Perhaps we could get that fixed...?

> Conflicting with FILEID_BCACHEFS_WITH_PARENT is not
> a serious issue, but I encourage Kent to pick different constants
> for bcachefs or keep the bcachefs constants out of this enum.

Happy to do so. Since it seems this enum doesn't have all the constants
I'd need to avoid conflicting with, I might need some help here :)

> It is a slight inconvenience for users that have bcachefs exported
> to NFS clients and upgrade their server, but maybe that is acceptable.
> In overlayfs, we encoded type OVL_FILEID_V0 and switched to encoding
> type OVL_FILEID_V1, but we still accept decoding of both types, neither
> of which are listed in this enum BTW.
> 
> Adding fid types to this enum is not required.
> This enum is a place to standardize and for different fs to share the same
> fid type/encoding as is the case with  FILEID_INO{32,64}_GEN*.
> IMO, the bcachefs constant do not follow the convention in this
> enum and their format is unlikely to be used by other fs, so
> they should not be added to this enum at all.

Eh?

Most of the constants here appear to be completely filesystem specific -
I see UDF, nilfs, btrfs, fat...

And since you also don't want conflicts with fid_types that aren't
defined here, it seems like they really should all be here.
