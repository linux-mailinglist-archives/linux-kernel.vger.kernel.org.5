Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD757D1177
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377527AbjJTOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377477AbjJTOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:22:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B998AD52;
        Fri, 20 Oct 2023 07:22:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B231C433C7;
        Fri, 20 Oct 2023 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697811777;
        bh=8UjVHIG4pHIzf6WnY8xNDmsWFhbzt0q7zzNVbYQt34w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djB+zb9L+53nV76+X/jaRZ1crfQvUPWje3uBQ/SrTXVat4NRJ0uOINVVpGVmH7FOz
         b5p1TJvVz4aMzWyyIMHwCp75/sUVC/q51WZykYuU99mt0spXwMRTrWEsGwGHtTiOZd
         TghHscFG3QzS3pucUGl6OLi2RuCxpAXYI30ZhRzw=
Date:   Fri, 20 Oct 2023 16:22:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 6.1.58
Message-ID: <2023102016-wanted-trash-a8c8@gregkh>
References: <2023101518-subscript-entity-be71@gregkh>
 <169778656748.20306.1670865069010793541@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169778656748.20306.1670865069010793541@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:22:47PM +1100, NeilBrown wrote:
> On Mon, 16 Oct 2023, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 6.1.58 kernel.
> > 
> > All users of the 6.1 kernel series must upgrade.
> > 
> > The updated 6.1.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------
> > 
> >  Makefile                 |    2 
> >  fs/nfs/direct.c          |  134 ++++++++++++++---------------------------------
> >  fs/nfs/write.c           |   23 +++-----
> >  include/linux/nfs_page.h |    4 -
> >  lib/test_meminit.c       |    2 
> >  5 files changed, 55 insertions(+), 110 deletions(-)
> > 
> > Greg Kroah-Hartman (7):
> >       Revert "NFS: More fixes for nfs_direct_write_reschedule_io()"
> >       Revert "NFS: Use the correct commit info in nfs_join_page_group()"
> >       Revert "NFS: More O_DIRECT accounting fixes for error paths"
> >       Revert "NFS: Fix O_DIRECT locking issues"
> >       Revert "NFS: Fix error handling for O_DIRECT write scheduling"
> 
> FYI the problem with these NFS patch is now described in comment #4 of
> https://bugzilla.kernel.org/show_bug.cgi?id=217999
> which I include below.  They can be reapplied if the "Fix error
> handling..." patch is fixed up as described.
> 
> NeilBrown
> 
> FYI the cause of this corruption is that the  backport of
>    NFS: Fix error handling for O_DIRECT write scheduling
> 
> had an error.
> The backported patch f16fd0b11f0f4d41846b5102b1656ea1fc9ac7a0
> moves "pos += req_len" in nfs_direct_write_schedule_iovec() from after
>     req->wb_index = pos >> PAGE_SHIFT;
> to before that statement.  This ->wb_index is wrong.
> Possibly a better way to look at this is the use of "pos" is moved to *after* it is updated.
> 
> The upstream patch 954998b60caa8f2a3bf3abe490de6f08d283687a
> doesn't move the use of pos because
> Commit 70e9db69f927 ("NFS: Clean up O_DIRECT request allocation")
> 
> removes the use.
> 
> v6.1.56 can be fixed with
> 
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 5a976fa343df..69134e11e7d0 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -864,6 +864,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>                                 result = PTR_ERR(req);
>                                 break;
>                         }
> +                       req->wb_index = pos >> PAGE_SHIFT;
> +                       req->wb_offset = pos & ~PAGE_MASK;
>  
>                         if (desc.pg_error < 0) {
>                                 nfs_free_request(req);
> @@ -883,8 +885,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
>                         }
>  
>                         nfs_lock_request(req);
> -                       req->wb_index = pos >> PAGE_SHIFT;
> -                       req->wb_offset = pos & ~PAGE_MASK;
>                         if (nfs_pageio_add_request(&desc, req))
>                                 continue;

Nice, thanks for digging into this.  I think I'll leave this be for now,
until someone submits a fully backported, and tested, series that they
are willing to say actually works :)

thanks,

greg k-h
