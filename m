Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940B67BC70B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjJGLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343812AbjJGLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:18:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B22CB6
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:18:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6178AC433C8;
        Sat,  7 Oct 2023 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696677534;
        bh=9lhl/Io5D9c5aOL11kV7r2LcfNh3+FYtUhr05ScLEqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fXQevo416IGR/tBe40pbdCAluOz50c6NVvZfl6Mar7STFV4B8WQ7sEEXOPOy5FH+A
         jaTol9RhaZjwvnJbmbqMYs6Em4/tybefmplmNi+5lL897GuW4TjlziaLsohvDKyXOJ
         n359PKwtc+dQBBBuoTvTF7luDzLLMu08ljDoBzyg=
Date:   Sat, 7 Oct 2023 13:18:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     gregkh@google.com, cmllamas@google.com, surenb@google.com,
        arve@android.com, joel@joelfernandes.org, brauner@kernel.org,
        tkjos@android.com, maco@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binder: add mutex_lock for mmap and NULL when free
Message-ID: <2023100725-oversized-shore-c873@gregkh>
References: <20231007034046.2352124-1-quic_yingangl@quicinc.com>
 <2023100715-blade-valiant-714d@gregkh>
 <26988068-8c9f-8591-db6e-44c8105af638@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26988068-8c9f-8591-db6e-44c8105af638@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 07:07:40PM +0800, Kassey Li wrote:
> 
> 
> On 2023/10/7 14:44, Greg KH wrote:
> > On Sat, Oct 07, 2023 at 11:40:46AM +0800, Kassey Li wrote:
> > > Enforce alloc->mutex in binder_alloc_mmap_handler when add
> > > the entry to list.
> > > 
> > > Assign the freed pages/page_ptr to NULL to catch possible
> > > use after free with NULL pointer access.
> > > 
> > > Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> > > ---
> > >   drivers/android/binder_alloc.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > What commit id does this fix?
> 
>   there is no specific commit id this change going to fix.
> 
>   it is a follow up for commit
> 	19c987241ca1216a51118b2bd0185b8bc5081783  binder: separate out binder_alloc
> functions (mutex lock added for list access in alloc/free)
> 	f2517eb76f1f2f7f89761f9db2b202e89931738c  android: binder: Add global lru
> shrinker to binder (set page->page_ptr = NULL;)
> 
>   the background to raise this change that we are easy hit below crash in
> monkey test:
> 
> where a wrong end is passing to
> binder_update_page_range, thus calculate a weird index
> for
>   page = &alloc->pages[index]

Obviously it is a fix for some commit, please list that here.

thanks,

greg k-h
