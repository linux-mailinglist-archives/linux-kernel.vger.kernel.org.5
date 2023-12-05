Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66A8053B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442326AbjLEMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbjLEMCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:02:01 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B19098;
        Tue,  5 Dec 2023 04:02:05 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36EEE844;
        Tue,  5 Dec 2023 13:01:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701777683;
        bh=bKZroPFsFtSdTPyHK0rJbVB9cPk+QtCuoUpKU4CunHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jee2wC3vSvY6cG7oCEtuQCbYH28IrZRKNXyIbJavutI6wA80Gy2Sm6o6cjQULbx5a
         M0SsPcBZFREcK+ZkNDNh13v/h4DHlS4XNrw2Xmk4OrPT6yn5HMFlQOfh2UlN/sZEjD
         nL3LaJ+XqCd35cYQ5mZorCOUYhcIbi1aF10XcdWY=
Date:   Tue, 5 Dec 2023 14:02:10 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] media: rkisp1: Fix IRQ handling due to shared
 interrupts
Message-ID: <20231205120210.GC17394@pendragon.ideasonboard.com>
References: <20231205-rkisp-irq-fix-v1-0-f4045c74ba45@ideasonboard.com>
 <20231205-rkisp-irq-fix-v1-3-f4045c74ba45@ideasonboard.com>
 <20231205082016.GA17394@pendragon.ideasonboard.com>
 <9b28dcf7-c9a0-4d68-9197-cdcdd9f0393b@ideasonboard.com>
 <CAHCN7xKdCixYtFE=NrfLiLNjZrV5Xrg27fMMTrdA_7-Tg9Ujfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHCN7xKdCixYtFE=NrfLiLNjZrV5Xrg27fMMTrdA_7-Tg9Ujfg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 05:49:30AM -0600, Adam Ford wrote:
> On Tue, Dec 5, 2023 at 2:27 AM Tomi Valkeinen wrote:
> > On 05/12/2023 10:20, Laurent Pinchart wrote:
> > > On Tue, Dec 05, 2023 at 10:09:34AM +0200, Tomi Valkeinen wrote:
> > >> The driver requests the interrupts as IRQF_SHARED, so the interrupt
> > >> handlers can be called at any time. If such a call happens while the ISP
> > >> is powered down, the SoC will hang as the driver tries to access the
> > >> ISP registers.
> > >
> > > Is IRQF_SHARED actually needed ?
> >
> > I don't have any answer to that, but it seems to have always been there.
> > Dropping it would simplify the code, but we can only do that if we are
> > sure all the platforms the ISP is used on or will be used on won't share
> > the interrupt.
> 
> I can't speak for the Rockchip, but from what I can see, the imx8mp
> has multiple causes for Interrupt 74 and  75, but they all appear to
> be ISP1 and ISP2 related.

The ISP has multiple interrupt lines. In some SoCs, they're all wired to
a single line of the IRQ controller (e.g. RK3399 and i.MX8MP), while
other SoCs use separate interrupts (e.g. PX30). I have checked the PX30,
RK3399 and i.MX8MP datasheets, and the ISP interrupts are not shared
with any other peripheral. I think it's thus safe to drop IRQF_SHARED.

> > >> Fix this by adding a new field, 'irqs_enabled', which is used to bail
> > >> out from the interrupt handler when the ISP is not operational.
> > >>
> > >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > >> ---
> > >>   .../media/platform/rockchip/rkisp1/rkisp1-capture.c |  3 +++
> > >>   .../media/platform/rockchip/rkisp1/rkisp1-common.h  |  2 ++
> > >>   drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c |  3 +++
> > >>   drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c | 21 +++++++++++++++++++++
> > >>   drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c |  3 +++
> > >>   5 files changed, 32 insertions(+)
> > >>
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > >> index b50b044d22af..e92067897f28 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
> > >> @@ -779,6 +779,9 @@ irqreturn_t rkisp1_capture_isr(int irq, void *ctx)
> > >>      unsigned int i;
> > >>      u32 status;
> > >>
> > >> +    if (!rkisp1->irqs_enabled)
> > >> +            return IRQ_NONE;
> > >> +
> > >>      status = rkisp1_read(rkisp1, RKISP1_CIF_MI_MIS);
> > >>      if (!status)
> > >>              return IRQ_NONE;
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > >> index ec28907d978e..7f97fdf6e24c 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
> > >> @@ -465,6 +465,7 @@ struct rkisp1_debug {
> > >>    * @debug:    debug params to be exposed on debugfs
> > >>    * @info:     version-specific ISP information
> > >>    * @irqs:          IRQ line numbers
> > >> + * @irqs_enabled:  the hardware is enabled and can cause interrupts
> > >>    */
> > >>   struct rkisp1_device {
> > >>      void __iomem *base_addr;
> > >> @@ -488,6 +489,7 @@ struct rkisp1_device {
> > >>      struct rkisp1_debug debug;
> > >>      const struct rkisp1_info *info;
> > >>      int irqs[RKISP1_NUM_IRQS];
> > >> +    bool irqs_enabled;
> > >>   };
> > >>
> > >>   /*
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> > >> index 47f4353a1784..f6b54654b435 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-csi.c
> > >> @@ -184,6 +184,9 @@ irqreturn_t rkisp1_csi_isr(int irq, void *ctx)
> > >>      struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> > >>      u32 val, status;
> > >>
> > >> +    if (!rkisp1->irqs_enabled)
> > >> +            return IRQ_NONE;
> > >> +
> > >>      status = rkisp1_read(rkisp1, RKISP1_CIF_MIPI_MIS);
> > >>      if (!status)
> > >>              return IRQ_NONE;
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > >> index 1d60f4b8bd09..fbe03f7864e3 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
> > >> @@ -306,6 +306,23 @@ static int __maybe_unused rkisp1_runtime_suspend(struct device *dev)
> > >>   {
> > >>      struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> > >>
> > >> +    rkisp1->irqs_enabled = false;
> > >> +    /* Make sure the IRQ handler will see the above */
> > >> +    mb();
> > >> +
> > >> +    /*
> > >> +     * Wait until any running IRQ handler has returned. The IRQ handler
> > >> +     * may get called even after this (as it's a shared interrupt line)
> > >> +     * but the 'irqs_enabled' flag will make the handler return immediately.
> > >> +     */
> > >> +    for (unsigned int i = 0; i < RKISP1_NUM_IRQS; ++i) {
> > >> +            if (rkisp1->irqs[i] == -1)
> > >> +                    continue;
> > >> +
> > >> +            if (i == 0 || rkisp1->irqs[i - 1] != rkisp1->irqs[i])
> > >> +                    synchronize_irq(rkisp1->irqs[i]);
> > >> +    }
> > >> +
> > >>      clk_bulk_disable_unprepare(rkisp1->clk_size, rkisp1->clks);
> > >>      return pinctrl_pm_select_sleep_state(dev);
> > >>   }
> > >> @@ -322,6 +339,10 @@ static int __maybe_unused rkisp1_runtime_resume(struct device *dev)
> > >>      if (ret)
> > >>              return ret;
> > >>
> > >> +    rkisp1->irqs_enabled = true;
> > >> +    /* Make sure the IRQ handler will see the above */
> > >> +    mb();
> > >> +
> > >>      return 0;
> > >>   }
> > >>
> > >> diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > >> index dafbfd230542..d6b8786661ad 100644
> > >> --- a/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > >> +++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-isp.c
> > >> @@ -1082,6 +1082,9 @@ irqreturn_t rkisp1_isp_isr(int irq, void *ctx)
> > >>      struct rkisp1_device *rkisp1 = dev_get_drvdata(dev);
> > >>      u32 status, isp_err;
> > >>
> > >> +    if (!rkisp1->irqs_enabled)
> > >> +            return IRQ_NONE;
> > >> +
> > >>      status = rkisp1_read(rkisp1, RKISP1_CIF_ISP_MIS);
> > >>      if (!status)
> > >>              return IRQ_NONE;

-- 
Regards,

Laurent Pinchart
