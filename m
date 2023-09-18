Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57877A3F71
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 04:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjIRCVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 22:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbjIRCUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 22:20:49 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6078F122
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 19:20:43 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-44d4d997dcfso1933265137.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nathanrossi.com; s=google; t=1695003642; x=1695608442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lX9+mbtWLP7yVS59bGmWxF7PGQEXO4BU8xeOBRCUUFE=;
        b=OsXsmKhDkS90HOKLJdNUijTpzWRwTTlBxGc00Uus75Do1y3RUnX3o9ArJM2wSS0leg
         PolARbByEkfyVLQQlvyC6wCgOYgtkiQct2J0jCsTl439Hl6r7px6ucikNr2YqWscSiNt
         eD1rTpcQj0JxdiyQ2W75IglVrziIplRZDnH0nwbq0lttF8nJ+2Wgon8asYg1fSsENTTh
         3C5QL2C4YThhqP8V7pHsEYWF1iWtKEKXxtBXFKt7GY0/xbfrAoJHEq1go5moPXU68Ir7
         Vl1LLDF2eKrHo72pre8k7sV3Y4iXWzgQsF09JR68xcLsz7zA3HR57njo0P0eDKfyYx0b
         12MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695003642; x=1695608442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX9+mbtWLP7yVS59bGmWxF7PGQEXO4BU8xeOBRCUUFE=;
        b=fo/436mkAY7YYcOT7VDRXAT9mxt/11aXOnL7mfj888fC34LhYOeQDO0xUeCVHQkbpD
         6XpWbaGA1ERB/LbCSvgcTvFZeNYClDuOSQY/Y7EYNmofgRclCpAWDQSYxW+xrvpn0Htx
         XJtHv3uByJcYQQP18ZYtJWEGE389g/Zq7KAQHNQoYxT0WIFyZqYQJ05+B1qocjKRWJfy
         TXDYzqKCYPvqKYGq5LkC4cK9j7QVA9I8gaOzFOUmGDdJ65/x38iZPBhh6ybHCrS/sE2W
         fi+dC2Xd/XAIwT4XCyGR5UbjiY4iMq82O6Saxvj9rkTLyBNl9+qHUOXdLarDeeRcfz/H
         OIeg==
X-Gm-Message-State: AOJu0YwhBM3yHVdqjk5J/djpDU9HHaRVwyFtgqJ3Gp4lzGPdqMLBYsGc
        s6p9ZcWWkDtEtsvq3jioO9qvcLfWYfr6j4RUWhST4Q==
X-Google-Smtp-Source: AGHT+IH+vx56dh32yR4y2NRMTthEVCWOPxwDtXokMTKStjD9VuUJy7UPL78epmvidybYRhYgdQGwF0fevybrV1lb9uE=
X-Received: by 2002:a05:6102:1588:b0:452:55f5:55e9 with SMTP id
 g8-20020a056102158800b0045255f555e9mr3608013vsv.14.1695003642473; Sun, 17 Sep
 2023 19:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814015700.70156-1-nathan@nathanrossi.com>
In-Reply-To: <20230814015700.70156-1-nathan@nathanrossi.com>
From:   Nathan Rossi <nathan@nathanrossi.com>
Date:   Mon, 18 Sep 2023 12:20:31 +1000
Message-ID: <CA+aJhH1dFz2gbZaYtqG+bNB2Cwd-iPQbEkUBBVLh9_T-O0VP9w@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Enable OCOTP clock for imx8mm before reading registers
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Nathan Rossi <nathan.rossi@digi.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 at 11:57, Nathan Rossi <nathan@nathanrossi.com> wrote:
>
> From: Nathan Rossi <nathan.rossi@digi.com>
>
> Commit 836fb30949d9 ("soc: imx8m: Enable OCOTP clock before reading the
> register") added configuration to enable the OCOTP clock before
> attempting to read from the associated registers.
>
> This same kexec issue is present with the imx8m SoCs that use the
> imx8mm_soc_uid function (e.g. imx8mp). This requires the imx8mm_soc_uid
> function to configure the OCOTP clock before accessing the associated
> registers. This change implements the same clock enable functionality
> that is present in the imx8mq_soc_revision function for the
> imx8mm_soc_uid function.

Gentle ping. Are there any comments or feedback on this change?

Thanks,
Nathan

>
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
>  drivers/soc/imx/soc-imx8m.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 1dcd243df5..ec87d9d878 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -100,6 +100,7 @@ static void __init imx8mm_soc_uid(void)
>  {
>         void __iomem *ocotp_base;
>         struct device_node *np;
> +       struct clk *clk;
>         u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
>                      IMX8MP_OCOTP_UID_OFFSET : 0;
>
> @@ -109,11 +110,20 @@ static void __init imx8mm_soc_uid(void)
>
>         ocotp_base = of_iomap(np, 0);
>         WARN_ON(!ocotp_base);
> +       clk = of_clk_get_by_name(np, NULL);
> +       if (IS_ERR(clk)) {
> +               WARN_ON(IS_ERR(clk));
> +               return;
> +       }
> +
> +       clk_prepare_enable(clk);
>
>         soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
>         soc_uid <<= 32;
>         soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
>
> +       clk_disable_unprepare(clk);
> +       clk_put(clk);
>         iounmap(ocotp_base);
>         of_node_put(np);
>  }
> ---
> 2.40.1
