Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E1D8033A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjLDM7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjLDM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:59:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D694106
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:59:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4C8C4339A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701694767;
        bh=Xuo/9Xw0T3ZL/f6gtSBDt9WLA8ftkplvVnNqlwQno80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mu5y1HaGiumAJYSkoMa8sm8sgNk/d2dwR0a1klxnPNWno5YuvRRDn6XX7pD4Xn4XG
         FL4qZrE3nTOZh3kbEmz6hbzbZ1b2/OKu0QVAlheCHq+cQmQdaUwVxeFYYNXnVoIsvN
         3hKy4p376auFLD5o1vxzkJGAK/vN2IdB1/5OQuB0jPSMBe4GUFCq2tQh9sTZscGBG2
         ne/9bCGEmbpbgrKgO80sX+lgRdF+tZGWJVtZ24bW2CjvYYiSamsSmLbyjj3QdJEoPK
         6NTCmDYJxgEmiXMTVK3nttHYceuLNzrLCYA/m1EWmNbH+q6xn6d+/TsSwOu8xw6HEZ
         PzrqUoHyiPlZg==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5be30d543c4so1300836a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:59:27 -0800 (PST)
X-Gm-Message-State: AOJu0YzOOKl+9odMis/tDiatbSrJBq/pP4t4gKEoRQyqZFqzJBFdv/iy
        VSL6H8cULeqk9aoOR5ScPpCuvFEyNoZVxi0d5QkMew==
X-Google-Smtp-Source: AGHT+IHfJJRhmZSRmC6gb+uuZ6g8xOkDk5TCuCssAUr46HqkpCHlIvrNioDI7Di+SsbN+mnos/NpCMNHm5sQn1rytIk=
X-Received: by 2002:a17:90a:196:b0:286:71c6:6b69 with SMTP id
 22-20020a17090a019600b0028671c66b69mr1369762pjc.24.1701694767449; Mon, 04 Dec
 2023 04:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20231115121338.22959-1-francesco@dolcini.it> <20231115121338.22959-2-francesco@dolcini.it>
In-Reply-To: <20231115121338.22959-2-francesco@dolcini.it>
From:   Robert Foss <rfoss@kernel.org>
Date:   Mon, 4 Dec 2023 13:59:16 +0100
X-Gmail-Original-Message-ID: <CAN6tsi7MNdG1Z3RW17gbOvUYbwc3=YrG4NnrW=XLF+GyvHk3MQ@mail.gmail.com>
Message-ID: <CAN6tsi7MNdG1Z3RW17gbOvUYbwc3=YrG4NnrW=XLF+GyvHk3MQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/bridge: lt8912b: Add suspend/resume support
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
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
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
> Add support for suspend and resume. The lt8912b will power off when
> going into suspend and power on when resuming.
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 03532efb893b..097ab04234b7 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -634,6 +634,33 @@ static const struct drm_bridge_funcs lt8912_bridge_f=
uncs =3D {
>         .get_edid =3D lt8912_bridge_get_edid,
>  };
>
> +static int lt8912_bridge_resume(struct device *dev)
> +{
> +       struct lt8912 *lt =3D dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret =3D lt8912_hard_power_on(lt);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D lt8912_soft_power_on(lt);
> +       if (ret)
> +               return ret;
> +
> +       return lt8912_video_on(lt);
> +}
> +
> +static int lt8912_bridge_suspend(struct device *dev)
> +{
> +       struct lt8912 *lt =3D dev_get_drvdata(dev);
> +
> +       lt8912_hard_power_off(lt);
> +
> +       return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(lt8912_bridge_pm_ops, lt8912_bridge_susp=
end, lt8912_bridge_resume);
> +
>  static int lt8912_parse_dt(struct lt8912 *lt)
>  {
>         struct gpio_desc *gp_reset;
> @@ -770,6 +797,7 @@ static struct i2c_driver lt8912_i2c_driver =3D {
>         .driver =3D {
>                 .name =3D "lt8912",
>                 .of_match_table =3D lt8912_dt_match,
> +               .pm =3D pm_sleep_ptr(&lt8912_bridge_pm_ops),
>         },
>         .probe =3D lt8912_probe,
>         .remove =3D lt8912_remove,
> --
> 2.25.1
>

Reviewed-by: Robert Foss <rfoss@kernel.org>
