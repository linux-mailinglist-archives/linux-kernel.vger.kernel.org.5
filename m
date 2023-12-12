Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D280F156
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377119AbjLLPlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377205AbjLLPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:41:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD0695;
        Tue, 12 Dec 2023 07:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702395669; x=1733931669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZ6hvomjTCYe68qbVXiiPSpyzF165YdGy6Q7vZP6y80=;
  b=ZdO1yfHzts9gL/OHocgUnzzkvhUkCeztyfHAmWsGJZvOi3x6rmZ2DMnG
   TS26DMZQXRYeCE8ghWpTi0ahI+MzXjz3mq5j5yutF5cPZpiveP7WT8/9h
   HYk6IguSp2eXShiRcp8saMRd/soSgISkbei+M0obk2yLk/GwCdXbA4vo8
   nQrbSvSRCV01hVk1cIoLWJ4zKWVUZogJwIbnur4/AE11cffFVmtu0Z9yS
   ufV11zQUeQ6mmuZ/NYtdG4vA6Coa40ior8ReGipRiIRd1+r2Wovn2P84s
   mRKqk/LbTLEUA/9fx0Rr4H+D61s55cid5KUD4uJpf0V57B6KIsKDzBzmB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1903332"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="1903332"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 07:41:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="777137588"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="777137588"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Dec 2023 07:41:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E19453D2; Tue, 12 Dec 2023 17:41:04 +0200 (EET)
Date:   Tue, 12 Dec 2023 17:41:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Sanath S <Sanath.S@amd.com>, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Introduce tb_switch_reset_ports(),
 tb_port_reset() and usb4_port_reset()
Message-ID: <20231212154104.GH1074920@black.fi.intel.com>
References: <20231212140047.2021496-1-Sanath.S@amd.com>
 <20231212140047.2021496-2-Sanath.S@amd.com>
 <20231212152706.GG1074920@black.fi.intel.com>
 <c56a359b-d035-4557-84d2-6c8ddd600bff@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c56a359b-d035-4557-84d2-6c8ddd600bff@amd.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:32:03AM -0600, Mario Limonciello wrote:
> On 12/12/2023 09:27, Mika Westerberg wrote:
> > On Tue, Dec 12, 2023 at 07:30:46PM +0530, Sanath S wrote:
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
> > >   drivers/thunderbolt/switch.c  | 31 ++++++++++++++++++++++++++++
> > >   drivers/thunderbolt/tb.h      |  2 ++
> > >   drivers/thunderbolt/tb_regs.h |  1 +
> > >   drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
> > >   4 files changed, 73 insertions(+)
> > > 
> > > diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> > > index 44e9b09de47a..26ad6cc1ee91 100644
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
> > > @@ -1547,6 +1560,24 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
> > >   	       regs->__unknown1, regs->__unknown4);
> > >   }
> > > +/**
> > > + * tb_switch_reset_ports() - Reset downstream ports of switch.
> > > + * @sw: Switch whose ports need to be reset.
> > > + *
> > > + * Return: Returns 0 on success or an error code on failure.
> > > + */
> > > +int tb_switch_reset_ports(struct tb_switch *sw)
> > > +{
> > > +	struct tb_port *port;
> > > +	int ret = -EINVAL;
> > 
> > Why it returns -EINVAL? What if this is run for non-USB4 router?
> 
> This is a good point, but in the non USB4 case (default return) maybe it's
> better to be -ENODEV and in patch 2 be careful about the caller.

Or -EOPNOTSUPP (to be consistent with the rest of the driver). Add this
to the kernel-doc too so that the caller needs to make sure
tb_switch_is_usb4() is called before this one or so.

> 
> > 
> > > +
> > > +	tb_switch_for_each_port(sw, port) {
> > > +		if (tb_port_is_null(port) && port->cap_usb4)
> > > +			ret = tb_port_reset(port);
> > 
> > Should it stop here and return ret?
> 
> +1
> 
> > 
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
> > > index 4277733d0021..55f7c163bf84 100644
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
> > > +	int ret;
> > > +	u32 val = 0;
> > 
> > Reverse christmas tree please:
> > 
> > u32 val = 0;
> > int ret;
> > 
> > > +
> > > +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val = val | PORT_CS_19_DPR;
> > > +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Wait for 10ms after requesting downstream port reset */
> > > +	msleep(10);
> > 
> > Probably good to add a couple of more ms just in case. Also
> > usleep_range()? (or fsleep()).
> 
> Sanath had it at 20 but I had suggested to align to spec.
> For the wiggle room maybe usleep_range(10000, 15000)?

Works for me.

> 
> > 
> > > +
> > > +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val &= ~PORT_CS_19_DPR;
> > > +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> > > +			port->cap_usb4 + PORT_CS_19, 1);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > >   /**
> > >    * usb4_port_unlock() - Unlock USB4 downstream port
> > >    * @port: USB4 port to unlock
> > > -- 
> > > 2.34.1
