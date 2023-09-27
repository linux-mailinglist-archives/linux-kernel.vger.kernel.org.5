Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FCE7B05AE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjI0Nnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjI0Nnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:43:40 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B8485121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:43:38 -0700 (PDT)
Received: (qmail 1499934 invoked by uid 1000); 27 Sep 2023 09:43:37 -0400
Date:   Wed, 27 Sep 2023 09:43:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, andre.przywara@arm.com,
        bjorn@mork.no, edumazet@google.com, gaul@gaul.org,
        horms@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH 2/3] r8152: Retry register reads/writes
Message-ID: <62fec09e-c881-498e-9ac0-d0a6de665f16@rowland.harvard.edu>
References: <20230926212824.1512665-1-dianders@chromium.org>
 <20230926142724.2.I65ea4ac938a55877dc99fdf5b3883ad92d8abce2@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926142724.2.I65ea4ac938a55877dc99fdf5b3883ad92d8abce2@changeid>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 02:27:27PM -0700, Douglas Anderson wrote:
> +
> +static
> +int r8152_control_msg(struct usb_device *udev, unsigned int pipe, __u8 request,
> +		      __u8 requesttype, __u16 value, __u16 index, void *data,
> +		      __u16 size, const char *msg_tag)
> +{
> +	int i;
> +	int ret;
> +
> +	for (i = 0; i < REGISTER_ACCESS_TRIES; i++) {
> +		ret = usb_control_msg(udev, pipe, request, requesttype,
> +				      value, index, data, size,
> +				      USB_CTRL_GET_TIMEOUT);
> +
> +		/* No need to retry or spam errors if the USB device got
> +		 * unplugged; just return immediately.
> +		 */
> +		if (udev->state == USB_STATE_NOTATTACHED)
> +			return ret;

Rather than testing udev->state, it would be better to check whether
ret == -ENODEV.  udev->state is meant primarily for use by the USB core
and it's subject to races.

Alan Stern
