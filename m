Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2FD80129B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379214AbjLAS1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAS1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:27:38 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7521D106;
        Fri,  1 Dec 2023 10:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=p15K61YVmkwcv6g72/Gggszer5DgJqcxM7vBW4kqy+M=; b=wSzSSMHzGaw6UDX7oDlqgnfE6V
        c5PQQf/HvCUKiwWcF2LS+PgZKvKA+00/e9NQBY5rXcMqtOctPOgKg9ABJbDZ9T4PxZcnXcQQhjtAi
        oLrcQ+mRijKn4t7+bg28UFugIUVBmGQ0YFvtOzCHErngUgwmZ8H4KoYAZp7FOq4LYxPY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52430 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r98Ei-00056U-Pr; Fri, 01 Dec 2023 13:27:38 -0500
Date:   Fri, 1 Dec 2023 13:27:36 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jan =?ISO-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc:     Mark Brown <broonie@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
Message-Id: <20231201132736.65cb0e2bff88fba85121c44a@hugovil.com>
In-Reply-To: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
References: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] tty: max310x: work around regmap->regcache data
 corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 15:51:51 +0100
Jan Kundr=E1t <jan.kundrat@cesnet.cz> wrote:

> The TL;DR summary is that the regmap_noinc_write spills over the data
> that are correctly written to the HW also to the following registers in
> the regcache. As a result, regcache then contains user-controlled
> garbage which will be used later for bit updates on unrelated registers.
>=20
> This patch is a "wrong" fix; a real fix would involve fixing regmap
> and/or regcache, but that code has too many indirections for my little
> mind.
>=20
> I was investigating a regression that happened somewhere between 5.12.4
> (plus 14 of our patches) and v6.5.9 (plus 7 of our patches). Our
> MAX14830 UART would work fine the first time, but when our application
> opens the UART the second time it just wouldn't send anything over the
> physical TX pin. With the help of a logical analyzer, I found out that
> the kernel was sending value 0xcd to the MODE1 register, which on this
> chip is a request to set the UART's TX pin to the Hi-Z mode and to
> switch off RX completely. That's certainly not the intention of the
> code, but that's what I was seeing on the physical SPI bus, and also in
> the log when I instrumented the regmap layer.
>=20
> It turned out that one of the *data* bytes which were sent over the UART
> was 0xdd, and that this *data byte* somehow ended up in the regcache's
> idea about the value within the MODE1 register. When the UART is opened
> up the next time and max310x_startup updates a single unrelated bit in
> MODE1, that code consults the regcache, notices the 0xdd data byte in
> there, and ends up sending 0xcd over SPI.
>=20
> Here's what dump_stack() shows:
>=20
>  max310x spi1.2: regcache_write: reg 0x9 value 0xdd
>  max310x spi1.2: PWNED
>  CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.5.9-7-g9e090fe75fd8 #7
>  Hardware name: Marvell Armada 380/385 (Device Tree)
>  Workqueue: events max310x_tx_proc
>   unwind_backtrace from show_stack+0x10/0x14
>   show_stack from dump_stack_lvl+0x40/0x4c
>   dump_stack_lvl from regcache_write+0xc0/0xc4
>   regcache_write from _regmap_raw_write_impl+0x178/0x828
>   _regmap_raw_write_impl from _regmap_raw_write+0xb8/0x134
>   _regmap_raw_write from regmap_noinc_write+0x130/0x178
>   regmap_noinc_write from max310x_tx_proc+0xd4/0x1a4
>   max310x_tx_proc from process_one_work+0x21c/0x4e4
>   process_one_work from worker_thread+0x50/0x54c
>   worker_thread from kthread+0xe0/0xfc
>   kthread from ret_from_fork+0x14/0x28
>=20
> Clearly, regmap_noinc_write of a register 0x00 (that's the TX FIFO on
> this chip) has no business updating register 0x09, but that's what was
> happening here. The regmap_config is already set up in a way that
> register 0x00 is marked precious and volatile, so it has no business
> going through the cache at all. Also, the documentation for
> regmap_noinc_write suggests that this driver was using the regmap
> infrastructure correctly, and that the real bug is somewhere in
> regmap/regcache where a call to regmap_noinc_write end up updating an
> unrelated register in regcache.

Hi Jan,
it is funny, as I am preparing to send a patch for the sc16is7xx driver
to convert FIFO R/W to use the _noinc_ versions of regmap functions,
inspired by your patch 3f42b142ea11 ("serial: max310x: fix IO data
corruption in batched operations").

I am testing on a custom board with two SC16IS752 in SPI mode.

Here is our current FIFO write code:

  regcache_cache_bypass(one->regmap, true);
  regmap_raw_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
  regcache_cache_bypass(one->regmap, false);

I am converting it to _noinc_ version to be able to remove the manual
(and ugly) cache control workaround to this:

  regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);

SC16IS7XX_THR_REG is already in precious and volatile, and I also
have put it in the noinc list.

To confirm that this works ok, I have put debug traces in some regmap
functions, and escpecially a trace in regcache_write() to indicate if
regmap is caching or not the register.

Here is an example when writing 01234567890123456789 (20 bytes) to the
Tx FIFO:

sc16is7xx spi0.0: sc16is7xx_tx_proc(): entry
sc16is7xx spi0.0: sc16is7xx_handle_tx(): entry
sc16is7xx spi0.0: regcache_read() not caching volatile reg $08
spi0.0-port0: regmap_read:  [08] 40
sc16is7xx spi0.0: regcache_write() not caching volatile reg $08
sc16is7xx spi0.0: _regmap_raw_write_impl() reg     =3D $00
sc16is7xx spi0.0: _regmap_raw_write_impl() val_len =3D 20
sc16is7xx spi0.0: regcache_write() not caching volatile reg $00
spi0.0-port0: regmap_write: [00] 30 31 32 33 34 35 36 37 38 39...
spi0.0-port0: regmap_write: [00] 36 37 38 39
...

With this I have confirmed that regmap _noinc_ works as intended, with
regcache_write() indicating it is not caching the volatile register 00
(THR).

I hope this can help you with your investigation, let me know if I can
help more.

Hugo Villeneuve.


=20
> Until regmap/regcache is fixed, let's just use an adapted version of the
> old code that bypasses regmap altogether, and just sends out an SPI
> transaction.
>=20
> This is related to my commit 3f42b142ea1171967e40e10e4b0241c0d6d28d41
> ("serial: max310x: fix IO data corruption in batched operations") which
> introduced usage of regmap_noinc_write() to this driver. That commit is
> a fixup of commit 285e76fc049c4d32c772eea9460a7ef28a193802 ("serial:
> max310x: use regmap methods for SPI batch operations") which started
> using regmap_raw_write(), which was however also a wrong function.
>=20
> Fixes: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched =
operations")
> Fixes: 285e76fc049c ("serial: max310x: use regmap methods for SPI batch o=
perations")
> Signed-off-by: Jan Kundr=E1t <jan.kundrat@cesnet.cz>
> To: Mark Brown <broonie@kernel.org>
> To: Cosmin Tanislav <cosmin.tanislav@analog.com>
> To: linux-serial@vger.kernel.org
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/tty/serial/max310x.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index c44237470bee..79797b573723 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -663,16 +663,34 @@ static u32 max310x_set_ref_clk(struct device *dev, =
struct max310x_port *s,
> =20
>  static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsig=
ned int len)
>  {
> -	struct max310x_one *one =3D to_max310x_port(port);
> -
> -	regmap_noinc_write(one->regmap, MAX310X_THR_REG, txbuf, len);
> +	const u8 header =3D (port->iobase * 0x20 + MAX310X_THR_REG) | MAX310X_W=
RITE_BIT;
> +	struct spi_transfer xfer[] =3D {
> +		{
> +			.tx_buf =3D &header,
> +			.len =3D 1,
> +		},
> +		{
> +			.tx_buf =3D txbuf,
> +			.len =3D len,
> +		},
> +	};
> +	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
>  }
> =20
>  static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsign=
ed int len)
>  {
> -	struct max310x_one *one =3D to_max310x_port(port);
> -
> -	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
> +	const u8 header =3D port->iobase * 0x20 + MAX310X_RHR_REG;
> +	struct spi_transfer xfer[] =3D {
> +		{
> +			.tx_buf =3D &header,
> +			.len =3D 1,
> +		},
> +		{
> +			.rx_buf =3D rxbuf,
> +			.len =3D len,
> +		},
> +	};
> +	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
>  }
> =20
>  static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
> --=20
> 2.42.0
>=20
>=20
>=20
