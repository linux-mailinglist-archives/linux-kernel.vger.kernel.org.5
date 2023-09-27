Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7D67AFB94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjI0HA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjI0HAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:00:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EDADD;
        Wed, 27 Sep 2023 00:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695798050; x=1727334050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YX9TWgn0UXlaSLJg2Ni0qoS+6JJGfy7qMNveOHGM1SA=;
  b=eyWNQB7d1dJ0FvM5Hmk45CJ7lW/jfwSDhChw6SoZwV91hd8uuuPVMdQt
   VS3dd+974CdKYTsmVEMKnN5fHyhMwCqBedoLXiDY8lJFxafrBI6JmIBvF
   AVrwf9cKBinBbCWg6lx9dPSouTArmr1pKKLSuTtiEv/n1f3+EyED1GmLS
   tLj9A06zahDgwvgimWBXdMaN4r/+JDF2qE3s2u61XJcFj1qCgzKBP3VJ1
   oZlwFRB868sOYdNzdTM+7S4N/MW26RpaB7PzouMvgYTOqD/UgUMGC4aUq
   ueHC5Mbx0E87SCOKOQUYX0vL4KJ76NEaRVUe6sGCLMrgAIM6X5ADgq/6R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412662330"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="412662330"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:00:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="1080015792"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="1080015792"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 27 Sep 2023 00:00:46 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Sep 2023 10:00:45 +0300
Date:   Wed, 27 Sep 2023 10:00:45 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com
Subject: Re: [PATCH v6 02/14] USB: typec: Add cmd timeout and response delay
Message-ID: <ZRPTHeYhdtdtKZ1/@kuha.fi.intel.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
 <20230923073959.86660-3-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923073959.86660-3-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 03:39:47AM -0400, Abdel Alkuor wrote:
> Some commands in tps25750 take longer than 1 second
> to complete, and some responses need some delay before
> the result becomes available.
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v6:
>   - Use tps6598x_exec_cmd as a wrapper
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 37b56ce75f39..32420c61660d 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -282,9 +282,10 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  	power_supply_changed(tps->psy);
>  }
>  
> -static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> +static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
>  			     size_t in_len, u8 *in_data,
> -			     size_t out_len, u8 *out_data)
> +			     size_t out_len, u8 *out_data,
> +			     u32 cmd_timeout_ms, u32 res_delay_ms)
>  {
>  	unsigned long timeout;
>  	u32 val;
> @@ -307,8 +308,7 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>  	if (ret < 0)
>  		return ret;
>  
> -	/* XXX: Using 1s for now, but it may not be enough for every command. */
> -	timeout = jiffies + msecs_to_jiffies(1000);
> +	timeout = jiffies + msecs_to_jiffies(cmd_timeout_ms);
>  
>  	do {
>  		ret = tps6598x_read32(tps, TPS_REG_CMD1, &val);
> @@ -321,6 +321,9 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>  			return -ETIMEDOUT;
>  	} while (val);
>  
> +	/* some commands require delay for the result to be available */
> +	mdelay(res_delay_ms);
> +
>  	if (out_len) {
>  		ret = tps6598x_block_read(tps, TPS_REG_DATA1,
>  					  out_data, out_len);
> @@ -345,6 +348,14 @@ static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
>  	return 0;
>  }
>  
> +static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> +			     size_t in_len, u8 *in_data,
> +			     size_t out_len, u8 *out_data)
> +{
> +	return tps6598x_exec_cmd_tmo(tps, cmd, in_len, in_data,
> +				     out_len, out_data, 1000, 0);
> +}
> +
>  static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
>  {
>  	const char *cmd = (role == TYPEC_DEVICE) ? "SWUF" : "SWDF";
> -- 
> 2.34.1

-- 
heikki
