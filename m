Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D20800FCE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjLAQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjLAQAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:00:30 -0500
Received: from office2.cesnet.cz (office2.cesnet.cz [IPv6:2001:718:ff05:10b::237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BF019E;
        Fri,  1 Dec 2023 08:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1701446433;
        bh=LRobM5gphSx+0LDN8LfiPwDMnavqYci9YHClgfmAcCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z8pcG1mDeQevUIfttZttXOyVVCPpOwwbU6lodX+c7l/LIqF8dOI8h/4u99Wwk2fMO
         a+63ORMzWFugroaiwi49M+BKiZDPrk6OQzoD6XuodSYMv8v1WGByZO6VVdOucHHSDe
         BCB8J5uX0Wqymai2Byx0V9AjVhUSe0NZTs4eilUHkGMc4kRk0o700NTfRhvPCrDXZk
         Pj06ELKIALPdO5Mu1dKcSY6/F5Qlh9DJ9GZ+EPO4y0Kwq850gjX9B5jSJotkE0XW2T
         TjUVExX9xib++HjRudpmZ6wHkUWDBAb8zQYAp1roczT5Tk8gwxAp9GkNtCywU/dNfT
         shViphMRmEEbg==
Received: from localhost (tlha232.cesnet.cz [IPv6:2001:718:1:6::134:232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 366FF118007E;
        Fri,  1 Dec 2023 17:00:30 +0100 (CET)
From:   =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <hvilleneuve@dimonoff.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 7/7] serial: max310x: use separate regmap name for each =?iso-8859-1?Q?port?=
Date:   Fri, 01 Dec 2023 17:00:30 +0100
MIME-Version: 1.0
Message-ID: <77f101f1-897d-4e6d-a8fd-27b818caf768@cesnet.cz>
In-Reply-To: <20231130191050.3165862-8-hugo@hugovil.com>
References: <20231130191050.3165862-1-hugo@hugovil.com>
 <20231130191050.3165862-8-hugo@hugovil.com>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.10; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C4=8Dtvrtek 30. listopadu 2023 20:10:49 CET, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Use a separate regmap name for each port so that each port can have its own=

> debugfs entry, allowing to access each port registers independently.
>
> For example, a four channels/ports device like the MAX14830 will have four
> entries in its regmap debugfs:
>
> $ find /sys/kernel/debug/regmap -type d | grep spi0.0
> /sys/kernel/debug/regmap/spi0.0-port0
> /sys/kernel/debug/regmap/spi0.0-port1
> /sys/kernel/debug/regmap/spi0.0-port2
> /sys/kernel/debug/regmap/spi0.0-port3
>
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

I was carrying a similar patch locally, and this one works for me as well.

Reviewed-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>
Tested-by: Jan Kundr=C3=A1t <jan.kundrat@cesnet.cz>

> ---
>  drivers/tty/serial/max310x.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 58dd5cc62014..d2eca05a6966 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -27,6 +27,7 @@
>  #include <linux/uaccess.h>
> =20
>  #define MAX310X_NAME=09=09=09"max310x"
> +#define MAX310X_PORT_NAME_SUFFIX=09"port"
>  #define MAX310X_MAJOR=09=09=09204
>  #define MAX310X_MINOR=09=09=09209
>  #define MAX310X_UART_NRMAX=09=0916
> @@ -1486,6 +1487,15 @@ static struct regmap_config regcfg =3D {
>  =09.max_raw_write =3D MAX310X_FIFO_SIZE,
>  };
> =20
> +static const char *max310x_regmap_name(unsigned int port_id)
> +{
> +=09static char buf[sizeof(MAX310X_PORT_NAME_SUFFIX=20
> __stringify(MAX310X_MAX_PORTS))];
> +
> +=09snprintf(buf, sizeof(buf), MAX310X_PORT_NAME_SUFFIX "%u", port_id);
> +
> +=09return buf;
> +}
> +
>  #ifdef CONFIG_SPI_MASTER
>  static int max310x_spi_extended_reg_enable(struct device *dev, bool enable=
)
>  {
> @@ -1521,6 +1531,8 @@ static int max310x_spi_probe(struct spi_device *spi)
> =20
>  =09for (i =3D 0; i < devtype->nr; i++) {
>  =09=09u8 port_mask =3D i * 0x20;
> +
> +=09=09regcfg.name =3D max310x_regmap_name(i);
>  =09=09regcfg.read_flag_mask =3D port_mask;
>  =09=09regcfg.write_flag_mask =3D port_mask | MAX310X_WRITE_BIT;
>  =09=09regmaps[i] =3D devm_regmap_init_spi(spi, &regcfg);
> @@ -1617,6 +1629,7 @@ static int max310x_i2c_probe(struct=20
> i2c_client *client)
>  =09=09=09=09     client->addr, devtype->slave_addr.min,
>  =09=09=09=09     devtype->slave_addr.max);
> =20
> +=09regcfg_i2c.name =3D max310x_regmap_name(0);
>  =09regmaps[0] =3D devm_regmap_init_i2c(client, &regcfg_i2c);
> =20
>  =09for (i =3D 1; i < devtype->nr; i++) {
> @@ -1625,6 +1638,7 @@ static int max310x_i2c_probe(struct=20
> i2c_client *client)
>  =09=09=09=09=09=09=09client->adapter,
>  =09=09=09=09=09=09=09port_addr);
> =20
> +=09=09regcfg_i2c.name =3D max310x_regmap_name(i);
>  =09=09regmaps[i] =3D devm_regmap_init_i2c(port_client, &regcfg_i2c);
>  =09}
> =20

