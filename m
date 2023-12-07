Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0E808073
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjLGGCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjLGGCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:02:20 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66EB1AD;
        Wed,  6 Dec 2023 22:02:25 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vy-fHbg_1701928942;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0Vy-fHbg_1701928942)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 14:02:23 +0800
Date:   Thu, 7 Dec 2023 14:02:19 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Wen Gu <guwen@linux.alibaba.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com, ubraun@linux.ibm.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix missing byte order conversion in CLC
 handshake
Message-ID: <ZXFf69zaLFWxr5pM@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1701882157-87956-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:02:37AM +0800, Wen Gu wrote:
> The byte order conversions of ISM GID and DMB token are missing in
> process of CLC accept and confirm. So fix it.
> 
> Fixes: 3d9725a6a133 ("net/smc: common routine for CLC accept and confirm")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

LGTM.

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> ---
>  net/smc/af_smc.c  | 4 ++--
>  net/smc/smc_clc.c | 9 ++++-----
>  net/smc/smc_clc.h | 4 ++--
>  3 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index c61666e..7fc2f3c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -723,7 +723,7 @@ static void smcd_conn_save_peer_info(struct smc_sock *smc,
>  	int bufsize = smc_uncompress_bufsize(clc->d0.dmbe_size);
>  
>  	smc->conn.peer_rmbe_idx = clc->d0.dmbe_idx;
> -	smc->conn.peer_token = clc->d0.token;
> +	smc->conn.peer_token = ntohll(clc->d0.token);
>  	/* msg header takes up space in the buffer */
>  	smc->conn.peer_rmbe_size = bufsize - sizeof(struct smcd_cdc_msg);
>  	atomic_set(&smc->conn.peer_rmbe_space, smc->conn.peer_rmbe_size);
> @@ -1415,7 +1415,7 @@ static int smc_connect_ism(struct smc_sock *smc,
>  		if (rc)
>  			return rc;
>  	}
> -	ini->ism_peer_gid[ini->ism_selected] = aclc->d0.gid;
> +	ini->ism_peer_gid[ini->ism_selected] = ntohll(aclc->d0.gid);
>  
>  	/* there is only one lgr role for SMC-D; use server lock */
>  	mutex_lock(&smc_server_lgr_pending);
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 0fda515..95e19aa 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -1005,6 +1005,7 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  {
>  	struct smc_connection *conn = &smc->conn;
>  	struct smc_clc_first_contact_ext_v2x fce;
> +	struct smcd_dev *smcd = conn->lgr->smcd;
>  	struct smc_clc_msg_accept_confirm *clc;
>  	struct smc_clc_fce_gid_ext gle;
>  	struct smc_clc_msg_trail trl;
> @@ -1022,17 +1023,15 @@ static int smc_clc_send_confirm_accept(struct smc_sock *smc,
>  		memcpy(clc->hdr.eyecatcher, SMCD_EYECATCHER,
>  		       sizeof(SMCD_EYECATCHER));
>  		clc->hdr.typev1 = SMC_TYPE_D;
> -		clc->d0.gid =
> -			conn->lgr->smcd->ops->get_local_gid(conn->lgr->smcd);
> -		clc->d0.token = conn->rmb_desc->token;
> +		clc->d0.gid = htonll(smcd->ops->get_local_gid(smcd));
> +		clc->d0.token = htonll(conn->rmb_desc->token);
>  		clc->d0.dmbe_size = conn->rmbe_size_comp;
>  		clc->d0.dmbe_idx = 0;
>  		memcpy(&clc->d0.linkid, conn->lgr->id, SMC_LGR_ID_SIZE);
>  		if (version == SMC_V1) {
>  			clc->hdr.length = htons(SMCD_CLC_ACCEPT_CONFIRM_LEN);
>  		} else {
> -			clc_v2->d1.chid =
> -				htons(smc_ism_get_chid(conn->lgr->smcd));
> +			clc_v2->d1.chid = htons(smc_ism_get_chid(smcd));
>  			if (eid && eid[0])
>  				memcpy(clc_v2->d1.eid, eid, SMC_MAX_EID_LEN);
>  			len = SMCD_CLC_ACCEPT_CONFIRM_LEN_V2;
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 89b258c..1697b84 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -204,8 +204,8 @@ struct smcr_clc_msg_accept_confirm {	/* SMCR accept/confirm */
>  } __packed;
>  
>  struct smcd_clc_msg_accept_confirm_common {	/* SMCD accept/confirm */
> -	u64 gid;		/* Sender GID */
> -	u64 token;		/* DMB token */
> +	__be64 gid;		/* Sender GID */
> +	__be64 token;		/* DMB token */
>  	u8 dmbe_idx;		/* DMBE index */
>  #if defined(__BIG_ENDIAN_BITFIELD)
>  	u8 dmbe_size : 4,	/* buf size (compressed) */
> -- 
> 1.8.3.1
