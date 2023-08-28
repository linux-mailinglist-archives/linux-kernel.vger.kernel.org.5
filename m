Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AF78B36B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjH1Ooo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjH1OoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:44:14 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 60C7DDA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:44:10 -0700 (PDT)
Received: (qmail 352516 invoked by uid 1000); 28 Aug 2023 10:44:09 -0400
Date:   Mon, 28 Aug 2023 10:44:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     andrey.konovalov@linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>,
        Herve Codina <herve.codina@bootlin.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: gadget: clarify usage of
 USB_GADGET_DELAYED_STATUS
Message-ID: <4945ba1a-296c-49da-be09-fbbc3aba6738@rowland.harvard.edu>
References: <5c2913d70556b03c9bb1893c6941e8ece04934b0.1693188390.git.andreyknvl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c2913d70556b03c9bb1893c6941e8ece04934b0.1693188390.git.andreyknvl@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:10:30AM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@gmail.com>
> 
> USB_GADGET_DELAYED_STATUS was introduced in commit 1b9ba000177e ("usb:
> gadget: composite: Allow function drivers to pause control transfers").
> It was initially intended for the composite framework to allow delaying
> completing the status stage of a SET_CONFIGURATION request until all
> functions are ready.
> 
> Unfortunately, that commit had an unintended side-effect of returning
> USB_GADGET_DELAYED_STATUS from the ->setup() call of the composite
> framework gadget driver.
> 
> As a result of this and the incomplete documentation, some UDC drivers
> started relying on USB_GADGET_DELAYED_STATUS to decide when to avoid
> autocompleting the status stage for 0-length control transfers. dwc3 was
> the first in commit 5bdb1dcc6330 ("usb: dwc3: ep0: handle delayed_status
> again"). And a number of other UDC drivers followed later, probably
> relying on the dwc3 behavior as a reference.
> 
> Unfortunately, this violated the interface between the UDC and the
> gadget driver for 0-length control transfers: the UDC driver must only
> proceed with the status stage for a 0-length control transfer once the
> gadget driver queued a response to EP0.
> 
> As a result, a few gadget drivers are partially broken when used with
> a UDC that only delays the status stage for 0-length transfers when
> USB_GADGET_DELAYED_STATUS is returned from the setup() callback.
> 
> This includes Raw Gadget and GadgetFS. For FunctionFS, a workaround was
> added in commit 946ef68ad4e4 ("usb: gadget: ffs: Let setup() return
> USB_GADGET_DELAYED_STATUS") and commit 4d644abf2569 ("usb: gadget: f_fs:
> Only return delayed status when len is 0").
> 
> The proper solution to this issue would be to contain
> USB_GADGET_DELAYED_STATUS within the composite framework and make all
> UDC drivers to not complete the status stage for 0-length requests on
> their own.
> 
> Unfortunately, there is quite a few UDC drivers that need to get fixed
> and the required changes for some of them are not trivial.
> 
> For now, update the comments to clarify that USB_GADGET_DELAYED_STATUS
> must not be used by the UDC drivers.
> 
> The following two commits also add workarounds to Raw Gadget and GadgetFS
> to make them compatible with the broken UDC drivers until they are fixed.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>
