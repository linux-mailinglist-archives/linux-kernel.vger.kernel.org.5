Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8FB7C9771
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 02:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjJOAyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 20:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjJOAyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 20:54:03 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82ECC;
        Sat, 14 Oct 2023 17:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fxni5dSBmJbibsqwhrWcgihmJb45z5XJE9yEcbUr3IQ=; b=remL+vZ6HueAFulPsMj0pfW7uY
        psBV4lobi6JLREOl815YSw2H1fv2ryCihrz/xgr4XxYaDanbcY88sS6p/Tai2oM8HYQ6YrqpOg9OB
        3h5gB6zUzIjsCtccKBl9SmFSk3KtBMSLjT5gy74RqONohJnZL+FpT+lgEHCmIsSBAilS7mjxcDARI
        cXgiB+cHcAJgkZo6ih+pakXCsBPyMoI7FmH8ejaDQFlSX3O4YHeY3+BQ9ZUtKq/ipAf0WqJT4uZAH
        pdo2KNUW4tlkBN+Jze0OYR9c3E37kDIrKxKDP8MmSx/cjZNe5aZtzJeU1u61wYhqifB35dW7GkjkF
        GxNq6/SQ==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qrpO1-001Kco-0g;
        Sun, 15 Oct 2023 00:53:41 +0000
Date:   Sat, 14 Oct 2023 17:53:32 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH net-next v4 2/4] netconsole: Initialize configfs_item for
 default targets
Message-ID: <ZSs4DF1o9pDlRP7w@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
References: <20231012111401.333798-1-leitao@debian.org>
 <20231012111401.333798-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012111401.333798-3-leitao@debian.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 04:13:59AM -0700, Breno Leitao wrote:
> For netconsole targets allocated during the boot time (passing
> netconsole=... argument), netconsole_target->item is not initialized.
> That is not a problem because it is not used inside configfs.
> 
> An upcoming patch will be using it, thus, initialize the targets with
> the name 'cmdline' plus a counter starting from 0.  This name will match
> entries in the configfs later.
> 
> Suggested-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
>  drivers/net/netconsole.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index d609fb59cf99..e153bce4dee4 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -53,6 +53,8 @@ static bool oops_only = false;
>  module_param(oops_only, bool, 0600);
>  MODULE_PARM_DESC(oops_only, "Only log oops messages");
>  
> +#define NETCONSOLE_PARAM_TARGET_PREFIX "cmdline"
> +
>  #ifndef	MODULE
>  static int __init option_setup(char *opt)
>  {
> @@ -165,6 +167,10 @@ static void netconsole_target_put(struct netconsole_target *nt)
>  {
>  }
>  
> +static void populate_configfs_item(struct netconsole_target *nt,
> +				   int cmdline_count)
> +{
> +}
>  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
>  
>  /* Allocate and initialize with defaults.
> @@ -688,6 +694,17 @@ static struct configfs_subsystem netconsole_subsys = {
>  	},
>  };
>  
> +static void populate_configfs_item(struct netconsole_target *nt,
> +				   int cmdline_count)
> +{
> +	char target_name[16];
> +
> +	snprintf(target_name, sizeof(target_name), "%s%d",
> +		 NETCONSOLE_PARAM_TARGET_PREFIX, cmdline_count);
> +	config_item_init_type_name(&nt->item, target_name,
> +				   &netconsole_target_type);
> +}
> +
>  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
>  
>  /* Handle network interface device notifications */
> @@ -887,7 +904,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
>  }
>  
>  /* Allocate new target (from boot/module param) and setup netpoll for it */
> -static struct netconsole_target *alloc_param_target(char *target_config)
> +static struct netconsole_target *alloc_param_target(char *target_config,
> +						    int cmdline_count)
>  {
>  	struct netconsole_target *nt;
>  	int err;
> @@ -922,6 +940,7 @@ static struct netconsole_target *alloc_param_target(char *target_config)
>  	if (err)
>  		goto fail;
>  
> +	populate_configfs_item(nt, cmdline_count);
>  	nt->enabled = true;
>  
>  	return nt;
> @@ -954,6 +973,7 @@ static int __init init_netconsole(void)
>  {
>  	int err;
>  	struct netconsole_target *nt, *tmp;
> +	unsigned int count = 0;
>  	bool extended = false;
>  	unsigned long flags;
>  	char *target_config;
> @@ -961,7 +981,7 @@ static int __init init_netconsole(void)
>  
>  	if (strnlen(input, MAX_PARAM_LENGTH)) {
>  		while ((target_config = strsep(&input, ";"))) {
> -			nt = alloc_param_target(target_config);
> +			nt = alloc_param_target(target_config, count);
>  			if (IS_ERR(nt)) {
>  				err = PTR_ERR(nt);
>  				goto fail;
> @@ -977,6 +997,7 @@ static int __init init_netconsole(void)
>  			spin_lock_irqsave(&target_list_lock, flags);
>  			list_add(&nt->list, &target_list);
>  			spin_unlock_irqrestore(&target_list_lock, flags);
> +			count++;
>  		}
>  	}
>  
> -- 
> 2.34.1
> 

-- 

"I don't want to achieve immortality through my work; I want to
 achieve immortality through not dying."
        - Woody Allen

			http://www.jlbec.org/
			jlbec@evilplan.org
