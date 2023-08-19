Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F2F7816E2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 04:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244518AbjHSCwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 22:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244993AbjHSCvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 22:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3774483;
        Fri, 18 Aug 2023 19:51:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 805F562CDF;
        Sat, 19 Aug 2023 02:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC656C433C7;
        Sat, 19 Aug 2023 02:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692413502;
        bh=pu8/O9c9zUV2oFoSmG7ZcjZiu3WqPhY5TTBh5CKL45o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1c7N9XVEjHqk28IQ1lr8j6SYbeus1K7IRbPSickduxqUdAU8bwkXTuvDaf88RCQJ
         R/I4gs5DcOVFZUwd+V24RZpmmA1n9bHq3o6hSfIZFYk0jEBPQ3hTqR5M31xCAu6M00
         e1s0TZGY7KELvHh34Ti/RyqblrvwIW/TBMK6/pp68+fQLXHLqvXgj452U/Ffe7Gg7E
         gX1+XQHNaR5G7JljaWf65Cw8vETarOb50qri3IZtX3cF/m5Oc1NoO+huX+X2n1nBRq
         9zFtrZ/OtT8wJqofmT3z6qf75ZTz9zXxgQNO15WkSEGpQiypQdkQy4XbXBTy1piYim
         GiH3A7oyvFvgQ==
Date:   Fri, 18 Aug 2023 19:54:22 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v4 3/4] clk: qcom: common: add _qcom_cc_really_probe
Message-ID: <4n3vqstyhknanmzx4swwjg4ueaqq2tbrxadnyrx3bchffyf7qr@yh4bik4rfsgm>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-4-quic_luoj@quicinc.com>
 <2dcu7jjwd2bhjbzxrxbfif566nupznb5n4oadnqha4h45w2n2g@4uy2pxkj5bvj>
 <6ee2129b-04c6-4978-03d6-835e3a10e665@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ee2129b-04c6-4978-03d6-835e3a10e665@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 04:35:52PM +0800, Jie Luo wrote:
> On 8/18/2023 11:14 AM, Bjorn Andersson wrote:
> > On Tue, Aug 15, 2023 at 04:52:04PM +0800, Luo Jie wrote:
[..]
> > > +int qcom_cc_really_probe(struct platform_device *pdev,
> > > +			 const struct qcom_cc_desc *desc, struct regmap *regmap)
> > 
> > Why do we want to keep this wrapper around?
> > 
> There are many existed clock controller drivers using this wrapper
> qcom_cc_really_probe, so i still keep this wrapper.
> 
> do we need to remove this wrapper and update the existed drivers to use
> _qcom_cc_really_probe?

Yes please. The additional API does not add value, but can be confusing,
so let's invest the extra time in fixing up all the drivers to keep the
interface clean.

Regards,
Bjorn
