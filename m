Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE84C7B8C93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbjJDTKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 15:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245619AbjJDTJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 15:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608A21BF5;
        Wed,  4 Oct 2023 12:08:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA56FC433C8;
        Wed,  4 Oct 2023 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696446494;
        bh=QNnMLUld3EP0hN/OdAh3qa/KhWWaME+HBFlqQYT6ChM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=rj3z/u3RnB7WfWljEWfz5tRqCuA4C7ZsQ/PuBNhU7cXWNX2QONvdVNdg4NHIrGP/9
         99T5wGqyKjblSKmWNjgA1MUAAcmXxHQR9CBoh68MwyGPjPfQL7gbQ39hODtze55Bet
         DVtiDvVEBm/Ug107suxPCo+bTxjkLZOO7bzn2H5zElaXxmJiqIWq2hDJlsfnJOsRwp
         qebDykGKEdzdNSkL/92pM9VIbblpE0nMTUSuiv685jwfFqg1dr0GHqcPbZ4yRDT4Hp
         fZzB8aIXJ9AXUfQ0Rvd76o+YeLREEF1/ptZzCofhgpmaeHST0/hIZkD4nvbVrFRTIr
         yleN8q0FN7J0w==
Date:   Wed, 4 Oct 2023 21:08:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Martino Fontana <tinozzo123@gmail.com>
cc:     djogorchock@gmail.com, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND] HID: nintendo: cleanup LED code
In-Reply-To: <20230924141547.11597-1-tinozzo123@gmail.com>
Message-ID: <nycvar.YFH.7.76.2310042107570.3534@cbobk.fhfr.pm>
References: <20230924141547.11597-1-tinozzo123@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023, Martino Fontana wrote:

> - Support player LED patterns up to 8 players.
>   (Note that the behavior still consinsts in increasing the player number
>   every time a controller is connected, never decreasing it. It should be
>   as is described in https://bugzilla.kernel.org/show_bug.cgi?id=216225.
>   However, any implementation here would stop making sense as soon as a
>   non-Nintendo controller is connected, which is why I'm not bothering.)
> 
> - Split part of `joycon_home_led_brightness_set` (which is called by hid)
>   into `joycon_set_home_led` (which is what actually sets the LEDs), for
>   consistency with player LEDs.
> 
> - `joycon_player_led_brightness_set` won't try it to "determine which
>   player led this is" anymore: it's already looking at every LED
>   brightness value.
> 
> - Instead of first registering the `led_classdev`, then attempting to set
>   the LED and unregistering the `led_classdev` if it fails, first attempt
>   to set the LED, then register the `led_classdev` only if it succeeds
>   (the class is still filled up in either case).
> 
> - If setting the player LEDs fails, still attempt setting the home LED.
>   (I don't know there's a third party controller where this may actually
>   happen, but who knows...)
> 
> - Use `JC_NUM_LEDS` where appropriate instead of 4.
> 
> - Print return codes in more places.
> 
> - Use spinlock instead of mutex for `input_num`. Copy its value to a local
>   variable, so that it can be unlocked immediately.
> 
> - `input_num` starts counting from 0
> 
> - Less holding of mutexes in general.
> 
> Signed-off-by: Martino Fontana <tinozzo123@gmail.com>
> ---
> Changes for v2:
> 
> Applied suggestions, commit message explains more stuff, restored `return ret`
> when `devm_led_classdev_register` fails (since all other hid drivers do this).
> If setting LED fails, `hid_warn` now explicitly says "skipping registration".
> 
> Changes for v3 and v4:
> 
> Fixed errors and warnings from test robot.
> 
> Changes for v5:
> 
> I thought that when connecting the controller on an actual Nintendo Switch,
> only the nth player LED would turn on, which is true... on Wii and Wii U.
> So I reverted that, and to compensate, now this supports the LED patterns
> up to 8 players.
> 
>  drivers/hid/hid-nintendo.c | 133 +++++++++++++++++++++----------------
>  1 file changed, 76 insertions(+), 57 deletions(-)

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

