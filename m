Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBEAC7EFB58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344566AbjKQWYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQWYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:24:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F261B8;
        Fri, 17 Nov 2023 14:24:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B29C433C7;
        Fri, 17 Nov 2023 22:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700259858;
        bh=B5vSl8vzWKTdqw2aSx8Cq887DgcvBzsRmJp1OK7uIXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MTHvkjbCO6H2z19g2/jJxmCWga+Licy9Inq+Hr7eSsX5ptNqjX4jb2JFl7e0yDV6f
         dQldwAOLAPKmRBP1QBYHUKqmLVszcT8fNUG5RCtNm3rWDy5tst3JYKHL0LsZpr51/k
         1AGiLLlW60Xrq1O8kKaeptCRss0vDVx2UB87I4vGIQTdzpWi7PVNJMHHZyxj5nHTIG
         puVuVIjtLFmOAuNrFnS6InTdRJ4ywxB87Ub9j3FS5qsDibaPJCD0ZYU2zrsVUtf+2V
         liud4fZqW9mP4kHa3FBZuAZBETVyWYDl5i2KLm+3yDcJSvTtfsJfCkYBehZIWM7NO5
         39efab78ppUnw==
Date:   Fri, 17 Nov 2023 16:24:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW
 accessors
Message-ID: <20231117222416.GA94936@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117094425.80477-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:44:19AM +0200, Ilpo Järvinen wrote:
> The rtlwifi driver comes with custom code to write into PCIe Link
> Control register. RMW access for the Link Control register requires
> locking that is already provided by the standard PCIe capability
> accessors.
> 
> Convert the custom RMW code writing into LNKCTL register to standard
> RMW capability accessors. The accesses are changed to cover the full
> LNKCTL register instead of touching just a single byte of the register.
> 
> After custom LNKCTL access code is removed, .num4bytes in the struct
> mp_adapter is no longer needed.

Looks like some nice fixes here.  I confess they're not all obvious to
me.

> @@ -164,21 +164,27 @@ static bool _rtl_pci_platform_switch_device_pci_aspm(
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>  
> +	value &= PCI_EXP_LNKCTL_ASPMC;
> +
>  	if (rtlhal->hw_type != HARDWARE_TYPE_RTL8192SE)
>  		value |= 0x40;

I guess this 0x40 is PCI_EXP_LNKCTL_CCC?

> -	pci_write_config_byte(rtlpci->pdev, 0x80, value);
> +	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,

PCI_EXP_LNKCTL is 0x10, so I guess we know somehow that the PCIe
Capability is at 0x70?

> +					   PCI_EXP_LNKCTL_ASPMC | value,
> +					   value);
>  
>  	return false;
>  }
>  
>  /*When we set 0x01 to enable clk request. Set 0x0 to disable clk req.*/
> -static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u8 value)
> +static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u16 value)
>  {
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
>  
> -	pci_write_config_byte(rtlpci->pdev, 0x81, value);
> +	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_CLKREQ_EN,

Depends on the fact that the caller only passes 0 or 1.  Ugly, but
looks true, and I see you clean this up a little more later.  I like
how you made it explicit in _rtl_pci_platform_switch_device_pci_aspm()
above by masking the value to set.

> +					   value);
>  
>  	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192SE)
>  		udelay(100);
> @@ -192,11 +198,8 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
>  	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
> -	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
>  	/*Retrieve original configuration settings. */
>  	u8 linkctrl_reg = pcipriv->ndis_adapter.linkctrl_reg;
> -	u16 pcibridge_linkctrlreg = pcipriv->ndis_adapter.
> -				pcibridge_linkctrlreg;
>  	u16 aspmlevel = 0;
>  	u8 tmp_u1b = 0;
>  
> @@ -221,15 +224,12 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
>  	/*Set corresponding value. */
>  	aspmlevel |= BIT(0) | BIT(1);
>  	linkctrl_reg &= ~aspmlevel;
> -	pcibridge_linkctrlreg &= ~(BIT(0) | BIT(1));
>  
>  	_rtl_pci_platform_switch_device_pci_aspm(hw, linkctrl_reg);
>  	udelay(50);
>  
> -	/*4 Disable Pci Bridge ASPM */
> -	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
> -			      pcibridge_linkctrlreg);
> -
> +	pcie_capability_clear_word(rtlpci->pdev, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_ASPMC);
>  	udelay(50);
>  }
>  
> @@ -245,7 +245,6 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
>  	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
>  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
>  	u8 pcibridge_vendor = pcipriv->ndis_adapter.pcibridge_vendor;
> -	u8 num4bytes = pcipriv->ndis_adapter.num4bytes;
>  	u16 aspmlevel;
>  	u8 u_pcibridge_aspmsetting;
>  	u8 u_device_aspmsetting;
> @@ -268,13 +267,14 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
>  	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_INTEL)
>  		u_pcibridge_aspmsetting &= ~BIT(0);
>  
> -	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
> -			      u_pcibridge_aspmsetting);
> +	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
> +					   PCI_EXP_LNKCTL_ASPMC,
> +					   u_pcibridge_aspmsetting &
> +					   PCI_EXP_LNKCTL_ASPMC);
>  
>  	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
> -		"PlatformEnableASPM(): Write reg[%x] = %x\n",
> -		(pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
> -		u_pcibridge_aspmsetting);
> +		"PlatformEnableASPM(): Write ASPM = %x\n",
> +		u_pcibridge_aspmsetting & PCI_EXP_LNKCTL_ASPMC);
>  
>  	udelay(50);
>  
> @@ -291,7 +291,8 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
>  
>  	if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_CLK_REQ) {
>  		_rtl_pci_switch_clk_req(hw, (ppsc->reg_rfps_level &
> -					     RT_RF_OFF_LEVL_CLK_REQ) ? 1 : 0);
> +					     RT_RF_OFF_LEVL_CLK_REQ) ?
> +					     PCI_EXP_LNKCTL_CLKREQ_EN : 0);
>  		RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_CLK_REQ);
>  	}
>  	udelay(100);
> @@ -2030,8 +2031,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
>  		    PCI_FUNC(bridge_pdev->devfn);
>  		pcipriv->ndis_adapter.pcibridge_pciehdr_offset =
>  		    pci_pcie_cap(bridge_pdev);
> -		pcipriv->ndis_adapter.num4bytes =
> -		    (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10) / 4;

I don't understand what's going on here.  Are we caching the PCIe
Capability offset of the *upstream bridge* here?  And then computing
the dword offset of the *bridge's* LNKCTL?  And then writing a byte to
the rtlwifi device (not the bridge) at the dword offset << 2, i.e., the
byte offset?  I must be out to lunch, because how could that ever
work?

If we were using the bridge capability location to write to the
rtlwifi device, that would clearly be a bug fix that would merit its
own patch.

Maybe this num4bytes thing could be its own patch, too.  Seems so
cumbersome that it makes me wonder if the device has issues with
larger accesses.

>  		rtl_pci_get_linkcontrol_field(hw);
>  
> diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.h b/drivers/net/wireless/realtek/rtlwifi/pci.h
> index 866861626a0a..57174b93db83 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/pci.h
> +++ b/drivers/net/wireless/realtek/rtlwifi/pci.h
> @@ -236,8 +236,6 @@ struct mp_adapter {
>  	u16 pcibridge_vendorid;
>  	u16 pcibridge_deviceid;
>  
> -	u8 num4bytes;
> -
>  	u8 pcibridge_pciehdr_offset;
>  	u8 pcibridge_linkctrlreg;
>  
> -- 
> 2.30.2
> 
