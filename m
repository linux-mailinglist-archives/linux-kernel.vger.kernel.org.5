Return-Path: <linux-kernel+bounces-14600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21973821F6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41FD1F22F03
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E314F7B;
	Tue,  2 Jan 2024 16:24:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BDF15481;
	Tue,  2 Jan 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vanmierlo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vanmierlo.com
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
	(authenticated user m.brock@vanmierlo.com)
	by connect.vanmierlo.com (Kerio Connect 10.0.3 patch 1) with ESMTPA;
	Tue, 2 Jan 2024 16:53:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jan 2024 16:53:52 +0100
From: Maarten Brock <m.brock@vanmierlo.com>
To: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
 u.kleine-koenig@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 cniedermaier@dh-electronics.com, hugo@hugovil.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, lukas@wunner.de,
 p.rosenberger@kunbus.com, stable@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v6 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
In-Reply-To: <988518d5-0d4f-1362-64f9-8bfeb3e3b700@gmx.de>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
 <20231225113524.8800-2-l.sanfilippo@kunbus.com>
 <5177a7aef77a6b77a6e742a2fdd52a0e@vanmierlo.com>
 <988518d5-0d4f-1362-64f9-8bfeb3e3b700@gmx.de>
Message-ID: <a7f55acaba62183586422e0202fa90ef@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Lino Sanfilippo wrote on 2023-12-29 16:03:
> Hi,
> 
> On 25.12.23 at 13:31, Maarten Brock wrote:
>> Lino Sanfilippo wrote on 2023-12-25 12:35:
>>> diff --git a/drivers/tty/serial/serial_core.c 
>>> b/drivers/tty/serial/serial_core.c
>>> +static void uart_set_rs485_rx_during_tx(struct uart_port *port,
>>> +                    const struct serial_rs485 *rs485)
>>> +{
>>> +    if (!(rs485->flags & SER_RS485_ENABLED))
>>> +        return;
>> 
>> How about checking port->rs485_rx_during_tx_gpio here against NULL 
>> instead of
>> before every call?
> 
> gpiod_set_value_cansleep() already checks for a NULL pointer, so doing
> this check in the caller is not needed.

Ah, sorry, you're right.

>>> +    gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>>> +                 !!(rs485->flags & SER_RS485_RX_DURING_TX));
>>> +}
>>> +
>>> @@ -1457,6 +1472,7 @@ static int uart_set_rs485_config(struct
>>> tty_struct *tty, struct uart_port *port,
>>>          return ret;
>>>      uart_sanitize_serial_rs485(port, &rs485);
>>>      uart_set_rs485_termination(port, &rs485);
>>> +    uart_set_rs485_rx_during_tx(port, &rs485);
>>> 
>>>      uart_port_lock_irqsave(port, &flags);
>>>      ret = port->rs485_config(port, &tty->termios, &rs485);
>>> @@ -1468,8 +1484,14 @@ static int uart_set_rs485_config(struct
>>> tty_struct *tty, struct uart_port *port,
>>>              port->ops->set_mctrl(port, port->mctrl);
>>>      }
>>>      uart_port_unlock_irqrestore(port, flags);
>>> -    if (ret)
>>> +    if (ret) {
>>> +        /* restore old GPIO settings */
>>> +        gpiod_set_value_cansleep(port->rs485_term_gpio,
>>> +            !!(port->rs485.flags & SER_RS485_TERMINATE_BUS));
>>> +        gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
>>> +            !!(port->rs485.flags & SER_RS485_RX_DURING_TX));
>> 
>> This does not look like restoring.
> 
> Hmm. The rx-during-tx and terminate-bus GPIOs may have changed before 
> the
> drivers rs485_config() was called. If that function fails, the GPIOs
> are set back to the values they had before (i.e what is still stored in
> the ports serial_rs485 struct). So what is wrong with the term 
> "restore"?

Oops, I missed that too that port-rs485 is not updated in this case.

Kind Regards,
Maarten Brock


