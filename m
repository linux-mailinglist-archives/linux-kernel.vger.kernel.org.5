Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906B8770418
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHDPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjHDPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D4D4EE5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA05362064
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E6BC43395
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691161812;
        bh=k/WEV4wChuXrYdiVjfZQg92NekohcL6BMfLucYkhImI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DeqIpYcYPsJrb5GoacN0Bs+9uHCfU0qlOXefyRIw345uQW+COgwQECJGhZLwO6oX9
         NaMp+PQGGsKq3Nk1G17T4KJspQgLBpKj2OPesmFXhaWlTY6qeCA7nF+2jN+EsezlHZ
         IWGQOi9d23l2uwqOdptBKqKjUZ20qQfVfSBsvb7AQQHTfTrII6k0e4CuhsXW9150KP
         EG83O95mTUJw5XHZzDdQHMSZ4n1+1Du4uQB1b82S6zuDFC/v4rxzAY3zKn13edqom/
         Oy+RyimmjBoNBQDzZmEXP62o+KVcUmm1+VJKS99rM40pkEilOG2LNaZEWAhJXzp/3v
         yenJZ/ZH6dBcw==
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bbc7b2133fso15629695ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:10:12 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlR7mDkEOeqsB2kr8Gr6lGvpEd6sx/3EG5YRHeWqFhTI0iWJ8f
        4LCRbJX8TWvk0GnVuQUXi7mLq8cQcqIrRn9NO1Q0PQ==
X-Google-Smtp-Source: AGHT+IElvAxN2zei6BanZFW0NwWKaaCidPWt1sbwnVPv5pTqIYIdvy4XQVOTTtbdkHsd177fmMf8SmGydpiw77jCVmM=
X-Received: by 2002:a17:90a:1bc6:b0:267:e011:3e9a with SMTP id
 r6-20020a17090a1bc600b00267e0113e9amr1495780pjr.3.1691161811724; Fri, 04 Aug
 2023 08:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230804-lt8912b-v1-0-c542692c6a2f@ideasonboard.com> <20230804-lt8912b-v1-1-c542692c6a2f@ideasonboard.com>
In-Reply-To: <20230804-lt8912b-v1-1-c542692c6a2f@ideasonboard.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Fri, 4 Aug 2023 17:10:01 +0200
X-Gmail-Original-Message-ID: <CAN6tsi7yxLNvXTVz-xzksr-E9SRmB5Hscc=Hue1G5T+5QZb5HA@mail.gmail.com>
Message-ID: <CAN6tsi7yxLNvXTVz-xzksr-E9SRmB5Hscc=Hue1G5T+5QZb5HA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: lt8912b: Fix bridge_detach
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Adrien Grassein <adrien.grassein@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 12:48=E2=80=AFPM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> The driver calls lt8912_bridge_detach() from its lt8912_remove()
> function. As the DRM core detaches bridges automatically, this leads to
> calling lt8912_bridge_detach() twice. The code probably has tried to
> manage the double-call with the 'is_attached' variable, but the driver
> never sets the variable to false, so its of no help.
>
> Fix the issue by dropping the call to lt8912_bridge_detach() from
> lt8912_remove(), as the DRM core will handle the detach call for us,
> and also drop the useless is_attached field.
>
> Fixes: 88abfc2b9e61 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt8912b.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/b=
ridge/lontium-lt8912b.c
> index 4eaea67fb71c..0e581f6e3c88 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
> @@ -45,7 +45,6 @@ struct lt8912 {
>
>         u8 data_lanes;
>         bool is_power_on;
> -       bool is_attached;
>  };
>
>  static int lt8912_write_init_config(struct lt8912 *lt)
> @@ -575,8 +574,6 @@ static int lt8912_bridge_attach(struct drm_bridge *br=
idge,
>         if (ret)
>                 goto error;
>
> -       lt->is_attached =3D true;
> -
>         return 0;
>
>  error:
> @@ -588,15 +585,13 @@ static void lt8912_bridge_detach(struct drm_bridge =
*bridge)
>  {
>         struct lt8912 *lt =3D bridge_to_lt8912(bridge);
>
> -       if (lt->is_attached) {
> -               lt8912_hard_power_off(lt);
> +       lt8912_hard_power_off(lt);
>
> -               if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
> -                       drm_bridge_hpd_disable(lt->hdmi_port);
> +       if (lt->hdmi_port->ops & DRM_BRIDGE_OP_HPD)
> +               drm_bridge_hpd_disable(lt->hdmi_port);
>
> -               drm_connector_unregister(&lt->connector);
> -               drm_connector_cleanup(&lt->connector);
> -       }
> +       drm_connector_unregister(&lt->connector);
> +       drm_connector_cleanup(&lt->connector);
>  }
>
>  static enum drm_connector_status
> @@ -750,7 +745,6 @@ static void lt8912_remove(struct i2c_client *client)
>  {
>         struct lt8912 *lt =3D i2c_get_clientdata(client);
>
> -       lt8912_bridge_detach(&lt->bridge);
>         drm_bridge_remove(&lt->bridge);
>         lt8912_free_i2c(lt);
>         lt8912_put_dt(lt);
>
> --
> 2.34.1
>


Reviewed-by: Robert Foss <rfoss@kernel.org>
