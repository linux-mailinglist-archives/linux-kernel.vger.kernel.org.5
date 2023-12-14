Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837A6812967
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443341AbjLNHdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjLNHdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:33:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF3F12B;
        Wed, 13 Dec 2023 23:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702539171; x=1734075171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yRBCGMjJPeNLdde6gmkCVoQ50q7qAYUMozdOeoIWt4c=;
  b=E7EgaJkR3Zuaw1U8Cy1Em7AUYaEgWRj6QOKc/eY3j23HaSlpaOzEoWTn
   lIQnW98G7nuQb6lNmmB11vmrRDGS6wgcnYeQ9nyCN3lVQT8MUteBmz8gu
   q52Ia/VW4MrjbzeRz+4hk2a7uBPq+Af1edXHpvU3mMrq9Yv5ik2EukpnN
   4cf3N3vwkm0SA4Kw76eOCIGYFxf45c40Cumoav5IIZY71yy1UNpT60EyO
   eO2HhOsEYQeFA6AmIZsPrQnWEnJJbk+gP31gpi70/Afe4uY8GwleGybjj
   4dxow4bUerOWhoiIA9h9d7Gdsz9uQ1ZmRcYgWBO32muZ+ouRRszME/nid
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="393953226"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="393953226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 23:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723970969"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723970969"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 23:32:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 133853AE; Thu, 14 Dec 2023 09:32:42 +0200 (EET)
Date:   Thu, 14 Dec 2023 09:32:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <sanaths2@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20231214073242.GT1074920@black.fi.intel.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-3-Sanath.S@amd.com>
 <20231213054914.GI1074920@black.fi.intel.com>
 <20231213061805.GK1074920@black.fi.intel.com>
 <20231213062306.GL1074920@black.fi.intel.com>
 <adcc6446-8c30-a258-e19b-76fca2c50d21@amd.com>
 <20231213115256.GM1074920@black.fi.intel.com>
 <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
 <20231214070746.GS1074920@black.fi.intel.com>
 <32163f49-8387-0754-534f-1764e731f26d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32163f49-8387-0754-534f-1764e731f26d@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 12:50:21PM +0530, Sanath S wrote:
> 
> On 12/14/2023 12:37 PM, Mika Westerberg wrote:
> > On Thu, Dec 14, 2023 at 12:08:34PM +0530, Sanath S wrote:
> > > On 12/13/2023 5:22 PM, Mika Westerberg wrote:
> > > > On Wed, Dec 13, 2023 at 04:04:57PM +0530, Sanath S wrote:
> > > > > On 12/13/2023 11:53 AM, Mika Westerberg wrote:
> > > > > > On Wed, Dec 13, 2023 at 08:18:06AM +0200, Mika Westerberg wrote:
> > > > > > > On Wed, Dec 13, 2023 at 07:49:14AM +0200, Mika Westerberg wrote:
> > > > > > > > On Wed, Dec 13, 2023 at 12:46:35AM +0530, Sanath S wrote:
> > > > > > > > > Boot firmware might have created tunnels of its own. Since we cannot
> > > > > > > > > be sure they are usable for us. Tear them down and reset the ports
> > > > > > > > > to handle it as a new hotplug for USB3 routers.
> > > > > > > > > 
> > > > > > > > > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > > > > > > Signed-off-by: Sanath S <Sanath.S@amd.com>
> > > > > > > > > ---
> > > > > > > > >     drivers/thunderbolt/tb.c | 11 +++++++++++
> > > > > > > > >     1 file changed, 11 insertions(+)
> > > > > > > > > 
> > > > > > > > > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > > > > > > > > index fd49f86e0353..febd0b6972e3 100644
> > > > > > > > > --- a/drivers/thunderbolt/tb.c
> > > > > > > > > +++ b/drivers/thunderbolt/tb.c
> > > > > > > > > @@ -2598,6 +2598,17 @@ static int tb_start(struct tb *tb)
> > > > > > > > >     	tb_switch_tmu_enable(tb->root_switch);
> > > > > > > > >     	/* Full scan to discover devices added before the driver was loaded. */
> > > > > > > > >     	tb_scan_switch(tb->root_switch);
> > > > > > > > > +	/*
> > > > > > > > > +	 * Boot firmware might have created tunnels of its own. Since we cannot
> > > > > > > > > +	 * be sure they are usable for us, Tear them down and reset the ports
> > > > > > > > > +	 * to handle it as new hotplug for USB4 routers.
> > > > > > > > > +	 */
> > > > > > > > > +	if (tb_switch_is_usb4(tb->root_switch)) {
> > > > > > > > > +		tb_switch_discover_tunnels(tb->root_switch,
> > > > > > > > > +					   &tcm->tunnel_list, false);
> > > > > > > > Why this is needed?
> > > > > > > > 
> > > > > > > > It should be enough, to do simply something like this:
> > > > > > > > 
> > > > > > > > 	if (tb_switch_is_usb4(tb->root_switch))
> > > > > > > > 		tb_switch_reset(tb->root_switch);
> > > > > If we don't tear down of tunnels before performing the DPR, the PCIe
> > > > > enumeration is failing.
> > > > > 
> > > > > PCIe link is not coming up after DPR. Below log is missing without
> > > > > performing path
> > > > > deactivation before performing DPR and hence PCIe enumeration is not
> > > > > initiated.
> > > > > 
> > > > > [  746.630865] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
> > > > > [  746.630885] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
> > > > > 
> > > > > I think when we do a DPR, it internally does some handling with PCI Path
> > > > > Enable bit(PE).
> > > > > So, deactivation of PCIe path is necessary for DPR to work.
> > > > Rigth, it should be enough to reset the protocol adapter config and path
> > > > config spaces. I guess using discovery at this point is fine too but I
> > > > would at least check how complex doing the minimal "reset" turns out.
> > > > 
> > > > I mean in tb_switch_reset() for USB4 v1 routers it can go over all the
> > > > adapters and perform "cleanup" or so.
> > > I gave it a thought yesterday and we can do something like this:
> > > 
> > > We are already doing tb_discovery(tb) in tb_start. This would
> > > discover the path configuration done by Boot firmware.
> > > 
> > > Now, we can place the tb_switch_reset() right below that api with
> > > conditions suggested by you.
> > > 
> > > And tb_switch_reset() would internally DPR for all down steam ports.
> > > 
> > > It can look something like below:
> > > 
> > >      /* Find out tunnels created by the boot firmware */
> > >          tb_discover_tunnels(tb);
> > >      /*
> > >       * Reset USB4 v1 host router to get rid of possible tunnels the
> > >       * boot firmware created. This makes sure all the tunnels are
> > >       * created by us and thus have known configuration.
> > >       *
> > >       * For USB4 v2 and beyond we do this in nhi_reset() using the
> > >       * host router reset interface.
> > >       */
> > >      if (host_reset && usb4_switch_version(tb->root_switch) == 1)
> > >          tb_switch_reset(tb->root_switch);
> > > 
> > > With this, we are making sure while we get a unplug event after doing a DPR,
> > > We are clearing all the paths established by Boot firmware. This wouldn't be
> > > possible
> > > if we had not discovered the paths before we perform DPR.
> > > 
> > > It would create inconsistency for a new hot plug if we have not cleared the
> > > path configurations
> > > of previous hot unplug events.
> > Right. I would still check if doing protocol adapter "reset" + path
> > config space clear in tb_switch_reset() is enough and how complex that
> > ends up to be. I think that's all what is needed.
> > 
> > If it turns out too complex, yes I guess something like this:
> > 
> > 	/* Find out tunnels created by the boot firmware */
> > 	tb_discover_tunnels(tb);
> > 	/* Add DP resources from the DP tunnels created by the boot firmware */
> > 	tb_discover_dp_resources(tb);
> > 
> > 	if (host_reset && usb4_switch_version(tb->root_switch) == 1) {
> > 		struct tb_tunnel *n, *tunnel;
> > 
> > 		list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list)
> > 			tb_deactivate_and_free_tunnel(tunnel);
> > 
> > 		tb_switch_reset(tb->root_switch);
> > 	}
> > 
> > With proper comments would work, no?
> Yes, this works. Tested it too and works fine.

Cool.

> Probably we can move tb_deactivate_and_free_tunnel() inside
> tb_switch_reset() to make it
> look better.

Unfortunately that's not possible because tb_switch_reset() lives in
switch.s (and should live there) and tb_deactivate_and_free_tunnel() is
part of tb.c (as should be). This is actually why I would like to try
the "reset" protocol adapters + their path config spaces in
tb_switch_reset() as then that would work with any router and does not
need to have any knowledge about tunnels or tb.c internals.
