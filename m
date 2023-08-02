Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6950676CD53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjHBMph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjHBMpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:45:34 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40502D51;
        Wed,  2 Aug 2023 05:44:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vov1X90_1690980241;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vov1X90_1690980241)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 20:44:02 +0800
Date:   Wed, 2 Aug 2023 20:43:56 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "D . Wythe" <alibuda@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/smc: Use correct buffer sizes when switching
 between TCP and SMC
Message-ID: <ZMpPjAaRzSRy-Vo_@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20230802093313.1501605-1-gbayer@linux.ibm.com>
 <20230802093313.1501605-3-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802093313.1501605-3-gbayer@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:33:13AM +0200, Gerd Bayer wrote:
> Tuning of the effective buffer size through setsockopts was working for
> SMC traffic only but not for TCP fall-back connections even before
> commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and
> make them tunable"). That change made it apparent that TCP fall-back
> connections would use net.smc.[rw]mem as buffer size instead of
> net.ipv4_tcp_[rw]mem.
> 
> Amend the code that copies attributes between the (TCP) clcsock and the
> SMC socket and adjust buffer sizes appropriately:
> - Copy over sk_userlocks so that both sockets agree on whether tuning
>   via setsockopt is active.
> - When falling back to TCP use sk_sndbuf or sk_rcvbuf as specified with
>   setsockopt. Otherwise, use the sysctl value for TCP/IPv4.
> - Likewise, use either values from setsockopt or from sysctl for SMC
>   (duplicated) on successful SMC connect.
> 
> In smc_tcp_listen_work() drop the explicit copy of buffer sizes as that
> is taken care of by the attribute copy.
> 
> Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Reviewed-by: Jan Karcher <jaka@linux.ibm.com>

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> 
^^^^ nit: a extra new line here.
> ---
>  net/smc/af_smc.c | 76 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 22 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 1fcf1e42474a..1c8ed19041d7 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -436,13 +436,63 @@ static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
>  	return rc;
>  }
>  
> +/* copy only relevant settings and flags of SOL_SOCKET level from smc to
> + * clc socket (since smc is not called for these options from net/core)
> + */
> +
> +#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
> +			     (1UL << SOCK_KEEPOPEN) | \
> +			     (1UL << SOCK_LINGER) | \
> +			     (1UL << SOCK_BROADCAST) | \
> +			     (1UL << SOCK_TIMESTAMP) | \
> +			     (1UL << SOCK_DBG) | \
> +			     (1UL << SOCK_RCVTSTAMP) | \
> +			     (1UL << SOCK_RCVTSTAMPNS) | \
> +			     (1UL << SOCK_LOCALROUTE) | \
> +			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
> +			     (1UL << SOCK_RXQ_OVFL) | \
> +			     (1UL << SOCK_WIFI_STATUS) | \
> +			     (1UL << SOCK_NOFCS) | \
> +			     (1UL << SOCK_FILTER_LOCKED) | \
> +			     (1UL << SOCK_TSTAMP_NEW))
> +
> +/* if set, use value set by setsockopt() - else use IPv4 or SMC sysctl value */
> +static void smc_adjust_sock_bufsizes(struct sock *nsk, struct sock *osk,
> +				     unsigned long mask)
> +{
> +	struct net *nnet;
> +
> +	nnet = nsk->sk_net.net;

Better to combine these two lines with existed helper.

struct net *net = sock_net(nsk);

> +
> +	nsk->sk_userlocks = osk->sk_userlocks;
> +
> +	if (osk->sk_userlocks & SOCK_SNDBUF_LOCK) {
> +		nsk->sk_sndbuf = osk->sk_sndbuf;
> +	} else {
> +		if (mask == SK_FLAGS_SMC_TO_CLC)
> +			WRITE_ONCE(nsk->sk_sndbuf,
> +				   READ_ONCE(nnet->ipv4.sysctl_tcp_wmem[1]));
> +		else
> +			WRITE_ONCE(nsk->sk_sndbuf,
> +				   2 * READ_ONCE(nnet->smc.sysctl_wmem));
> +	}
> +	if (osk->sk_userlocks & SOCK_RCVBUF_LOCK) {
> +		nsk->sk_rcvbuf = osk->sk_rcvbuf;
> +	} else {
> +		if (mask == SK_FLAGS_SMC_TO_CLC)
> +			WRITE_ONCE(nsk->sk_rcvbuf,
> +				   READ_ONCE(nnet->ipv4.sysctl_tcp_rmem[1]));
> +		else
> +			WRITE_ONCE(nsk->sk_rcvbuf,
> +				   2 * READ_ONCE(nnet->smc.sysctl_rmem));
> +	}
> +}
> +
>  static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
>  				   unsigned long mask)
>  {
>  	/* options we don't get control via setsockopt for */
>  	nsk->sk_type = osk->sk_type;
> -	nsk->sk_sndbuf = osk->sk_sndbuf;
> -	nsk->sk_rcvbuf = osk->sk_rcvbuf;
>  	nsk->sk_sndtimeo = osk->sk_sndtimeo;
>  	nsk->sk_rcvtimeo = osk->sk_rcvtimeo;
>  	nsk->sk_mark = osk->sk_mark;
> @@ -453,26 +503,10 @@ static void smc_copy_sock_settings(struct sock *nsk, struct sock *osk,
>  
>  	nsk->sk_flags &= ~mask;
>  	nsk->sk_flags |= osk->sk_flags & mask;
> +
> +	smc_adjust_sock_bufsizes(nsk, osk, mask);
>  }
>  
> -#define SK_FLAGS_SMC_TO_CLC ((1UL << SOCK_URGINLINE) | \
> -			     (1UL << SOCK_KEEPOPEN) | \
> -			     (1UL << SOCK_LINGER) | \
> -			     (1UL << SOCK_BROADCAST) | \
> -			     (1UL << SOCK_TIMESTAMP) | \
> -			     (1UL << SOCK_DBG) | \
> -			     (1UL << SOCK_RCVTSTAMP) | \
> -			     (1UL << SOCK_RCVTSTAMPNS) | \
> -			     (1UL << SOCK_LOCALROUTE) | \
> -			     (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE) | \
> -			     (1UL << SOCK_RXQ_OVFL) | \
> -			     (1UL << SOCK_WIFI_STATUS) | \
> -			     (1UL << SOCK_NOFCS) | \
> -			     (1UL << SOCK_FILTER_LOCKED) | \
> -			     (1UL << SOCK_TSTAMP_NEW))
> -/* copy only relevant settings and flags of SOL_SOCKET level from smc to
> - * clc socket (since smc is not called for these options from net/core)
> - */
>  static void smc_copy_sock_settings_to_clc(struct smc_sock *smc)
>  {
>  	smc_copy_sock_settings(smc->clcsock->sk, &smc->sk, SK_FLAGS_SMC_TO_CLC);
> @@ -2479,8 +2513,6 @@ static void smc_tcp_listen_work(struct work_struct *work)
>  		sock_hold(lsk); /* sock_put in smc_listen_work */
>  		INIT_WORK(&new_smc->smc_listen_work, smc_listen_work);
>  		smc_copy_sock_settings_to_smc(new_smc);
> -		new_smc->sk.sk_sndbuf = lsmc->sk.sk_sndbuf;
> -		new_smc->sk.sk_rcvbuf = lsmc->sk.sk_rcvbuf;
>  		sock_hold(&new_smc->sk); /* sock_put in passive closing */
>  		if (!queue_work(smc_hs_wq, &new_smc->smc_listen_work))
>  			sock_put(&new_smc->sk);
> -- 
> 2.41.0
