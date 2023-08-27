Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBF78A012
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 17:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjH0Pu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjH0PuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:50:17 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B1043127
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 08:50:13 -0700 (PDT)
Received: (qmail 320883 invoked by uid 1000); 27 Aug 2023 11:50:12 -0400
Date:   Sun, 27 Aug 2023 11:50:12 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Milan Broz <gmazyland@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage: how to extend quirks flags to 64bit?
Message-ID: <6f8b825b-bc41-4080-8128-4a6f0a43f779@rowland.harvard.edu>
References: <f9e8acb5-32d5-4a30-859f-d4336a86b31a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e8acb5-32d5-4a30-859f-d4336a86b31a@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 11:32:05AM +0200, Milan Broz wrote:
> Hello,
> 
> I tried to extend USB storage for the passthrough of Opal
> security commands,

What sort of changes are needed?  Where is this passthrough mechanism 
documented?

>  and some adapters are clearly "not perfect".

Which ones?

> I would need to introduce a new quirks flag to turn it off.
> 
> Seems that we are already out of quirks flags on 32bit
> for usb storage - in usb_usual.h the last entry in mainline is
>   US_FLAG(SENSE_AFTER_SYNC, 0x80000000)
> 
> Adding a new flag will work for 64-bit systems but not
> for platforms with 32-bit unsigned long like i686.
> 
> How do we allow new flag definitions?
> 
> Struct us_data fflags can be made 64bit (defined in
> drivers/usb/storage/usb.h), but the major problem is that these
> are transferred through the generic driver_info field
> defined in linux/mod_devicetable.h as unsigned long).
> Making this 64bit is IMO an extensive API change (if even possible).
> I guess this is not the way to go.
> 
> Could USB maintainers please help to advise what is the correct
> solution? I am not familiar with the USB driver model here
> and I see no easy way how it can be solved by a trivial static
> allocation inside the USB storage driver.
> 
> Someone will need a new quirks flag in the future anyway... :)

I can think of only one way to accomplish this on 32-bit systems: Change 
the driver_info field from a bit array to an index into a static table 
of 64-bit flags values.  Each unusual_devs structure would have its own 
entry in this table.  As far as I can tell, the other unusual_*.h tables
could retain their current driver_info interpretations, since no new 
quirk bits are likely to be relevant to them.

Making this change would be an awkward nuisance, but it should be 
doable.

Alan Stern
