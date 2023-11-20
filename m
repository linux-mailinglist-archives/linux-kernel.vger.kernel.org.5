Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F737F0E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbjKTIyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjKTIyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:54:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137D5A2;
        Mon, 20 Nov 2023 00:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700470490; x=1732006490;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ipydi896Ytg31JN042L+cdhnF+9wtrOPAOlfCQDDJZQ=;
  b=Fdy0YF2hzBtlRX9XfRD1Ii9QjOrzFs9XzMq9GkiMEqvGFGEJuf901yns
   j52UHAVLP9WS8pnt47/1gusAPZc5xDJhCxZrvnZfGTgWgmDMv8+hSdYox
   v6KrJSxr1GW9dfMZo1mv/OpmMcFLzGIxGRpamOlhJ5Cquvwi1DXeZbQJ1
   AMeDg142DJga1ARcUdDeQOgD9eFOtjC/bbR7AW27fG7LNT5atWFzkdCzA
   k6ZV0Cy7haMGPn9qbnZxM31Kau/ojFW7t0OBiby0MMbNWq2xWxaCaS9Xr
   Tkj5Lm1zd4x/zK38m3YaykwzApEztwiII8cuESQLgNgk4uaSay+sxMUTj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="370922681"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="370922681"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="832207807"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="832207807"
Received: from akeren-mobl.ger.corp.intel.com ([10.252.40.26])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 00:54:47 -0800
Date:   Mon, 20 Nov 2023 10:54:45 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
cc:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] wifi: rtlwifi: Convert to use PCIe capability
 accessors
In-Reply-To: <20231117223738.GA95634@bhelgaas>
Message-ID: <a687cad5-6cc9-3db0-c8fa-a959dd70347a@linux.intel.com>
References: <20231117223738.GA95634@bhelgaas>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1144834576-1700468383=:2032"
Content-ID: <d06ccde1-05f-8d38-ad14-776bccf11e2b@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1144834576-1700468383=:2032
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <f39c6061-e3d2-7ff2-3e46-5a877df64a4e@linux.intel.com>

On Fri, 17 Nov 2023, Bjorn Helgaas wrote:

> On Fri, Nov 17, 2023 at 11:44:20AM +0200, Ilpo Järvinen wrote:
> > The rtlwifi driver accesses PCIe capabilities through custom config
> > offsets.
> > 
> > Convert the accesses to use the normal PCIe capability accessors.
> > pcibridge_pciehdr_offset in the struct mp_adapter becomes unused after
> > the conversion and can be removed.
> 
> More good stuff.  I guess patch [1/7] was specifically for the RMW
> things, and this one is for the rest?

Yes, I wanted to separate them because of the Fixes tag.

> > @@ -219,7 +220,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
> >  	}
> >  
> >  	/*for promising device will in L0 state after an I/O. */
> > -	pci_read_config_byte(rtlpci->pdev, 0x80, &tmp_u1b);
> > +	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &tmp_u1b);
> >  
> >  	/*Set corresponding value. */
> >  	aspmlevel |= BIT(0) | BIT(1);
> 
> I guess this is PCI_EXP_LNKCTL_ASPM_L0S | PCI_EXP_LNKCTL_ASPM_L1?

I'll change it too. There was just so much to cleanup I started to miss 
things even this obvious :-(.

Also, I was not at all sure if that read from LNKCTL is really trying to 
achieve. The comment sounds like it's trying to ensure the dev is in L0
but why it cares? These drivers do so odd things :-).

> There's also a similar u_pcibridge_aspmsetting mask in
> rtl_pci_enable_aspm().

Yes, but I'll put that into 1/7 since it's related to the change made 
there.

> And some scary looking stuff in rtl_pci_get_amd_l1_patch().
> And platform_enable_dma64().  No clue what either of those does.

Those elude me as well.


-- 
 i.
--8323329-1144834576-1700468383=:2032--
