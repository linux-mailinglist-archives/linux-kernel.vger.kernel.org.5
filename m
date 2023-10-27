Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B27D9D5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjJ0PtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJ0PtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:49:16 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 56EFCB8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:49:14 -0700 (PDT)
Received: (qmail 573361 invoked by uid 1000); 27 Oct 2023 11:49:13 -0400
Date:   Fri, 27 Oct 2023 11:49:13 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        erosca@de.adit-jv.com, s.shtylyov@omp.ru
Subject: Re: [PATCH v7 2/2] usb: new quirk to reduce the SET_ADDRESS request
 timeout
Message-ID: <7cbc1a70-2dcc-4a2a-99e6-fdd92bd5cc9b@rowland.harvard.edu>
References: <20231027152029.104363-1-hgajjar@de.adit-jv.com>
 <20231027152029.104363-2-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027152029.104363-2-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:20:29PM +0200, Hardik Gajjar wrote:
> This patch introduces a new USB quirk,
> USB_QUIRK_SHORT_SET_ADDRESS_REQ_TIMEOUT, which modifies the timeout value
> for the SET_ADDRESS request. The standard timeout for USB request/command
> is 5000 ms, as recommended in the USB 3.2 specification (section 9.2.6.1).
> 
> However, certain scenarios, such as connecting devices through an APTIV
> hub, can lead to timeout errors when the device enumerates as full speed
> initially and later switches to high speed during chirp negotiation.
> 
> In such cases, USB analyzer logs reveal that the bus suspends for
> 5 seconds due to incorrect chirp parsing and resumes only after two
> consecutive timeout errors trigger a hub driver reset.
> 
> Packet(54) Dir(?) Full Speed J(997.100 us) Idle(  2.850 us)
> _______| Time Stamp(28 . 105 910 682)
> _______|_____________________________________________________________Ch0
> Packet(55) Dir(?) Full Speed J(997.118 us) Idle(  2.850 us)
> _______| Time Stamp(28 . 106 910 632)
> _______|_____________________________________________________________Ch0
> Packet(56) Dir(?) Full Speed J(399.650 us) Idle(222.582 us)
> _______| Time Stamp(28 . 107 910 600)
> _______|_____________________________________________________________Ch0
> Packet(57) Dir Chirp J( 23.955 ms) Idle(115.169 ms)
> _______| Time Stamp(28 . 108 532 832)
> _______|_____________________________________________________________Ch0
> Packet(58) Dir(?) Full Speed J (Suspend)( 5.347 sec) Idle(  5.366 us)
> _______| Time Stamp(28 . 247 657 600)
> _______|_____________________________________________________________Ch0
> 
> This 5-second delay in device enumeration is undesirable, particularly
> in automotive applications where quick enumeration is crucial
> (ideally within 3 seconds).
> 
> The newly introduced quirks provide the flexibility to align with a
> 3-second time limit, as required in specific contexts like automotive
> applications.
> 
> By reducing the SET_ADDRESS request timeout to 500 ms, the
> system can respond more swiftly to errors, initiate rapid recovery, and
> ensure efficient device enumeration. This change is vital for scenarios
> where rapid smartphone enumeration and screen projection are essential.
> 
> To use the quirk, please write "vendor_id:product_id:p" to
> /sys/bus/usb/drivers/hub/module/parameter/quirks
> 
> For example,
> echo "0x2c48:0x0132:p" > /sys/bus/usb/drivers/hub/module/parameters/quirks"
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
