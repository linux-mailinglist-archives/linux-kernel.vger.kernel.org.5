Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6C7E6C52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjKIOQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjKIOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:16:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7D2D75;
        Thu,  9 Nov 2023 06:16:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902FEC433C7;
        Thu,  9 Nov 2023 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699539396;
        bh=Jefis7BJPm8d2mbZDQyqchWmfeq/UCjpqN3YEJnAzuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NrWES9zFfmZ+M/xaDGSbouhBx14MEPq6KNeXhRCqUIM5RH+F1Mmw51zawaulft5o9
         tCAWCyXGJ5MpxNjVBI40NliGHnFHCmg1NEoHtqpzG2tXoAbhDNGnRwwux8YK+QLOXn
         apPpkdZvcZxLgHr0EJWKWYBbKq8Xk8XNo5DvMF58=
Date:   Thu, 9 Nov 2023 15:16:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v3] tty: serial: Add RS422 flag to struct serial_rs485
Message-ID: <2023110919-properly-each-55f5@gregkh>
References: <20231108060719.11775-1-crescentcy.hsieh@moxa.com>
 <c247dda3-40d0-f1ab-fe59-2649f779f3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c247dda3-40d0-f1ab-fe59-2649f779f3@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 03:35:50PM +0200, Ilpo Järvinen wrote:
> On Wed, 8 Nov 2023, Crescent CY Hsieh wrote:
> 
> > Add "SER_RS485_MODE_RS422" flag to struct serial_rs485, so that serial
> > port can switch interface into RS422 if supported by using ioctl command
> > "TIOCSRS485".
> > 
> > By treating RS422 as a mode of RS485, which means while enabling RS422
> > there are two flags need to be set (SER_RS485_ENABLED and
> > SER_RS485_MODE_RS422), it would make things much easier. For example
> > some places that checks for "SER_RS485_ENABLED" won't need to be rewritten.
> > 
> > There are only two things need to be noticed:
> > 
> > - While enabling RS422, other RS485 flags should not be set.
> > - RS422 doesn't need to deal with termination, so while disabling RS485
> >   or enabling RS422, uart_set_rs485_termination() shall return.
> > 
> > Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> > 
> > ---
> > Changes from v2 to v3:
> > - Remove "SER_RS422_ENABLED" flag from legacy flags.
> > - Revise "SER_RS422_ENABLED" into "SER_RS485_MODE_RS422".
> > - Remove the code which checks the conflicts between SER_RS485_ENABLED
> >   and SER_RS422_ENABLED.
> > - Add return check in uart_set_rs485_termination().
> > 
> > Changes from v1 to v2:
> > - Revise the logic that checks whether RS422/RS485 are enabled
> >   simultaneously.
> > 
> > v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@moxa.com/
> > v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/
> > 
> > ---
> 
> > --- a/include/uapi/linux/serial.h
> > +++ b/include/uapi/linux/serial.h
> > @@ -137,17 +137,19 @@ struct serial_icounter_struct {
> >   * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> >   * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
> >   * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
> > + * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
> >   */
> >  struct serial_rs485 {
> >  	__u32	flags;
> > -#define SER_RS485_ENABLED		(1 << 0)
> > -#define SER_RS485_RTS_ON_SEND		(1 << 1)
> > -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
> > -#define SER_RS485_RX_DURING_TX		(1 << 4)
> > -#define SER_RS485_TERMINATE_BUS		(1 << 5)
> > -#define SER_RS485_ADDRB			(1 << 6)
> > -#define SER_RS485_ADDR_RECV		(1 << 7)
> > -#define SER_RS485_ADDR_DEST		(1 << 8)
> > +#define SER_RS485_ENABLED		BIT(0)
> > +#define SER_RS485_RTS_ON_SEND		BIT(1)
> > +#define SER_RS485_RTS_AFTER_SEND	BIT(2)
> > +#define SER_RS485_RX_DURING_TX		BIT(3)
> > +#define SER_RS485_TERMINATE_BUS		BIT(4)
> > +#define SER_RS485_ADDRB			BIT(5)
> > +#define SER_RS485_ADDR_RECV		BIT(6)
> > +#define SER_RS485_ADDR_DEST		BIT(7)
> > +#define SER_RS485_MODE_RS422		BIT(8)
> 
> Is BIT() allowed in uapi headers these days?

No, but there is something else that is, can't find it at the moment...
