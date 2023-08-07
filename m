Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465057718B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjHGDNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHGDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A52010F6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84D2860F36
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82018C433C8;
        Mon,  7 Aug 2023 03:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691377999;
        bh=uLNSAWYcfGbQ5pT6oMUu2cY9U/9eHT+/NKcyMIBS8lQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHm6hvnIcpkHGPPepfnJvc//JpoPwfWAu3+Qt0alLMap9Bsi/51KLVttJdx5JjG+j
         tauj8/uhsWNl36Oxb0GiHYmPSx6kQpAplajKJDxYnri8u1u09/3hFZVT6ymHaOMBey
         DGX9XugsgdaCUyEGSx5NzkNUlLG8sxHrzsK4A4zUKnfppxceDM0s6ZwV8bl3TP+Buy
         wxSimnAoNdt5WRxaC88OIiRPXKd6/Hmqiweby7sWoh7x5IdgQDZSPvTiriS2jcEoj/
         cmbU974Pqz27W+fMyaN3ap1TNKiU0jfC0qX9rBObBjOC6HmQHyXdgeDt4PWaYC6XmP
         o0ap3GQQBix4Q==
Date:   Mon, 7 Aug 2023 11:13:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V5 6/9] firmware: imx: scu-irq: fix RCU complains after
 M4 partition reset
Message-ID: <20230807031309.GO151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-7-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731090449.2845997-7-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:04:46PM +0800, Peng Fan (OSS) wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> Use blocking_notifier_chain instead of atomic_notifier_chain, otherwise
> below RCU complains would come out since unregister/register_virtio_device

s/complains/complaint, and in subject too.

> () will issue mbox message (mbox_send_message() is blocking) again after

The () should be on the same line as register_virtio_device.

> received M4 partition reset. Actually, no need atomic for notifier which

there is no need of atomic for ...?

Shawn

> is so tough for user since this notifier is called in worker instead of
> interrupt handler directly.
> 
> [  389.706645] i2c-rpmsg virtio0.rpmsg-i2c-channel.-1.2: i2c rpmsg driver is removed
> [  389.767362] Wait for remote ready timeout, use first_notify.
> [  389.774084] ------------[ cut here ]------------
> [  389.778729] WARNING: CPU: 0 PID: 397 at kernel/rcu/tree_plugin.h:293 rcu_note_context_switch+0x34/0x338
> [  389.788131] Modules linked in:
> [  389.791195] CPU: 0 PID: 397 Comm: kworker/0:13 Not tainted 5.4.0-rc5-02977-g08f78722f07b #26
> [  389.799633] Hardware name: Freescale i.MX8DXL Phantom MEK (DT)
> [  389.805481] Workqueue: events imx_scu_irq_work_handler
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/firmware/imx/imx-scu-irq.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> index d9dcc20945c6..4408f150b3d5 100644
> --- a/drivers/firmware/imx/imx-scu-irq.c
> +++ b/drivers/firmware/imx/imx-scu-irq.c
> @@ -42,25 +42,25 @@ struct imx_sc_msg_irq_enable {
>  
>  static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
>  static struct work_struct imx_sc_irq_work;
> -static ATOMIC_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
> +static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
>  
>  int imx_scu_irq_register_notifier(struct notifier_block *nb)
>  {
> -	return atomic_notifier_chain_register(
> +	return blocking_notifier_chain_register(
>  		&imx_scu_irq_notifier_chain, nb);
>  }
>  EXPORT_SYMBOL(imx_scu_irq_register_notifier);
>  
>  int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
>  {
> -	return atomic_notifier_chain_unregister(
> +	return blocking_notifier_chain_unregister(
>  		&imx_scu_irq_notifier_chain, nb);
>  }
>  EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
>  
>  static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
>  {
> -	return atomic_notifier_call_chain(&imx_scu_irq_notifier_chain,
> +	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
>  		status, (void *)group);
>  }
>  
> -- 
> 2.37.1
> 
