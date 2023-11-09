Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E987E7413
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjKIWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjKIWA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:00:29 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8823AA8;
        Thu,  9 Nov 2023 14:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=anOQMVnXqS6edVU03GrtNGZXocRurD23acE+4byDQFc=; b=f/2dDbTny8+5mpl75c8Si55DgJ
        fj+fswouCubQqu0i9Cjo/nIQsO7tQZg4swOBurZrNtwKyHYmY6IuYR8cRNkrFAwMq5zILlsPjtY/+
        0L/34MdAwo5oFJh8SJFS8tfLb+AzLCpGkjhMZCQqZnyFMYdxykGxC2kf2LN08lG9alnD/T2i0vYoJ
        wC4GrorkAOv3mHlIWdsSrWspHJzqaBlnOUDpnyR9Wvl2jlh6zmIH3yTRFUIK+4LI2zmOrTiZyyQ54
        brszdVTQdt9pYYs172igF1AEXQdadgWZNniObxSe2UNiFYFE19T7oQVUn7U/7iTBYInRq5X67mXUr
        TbAQEiyQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r1D4U-00DbMG-1V;
        Thu, 09 Nov 2023 22:00:18 +0000
Date:   Thu, 9 Nov 2023 22:00:18 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>,
        Abhi Das <adas@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: RESOLVE_CACHED final path component fix
Message-ID: <20231109220018.GI1957730@ZenIV>
References: <20231109190844.2044940-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109190844.2044940-1-agruenba@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 08:08:44PM +0100, Andreas Gruenbacher wrote:
> Jens,
> 
> since your commit 99668f618062, applications can request cached lookups
> with the RESOLVE_CACHED openat2() flag.  When adding support for that in
> gfs2, we found that this causes the ->permission inode operation to be
> called with the MAY_NOT_BLOCK flag set for directories along the path,
> which is good, but the ->permission check on the final path component is
> missing that flag.  The filesystem will then sleep when it needs to read
> in the ACL, for example.
> 
> This doesn't look like the intended RESOLVE_CACHED behavior.
> 
> The file permission checks in path_openat() happen as follows:
> 
> (1) link_path_walk() -> may_lookup() -> inode_permission() is called for
> each but the final path component. If the LOOKUP_RCU nameidata flag is
> set, may_lookup() passes the MAY_NOT_BLOCK flag on to
> inode_permission(), which passes it on to the permission inode
> operation.
> 
> (2) do_open() -> may_open() -> inode_permission() is called for the
> final path component. The MAY_* flags passed to inode_permission() are
> computed by build_open_flags(), outside of do_open(), and passed down
> from there. The MAY_NOT_BLOCK flag doesn't get set.
> 
> I think we can fix this in build_open_flags(), by setting the
> MAY_NOT_BLOCK flag when a RESOLVE_CACHED lookup is requested, right
> where RESOLVE_CACHED is mapped to LOOKUP_CACHED as well.

No.  This will expose ->permission() instances to previously impossible
cases of MAY_NOT_BLOCK lookups, and we already have enough trouble
in that area.  See RCU pathwalk patches I posted last cycle; I'm
planning to rebase what still needs to be rebased and feed the
fixes into mainline, but that won't happen until the end of this
week *AND* ->permission()-related part of code audit will need
to be repeated and extended.

Until then - no, with the side of fuck, no.
