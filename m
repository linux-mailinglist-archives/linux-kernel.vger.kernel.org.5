Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF037EFB85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346213AbjKQWho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQWhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:37:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51323D4D;
        Fri, 17 Nov 2023 14:37:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A999CC433C8;
        Fri, 17 Nov 2023 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700260660;
        bh=Ndj0p7n2VYiLvuAu7Gg193qmpVDyBOQt2CzlcP0rtVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NrTIERkPhX0tiu56TFlHegIui6QO8D4nVLD8eVCTzR0MVDYhzzrDODdpJ3eJICSmb
         PplbPAVjNXocnpXVA/na2nQNXeY9IM/K6+TUZfAYbxZChvPUoknh/aHzLSt60jbete
         vdt21tLwVbW/Vsyogn5BL9ULyKr2EtcTWCwGHkWD4UsKeDg+lG3W4ZZ8uRO1YImweY
         JGFgFpu7LCZh2R9ptlulR+D4Ya1gGWdt0Kulk4ldSUHLBfGQzGo9kcOuN4S0M1UIjw
         7MK/eOEZeyh0FmbkN7Gu6OUPNtEMIuzMzK9MB4tz6/+Ux6ODW8Ne7f4ovR9TfX1Ve6
         VAOozy3B2mpHg==
Date:   Fri, 17 Nov 2023 16:37:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] wifi: rtlwifi: Convert to use PCIe capability
 accessors
Message-ID: <20231117223738.GA95634@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117094425.80477-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:44:20AM +0200, Ilpo Järvinen wrote:
> The rtlwifi driver accesses PCIe capabilities through custom config
> offsets.
> 
> Convert the accesses to use the normal PCIe capability accessors.
> pcibridge_pciehdr_offset in the struct mp_adapter becomes unused after
> the conversion and can be removed.

More good stuff.  I guess patch [1/7] was specifically for the RMW
things, and this one is for the rest?

> @@ -219,7 +220,7 @@ static void rtl_pci_disable_aspm(struct ieee80211_hw *hw)
>  	}
>  
>  	/*for promising device will in L0 state after an I/O. */
> -	pci_read_config_byte(rtlpci->pdev, 0x80, &tmp_u1b);
> +	pcie_capability_read_word(rtlpci->pdev, PCI_EXP_LNKCTL, &tmp_u1b);
>  
>  	/*Set corresponding value. */
>  	aspmlevel |= BIT(0) | BIT(1);

I guess this is PCI_EXP_LNKCTL_ASPM_L0S | PCI_EXP_LNKCTL_ASPM_L1?

There's also a similar u_pcibridge_aspmsetting mask in
rtl_pci_enable_aspm().

And some scary looking stuff in rtl_pci_get_amd_l1_patch().  And
platform_enable_dma64().  No clue what either of those does.
