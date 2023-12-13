Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66888110B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378788AbjLMMEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjLMMEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:04:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AED1B0;
        Wed, 13 Dec 2023 04:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702469059; x=1734005059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8rwMF8DriN+ivdWOKOxVSCXDTJzbpUpVsoZbypM+S8=;
  b=WgTXZqGfbsgzN8KQyEeo3uefFwGTbGu9fjt2jgnzBgoCRqSYwH9/23Du
   xAL7zJpoSQy8hH44ZK95QNe06BymarU5rZD7NWU7PwKjMPKy08tuyoHt2
   McY9ocPKOT0zfs32c5G+zCvaJewXsAlRs/Q3mn1pJrA4LWH00mhrqVDYk
   J4U+zDJOMzmHc3oCihjjzmTiUTKVh/y49FPCoed4iuvahPTiBqjA1eZXW
   vEE7NNe13MSG6+9nWUDckqJDE7BI0pMJMeo2PbE97/8Grg/yHvhtCn/b7
   MxZcp/5ZAMwfYUcrxMUQs7IAIBYgCv06a5ZbKP/BmlCKFdksiPt+6JvFt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2125620"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="2125620"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 04:04:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1021096026"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="1021096026"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2023 04:04:16 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8AFFF591; Wed, 13 Dec 2023 14:04:15 +0200 (EET)
Date:   Wed, 13 Dec 2023 14:04:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <sanaths2@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 1/2] thunderbolt: Introduce tb_switch_reset_ports(),
 tb_port_reset() and usb4_port_reset()
Message-ID: <20231213120415.GO1074920@black.fi.intel.com>
References: <20231212191635.2022520-1-Sanath.S@amd.com>
 <20231212191635.2022520-2-Sanath.S@amd.com>
 <20231213055941.GJ1074920@black.fi.intel.com>
 <e1b45051-54c8-1d26-9366-dba2c2d621a8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1b45051-54c8-1d26-9366-dba2c2d621a8@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 05:28:12PM +0530, Sanath S wrote:
> 
> On 12/13/2023 11:29 AM, Mika Westerberg wrote:
> > On Wed, Dec 13, 2023 at 12:46:34AM +0530, Sanath S wrote:
> > > Introduce the tb_switch_reset_ports() function that resets the
> > > downstream ports of a given switch. This helps us reset the USB4
> > > links created by boot firmware during the init sequence.
> > > 
> > > Introduce the tb_port_reset() helper function that resets the
> > > given port.
> > > 
> > > Introduce the usb4_port_reset() function that performs the DPR
> > > of a given port. This function follows the CM guide specification 7.3
> > > 
> > > Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> > > Signed-off-by: Sanath S <Sanath.S@amd.com>
> > > ---
> > >   drivers/thunderbolt/switch.c  | 35 +++++++++++++++++++++++++++++++
> > >   drivers/thunderbolt/tb.h      |  2 ++
> > >   drivers/thunderbolt/tb_regs.h |  1 +
> > >   drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
> > >   4 files changed, 77 insertions(+)
> > > 
> > > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > > index 44e9b09de47a..ef7ed92fd48e 100644
> > > --- a/drivers/thunderbolt/switch.c
> > > +++ b/drivers/thunderbolt/switch.c
> > > @@ -626,6 +626,19 @@ int tb_port_unlock(struct tb_port *port)
> > >   	return 0;
> > >   }
> > > +/**
> > > + * tb_port_reset() - Reset downstream port
> > > + * @port: Port to reset
> > > + *
> > > + * Helps to reconfigure the USB4 link by resetting the downstream port.
> > > + *
> > > + * Return: Returns 0 on success or an error code on failure.
> > > + */
> > > +static int tb_port_reset(struct tb_port *port)
> > > +{
> > > +	return usb4_port_reset(port);
> > > +}
> > > +
> > >   static int __tb_port_enable(struct tb_port *port, bool enable)
> > >   {
> > >   	int ret;
> > > @@ -1547,6 +1560,28 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
> > >   	       regs->__unknown1, regs->__unknown4);
> > >   }
> > > +/**
> > > + * tb_switch_reset_ports() - Reset downstream ports of switch.
> > Drop the '.'
> Ack.
> > > + * @sw: Switch whose ports need to be reset.
> > > + *
> > > + * This is applicable only for USB4 routers.
> > > + * tb_switch_is_usb4() needs to be called before calling this
> > > + * function.
> > This should fit into 2 lines:
> > 
> > 	* This is applicable only for USB4 routers. tb_switch_is_usb4()
> > 	* needs to be called before calling this function.
> Ack.
> > > + *
> > > + * Return: Returns 0 on success or an error code on failure.
> > Specifically returns %-EOPNOTSUPP if the router does not support this
> > (e.g is not USB4 router).
> > 
> > > + */
> > > +int tb_switch_reset_ports(struct tb_switch *sw)
> > > +{
> > > +	struct tb_port *port;
> > > +	int ret = -EOPNOTSUPP;
> > Reverse christmas tree:
> > 
> > 	int ret = -EOPNOTSUPP;
> > 	struct tb_port *port;
> Ack.
> > > +
> > > +	tb_switch_for_each_port(sw, port) {
> > > +		if (tb_port_is_null(port) && port->cap_usb4)
> > > +			return tb_port_reset(port);
> > Now you run this only once for the first lane adapter it finds.
> > 
> > How much you actually tested this patch series? :(
> 
> I've tested this patch on multiple TBT4 docks like OWC, Kenningston and
> Lenovo on
> reboot/suspend-resume/hotplug scenarios.

Did you test so that you had the thing plugged to a second USB4 port of
the host router? I don't think so because the above is only run for the
first port and then it immediately returns so all the other USB4 ports
will not be reset.

> > Since we are already in -rc5 it is unlikely that behavioral changes like
> > this will go to the next release (v6.8-rc1), so you have all that time
> > to make sure your patches work as expected.
> Agreed. Since this is a behavioral change it needs more testing and
> refinement on how
> we can reset the switch and its ports.
> > > +	}
> > > +	return ret;
> > > +}
> > > +
> > >   /**
> > >    * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
> > >    * @sw: Switch to reset
> > > diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> > > index e299e53473ae..f2687ec4ac53 100644
> > > --- a/drivers/thunderbolt/tb.h
> > > +++ b/drivers/thunderbolt/tb.h
> > > @@ -797,6 +797,7 @@ void tb_switch_remove(struct tb_switch *sw);
> > >   void tb_switch_suspend(struct tb_switch *sw, bool runtime);
> > >   int tb_switch_resume(struct tb_switch *sw);
> > >   int tb_switch_reset(struct tb_switch *sw);
> > > +int tb_switch_reset_ports(struct tb_switch *sw);
> > >   int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
> > >   			   u32 value, int timeout_msec);
> > >   void tb_sw_set_unplugged(struct tb_switch *sw);
> > > @@ -1281,6 +1282,7 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
> > >   int usb4_switch_add_ports(struct tb_switch *sw);
> > >   void usb4_switch_remove_ports(struct tb_switch *sw);
> > > +int usb4_port_reset(struct tb_port *port);
> > >   int usb4_port_unlock(struct tb_port *port);
> > >   int usb4_port_hotplug_enable(struct tb_port *port);
> > >   int usb4_port_configure(struct tb_port *port);
> > > diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> > > index 87e4795275fe..d49530bc0d53 100644
> > > --- a/drivers/thunderbolt/tb_regs.h
> > > +++ b/drivers/thunderbolt/tb_regs.h
> > > @@ -389,6 +389,7 @@ struct tb_regs_port_header {
> > >   #define PORT_CS_18_CSA				BIT(22)
> > >   #define PORT_CS_18_TIP				BIT(24)
> > >   #define PORT_CS_19				0x13
> > > +#define PORT_CS_19_DPR				BIT(0)
> > >   #define PORT_CS_19_PC				BIT(3)
> > >   #define PORT_CS_19_PID				BIT(4)
> > >   #define PORT_CS_19_WOC				BIT(16)
> > > diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> > > index 4277733d0021..c8a4bf33ed1c 100644
> > > --- a/drivers/thunderbolt/usb4.c
> > > +++ b/drivers/thunderbolt/usb4.c
> > > @@ -1073,6 +1073,45 @@ void usb4_switch_remove_ports(struct tb_switch *sw)
> > >   	}
> > >   }
> > > +/**
> > > + * usb4_port_reset() - Reset USB4 downsteam port
> > > + * @port: USB4 port to reset.
> > > + *
> > > + * Helps to reconfigure USB4 link by resetting downstream port.
> > > + *
> > > + * Return: Returns 0 on success or an error code on failure.
> > > + */
> > > +int usb4_port_reset(struct tb_port *port)
> > > +{
> > > +	u32 val = 0;
> > This initialization is actually not needed.
> Ack.
> > 
> > > +	int ret;
> > > +
> > > +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val = val | PORT_CS_19_DPR;
> > val |= PORT_CS_19_DPR;
> > 
> > Same as you do below with &= ~..
> Ack.
> > 
> > > +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Wait for 10ms after requesting downstream port reset */
> > > +	usleep_range(10000, 15000);
> > > +
> > > +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +	if (ret)
> > > +		return ret;
> > Do you really need to read it back from the hardware here?
> 
> I don't think it's necessary. But I added this just to be safe if performing
> DPR has
> made changes to other CS_19 bits.

Okay.

> > > +
> > > +	val &= ~PORT_CS_19_DPR;
> > > +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +
> > > +	return ret;
> > This can be simply
> > 
> > 	return tb_port_write(port, &val, TB_CFG_PORT,
> > 			     port->cap_usb4 + PORT_CS_19, 1);
> Ack.
> > > +}
> > > +
> > >   /**
> > >    * usb4_port_unlock() - Unlock USB4 downstream port
> > >    * @port: USB4 port to unlock
> > > -- 
> > > 2.34.1
