Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5D7D131B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377761AbjJTPqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTPqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:46:52 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E04D1B3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:46:49 -0700 (PDT)
Received: (qmail 300745 invoked by uid 1000); 20 Oct 2023 11:46:49 -0400
Date:   Fri, 20 Oct 2023 11:46:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ray Chi <raychi@google.com>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, Rob Herring <robh@kernel.org>,
        Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Prevent infinite loops when
 usb_reset_device() unbinds/binds
Message-ID: <60a358c9-b44b-4d25-9a20-aa9e00c65ab6@rowland.harvard.edu>
References: <20231020083125.1.I3e5f7abcbf6f08d392e31a5826b7f234df662276@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020083125.1.I3e5f7abcbf6f08d392e31a5826b7f234df662276@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:31:38AM -0700, Douglas Anderson wrote:
> When we call usb_reset_device() and a driver doesn't implement
> pre_reset() and post_reset() methods then the USB core will attempt to
> unbind and rebind the driver in order to make reset work. This is a
> great general solution, but it has the potential to loop forever.
> Specifically, if the USB device is in a state that the USB device
> driver issues another usb_reset_device() after each rebind then we'll
> just continually unbind and rebind with no end.
> 
> It's difficult to address this condition in a USB device driver
> because it's hard for the driver to keep state across each
> unbind/bind.

How about just adding appropriate pre_reset() and post_reset() methods? 
This is precisely what they are meant for.  Then the the unbind/rebind 
loop wouldn't ever get started.

Alan Stern
