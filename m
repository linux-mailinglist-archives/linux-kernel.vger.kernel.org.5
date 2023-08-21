Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8590E783159
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHUTb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjHUTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:31:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A56691;
        Mon, 21 Aug 2023 12:31:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B67860C21;
        Mon, 21 Aug 2023 19:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDB4C433C8;
        Mon, 21 Aug 2023 19:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692646315;
        bh=F6NwPwXvHCMNXVk89zgd0KudbXMPo7G10BPfgRaFtNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QKGIR0DuvyWjH3ADMwA+fycZ8teWe0MUP2gsoSfPMNIrpTJU3m0WF46DAS3+vajza
         uPGhjJZ2QQ7SRU6L6ZGIQ+l0ReTMnD2uVC0v6SS8zylEk2Em6Nj6kTfgQL5rRR9yTI
         W/YGbczechGBkG9CQhzpxggt/GMPrfXqy7jhTzUUqFIQ3GscMAlHQfBqZnrMVcj5jX
         Dwx1mdowZDVnTFhWpeHVySon/4lQjuC/Gm9v6GMInBvAYBKvVvnvpU3iIvsyq0FT0X
         ux/VKFR1C32Qvfci9B5sHDLMTJQ5/h6JwN6qWkyJDsx0lLRTN0sDTSmGOJPmT3jSgp
         BeiTsy1nIUP9w==
Received: (nullmailer pid 2162007 invoked by uid 1000);
        Mon, 21 Aug 2023 19:31:52 -0000
Date:   Mon, 21 Aug 2023 14:31:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        computersforpeace@gmail.com
Subject: Re: [PATCH v2 1/5] dt-bindings: firmware: qcom,scm: Document SDI
 disable
Message-ID: <20230821193152.GA2157670-robh@kernel.org>
References: <20230815140030.1068590-1-robimarko@gmail.com>
 <83cc4b10-34bf-ea91-7756-f345c0071479@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83cc4b10-34bf-ea91-7756-f345c0071479@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:15:54AM +0200, Krzysztof Kozlowski wrote:
> On 15/08/2023 15:59, Robert Marko wrote:
> > IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> > means that WDT being asserted or just trying to reboot will hang the board
> > in the debug mode and only pulling the power and repowering will help.
> > Some IPQ4019 boards like Google WiFI have it enabled as well.
> > 
> > So, lets add a boolean property to indicate that SDI should be disabled.
> > 
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > index 4233ea839bfc..bf753192498a 100644
> > --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> > @@ -89,6 +89,14 @@ properties:
> >        protocol to handle sleeping SCM calls.
> >      maxItems: 1
> >  
> > +  qcom,sdi-disable:
> 
> The property should describe rather current hardware/firmware state,
> instead of expressing your intention for OS what to do. Therefore rather:
> qcom,sdi-enabled
> or
> qcom,secure-debug-image

Why can't you just disable SDI unconditionally when going into debug 
mode? Is doing that when not enabled going to crash the system or 
something?

Rob

