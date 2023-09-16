Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A67A3106
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjIPPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIPPGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 11:06:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F6CC9
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 08:06:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0675C433C7;
        Sat, 16 Sep 2023 15:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694876763;
        bh=LdwNM+hoVxGLKL8aspvRzHcYJa2o3pYdJ7X5XMKj9Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pa2ejGixJU/CeiUgyPXJ/HWjE4zIfIeGOMImJntAch1cRsfQBWqnE+WlryVn9hipp
         ECwj/HGmE0613mT3jSGqw/l2OmoiaiDNiDxae2uSaqQiyqUKPgCpNQpueDIIsIKqBf
         Jk7MbU+Iqa6p+YPHBMV6I9AEg+wdypMusllItwffOhm00C5PNcn9IxbYYUCXM79dQH
         rn+IIVfyh9Qu01uX8lYbDTH5eacsrAIfqojHip1kRl9CD7AIY+ThxAXLJs9LiibBAm
         EamLdr1wrxAUlORyiJD9Pkvzl9xEVmqQuFHaVxryZSNCr7+jr8IKyn1YHMr9bSw/JF
         znTHP4bCn+jxA==
Date:   Sat, 16 Sep 2023 17:05:58 +0200
From:   Simon Horman <horms@kernel.org>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, edumazet@google.com,
        pabeni@redhat.com
Subject: Re: [net-next Patch] octeontx2-pf: Tc flower offload support for MPLS
Message-ID: <20230916150558.GD1125562@kernel.org>
References: <20230914110655.31222-1-hkelam@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914110655.31222-1-hkelam@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:36:55PM +0530, Hariprasad Kelam wrote:

...

> @@ -738,6 +741,57 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
>  		}
>  	}
>  
> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_MPLS)) {
> +		struct flow_match_mpls match;
> +		u8 bit;
> +
> +		flow_rule_match_mpls(rule, &match);
> +
> +		if (match.mask->used_lses & OTX2_UNSUPP_LSE_DEPTH) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "unsupported LSE depth for MPLS match offload");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		for_each_set_bit(bit, (unsigned long *)&match.mask->used_lses,
> +				 FLOW_DIS_MPLS_MAX)  {
> +			/* check if any of the fields LABEL,TC,BOS are set */
> +			if (*((u32 *)&match.mask->ls[bit]) & 0xffffff00) {

Hi Hariprasad,

I wonder if we could avoid using the magic number 0xffffff00 above.
Perhaps ~MPLS_LS_TTL_MASK is appropriate?

Otherwise this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...
