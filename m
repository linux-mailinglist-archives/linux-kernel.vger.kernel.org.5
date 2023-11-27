Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5325A7F9C61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 10:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjK0JJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 04:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjK0JJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 04:09:26 -0500
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E6F125
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 01:09:32 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Sf0CD5cSKzMpykB;
        Mon, 27 Nov 2023 09:09:28 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Sf0CC6WJMzMppcc;
        Mon, 27 Nov 2023 10:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bigler.io;
        s=20200409; t=1701076168;
        bh=AZrND3sqXyH2z226vTZZ/SZJmPQAxaZthdQvK8/rTIU=;
        h=Date:Subject:From:Reply-To:To:Cc:References:In-Reply-To:From;
        b=LrK2S2ZwZPhI2cRxTyHf4zQw7MhDewwmuXH2lGGSp6uHAiw5HfkVaACDKogWqhrcQ
         2Cmbrg7xprk30xHIQjsgLd29+JcVxLWHyJ9TQJSS1Fu/ql+WxwM8YXL9F+/3ozDeJF
         5Dv2voqChOcRpuJH8kby1OwO6j6ki1jLElIXHXLk=
Message-ID: <89209fbb46c4ce650141ecb6fdf06476@mail.infomaniak.com>
Date:   Mon, 27 Nov 2023 10:09:27 +0100
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
From:   linux@bigler.io
Reply-To: linux@bigler.io
To:     Benjamin Bigler <benjamin@bigler.one>
Cc:     broonie@kernel.org, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        regressions@lists.linux.dev, stefan.moring@technolution.nl
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IjhubE1QemJPdVI4amxlWHlvcy9Tdnc9PSIsInZhbHVlIjoiVlNieTNiZXQ0cFAwMFZGS1M3ZDhSQT09IiwibWFjIjoiMTk1YTQwMGE0NDc0YzE0NjEyOWJmM2YyMGMyYzhlZTVjYjQxODhlOWU3NTgwNTA1MDkwYzJmOGM4MmM3NjJiNiIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6ImR5Tm5EQytBZHUyeXc5d3I3SkFzZnc9PSIsInZhbHVlIjoidkVUbnQzeFRMV0hwbkhGNGlWcWhBQT09IiwibWFjIjoiZTJkOWFiMjEyZDg2ZGM2OGYwMjc3ODgxYzZiZWQ5MjE2ZjBkOTZhMDNjYjliODBmMWY5NWY2ZTVhOGYxOWI2OSIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.601)
References: <c7a38307ac74a973e26ac820a0b98773262720bd.camel@bigler.one>
In-Reply-To: <c7a38307ac74a973e26ac820a0b98773262720bd.camel@bigler.one>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi=20

Thank you Benjamin for the patch.
I have tested the patch and is works fine.

Best regards
Stefan Bigler

Am 2023-11-26T14:19:56.000+01:00 hat Benjamin Bigler <benjamin@bigler.one> =
geschrieben:
>  Hi
>=20
> I did some debugging and I think the problem is that in this case bits_pe=
r_word is 8. So in
> spi_imx_dma_configure the buswidth is set to DMA_SLAVE_BUSWIDTH_1_BYTE. B=
ut in
> mx51_ecspi_prepare_transfer the BURST_LENGTH is now set to (spi_imx->coun=
t * spi_imx->bits_per_word
> - 1)
> before 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f it was (spi_imx->bits_per=
_word - 1). Now the spi
> transmits 4 byte per byte except for the first word. I added the followin=
g patch and it worked again
>=20
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 498e35c8db2c..f514966e2ada 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -659,11 +659,22 @@ static int mx51_ecspi_prepare_transfer(struct spi_i=
mx_data *spi_imx,
>  =09=09ctrl |=3D (spi_imx->target_burst * 8 - 1)
>  =09=09=09<< MX51_ECSPI_CTRL_BL_OFFSET;
>  =09else {
> -=09=09if (spi_imx->count &gt;=3D 512)
> -=09=09=09ctrl |=3D 0xFFF << MX51_ECSPI_CTRL_BL_OFFSET;
> -=09=09else
> -=09=09=09ctrl |=3D (spi_imx->count * spi_imx->bits_per_word - 1)
> +=09=09if (spi_imx->usedma)
> +=09=09=09ctrl |=3D (spi_imx->bits_per_word *
> +=09=09=09=09=09 spi_imx_bytes_per_word(
> +=09=09=09=09=09=09 spi_imx->bits_per_word) -
> +=09=09=09=09 1)
>  =09=09=09=09<< MX51_ECSPI_CTRL_BL_OFFSET;
> +=09=09else {
> +=09=09=09if (spi_imx->count &gt;=3D MX51_ECSPI_CTRL_MAX_BURST)
> +=09=09=09=09ctrl |=3D (MX51_ECSPI_CTRL_MAX_BURST - 1)
> +=09=09=09=09=09<< MX51_ECSPI_CTRL_BL_OFFSET;
> +=09=09=09else
> +=09=09=09=09ctrl |=3D (spi_imx->count *
> +=09=09=09=09=09=09 spi_imx->bits_per_word -
> +=09=09=09=09=09 1)
> +=09=09=09=09=09<< MX51_ECSPI_CTRL_BL_OFFSET;
> +=09=09}
>  =09}
> =20
>  =09/* set clock speed */
>=20
> Best regards,
Benjamin Bigler
