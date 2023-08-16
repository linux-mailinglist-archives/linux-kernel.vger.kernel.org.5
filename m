Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CBE77EB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbjHPVRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbjHPVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:17:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A46173F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:17:19 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68874269df4so1503622b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1692220639; x=1692825439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ijQ4xjAyy4cXvtCZ8IHt29eyOuPHI1+Xar27Tt86Dp4=;
        b=JVpUR/lawlqlFkpcF+J84noZqg2UnYi6hcWRQDwGqmdXVRZzyrBKuG3SIETA3elfYQ
         r9TDMEOc++w5WtVfc0jnYe5KbddenKmeLsJfZ62h/J2oJezAn8CsKHQ1f2NRW5VrFH6X
         SSgNBhgwsbCTNq/rlmuQIK+exph042uq7e/9da2suNdo6LRKm8rIm4H+sHD9MFLt00Du
         qnGC2eyqevo3Aw4yrlh8MtqaEcqADVTvF+WRAk9o/+la7hJC5bzKbOAtUT8HWSqTJorq
         b1h2ubVaYojV5duI5XdsFwY5GPtIF7e7qy9UdWEBpvMMGcbVeQYhO1I995LpF42WJWX/
         62wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692220639; x=1692825439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijQ4xjAyy4cXvtCZ8IHt29eyOuPHI1+Xar27Tt86Dp4=;
        b=MiBjYsD5aM0mbqCYJn7FOBAQClnUeVhBMz6wGMEUbLnVJcY5qjetGmQWWP6SmrAqgN
         FSR+n1tgqCjbirgHrp0rKr2j5azjXNpRxSxPFE2yZeRJzwYM8RBjtEKYSaqVUDXSpI6G
         mMbKI6iLIjeAVMQmCSsxQd8f9q13b9zmrdvqGrKmEozEQEbLwIfiUpy32DfPch6iZxSg
         WxwFWMwjyok3Jk0qx//PxDdvIc7MOWb+NCTnjtWWPXM1YcdyXgrQydI4sBByIhelO7Sb
         BU5awW9HII+pPU6d5+tAie8lkOvstqPSXWhyLlSVs5F18NnWcCe50B9fs9uh20/AEPBQ
         iGmw==
X-Gm-Message-State: AOJu0YxKY3pyx9ALwtkZNtiPpjRvuDZXZrEVYhyihkZIWzckxuHmndwK
        /eXtX48iFAd3csZJNy7bELkwLA==
X-Google-Smtp-Source: AGHT+IFvj8M6RzJ7QeCC2fvLEuc+3NAgBeDGLAHgvYrVY85sg3niFmG+56sLaJbghUe4gDStIMpITA==
X-Received: by 2002:a05:6a00:c90:b0:673:8dfb:af32 with SMTP id a16-20020a056a000c9000b006738dfbaf32mr2912809pfv.26.1692220639226;
        Wed, 16 Aug 2023 14:17:19 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:ad77:24cb:c068:c5e6])
        by smtp.gmail.com with ESMTPSA id e26-20020aa7825a000000b00686dd062207sm11521224pfn.150.2023.08.16.14.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 14:17:18 -0700 (PDT)
Date:   Wed, 16 Aug 2023 14:17:16 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH RFC v2 4/4] mmc: sdhci-of-dwcmshc: Add support for T-Head
 TH1520
Message-ID: <ZN083N3cCNu4o2Ny@x1>
References: <20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com>
 <20230724-th1520-emmc-v2-4-132ed2e2171e@baylibre.com>
 <ZM9xY6dGWbTxCgqj@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZM9xY6dGWbTxCgqj@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 06, 2023 at 06:09:39PM +0800, Jisheng Zhang wrote:
> On Fri, Aug 04, 2023 at 08:14:48PM -0700, Drew Fustini wrote:
> > Add basic support for the T-Head TH1520 SoC mmc controller with the new
> > compatible "thead,th1520-dwcmshc".
> > 
> > However, quirks are currently set to disable DMA and use PIO. The proper
> > settings for DMA support still need to be determined.
> 
> Hi Drew,
> 
> Thank you for this patch. I think we need to make DMA work even in the
> first version.

Thanks for your review. I agree that DMA should be made to work.
When I remove the SDHCI_QUIRK_BROKEN_ADMA quirk, I see the following in
the boot log [1]:

[    3.633611] mmc0: SDHCI controller on ffe7080000.mmc [ffe7080000.mmc] using ADMA 64-bit
[    3.723080] mmc0: ADMA error: 0x02000000
[    4.327491] mmc0: error -5 whilst initialising MMC card

I'm going to add some more debug output so I can better understand what
exactly is failing.

> 
> Several comments below.
> 
> > 
> > Another issue is th1520-specific code for MMC_TIMING_MMC_HS400 in
> > dwcmshc_set_uhs_signaling() will run on all platforms which is not
> > correct. One solution could be to add a th1520 flag to dwcmshc_priv but
> > that is hacky. Another solution could be to set the set_uhs_signaling op
> > in sdhci_dwcmshc_th1520_ops to a th1520-specific function. However, that
> > new function would have to duplicate all the code in the current
> > dwcmshc_set_uhs_signaling().
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  drivers/mmc/host/sdhci-of-dwcmshc.c | 336 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 336 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index e68cd87998c8..d35e204cdb16 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -71,6 +71,63 @@
> >  	(((x) & DWCMSHC_EMMC_DLL_TIMEOUT) == 0))
> >  #define RK35xx_MAX_CLKS 3
> >  
> > +/* T-Head specific registers */
> 
> I guess this may not be T-HEAD specific but dwc phy, could you please
> check?

Yes, I will try to find out if if this really is t-head specific or just
standard for the DWC PHY.

> > +#define DWC_MSHC_PTR_PHY_R	0x300
> > +#define PHY_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x00)
> > +#define PHY_RSTN		0x0
> > +#define PAD_SP			0x10
> > +#define PAD_SN			0x14
> > +
> > +#define PHY_CMDPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x04)
> > +#define PHY_DATAPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x06)
> > +#define PHY_CLKPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x08)
> > +#define PHY_STBPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0a)
> > +#define PHY_RSTNPAD_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0c)
> > +#define RXSEL			0x0
> > +#define WEAKPULL_EN		0x3
> > +#define TXSLEW_CTRL_P		0x5
> > +#define TXSLEW_CTRL_N		0x9
> > +
> > +#define PHY_PADTEST_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x0e)
> > +#define PHY_PADTEST_OUT_R	(DWC_MSHC_PTR_PHY_R + 0x10)
> > +#define PHY_PADTEST_IN_R	(DWC_MSHC_PTR_PHY_R + 0x12)
> > +#define PHY_PRBS_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x18)
> > +#define PHY_PHYLBK_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x1a)
> > +#define PHY_COMMDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x1c)
> > +
> > +#define PHY_SDCLKDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x1d)
> > +#define UPDATE_DC		0x4
> > +
> > +#define PHY_SDCLKDL_DC_R	(DWC_MSHC_PTR_PHY_R + 0x1e)
> > +#define PHY_SMPLDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x20)
> > +#define PHY_ATDL_CNFG_R		(DWC_MSHC_PTR_PHY_R + 0x21)
> > +#define INPSEL_CNFG		2
> > +
> > +#define PHY_DLL_CTRL_R		(DWC_MSHC_PTR_PHY_R + 0x24)
> > +#define DLL_EN			0x0
> > +
> > +#define PHY_DLL_CNFG1_R		(DWC_MSHC_PTR_PHY_R + 0x25)
> > +#define PHY_DLL_CNFG2_R		(DWC_MSHC_PTR_PHY_R + 0x26)
> > +#define PHY_DLLDL_CNFG_R	(DWC_MSHC_PTR_PHY_R + 0x28)
> > +#define SLV_INPSEL		0x5
> > +
> > +#define P_VENDOR_SPECIFIC_AREA	0x500
> > +#define EMMC_CTRL_R		(P_VENDOR_SPECIFIC_AREA + 0x2c)
> > +#define AT_CTRL_R		(P_VENDOR_SPECIFIC_AREA + 0x40)
> > +#define AT_EN			0x0
> > +#define CI_SEL			0x1
> > +#define SWIN_TH_EN		0x2
> > +#define RPT_TUNE_ERR		0x3
> > +#define SW_TUNE_EN		0x4
> > +#define WIN_EDGE_SEL		0x8
> > +#define TUNE_CLK_STOP_EN	0x10
> > +#define PRE_CHANGE_DLY		0x11
> > +#define POST_CHANGE_DLY		0x13
> > +#define SWIN_TH_VAL		0x18
> > +
> > +#define DELAY_LINE_HS400	24
> > +#define DELAY_LINE_DEFAULT	50
> > +
> >  #define BOUNDARY_OK(addr, len) \
> >  	((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
> >  
> > @@ -91,6 +148,10 @@ struct dwcmshc_priv {
> >  	struct clk	*bus_clk;
> >  	int vendor_specific_area1; /* P_VENDOR_SPECIFIC_AREA reg */
> >  	void *priv; /* pointer to SoC private stuff */
> > +	uint32_t delay_line;
> > +	bool non_removable;
> 
> can be replaced with mmc_host.caps & MMC_CAP_NONREMOVABLE

Thank you, I'll change in the next version.

> 
> > +	bool pull_up_en;
> > +	bool io_fixed_1v8;
> 
> replace them with flag?

Do you mean that I should replace the above bool's with a single flags
field in the struct where the bool's would become bit fields in flags?

> 
> >  };
> >  
> >  /*
> > @@ -156,11 +217,171 @@ static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  	sdhci_request(mmc, mrq);
> >  }
> >  
> > +static void sdhci_phy_1_8v_init_no_pull(struct sdhci_host *host)
> > +{
> > +	uint32_t val;
> > +	sdhci_writel(host, 1, DWC_MSHC_PTR_PHY_R);
> > +	sdhci_writeb(host, 1 << 4, PHY_SDCLKDL_CNFG_R);
> > +	sdhci_writeb(host, 0x40, PHY_SDCLKDL_DC_R);
> 
> These magic numbers need a proper macro definitions.

I'll try to find out their meaning and document it.

> 
> > +
> > +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > +	val &= ~(1 << 4);
> 
> ditto
> 
> > +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +
> > +
> > +	val = sdhci_readw(host, PHY_CMDPAD_CNFG_R);
> > +	sdhci_writew(host, val | 1, PHY_CMDPAD_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_DATAPAD_CNFG_R);
> > +	sdhci_writew(host, val | 1, PHY_DATAPAD_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_RSTNPAD_CNFG_R);
> > +	sdhci_writew(host, val | 1, PHY_RSTNPAD_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_STBPAD_CNFG_R);
> > +	sdhci_writew(host, val | 1, PHY_STBPAD_CNFG_R);
> > +
> > +	val = sdhci_readb(host, PHY_DLL_CTRL_R);
> > +	sdhci_writeb(host, val | 1, PHY_DLL_CTRL_R);
> > +}
> > +
> > +static void sdhci_phy_3_3v_init_no_pull(struct sdhci_host *host)
> > +{
> > +	uint32_t val;
> > +
> > +	sdhci_writel(host, 1, DWC_MSHC_PTR_PHY_R);
> > +	sdhci_writeb(host, 1 << 4, PHY_SDCLKDL_CNFG_R);
> > +	sdhci_writeb(host, 0x40, PHY_SDCLKDL_DC_R);
> > +
> > +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > +	val &= ~(1 << 4);
> > +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_CMDPAD_CNFG_R);
> > +	sdhci_writew(host, val | 2, PHY_CMDPAD_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_DATAPAD_CNFG_R);
> > +	sdhci_writew(host, val | 2, PHY_DATAPAD_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_RSTNPAD_CNFG_R);
> > +	sdhci_writew(host, val | 2, PHY_RSTNPAD_CNFG_R);
> > +
> > +	val = sdhci_readw(host, PHY_STBPAD_CNFG_R);
> > +	sdhci_writew(host, val | 2, PHY_STBPAD_CNFG_R);
> > +
> > +	val = sdhci_readb(host, PHY_DLL_CTRL_R);
> > +	sdhci_writeb(host, val | 1, PHY_DLL_CTRL_R);
> > +}
> > +
> > +static void th1520_phy_1_8v_init(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	u32 val;
> > +
> > +	if (!priv)
> > +		return;
> > +
> > +	if (priv->pull_up_en == 0) {
> > +		sdhci_phy_1_8v_init_no_pull(host);
> > +		return;
> > +	}
> > +
> > +	/* set driving force */
> > +	sdhci_writel(host, (1 << PHY_RSTN) | (0xc << PAD_SP) | (0xc << PAD_SN), PHY_CNFG_R);
> > +
> > +	/* disable delay lane */
> > +	sdhci_writeb(host, 1 << UPDATE_DC, PHY_SDCLKDL_CNFG_R);
> > +
> > +	/* set delay lane */
> > +	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> > +	sdhci_writeb(host, 0xa, PHY_DLL_CNFG2_R);
> > +
> > +	/* enable delay lane */
> > +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > +	val &= ~(1 << UPDATE_DC);
> > +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +
> > +	val = (1 << RXSEL) | (1 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
> > +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> > +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> > +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> > +
> > +	val = (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
> > +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> > +
> > +	val = (1 << RXSEL) | (2 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
> > +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> > +
> > +	/* enable data strobe mode */
> > +	sdhci_writeb(host, 3 << SLV_INPSEL, PHY_DLLDL_CNFG_R);
> > +	sdhci_writeb(host, (1 << DLL_EN),  PHY_DLL_CTRL_R);
> > +}
> > +
> > +static void th1520_phy_3_3v_init(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	u32 val;
> > +
> > +	if (priv->pull_up_en == 0) {
> > +		sdhci_phy_3_3v_init_no_pull(host);
> > +		return;
> > +	}
> > +
> > +	/* set driving force */
> > +	sdhci_writel(host, (1 << PHY_RSTN) | (0xc << PAD_SP) | (0xc << PAD_SN), PHY_CNFG_R);
> > +
> > +	/* disable delay lane */
> > +	sdhci_writeb(host, 1 << UPDATE_DC, PHY_SDCLKDL_CNFG_R);
> > +
> > +	/* set delay lane */
> > +	sdhci_writeb(host, priv->delay_line, PHY_SDCLKDL_DC_R);
> > +	sdhci_writeb(host, 0xa, PHY_DLL_CNFG2_R);
> > +
> > +	/* enable delay lane */
> > +	val = sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
> > +	val &= ~(1 << UPDATE_DC);
> > +	sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);
> > +
> > +	val = (2 << RXSEL) | (1 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
> > +	sdhci_writew(host, val, PHY_CMDPAD_CNFG_R);
> > +	sdhci_writew(host, val, PHY_DATAPAD_CNFG_R);
> > +	sdhci_writew(host, val, PHY_RSTNPAD_CNFG_R);
> > +
> > +	val = (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
> > +	sdhci_writew(host, val, PHY_CLKPAD_CNFG_R);
> > +
> > +	val = (2 << RXSEL) | (2 << WEAKPULL_EN) | (3 << TXSLEW_CTRL_P) | (3 << TXSLEW_CTRL_N);
> > +	sdhci_writew(host, val, PHY_STBPAD_CNFG_R);
> > +}
> > +
> > +
> > +static void th1520_sdhci_set_phy(struct sdhci_host *host)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	u8 emmc_ctl;
> > +
> > +	/* Before power on, set PHY configs */
> > +	emmc_ctl = sdhci_readw(host, EMMC_CTRL_R);
> > +	if (priv->non_removable) {
> > +		th1520_phy_1_8v_init(host);
> > +		emmc_ctl |= (1 << DWCMSHC_CARD_IS_EMMC);
> > +	} else {
> > +		th1520_phy_3_3v_init(host);
> > +		emmc_ctl &=~(1 << DWCMSHC_CARD_IS_EMMC);
> > +	}
> > +	sdhci_writeb(host, emmc_ctl, EMMC_CTRL_R);
> > +	sdhci_writeb(host, 0x25, PHY_DLL_CNFG1_R);
> 
> magic 0x25 needs a meaningful MACRO definition.

Okay, I'll investigate the meaning of that value and define it.

> 
> > +}
> > +
> >  static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
> >  				      unsigned int timing)
> >  {
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >  	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +
> 
> we don't need this extra blank line

Okay

> 
> >  	u16 ctrl, ctrl_2;
> >  
> >  	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > @@ -188,7 +409,22 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
> >  		ctrl_2 |= DWCMSHC_CTRL_HS400;
> >  	}
> >  
> > +	if (priv->io_fixed_1v8)
> > +		ctrl_2 |= SDHCI_CTRL_VDD_180;
> > +
> >  	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +
> > +	/* TODO: add check so that this only runs on th1520  */
> 
> this TODO needs to be solved since it affects other platforms such as NV
> and RK

Yes, I need to fix this. For the next version, I am considering adding
a flag to dwcmshc_priv that would gate the following code block.


> > +	if (timing == MMC_TIMING_MMC_HS400) {
> > +		/* disable auto tuning */
> > +		u32 reg = sdhci_readl(host, AT_CTRL_R);
> > +		reg &= ~1;
> > +		sdhci_writel(host, reg, AT_CTRL_R);
> > +		priv->delay_line = DELAY_LINE_HS400;
> > +		th1520_sdhci_set_phy(host);
> > +	} else {
> > +		sdhci_writeb(host, 0, PHY_DLLDL_CNFG_R);
> > +	}
> >  }
> >  
> >  static void dwcmshc_hs400_enhanced_strobe(struct mmc_host *mmc,
> > @@ -337,6 +573,49 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> >  	sdhci_reset(host, mask);
> >  }
> >  
> > +static int th1520_execute_tuning(struct sdhci_host *host, u32 opcode)
> > +{
> > +	u32 val = 0;
> > +
> > +	sdhci_writeb(host, 3 << INPSEL_CNFG, PHY_ATDL_CNFG_R);
> > +
> > +	val = sdhci_readl(host, AT_CTRL_R);
> > +	val &= ~((1 << CI_SEL) | (1 << RPT_TUNE_ERR) \
> > +	    | (1 << SW_TUNE_EN) |(0xf << WIN_EDGE_SEL));
> > +	val |= (1 << AT_EN) | (1 << SWIN_TH_EN) | (1 << TUNE_CLK_STOP_EN)\
> > +	    | (1 << PRE_CHANGE_DLY) | (3 << POST_CHANGE_DLY) | (9 << SWIN_TH_VAL);
> > +
> > +	sdhci_writel(host, val, AT_CTRL_R);
> > +
> > +	val = sdhci_readl(host, AT_CTRL_R);
> > +	if(!(val & (1 << AT_EN))) {
> > +		pr_warn("%s(): auto tuning is not enabled", __func__);
> 
> AFAIK, the controller supports both auto tuning and sw tuning.

Okay, I'll have to investigate further why it is like this in the vendor
kernel [2].

> 
> > +		return -1;
> 
> can we replace -1 with meaningful error number?
> 

Yes, will do for next version.

> > +	}
> > +
> > +	val &= ~(1 << AT_EN);
> > +	sdhci_writel(host, val, AT_CTRL_R);
> > +
> > +	return 0;
> > +}
> > +
> > +static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> > +	u16 ctrl_2;
> > +
> > +	sdhci_reset(host, mask);
> > +
> > +	if(priv->io_fixed_1v8){
> > +		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > +		if(! (ctrl_2 & SDHCI_CTRL_VDD_180)){
> > +			ctrl_2 |= SDHCI_CTRL_VDD_180;
> > +			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +		}
> > +	}
> > +}
> > +
> >  static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >  	.set_clock		= sdhci_set_clock,
> >  	.set_bus_width		= sdhci_set_bus_width,
> > @@ -355,6 +634,17 @@ static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
> >  	.adma_write_desc	= dwcmshc_adma_write_desc,
> >  };
> >  
> > +static const struct sdhci_ops sdhci_dwcmshc_th1520_ops = {
> > +	.set_clock		= sdhci_set_clock,
> > +	.set_bus_width		= sdhci_set_bus_width,
> > +	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> > +	.get_max_clock		= dwcmshc_get_max_clock,
> > +	.reset			= th1520_sdhci_reset,
> > +	.adma_write_desc	= dwcmshc_adma_write_desc,
> > +	.voltage_switch		= th1520_phy_1_8v_init,
> > +	.platform_execute_tuning = &th1520_execute_tuning,
> > +};
> > +
> >  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
> >  	.ops = &sdhci_dwcmshc_ops,
> >  	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> > @@ -378,6 +668,15 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk35xx_pdata = {
> >  		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> >  };
> >  
> > +static const struct sdhci_pltfm_data sdhci_dwcmshc_th1520_pdata = {
> > +	.ops = &sdhci_dwcmshc_th1520_ops,
> > +
> > +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> > +		  SDHCI_QUIRK_BROKEN_DMA |
> > +		  SDHCI_QUIRK_BROKEN_ADMA,
> > +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> > +};
> > +
> >  static int dwcmshc_rk35xx_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
> >  {
> >  	int err;
> > @@ -434,6 +733,10 @@ static void dwcmshc_rk35xx_postinit(struct sdhci_host *host, struct dwcmshc_priv
> >  }
> >  
> >  static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
> > +	{
> > +		.compatible = "thead,th1520-dwcmshc",
> > +		.data = &sdhci_dwcmshc_th1520_pdata,
> > +	},
> >  	{
> >  		.compatible = "rockchip,rk3588-dwcmshc",
> >  		.data = &sdhci_dwcmshc_rk35xx_pdata,
> > @@ -541,6 +844,39 @@ static int dwcmshc_probe(struct platform_device *pdev)
> >  			goto err_clk;
> >  	}
> >  
> > +	if (pltfm_data == &sdhci_dwcmshc_th1520_pdata) {
> > +
> > +		priv->delay_line = DELAY_LINE_DEFAULT;
> > +
> > +		if (device_property_present(&pdev->dev, "non-removable"))
> > +			priv->non_removable = 1;
> > +		else
> > +			priv->non_removable = 0;
> > +
> > +		if (device_property_present(&pdev->dev, "thead,pull-up"))
> > +			priv->pull_up_en = 1;
> > +		else
> > +			priv->pull_up_en = 0;
> > +
> > +		if (device_property_present(&pdev->dev, "thead,io-fixed-1v8"))
> > +			priv->io_fixed_1v8 = true;
> > +		else
> > +			priv->io_fixed_1v8 = false;
> > +
> > +		/*
> > +		 * start_signal_voltage_switch() will try 3.3V first
> > +		 * then 1.8V. Use SDHCI_SIGNALING_180 ranther than
> > +		 * SDHCI_SIGNALING_330 to avoid setting voltage to 3.3V
> > +		 * in sdhci_start_signal_voltage_switch().
> > +		 */
> > +		if(priv->io_fixed_1v8){
> > +			host->flags &=~SDHCI_SIGNALING_330;
> > +			host->flags |= SDHCI_SIGNALING_180;
> > +		}
> > +
> > +		sdhci_enable_v4_mode(host);
> > +	}
> > +
> >  #ifdef CONFIG_ACPI
> >  	if (pltfm_data == &sdhci_dwcmshc_bf3_pdata)
> >  		sdhci_enable_v4_mode(host);
> > 
> > -- 
> > 2.34.1
> > 

Thank you,
Drew

[1] https://gist.github.com/pdp7/a8301b895c2dc293f2e0210e77e45e01
[2] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead-linux/-/blob/beaglev-v5.10.113-1.1.2/drivers/mmc/host/sdhci-of-dwcmshc.c#L238
