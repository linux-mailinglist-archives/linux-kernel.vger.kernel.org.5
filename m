Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E517F5801
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344740AbjKWGFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:05:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B5C191;
        Wed, 22 Nov 2023 22:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700719521; x=1732255521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Yr+1TmW4F+rsKSkU4sHlrHj98hszXJZ1OdJBTd24Dpo=;
  b=bQCLBAxYj4bKPVV+yJMUeUi/mfoaAcpDr/QU9XxO/rwxM4f36Wnmaocs
   4qDFvJkOeJJJv/X39NtcS0B+if41CLGObaoRaeY+mTHZiFvVfwCyoWco8
   uvKm6dH/Wiy5lF7fjrs2d3ekOW3v5uUBB3SZkU+xd9mr6csac3TtoOqLU
   zFimnef9vcJBNX57o+z9G0VjSQj/tFmSDQT6pWdBAABKnUIMxnF3nCBpJ
   v/bjL9iH4SMeWokVeyqHzZW5HQgvdSl6yLVslLWxKoYbX85gJlBGpN4Le
   3+paUfmOTUD9DFgJi4cpi9v4y6nbuXYbWRA2vSLNm3FUb3zj7f8CJsfTk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13759430"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="13759430"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 22:05:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="1014517211"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="1014517211"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Nov 2023 22:05:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 23BC82A6; Thu, 23 Nov 2023 08:05:16 +0200 (EET)
Date:   Thu, 23 Nov 2023 08:05:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <sanaths2@amd.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [Patch v2] thunderbolt: Add quirk to reset downstream port
Message-ID: <20231123060516.GB1074920@black.fi.intel.com>
References: <20231122050639.19651-1-Sanath.S@amd.com>
 <20231122060316.GT1074920@black.fi.intel.com>
 <95ceae27-f88d-4915-870a-36cf9418f244@amd.com>
 <efb152bc-fd17-a374-4303-20aa9bde698d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efb152bc-fd17-a374-4303-20aa9bde698d@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:46:27AM +0530, Sanath S wrote:
> 
> On 11/22/2023 9:13 PM, Mario Limonciello wrote:
> > On 11/22/2023 00:03, Mika Westerberg wrote:
> > > Hi,
> > > 
> > > On Wed, Nov 22, 2023 at 10:36:39AM +0530, Sanath S wrote:
> > > > Boot firmware on AMD's Yellow Carp and Pink Sardine allocates
> > > > very minimal buses for PCIe downstream ports. This results in
> > > > failure to extend the daisy chain.
> > > > 
> > > > Add quirk to reset the downstream port to help reset the topology
> > > > created by boot firmware.
> > > 
> > > But this resets the USB4 side of ports, how does this help with the PCIe
> > > side? Or this also resets the PCIe side? Please add this information to
> > > the changelog too.
> > 
> Sure, I'll add the PCIe side reset in changelog.
> > IIUC the PCIe side will be implicitly reset as well.
> > 
> > > 
> > > I suppose it is not possible to fix the boot firmware?
> > 
> > It's a really difficult case to make with firmware team.  Windows and
> > Linux have a different behavior here.  The Windows CM doesn't take the
> > existing tunnels from firmware and instead always resets them.
> > So Windows "isn't affected" by this problem.
> > 
> > Furthermore there are already lots of systems out "in the wild" as these
> > are already both production silicon with shipping OEM products.
> > 
> > > 
> > > > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > > Signed-off-by: Sanath S <Sanath.S@amd.com>
> > > > Fixes: e390909ac763 ("thunderbolt: Add vendor specific NHI quirk
> > > > for auto-clearing interrupt status")
> > > > Cc: <stable@vger.kernel.org>
> > > > ---
> > > > Changes since v1:
> > > >   - Initialize ret variable to avoid compiler warning.
> > > >   - Add Fixes tag with commit id.
> > > > ---
> > > > 
> > > >   drivers/thunderbolt/quirks.c  | 14 ++++++++++++++
> > > >   drivers/thunderbolt/switch.c  | 28 ++++++++++++++++++++++++++++
> > > >   drivers/thunderbolt/tb.h      |  2 ++
> > > >   drivers/thunderbolt/tb_regs.h |  1 +
> > > >   4 files changed, 45 insertions(+)
> > > > 
> > > > diff --git a/drivers/thunderbolt/quirks.c
> > > > b/drivers/thunderbolt/quirks.c
> > > > index e6bfa63b40ae..45e9d6c43e4a 100644
> > > > --- a/drivers/thunderbolt/quirks.c
> > > > +++ b/drivers/thunderbolt/quirks.c
> > > > @@ -27,6 +27,12 @@ static void quirk_clx_disable(struct tb_switch *sw)
> > > >       tb_sw_dbg(sw, "disabling CL states\n");
> > > >   }
> > > >   +static void quirk_amd_downstream_port_reset(struct tb_switch *sw)
> > > > +{
> > > > +    sw->quirks |= QUIRK_DPR;
> > > > +    tb_sw_dbg(sw, "Resetting Down Stream Port\n");
> > > 
> > > That's "resetting downstream ports\n"
> > > 
> Ack, Will take care in v3.
> > > > +}
> > > > +
> > > >   static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
> > > >   {
> > > >       struct tb_port *port;
> > > > @@ -93,6 +99,14 @@ static const struct tb_quirk tb_quirks[] = {
> > > >       { 0x0438, 0x0209, 0x0000, 0x0000, quirk_clx_disable },
> > > >       { 0x0438, 0x020a, 0x0000, 0x0000, quirk_clx_disable },
> > > >       { 0x0438, 0x020b, 0x0000, 0x0000, quirk_clx_disable },
> > > > +    /*
> > > > +     * Reset Down Stream Ports on AMD USB4 Yellow Carp and
> > > > +     * Pink Sardine platforms.
> > > > +     */
> > > > +    { 0x0438, 0x0208, 0x0000, 0x0000,
> > > > quirk_amd_downstream_port_reset },
> > > > +    { 0x0438, 0x0209, 0x0000, 0x0000,
> > > > quirk_amd_downstream_port_reset },
> > > > +    { 0x0438, 0x020a, 0x0000, 0x0000,
> > > > quirk_amd_downstream_port_reset },
> > > > +    { 0x0438, 0x020b, 0x0000, 0x0000,
> > > > quirk_amd_downstream_port_reset },
> > > >   };
> > > >     /**
> > > > diff --git a/drivers/thunderbolt/switch.c
> > > > b/drivers/thunderbolt/switch.c
> > > > index 1e15ffa79295..1c4b1dd5f472 100644
> > > > --- a/drivers/thunderbolt/switch.c
> > > > +++ b/drivers/thunderbolt/switch.c
> > > > @@ -1547,6 +1547,23 @@ static void tb_dump_switch(const struct
> > > > tb *tb, const struct tb_switch *sw)
> > > >              regs->__unknown1, regs->__unknown4);
> > > >   }
> > > >   +static int tb_switch_reset_downstream_port(struct tb_switch *sw)
> > > > +{
> > > > +    struct tb_port *port;
> > > > +    uint32_t val = 0;
> > > 
> > > u32
> > > 
> Ack.
> > > > +    int ret = -1;
> > > 
> > > What is -1? Please use proper error codes.
> > > 
> Ack, It'll be ret = -ENODEV;
> > > > +
> > > > +    tb_switch_for_each_port(sw, port) {
> > > > +        if (port->config.type == TB_TYPE_PORT) {
> > > 
> > > You mean
> > > 
> > >     tb_port_is_null()
> > > 
> > > also please make it a separate function, tb_port_reset() following the
> > > similar tb_port_unlock() and friends. With the matching kernel-doc and
> > > everything.
> > > 
> Sure, I'll handle this and send a v3.
> Will also take case of 10ms delay as per spec.
> > > > +            val = val | PORT_CS_19_DPR;
> > > > +            ret = tb_port_write(port, &val, TB_CFG_PORT,
> > > > +                    port->cap_usb4 + PORT_CS_19, 1);
> > > 
> > > Since it is using cap_usb4 you probably need to make usb4_port_reset()
> > > as well that gets called from tb_port_reset() (try to make it as simple
> > > as possible though).
> > > 
> > > > +            break;
> > > 
> > > It is OK just to reset one port?
> > > 
> As per spec, setting the DPR bit of downstream port would help us
> reconfigure
> 
> the USB4 link, So had a condition check only for downstream port.

It can be used to re-configure the link but also simple reset.

Actually can we instead of the quirk in quirks.c add this to nhi.c and
"host_reset". So that on these AMD controllers trigger host reset in the
same way Windows would?

That's DPR and probably host interface reset. In other words tie this to
the host reset we are doing for USB4 v2 routers (this one adds it for
USB4 v1 routers and enables it by default for AMD).
