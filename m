Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927E8808AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443382AbjLGOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443335AbjLGOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:43:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CF5AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:43:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F247C433C8;
        Thu,  7 Dec 2023 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701960204;
        bh=ZB2DauAIH9sieCvspymkqF88MIq6wzjcMQoKXrlFZrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XbZu5YQ1UgWnVOJqGNP7exbnBaqWJIH47N3tl+XPxKNZhx42XAVuRQ+6+ZcSMwCQh
         Lk4SGrACSHqBQsnu3C0BJOjG5am+V3xo6ybS1H4wLUFFugYrsLQxPc8MnO7n1bl4AC
         o+EvC4K+KYqTK1Hj6JglxfcMMe6u1rvL8iAWPD3YJI4BpVUiuApPaEVFVxrtz0MO8t
         mIvKVSnk3jCUKpnNWu4IT/i7mnx/9mAWJDuJJuQotyHQVnOOuR4CAeBBSvshOTQqsb
         4DdoklGU/kLFq6/5fWsPk6Cds091W55hwY7aL/7gWQv2XCd1DF+eA/MxylHxgaZYW6
         TX9HoWvIW8rZA==
Date:   Thu, 7 Dec 2023 15:43:20 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Sjoerd Simons <sjoerd@collabora.com>
Cc:     kernel@collabora.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bus: moxtet: Add spi device table
Message-ID: <20231207154320.4bd7d7a0@dellmb>
In-Reply-To: <20231128213536.3764212-3-sjoerd@collabora.com>
References: <20231128213536.3764212-1-sjoerd@collabora.com>
        <20231128213536.3764212-3-sjoerd@collabora.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 22:35:05 +0100
Sjoerd Simons <sjoerd@collabora.com> wrote:

> The moxtet module fails to auto-load on. Add a SPI id table to
> allow it to do so.
>=20
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> Cc: stable@vger.kernel.org
>=20
> ---
>=20
> (no changes since v1)
>=20
>  drivers/bus/moxtet.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
> index 48c18f95660a..e384fbc6c1d9 100644
> --- a/drivers/bus/moxtet.c
> +++ b/drivers/bus/moxtet.c
> @@ -830,6 +830,12 @@ static void moxtet_remove(struct spi_device *spi)
>  	mutex_destroy(&moxtet->lock);
>  }
> =20
> +static const struct spi_device_id moxtet_spi_ids[] =3D {
> +	{ "moxtet" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, moxtet_spi_ids);
> +
>  static const struct of_device_id moxtet_dt_ids[] =3D {
>  	{ .compatible =3D "cznic,moxtet" },
>  	{},
> @@ -841,6 +847,7 @@ static struct spi_driver moxtet_spi_driver =3D {
>  		.name		=3D "moxtet",
>  		.of_match_table =3D moxtet_dt_ids,
>  	},
> +	.id_table	=3D moxtet_spi_ids,
>  	.probe		=3D moxtet_probe,
>  	.remove		=3D moxtet_remove,
>  };

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
