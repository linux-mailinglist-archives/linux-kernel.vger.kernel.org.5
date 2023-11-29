Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB417FE0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 21:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjK2UFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 15:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjK2UFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 15:05:41 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C60FBF;
        Wed, 29 Nov 2023 12:05:47 -0800 (PST)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 228F36F0;
        Wed, 29 Nov 2023 21:05:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701288309;
        bh=spSf15rTwxA5JE7+sp4ojIqhMxZPcSNcX/1hS4MkL7c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZFigpqTDQUCC6I06rU2X8xxZonJ1X7078Tw2MM4eOeygEbZtgA9UtiYi78FLQQGPE
         ZJnR43Ero5GduQP4r6TqehBjBSQl3VtnAp2quLJmwe8NRo2h4Q6FYDBdlAxcz+rRAD
         9GmrFLNdgklQuYXYJSL7PoJjYXDe2HxTLGzwtle8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231129092956.250129-3-paul.elder@ideasonboard.com>
References: <20231129092956.250129-1-paul.elder@ideasonboard.com> <20231129092956.250129-3-paul.elder@ideasonboard.com>
Subject: Re: [PATCH 2/3] media: rkisp1: debug: Add register dump for IS
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     tomi.valkeinen@ideasonboard.com, umang.jain@ideasonboard.com,
        Paul Elder <paul.elder@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org
Date:   Wed, 29 Nov 2023 20:05:42 +0000
Message-ID: <170128834260.3048548.11979514587961676400@ping.linuxembedded.co.uk>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Elder (2023-11-29 09:29:55)
> Add register dump for the image stabilizer module to debugfs.
>=20

Is the Image Stabilizer on all variants of the ISP?

I.e. is it valid register space on the RK3399 implementation?

If so then:
Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---
>  .../platform/rockchip/rkisp1/rkisp1-debug.c    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c b/driv=
ers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> index 71df3dc95e6f..f66b9754472e 100644
> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-debug.c
> @@ -139,6 +139,21 @@ static int rkisp1_debug_dump_mi_mp_show(struct seq_f=
ile *m, void *p)
>  }
>  DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_mi_mp);
> =20
> +static int rkisp1_debug_dump_is_show(struct seq_file *m, void *p)
> +{
> +       static const struct rkisp1_debug_register registers[] =3D {
> +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_OFFS),
> +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_OFFS),
> +               RKISP1_DEBUG_SHD_REG(ISP_IS_H_SIZE),
> +               RKISP1_DEBUG_SHD_REG(ISP_IS_V_SIZE),

I expect so as you haven't added the register macros in this series so
they must already be there ...


> +               { /* Sentinel */ },
> +       };
> +       struct rkisp1_device *rkisp1 =3D m->private;
> +
> +       return rkisp1_debug_dump_regs(rkisp1, m, 0, registers);
> +}
> +DEFINE_SHOW_ATTRIBUTE(rkisp1_debug_dump_is);
> +
>  #define RKISP1_DEBUG_DATA_COUNT_BINS   32
>  #define RKISP1_DEBUG_DATA_COUNT_STEP   (4096 / RKISP1_DEBUG_DATA_COUNT_B=
INS)
> =20
> @@ -235,6 +250,9 @@ void rkisp1_debug_init(struct rkisp1_device *rkisp1)
> =20
>         debugfs_create_file("mi_mp", 0444, regs_dir, rkisp1,
>                             &rkisp1_debug_dump_mi_mp_fops);
> +
> +       debugfs_create_file("is", 0444, regs_dir, rkisp1,
> +                           &rkisp1_debug_dump_is_fops);
>  }
> =20
>  void rkisp1_debug_cleanup(struct rkisp1_device *rkisp1)
> --=20
> 2.39.2
>
