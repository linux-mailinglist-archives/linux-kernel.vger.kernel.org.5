Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24DF8033A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjLDM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjLDM6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:58:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796CD7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:59:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8394C433D9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701694739;
        bh=7dgUCGHzMoPBZl2tDe1rIHvMaAhMu3JQbSWiCGiui6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uRjmfRsC3a+igtsBpD6wf5ipmviGpCi/X/y4EC8fnnn0KDS6QiRjhTVBv+heaOafa
         ytOJXaa0MD7qIclVnbi7svyejzbTUEB+lBpzKX/f2qgQlI1uz/ekb4od/loEVlngg+
         +DOAjizYQPEkeUKenEv5olTi9RppfTS7ORPmUg2V8TKtCrau+bf5geO1DufNA0b5hv
         63UUho/A80UG5ZLHm1D3h8gMSqA3MQlZNgdVepA7Wi3S7RSKmqVM8nuBqn4yuMWDGn
         /kAExOeNTqE0g9xrikgDRGh8GO86aAxhkXgqHYPVkN9tOyr48oAFl4zNyus3Rj+wK6
         IX83cJGXu1Axw==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5b9a456798eso1173549a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:58:59 -0800 (PST)
X-Gm-Message-State: AOJu0YyQlmzIJQajzJYpXoBe9MgFXQr6QTvarweZR+uMwVjQVOs0SGGs
        /EAtInJKgB5VCfHcdsAc3LScrevSrAQWt6KxeacW5Q==
X-Google-Smtp-Source: AGHT+IGoBM1mO4+FKfPHfVAarHazScsJwRRCDteV6vPmRupL4DGsxj2JC8dqLAUQL8DV4spvS+XM9g1zJMQ7WuCYaBs=
X-Received: by 2002:a17:90b:4f44:b0:285:9ec0:892a with SMTP id
 pj4-20020a17090b4f4400b002859ec0892amr1119686pjb.33.1701694739111; Mon, 04
 Dec 2023 04:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20231115121338.22959-1-francesco@dolcini.it> <20231115121338.22959-4-francesco@dolcini.it>
In-Reply-To: <20231115121338.22959-4-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 4 Dec 2023 13:58:46 +0100
X-Gmail-Original-Message-ID: <CAN6tsi4HX1BtR9BG0H3N9c9j1q2iVAvHh4SM=ZLnog52ncqSqg@mail.gmail.com>
Message-ID: <CAN6tsi4HX1BtR9BG0H3N9c9j1q2iVAvHh4SM=ZLnog52ncqSqg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/bridge: lt8912b: Add power supplies
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Nov 15, 2023 at 1:14=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> Add supplies to the driver that can be used to turn the Lontium lt8912b
> on and off. It can have up to 7 independent supplies, we add them all
> and enable/disable them with bulk_enable/disable.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 30 ++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 097ab04234b7..273157428c82 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -43,6 +43,8 @@ struct lt8912 {
>
>         struct videomode mode;
>
> +       struct regulator_bulk_data supplies[7];
> +
>         u8 data_lanes;
>         bool is_power_on;
>  };
> @@ -257,6 +259,12 @@ static int lt8912_free_i2c(struct lt8912 *lt)
>
>  static int lt8912_hard_power_on(struct lt8912 *lt)
>  {
> +       int ret;
> +
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(lt->supplies), lt->suppl=
ies);
> +       if (ret)
> +               return ret;
> +
>         gpiod_set_value_cansleep(lt->gp_reset, 0);
>         msleep(20);
>
> @@ -267,6 +275,9 @@ static void lt8912_hard_power_off(struct lt8912 *lt)
>  {
>         gpiod_set_value_cansleep(lt->gp_reset, 1);
>         msleep(20);
> +
> +       regulator_bulk_disable(ARRAY_SIZE(lt->supplies), lt->supplies);
> +
>         lt->is_power_on =3D false;
>  }
>
> @@ -661,6 +672,21 @@ static int lt8912_bridge_suspend(struct device *dev)
>
>  static DEFINE_SIMPLE_DEV_PM_OPS(lt8912_bridge_pm_ops, lt8912_bridge_susp=
end, lt8912_bridge_resume);
>
> +static int lt8912_get_regulators(struct lt8912 *lt)
> +{
> +       unsigned int i;
> +       const char * const supply_names[] =3D {
> +               "vdd", "vccmipirx", "vccsysclk", "vcclvdstx",
> +               "vcchdmitx", "vcclvdspll", "vcchdmipll"
> +       };
> +
> +       for (i =3D 0; i < ARRAY_SIZE(lt->supplies); i++)
> +               lt->supplies[i].supply =3D supply_names[i];
> +
> +       return devm_regulator_bulk_get(lt->dev, ARRAY_SIZE(lt->supplies),
> +                                      lt->supplies);
> +}
> +
>  static int lt8912_parse_dt(struct lt8912 *lt)
>  {
>         struct gpio_desc *gp_reset;
> @@ -712,6 +738,10 @@ static int lt8912_parse_dt(struct lt8912 *lt)
>                 goto err_free_host_node;
>         }
>
> +       ret =3D lt8912_get_regulators(lt);
> +       if (ret)
> +               goto err_free_host_node;
> +
>         of_node_put(port_node);
>         return 0;
>
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
