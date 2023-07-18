Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55183757D73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGRN1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjGRN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:27:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96267126;
        Tue, 18 Jul 2023 06:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC4361585;
        Tue, 18 Jul 2023 13:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9BDC433C7;
        Tue, 18 Jul 2023 13:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686831;
        bh=3YW/KjszKYzVW7m/iuNTze8VrSliNp0LOZ9DLIsTcPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DCSqxnny6+1a6VhvBmCm2zrhNVFk9SfCvq0hRu+itMsvyoPQ7+BzT225O0glNtwNU
         FguPLhYspRgh2byJdwYrfiArKZI5AOK+XBmQbH2kgb4Nt8nVTZNgg9qdrH9VZLL//9
         Bh3TMkDsTIiR1GlihSUCc7xrJRtVtAaaal8vwIwV9x4gRLjcFic1d6rfwS23t5+s9r
         0mUo9YFvEkaNMJANkXdLBNjmUKzvhbIxa0RprEoa65gpVT74mjdnRTrIYPA63lWr+5
         gOAPt8qrQGekLG9jCcNklkWBtMpQNJK0djZ4UWQwLQSo8955Ktw/99ZkC5bTs2q9lS
         PewQZCO8AbVgQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLkjY-0005Yk-1Z;
        Tue, 18 Jul 2023 15:27:20 +0200
Date:   Tue, 18 Jul 2023 15:27:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 04/15] clk: qcom: gcc-sm6375: Add runtime PM
Message-ID: <ZLaTOJvtyEWnN1Av@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-4-27784d27a4f4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:11PM +0200, Konrad Dybcio wrote:
> The GCC block on SM6375 is powered by the VDD_CX rail. We need to ensure
> that it's enabled to prevent unwanted power collapse.

This bit is not correct either (and similar throughout the series).

> Enable runtime PM to keep the power flowing only when necessary.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
>  	regmap = qcom_cc_map(pdev, &gcc_sm6375_desc);
> -	if (IS_ERR(regmap))
> +	if (IS_ERR(regmap)) {
> +		pm_runtime_put(&pdev->dev);
>  		return PTR_ERR(regmap);
> +	}
>  
>  	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks, ARRAY_SIZE(gcc_dfs_clocks));
>  	if (ret)

Looks like you forgot to update this error path.

> @@ -3817,7 +3828,10 @@ static int gcc_sm6375_probe(struct platform_device *pdev)
>  	clk_lucid_pll_configure(&gpll8, regmap, &gpll8_config);
>  	clk_zonda_pll_configure(&gpll9, regmap, &gpll9_config);
>  
> -	return qcom_cc_really_probe(pdev, &gcc_sm6375_desc, regmap);
> +	ret = qcom_cc_really_probe(pdev, &gcc_sm6375_desc, regmap);
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;

Johan
