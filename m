Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00FF751829
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjGMFcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjGMFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568DC119;
        Wed, 12 Jul 2023 22:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E21E661A15;
        Thu, 13 Jul 2023 05:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E74AC433C8;
        Thu, 13 Jul 2023 05:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689226326;
        bh=fVVjgsYE+Qoi+R94FE6e7lA0UTa62pQgQ545OxhcM9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZVgs6buiRTDdalbv2ZlrRBzrZfqoUiABFLs6WO1uVDx7yut6id1QniuBP9TE75Dr
         Pbv8EDd9iWXYV6T82XvUowSPK+vsALcfjN8dfgcVMnS0v/KZ/L5jW2ZWMxoqDunz6P
         pwC5sFon/w+70nR9PFTtkqhFzhjgAOGytaeDZLWJbpwXdElbWea4yRom6ReQ0Fwf6i
         0x8X4ZmeDoC654H5/Ie7a0h4yTjizDyuJ9c4d8Ew8H5bbt5pHFS3aK/Ve6/2DtCArY
         39ipOuLlQVqXDYClQhx67gLANhsT0mzDrMwGc08DqeVrDVYw3z9KqPg5GLZpGvNKV0
         H4S9YFrSwOFGg==
Date:   Thu, 13 Jul 2023 06:32:01 +0100
From:   Simon Horman <horms@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] clk: qcom: clk-rcg2: add support for rcg2 freq
 multi ops
Message-ID: <ZK+MUW55tWhOX1/i@kernel.org>
References: <20230531222654.25475-1-ansuelsmth@gmail.com>
 <20230531222654.25475-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531222654.25475-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 12:26:53AM +0200, Christian Marangi wrote:
> Some RCG frequency can be reached by multiple configuration.
> 
> Add clk_rcg2_fm_ops ops to support these special RCG configurations.
> 
> These alternative ops will select the frequency using a CEIL policy.
> 
> When the correct frequency is found, the correct config is selected by
> calculating the final rate (by checking the defined parent and values
> in the config that is being checked) and deciding based on the one that
> is less different than the requested one.
> 
> These check are skipped if there is just on config for the requested
> freq.
> 
> qcom_find_freq_multi is added to search the freq with the new struct
> freq_multi_tbl.
> __clk_rcg2_select_conf is used to select the correct conf by simulating
> the final clock.
> If a conf can't be found due to parent not reachable, a WARN is printed
> and -EINVAL is returned.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

...

> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index 76551534f10d..9a139fc8bbfa 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -266,6 +266,112 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>  	return 0;
>  }
>  
> +static const struct freq_conf *
> +__clk_rcg2_select_conf(struct clk_hw *hw, const struct freq_multi_tbl *f,
> +		       unsigned long req_rate)
> +{
> +	unsigned long rate_diff, best_rate_diff = ULONG_MAX;
> +	const struct freq_conf *conf, *best_conf;
> +	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
> +	const char *name = clk_hw_get_name(hw);
> +	unsigned long parent_rate, rate;
> +	struct clk_hw *p;
> +	int index, i;
> +
> +	/* Exit early if only one config is defined */
> +	if (f->num_confs == 1)
> +		return f->confs;
> +
> +	/* Search in each provided config the one that is near the wanted rate */
> +	for (i = 0, conf = f->confs; i < f->num_confs; i++, conf++) {
> +		index = qcom_find_src_index(hw, rcg->parent_map, conf->src);
> +		if (index < 0)
> +			continue;
> +
> +		p = clk_hw_get_parent_by_index(hw, index);
> +		if (!p)
> +			continue;
> +
> +		parent_rate =  clk_hw_get_rate(p);
> +		rate = calc_rate(parent_rate, conf->n, conf->m, conf->n, conf->pre_div);
> +
> +		if (rate == req_rate) {
> +			best_conf = conf;
> +			break;
> +		}
> +
> +		rate_diff = abs(req_rate - rate);
> +		if (rate_diff < best_rate_diff) {
> +			best_rate_diff = rate_diff;
> +			best_conf = conf;
> +		}
> +	}
> +
> +	/*
> +	 * Very unlikely. Warn if we couldn't find a correct config
> +	 * due to parent not present.
> +	 */
> +	if (unlikely(i == f->num_confs)) {
> +		WARN(1, "%s: can't find a configuration for rate %lu.",
> +		     name, req_rate);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return best_conf;

Hi Christian,

It's unclear to me if this can actually occur,
but Sparse warns that best_conf may be uninitialised here.

> +}

...
