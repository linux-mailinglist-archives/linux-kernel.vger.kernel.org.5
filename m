Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B63C800FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjLAP7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjLAP7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:59:49 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id F11AA10D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:59:54 -0800 (PST)
Received: (qmail 290509 invoked by uid 1000); 1 Dec 2023 10:59:53 -0500
Date:   Fri, 1 Dec 2023 10:59:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Horman <horms@kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Brian Geffon <bgeffon@google.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, Rob Herring <robh@kernel.org>,
        Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Save the config when a device is
 deauthorized+authorized
Message-ID: <62b7467f-f142-459d-aa23-8bfd70bbe733@rowland.harvard.edu>
References: <20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:43:47PM -0800, Douglas Anderson wrote:
> Right now, when a USB device is deauthorized (by writing 0 to the
> "authorized" field in sysfs) and then reauthorized (by writing a 1) it
> loses any configuration it might have had. This is because
> usb_deauthorize_device() calls:
>   usb_set_configuration(usb_dev, -1);
> ...and then usb_authorize_device() calls:
>   usb_choose_configuration(udev);
> ...to choose the "best" configuration.
> 
> This generally works OK and it looks like the above design was chosen
> on purpose. In commit 93993a0a3e52 ("usb: introduce
> usb_authorize/deauthorize()") we can see some discussion about keeping
> the old config but it was decided not to bother since we can't save it
> for wireless USB anyway. It can be noted that as of commit
> 1e4c574225cc ("USB: Remove remnants of Wireless USB and UWB") wireless
> USB is removed anyway, so there's really not a good reason not to keep
> the old config.
> 
> Unfortunately, throwing away the old config breaks when something has
> decided to choose a config other than the normal "best" config.
> Specifically, it can be noted that as of commit ec51fbd1b8a2 ("r8152:
> add USB device driver for config selection") that the r8152 driver
> subclasses the generic USB driver and selects a config other than the
> one that would have been selected by usb_choose_configuration(). This
> logic isn't re-run after a deauthorize + authorize and results in the
> r8152 driver not being re-bound.
> 
> Let's change things to save the old config when we deauthorize and
> then restore it when we re-authorize. We'll disable this logic for
> wireless USB where we re-fetch the descriptor after authorization.

Would it be better to make the r8152 driver override 
usb_choose_configuration()?  This is the sort of thing that subclassing 
is intended for.

Alan Stern
