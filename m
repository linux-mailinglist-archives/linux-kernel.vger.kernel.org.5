Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3767D1E2C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjJUQPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjJUQPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:15:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FFB1A8;
        Sat, 21 Oct 2023 09:15:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6404C433C8;
        Sat, 21 Oct 2023 16:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697904926;
        bh=SHOy2rMtReYiFTxDJT1AME1BMS7WvUye36eUPs7PVdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlg+wTlhHgYcLmcjz6kx2/83Mrg84TXk9muSAlCjmS1G6Ip8FPzdTVIRQQB/O9cRI
         iTDSJ4Ws8RW/Pvx0qzZeHX3BP10NqnPV4KsIYKW0EKK1cQhQOfcym1ZLAKMxseud88
         OgcKhARRp6EtWP8Zx0u8BP7rj9IjOqeflF1Pl308=
Date:   Sat, 21 Oct 2023 18:15:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, kabel@kernel.org, u.kleine-koenig@pengutronix.de,
        ansuelsmth@gmail.com, m.brock@vanmierlo.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 2/3] tty: add new helper function tty_get_tiocm
Message-ID: <2023102115-stock-scrambled-f7d5@gregkh>
References: <20231019112809.881730-1-fe@dev.tdt.de>
 <20231019112809.881730-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019112809.881730-3-fe@dev.tdt.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 01:28:08PM +0200, Florian Eckert wrote:
> The struct 'tty_struct' has a callback to read the status flags of the tty
> if the tty driver provides them. So fare, the data is transferred directly
> to userspace with the function 'tty_tiocmget'. This function cannot be
> used to evaluate the status line of the tty interface in the ledtrig-tty
> trigger. To make this possible, a new function must be added that does
> not immediately pass the data on to userspace.
> 
> The new function 'tty_get_tiocm' only returns the status register.
> This information can then be processed further in the ledtrig-tty
> trigger.

Writing changelogs are hard.  You are including a lot of information in
here that really doesn't need to be, as you are focusing on your
specific use case, which is fine, but you are creating a generic
function.

This can be simpler, how about something like this:

	There is no in-kernel function to get the status register of a
	tty device like the TIOCMGET ioctl returns to userspace.  Create
	a new function, tty_get_tiocm(), to obtain the status register
	that other portions of the kernel can call if they need this
	information, and move the existing internal tty_tiocmget()
	function to use this interface.

Sound good?

The code portion looks fine to me, thanks for doing this.

greg k-h
