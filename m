Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D11757D5C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjGRNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjGRNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:24:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AE137;
        Tue, 18 Jul 2023 06:24:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8946A61591;
        Tue, 18 Jul 2023 13:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E79C433C8;
        Tue, 18 Jul 2023 13:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689686683;
        bh=H5aBA4x9IY7IMt2FxtcOdd+EhKpK0NPY4BzfgMXlekE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JC1pzFYKYxywTNgHJPt3TAzLNKBvlw8sNpl4UYPZFWIBSVw87HhCrKHeRLHEBBiVG
         SJlXe0T/8RtLssEUp9Znrw/84aF7EDFoZil82oNIzBhLexkVK7cDtXqfmWrpr7oZww
         +5u020c9/KIH3ZOeo2TNkPI2sNGg6IC3gtptg6NHqpwhvsHO0txKjlAaIK3hRENjxp
         Xv47P/t/8NovR0t/0wMpBojJaqMitNHilI8kn2Nl5tUcfPsjYyGh9tXaOFSn18kXuU
         uNVi9V7rX4KxSk1kGg/YFFTyLPbDqlckMx46wwaBp9FGosSGYdGbnygVraZOzgU2qC
         c4ZkUyibXb8Yg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qLkhA-0005Y5-0Z;
        Tue, 18 Jul 2023 15:24:52 +0200
Date:   Tue, 18 Jul 2023 15:24:52 +0200
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
Subject: Re: [PATCH 07/15] clk: qcom: gpucc-sm6115: Add runtime PM
Message-ID: <ZLaSpFFBzP_Yz5yY@hovoldconsulting.com>
References: <20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org>
 <20230717-topic-branch_aon_cleanup-v1-7-27784d27a4f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-topic-branch_aon_cleanup-v1-7-27784d27a4f4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:19:14PM +0200, Konrad Dybcio wrote:
> The GPU_CC block on SM6115 is powered by the VDD_CX rail. We need to
> ensure that it's enabled to prevent unwanted power collapse.

This bit is not correct, the power domain would not have been disabled
until you enable runtime PM as part of this very patch.

I noticed similar claims have incorrectly been made in the past, for
example, in the recent:

	2a541abd9837 clk: qcom: gcc-sc8280xp: Add runtime PM

and older:

	a91c483b42fa ("clk: qcom: videocc-sm8250: use runtime PM for the clock controller")

Johan
