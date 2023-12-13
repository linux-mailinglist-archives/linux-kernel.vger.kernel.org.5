Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23152810A27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378560AbjLMGSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjLMGSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:18:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950EAD;
        Tue, 12 Dec 2023 22:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702448290; x=1733984290;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+wG0n5eRdc2tViq1iHhn5Dd5cJsoQhhtB8vAzTofY04=;
  b=kkRIXM6TwrqqhvPK2E7hZ9ulpvLHt/yI7CexHybxIRk6lLIJR28IGs1+
   xUgapZjfCjIrO4JIydAA7UiefP54TX5p/Ns3n6fU3ea2md1PD1f3f1QDa
   vihTXFRVMvsuPXWE1ShNP/k7e0BA/hBctGhgtoSZ2r9Hn7fvyOzAHqn25
   lPrAJsJxbn1YHkhz+EUMBIM0JpITW6XM66JIrdLnVVFKnr+ZebTxxLzp8
   2UzWHSCrmkmeh4PzmQd6elzQEhHHo5F/2RzP+NTh281sId2UZxrOg5OTy
   NsW84AjGUXVx9GgcMqJJcDFxgJyHZ7z7X2AotXLPD7zn/bIYcxebJ9um3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1761898"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1761898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 22:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864500802"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="864500802"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 22:18:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 21D7B1A7; Wed, 13 Dec 2023 08:18:05 +0200 (EET)
Date:   Wed, 13 Dec 2023 08:18:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <Sanath.S@amd.com>
Cc:     mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231213061805.GK1074920@black.fi.intel.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
 <20231213054914.GI1074920@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231213054914.GI1074920@black.fi.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
> On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
> > Boot firmware might have created tunnels of its own. Since we cannot
> > be sure they are usable for us. Tear them down and reset the ports
> > to handle it as a new hotplug for USB3 routers.
> > 
> > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Sanath S <Sanath.S@amd.com>
> > ---
> >  drivers/thunderbolt/tb.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > index fd49f86e0353..febd0b6972e3 100644
> > --- a/drivers/thunderbolt/tb.c
> > +++ b/drivers/thunderbolt/tb.c
> > @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
> >  	tb_switch_tmu_enable(tb->root_switch);
> >  	/* Full scan to discover devices added before the driver was loaded. */
> >  	tb_scan_switch(tb->root_switch);
> > +	/*
> > +	 * Boot firmware might have created tunnels of its own. Since we cannot
> > +	 * be sure they are usable for us, Tear them down and reset the ports
> > +	 * to handle it as new hotplug for USB4 routers.
> > +	 */
> > +	if (tb_switch_is_usb4(tb->root_switch)) {
> > +		tb_switch_discover_tunnels(tb->root_switch,
> > +					   &tcm->tunnel_list, false);
> 
> Why this is needed?
> 
> It should be enough, to do simply something like this:
> 
> 	if (tb_switch_is_usb4(tb->root_switch))
> 		tb_switch_reset(tb->root_switch);

Actually this needs to be done only for USB4 v1 routers since we already
reset USB4 v2 hosts so something like:

	/*
	 * Reset USB4 v1 host router to get rid of possible tunnels the
	 * boot firmware created. This makes sure all the tunnels are
	 * created by us and thus have known configuration.
	 *
	 * For USB4 v2 and beyond we do this in nhi_reset() using the
	 * host router reset interface.
	 */
	if (usb4_switch_version(tb->root_switch) == 1)
		tb_switch_reset(tb->root_switch);

(possibly add similar comment to the nhi_reset() to refer this one).
