Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046657E7E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbjKJRpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344174AbjKJRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0A2AD16;
        Fri, 10 Nov 2023 02:55:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96045C433CA;
        Fri, 10 Nov 2023 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699613749;
        bh=RXAfJy6nVK1MJToiQzsFVKZg55+RyTigmmxRjOy2q20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y63pPfubX5FHv9hUsmnxHwBXZY4mQJgLq2JtmrYVTJk/I2S1BXkd5Nn+MFblIC7xk
         uUkkfyM/ufjrKskwquv3wyGUfGc6BXEvt9NlZPtY1kmdLcrNJGxPY3Wdcv/2+GUZ+t
         WATx1VXK0FTDCOfCzZeGLcPffbQ1RGRNs6/En2DE=
Date:   Fri, 10 Nov 2023 11:55:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
Cc:     "git (AMD-Xilinx)" <git@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "jacmet@sunsite.dk" <jacmet@sunsite.dk>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: Re: [PATCH] serial: uartlite: Use dynamic allocation for major number
Message-ID: <2023111052-unread-drum-895d@gregkh>
References: <20231109123640.1740310-1-manikanta.guntupalli@amd.com>
 <2023110915-trusting-pointer-40b0@gregkh>
 <DM4PR12MB6109220B13FCD2B1D7B48B3C8CAEA@DM4PR12MB6109.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB6109220B13FCD2B1D7B48B3C8CAEA@DM4PR12MB6109.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 09:28:40AM +0000, Guntupalli, Manikanta wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, November 9, 2023 6:50 PM
> > To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
> > Cc: git (AMD-Xilinx) <git@amd.com>; Simek, Michal
> > <michal.simek@amd.com>; jacmet@sunsite.dk; jirislaby@kernel.org; linux-
> > serial@vger.kernel.org; linux-kernel@vger.kernel.org; Pandey, Radhey Shyam
> > <radhey.shyam.pandey@amd.com>; Goud, Srinivas
> > <srinivas.goud@amd.com>; Datta, Shubhrajyoti
> > <shubhrajyoti.datta@amd.com>; manion05gk@gmail.com
> > Subject: Re: [PATCH] serial: uartlite: Use dynamic allocation for major number
> > 
> > On Thu, Nov 09, 2023 at 06:06:40PM +0530, Manikanta Guntupalli wrote:
> > > Device number 204 has a range of minors on major number.
> > > uart_register_driver is failing due to lack of minor numbers when more
> > > number of uart ports used.
> > 
> > So you need more than the 4 allocated to you?
> Yes, we have a customer who has 32 uartlite instances in his board.
> > 
> > > So, use dynamic allocation
> > > for major number to avoid minor number limitation on 204 major number.
> > >
> > > https://docs.kernel.org/arch/arm/sa1100/serial_uart.html
> > 
> > What does this break by doing this?
> uart_register_driver() is failing due to lack of minor numbers when the customer
> has 32 uartlite instances in his board.
> > 
> > Also, you forgot to update the documentation :(
> We will update the documentation.
> > 
> > And how was this tested?  
> We tested on both ZCU106 AMD/Xilinx evaluation board with 32 uartlite instances with customer design.
> 
> >What about older systems with static device nodes,
> > are you sure none are out there for this old hardware anymore?
> Shall we use below approach to support both legacy hardware and hardware with more number of uartlite instances use case. Please suggest.

Yes, that looks much better, also update the Kconfig entry for
CONFIG_SERIAL_UARTLITE_NR_UARTS as well so that people know the
major/minor will be dynamic and will not be the other entry if they ask
for over 4.

thanks,

greg k-h
