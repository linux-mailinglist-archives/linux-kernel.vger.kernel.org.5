Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F97E0FB0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjKDNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDNQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:16:58 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EECE194
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699103813;
        bh=u0qeXEEOdwc8vPkT1WlKQFA0UcoAyRJbJYXcMqHSGT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4QTOorshB3i8vekuVrzyZr81UV534ymfN6qwAo83A181YnK2onhXDNue2X9TOuae
         V9VSiuld6IT73X19WzF5JXItOmrOMGCUgo7WLw/Z8AfRcjaWTPCLgaeZypZpSRd/6K
         s1eWwYneUJvxFU7L/yw0w0iyppHfVbSVXMBw3gLY=
Date:   Sat, 4 Nov 2023 14:16:53 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>, Willy Tarreau <w@1wt.eu>,
        Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH RFC] misc/pvpanic: add support for normal shutdowns
Message-ID: <365bbe1f-5ee8-40fe-bec0-53d9e7395c18@t-8ch.de>
References: <20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net>
 <2023110407-unselect-uptight-b96d@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023110407-unselect-uptight-b96d@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-04 14:05:02+0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 04, 2023 at 12:29:30PM +0100, Thomas Weißschuh wrote:
> > Shutdown requests are normally hardware dependent.
> > By extending pvpanic to also handle shutdown requests, guests can
> > submit such requests with an easily implementable and cross-platform
> > mechanism.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > The corresponding patch to qemu has also been submitted[0].
> > General discussions about the feature should happen on the other thread.
> > 
> > [0] https://lore.kernel.org/qemu-devel/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de/
> > ---
> >  drivers/misc/pvpanic/pvpanic.c | 19 +++++++++++++++++--
> >  include/uapi/misc/pvpanic.h    |  1 +
> >  2 files changed, 18 insertions(+), 2 deletions(-)

[..]

> > diff --git a/include/uapi/misc/pvpanic.h b/include/uapi/misc/pvpanic.h
> > index 54b7485390d3..82fc618bfbcf 100644
> > --- a/include/uapi/misc/pvpanic.h
> > +++ b/include/uapi/misc/pvpanic.h
> > @@ -5,5 +5,6 @@
> >  
> >  #define PVPANIC_PANICKED	(1 << 0)
> >  #define PVPANIC_CRASH_LOADED	(1 << 1)
> > +#define PVPANIC_SHUTDOWN	(1 << 2)
> 
> Why are these in a uapi file?

They are ABI between qemu and its guest.
The specification for these values is part of qemu but for some reason
the header is part of Linux which is then imported back into qemu.

I guess this has historical reasons, maybe because qemu doesn't really
ship ABI headers and for Linux it's natural.
The real reason probably doesn't matter today as the header propably
can't be dropped from Linux anyways for compatibility reasons.

> And if they need to be here, why not use the proper BIT() macro for it?

This was for uniformity with the existing code.
I can send a (standalone?) patch to fix it up.


Thomas
