Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2D7D89BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjJZUhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:37:41 -0400
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA849C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:37:39 -0700 (PDT)
Date:   Thu, 26 Oct 2023 16:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698352657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oyhZVjlMWkkyoVP699SWE02EC5AkW5qcR3B/BUBJ1qQ=;
        b=D0Rv4CNf8DR4kNKhKpuVgTpGsqxiWUItieCxJPeA8Y2fgX79JpCJv9ZsJ0+g//ssDkeJ1r
        fcznY6fz6G+cZPuEx2+NDBrNniG35AcABKpqRRxRlZangwOxWkNXseAkKCOfbRQZ5t20eD
        IOSmHBQrhiapJNO3WF0aw15WecH7f+8=
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
Message-ID: <20231026203733.fx65mjyic4pka3e5@moria.home.lan>
References: <20231026100157.735d7dee@canb.auug.org.au>
 <CAOQ4uxjmRena4AB3yMQhBJ58c6DRtkDJJrnTgFe=gWsadSdbQw@mail.gmail.com>
 <20231026183539.cffe6uljmnjgacxq@moria.home.lan>
 <CAOQ4uxhNDADk9CgSMxKc93qunDUD17AFaA+tuSni9AOsjkfPYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhNDADk9CgSMxKc93qunDUD17AFaA+tuSni9AOsjkfPYw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:34:18PM +0300, Amir Goldstein wrote:
> On Thu, Oct 26, 2023 at 9:35 PM Kent Overstreet
> > > This is wrong.
> > > Those are filesystem defined constants.
> > > Please don't change them.
> > >
> > > 0x81/0x82 have been used by xfs and fuse for years,
> > > even though neither defined a constant in this enum so far.
> >
> > Perhaps we could get that fixed...?
> 
> commit 2560fa66d2ac ("exportfs: define FILEID_INO64_GEN*
> file handle types") fixes that for fuse.
> I may fix up xfs to use these constants later.

Wonderful

> > > Conflicting with FILEID_BCACHEFS_WITH_PARENT is not
> > > a serious issue, but I encourage Kent to pick different constants
> > > for bcachefs or keep the bcachefs constants out of this enum.
> >
> > Happy to do so. Since it seems this enum doesn't have all the constants
> > I'd need to avoid conflicting with, I might need some help here :)
> >
> 
> Technically, you don't *need* to avoid conflicting with fileid types
> of other filesystems and you do not *need* to define your constant
> in this enum. It serves no real purpose unless your constant
> declares a fileid format that other filesystems also use.
> 
> See the comment at the top of the enum.
> 
> > > It is a slight inconvenience for users that have bcachefs exported
> > > to NFS clients and upgrade their server, but maybe that is acceptable.
> > > In overlayfs, we encoded type OVL_FILEID_V0 and switched to encoding
> > > type OVL_FILEID_V1, but we still accept decoding of both types, neither
> > > of which are listed in this enum BTW.
> > >
> > > Adding fid types to this enum is not required.
> > > This enum is a place to standardize and for different fs to share the same
> > > fid type/encoding as is the case with  FILEID_INO{32,64}_GEN*.
> > > IMO, the bcachefs constant do not follow the convention in this
> > > enum and their format is unlikely to be used by other fs, so
> > > they should not be added to this enum at all.
> >
> > Eh?
> >
> > Most of the constants here appear to be completely filesystem specific -
> > I see UDF, nilfs, btrfs, fat...
> >
> 
> There is no good reason for those to be in the enum either
> other than documentation.

Well, clearly not: since the cause of this whole thread was conflicts
with constants that were /not/ previously in this enum.

> 
> > And since you also don't want conflicts with fid_types that aren't
> > defined here, it seems like they really should all be here.
> 
> If you define your constants internally in bcachefs, I don't care
> about conflicts, but if I were you, I would avoid conflicts with
> the known types.
> 
> If you want to define your constants in this enum please choose
> any vacant 0x?{1,2} values. 0xb{1,2}?

That'll do, I'll patch accordingly.
