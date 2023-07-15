Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C87754A21
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjGOQiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:38:22 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC27E43
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:38:21 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-263315da33cso598715a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689439101; x=1690043901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF5L5fdsheXdW4FCgpI8nwilAf+nvvySGrScnnOzsHs=;
        b=cJbpiW1PjvUlB+7JHcMUH2p7CHnCn3wa8Fc11TSAnOMvPS4XJLP0FbTLmyVG/K1HON
         H17k2Dh1V2n+k15uE88MxNPFGCTa50pZeC/9HcT0xYeDTY5Or3/UhXZ+7PMvzIjzhFzn
         LCgF0brRckx9uXixYPGd3YETOSfvaAywLwsJEqNYrv4oR9DDu0ef6MZtY6V2wpxdi8d0
         nVZNMlsRdXj5IjV0Q8VnSgeRurXMX7vLyzfSVeXrdMVsAJVT+FCfP+gieObrQz3quaFj
         bYiyn8kJo7M0glTaI+5jKLmF07kQ7zSyl5UoGdMUeDNxrlNJhPwRpWghS6r+doG00dnQ
         Pf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689439101; x=1690043901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oF5L5fdsheXdW4FCgpI8nwilAf+nvvySGrScnnOzsHs=;
        b=WeOJLHfpGh82pYICD2wEeohBrdW9Iy4WhGSrL+O+uZKmFRYgM9RoY3KgMHH1DXfvrH
         Ob5BYM3GdLeTCtBTw3t4lu0s6Uh9TKA1BFp6XJa1MK/xq8I9wPJg0pTV/5wPwmTr2id1
         dHmi5VnJM0t3pfasZ2nYyt3P+/DKRqwbq5ZPY2DiOoeY09ZKeZBVqbi/tjZ0W/zffCPc
         L6JqlhXVC8kWTSQwwPizkIwRotBbSPicW/YlHBxqss8sSYZ1D1Vn0U8G2jxeaNQXyJLe
         tYkTSAqyAjJjc956ZghPO/GgVdi3rzOM05jhlitLb0cTtJ8MTwGdJ/e72wxWkvPiQuoM
         3gZA==
X-Gm-Message-State: ABy/qLYEuG/Dr97yOKgpovlIMg6CIDOB15gFqetNaVtI8804C4wQygoM
        iSbDzvvB6CoUug4w3Q300HBeKA2YHol1wwwowTlnwQSrTY4=
X-Google-Smtp-Source: APBJJlEzodN+N+Jx5YBxIQUb3mCMJtMULEVP7fM5G5mafpNc1xXQ7Dq0iYOQmmV8RBFkQKn+RSdUBi1NzkXBQxKl1AU=
X-Received: by 2002:a17:90a:4a91:b0:258:9621:913f with SMTP id
 f17-20020a17090a4a9100b002589621913fmr7622607pjh.3.1689439100686; Sat, 15 Jul
 2023 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_0ED0DF5CD5426F55806D79D028F8A10E490A@qq.com>
In-Reply-To: <tencent_0ED0DF5CD5426F55806D79D028F8A10E490A@qq.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 15 Jul 2023 13:38:09 -0300
Message-ID: <CAOMZO5BByJsCOCpQ9WZqMWP7qmh7x3N06wD9VhpWMjoi4hg2ag@mail.gmail.com>
Subject: Re: [PATCH] bus: imx-weim: fix to avoid potential NULL pointer dereference
To:     Zhang Shurong <zhang_shurong@foxmail.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

On Sat, Jul 15, 2023 at 12:21=E2=80=AFPM Zhang Shurong
<zhang_shurong@foxmail.com> wrote:
>
> of_match_device() may fail and returns a NULL pointer.
>
> Fix this by checking the return value of of_match_device.
>
> Fixes: 3f98b6baad63 ("drivers: bus: imx-weim: Add support for i.MX1/21/25=
/27/31/35/50/51/53")
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
>  drivers/bus/imx-weim.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 52a5d0447390..65402bb60c18 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -202,15 +202,19 @@ static int weim_timing_setup(struct device *dev, st=
ruct device_node *np,
>
>  static int weim_parse_dt(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id =3D of_match_device(weim_id_tabl=
e,
> -                                                          &pdev->dev);
> -       const struct imx_weim_devtype *devtype =3D of_id->data;
> +       const struct of_device_id *of_id;
> +       const struct imx_weim_devtype *devtype;
>         int ret =3D 0, have_child =3D 0;
>         struct device_node *child;
>         struct weim_priv *priv;
>         void __iomem *base;
>         u32 reg;
>
> +       of_id =3D of_match_device(weim_id_table, &pdev->dev);
> +       if (!of_id)
> +               return -EINVAL;

If there is no match the driver will not probe in the first place.

I don't think this check is needed.
