Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45A27DC795
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbjJaHsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236654AbjJaHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:48:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97000C1;
        Tue, 31 Oct 2023 00:48:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C27C433C7;
        Tue, 31 Oct 2023 07:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698738492;
        bh=u5OhuMhZzR6JXuvhNC/KDrltMRDZ6tM7BPip6bBNUic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cqfsXm/cvPDFyWtJcarQZbOA+Ra2DBzhwm1Xm2FVKaBARc8FW0bceA+lQShI5GQAI
         WvjnPpUor4s7F/lyhTRkAHt5AsHeHRZerxG/pCNDxIPO1YZKs44wLMAi7eaRxQFpZD
         S4DKTU1kUJPL40Sg8nJ0O8FOgsqxDZeaX3G4TBJA4fuLZpfjl33gBDnADEz9k0B0Hz
         Rs1Lhpb+rV3QkBO6PkmIGcwIpXUgMBLonhFQNP99k9P+lWbPVyIM3B2RhcW1Q7YprL
         EqkLUalBBH/LGoJ8U1q5MNcB9oytnJ8ZiEMHb3KDuCp23uUGUDZRg06TWN0Bky/cxQ
         S55p9ERkgGmBA==
Date:   Tue, 31 Oct 2023 07:48:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v7 2/5] leds: sun50i-a100: New driver for the A100
 LED controller
Message-ID: <20231031074807.GQ8909@google.com>
References: <20221231235541.13568-1-samuel@sholland.org>
 <20221231235541.13568-3-samuel@sholland.org>
 <20230316133422.GM9667@google.com>
 <a1adbe50-3400-fd10-1856-8c1d0ed82276@sholland.org>
 <f5468eac-96ec-e8c9-bcc1-9ec219bf3352@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5468eac-96ec-e8c9-bcc1-9ec219bf3352@sholland.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023, Samuel Holland wrote:

> Hi Lee,
> 
> On 10/17/23 19:38, Samuel Holland wrote:
> > On 3/16/23 08:34, Lee Jones wrote:
> >> On Sat, 31 Dec 2022, Samuel Holland wrote:
> >>> +	for_each_available_child_of_node(np, child) {
> >>> +		struct sun50i_a100_ledc_led *led;
> >>> +		struct led_classdev *cdev;
> >>> +		u32 addr, color;
> >>> +
> >>> +		ret = of_property_read_u32(child, "reg", &addr);
> >>> +		if (ret || addr >= count) {
> >>> +			dev_err(dev, "LED 'reg' values must be from 0 to %d\n",
> >>
> >> Doesn't sounds like an address.
> > 
> > The one-wire protocol involves the first LED responding to the first 24
> > bits of the transfer, then forwarding the rest to the next LED. The
> > address is the ordinal position in the chain. So I don't think there is
> > any reason to have gaps in the addresses--the LEDs would still have to
> > physically be there, but you would not be able to control them. That
> > said, the driver doesn't need to enforce this, so I can remove the check.
> 
> There's actually a reason for the driver enforcing that LED addresses
> are contiguous. Removing this check decouples the largest address from
> the number of LED class devices. Unfortunately, there's a register field
> (LEDC_RESET_TIMING_CTRL_REG_LED_NUM) that must be set to the largest
> address for transfers to work correctly.
> 
> This means the driver would need to iterate through the child nodes in
> two passes inside the probe function: first to find the largest reg
> value, and second to actually register the LED class devices.
> 
> Since I don't think having gaps in the addresses is a realistic use
> case, I'd like to keep this restriction for now (with a comment). We
> could always pay the complexity cost later if someone really does want
> to relax this check.

You're replying to a review conducted 7 months ago which in turn was for
a patch submitted nearly a year ago!

Also the review comment was simple - if it's not an address, rename the
variable.

-- 
Lee Jones [李琼斯]
