Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241E1757886
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjGRJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGRJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:54:09 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AB21FC6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=bLG3Hj/avYD20zcuWTTF4BBDPz5pcBq1H1Srh8DnyRo=; b=mEBUDxLV+mRH37IuwGieU9tBF4
        0iY8NsX3ZO46Y5PkkAyXDmb+cqHOBqKst3QCtnqQWQ80nL1mY/xDsoMXyUvw5NxZ0nXCcABuN+snO
        7lVhAo/3/n7+6Xy3wlRg4yfgtWYb0zD2Oo5mEJwiJO69QrPbpIfU303kk6KdfhNfAMmhHRiRccd/r
        d81vULpFHnJE15VXRpYDZfCKAVhjlm8QdZaqbHO32gQujQwG+ycl4SL9SkKcsVkOTP9H+HcUIWce0
        wCIZGjRG+FQe63p6wJnUizVhTgMRyfBZbMr5AZLb/2LagIlPocmVBhNrF8TNn44pN0Lx8n6T0twfh
        NirXob45bTD8keIjQcphffHHfjGTZSr1ZN09IXQvo+13dNkKHDSUP1IHLSJVHWDzK1iNOW78tTurM
        I10aLNSHD5MQSGDbosTwh6cH3Ez/oNWbV7e7XOQN3VoD5kkCL9Es8YrQtwjo4vIJnP874Y1LSIxij
        /rDWD+ZGgx1pt3XaZbSiTg623k21l9wNsi5KG5KZ3p5RfMaqox+zEdEqF12TPOU5Anqx6vPQaea+x
        UnyJbY/sov7gSCJgPXdoxRPBKOLuOFsT0Me86w+rD335H2GkNCD1NqiDzBzyz9R/KsOWkk/8bmVok
        Uu15YGzJWLMXu/kK9iuxtTO3kTfKi6XoK6VRKssa4=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Latchesar Ionkov <lucho@ionkov.net>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH 1/3] fs/9p: remove unecessary and overrestrictive check
Date:   Tue, 18 Jul 2023 11:17:16 +0200
Message-ID: <9085752.7RgNvelpzP@silver>
In-Reply-To: <ZLX8xUdCRLYj3cjk@codewreck.org>
References: <20230716-fixes-overly-restrictive-mmap-v1-0-0683b283b932@kernel.org>
 <20230716-fixes-overly-restrictive-mmap-v1-1-0683b283b932@kernel.org>
 <ZLX8xUdCRLYj3cjk@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 18, 2023 4:45:25 AM CEST Dominique Martinet wrote:
> Eric Van Hensbergen wrote on Mon, Jul 17, 2023 at 04:29:00PM +0000:
> > This eliminates a check for shared that was overrestrictive and
> > duplicated a check in generic_file_readonly_mmap.
> 
> generic_file_readonly_mmap checks for VM_SHARED + VM_MAYWRITE,
> so it isn't exactly "duplicating" the check.. But I agree we don't need
> it; we used to have the mmap op be generic_file_readonly_mmap directly
> previously.

It should be removed from the commit log then though.

> I'd argue we don't need to invalidate inode pages either if there is no
> writeback cache, there shouldn't be anything in it? but that can be done
> separately, and extra invalidation won't bring harm anyway.

Unnecessary performance penalty? So I would drop that in a separate patch.

> Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>

Feel free to add my RB as well:

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> > 
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > ---
> >  fs/9p/vfs_file.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> > index 2996fb00387fa..bda3abd6646b8 100644
> > --- a/fs/9p/vfs_file.c
> > +++ b/fs/9p/vfs_file.c
> > @@ -506,8 +506,6 @@ v9fs_file_mmap(struct file *filp, struct vm_area_struct *vma)
> >  
> >  	if (!(v9ses->cache & CACHE_WRITEBACK)) {
> >  		p9_debug(P9_DEBUG_CACHE, "(no mmap mode)");
> > -		if (vma->vm_flags & VM_MAYSHARE)
> > -			return -ENODEV;
> >  		invalidate_inode_pages2(filp->f_mapping);
> >  		return generic_file_readonly_mmap(filp, vma);
> >  	}
> > 
> 
> 




