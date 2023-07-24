Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626F175F9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGXOSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGXOSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:18:52 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 8CC85E64
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:18:51 -0700 (PDT)
Received: (qmail 1848669 invoked by uid 1000); 24 Jul 2023 10:18:50 -0400
Date:   Mon, 24 Jul 2023 10:18:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Stanley Chang <stanley_chang@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Roy Luo <royluo@google.com>, Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 1/5] usb: phy: add usb phy notify port status API
Message-ID: <802dd50c-7201-45d2-8855-6692aeb947db@rowland.harvard.edu>
References: <20230724103600.14164-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724103600.14164-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 06:34:48PM +0800, Stanley Chang wrote:

> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -614,6 +614,30 @@ static int hub_ext_port_status(struct usb_hub *hub, int port1, int type,
>  		ret = 0;
>  	}
>  	mutex_unlock(&hub->status_mutex);
> +
> +	/*
> +	 * There is no need to lock status_mutex here, because status_mutex
> +	 * protects hub->status, and the phy driver only checks the port
> +	 * status without changing the status.
> +	 */
> +	if (!ret) {
> +		struct usb_device *hdev = hub->hdev;
> +
> +		/*
> +		 * Applies to roothub only. That is, when hdev->parent is
> +		 * empty. Only roothub will be notified of port state
> +		 * changes, since the USB PHY only cares about changes at
> +		 * the next level.
> +		 */
> +		if (hdev && !hdev->parent) {

hdev can never be NULL, so you don't need to test it.  Also, there 
is an is_root_hub() routine you can call here -- it's an inline defined 
in usb.h.  If you use that then you won't have to explain it in the 
comment.

To be fair, there are plenty of other places in the driver that test 
!hdev->parent (or !udev->parent) with no explanation.

Alan Stern
