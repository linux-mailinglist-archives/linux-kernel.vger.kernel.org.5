Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32F275B068
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjGTNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGTNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9EE2122;
        Thu, 20 Jul 2023 06:52:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8317F61ADE;
        Thu, 20 Jul 2023 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AA9C433C7;
        Thu, 20 Jul 2023 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689861128;
        bh=7qMBM2O1eJyO65YYQrFbKbYLInUaocfLwQBu0lo73lM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6YH0LUfb24M65v9ROoNvDh8Qv9ongsj8EZseujrAh9lDOgvB30wCbr2YrQeb9BJg
         kn2VrBEcezhPPaylGcSJPlvdML6oyab9cxkBiaLZLSceFVEYYqjbqOkQptMjGan/zG
         V/tuQxem6P07BjaGDC5FPbrbcsoSsGcKzGlWoUV4Xj8+esVugPL4c3NMHDZV6auttH
         juVxunPlaDKV9YjJ0oHZxD9LfYJeJAR6wYvMTmsVFAhjtF6AMIKvtmh6i7H1qSBTuy
         4up25ZwO0yfWB2efP0qDYlUZzh2cPptHOu4rqJQAT6Q3hWVedXzuPymbi3ae/hjwTh
         w9uqRSbCZ6clg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMU4m-0007v3-1f;
        Thu, 20 Jul 2023 15:52:17 +0200
Date:   Thu, 20 Jul 2023 15:52:16 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZLk8ECsKZc-akHef@hovoldconsulting.com>
References: <ZJGduS4z5U65T7IL@hovoldconsulting.com>
 <20230708145651.1860565-1-kasper@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708145651.1860565-1-kasper@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 05:56:50PM +0300, Jarkko Sonninen wrote:
> Exar devices like XR21B1411 can control an RS485 transceiver by
> automatically asserting the RTS#/RS485 pin before sending data
> and deasserting it when the last stop bit has been transmitted.
> The polarity of the RST#/RS485 signal is configurable and the
> hardware also supports half-duplex turn-around delay and
> address matching mode.
> 
> Add support for enabling and disabling RS-485 mode and
> configuring the RST#/RS485 signal polarity using the TIOCGRS485
> and TIOCSRS485 ioctls. Support for half-duplex turn-around delay
> and address matching mode are left unimplemented for now.
> 
> User enables RS-485 mode by setting SER_RS485_ENABLED flag in
> struct serial_rs485 flags. User should also set either
> SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND to select the
> behaviour of the RTS#/RS485 pin. Setting SER_RS485_RTS_AFTER_SEND
> will drive RTS#/RS485 high during transmission. As this is the
> typical application described by Exar, it is selected when
> user sets neither or both flags.
> 
> Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
> ---
> Changes in v3:
>  - In this version only rs485.flags are stored to state.
>  - There is no locking as only one bit of the flags is used.
>  - ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
> Changes in v4:
>  - Store struct rs485 to data
>  - Add mutex to protect data->rs485.
>  - Implement SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND flags
>  - SER_RS485_RTS_ON_SEND is the default like in serial_core.c
> Change in v5:
>  - Use tty->termios_rwsem semaphore instead of own mutex
>  - Set SER_RS485_RTS_AFTER_SEND as the default
>  - Fix XR_GPIO_MODE_RS485_TX_H setting with SER_RS485_RTS_ON_SEND
>  - Add missing __user directives

I've applied this one now but with the small change I just mentioned
that makes SER_RS485_RTS_ON_SEND determine SER_RS485_RTS_AFTER_SEND.

Since this sets SER_RS485_RTS_AFTER_SEND when neither flag is set, I
believe you get the behaviour you preferred (even if
SER_RS485_RTS_AFTER_SEND is now cleared when both flags are set).

Let me know otherwise and we'll discuss it. Here's the result:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-next&id=974e2f6a0554685493cc44406bc7d8ba0a3b0e33

Thanks for sticking with. I think the end result looks really good.

Johan
