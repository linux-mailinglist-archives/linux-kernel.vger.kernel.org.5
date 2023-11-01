Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84ED7DDA69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376974AbjKAAxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbjKAAxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:53:18 -0400
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D448ED
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 17:53:12 -0700 (PDT)
Date:   Tue, 31 Oct 2023 20:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698799990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9CIT9rgvKDVZdYofh7mLXgEqsY7gMwRBGWwzpZc0RO0=;
        b=DK3LYU0TJTwDjFhz1CZUheGGEFomOodRhckWJH4+4ObVGLr72zZSN1WOO7XwlN2VDFXiKS
        UYiy+2kHQu9ym1tZPJ4f7xesr5ydInjrBRWEFzNNr5NxjHpV+Ma3m4Vs9tSKLUG6rcFYz2
        YGJyxiljj41Q4rfemYPsVxl5thRyjps=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <20231101005307.2udx7kqicf3rba3h@moria.home.lan>
References: <20230912120429.7852428f@canb.auug.org.au>
 <e639a428-0fb7-7329-ce52-e51f7951a146@bytedance.com>
 <20230913093553.4290421e@canb.auug.org.au>
 <ada473e9-aa2f-c6ff-b869-cf94942ddd20@bytedance.com>
 <20230913132330.00b3ef07f696cf9efc4d0886@linux-foundation.org>
 <20230914083145.17c2e7de@canb.auug.org.au>
 <20231101113222.13e7edc2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101113222.13e7edc2@canb.auug.org.au>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:32:22AM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> On Thu, 14 Sep 2023 08:31:45 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Wed, 13 Sep 2023 13:23:30 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Wed, 13 Sep 2023 09:10:11 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > >   
> > > > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > Date: Tue, 12 Sep 2023 11:27:22 +1000
> > > > > Subject: [PATCH] bcachefs: convert to dynamically allocated shrinkers
> > > > > 
> > > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > ---
> > > > >   fs/bcachefs/btree_cache.c     | 22 ++++++++++++----------
> > > > >   fs/bcachefs/btree_key_cache.c | 21 ++++++++++++---------
> > > > >   fs/bcachefs/btree_types.h     |  4 ++--
> > > > >   fs/bcachefs/fs.c              |  2 +-
> > > > >   fs/bcachefs/sysfs.c           |  2 +-
> > > > >   5 files changed, 28 insertions(+), 23 deletions(-)    
> > > > 
> > > > This version looks good to me.
> > > > 
> > > > Reviewed-by: Qi Zheng <zhengqi.arch@bytedance.com>    
> > > 
> > > I not longer carry a post-linux-next patch queue, so there's nothing I
> > > can do with this patch.  I'll assume that either Kent or I will merge
> > > it later, depending upon whose stuff goes into mainline first.  
> > 
> > Actually the correct plan is for you and Kent to inform Linus of the
> > need for this patch as part of the merge resolution when he merges the
> > latter of your trees (unless you want to stabilise the shrinker changes
> > into a separate branch that is never rewritten and is merged into your
> > tree and the bcachefs tree).
> 
> This is now a conflict between the mm-stable tree and Linus' tree.

Is/was there a procedure for me here?
