Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC7F805D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345965AbjLESWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345907AbjLESWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:22:09 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DC5831702
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:22:09 -0800 (PST)
Received: (qmail 425674 invoked by uid 1000); 5 Dec 2023 13:22:09 -0500
Date:   Tue, 5 Dec 2023 13:22:09 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, tj@kernel.org, paulmck@kernel.org,
        Martin.Mueller5@de.bosch.com
Subject: Re: [PATCH v5 2/2] usb: hub: Add quirk to decrease IN-ep poll
 interval for Microchip USB491x hub
Message-ID: <1773e17b-a94e-4101-8881-54e33fb700d6@rowland.harvard.edu>
References: <20231205181829.127353-1-hgajjar@de.adit-jv.com>
 <20231205181829.127353-2-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205181829.127353-2-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 07:18:29PM +0100, Hardik Gajjar wrote:
> There is a potential delay in notifying Linux USB drivers of downstream
> USB bus activity when connecting a high-speed or superSpeed device via the
> Microchip USB491x hub. This delay is due to the fixed bInterval value of
> 12 in the silicon of the Microchip USB491x hub.
> 
> Microchip requested to ignore the device descriptor and decrease that
> value to 9 as it was too late to modify that in silicon.
> 
> This patch speeds up the USB enummeration process that helps to pass
> Apple Carplay certifications and improve the User experience when utilizing
> the USB device via Microchip Multihost USB491x Hub.
> 
> A new hub quirk HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL speeds up
> the notification process for Microchip USB491x hub by limiting
> the maximum bInterval value to 9.
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
> changes since version 1:
> 	- Move implementation from config.c and quirk.c to hub.c as this is hub
> 	  specific changes.
> 	- Improve commit message.
> 	- Link to v1 - https://lore.kernel.org/all/20231123081948.58776-1-hgajjar@de.adit-jv.com/
> 
> changes since version 2:
>     - Call usb_set_interface after updating the bInterval to Tell the HCD about modification
> 	- Link to v2 - https://lore.kernel.org/all/20231130084855.119937-1-hgajjar@de.adit-jv.com/
> 
> changes since version 3:
>     - Change HUB_QUIRK_REDUCE_FRAME_INTR_BINTERVAL value from 0x08 to 0x04
> 	- Link to v3 - https://lore.kernel.org/all/20231201144705.97385-1-hgajjar@de.adit-jv.com/
> 
> changes since version 4:
> 	- change quirk hardcoded value to BIT() Macro
> 	- Link to v4 - https://lore.kernel.org/all/20231204073834.112509-1-hgajjar@de.adit-jv.com/
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
