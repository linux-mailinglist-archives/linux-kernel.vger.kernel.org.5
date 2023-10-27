Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475287D8F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbjJ0HUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:20:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E90194
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:19:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7146FC433C7;
        Fri, 27 Oct 2023 07:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698391197;
        bh=eAzGncuNN+h/nEmL0ZN/dcXM9fGW6dn1TaiHf0175Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOPH7MxC1fgBZD4Sr2OY9INWba7SOjh03byjzEY0Hg3jA6SPPpqqHDuT4zAnESK0o
         STR/y3RVFPBeVW+1Gu7xEUbXIGNhlWS/0jsqyKjR2j2QvR9z999NEiYDcuEdQFSlcv
         gURLO0OKq7yCHZDh3THAX4hJIsBmzZD3aqYa+BI0=
Date:   Fri, 27 Oct 2023 09:19:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jayant Chowdhary <jchowdhary@google.com>
Cc:     mgr@pengutronix.de, Thinh.Nguyen@synopsys.com, arakesh@google.com,
        etalvala@google.com, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH v2] usb:gadget:uvc Do not use worker thread to pump usb
 requests
Message-ID: <2023102739-reproach-salute-0d22@gregkh>
References: <ZToOJhyOFeGCGUFj@pengutronix.de>
 <20231026215635.2478767-1-jchowdhary@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026215635.2478767-1-jchowdhary@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 09:56:35PM +0000, Jayant Chowdhary wrote:
> This patch is based on top of
> https://lore.kernel.org/linux-usb/20230930184821.310143-1-arakesh@google.com/T/#t:

That doesn't work in the changelog of a patch at all, it goes below the
--- line p lease.

> 
> When we use an async work queue to perform the function of pumping
> usb requests to the usb controller, it is possible that thread scheduling
> affects at what cadence we're able to pump requests. This could mean usb
> requests miss their uframes - resulting in video stream flickers on the host
> device.
> 
> In this patch, we move the pumping of usb requests to
> 1) uvcg_video_complete() complete handler for both isoc + bulk
>    endpoints. We still send 0 length requests when there is no uvc buffer
>    available to encode.
> 2) uvc_v4l2_qbuf - only for bulk endpoints since it is not legal to send
>    0 length requests.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
> Suggested-by: Jayant Chowdhary <jchowdhary@google.com>
> Suggested-by: Avichal Rakesh <arakesh@google.com>
> Tested-by: Jayant Chowdhary <jchowdhary@google.com>
> ---
>  v1->v2: Fix code style and add self Signed-off-by

Great, but as signed-off-by kind of implies you tested it, no need for
the tested-by now, right?  Not a big deal, and normally I'd ignore it
but I know you at least have to do one more version of this based on the
above problem...

thanks,

greg k-h
