Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573B67E47FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343772AbjKGSN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234669AbjKGSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:13:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55370132
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 10:13:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71478C433CA;
        Tue,  7 Nov 2023 18:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699380802;
        bh=gazaRc+aEiIyTzNinDjx0ki65vH/wKHbHk/6Ydw3L4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOcX6UKm4/PBOxQiHjHPNKhhHh8phKJLtEmQmdaIx/e2sKj7d2IAKTNYQvTivuHUn
         xraxU6y5AcfE409OESVyY5/VZ252r+5wV3YgMD5VkT6UM5y8QAwvaCTdgFFNrNTLBj
         EdtMiqBCv1CN+yhovvAYxyu4j+UAUaXDk8pJPQig=
Date:   Tue, 7 Nov 2023 19:13:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        marcel@holtmann.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] Bluetooth: Replaces printk with pr_debug in bt_dbg
Message-ID: <2023110752-laundry-stiffness-9f34@gregkh>
References: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <2023110752-headset-gains-41a7@gregkh>
 <DB3PR10MB6835DDFE9086DAC4B01C7508E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB6835DDFE9086DAC4B01C7508E8A9A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 09:32:51PM +0530, Yuran Pereira wrote:
> Hello Greg,
> On Tue, Nov 07, 2023 at 07:31:27AM +0100, Greg KH wrote:
> > 
> > You might have just changed the functionality here, are you SURE this is
> > identical to the original code?  How was it tested?
> > 
> > I'm not saying this is a bad idea to do, just be aware of the
> > consequences for this change and document it properly (hint, the
> > changelog does not document the user-visible change that just happened.)
> > 
> > Note, pr_debug() is NOT identical to printk(), look at the source for
> > the full details.
> > 
> 
> Thank you for the heads-up. 
> Yes, you're right.
> 
> I just took another look and it seems that using pr_debug here
> does defeat the purpose of bt_dbg which was created for situations
> where `DYNAMIC_DEBUG` and `DEBUG` are disabled.
> 
> The likely equivalent would have been `pr_devel` but that also
> depends on `DEBUG`.
> 
> Do you think that a new `pr_devel_uncond` like the one below
> (only to be used in exceptional scenarios) would be a good idea?
> 
> ```
> #define pr_devel_uncond(fmt, ...) \
>     printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
> ```
> 
> This would neither depend on `DYNAMIC_DEBUG` nor on `DEBUG`.

No, not at all, the bluetooth subsystem should move to actually use the
proper dynamic debug infrastructure and not have their own "special"
subsystem loging macros/functions.  What you are doing here is the
proper way forward, BUT you need to make everyone aware that it is going
to change how things work from what they do today.

In other words, it's not just a "trivial" change, you need to get
approval to change this type of functionality from the Bluetooth
developers/maintainers.

thanks,

greg k-h
