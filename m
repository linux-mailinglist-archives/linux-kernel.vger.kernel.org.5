Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1C800422
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377637AbjLAGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjLAGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:49:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123011728;
        Thu, 30 Nov 2023 22:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701413358; x=1732949358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zgA9er2TieuKbZ/sO/TlArv1h+YGFZzAROMCbrfkuck=;
  b=oG4y/BOLVU5wnhhvV8vDksxpoKCcBpjUr/ufmHI06sf39Zhtq3DYi0FZ
   LghLrUhY0sZ8bmDIWMgwtix4A55V/xSBXUKHfeuhItlkPzm+IURM4v88J
   eY0SMUCec+RWLsOm76ltGSzT06oCdgEn4OO/PUcJmb0bfmDEmgdpQ32B5
   WooP0qJt1Ud06f9fHmIZ3nVvc28JB2sLSoKw/pT6MQYmi05mI8cDOsGX3
   RCRJJTT2ZvIHgX/cwBlv4I/SJ3AaVGtZfOS8K9yI2teqSllkBaWW6lwoI
   ojc5EOGSjH1aUmstjqVFjPZVR7ADYhKiBvvlhjzbQrpDQljhWfmWxdp6I
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="372835334"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="372835334"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 22:49:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="835678296"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="835678296"
Received: from ppgyli0104.png.intel.com ([10.126.160.64])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2023 22:49:12 -0800
From:   Rohan G Thomas <rohan.g.thomas@intel.com>
To:     fancer.lancer@gmail.com
Cc:     alexandre.torgue@foss.st.com, andriy.shevchenko@linux.intel.com,
        davem@davemloft.net, edumazet@google.com, joabreu@synopsys.com,
        kuba@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        pabeni@redhat.com, rohan.g.thomas@intel.com
Subject: Re: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts handling
Date:   Fri,  1 Dec 2023 14:49:09 +0800
Message-Id: <20231201064909.28399-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
References: <cjgx6e3agc6gpvs75nhkf6wlztk73epmct6tcuooyqvk2nx2o2@vr5buyk637t3>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Oct 2023 13:08:33 +0300 Serge Semin wrote:
> Hi Rohan, Jakub
> ...
> Interesting thing. My DW QoS Eth _v5.10a_ HW manual explicitly states that
> it's multiplied by _6_ in nanoseconds (just rechecked). So either there is a
> difference between the minor DW QoS Eth IP-core releases or the older HW-
> manuals have had a typo in the MTL_EST_CONTROL.PTOV field description.
> Synopsys normally describes such changes (whether it was a mistake or a
> functional change) in the IP-core release notes. The release notes document
> is supplied as a separate pdf file. Alas I don't have one.( Even if I had it it
> would have been useless since the change was introduced in the newer QoS
> IP-cores. Rohan, do you happen to have the release notes for DW QoS Eth IP-
> core v5.30 at hands?
> Something like DWC_ether_qos_rc_relnotes.pdf?

Hi Serge,

Sorry for the delay. Sends out another version with the suggested changes.

Managed to get DWC_ether_qos_relnotes.pdf for v5.20a and v5.30a. But I couldn't
find anything related to this. So for refactoring, I'm keeping the logic as in
the upstream code to avoid any regression.

> 
> Also please double check that your DW QoS Eth v5.30a for sure states that
> MTL_EST_CONTROL.PTOV contains value multiplied by _6_. So we wouldn't
> be wasting time trying to workaround a more complex problem than we
> already have.

Yes, I checked this again. For DW QoS Eth v5.30a the multiplier for 
MTL_EST_CONTROL.PTOV is _9_ as per the databook.

Also noticed a similar difference for MTL_EST_Status.BTRL field length. As per
the upstream code and DW QoS Eth v5.10a databook this field covers bit 8 to bit
11. But for the xgmac IP and DW QoS Eth v5.30a databook this field covers bit 8
to bit 15. Again nothing mentioned in the release notes. Here also I'm keeping
the logic as in the upstream code to avoid any regression.

> 
> -Serge(y)
> 

Best Regards,
Rohan
