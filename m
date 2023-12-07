Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F218E808249
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377955AbjLGIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjLGH77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:59:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F674A9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:00:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB39C433C7;
        Thu,  7 Dec 2023 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701936004;
        bh=I681gHWMUSa0Ipi09gdgntlBhUESlz33stQ0H29C43o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isIq0Z1Zo2xyN9yQmONswOxPpZI/SHW+J6RK13AEY+reg6kdXEMFUqnajpRgxtE9p
         TVYV2YD6CTK7DynnWBIwybKrVQ+38vg/j7jZCv11QEbzPwCzaZ1fi+hcB6G0rl91Ww
         08D9+pnkkOBNUsF5+VBm5Uj0XtODYcCoArh+EJ7AZ2e7fmO0Eql9hVbjrMqW1zhXjH
         bK/3tBQ4GkxuG34ULsud3h/+pMxbP54UdhZf+J3talfW3WZGQ2DML9ie2Kx5FPixLU
         qoUKVBMRgBug4xnCswBjbfrpWFqO7gU0LBsRgvmAHzWVlPr13yWRaedbNqyiPYr7BV
         Dz88b1LGr7pgg==
Date:   Thu, 7 Dec 2023 13:29:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     bhelgaas@google.com, thierry.reding@gmail.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
Subject: Re: [RFC,v14 4/5] arm64: tegra: Add PCIe port node with PCIe WAKE#
 for C1 controller
Message-ID: <20231207075952.GG2932@thinkpad>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-5-mmaddireddy@nvidia.com>
 <20231206153627.GJ12802@thinkpad>
 <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c86e8f75-f74a-491e-9ac0-2431a6ec4b80@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 12:54:04PM +0530, Manikanta Maddireddy wrote:
> 
> On 06-12-2023 21:06, Manivannan Sadhasivam wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Feb 08, 2023 at 04:46:44PM +0530, Manikanta Maddireddy wrote:
> > > Add PCIe port node under the PCIe controller-1 device tree node to support
> > > PCIe WAKE# interrupt for WiFi.
> > > 
> > > Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> > > ---
> > > 
> > > Changes in v14:
> > > New patch in the series to support PCIe WAKE# in NVIDIA Jetson AGX Orin.
> > > 
> > >   .../dts/nvidia/tegra234-p3737-0000+p3701-0000.dts     | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > index 8a9747855d6b..9c89be263141 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
> > > @@ -2147,6 +2147,17 @@ pcie@14100000 {
> > > 
> > >                        phys = <&p2u_hsio_3>;
> > >                        phy-names = "p2u-0";
> > > +
> > > +                     pci@0,0 {
> > > +                             reg = <0x0000 0 0 0 0>;
> > > +                             #address-cells = <3>;
> > > +                             #size-cells = <2>;
> > > +                             ranges;
> > > +
> > > +                             interrupt-parent = <&gpio>;
> > > +                             interrupts = <TEGRA234_MAIN_GPIO(L, 2) IRQ_TYPE_LEVEL_LOW>;
> > > +                             interrupt-names = "wakeup";
> > WAKE# should be part of the PCIe controller, not device. And the interrupt name
> > should be "wake".
> > 
> > - Mani
> Hi,
> 
> Please refer to the discussion in below link, WAKE# is per PCI bridge.
> https://patchwork.ozlabs.org/project/linux-pci/patch/20171226020806.32710-2-jeffy.chen@rock-chips.com/
> 

PCIe Host controller (RC) usually represents host bridge + PCI-PCI bridge. We do
not represent the PCI-PCI bridge in devicetree for any platforms, but only RC as
a whole.

Moreover, PERST# is already defined in RC node. So it becomes confusing if
WAKE# is defined in a child node representing bridge.

So please move WAKE# to RC node.

- Mani

> I carried wakeup name defined in previous version, but wake seems to be
> sufficient.
> 
> Thanks,
> Manikanta
> > 
> > > +                     };
> > >                };
> > > 
> > >                pcie@14160000 {
> > > --
> > > 2.25.1
> > > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
