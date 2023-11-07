Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A17E49FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbjKGUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjKGUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:44:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA4310DA;
        Tue,  7 Nov 2023 12:44:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B834C433C8;
        Tue,  7 Nov 2023 20:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699389846;
        bh=OASy8gi5xgHMzsfgaPoo3ATcjRCXUAl+nIxHvRWkQuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFFn0sfLg22L3cB6qaXqcuECNlfdUvekm7LLfiycxw4tR3TaDaD5ShO+GgpJ7Z9bx
         aTWq8iVKstQopL9NO8qoQMdMLmToZZm/kwWuLEJ79ciha226/JsOs4LuXXVOQLwj6Y
         s5CpA4ukQGjZgpBQgRvQby4UaP0ogo6GedPjn3nDtb+vRe8SLmvIVe2+OfbQMrWvN0
         1R40awq0pUSdhSUMDl6gjselEPEPjPzcG1GcqqF9PYVOTDy1uMIDwXHmYw/cm+M93G
         /jKF/zYPK2zSkjnAX7JN6MCUcVyt92nJAT6wdqylTfoU61iHfSP1B2e18XgGZdBtF6
         PTHHlXVKfgKkQ==
Date:   Tue, 7 Nov 2023 12:44:05 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Bill O'Donnell <bodonnel@redhat.com>, chandan.babu@oracle.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] xfs: Remove unused function
Message-ID: <20231107204405.GP1205143@frogsfrogsfrogs>
References: <20231103073040.649-1-jiapeng.chong@linux.alibaba.com>
 <ZUqPdhc4RQxL8TVB@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUqPdhc4RQxL8TVB@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:26:46PM -0600, Bill O'Donnell wrote:
> On Fri, Nov 03, 2023 at 03:30:40PM +0800, Jiapeng Chong wrote:
> > The function are defined in the bitmap.c file, but not called
> > elsewhere, so delete the unused function.
> > 
> > fs/xfs/scrub/bitmap.c:55:1: warning: unused function 'xbitmap_tree_iter_next'.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7137
> > Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> Makes sense.
> Reviewed-by: Bill O'Donnell <bodonnel@redhat.com>

I disagree -- I added redundant forward declarations here so I wouldn't
have to go digging through the 150LOC definition of INTERVAL_TREE_DEFINE
to figure out what helper functions were actually being defined by the
macro.  They'll trigger compiler errors if the definition of
INTERVAL_TREE_DEFINE ever drifts away from my understanding of it at the
time I wrote the code.

--D

> 
> 
> > ---
> >  fs/xfs/scrub/bitmap.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/fs/xfs/scrub/bitmap.c b/fs/xfs/scrub/bitmap.c
> > index e0c89a9a0ca0..ba4b18e40faa 100644
> > --- a/fs/xfs/scrub/bitmap.c
> > +++ b/fs/xfs/scrub/bitmap.c
> > @@ -48,10 +48,6 @@ static inline struct xbitmap_node *
> >  xbitmap_tree_iter_first(struct rb_root_cached *root, uint64_t start,
> >  			uint64_t last);
> >  
> > -static inline struct xbitmap_node *
> > -xbitmap_tree_iter_next(struct xbitmap_node *node, uint64_t start,
> > -		       uint64_t last);
> > -
> >  INTERVAL_TREE_DEFINE(struct xbitmap_node, bn_rbnode, uint64_t,
> >  		__bn_subtree_last, START, LAST, static inline, xbitmap_tree)
> >  
> > -- 
> > 2.20.1.7.g153144c
> > 
> 
