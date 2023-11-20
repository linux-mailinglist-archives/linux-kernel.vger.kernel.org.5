Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704E7F0EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjKTJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTJZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:25:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F4DCD;
        Mon, 20 Nov 2023 01:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700472308; x=1732008308;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=BVUYYQ1JYAQmJwUnfzncwjq61tORuEuESunZjowyk9o=;
  b=RoO18/ZUgKH+IGafBqYuRiwNfDVEkPmNmRc0YsFPvqJ6ALrkh2I5Fpbk
   U5/Krds5dG7rsKf+vImHCYkUWVgf2YfSOpgNXqfmlFb5woNZM45fgzbHo
   lw5FjVIfVQs2+geGQMsfVliUtNhsvlECTydNvTPSFd2infdrl0/fl38uB
   XOsuajJQy10sBu8T5QVq1nVyFNOckUzrjvnFyTHi3yZeBo8pWQC+PmjXJ
   QWP1iCkr6x3u5bc1VV8kPsd8CNq7I2HuXT4LfaFweWwgOfHcZps+FpiYS
   w4Bzfg2dwGd1XPtB9VB/zeTZoe1pysD5Q3Y/Y9DZh3G/m/otpwzmSkRhJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="4765284"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="4765284"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795418486"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="795418486"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:25:05 -0800
Date:   Mon, 20 Nov 2023 11:25:03 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] wifi: rtlwifi: Convert LNKCTL change to PCIe cap
 RMW accessors
In-Reply-To: <20231117222416.GA94936@bhelgaas>
Message-ID: <bcb6c224-c279-bfa3-5bf0-d1e7512f44cb@linux.intel.com>
References: <20231117222416.GA94936@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1911404933-1700466388=:2032"
Content-ID: <118f9d3-aec8-f64a-2857-2dfad61f381c@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1911404933-1700466388=:2032
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <79bf996f-ae7-d121-1633-98d3cdbca3de@linux.intel.com>

On Fri, 17 Nov 2023, Bjorn Helgaas wrote:

> On Fri, Nov 17, 2023 at 11:44:19AM +0200, Ilpo Järvinen wrote:
> > The rtlwifi driver comes with custom code to write into PCIe Link
> > Control register. RMW access for the Link Control register requires
> > locking that is already provided by the standard PCIe capability
> > accessors.
> > 
> > Convert the custom RMW code writing into LNKCTL register to standard
> > RMW capability accessors. The accesses are changed to cover the full
> > LNKCTL register instead of touching just a single byte of the register.
> > 
> > After custom LNKCTL access code is removed, .num4bytes in the struct
> > mp_adapter is no longer needed.
> 
> Looks like some nice fixes here.  I confess they're not all obvious to
> me.

It took a while to figure out what it is doing, yes... and while figuring
it out, I found more and more to cleanup... And seems you also found some
more... ;-) lol.

When going all the way with cleanups, I tend run this kind of things that 
are not all that obvious but those are usually the most valuable cleanups 
(and normally cannot be automated either so we'll have a lot less people 
looking at them).

> > @@ -164,21 +164,27 @@ static bool _rtl_pci_platform_switch_device_pci_aspm(
> >  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
> >  	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
> >  
> > +	value &= PCI_EXP_LNKCTL_ASPMC;
> > +
> >  	if (rtlhal->hw_type != HARDWARE_TYPE_RTL8192SE)
> >  		value |= 0x40;
> 
> I guess this 0x40 is PCI_EXP_LNKCTL_CCC?

Good point, I forgot to change that in 2/7 and it belongs logically into 
this patch anyway so I'll add it to this patch.

> > -	pci_write_config_byte(rtlpci->pdev, 0x80, value);
> > +	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
> 
> PCI_EXP_LNKCTL is 0x10, so I guess we know somehow that the PCIe
> Capability is at 0x70?

It's what I inferred based on the offsets of LNKCTL & DEVCTL2. And if 
that assumption does not hold with all these devices, the writes would 
just wreck some random havoc. :-/

> > +					   PCI_EXP_LNKCTL_ASPMC | value,
> > +					   value);
> >  
> >  	return false;
> >  }
> >  
> >  /*When we set 0x01 to enable clk request. Set 0x0 to disable clk req.*/
> > -static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u8 value)
> > +static void _rtl_pci_switch_clk_req(struct ieee80211_hw *hw, u16 value)
> >  {
> >  	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
> >  	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
> >  
> > -	pci_write_config_byte(rtlpci->pdev, 0x81, value);
> > +	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
> > +					   PCI_EXP_LNKCTL_CLKREQ_EN,
> 
> Depends on the fact that the caller only passes 0 or 1.  Ugly, but
> looks true, and I see you clean this up a little more later.  I like
> how you made it explicit in _rtl_pci_platform_switch_device_pci_aspm()
> above by masking the value to set.

I thought of adding the masking here too but since it wasn't strictly 
necessary, I didn't. But I can add that now and I'll also update the 
comment to match the code :-).

These code fragments hopefully die anyway once I get the ASPM from 
drivers to core series done.

> > @@ -268,13 +267,14 @@ static void rtl_pci_enable_aspm(struct ieee80211_hw *hw)
> >  	if (pcibridge_vendor == PCI_BRIDGE_VENDOR_INTEL)
> >  		u_pcibridge_aspmsetting &= ~BIT(0);
> >  
> > -	pci_write_config_byte(rtlpci->pdev, (num4bytes << 2),
> > -			      u_pcibridge_aspmsetting);
> > +	pcie_capability_clear_and_set_word(rtlpci->pdev, PCI_EXP_LNKCTL,
> > +					   PCI_EXP_LNKCTL_ASPMC,
> > +					   u_pcibridge_aspmsetting &
> > +					   PCI_EXP_LNKCTL_ASPMC);
> >  
> >  	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
> > -		"PlatformEnableASPM(): Write reg[%x] = %x\n",
> > -		(pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10),
> > -		u_pcibridge_aspmsetting);
> > +		"PlatformEnableASPM(): Write ASPM = %x\n",
> > +		u_pcibridge_aspmsetting & PCI_EXP_LNKCTL_ASPMC);
> >  
> >  	udelay(50);

> > @@ -2030,8 +2031,6 @@ static bool _rtl_pci_find_adapter(struct pci_dev *pdev,
> >  		    PCI_FUNC(bridge_pdev->devfn);
> >  		pcipriv->ndis_adapter.pcibridge_pciehdr_offset =
> >  		    pci_pcie_cap(bridge_pdev);
> > -		pcipriv->ndis_adapter.num4bytes =
> > -		    (pcipriv->ndis_adapter.pcibridge_pciehdr_offset + 0x10) / 4;
> 
> I don't understand what's going on here.  Are we caching the PCIe
> Capability offset of the *upstream bridge* here?  And then computing
> the dword offset of the *bridge's* LNKCTL? And then writing a byte to
> the rtlwifi device (not the bridge) at the dword offset << 2, i.e., the
> byte offset?  I must be out to lunch, because how could that ever
> work?
>
> If we were using the bridge capability location to write to the
> rtlwifi device, that would clearly be a bug fix that would merit its
> own patch.

Oh no, I entirely missed it because of those nice comments which tell it's 
trying to update bridge's ASPM so I didn't pay attention to which device 
it passes for real...

Now I'm left to wonder what would be the best course of action here...
Since it has never really written to bridge's ASPM at all, perhaps that's 
not needed and those writes could just be dropped rather than point them 
to the correct device.

> Maybe this num4bytes thing could be its own patch, too.  Seems so
> cumbersome that it makes me wonder if the device has issues with
> larger accesses.

I thought of that but since it was just 2 extra context blocks which are 
clearly disjoint from the rest, I didn't separate the removal of the 
member variable to its own patch.


-- 
 i.
--8323329-1911404933-1700466388=:2032--
