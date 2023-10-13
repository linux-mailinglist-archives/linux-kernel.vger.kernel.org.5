Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD387C853A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjJMMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjJMMBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:01:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D32D5C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:01:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FB2C433C7;
        Fri, 13 Oct 2023 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198468;
        bh=3oSV4wrD/VI++CPjF8EIFb1o1M+cd24rSplIjiYIWZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlUxoZCOMvp9g/HsQZN5dp8ZWPZx6QOhRnZ98IJmckIaJoLyfYZNIzzG3vpb2dJzY
         DXWomoi7mo5Mu/CFkD0OPChiEzmBmdwwSv4HQiTCN4Omw4D7TLUtroJFMgPj1xtjHg
         1cPG9g+YTJoLfLrrcZyw88Ul4XtmcohDdqBUNXiAfP6CL1YJnVRce8HNU0zIOkFaP4
         M86iRH6QEqMSHSEw9rGN/0REWO6UJnrCTmSRHNq89QdHYwo3aeJzMwSrev/816v8YS
         sjMsSHJfRDkFY+gNdPNapi5HNuPnsTSeXtgRVZNDHaEz4Qy8j7ZkFCoGQNcPEKF0yW
         pzr5DK/7k5Crw==
Date:   Fri, 13 Oct 2023 14:01:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net,
        Liam.Howlett@oracle.com, netdev@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v2] Fix NULL pointer deref due to filtering on fork
Message-ID: <20231013120105.GH29570@kernel.org>
References: <20231011051225.3674436-1-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011051225.3674436-1-anjali.k.kulkarni@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:12:25PM -0700, Anjali Kulkarni wrote:
> cn_netlink_send_mult() should be called with filter & filter_data only
> for EXIT case. For all other events, filter & filter_data should be
> NULL.
> 
> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com__;!!ACWV5N9M2RV99hQ!PgqlHq_nOe_KlyKkB9Mm_S8QstTJvicjuENwskatuuQK05KPuFw-KvRZeOH8iuEAMjRhkxEMPKJJnLcaT8zrPf9aqNs$

For the record, this got a bit mangled. I believe it should be:

Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/

Also, there is probably no need to resend because of this,
but no blank line here, please.

> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> ---
>  drivers/connector/cn_proc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
> index 05d562e9c8b1..01e17f18d187 100644
> --- a/drivers/connector/cn_proc.c
> +++ b/drivers/connector/cn_proc.c
> @@ -104,13 +104,13 @@ static inline void send_msg(struct cn_msg *msg)
>  	if (filter_data[0] == PROC_EVENT_EXIT) {
>  		filter_data[1] =
>  		((struct proc_event *)msg->data)->event_data.exit.exit_code;
> +		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> +				     cn_filter, (void *)filter_data);
>  	} else {
> -		filter_data[1] = 0;
> +		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> +				     NULL, NULL);
>  	}
>  
> -	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
> -			     cn_filter, (void *)filter_data);
> -

I am wondering if you considered making cn_filter slightly smarter.
It seems it already understands not to do very much for PROC_EVENT_ALL.

>  	local_unlock(&local_event.lock);
>  }
>  
> -- 
> 2.42.0
> 
> 
