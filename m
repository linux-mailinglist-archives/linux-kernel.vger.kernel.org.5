Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3834676F0F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjHCR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjHCRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:55:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E711704;
        Thu,  3 Aug 2023 10:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 168CF61E4E;
        Thu,  3 Aug 2023 17:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA11BC433C7;
        Thu,  3 Aug 2023 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691085356;
        bh=4Ld8BAA+kCjrI9UjzRHJmebdxcphDEau9AAkrxrmt0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jcEqo1ttrHtdrmdbxjI4EIrA4Rp4zLKc4mTyg0RFpWsDA49uQ2wTILEfw2qBtW9A1
         c6itAceQ7mGduut5TpowbfaNjCnBFQIRzg4EaDcdowIu4YqjpYipidJIhm7v31xk8g
         ELd2Y7l0nN3yVnQ+0gpmrAm+KdnG30Bbej04iRusdm/jqDaPDzQVQp6yC5MfZ0dkks
         GadS93Lcjq1wZ3Bm6aiwsqtKvMTJTNPGYFPltsgI75Y+9vt0W/vAfG/gPIZnKHjVLv
         LQE5ewkZ//zE8gctYXVuQetXo+5a/hJsTRWzJm1f+qoZXMIKdbdaS5btzwua7/ovlB
         FKARp59C2gjPw==
Date:   Thu, 3 Aug 2023 19:55:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc:     wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
        tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 4/6] net/smc: support max connections per
 lgr negotiation
Message-ID: <ZMvqJ6FYR6gWS+ZK@kernel.org>
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-5-guangguan.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803132422.6280-5-guangguan.wang@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:24:20PM +0800, Guangguan Wang wrote:
> Support max connections per lgr negotiation for SMCR v2.1,
> which is one of smc v2.1 features.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

...

Hi Guangguan Wang,

>  int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>  				      struct smc_init_info *ini)
>  {
> +	struct smc_clc_first_contact_ext_v2x *fce_v2x =
> +		(struct smc_clc_first_contact_ext_v2x *)fce;
> +
>  	if (ini->release_ver < SMC_RELEASE_1)
>  		return 0;
>  
> +	if (!ini->is_smcd) {
> +		if (fce_v2x->max_conns > SMC_CONN_PER_LGR_MAX)

The type of the max_cons field is u8.
The value of SMC_CONN_PER_LGR_MAX is 255 (in another patch of this series),
the maximum value that the max_cons field can be assigned.
So it seems that this condition cannot ever be true.

As flagged by Smatch.

> +			return SMC_CLC_DECL_MAXCONNERR;
> +		ini->max_conns = fce_v2x->max_conns;
> +	}
> +
>  	return 0;
>  }

...

> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h

...

> @@ -236,7 +238,8 @@ struct smc_clc_first_contact_ext {
>  
>  struct smc_clc_first_contact_ext_v2x {
>  	struct smc_clc_first_contact_ext fce_v20;
> -	u8 reserved3[4];
> +	u8 max_conns; /* for SMC-R only */
> +	u8 reserved3[3];
>  	__be32 vendor_exp_options;
>  	u8 reserved4[8];
>  } __packed;		/* format defined in

...

> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 1a97fef39127..065369dc6584 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -22,6 +22,7 @@
>  #include "smc_ib.h"
>  
>  #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
> +#define SMC_CONN_PER_LGR_MAX	255	/* max. # of connections per link group */
>  
>  struct smc_lgr_list {			/* list of link group definition */
>  	struct list_head	list;
