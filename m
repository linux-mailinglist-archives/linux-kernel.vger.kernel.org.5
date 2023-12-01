Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8E800B38
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378905AbjLAMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 07:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378879AbjLAMln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:41:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF91A4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 04:41:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D35AC433CA;
        Fri,  1 Dec 2023 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701434509;
        bh=imMZhfTtyyGFtFcaYBtnqz4qJYY6QUgBBX1z+Bcmn78=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OaGNG6KoKebXZRxH+/ZzHRN3G7Und64V4LWYAEwksUBOhkovG8ua4z9z9GooqAs+j
         N6CNHSflRxHdz+mHZyXsvpWHy+jEZ5ixIUvVTBMqrv3cU7kLpB+U0lxeuyRobCikPX
         VTHvEu2CxYIVQvKMwUB6il4hiMgmU6+67vGr/JRw0XwEAuhHu9r7SSTjn/7jFJ+zcg
         sN1ab4TSp6b+GsWDPWyfdtFmqGgS9yXEmuBSkEa1Y6fjHeBtF0tT1bHuMci799Ncio
         USHE0ASdS78KNCU7GXR27jHCIFRW0+fvy501KVas50Yg1Hx+DoZ+kkkuKnkdHMe+Lo
         9L8mJICKTParQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 01/10] wifi: rtlwifi: Remove bogus and dangerous ASPM
 disable/enable code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231124084725.12738-2-ilpo.jarvinen@linux.intel.com>
References: <20231124084725.12738-2-ilpo.jarvinen@linux.intel.com>
To:     =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "John W. Linville" <linville@tuxdriver.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@kernel.org>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170143450482.2072551.1616110971687036096.kvalo@kernel.org>
Date:   Fri,  1 Dec 2023 12:41:46 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Ever since introduction in the commit 0c8173385e54 ("rtl8192ce: Add new
> driver") the rtlwifi code has, according to comments, attempted to
> disable/enable ASPM of the upstream bridge by writing into its LNKCTL
> register. However, the code has never been correct because it performs
> the writes to the device instead of the upstream bridge.
> 
> Worse yet, the offset where the PCIe capabilities reside is derived
> from the offset of the upstream bridge. As a result, the write will use
> an offset on the device that does not relate to the LNKCTL register
> making the ASPM disable/enable code outright dangerous.
> 
> Because of those problems, there is no indication that the driver needs
> disable/enable ASPM on the upstream bridge. As the Capabilities offset
> is not correctly calculated for the write to target device's LNKCTL
> register, the code is not disabling/enabling device's ASPM either.
> Therefore, just remove the upstream bridge related ASPM disable/enable
> code entirely.
> 
> The upstream bridge related ASPM code was the only user of the struct
> mp_adapter members num4bytes, pcibridge_pciehdr_offset, and
> pcibridge_linkctrlreg so those are removed as well.
> 
> Note: This change does not remove the code related to changing the
> device's ASPM on purpose (which is independent of this flawed code
> related to upstream bridge's ASPM).
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@kernel.org>
> Fixes: 0c8173385e54 ("rtl8192ce: Add new driver")
> Fixes: 886e14b65a8f ("rtlwifi: Eliminate raw reads and writes from PCIe portion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

10 patches applied to wireless-next.git, thanks.

b3943b3c2971 wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
5894d0089cbc wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
a4fcac11a25a wifi: rtlwifi: Convert to use PCIe capability accessors
6e071ae899f1 wifi: rtlwifi: rtl8821ae: Remove unnecessary PME_Status bit set
760bfed91201 wifi: rtlwifi: rtl8821ae: Reverse PM Capability exists check
9dcc75e0b7d0 wifi: rtlwifi: rtl8821ae: Use pci_find_capability()
7bd350d2ac91 wifi: rtlwifi: rtl8821ae: Add pdev into _rtl8821ae_clear_pci_pme_status()
05b311a3f915 wifi: rtlwifi: rtl8821ae: Access full PMCS reg and use pci_regs.h
217fbc032eaa wifi: rtlwifi: Remove unused PCI related defines and struct
874a0eda000d wifi: rtlwifi: Remove bridge vendor/device ids

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231124084725.12738-2-ilpo.jarvinen@linux.intel.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

