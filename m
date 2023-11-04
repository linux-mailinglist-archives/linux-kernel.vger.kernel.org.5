Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B87E0FBA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjKDN2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:28:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBB1194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:28:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4ECC433C7;
        Sat,  4 Nov 2023 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699104524;
        bh=7kiTv8orfQicg6Mv+6HGJziKmy7PZhj8z0zjpoEJlEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iH+FAJr9h9U+Bu7NYTdquvfW8PUwU2/bkVjgm9jZcOARbGuDVSmk3XPEAQqgEZSeg
         qv91vzHkY4YpaowrX7mfUrUdrSb9EcJFwgLSZCCC4lfetRu5PcvOxwbfl6Y3v8yreX
         0fzJfnytQgvUrgBJMrD4B3myaAs9g0NFUC/EqGTE=
Date:   Sat, 4 Nov 2023 14:28:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <2023110431-pacemaker-pruning-0e4c@gregkh>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
 <365bbe1f-5ee8-40fe-bec0-53d9e7395c18@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <365bbe1f-5ee8-40fe-bec0-53d9e7395c18@t-8ch.de>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 02:16:53PM +0100, Thomas Weiﬂschuh wrote:
> On 2023-11-04 14:05:02+0100, Greg Kroah-Hartman wrote:
> > On Sat, Nov 04, 2023 at 12:29:30PM +0100, Thomas Weiﬂschuh wrote:
> > > Shutdown requests are normally hardware dependent.
> > > By extending pvpanic to also handle shutdown requests, guests can
> > > submit such requests with an easily implementable and cross-platform
> > > mechanism.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > > The corresponding patch to qemu has also been submitted[0].
> > > General discussions about the feature should happen on the other thread.
> > > 
> > > [0] https://lore.kernel.org/qemu-devel/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de/
> > > ---
> > >  drivers/misc/pvpanic/pvpanic.c | 19 +++++++++++++++++--
> > >  include/uapi/misc/pvpanic.h    |  1 +
> > >  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> [..]
> 
> > > diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
> > > index 54b7485390d3..82fc618bfbcf 100644
> > > --- a/include/uapi/misc/pvpanic.h
> > > +++ b/include/uapi/misc/pvpanic.h
> > > @@ -5,5 +5,6 @@
> > >  
> > >  #define PVPANIC_PANICKED	(1 << 0)
> > >  #define PVPANIC_CRASH_LOADED	(1 << 1)
> > > +#define PVPANIC_SHUTDOWN	(1 << 2)
> > 
> > Why are these in a uapi file?
> 
> They are ABI between qemu and its guest.

But there's no interaction between Linux and userspace for these values,
so I would just drop them from here.

> The specification for these values is part of qemu but for some reason
> the header is part of Linux which is then imported back into qemu.
> 
> I guess this has historical reasons, maybe because qemu doesn't really
> ship ABI headers and for Linux it's natural.

That feels odd, are there other in-kernel examples of the Linux uapi
files being abused like this?

> The real reason probably doesn't matter today as the header propably
> can't be dropped from Linux anyways for compatibility reasons.
> 
> > And if they need to be here, why not use the proper BIT() macro for it?
> 
> This was for uniformity with the existing code.
> I can send a (standalone?) patch to fix it up.

If we keep it, sure, that would be nice.  But let's try to drop it if
possible :)

thanks,

greg k-h
