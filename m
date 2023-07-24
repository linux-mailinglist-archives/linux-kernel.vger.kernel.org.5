Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB4C75FBE9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGXQYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGXQYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EB690;
        Mon, 24 Jul 2023 09:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B90A66124A;
        Mon, 24 Jul 2023 16:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF91C433C8;
        Mon, 24 Jul 2023 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690215862;
        bh=6NGzDJNu/uN9rHgETSJqMjm2aZhAn1+hlsqguz+TxYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlciR1IC/iFXisfN79U+eBJ7EOQq0RaK9uZFbmi+HWWrrFhU+G1WHkw0tiZcq9sbk
         xmFzlwCmY//YuageHq76Za2GZ8mnadQNoMHVsHe+uXVYLpYFboo+tGbEKcA8zHHX65
         980/5SLR1ay+DllILY7dMNOteTRWxjD4y/YNaK9udiDYuyiKXjxDIYpknBOf91oT7i
         EGRfX2NMeIAEHxJmGrvm7F/OmmU+rExNvmnTR2kjMPxPNEeA96txM2ZzWn7BTyq2HH
         XusXruOcez2uLVSvQg7fAMCjyjLqWLd9nkjzzDGOCXcAzChbJq8dbBR66S43G1Q8d7
         nIAOdxUXSJi+A==
Received: (nullmailer pid 3775609 invoked by uid 1000);
        Mon, 24 Jul 2023 16:24:19 -0000
Date:   Mon, 24 Jul 2023 10:24:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 1/3] media: dt-bindings: samsung,exynos4212-fimc-is:
 replace duplicate pmu node with phandle
Message-ID: <169021585853.3775371.15388589164520572622.robh@kernel.org>
References: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230722115441.139628-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Jul 2023 13:54:39 +0200, Krzysztof Kozlowski wrote:
> The FIMC IS camera must access the PMU (Power Management Unit) IO memory
> to control camera power.  This was achieved by duplicating the PMU node
> as its child like:
> 
>   soc@0 {
>     system-controller@10020000 { ... }; // Real PMU
> 
>     camera@11800000 {
>       fimc-is@12000000 {
>         // FIMC IS camera node
>         pmu@10020000 {
>           reg = <0x10020000 0x3000>; // Fake PMU node
>         };
>       };
>     };
>   };
> 
> This is not a correct representation of the hardware.  Mapping the PMU
> (Power Management Unit) IO memory should be via syscon-like phandle
> (samsung,pmu-syscon, already used for other drivers), not by duplicating
> "pmu" Devicetree node inside the FIMC IS.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../media/samsung,exynos4212-fimc-is.yaml         | 15 ++++++++++-----
>  .../devicetree/bindings/media/samsung,fimc.yaml   |  5 +----
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

