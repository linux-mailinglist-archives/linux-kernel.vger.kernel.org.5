Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB578F0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbjHaPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjHaPzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:55:07 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D6A281A3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 08:54:57 -0700 (PDT)
Received: (qmail 483141 invoked by uid 1000); 31 Aug 2023 11:54:57 -0400
Date:   Thu, 31 Aug 2023 11:54:57 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to extend quirks flags to 64bit?
Message-ID: <6553da2f-455e-4263-a9d9-b6dc64d61e92@rowland.harvard.edu>
References: <f9e8acb5-32d5-4a30-859f-d4336a86b31a@gmail.com>
 <6f8b825b-bc41-4080-8128-4a6f0a43f779@rowland.harvard.edu>
 <34aa2eea-5417-4e46-91a0-aac1a46a84cf@gmail.com>
 <2d580337-eaf3-47fb-afa7-1006d9a257ea@rowland.harvard.edu>
 <c4c48d12-c4ce-4bdc-a3f9-c6020067681b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c48d12-c4ce-4bdc-a3f9-c6020067681b@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:39:07PM +0200, Milan Broz wrote:
> On 8/27/23 20:55, Alan Stern wrote:
> 
> ...
> 
> > > > > Someone will need a new quirks flag in the future anyway... :)
> > > > 
> > > > I can think of only one way to accomplish this on 32-bit systems: Change
> > > > the driver_info field from a bit array to an index into a static table
> > > > of 64-bit flags values.  Each unusual_devs structure would have its own
> > > > entry in this table.  As far as I can tell, the other unusual_*.h tables
> > > > could retain their current driver_info interpretations, since no new
> > > > quirk bits are likely to be relevant to them.
> > > > 
> > > > Making this change would be an awkward nuisance, but it should be
> > > > doable.
> > > 
> > > Hm, yes, thanks for the idea,that is a possible solution.
> > > It will need to modify all unusual macros, though. Just I am not sure I want
> > > to spent time patching all the drivers as I have not way how to test it.
> > 
> > I don't think it will be necessary to change all those macros, just the
> > ones in usual_tables.c.  And to create the new table containing the
> > actual flag values, of course.
> > 
> > There will also have to be a new argument to usb_stor_probe1()
> > specifying whether the id->driver_info field is standard (i.e., it
> > contains the flags directly) or is one of the new indirect index values.
> > 
> > And you'll have to figure out a comparable change to the dynamic device
> > ID table mechanism.
> > 
> > (If you want to be really fancy about it, you could design things in
> > such a way that the indirect flags approach is used only on 32-bit
> > systems.  64-bit systems can put the new flag bits directly into the
> > driver_info field.  However, it's probably best not to worry about this
> > initially.)
> 
> Hi Alan,
> 
> So, I really tried this approach, spent more time on in than I expected, but
> produced working code... that I am really not proud of :-]
> (Thus avoiding to send it here, for now.)
> 
> I pushed it to my dm-cryptsetup branch here
> https://git.kernel.org/pub/scm/linux/kernel/git/mbroz/linux.git/log/?h=dm-cryptsetup

I haven't had a chance to look at your changes yet, and I might not get 
around to it for a while.

> The last patch is the reason why I need it, just for reference.
> More comments in the patch headers.
> 
> Could you please check it if it is *really* what we want?
> If so, I'll rebase it for usb next tree and send as a patchset.
> 
> But the macro magic is crazy... and I really did not find the better way.

Another possibility is to create a simple pre-processor program that 
would read the unusual_devs files and massage the information into the 
form the driver will want.  Such a program could do things that the C 
preprocessor isn't capable of.

For example, with this approach you could keep the original flag bits in 
positions 0 - 30, and reserve bit 31 as an indicator that there are 
additional flags stored in an "overflow" table entry.  This extra table 
could be relatively short, since it would need to contain only a small 
number of entries.  I can't think of any way to get the C preprocessor 
to do this, but it would be easy to have a separate program do it.

> Anyway, it also uncovered some problems
>  - some macros need to be changed a little bit, there is even old one unused

It doesn't hurt to have someone with fresh eyes taking a look at this.  :-)

>  - duplicity of entries in UAS and mass-storage are strange (and complicates
>    the approach).
>    I guess the sorting is intentionally that mass-storage is included
>    before UAS, so the mass-storage quirk is found as the first (for non-UAS).
>    (While UAS drive includes only own header.)

It's a little tricky because the two drivers need to be aware, to some 
extent, of which devices either prefer to use UAS or can't work with UAS.

> - the patch significantly increases size of module for 32bit
>   (64bit system use the direct flag store approach)

The "overflow table" approach would help a lot with this.

> - I stored a pointer to the flags array, not the index. Perhaps it should be
>   index only (trivial change, though).

Alan Stern
