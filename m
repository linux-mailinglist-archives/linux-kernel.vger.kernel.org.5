Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2B8128BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbjLNHHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjLNHHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:07:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F726B9;
        Wed, 13 Dec 2023 23:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702537670; x=1734073670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aVTV69PCQTQ31JKv3NEFHclx9YKwGXb979KUPDnem7A=;
  b=FyrYhzoYVAlak9P/SHd5MUELxrxEUz+NizWUWsYbsEUd7tdXpRZkXplB
   Ha1yNPiucaNflTB618FmEfgSeuki+n63YcB0JapxkBk2SSoTePmCdwIMw
   PyB3m+nbzWUaDUVp9g6/+5mRgCh8wZmsgT6TBxJMdcTMFez1Oxz3kbHr4
   mHl95GFfwSn+VeVnQwb+Z8TamBtK5DKLrUZx2FiS0k16Liq+UqWEOvGMS
   PTU3NUGYkWThfEDOBvblb1l1KwbwmrVucSGyRi0haVZ0CKv71eYkIxEfz
   w905+gX/5QBjPV2DwzaDT+UDI/TAIpfWThYFDuhETuDiDxGRdBIOTZSwS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="426211181"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="426211181"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="840169997"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="840169997"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2023 23:07:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id CAECD483; Thu, 14 Dec 2023 09:07:46 +0200 (EET)
Date:   Thu, 14 Dec 2023 09:07:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <sanaths2@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231214070746.GS1074920@black.fi.intel.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
 <20231213054914.GI1074920@black.fi.intel.com>
 <20231213061805.GK1074920@black.fi.intel.com>
 <20231213062306.GL1074920@black.fi.intel.com>
 <adcc6446-8c30-a258-e19b-76fca2c50d21@amd.com>
 <20231213115256.GM1074920@black.fi.intel.com>
 <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:08:34PM +0530, Sanath S wrote:
> 
> On 12/13/2023 5:22 PM, Mika Westerberg wrote:
> > On Wed, Dec 13, 2023 at 04:04:57PM +0530, Sanath S wrote:
> > > On 12/13/2023 11:53 AM, Mika Westerberg wrote:
> > > > On Wed, Dec 13, 2023 at 08:18:06AM +0200, Mika Westerberg wrote:
> > > > > On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
> > > > > > On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
> > > > > > > Boot firmware might have created tunnels of its own. Since we cannot
> > > > > > > be sure they are usable for us. Tear them down and reset the ports
> > > > > > > to handle it as a new hotplug for USB3 routers.
> > > > > > > 
> > > > > > > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > Signed-off-by: Sanath S <Sanath.S@amd.com>
> > > > > > > ---
> > > > > > >    drivers/thunderbolt/tb.c | 11 +++++++++++
> > > > > > >    1 file changed, 11 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > > > > > > index fd49f86e0353..febd0b6972e3 100644
> > > > > > > --- a/drivers/thunderbolt/tb.c
> > > > > > > +++ b/drivers/thunderbolt/tb.c
> > > > > > > @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
> > > > > > >    	tb_switch_tmu_enable(tb->root_switch);
> > > > > > >    	/* Full scan to discover devices added before the driver was loaded. */
> > > > > > >    	tb_scan_switch(tb->root_switch);
> > > > > > > +	/*
> > > > > > > +	 * Boot firmware might have created tunnels of its own. Since we cannot
> > > > > > > +	 * be sure they are usable for us, Tear them down and reset the ports
> > > > > > > +	 * to handle it as new hotplug for USB4 routers.
> > > > > > > +	 */
> > > > > > > +	if (tb_switch_is_usb4(tb->root_switch)) {
> > > > > > > +		tb_switch_discover_tunnels(tb->root_switch,
> > > > > > > +					   &tcm->tunnel_list, false);
> > > > > > Why this is needed?
> > > > > > 
> > > > > > It should be enough, to do simply something like this:
> > > > > > 
> > > > > > 	if (tb_switch_is_usb4(tb->root_switch))
> > > > > > 		tb_switch_reset(tb->root_switch);
> > > If we don't tear down of tunnels before performing the DPR, the PCIe
> > > enumeration is failing.
> > > 
> > > PCIe link is not coming up after DPR. Below log is missing without
> > > performing path
> > > deactivation before performing DPR and hence PCIe enumeration is not
> > > initiated.
> > > 
> > > [  746.630865] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
> > > [  746.630885] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
> > > 
> > > I think when we do a DPR, it internally does some handling with PCI Path
> > > Enable bit(PE).
> > > So, deactivation of PCIe path is necessary for DPR to work.
> > Rigth, it should be enough to reset the protocol adapter config and path
> > config spaces. I guess using discovery at this point is fine too but I
> > would at least check how complex doing the minimal "reset" turns out.
> > 
> > I mean in tb_switch_reset() for USB4 v1 routers it can go over all the
> > adapters and perform "cleanup" or so.
> I gave it a thought yesterday and we can do something like this:
> 
> We are already doing tb_discovery(tb) in tb_start. This would
> discover the path configuration done by Boot firmware.
> 
> Now, we can place the tb_switch_reset() right below that api with
> conditions suggested by you.
> 
> And tb_switch_reset() would internally DPR for all down steam ports.
> 
> It can look something like below:
> 
>     /* Find out tunnels created by the boot firmware */
>         tb_discover_tunnels(tb);
>     /*
>      * Reset USB4 v1 host router to get rid of possible tunnels the
>      * boot firmware created. This makes sure all the tunnels are
>      * created by us and thus have known configuration.
>      *
>      * For USB4 v2 and beyond we do this in nhi_reset() using the
>      * host router reset interface.
>      */
>     if (host_reset && usb4_switch_version(tb->root_switch) == 1)
>         tb_switch_reset(tb->root_switch);
> 
> With this, we are making sure while we get a unplug event after doing a DPR,
> We are clearing all the paths established by Boot firmware. This wouldn't be
> possible
> if we had not discovered the paths before we perform DPR.
> 
> It would create inconsistency for a new hot plug if we have not cleared the
> path configurations
> of previous hot unplug events.

Right. I would still check if doing protocol adapter "reset" + path
config space clear in tb_switch_reset() is enough and how complex that
ends up to be. I think that's all what is needed.

If it turns out too complex, yes I guess something like this:

	/* Find out tunnels created by the boot firmware */
	tb_discover_tunnels(tb);
	/* Add DP resources from the DP tunnels created by the boot firmware */
	tb_discover_dp_resources(tb);

	if (host_reset && usb4_switch_version(tb->root_switch) == 1) {
		struct tb_tunnel *n, *tunnel;

		list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
			tb_deactivate_and_free_tunnel(tunnel);

		tb_switch_reset(tb->root_switch);
	}

With proper comments would work, no?

Regarding "host_reset", I think we can actually keep it in nhi.c and add
a parameter to cm_ops->start(reset) that gets passed to the "CM
implementation". Or something along those lines.

> > > > > Actually this needs to be done only for USB4 v1 routers since we already
> > > > > reset USB4 v2 hosts so something like:
> > > > > 
> > > > > 	/*
> > > > > 	 * Reset USB4 v1 host router to get rid of possible tunnels the
> > > > > 	 * boot firmware created. This makes sure all the tunnels are
> > > > > 	 * created by us and thus have known configuration.
> > > > > 	 *
> > > > > 	 * For USB4 v2 and beyond we do this in nhi_reset() using the
> > > > > 	 * host router reset interface.
> > > > > 	 */
> > > > > 	if (usb4_switch_version(tb->root_switch) == 1)
> > > > > 		tb_switch_reset(tb->root_switch);
> > > > > 
> > > > > (possibly add similar comment to the nhi_reset() to refer this one).
> > > > Oh, and would it be possible to tie this with the "host_reset" parameter
> > > > too somehow? I guess it could be moved to "tb.c" and "tb.h" and then
> > > > check it from nhi.c as already done and then here so this would become:
> > > > 
> > > >    	if (host_reset && usb4_switch_version(tb->root_switch) == 1)
> > > >    		tb_switch_reset(tb->root_switch);
> > > Is host_reset necessary for USB4 v1 routers ? I did not use host_reset in
> > > this case.
> > > If its needed, then we have to modify to enable host_reset in nhi.c as well.
> > Well you are effectively doing that here, no? You "reset" the host
> > router therefore tying this to the same command line parameter makes
> > sense and allows user an "escape hatch" if this turns out breaking
> > things.
