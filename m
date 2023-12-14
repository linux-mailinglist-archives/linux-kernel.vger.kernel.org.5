Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F707812CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443595AbjLNKPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443594AbjLNKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:15:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2695110E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:15:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7537C433C7;
        Thu, 14 Dec 2023 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702548938;
        bh=spD0AcUmHxYeiPYt/c3JhN1YM2jl2kjLtal2py7KBa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+HvtCwnirQYqb0XbaZZISMF+cDLc/3vjA3UQTYQWPiM7Z67oMaX0TSMyybRQUwo3
         VoH80XOrwpYpM+tma/YD2DjOzL/RnPF419qSrGIM82tSHG+nRcI7xozewZKviSs9Mz
         RviVxNHT93s54OVcbGMkNUd+iiZUqIHuENqCtp6poC8CenDJLteveEAlVHawyyIctM
         hnaWuLkLsiVCRH4oYptbvCWKi0GoRzUO9UQglIKK4wl0Z41N4h8U2umipGVKOiHQAp
         wsqaBvgwqL/97KOepDh8TFUqA1+V8DLB8sRkUMQNDpQLrO8O98TyEqXdH9XFg/BvwY
         quC3+8ZE6Sdew==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDikg-0007zX-34;
        Thu, 14 Dec 2023 11:15:35 +0100
Date:   Thu, 14 Dec 2023 11:15:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 00/16] Fix Qcom UFS PHY clocks
Message-ID: <ZXrVxmxY6wZprbBa@hovoldconsulting.com>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 02:40:45PM +0530, Manivannan Sadhasivam wrote:

> This series fixes the clocks supplied to QMP PHY IPs in the Qcom SoCs. All
> of the Qcom SoCs except MSM8996 require 3 clocks for QMP UFS:
> 
> * ref - 19.2MHz reference clock from RPM/RPMh
> * ref_aux - Auxiliary reference clock from GCC
> * qref - QREF clock from GCC or TCSR (TCSR since SM8550)
> 
> MSM8996 only requires 'ref' and 'qref' clocks.
> 
> Hence, this series fixes the binding, DT and GCC driver to reflect the
> actual clock topology.

Is this based on documentation for all the SoCs or on inference from the
current (upstream and downstream) devicetrees?

Are you sure that you should not just describe that some of these UFS
reference clocks are sourced from CXO in the clock driver instead?

Take a look at commits

	f446022b932a ("arm64: dts: qcom: sc8280xp: fix UFS reference clocks")
	f6abcc21d943 ("clk: qcom: gcc-sc8280xp: add cxo as parent for three ufs ref clks")

Johan
