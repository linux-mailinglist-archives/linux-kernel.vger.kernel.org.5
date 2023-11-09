Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36FB7E7438
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjKIWLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjKIWLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:11:48 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F79E1FF6;
        Thu,  9 Nov 2023 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tRJ5cgcgY6rhfYTgPiiME6UbrPY/sU/021bhi9QLbcw=; b=JPjB1VgrnFh7mHgnK2Dquut/cc
        iQY/Jt7D1UBinDdZ+SALNeDAbdzIx/WzHAZF+r7wc6FGQABqyugVQj02q+bOuTlpNEGTegeidRqzN
        tR0CC4+68Wb5cKcrSQjznFZu1YmM+o4sF3DI3ZWhHjeaZzDJh8M3VXJg0zrTV0DlB8KL/76A6EA4m
        0cOOqDJgUPqHiIzt4iAXb5bbAxEwm2a1dDAs+/6ub+CAZ/pDfy9Sp3lsnA8F9Ybihr74rkUncxQbW
        XFOK2d2Le7WhNuezl8cwhRsbSS/6+YfwWsBtIDMM1gHAjkOO0gEqaYZetqYfK2fk2XuaV3qfPeVZQ
        IHRzwBzw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r1DFU-00Dbab-0h;
        Thu, 09 Nov 2023 22:11:40 +0000
Date:   Thu, 9 Nov 2023 22:11:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Abhi Das <adas@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
Message-ID: <20231109221140.GJ1957730@ZenIV>
References: <20231109190844.2044940-1-agruenba@redhat.com>
 <20231109220018.GI1957730@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109220018.GI1957730@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:00:18PM +0000, Al Viro wrote:
> On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> > Jens,
> > 
> > since your commit 99668f618062, applications can request cached lookups
> > with the RESOLVE_CACHED openat2() flag.  When adding support for that in
> > gfs2, we found that this causes the ->permission inode operation to be
> > called with the MAY_NOT_BLOCK flag set for directories along the path,
> > which is good, but the ->permission check on the final path component is
> > missing that flag.  The filesystem will then sleep when it needs to read
> > in the ACL, for example.
> > 
> > This doesn't look like the intended RESOLVE_CACHED behavior.
> > 
> > The file permission checks in path_openat() happen as follows:
> > 
> > (1) link_path_walk() -> may_lookup() -> inode_permission() is called for
> > each but the final path component. If the LOOKUP_RCU nameidata flag is
> > set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> > inode_permission(), which passes it on to the permission inode
> > operation.
> > 
> > (2) do_open() -> may_open() -> inode_permission() is called for the
> > final path component. The MAY_* flags passed to inode_permission() are
> > computed by build_open_flags(), outside of do_open(), and passed down
> > from there. The MAY_NOT_BLOCK flag doesn't get set.
> > 
> > I think we can fix this in build_open_flags(), by setting the
> > MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> > where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.
> 
> No.  This will expose ->permission() instances to previously impossible
> cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
> in that area.  See RCU pathwalk patches I posted last cycle; I'm
> planning to rebase what still needs to be rebased and feed the
> fixes into mainline, but that won't happen until the end of this
> week *AND* ->permission()-related part of code audit will need
> to be repeated and extended.
> 
> Until then - no, with the side of fuck, no.

Note that it's not just "->permission() might get called in RCU mode with
combination of flags it never had seen before"; it actually would be
called with MAY_NOT_BLOCK and without rcu_read_lock() held.

Which means that it can't make the usual assumptions about the objects
not getting freed under it in such mode.  Sure, the inode itself is
pinned in your new case, but anything that goes
	if !MAY_NOT_BLOCK
		grab a spinlock
		grab a reference to X from inode
		drop spinlock
		use X, it's pinned down
		drop a reference to X
	else
		READ_ONCE the reference to X
		use X, its freeing is RCU-delayed
would get screwed.  And that would need to be audited for all instances
of ->permission() in the tree, along with all weird shit they might be
pulling off.
