Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300D07B0ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjI0WTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:19:29 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD4DAF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:19:28 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59e88a28b98so171153357b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695853168; x=1696457968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNPNE6ZI/33m69iO4nrfDEaqDNZF0EXoDxHt8Xj7A5c=;
        b=FeHcP/gO+8Bonp3CPcPTqmJ+xd6MdRKL2Lw12hk9zL0ZPDV2lG6J3/4XK59SagjRwL
         rZXSvAnViKW4fJgAy7HUYipSjJsJa0SxQbr7S4EFfmJmOIiA542MXFCdewUlZ8I6a3YR
         /8gv4EUuIBGingpX8zJg1ZRKfzXTsDbBg+SPS76Wlaew6rWzPAETdxf/bjvJdHPIZiC6
         9B/8StSEhVholkJdx731l1724ku0/EqrmdOOJXDdi+GB42s/Lfh7bTFPgouUweq3HPQi
         YDZvP8VmdZtK0qLlmIyVdbRf49nO3t7OtOF43kURaYpF8Pomk7sotVBibM1lq9+NSuDz
         uWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695853168; x=1696457968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNPNE6ZI/33m69iO4nrfDEaqDNZF0EXoDxHt8Xj7A5c=;
        b=bJ7gDvyBP78WPR7rs6Qf0+lhkjVY3jEyMqk51pDRbCd/G8Dn4y9Du/A8/EvECp7uMC
         7u0v8IwF7X9TxDQCj+t5XWmsBWABxYZ2ImTHk3BV+uS4UqV8mJWJoguLQH3QWxoKozOG
         PdKZJU4jZ7BuKVbFHwY4jmjgiiJ3AHLRMv8h1kkeF5C7BXcw+0rcYPLPSHqqq29CALeu
         skelE5jHdnP98EjSyceYCF2eXDIILeg84vvIOOw6ofeXRlfWl/BsV+jirmeQ7BSmJ29o
         2MH51KZjxB5n7+Uboj3AuQPP4ihnriwL33e96q4wVNwjZ1ThZ35glTiB6bcsHcHA9Mo4
         pooA==
X-Gm-Message-State: AOJu0Yxh4aVlL7vDxIdQrXfovmhCVgDfUibEUlAHlab/apmQrr2PcY1k
        BDG8PjWpat4bXkCP67SJVRyGIh5EygaFdf3YZAzvLA==
X-Google-Smtp-Source: AGHT+IGOFDBVqzOLee/sxAR9iGgK1IsrGDxg0u9N7DeadlJtHUbFJGeHuARY+QXmXwqa6r7dlyDUMkozYOV9NkpmD3M=
X-Received: by 2002:a0d:dd47:0:b0:59b:e743:630 with SMTP id
 g68-20020a0ddd47000000b0059be7430630mr5040982ywe.22.1695853167792; Wed, 27
 Sep 2023 15:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230927184556.1422122-1-ben.wolsieffer@hefring.com>
In-Reply-To: <20230927184556.1422122-1-ben.wolsieffer@hefring.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Sep 2023 00:19:16 +0200
Message-ID: <CACRpkdY=kuwiBb965Q7cwu4AeGaG2j0UQ=SOVEZAu=Nq+U265g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: use peripheral flow control for STM32
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

thanks for your patch!

On Wed, Sep 27, 2023 at 8:47=E2=80=AFPM Ben Wolsieffer
<ben.wolsieffer@hefring.com> wrote:

> @@ -378,6 +379,7 @@ struct variant_data {
>         u8                      dma_lli:1;
>         u32                     stm32_idmabsize_mask;
>         u32                     stm32_idmabsize_align;
> +       u8                      dma_flow_controller:1;

I've insisted that we use bool rather than u8:1, ut admittedly it is
nitpicking.

Either way:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
