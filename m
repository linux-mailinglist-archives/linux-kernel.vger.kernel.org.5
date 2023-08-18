Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82078046D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357577AbjHRD0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357565AbjHRD0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:26:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A573A8B;
        Thu, 17 Aug 2023 20:26:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A48362F7E;
        Fri, 18 Aug 2023 03:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E00C433C8;
        Fri, 18 Aug 2023 03:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692329189;
        bh=hTg4Udjkb0FLmpaBggFGuLREBebvjcLcNS4EAGXq/pc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C/1jkKGf6Sg8nkF2+a2WQb46g+QC+ULzaqnnDAkaTCTeffzPqR1sgC5Apc7ndl/f1
         KOU8i37lieLCJ9fXbtpJd/pH7EQp+F9v45+wfDI2gMOs752cpCw3Il51ccr8lVYTKL
         VGHF2Sgyb1hj/qOoPJ1lHM4lXjvfL7mrKAmyP9NLfOh3MROchoN6SK56mA9lAqSj05
         p0PXcFFlAiIEjzMdf/kkvvosc43rzZY6i4CaVxhPZkQtmkJedgB54zCBQezMERhmXX
         wgWHEHbYHQ0iUdxkWxcNgeNuMmyvS63IcDxeNSUuMRmZ+jueM5/g1yIdhTQGiKJZ9A
         OgKCvy4p9F+fA==
Date:   Thu, 17 Aug 2023 20:29:10 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v4 1/4] clk: qcom: branch: Add clk_branch2_mdio_ops
Message-ID: <p7m4fi53nc75rjnmxdrukaitaddvq4vgvpydiyjmem4g2leyih@uohiocu35w2u>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815085205.9868-2-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:52:02PM +0800, Luo Jie wrote:
> Add the clk_branch2_mdio_ops for supporting clock controller
> where the hardware register is accessed by MDIO bus, and the
> spin clock can't be used because of sleep during the MDIO

spin clock?

I believe you're trying to say that the underlying access to the MDIO
bus can not be done in non-sleepable context and we can therefor not use
enable/disable to operate it?

> operation.
> 
> The clock is enabled by the .prepare instead of .enable when
> the clk_branch2_mdio_ops is used.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/clk-branch.c | 7 +++++++
>  drivers/clk/qcom/clk-branch.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
> index fc4735f74f0f..5e08c026ca4a 100644
> --- a/drivers/clk/qcom/clk-branch.c
> +++ b/drivers/clk/qcom/clk-branch.c
> @@ -153,3 +153,10 @@ const struct clk_ops clk_branch_simple_ops = {
>  	.is_enabled = clk_is_enabled_regmap,
>  };
>  EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
> +
> +const struct clk_ops clk_branch2_mdio_ops = {
> +	.prepare = clk_branch2_enable,
> +	.unprepare = clk_branch2_disable,

I see none of the clocks specify halt_check, which would imply that
these two calls just turns into clk_enable_regmap() and
clk_disable_regmap().

So, isn't this then equivalent to clk_branch_simple_ops?

Regards,
Bjorn

> +	.is_prepared = clk_is_enabled_regmap,
> +};
> +EXPORT_SYMBOL_GPL(clk_branch2_mdio_ops);
> diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
> index 0cf800b9d08d..4b006e8eec5e 100644
> --- a/drivers/clk/qcom/clk-branch.h
> +++ b/drivers/clk/qcom/clk-branch.h
> @@ -85,6 +85,7 @@ extern const struct clk_ops clk_branch_ops;
>  extern const struct clk_ops clk_branch2_ops;
>  extern const struct clk_ops clk_branch_simple_ops;
>  extern const struct clk_ops clk_branch2_aon_ops;
> +extern const struct clk_ops clk_branch2_mdio_ops;
>  
>  #define to_clk_branch(_hw) \
>  	container_of(to_clk_regmap(_hw), struct clk_branch, clkr)
> -- 
> 2.17.1
> 
