Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0B790CC3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjICPX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:23:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD57F1;
        Sun,  3 Sep 2023 08:23:52 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8C6B6B5;
        Sun,  3 Sep 2023 17:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693754544;
        bh=jqSdoyKWx526+FF9/nQYZnWif025tFD5VF+7BR3PYNE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SW5/2tVB7/Z4Beu38xqK1QnIUMEXuzp498iDu6OmIF7u+24BgHYk8ADYPV1nOg3yy
         r6Dv11y1hLPmSKhUqFycrE/4KtrEGYzcYYbKxECqr87PWdUQbVTvV0M/7d2XzQN07D
         UPqf4BAy2XRQUCFo5eD19OwjxlkfF9QUUqq/HYAc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230903133709.8049-1-adiupina@astralinux.ru>
References: <20230903133709.8049-1-adiupina@astralinux.ru>
Subject: Re: [PATCH] drm/rcar-du: fix comment to rcar_du_group_get()
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
To:     Alexandra Diupina <adiupina@astralinux.ru>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:   Sun, 03 Sep 2023 16:23:46 +0100
Message-ID: <169375462648.1779741.7610374659365330420@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandra

Quoting Alexandra Diupina (2023-09-03 14:37:09)
> rcar_du_group_get() never returns a negative
> error code (always returns 0), so change
> the comment about returned value

If so, then perhaps this may as well become a void return and remove the
return 0.

That could then clean up some redundant error path handling in
drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c too ?

Still, this does correct the documentation to match the implementation
as it stands so... for that ...

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

But removing an unused error path seems like a worthy clean up
opportunity too.

>=20
> Fixes: cb2025d2509f ("drm/rcar-du: Introduce CRTCs groups")

Hrm ... well the documented behaviour was the same even before this
commit in rcar_du_get(), so perhaps it was documenting the intent... But
it does seem that the return code has been redundant for quite some time
so perhaps it's just not required.


--
Kieran


> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c b/drivers/gp=
u/drm/renesas/rcar-du/rcar_du_group.c
> index 2ccd2581f544..499d4e56c32d 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_group.c
> @@ -200,7 +200,7 @@ static void rcar_du_group_setup(struct rcar_du_group =
*rgrp)
>   *
>   * This function must be called with the DRM mode_config lock held.
>   *
> - * Return 0 in case of success or a negative error code otherwise.
> + * Always return 0.
>   */
>  int rcar_du_group_get(struct rcar_du_group *rgrp)
>  {
> --=20
> 2.30.2
>
