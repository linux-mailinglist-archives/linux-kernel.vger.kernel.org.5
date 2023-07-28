Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F8C766B34
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbjG1LAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbjG1LAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:00:49 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281B3A96;
        Fri, 28 Jul 2023 04:00:44 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55acbe0c7e4so329255a12.0;
        Fri, 28 Jul 2023 04:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690542044; x=1691146844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAU8K3a8dHy/tuEIb7Zpcs7Yfdt1964yvfWu4jQqUuw=;
        b=UrIAf3FUSIv8YxPhfTK3nLv5IcWt5sxAS/MbAn3DuvkbIaHb7LD1g2rsl9yDEOwdSh
         3vY0iX48P3rU4dTxIJB9eIHtKllX7TF/TQCeOHzvgsz3cWjLPstf2rQNO1zJWaoQn/gT
         UDXJsAlFDdBYgpQbSjyavgIMkKIzTkwmiiGHFsWFrOlEcyrmWSTfsQa90rXEFhKycdx3
         sDsjhtBzBwTjeYOFc5jeJUg3L02N3lkPbPRcUAFljwl+lxlzHq8CKGg/m/bq7o/rlqbu
         fBbHr2TW9PfmJwxLS25qzOzPs3WbUxIe2YYi58UyCNVMDhLqbq9r2TYFdyq5zGHKFDSJ
         cKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690542044; x=1691146844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAU8K3a8dHy/tuEIb7Zpcs7Yfdt1964yvfWu4jQqUuw=;
        b=IjpXhcdGkyZp4rkFXUkal/ltjHfD51zA4CvXZfU4Neps6HSVyD8JqOMErV9auzUBB7
         vFPSil6Gnyx9OYf54Odo9APLMa24LR7eXriSdhfIxrjIZe7NA2wVvhFAU43xzyGRO4yC
         8I0zS+HSy+F/SZEPSzF8NRRejOvL5AYMux/9R3ntechNIND7Tjx+K8GpEAHzIrS0lejh
         lCL91QPwoX5oII9mjSON9t0ioHci6rjqKmFwgQlg0+KxnmaWC1PleFDYwhl1sbDJ/RF8
         nGgTOVBis1kEI4pyxFYRjY/0jf7pWPodcLSGhEJZdwx50pLruSAvhn31afzWd8kzz4eo
         j2vw==
X-Gm-Message-State: ABy/qLZ1UVbJLnGmVceew55538jTjYwMCclPnQE0z8o3vuYpA+IyfXjL
        KzQK8BELnCVVrau7njjbKZ04GkYiA6Cs2uXKouE=
X-Google-Smtp-Source: APBJJlFRUaRTonS8rZhdy8awwpxcfDvB90VkuyRkJuU4rORotvPAMG3r669s1DgV5c8fsVRmEz9c48FJa+0b7z7329Q=
X-Received: by 2002:a17:90a:e4f:b0:267:f1dc:74ee with SMTP id
 p15-20020a17090a0e4f00b00267f1dc74eemr1975393pja.2.1690542044042; Fri, 28 Jul
 2023 04:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230727152503.2199550-1-shenwei.wang@nxp.com> <20230727152503.2199550-3-shenwei.wang@nxp.com>
In-Reply-To: <20230727152503.2199550-3-shenwei.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 28 Jul 2023 08:00:32 -0300
Message-ID: <CAOMZO5ANQmVbk_jy7qdVtzs3716FisT2c72W+3WZyu7FoAochw@mail.gmail.com>
Subject: Re: [PATCH v2 net 2/2] net: stmmac: dwmac-imx: pause the TXC clock in fixed-link
To:     Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev,
        Frank Li <frank.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 12:25=E2=80=AFPM Shenwei Wang <shenwei.wang@nxp.com=
> wrote:

>         struct plat_stmmacenet_data *plat_dat =3D priv;
> @@ -317,8 +359,11 @@ static int imx_dwmac_probe(struct platform_device *p=
dev)
>         plat_dat->exit =3D imx_dwmac_exit;
>         plat_dat->clks_config =3D imx_dwmac_clks_config;
>         plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed;
> +       if (of_machine_is_compatible("fsl,imx93"))
> +               plat_dat->fix_mac_speed =3D imx_dwmac_fix_speed_mx93;

So you are forcing this on all imx93 boards, even if they don't use a SJA11=
05.

Andrew Lunn gave the following feedback in v1:

"The SJA1105 has the problem, so i would expect it to be involved in
the solution. Otherwise, how is this going to work for other MAC
drivers?

Maybe you need to expose a common clock framework clock for the TXC
clock line, which the SJA1105 can disable/enable? That then makes it
clear what other MAC drivers need to do."
