Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C96477E1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245331AbjHPMuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbjHPMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:49:38 -0400
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [IPv6:2001:41d0:1004:224b::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944CB270D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 05:49:19 -0700 (PDT)
Message-ID: <5421115a-a8d0-0eae-78b1-a2c5977e2ba1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692190155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z0Ig5nxkqFBnmZKSAywmHRcxc65yB50Vvosgp1iux4=;
        b=xGA7jFj5Gs4zr1A4tnJqZ5lclNfr7RAeFbNOStciN9UwrVtBt4GilxsJbsay1cv1p3ZSlb
        GSAzG4AD3OKPF/TZL+VzNAFVqbYkr97Bst+dAJ6/8YvXoRjJpx/wzNG4kdeqhCl+uFNZMk
        BNpFUjGwllUh++IrNzunzduC1yxgyIQ=
Date:   Wed, 16 Aug 2023 13:49:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/6] net/smc: support smc v2.x features validate
Content-Language: en-US
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 09:33, Guangguan Wang wrote:
> Support SMC v2.x features validate for SMC v2.1. This is the frame
> code for SMC v2.x features validate, and will take effects only when
> the negotiated release version is v2.1 or later.
> 
> For Server, v2.x features' validation should be done in smc_clc_srv_
> v2x_features_validate when receiving v2.1 or later CLC Proposal Message,
> such as max conns, max links negotiation, the decision of the final
> value of max conns and max links should be made in this function.
> And final check for server when receiving v2.1 or later CLC Confirm
> Message should be done in smc_clc_v2x_features_confirm_check.
> 
> For client, v2.x features' validation should be done in smc_clc_cli_
> v2x_features_validate when receiving v2.1 or later CLC Accept Message,
> for example, the decision to accpt the accepted value or to decline
> should be made in this function.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>   net/smc/af_smc.c  | 18 ++++++++++++++++++
>   net/smc/smc_clc.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>   net/smc/smc_clc.h |  7 +++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 7b54c153bd0d..65c02b48331f 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1169,6 +1169,7 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   	struct smc_clc_first_contact_ext *fce =
>   		(struct smc_clc_first_contact_ext *)
>   			(((u8 *)clc_v2) + sizeof(*clc_v2));
> +	int rc;
>   
>   	if (!ini->first_contact_peer || aclc->hdr.version == SMC_V1)
>   		return 0;
> @@ -1189,6 +1190,9 @@ static int smc_connect_rdma_v2_prepare(struct smc_sock *smc,
>   	}
>   
>   	ini->release_nr = fce->release;
> +	rc = smc_clc_cli_v2x_features_validate(fce, ini);
> +	if (rc)
> +		return rc;
>   
>   	return 0;
>   }
> @@ -1363,6 +1367,9 @@ static int smc_connect_ism(struct smc_sock *smc,
>   				smc_get_clc_first_contact_ext(aclc_v2, true);
>   
>   			ini->release_nr = fce->release;
> +			rc = smc_clc_cli_v2x_features_validate(fce, ini);
> +			if (rc)
> +				return rc;
>   		}
>   
>   		rc = smc_v2_determine_accepted_chid(aclc_v2, ini);
> @@ -2413,6 +2420,10 @@ static void smc_listen_work(struct work_struct *work)
>   	if (rc)
>   		goto out_decl;
>   
> +	rc = smc_clc_srv_v2x_features_validate(pclc, ini);
> +	if (rc)
> +		goto out_decl;
> +
>   	mutex_lock(&smc_server_lgr_pending);
>   	smc_close_init(new_smc);
>   	smc_rx_init(new_smc);
> @@ -2445,6 +2456,13 @@ static void smc_listen_work(struct work_struct *work)
>   		goto out_decl;
>   	}
>   
> +	rc = smc_clc_v2x_features_confirm_check(cclc, ini);
> +	if (rc) {
> +		if (!ini->is_smcd)
> +			goto out_unlock;
> +		goto out_decl;
> +	}
> +
>   	/* finish worker */
>   	if (!ini->is_smcd) {
>   		rc = smc_listen_rdma_finish(new_smc, cclc,
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 624dc970d187..f71b22e50be5 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -1158,6 +1158,52 @@ int smc_clc_send_accept(struct smc_sock *new_smc, bool srv_first_contact,
>   	return len > 0 ? 0 : len;
>   }
>   
> +int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> +				      struct smc_init_info *ini)
> +{
> +	struct smc_clc_v2_extension *pclc_v2_ext;
> +
> +	if ((!(ini->smcd_version & SMC_V2) && !(ini->smcr_version & SMC_V2)) ||
> +	    ini->release_nr < SMC_RELEASE_1)
> +		return 0;
> +
> +	pclc_v2_ext = smc_get_clc_v2_ext(pclc);
> +	if (!pclc_v2_ext)
> +		return SMC_CLC_DECL_NOV2EXT;
> +
> +	return 0;
> +}
> +
> +int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> +				      struct smc_init_info *ini)
> +{
> +	if (ini->release_nr < SMC_RELEASE_1)
> +		return 0;
> +
> +	return 0;
> +}

This function always returns 0. Is it really what expected?

> +
> +int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
> +				       struct smc_init_info *ini)
> +{
> +	struct smc_clc_msg_accept_confirm_v2 *clc_v2 =
> +		(struct smc_clc_msg_accept_confirm_v2 *)cclc;
> +	struct smc_clc_first_contact_ext *fce =
> +		smc_get_clc_first_contact_ext(clc_v2, ini->is_smcd);
> +
> +	if (cclc->hdr.version == SMC_V1 ||
> +	    !(cclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK))
> +		return 0;
> +
> +	if (ini->release_nr != fce->release)
> +		return SMC_CLC_DECL_RELEASEERR;
> +
> +	if (fce->release < SMC_RELEASE_1)
> +		return 0;
> +
> +	return 0;
> +}
> +
>   void smc_clc_get_hostname(u8 **host)
>   {
>   	*host = &smc_hostname[0];
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 6133276a8839..66932bfdc6d0 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -45,6 +45,7 @@
>   #define SMC_CLC_DECL_NOSEID	0x03030006  /* peer sent no SEID	      */
>   #define SMC_CLC_DECL_NOSMCD2DEV	0x03030007  /* no SMC-Dv2 device found	      */
>   #define SMC_CLC_DECL_NOUEID	0x03030008  /* peer sent no UEID	      */
> +#define SMC_CLC_DECL_RELEASEERR	0x03030009  /* release version negotiate failed */
>   #define SMC_CLC_DECL_MODEUNSUPP	0x03040000  /* smc modes do not match (R or D)*/
>   #define SMC_CLC_DECL_RMBE_EC	0x03050000  /* peer has eyecatcher in RMBE    */
>   #define SMC_CLC_DECL_OPTUNSUPP	0x03060000  /* fastopen sockopt not supported */
> @@ -415,6 +416,12 @@ int smc_clc_send_confirm(struct smc_sock *smc, bool clnt_first_contact,
>   			 u8 version, u8 *eid, struct smc_init_info *ini);
>   int smc_clc_send_accept(struct smc_sock *smc, bool srv_first_contact,
>   			u8 version, u8 *negotiated_eid, struct smc_init_info *ini);
> +int smc_clc_srv_v2x_features_validate(struct smc_clc_msg_proposal *pclc,
> +				      struct smc_init_info *ini);
> +int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
> +				      struct smc_init_info *ini);
> +int smc_clc_v2x_features_confirm_check(struct smc_clc_msg_accept_confirm *cclc,
> +				       struct smc_init_info *ini);
>   void smc_clc_init(void) __init;
>   void smc_clc_exit(void);
>   void smc_clc_get_hostname(u8 **host);

