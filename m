Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461CF8092BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443975AbjLGUrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjLGUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:47:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A361728
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:47:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D638EC433C7;
        Thu,  7 Dec 2023 20:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982038;
        bh=szsXL9Pkyj4AVfw+UsXxMv2rdIObYfpxXnQD6RrB26Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BABDhGjeDklAokNm+6dGqWNnZfxS3OO2Vc3g2Y+0ipyVsnBwl0U98CGmYZstopMuq
         E8i88OMhYZnALskRuMHpJ2CNniaeZ0NGLWFqjpI7P05HYTqLDzCIFUzz0u0FURk7v2
         p/KaNNFB51Liqer6Jc/o5I4JIL9b6ozn1mPSw4vv/1zzvivbFuGkfVI+67ktZE4TnX
         UXZVVLEAWRhaPsMVE5S5FHw+xdc09hx0cSW4EIIP4RP7RBi9nIDBH6SopoPsiEAUzm
         iPRc8TR+1Rfgeq7H5DBoF9WxMVuP4rD4F6GbBcVlLFZ+JqzW4b3SCn9aBp3Zlqj/SE
         GD7C2o9DZgltg==
Date:   Thu, 7 Dec 2023 14:47:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Bottini <michael.a.bottini@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v2 1/6] PCI/ASPM: Add locked helper for enabling link
 state
Message-ID: <20231207204716.GA764883@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128081512.19387-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Kai-Heng]

On Tue, Nov 28, 2023 at 09:15:07AM +0100, Johan Hovold wrote:
> Add a helper for enabling link states that can be used in contexts where
> a pci_bus_sem read lock is already held (e.g. from pci_walk_bus()).
> 
> This helper will be used to fix a couple of potential deadlocks where
> the current helper is called with the lock already held, hence the CC
> stable tag.
> 
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> Cc: stable@vger.kernel.org	# 6.3
> Cc: Michael Bottini <michael.a.bottini@linux.intel.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/pcie/aspm.c | 53 +++++++++++++++++++++++++++++++----------
>  include/linux/pci.h     |  3 +++
>  2 files changed, 43 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 50b04ae5c394..5eb462772354 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1109,17 +1109,7 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> -/**
> - * pci_enable_link_state - Clear and set the default device link state so that
> - * the link may be allowed to enter the specified states. Note that if the
> - * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> - * touch the LNKCTL register. Also note that this does not enable states
> - * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> - *
> - * @pdev: PCI device
> - * @state: Mask of ASPM link states to enable
> - */
> -int pci_enable_link_state(struct pci_dev *pdev, int state)
> +static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  {
>  	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
>  
> @@ -1136,7 +1126,8 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  		return -EPERM;
>  	}
>  
> -	down_read(&pci_bus_sem);
> +	if (!locked)
> +		down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	link->aspm_default = 0;
>  	if (state & PCIE_LINK_STATE_L0S)
> @@ -1157,12 +1148,48 @@ int pci_enable_link_state(struct pci_dev *pdev, int state)
>  	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
>  	pcie_set_clkpm(link, policy_to_clkpm_state(link));
>  	mutex_unlock(&aspm_lock);
> -	up_read(&pci_bus_sem);
> +	if (!locked)
> +		up_read(&pci_bus_sem);
>  
>  	return 0;
>  }
> +
> +/**
> + * pci_enable_link_state - Clear and set the default device link state so that
> + * the link may be allowed to enter the specified states. Note that if the
> + * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
> + * touch the LNKCTL register. Also note that this does not enable states
> + * disabled by pci_disable_link_state(). Return 0 or a negative errno.
> + *
> + * @pdev: PCI device
> + * @state: Mask of ASPM link states to enable
> + */
> +int pci_enable_link_state(struct pci_dev *pdev, int state)
> +{
> +	return __pci_enable_link_state(pdev, state, false);
> +}
>  EXPORT_SYMBOL(pci_enable_link_state);

As far as I can see, we end up with pci_enable_link_state() defined
but never called and pci_enable_link_state_locked() being called only
by pcie-qcom.c and vmd.c.

Can we just rename pci_enable_link_state() to
pci_enable_link_state_locked() and assert that pci_bus_sem is held, so
we don't end up with a function that's never used?

I hope we can obsolete this whole idea someday.  Using pci_walk_bus()
in qcom and vmd to enable ASPM is an ugly hack to work around this
weird idea that "the OS isn't allowed to enable more ASPM states than
the BIOS did because the BIOS might have left ASPM disabled because it
knows about hardware issues."  More history at
https://lore.kernel.org/linux-pci/20230615070421.1704133-1-kai.heng.feng@canonical.com/T/#u

I think we need to get to a point where Linux enables all supported
ASPM features by default.  If we really think x86 BIOS assumes an
implicit contract that the OS will never enable ASPM more
aggressively, we might need some kind of arch quirk for that.

If we can get there, the qcom use of pci_enable_link_state() could go
away, and the vmd use could be replaced by some kind of "if device is
below VMD, get rid of the legacy x86 ASPM assumption" quirk.

Bjorn
