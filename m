Return-Path: <linux-kernel+bounces-13128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8A820016
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A1C8B22227
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D20B125A1;
	Fri, 29 Dec 2023 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=linosanfilippo@gmx.de header.b="r2dZZbEa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743411CAE;
	Fri, 29 Dec 2023 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1703862196; x=1704466996; i=linosanfilippo@gmx.de;
	bh=AVsyOvF8iyVIZ+y0HTYWiJ5lv/jurTEehXeDcW566s0=;
	h=X-UI-Sender-Class:From:Subject:To:Cc:References:Date:
	 In-Reply-To;
	b=r2dZZbEaWPakyKajbHilP2dnmyJQIb86Rl008O7k9kDpUqJpmZQEZkjI/NXiK8rG
	 MnvCowJCC5OgZxpapX/fGY8SxDumm/i7qAlZayspO5DABfCL8PdKmD4Y2YnRV09JR
	 TmR+fpSUNJ1mwUOskIIoBrgZzrLIamEi2adOrQIK19sHEF039vFt+VjnDngfrAuV1
	 Es9klZjHMmjwV1MA9dqP1NpU34hNI2+tCLoNhxBp/YTY0Dwd0oA6bdrZ7nnw5Y+I/
	 c+/jpKt9464KyX6IwDzsyj9R/3fyRd7t4v/cdh8jOpnyGG8QyzF1ZwLOTIh6Emml9
	 aG+lcQpdgMCs2IVwag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.37] ([84.162.15.98]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvPJ-1rilU12tdd-00Rsyf; Fri, 29
 Dec 2023 16:03:16 +0100
From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: Re: [PATCH v6 1/7] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
To: Maarten Brock <m.brock@vanmierlo.com>,
 Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
 shawnguo@kernel.org, s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
 hugo@hugovil.com, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, lukas@wunner.de, p.rosenberger@kunbus.com,
 stable@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20231225113524.8800-1-l.sanfilippo@kunbus.com>
 <20231225113524.8800-2-l.sanfilippo@kunbus.com>
 <5177a7aef77a6b77a6e742a2fdd52a0e@vanmierlo.com>
Message-ID: <988518d5-0d4f-1362-64f9-8bfeb3e3b700@gmx.de>
Date: Fri, 29 Dec 2023 16:03:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5177a7aef77a6b77a6e742a2fdd52a0e@vanmierlo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p+fqf9l7jTjDJGxOH1YnDruj+CgRcfHEjHCkTRBGnhLYpt29OXV
 R50OBYMIgvUo5aIQm5sh9SxU6sVZXMnlFA0+GDq6udaQo3wcl+rbv34yuG5VN29b2Vlffu6
 zAvc8CpRqId2jLxcr6nPA9IofjPOvyAU9zamJUHNf+kGZ62cHjoS5DczHJqzwEn8+y+LMaq
 NrW/B/qTVorJKXXGloH4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sRL9VqN4ciI=;ndmP7eJWlwKe3/QqbuaaDjEotdN
 +lfLCMaxTEtl1BV/yENDeJ/gzs8DB07gKzSpOq7e3apLb0V1uvLKw5fsfA7CiBiWNv5ZObq/7
 rPU+FHhmV1K2wjdRauS9nHBy2nMsCTf+EqiPKv+QWb2VlAq7NgO6FfFXJ/wK6MZrx4l1TyfOW
 l55S6fF3ugQ6HRdKWHaQktYkNdXy5V6N/tyMmCGHdcwyKFAKdlRW7O7uLW/2e7/abIrr50YMG
 dwsshviwna+ZcnJTtrWeHAvacFSV4oo2tEzl5rRt51flvQVt4w9qIVHIRXsJ2+Tx6hvIDovoc
 BrP44nSYLAGYesBd9mnvQiZKbUG0kZrfzm0rYSpcZBTN4PuPVMJJQFfOFjx0+PE1vJdw3v/So
 tY7FKzrxBWScjjYSPvpu/d0s4LOMrUysgjQaSSYWxQB6GD3rrVlm5ORJta63SKvH2eTYTc5Ln
 3d1Mv464qX7tZ2DlaSZdjJ+DYZrkQGwRkwmZDg9yxSr2afb+EJpNJTYefd32S6/9f1G5fsw9s
 baOA12B2TIhjGQ2c/qmWUCKfwldpDzbIl5dneoOVdVSCGom1LDuO26R9+hjq9p139THl9vNMJ
 ENKm1w9G6dr0XSVwULfKC2LeeNRAcqeQt5R33JY7DZRyoq7vzVwiwnxK3UMtE6ElwVbmHnetP
 Sw2mLuMA19evwfCv0RGUDzL+LL9rgX3a58uayTI00t6N9ddNAUHUBgSo6Rl7i3szN3qRqoY5Z
 A6UjPnok9EKW5Ibb5MxGGf/fksFwC2wECE299A24b6oq2ZPddZXnJVrwV4JvObc6omsE56MO6
 H6S9R0IDuTTActmzsZdracFUSR9YDUqiNgnFaCVUNNHHl4bJRw/0VDcBXSf93kv96ohSWzZjE
 bTzLJDBrjHXHql2SCSSO4xgVOUBqimtjRdDNqjFohZT4N6bssbfQgOLgHb2pjQVuYlT/EO6VO
 jfmI1TOsZ8LrJBmsmJZr1O1y1BQ=


Hi,

On 25.12.23 at 13:31, Maarten Brock wrote:
> Lino Sanfilippo wrote on 2023-12-25 12:35:
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
>> index f1348a509552..d155131f221d 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -1402,6 +1402,16 @@ static void uart_set_rs485_termination(struct
>> uart_port *port,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!(rs485->flags & SER_RS485_TERMINATE_BU=
S));
>> =C2=A0}
>>
>> +static void uart_set_rs485_rx_during_tx(struct uart_port *port,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct serial_rs485 *r=
s485)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!(rs485->flags & SER_RS485_ENABLED))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>
> How about checking port->rs485_rx_during_tx_gpio here against NULL inste=
ad of
> before every call?
>

gpiod_set_value_cansleep() already checks for a NULL pointer, so doing thi=
s check
in the caller is not needed.

>> +=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(port->rs485_rx_during_tx_g=
pio,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!(rs485->flags & SER_RS485_RX_DURING_TX));
>> +}
>> +
>> =C2=A0static int uart_rs485_config(struct uart_port *port)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct serial_rs485 *rs485 =3D &port->rs485;
>> @@ -1413,12 +1423,17 @@ static int uart_rs485_config(struct uart_port *=
port)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_sanitize_serial_rs485(port, rs485);
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_set_rs485_termination(port, rs485);
>> +=C2=A0=C2=A0=C2=A0 uart_set_rs485_rx_during_tx(port, rs485);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_port_lock_irqsave(port, &flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D port->rs485_config(port, NULL, rs485);
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_port_unlock_irqrestore(port, flags);
>> -=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(rs485, 0, sizeo=
f(*rs485));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* unset GPIOs */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(po=
rt->rs485_term_gpio, 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(po=
rt->rs485_rx_during_tx_gpio, 0);
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0}
>> @@ -1457,6 +1472,7 @@ static int uart_set_rs485_config(struct
>> tty_struct *tty, struct uart_port *port,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_sanitize_serial_rs485(port, &rs485);
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_set_rs485_termination(port, &rs485);
>> +=C2=A0=C2=A0=C2=A0 uart_set_rs485_rx_during_tx(port, &rs485);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_port_lock_irqsave(port, &flags);
>> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D port->rs485_config(port, &tty->termios=
, &rs485);
>> @@ -1468,8 +1484,14 @@ static int uart_set_rs485_config(struct
>> tty_struct *tty, struct uart_port *port,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 port->ops->set_mctrl(port, port->mctrl);
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0 uart_port_unlock_irqrestore(port, flags);
>> -=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* restore old GPIO setting=
s */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(po=
rt->rs485_term_gpio,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!(=
port->rs485.flags & SER_RS485_TERMINATE_BUS));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(po=
rt->rs485_rx_during_tx_gpio,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!(=
port->rs485.flags & SER_RS485_RX_DURING_TX));
>
> This does not look like restoring.


Hmm. The rx-during-tx and terminate-bus GPIOs may have changed before the
drivers rs485_config() was called. If that function fails, the GPIOs
are set back to the values they had before (i.e what is still stored in
the ports serial_rs485 struct). So what is wrong with the term "restore"?

> Further this looks suspiciously like duplicated code

Since the added code consists of two one-liners I am not sure how to
decrease code duplication in this case. We could introduce wrapper functio=
ns (the only
ones we have so far to set the GPIOs are uart_set_rs485_termination() and
uart_set_rs485_rx_during_tx() which cannot be used here due to the initial
check for SER_RS485_ENABLED). But would that really help?


>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (copy_to_user(rs485_user, &port->rs485, siz=
eof(port->rs485)))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EFAULT;
>> diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm3=
2-usart.c
>> index 3048620315d6..ec9a72a5bea9 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -226,10 +226,7 @@ static int stm32_usart_config_rs485(struct
>> uart_port *port, struct ktermios *ter
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->=
uart_enable_bit));
>>
>> -=C2=A0=C2=A0=C2=A0 if (port->rs485_rx_during_tx_gpio)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpiod_set_value_cansleep(po=
rt->rs485_rx_during_tx_gpio,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !!(rs485conf->flags & =
SER_RS485_RX_DURING_TX));
>> -=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0 if (!port->rs485_rx_during_tx_gpio)
>
> Should the ! be there?
>

Thats a good point, the "else" seems indeed to be wrong. It has been intro=
duced
with the code that added the GPIO support (c54d48543689 "serial: stm32: Ad=
d support for rs485 RX_DURING_TX output GPIO")

I will fix it in the next version of this patch, thanks.


>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rs485conf->flags |=3D =
SER_RS485_RX_DURING_TX;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (rs485conf->flags & SER_RS485_ENABLED) {
>
> Kind Regards
> Maarten Brock
>

Thanks a lot for the review.

BR,
Lino

