Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34B7D43C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbjJXAOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXAOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:14:12 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA7CD6E;
        Mon, 23 Oct 2023 17:14:07 -0700 (PDT)
Received: from [192.168.68.112] (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net [118.210.136.142])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B500F20034;
        Tue, 24 Oct 2023 08:13:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698106442;
        bh=xf45kMR6lFEzv3Mn9oNtZZ7uAthFMPRd7r9ZXIrWv7I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GUx5geqNxZPF0MtIxzsvsFTVESMyuDuDjKHiWQqcyqRia/okbxSE6uKQbWe5g5re7
         isGkc4IGs2cHg8pQT52IimK+B9wasH2ws3jzSxcyJ2gEG3WnW1ey5CCyqVtaHHPwHa
         uckM7NPQt/eBPF/181w1K6w9tX3stP3Hjc6j7N9fSlPeIyjF/ZgUoAwl+QzFiaKKUT
         9bhPHskstheOQUIYsyupO760PTI21905eYXRhNDgDGmxKi0fqdHZqHLv3SPuwrm/5w
         k+0crspYly9IZA0eq5iC9rzeTsO2uoNRITV5ohc6W8L0kgJB9+/Y0v+tsAuT06YqpS
         j7oxYADgJPEIQ==
Message-ID: <d4f77e13d3c5de613877450fd25bf5f77f1331a2.camel@codeconstruct.com.au>
Subject: Re: [PATCH] drm: Use device_get_match_data()
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Joel Stanley <joel@jms.id.au>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Date:   Tue, 24 Oct 2023 10:43:55 +1030
In-Reply-To: <20231020125214.2930329-1-robh@kernel.org>
References: <20231020125214.2930329-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-20 at 07:52 -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data in a single step. With this, adjust the
> includes to explicitly include the correct headers. That also serves as
> preparation to remove implicit includes within the DT headers
> (of_device.h in particular).
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/armada/armada_crtc.c    | 24 +++++++-----------------
>  drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 10 ++++------

For Aspeed:

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Thanks!
