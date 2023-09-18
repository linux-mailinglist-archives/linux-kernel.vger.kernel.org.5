Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645657A4748
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbjIRKiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbjIRKhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:37:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98ECD2;
        Mon, 18 Sep 2023 03:36:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-530e180ffcbso1625481a12.1;
        Mon, 18 Sep 2023 03:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695033401; x=1695638201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfyGp6Kddb3DCMaY63FRlBCmjrpoU/tnkcgquAmU9Do=;
        b=ZXnT8j1dk5JU5/+YhhTP6gVtk1YpDFU4WcoXiqumFRPGfzUv58Uvpj4wvK6oX23afh
         cLthyQW9JRusRgCI5V5s5uZLQM7mK/O8edonQblEAokZ7VOvYWd9k1o5Hoiz24E0v9eo
         KR2g8IabHp33s1GLVGGC7WCi2I2n1YPgUgmq4Q8AzGk2Y7giEz0wIKlm9DdZtBmYydVN
         xsA87wmmLjWAwzUctxXM75scm6U12u1nolUAre6C244I9Brx0UwMkXglYdzds/I+j9DN
         JltHFWTWwyCva0JXm2zcv8cb0/7SRVSxMoCnTu7+E692QpqqJTaSzSo/DGm4Drfyf16G
         vtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033401; x=1695638201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfyGp6Kddb3DCMaY63FRlBCmjrpoU/tnkcgquAmU9Do=;
        b=twpIlaTGSTm4zEbE22Tua5uqXjYBseR++4QrB1nnQXZLvnwQuNdao4eavEoG9NQEyM
         YWCHLzwu7/5sgIl8DsRWglx0XyMdtU4vwPXU2S6/ClxwuzHXdhsqCi9WLeWnB3m+3+Ps
         DONG11wOhtccsXwzW3LY49I1mZVzCOiO+7cIi9T988qUJUHg3ccjstT5OvnQ/YFVBrM8
         HqGsInH4Aj7Fu5fbu64+F+RwJjloK4CsakhUXUobT6w+FJNf81tiVb+N17s87rODOtmI
         AYVtMWwDlCKHI/B3EMF9zKIoBY/uQwgkXv2PDNvFBFN0Jy4fS9uzMZreyPNRHLb8gwOr
         VXQA==
X-Gm-Message-State: AOJu0Yymlb/j71ZIOQwXxluyctYJyGBGgoN+1HqGVsxbgqf8Iezo0whe
        +cEprNAtK+l4F908tFWkQ5a6i4zzFSdEeMu5/UGZleXRqZE=
X-Google-Smtp-Source: AGHT+IGBhbw2GqtePaA3YZkcQ5+6cwIgmDo63KJAyC9BfF+J4OxFXgY5Cd97zPAbffng77ih/bw+KY98qk8yWK+VavY=
X-Received: by 2002:aa7:d1c5:0:b0:52c:9f89:4445 with SMTP id
 g5-20020aa7d1c5000000b0052c9f894445mr6203415edp.21.1695033401103; Mon, 18 Sep
 2023 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230917-imx95-mbox-v1-0-440245287356@nxp.com> <20230917-imx95-mbox-v1-2-440245287356@nxp.com>
In-Reply-To: <20230917-imx95-mbox-v1-2-440245287356@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 18 Sep 2023 13:36:25 +0300
Message-ID: <CAEnQRZBbdrwX3mq=1RVHwzPAUtWjrKmz3y4ezOann6yZUwZAYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mailbox: imx: support channel type tx doorbell v2
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2023 at 5:45=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The Message Unit(MU) General Purpose Control registers are used for
> TX doorbell, but there is no hardware ACK support.
>
> The current TX doorbell channel is using tasklet to emulate hardware
> ACK support to kick the TX tick from controller driver side.
>
> The new added TX doorbell channel V2 not using tasklet to emulate the
> hardware ACK support. The behavior for the channel is just writing the
> GCR register, and no else. This will be used for SCMI mailbox.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.=
c
> index 3ef4dd8adf5d..0af739ab571c 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -20,7 +20,9 @@
>  #include <linux/suspend.h>
>  #include <linux/slab.h>
>
> -#define IMX_MU_CHANS           17
> +#include "mailbox.h"
> +
> +#define IMX_MU_CHANS           24
>  /* TX0/RX0/RXDB[0-3] */
>  #define IMX_MU_SCU_CHANS       6
>  /* TX0/RX0 */
> @@ -39,6 +41,7 @@ enum imx_mu_chan_type {
>         IMX_MU_TYPE_TXDB        =3D 2, /* Tx doorbell */
>         IMX_MU_TYPE_RXDB        =3D 3, /* Rx doorbell */
>         IMX_MU_TYPE_RST         =3D 4, /* Reset */
> +       IMX_MU_TYPE_TXDB_V2     =3D 5, /* Tx doorbell with S/W ACK */
>  };
>
>  enum imx_mu_xcr {
> @@ -226,6 +229,9 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv=
,
>                 imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dc=
fg->type, cp->idx), 0);
>                 tasklet_schedule(&cp->txdb_tasklet);
>                 break;
> +       case IMX_MU_TYPE_TXDB_V2:
> +               imx_mu_xcr_rmw(priv, IMX_MU_GCR, IMX_MU_xCR_GIRn(priv->dc=
fg->type, cp->idx), 0);
> +               break;
>         default:
>                 dev_warn_ratelimited(priv->dev, "Send data on wrong chann=
el type: %d\n", cp->type);
>                 return -EINVAL;
> @@ -554,6 +560,9 @@ static int imx_mu_startup(struct mbox_chan *chan)
>         int ret;
>
>         pm_runtime_get_sync(priv->dev);
> +       if (cp->type =3D=3D IMX_MU_TYPE_TXDB_V2)
> +               return 0;
> +
>         if (cp->type =3D=3D IMX_MU_TYPE_TXDB) {
>                 /* Tx doorbell don't have ACK support */
>                 tasklet_init(&cp->txdb_tasklet, imx_mu_txdb_tasklet,
> @@ -595,6 +604,11 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
>         int ret;
>         u32 sr;
>
> +       if (cp->type =3D=3D IMX_MU_TYPE_TXDB_V2) {
> +               pm_runtime_put_sync(priv->dev);
> +               return;
> +       }
> +
>         if (cp->type =3D=3D IMX_MU_TYPE_TXDB) {
>                 tasklet_kill(&cp->txdb_tasklet);
>                 pm_runtime_put_sync(priv->dev);
> @@ -671,6 +685,7 @@ static struct mbox_chan *imx_mu_specific_xlate(struct=
 mbox_controller *mbox,
>  static struct mbox_chan * imx_mu_xlate(struct mbox_controller *mbox,
>                                        const struct of_phandle_args *sp)
>  {
> +       struct mbox_chan *p_chan;
>         u32 type, idx, chan;
>
>         if (sp->args_count !=3D 2) {
> @@ -680,14 +695,25 @@ static struct mbox_chan * imx_mu_xlate(struct mbox_=
controller *mbox,
>
>         type =3D sp->args[0]; /* channel type */
>         idx =3D sp->args[1]; /* index */
> -       chan =3D type * 4 + idx;
>
> +       /* RST only supports 1 channel */
> +       if ((type =3D=3D IMX_MU_TYPE_RST) && idx) {
> +               dev_err(mbox->dev, "Invalid RST channel %d\n", idx);
> +               return ERR_PTR(-EINVAL);
> +       }

I don't understand how is this related to introduction of a new
doorbell channel. Can you please
add it in a separate patch with proper explanation?


> +
> +       chan =3D type * 4 + idx;
>         if (chan >=3D mbox->num_chans) {
>                 dev_err(mbox->dev, "Not supported channel number: %d. (ty=
pe: %d, idx: %d)\n", chan, type, idx);
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       return &mbox->chans[chan];
> +       p_chan =3D &mbox->chans[chan];
> +
> +       if (type =3D=3D IMX_MU_TYPE_TXDB_V2)
> +               p_chan->txdone_method =3D TXDONE_BY_ACK;
> +
> +       return p_chan;
>  }
>
>  static struct mbox_chan *imx_mu_seco_xlate(struct mbox_controller *mbox,
>
> --
> 2.37.1
>
