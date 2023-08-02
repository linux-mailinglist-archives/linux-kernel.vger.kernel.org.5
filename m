Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FE676CCB4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjHBMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjHBMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:33:16 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64532701;
        Wed,  2 Aug 2023 05:33:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vov0kNP_1690979588;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vov0kNP_1690979588)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 20:33:09 +0800
Date:   Wed, 2 Aug 2023 20:33:04 +0800
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
Subject: Re: [PATCH net 1/2] net/smc: Fix setsockopt and sysctl to specify
 same buffer size again
Message-ID: <ZMpNALPfBbSFmBAS@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20230802093313.1501605-1-gbayer@linux.ibm.com>
 <20230802093313.1501605-2-gbayer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802093313.1501605-2-gbayer@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 11:33:12AM +0200, Gerd Bayer wrote:
> Commit 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock
> and make them tunable") introduced the net.smc.rmem and net.smc.wmem
> sysctls to specify the size of buffers to be used for SMC type
> connections. This created a regression for users that specified the
> buffer size via setsockopt() as the effective buffer size was now
> doubled.

The idea of the original patch is going to unbind buffer from clcsock.
It's great here to determine whether to use original value or doubled.

> 
> Re-introduce the division by 2 in the SMC buffer create code and level
> this out by duplicating the net.smc.[rw]mem values used for initializing
> sk_rcvbuf/sk_sndbuf at socket creation time. This gives users of both
> methods (setsockopt or sysctl) the effective buffer size that they
> expect.
> 
> Initialize net.smc.[rw]mem from its own constant of 64kB, respectively.
> Internal performance tests show that this value is a good compromise
> between throughput/latency and memory consumption. Also, this decouples
> it from any tuning that was done to net.ipv4.tcp_[rw]mem[1] before the
> module for SMC protocol was loaded. Check that no more than INT_MAX / 2
> is assigned to net.smc.[rw]mem, in order to avoid any overflow condition
> when that is doubled for use in sk_sndbuf or sk_rcvbuf.

64kB may be small in our environment, but that's okay to change it with
systemd during boot. Different networking environment, such as with
higher latency, should have different buffer size. So two tunable knobs
are good enough.

> 
> While at it, drop the confusing sk_buf_size variable from
> __smc_buf_create and name "compressed" buffer size variables more
> consistently.
> 
> Background:
> 
> Before the commit mentioned above, SMC's buffer allocator in
> __smc_buf_create() always used half of the sockets' sk_rcvbuf/sk_sndbuf
> value as initial value to search for appropriate buffers. If the search
> resorted to using a bigger buffer when all buffers of the specified
> size were busy, the duplicate of the used effective buffer size is
> stored back to sk_rcvbuf/sk_sndbuf.
> 
> When available, buffers of exactly the size that a user had specified as
> input to setsockopt() were used, despite setsockopt()'s documentation in
> "man 7 socket" talking of a mandatory duplication:
> 
> [...]
>        SO_SNDBUF
>               Sets  or  gets the maximum socket send buffer in bytes.
>               The kernel doubles this value (to allow space for book‐
>               keeping  overhead)  when it is set using setsockopt(2),
>               and this doubled value is  returned  by  getsockopt(2).
>               The     default     value     is     set     by     the
>               /proc/sys/net/core/wmem_default file  and  the  maximum
>               allowed value is set by the /proc/sys/net/core/wmem_max
>               file.  The minimum (doubled) value for this  option  is
>               2048.
> [...]
> 
> Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> Co-developed-by: Jan Karcher <jaka@linux.ibm.com>
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> ---
>  net/smc/af_smc.c     |  4 ++--
>  net/smc/smc.h        |  2 +-
>  net/smc/smc_clc.c    |  4 ++--
>  net/smc/smc_core.c   | 25 ++++++++++++-------------
>  net/smc/smc_sysctl.c | 10 ++++++++--
>  5 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index a7f887d91d89..1fcf1e42474a 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -378,8 +378,8 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>  	sk->sk_state = SMC_INIT;
>  	sk->sk_destruct = smc_destruct;
>  	sk->sk_protocol = protocol;
> -	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(net->smc.sysctl_wmem));
> -	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(net->smc.sysctl_rmem));
> +	WRITE_ONCE(sk->sk_sndbuf, 2 * READ_ONCE(net->smc.sysctl_wmem));
> +	WRITE_ONCE(sk->sk_rcvbuf, 2 * READ_ONCE(net->smc.sysctl_rmem));
>  	smc = smc_sk(sk);
>  	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>  	INIT_WORK(&smc->connect_work, smc_connect_work);
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 2eeea4cdc718..1f2b912c43d1 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -161,7 +161,7 @@ struct smc_connection {
>  
>  	struct smc_buf_desc	*sndbuf_desc;	/* send buffer descriptor */
>  	struct smc_buf_desc	*rmb_desc;	/* RMBE descriptor */
> -	int			rmbe_size_short;/* compressed notation */
> +	int                     rmbe_size_comp; /* compressed notation */

nit: spaces are used here, better to use two tabs.

>  	int			rmbe_update_limit;
>  						/* lower limit for consumer
>  						 * cursor update
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index b9b8b07aa702..c90d9e5dda54 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -1007,7 +1007,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  		clc->d0.gid =
>  			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
>  		clc->d0.token = conn->rmb_desc->token;
> -		clc->d0.dmbe_size = conn->rmbe_size_short;
> +		clc->d0.dmbe_size = conn->rmbe_size_comp;
>  		clc->d0.dmbe_idx = 0;
>  		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
>  		if (version == SMC_V1) {
> @@ -1050,7 +1050,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  			clc->r0.qp_mtu = min(link->path_mtu, link->peer_mtu);
>  			break;
>  		}
> -		clc->r0.rmbe_size = conn->rmbe_size_short;
> +		clc->r0.rmbe_size = conn->rmbe_size_comp;
>  		clc->r0.rmb_dma_addr = conn->rmb_desc->is_vm ?
>  			cpu_to_be64((uintptr_t)conn->rmb_desc->cpu_addr) :
>  			cpu_to_be64((u64)sg_dma_address
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 3f465faf2b68..6b78075404d7 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -2309,31 +2309,30 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>  	struct smc_connection *conn = &smc->conn;
>  	struct smc_link_group *lgr = conn->lgr;
>  	struct list_head *buf_list;
> -	int bufsize, bufsize_short;
> +	int bufsize, bufsize_comp;
>  	struct rw_semaphore *lock;	/* lock buffer list */
>  	bool is_dgraded = false;
> -	int sk_buf_size;
>  
>  	if (is_rmb)
>  		/* use socket recv buffer size (w/o overhead) as start value */
> -		sk_buf_size = smc->sk.sk_rcvbuf;
> +		bufsize = smc->sk.sk_rcvbuf / 2;
>  	else
>  		/* use socket send buffer size (w/o overhead) as start value */
> -		sk_buf_size = smc->sk.sk_sndbuf;
> +		bufsize = smc->sk.sk_sndbuf / 2;
>  
> -	for (bufsize_short = smc_compress_bufsize(sk_buf_size, is_smcd, is_rmb);
> -	     bufsize_short >= 0; bufsize_short--) {
> +	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
> +	     bufsize_comp >= 0; bufsize_comp--) {
>  		if (is_rmb) {
>  			lock = &lgr->rmbs_lock;
> -			buf_list = &lgr->rmbs[bufsize_short];
> +			buf_list = &lgr->rmbs[bufsize_comp];
>  		} else {
>  			lock = &lgr->sndbufs_lock;
> -			buf_list = &lgr->sndbufs[bufsize_short];
> +			buf_list = &lgr->sndbufs[bufsize_comp];
>  		}
> -		bufsize = smc_uncompress_bufsize(bufsize_short);
> +		bufsize = smc_uncompress_bufsize(bufsize_comp);
>  
>  		/* check for reusable slot in the link group */
> -		buf_desc = smc_buf_get_slot(bufsize_short, lock, buf_list);
> +		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
>  		if (buf_desc) {
>  			buf_desc->is_dma_need_sync = 0;
>  			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
> @@ -2377,8 +2376,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>  
>  	if (is_rmb) {
>  		conn->rmb_desc = buf_desc;
> -		conn->rmbe_size_short = bufsize_short;
> -		smc->sk.sk_rcvbuf = bufsize;
> +		conn->rmbe_size_comp = bufsize_comp;
> +		smc->sk.sk_rcvbuf = bufsize * 2;
>  		atomic_set(&conn->bytes_to_rcv, 0);
>  		conn->rmbe_update_limit =
>  			smc_rmb_wnd_update_limit(buf_desc->len);
> @@ -2386,7 +2385,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>  			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
>  	} else {
>  		conn->sndbuf_desc = buf_desc;
> -		smc->sk.sk_sndbuf = bufsize;
> +		smc->sk.sk_sndbuf = bufsize * 2;
>  		atomic_set(&conn->sndbuf_space, bufsize);
>  	}
>  	return 0;
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index b6f79fabb9d3..0b2a957ca5f5 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -21,6 +21,10 @@
>  
>  static int min_sndbuf = SMC_BUF_MIN_SIZE;
>  static int min_rcvbuf = SMC_BUF_MIN_SIZE;
> +static int max_sndbuf = INT_MAX / 2;
> +static int max_rcvbuf = INT_MAX / 2;
> +static const int net_smc_wmem_init = (64 * 1024);
> +static const int net_smc_rmem_init = (64 * 1024);
>  
>  static struct ctl_table smc_table[] = {
>  	{
> @@ -53,6 +57,7 @@ static struct ctl_table smc_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &min_sndbuf,
> +		.extra2		= &max_sndbuf,
>  	},
>  	{
>  		.procname	= "rmem",
> @@ -61,6 +66,7 @@ static struct ctl_table smc_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &min_rcvbuf,
> +		.extra2		= &max_rcvbuf,
>  	},
>  	{  }
>  };
> @@ -88,8 +94,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>  	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>  	net->smc.sysctl_smcr_buf_type = SMCR_PHYS_CONT_BUFS;
>  	net->smc.sysctl_smcr_testlink_time = SMC_LLC_TESTLINK_DEFAULT_TIME;
> -	WRITE_ONCE(net->smc.sysctl_wmem, READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]));
> -	WRITE_ONCE(net->smc.sysctl_rmem, READ_ONCE(net->ipv4.sysctl_tcp_rmem[1]));
> +	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
> +	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>  
>  	return 0;
>  
> -- 
> 2.41.0
