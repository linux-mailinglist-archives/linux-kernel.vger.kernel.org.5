Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308197ADA38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjIYOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIYOnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:43:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6707211B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:43:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4053c6f0d55so61666265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695653018; x=1696257818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/sMphRuA0VcjIhUu52wZChuZavyxtp56aeA36+PYxE=;
        b=aUOOreRInVc77su+vU68pq2DcBu5WxOTbtrNFudxrQ8+rlB7kQrHZIZAFzjaIGgW3D
         eT+c5NJqWpQELL9YvLEtchHONLQZ66xRMYZFFqofbmPmVtUJqTwz3cr/24e/yR2AAX+D
         ppuGlSUtnZn/ikZj/7SP5hL02ArrdVyNzxnXtW09BFh4qXgZmjDeqwj8Ya6oqbOUmL+4
         dmGfwrf4+liTNGwnYco313nVsnld1qR1ZcvYf13ZOnp1lZj6FIHaIDicgzmyf9raCpqP
         lS6j1A7HaPGi4T/WrVpL7hgs0hI83sSJ4uPYWIReNGysu3eVDBCBra0UMPNAU6DIf3w6
         k+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653018; x=1696257818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/sMphRuA0VcjIhUu52wZChuZavyxtp56aeA36+PYxE=;
        b=i/x51q+TluQMKydBepe8cfXAJH9kD55VLbIE7hNjSLPm8hDzqJj2O2lkvt2gDQUIZU
         cEhYmTynNz5ythP85U6kMZZrEquxrnawDW5FgGgimD1Wl9GMsxh867DtlOpPZxIfU6H6
         FptAA1gaJcByg3yiVn154F4uE2W9vV5ynv7A+Pj3DusWG3lDUdOUnmv4O6n6IcMxZ5qd
         YnuVn9tsqWkpNFVFeeQM+R7n01C99bmPbzEzuBi0htH7QedlvmWUCeolCSec5t0AyxI+
         f6iJT60RmdT2n9TuFOIpw06mjyHIyRp3PcHqFoV2wC386tskjmaHvq253Zc3uvPsxYUB
         QbIw==
X-Gm-Message-State: AOJu0YxDKSVbNF06TrQBqsbVMqXcmCSVLPMqUwOBNbz5wvw0kpkE1e5u
        i1ZiuOyxepR+v8EUaGX81dkQEg==
X-Google-Smtp-Source: AGHT+IEbGAlM/VewJdTcTv5/aTJRKALQYUm6lwgRKY3S9S1k9trypjsl9J42XlYhfQuHu1BmTqd4sg==
X-Received: by 2002:a7b:cd07:0:b0:405:3ae6:2401 with SMTP id f7-20020a7bcd07000000b004053ae62401mr5847424wmj.14.1695653017666;
        Mon, 25 Sep 2023 07:43:37 -0700 (PDT)
Received: from x1 ([193.52.24.5])
        by smtp.gmail.com with ESMTPSA id n13-20020a7bc5cd000000b003fee53feab5sm12588862wmk.10.2023.09.25.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:43:37 -0700 (PDT)
Date:   Mon, 25 Sep 2023 16:43:29 +0200
From:   Drew Fustini <dfustini@baylibre.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/6] mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520
Message-ID: <ZRGckWotC4RYHLNZ@x1>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-3-49f76c274fb3@baylibre.com>
 <a420c2e5-db23-4b61-a110-476f8fb8636a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a420c2e5-db23-4b61-a110-476f8fb8636a@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 01:35:36PM +0300, Adrian Hunter wrote:
> On 22/09/23 04:49, Drew Fustini wrote:
> > Add support for the mmc controller in the T-Head TH1520 with the new
> > compatible "thead,th1520-dwcmshc". Implement custom sdhci_ops for
> > set_uhs_signaling, reset, voltage_switch, and platform_execute_tuning.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 456 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 456 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index 3a3bae6948a8..7294bf1afb7d 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -35,6 +35,26 @@
> >  #define DWCMSHC_CARD_IS_EMMC		BIT(0)
> >  #define DWCMSHC_ENHANCED_STROBE		BIT(8)
> >  #define DWCMSHC_EMMC_ATCTRL		0x40
> > +/* Tuning and auto-tuning fields in AT_CTRL_R control register */
> > +#define AT_CTRL_AT_EN			0x1 /* autotuning is enabled */
> > +#define AT_CTRL_CI_SEL_SHIFT		0x1 /* bit 1 */
> > +#define AT_CTRL_CI_SEL			0x1 /* interval to drive center phase select */
> > +#define AT_CTRL_SWIN_TH_EN_SHIFT	0x2 /* bit 2 */
> > +#define AT_CTRL_SWIN_TH_EN		0x1 /* sampling window threshold enable */
> > +#define AT_CTRL_RPT_TUNE_ERR_SHIFT	0x3 /* bit 3 */
> > +#define AT_CTRL_RPT_TUNE_ERR		0x1 /* enable reporting framing errors */
> > +#define AT_CTRL_SW_TUNE_EN_SHIFT	0x4 /* bit 4 */
> > +#define AT_CTRL_SW_TUNE_EN		0x1 /* enable software managed tuning */
> > +#define AT_CTRL_WIN_EDGE_SEL_SHIFT	0x8 /* bits [11:8] */
> > +#define AT_CTRL_WIN_EDGE_SEL		0xf /* sampling window edge select */
> > +#define AT_CTRL_TUNE_CLK_STOP_EN_SHIFT	0x10 /* bit 16 */
> > +#define AT_CTRL_TUNE_CLK_STOP_EN	0x1  /* clocks stopped during phase code change */
> > +#define AT_CTRL_PRE_CHANGE_DLY_SHIFT	0x11 /* bits [18:17] */
> > +#define AT_CTRL_PRE_CHANGE_DLY		0x1  /* 2-cycle latency */
> > +#define AT_CTRL_POST_CHANGE_DLY_SHIFT	0x13 /* bits [20:19] */
> > +#define AT_CTRL_POST_CHANGE_DLY		0x3  /* 4-cycle latency */
> > +#define AT_CTRL_SWIN_TH_VAL_SHIFT	0x18 /* bits [31:24] */
> > +#define AT_CTRL_SWIN_TH_VAL		0x9  /* sampling window threshold */
> 
> Here and elsewhere, please try to make use of BIT(), GENMASK(),
> FIELD_PREP(), FIELD_GET()

Thank you for the advice.  FIELD_PREP() and FIELD_GET() look like they
can make the code simpler.  I'll make use of those macros in the next
version.

thanks,
drew
