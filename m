Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E0D7E7453
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKIWXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIWXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:23:02 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A141FF6;
        Thu,  9 Nov 2023 14:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=/1aAAOfZoPJB+SIcZK8uAuu2vTpGQEKR3GjqFdj1Lfs=; b=WXL5BfFZTfyzIdYpq/yJHYDjLS
        cNb3Gu55uygBewH4u7fSvpIgn+vEjUIXHjSGlYnS+4KDXXW1Z4DIBgI3ybRYD5G7vrYY7cuQBhWEo
        E5wXD1U2N8mO1hDl0WTRlbEENenNjHd07GB64kiQ9gsMAWF4AD060v5PfYwzGtKvVlbHkcOfNYnip
        UJsODITYXv7zR9lPdCzmqSJHomeCZ9G8t4T7hVtiCpLeI1vdMe/0+y4zkAdrS+30Ge8mTTUg7V3rc
        jMirK0Ug+n+t8D5h+/Bac4N6RcmgFOmFxYu8EPD12zK9e4Og9Sz5CmuPfE+JBxupbLduQSr9JSyml
        TiY7S0gg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r1DQM-00DboO-2u;
        Thu, 09 Nov 2023 22:22:55 +0000
Date:   Thu, 9 Nov 2023 22:22:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas =?iso-8859-1?Q?Gr=FCnbacher?= 
        <andreas.gruenbacher@gmail.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Abhi Das <adas@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
Message-ID: <20231109222254.GK1957730@ZenIV>
References: <20231109190844.2044940-1-agruenba@redhat.com>
 <20231109220018.GI1957730@ZenIV>
 <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHpGcMJfNNRDAvGhH-1Fs79uTks10XhLXBLeCqABoxufZeLGzw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 11:12:32PM +0100, Andreas Grünbacher wrote:
> Am Do., 9. Nov. 2023 um 23:00 Uhr schrieb Al Viro <viro@zeniv.linux.org.uk>:
> > On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> > > Jens,
> > >
> > > since your commit 99668f618062, applications can request cached lookups
> > > with the RESOLVE_CACHED openat2() flag.  When adding support for that in
> > > gfs2, we found that this causes the ->permission inode operation to be
> > > called with the MAY_NOT_BLOCK flag set for directories along the path,
> > > which is good, but the ->permission check on the final path component is
> > > missing that flag.  The filesystem will then sleep when it needs to read
> > > in the ACL, for example.
> > >
> > > This doesn't look like the intended RESOLVE_CACHED behavior.
> > >
> > > The file permission checks in path_openat() happen as follows:
> > >
> > > (1) link_path_walk() -> may_lookup() -> inode_permission() is called for
> > > each but the final path component. If the LOOKUP_RCU nameidata flag is
> > > set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> > > inode_permission(), which passes it on to the permission inode
> > > operation.
> > >
> > > (2) do_open() -> may_open() -> inode_permission() is called for the
> > > final path component. The MAY_* flags passed to inode_permission() are
> > > computed by build_open_flags(), outside of do_open(), and passed down
> > > from there. The MAY_NOT_BLOCK flag doesn't get set.
> > >
> > > I think we can fix this in build_open_flags(), by setting the
> > > MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> > > where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.
> >
> > No.  This will expose ->permission() instances to previously impossible
> > cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
> > in that area.
> 
> True, lockdep wouldn't be happy.
> 
> >  See RCU pathwalk patches I posted last cycle;
> 
> Do you have a pointer? Thanks.

Thread starting with Message-ID: <20231002022815.GQ800259@ZenIV>
I don't remember if I posted the audit notes into it; I'll get around
to resurrecting that stuff this weekend, when the mainline settles down
enough to bother with that.
