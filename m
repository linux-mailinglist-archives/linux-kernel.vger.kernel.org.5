Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D449180F065
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjLLP1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjLLP1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:27:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5593D0;
        Tue, 12 Dec 2023 07:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702394829; x=1733930829;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHJpjWivJi6vmpkJlgw8nUugGxdkOk53hw5vrDETwKE=;
  b=jUl6Y88N8BkLTG4FdnxE66CMvjCsDxWnbEx/L45mk1zqrXtDVaU1NSbU
   ELdGdR6riQbAkacvhSJW2DWBN0nrHpgQmkr6xAF9/qs/Wdgp2K6ktdp1+
   n9xfnz9mIht+hl7o8gpMG/5Bv1YB7wHQyK6k8cs7DzYJFzZIMLYDsuIyL
   r6M+6Vv5O6oD4SwbEOcS6JKO2vRWnGGj0XeVmKVWgXxfaeamRWH6D5798
   3hN6tpZ27zeFY3gEJYS+RQpJvAu2kMeWjGgNrzmvtV5WovWvUrwViBxyx
   /XazhtkMsApnUPFaNN1pfgThICm7RZWgkxbyzyb9kFPZjnduyzJjBIVyt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="374327950"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="374327950"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 07:27:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="917317349"
X-IronPort-AV: E=Sophos;i="6.04,270,1695711600"; 
   d="scan'208";a="917317349"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2023 07:27:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5E8EC3D2; Tue, 12 Dec 2023 17:27:06 +0200 (EET)
Date:   Tue, 12 Dec 2023 17:27:06 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Sanath S <Sanath.S@amd.com>
Cc:     mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thunderbolt: Introduce tb_switch_reset_ports(),
 tb_port_reset() and usb4_port_reset()
Message-ID: <20231212152706.GG1074920@black.fi.intel.com>
References: <20231212140047.2021496-1-Sanath.S@amd.com>
 <20231212140047.2021496-2-Sanath.S@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231212140047.2021496-2-Sanath.S@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 07:30:46PM +0530, Sanath S wrote:
> Introduce the tb_switch_reset_ports() function that resets the
> downstream ports of a given switch. This helps us reset the USB4
> links created by boot firmware during the init sequence.
> 
> Introduce the tb_port_reset() helper function that resets the
> given port.
> 
> Introduce the usb4_port_reset() function that performs the DPR
> of a given port. This function follows the CM guide specification 7.3
> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> ---
>  drivers/thunderbolt/switch.c  | 31 ++++++++++++++++++++++++++++
>  drivers/thunderbolt/tb.h      |  2 ++
>  drivers/thunderbolt/tb_regs.h |  1 +
>  drivers/thunderbolt/usb4.c    | 39 +++++++++++++++++++++++++++++++++++
>  4 files changed, 73 insertions(+)
> 
> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
> index 44e9b09de47a..26ad6cc1ee91 100644
> --- a/drivers/thunderbolt/switch.c
> +++ b/drivers/thunderbolt/switch.c
> @@ -626,6 +626,19 @@ int tb_port_unlock(struct tb_port *port)
>  	return 0;
>  }
>  
> +/**
> + * tb_port_reset() - Reset downstream port
> + * @port: Port to reset
> + *
> + * Helps to reconfigure the USB4 link by resetting the downstream port.
> + *
> + * Return: Returns 0 on success or an error code on failure.
> + */
> +static int tb_port_reset(struct tb_port *port)
> +{
> +	return usb4_port_reset(port);
> +}
> +
>  static int __tb_port_enable(struct tb_port *port, bool enable)
>  {
>  	int ret;
> @@ -1547,6 +1560,24 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>  	       regs->__unknown1, regs->__unknown4);
>  }
>  
> +/**
> + * tb_switch_reset_ports() - Reset downstream ports of switch.
> + * @sw: Switch whose ports need to be reset.
> + *
> + * Return: Returns 0 on success or an error code on failure.
> + */
> +int tb_switch_reset_ports(struct tb_switch *sw)
> +{
> +	struct tb_port *port;
> +	int ret = -EINVAL;

Why it returns -EINVAL? What if this is run for non-USB4 router?

> +
> +	tb_switch_for_each_port(sw, port) {
> +		if (tb_port_is_null(port) && port->cap_usb4)
> +			ret = tb_port_reset(port);

Should it stop here and return ret?

> +	}
> +	return ret;
> +}
> +
>  /**
>   * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>   * @sw: Switch to reset
> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
> index e299e53473ae..f2687ec4ac53 100644
> --- a/drivers/thunderbolt/tb.h
> +++ b/drivers/thunderbolt/tb.h
> @@ -797,6 +797,7 @@ void tb_switch_remove(struct tb_switch *sw);
>  void tb_switch_suspend(struct tb_switch *sw, bool runtime);
>  int tb_switch_resume(struct tb_switch *sw);
>  int tb_switch_reset(struct tb_switch *sw);
> +int tb_switch_reset_ports(struct tb_switch *sw);
>  int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
>  			   u32 value, int timeout_msec);
>  void tb_sw_set_unplugged(struct tb_switch *sw);
> @@ -1281,6 +1282,7 @@ struct tb_port *usb4_switch_map_usb3_down(struct tb_switch *sw,
>  int usb4_switch_add_ports(struct tb_switch *sw);
>  void usb4_switch_remove_ports(struct tb_switch *sw);
>  
> +int usb4_port_reset(struct tb_port *port);
>  int usb4_port_unlock(struct tb_port *port);
>  int usb4_port_hotplug_enable(struct tb_port *port);
>  int usb4_port_configure(struct tb_port *port);
> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
> index 87e4795275fe..d49530bc0d53 100644
> --- a/drivers/thunderbolt/tb_regs.h
> +++ b/drivers/thunderbolt/tb_regs.h
> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>  #define PORT_CS_18_CSA				BIT(22)
>  #define PORT_CS_18_TIP				BIT(24)
>  #define PORT_CS_19				0x13
> +#define PORT_CS_19_DPR				BIT(0)
>  #define PORT_CS_19_PC				BIT(3)
>  #define PORT_CS_19_PID				BIT(4)
>  #define PORT_CS_19_WOC				BIT(16)
> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
> index 4277733d0021..55f7c163bf84 100644
> --- a/drivers/thunderbolt/usb4.c
> +++ b/drivers/thunderbolt/usb4.c
> @@ -1073,6 +1073,45 @@ void usb4_switch_remove_ports(struct tb_switch *sw)
>  	}
>  }
>  
> +/**
> + * usb4_port_reset() - Reset USB4 downsteam port
> + * @port: USB4 port to reset.
> + *
> + * Helps to reconfigure USB4 link by resetting downstream port.
> + *
> + * Return: Returns 0 on success or an error code on failure.
> + */
> +int usb4_port_reset(struct tb_port *port)
> +{
> +	int ret;
> +	u32 val = 0;

Reverse christmas tree please:

u32 val = 0;
int ret;

> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	val = val | PORT_CS_19_DPR;
> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for 10ms after requesting downstream port reset */
> +	msleep(10);

Probably good to add a couple of more ms just in case. Also
usleep_range()? (or fsleep()).

> +
> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +	if (ret)
> +		return ret;
> +
> +	val &= ~PORT_CS_19_DPR;
> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
> +			port->cap_usb4 + PORT_CS_19, 1);
> +
> +	return ret;
> +}
> +
>  /**
>   * usb4_port_unlock() - Unlock USB4 downstream port
>   * @port: USB4 port to unlock
> -- 
> 2.34.1
