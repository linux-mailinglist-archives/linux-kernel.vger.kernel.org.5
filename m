Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F057F7706
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345407AbjKXO5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKXO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:57:09 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3E3BED72
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 06:57:15 -0800 (PST)
Received: (qmail 33955 invoked by uid 1000); 24 Nov 2023 09:57:14 -0500
Date:   Fri, 24 Nov 2023 09:57:14 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net, tj@kernel.org,
        rdunlap@infradead.org, paulmck@kernel.org,
        linux-doc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com,
        Martin.Mueller5@de.bosch.com
Subject: Re: [PATCH] usb: hubs: Decrease IN-endpoint poll interval for
 Microchip USB491x hub
Message-ID: <66137982-c6a4-48c8-860f-c87cc6e01101@rowland.harvard.edu>
References: <20231123081948.58776-1-hgajjar@de.adit-jv.com>
 <988f4311-a726-4a7e-b0bf-6aeec13d8f23@rowland.harvard.edu>
 <20231124145005.GA72525@vmlxhi-118.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124145005.GA72525@vmlxhi-118.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 03:50:05PM +0100, Hardik Gajjar wrote:
> On Thu, Nov 23, 2023 at 01:17:03PM -0500, Alan Stern wrote:
> > On Thu, Nov 23, 2023 at 09:19:48AM +0100, Hardik Gajjar wrote:
> > > There is a potential delay in announcing downstream USB bus activity to
> > > Linux USB drivers due to the default interrupt endpoint having a poll
> > > interval of 256ms.
> > > 
> > > Microchip has recommended ignoring the device descriptor and reducing
> > > that value to 32ms, as it was too late to modify it in silicon.
> > > 
> > > This patch aims to speed up the USB enumeration process, facilitating
> > > the successful completion of Apple CarPlay certifications and enhancing
> > > user experience when utilizing USB devices through the Microchip Multihost
> > > Hub.
> > > 
> > > A new quirk, USB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL, accelerates the
> > > notification process by changing the Endpoint interrupt poll interval
> > > from 256ms to 32ms.
> > 
> > But this is meant to apply only to hubs, right?  So shouldn't it be a 
> > HUB_QUIRK_32_MS_INTR_INTERVAL macro, used in hub.c's hub_id_table, 
> > rather than a general USB quirk?
> 
> Thank you, Alan, for the feedback. To confirm my understanding, are you suggesting
> moving all implementations to hub.c, adding the hub-specific quirk, and using the
> same quirk to update the bInterval value parsed by usb_get_configuration() in
> usb_enumerate_device()?"

Basically, yes.  The update should be performed in the hub_probe() 
routine if the quirk flag is set, before hub_configure() is called.  It 
might be necessary to add a usb_set_interface() call as well, in case 
the old bInterval value has already been cached by the host controller 
driver.

Alan Stern
