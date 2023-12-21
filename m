Return-Path: <linux-kernel+bounces-8711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B7981BB57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07BF31F21D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBDB55E41;
	Thu, 21 Dec 2023 15:53:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0BA539FD;
	Thu, 21 Dec 2023 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 2F054100B08FA;
	Thu, 21 Dec 2023 16:53:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 009392AE38; Thu, 21 Dec 2023 16:53:05 +0100 (CET)
Date: Thu, 21 Dec 2023 16:53:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"brenda.streiff@ni.com" <brenda.streiff@ni.com>,
	Tomas Paukrt <tomaspaukrt@email.cz>
Subject: Re: [PATCH 1/2] dt-bindings: serial: rs485: add rs485-mux-gpios
 binding
Message-ID: <20231221155305.GA13673@wunner.de>
References: <20231120151056.148450-1-linux@rasmusvillemoes.dk>
 <20231120151056.148450-2-linux@rasmusvillemoes.dk>
 <20231122145344.GA18949@wunner.de>
 <3b8548b1-b8a9-0c9e-4040-5cfda06a85c6@gmx.de>
 <ec66d25162de4cbc92720df1e7008fe8@dh-electronics.com>
 <5c140498-69e3-4187-8703-db0c41e7ca89@gmx.de>
 <fe28eb93-daa1-41af-a005-f21aa87e1984@gmx.de>
 <ZXcJr4VS_uGr_6TV@smile.fi.intel.com>
 <ZXrX4mQXPLum0jL3@moxa-ThinkCentre-M90t>
 <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b35730df8288469fbaf67b5ceae4eece@dh-electronics.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Dec 14, 2023 at 01:41:47PM +0000, Christoph Niedermaier wrote:
> I will summarize the current situation from my point of view, maybe it helps:
> 
> RS-232:
>   - Full Duplex Point-to-Point connection
>   - No transceiver control with RTS
>   - No termination
>   - No extra struct in use
> 
> RS-422:
>   - Full Duplex Point-to-Point connection
>   - No transceiver control with RTS needed
>   - Termination possible
>   - Extra struct serial_rs485 needed if termination is used
>  => RS-422 can be used in RS-232 operation, but if a termination should be
>     switchable the RS485 flag has to be enabled. But then also transceiver
>     control will be enabled. Not a very satisfying situation.

Well why don't we just allow enabling or disabling RS-485 termination
independently from the SER_RS485_ENABLED bit in struct serial_rs485?

Just let the user issue a TIOCSRS485 ioctl to toggle termination even
if in RS-232 mode and use that mode for RS-422.

Looks like the simplest solution to me.


> RS-485 (2-wire) very common:
>   - Half Duplex RS-485 bus
>   - Transceiver control with RTS is needed
>   - Termination possible
>   - Extra struct serial_rs485 is needed
>  => RS-485 has to be enabled and configured:
>     - Set SER_RS485_ENABLED 
>     - Set SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND
>     - Set/clear SER_RS485_RX_DURING_TX depending on whether
>       the receiver path should be on or off during sending.
>       If it's set it allows to monitor the sending on the bus
>       and detect whether another bus device is transmitting
>       at the same time.
>     - Set/clear SER_RS485_TERMINATE_BUS for bus termination.
> 
> RS-485 (4-wire) little used:
>   - Full Duplex RS-485 bus
>   - Transceiver control with RTS is needed
>   - Termination possible
>   - Extra struct serial_rs485 is needed
>  => RS-485 has to be enabled and configured:
>     - Set SER_RS485_ENABLED 
>     - Set SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND
>     - Set SER_RS485_RX_DURING_TX, as the receiver should always
>       be enabled independently of TX, because TX and RX are
>       separated from each other by their own wires.
>     - Set/clear SER_RS485_TERMINATE_BUS for bus termination.

Thanks for that overview, I found it very helpful.

One small addendum:  Hardware flow control.  Only possible with
RS-232.  Doesn't work in any of the other modes, right?

Thanks,

Lukas

