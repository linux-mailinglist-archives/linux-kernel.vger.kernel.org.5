Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680A575B053
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGTNqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjGTNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:45:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCCE1986;
        Thu, 20 Jul 2023 06:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADB9A61AF3;
        Thu, 20 Jul 2023 13:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE895C433C8;
        Thu, 20 Jul 2023 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689860757;
        bh=MVVckKfWdb/UFwbNUW/fQU3gPnX5foBXQJh6KT8HQ+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boFfscIY8umJ/s7h4gFQo5CTmHGrgpus1lA0CIwGCqiXJEdfJZ7xqXm/BciUYsfei
         Bp5R3aIPsCW0LzfkWu/GWbVaICvCG6Bhghqkh4PIUZDQ5qwYvzgqzldEGoQF6g+cp1
         EB+t94GHkAZGQTucE5y1mL1/54YAY0i5+RLcxAphNv+xRGZ5G3Cte8xLSHtsNpJXXK
         PwiY9ELH8r1+2UJs3Rcb/CEtH/R1Um6bxmWLG4iqnMHW7KB3VaMT3N5/LtqGhL7m5a
         7vHXJqpIjNQMnvjo4Nx1lxq1PaVMo8WT9Su9BJmVNxTuVZnRpaN2/Ve9//957kdC7X
         s574fvJaTCvwQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qMTyo-00076j-07;
        Thu, 20 Jul 2023 15:46:06 +0200
Date:   Thu, 20 Jul 2023 15:46:06 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Message-ID: <ZLk6nu_PuH5Tr-L8@hovoldconsulting.com>
References: <ZD1cy6omacYMRCLs@hovoldconsulting.com>
 <20230423185929.1595056-1-kasper@iki.fi>
 <ZJGduS4z5U65T7IL@hovoldconsulting.com>
 <ae52e145-98b5-dd55-a4d8-5022c99b1129@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae52e145-98b5-dd55-a4d8-5022c99b1129@iki.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 10:37:51PM +0300, Jarkko Sonninen wrote:
> On 6/20/23 15:38, Johan Hovold wrote:

> Thank you. Sorry for slow responses. My mind has been elsewhere.

No worries at all.

> > On Sun, Apr 23, 2023 at 09:59:28PM +0300, Jarkko Sonninen wrote:

> >> User enables RS-485 mode by setting SER_RS485_ENABLED flag in
> >> struct serial_rs485 flags. User should also set either
> >> SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND to select the
> >> behaviour of the RTS#/RS485 pin. Setting SER_RS485_RTS_ON_SEND
> >> will drive RTS#/RS485 high during transmission. As this is the
> >> typical application described by Exar, it is selected when
> >> user sets neither or both flags.

> > Since RTS# is active low, shouldn't SER_RS485_RTS_ON_SEND drive RTS# low
> > rather than high during transmission as I also pointed out earlier?
> 
> I guess you are right. I'll change that.
> 
> 
> I use an exar usb adapter to control a solar charging controller. I 
> haven't found any other type of exar adapters in ebay.
> 
> This adapter uses high level (RTS off) on TX. So I really would like it 
> to work with the default configuration.
> 
> I hope it is ok to use SER_RS485_RTS_AFTER_SEND as the default

I was first going to argue against with this as serial core defaults to
SER_RS485_RTS_ON_SEND when neither is set, but I changed my mind as I
believe this is more in line with how these flags were intended to be
used.

Having both flags set to the same value clearly makes no sense, but if
left that way I think SER_RS485_RTS_ON_SEND should take precedence and
SER_RS485_RTS_AFTER_SEND simply be set not its negation (when the
hardware does not support the nonsensical RTS always asserted
combination...). That is:

	/* RTS always toggles after TX */
	if (rs485->flags & SER_RS485_RTS_ON_SEND)
		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
	else
		rs485->flags |= SER_RS485_RTS_AFTER_SEND;

Since you still need to use the new ioctl() to enable RS485 mode, there
shouldn't really be any reason not to simultaneously set the polarity
your application expects anyway.

Johan
