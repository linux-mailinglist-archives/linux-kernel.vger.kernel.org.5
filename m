Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77697C9777
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 02:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjJOAz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 20:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOAz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 20:55:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE0CCC;
        Sat, 14 Oct 2023 17:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uAzEWPlAFbI+/fsmaBKX8Evs419Pr/qqscJnwH/iIs8=; b=d0woM+J55qDqjJ1yABgFrsVnsR
        1VtkjUnmUIsUx9gOna03H0aiRUVr237NSfBV+2FSvxgDmGVi4bCvdXZkqFXoQElWDHjovK73UlLYl
        ZPpcKXrpU34AKeoQ4yly9TtviEdwKiisWqHRmM+9CpgVU25jng3t2fdRcZAIhTRjSndtpSQ1yhwzu
        bTx9nNLURWqATdLs5rQvPBrC8mSggNsSJ3iYOT9VlIb9iCj3zRw+t9Jg2w1ifOOwkWndmY1gE1MwJ
        QgcoD/Lrs5T94mVhFHTWQ0lTBIcrwqOo5NCBEjCXa7YewUAEiMltcf0M0RjTcgtmJP4wFPz48wGqI
        rmH/ztaw==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qrpPT-001Key-1W;
        Sun, 15 Oct 2023 00:55:11 +0000
Date:   Sat, 14 Oct 2023 17:55:08 -0700
From:   Joel Becker <jlbec@evilplan.org>
To:     Breno Leitao <leitao@debian.org>
Cc:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH net-next v4 3/4] netconsole: Attach cmdline target to
 dynamic target
Message-ID: <ZSs4bC+NST2hkT/E@google.com>
Mail-Followup-To: Breno Leitao <leitao@debian.org>, kuba@kernel.org,
        davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
References: <20231012111401.333798-1-leitao@debian.org>
 <20231012111401.333798-4-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012111401.333798-4-leitao@debian.org>
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

On Thu, Oct 12, 2023 at 04:14:00AM -0700, Breno Leitao wrote:
> Enable the attachment of a dynamic target to the target created during
> boot time. The boot-time targets are named as "cmdline\d", where "\d" is
> a number starting at 0.
> 
> If the user creates a dynamic target named "cmdline0", it will attach to
> the first target created at boot time (as defined in the
> `netconsole=...` command line argument). `cmdline1` will attach to the
> second target and so forth.
> 
> If there is no netconsole target created at boot time, then, the target
> name could be reused.
> 
> Relevant design discussion:
> https://lore.kernel.org/all/ZRWRal5bW93px4km@gmail.com/
> 
> Suggested-by: Joel Becker <jlbec@evilplan.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Joel Becker <jlbec@evilplan.org>

> ---
>  drivers/net/netconsole.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index e153bce4dee4..6e14ba5e06c8 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -629,6 +629,23 @@ static const struct config_item_type netconsole_target_type = {
>  	.ct_owner		= THIS_MODULE,
>  };
>  
> +static struct netconsole_target *find_cmdline_target(const char *name)
> +{
> +	struct netconsole_target *nt, *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&target_list_lock, flags);
> +	list_for_each_entry(nt, &target_list, list) {
> +		if (!strcmp(nt->item.ci_name, name)) {
> +			ret = nt;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&target_list_lock, flags);
> +
> +	return ret;
> +}
> +
>  /*
>   * Group operations and type for netconsole_subsys.
>   */
> @@ -639,6 +656,17 @@ static struct config_item *make_netconsole_target(struct config_group *group,
>  	struct netconsole_target *nt;
>  	unsigned long flags;
>  
> +	/* Checking if a target by this name was created at boot time.  If so,
> +	 * attach a configfs entry to that target.  This enables dynamic
> +	 * control.
> +	 */
> +	if (!strncmp(name, NETCONSOLE_PARAM_TARGET_PREFIX,
> +		     strlen(NETCONSOLE_PARAM_TARGET_PREFIX))) {
> +		nt = find_cmdline_target(name);
> +		if (nt)
> +			return &nt->item;
> +	}
> +
>  	nt = alloc_and_init();
>  	if (!nt)
>  		return ERR_PTR(-ENOMEM);
> -- 
> 2.34.1
> 

-- 

"Nobody loves me,
 Nobody seems to care.
 Troubles and worries, people,
 You know I've had my share."

			http://www.jlbec.org/
			jlbec@evilplan.org
