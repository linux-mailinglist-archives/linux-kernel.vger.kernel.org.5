Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CFF752FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbjGNDQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjGNDQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434E269D;
        Thu, 13 Jul 2023 20:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EEE261BDC;
        Fri, 14 Jul 2023 03:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168F5C433C8;
        Fri, 14 Jul 2023 03:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689304605;
        bh=e0i15wf+juQwjhj8xsVBTzQPejbjMVB43hjyJlpR3+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UbuR3nTRpwIexQVOtZD4uEfYnY+WDhU0xWsLcySwYa1GkdrJ0mTJ8bAgTQhrWu0dB
         XM7kY9iIbeSmepk4moiR8ELNTbJSttE7FPQhlcJk2Ljn9bMvB328FdwjK7Ai9oelQM
         gLJ4PFxHEo0v0PMdftqYlcPg/PylC+gicqBI+xVp5ut13a5FEvCNTBsdM5B3foBRnr
         WRPF62xlmut6RlOTsm/XAIzerTMZP4Pq7kFpci6jmlaIMucDj1a7/X9ZT06An9XUCs
         bmqkPp4j7QrtVGqkmDNeglawAR6FNaa0jv8ML3YoODrywmMpmN2mGTOOx7mZR01pmy
         8Ov6Ye56RZapQ==
Date:   Thu, 13 Jul 2023 20:20:15 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: document extcon property
Message-ID: <k3szwvlfadcymr6yfxln7hsm4vcym6wauglhmkbhekrvnzuqvn@pygu7iybuldl>
References: <20230712235902.98557-1-david@ixit.cz>
 <84d88d8b-25a1-9b0f-d779-325d048909b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d88d8b-25a1-9b0f-d779-325d048909b7@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 08:37:55AM +0200, Krzysztof Kozlowski wrote:
> On 13/07/2023 01:59, David Heidelberg wrote:
> > The driver has support for it already. Only missing bit is dt-binding entry.
> 
> No, because the child node already has it. We do not need to extcons for
> one USB. Also another reason is that it should be deprecated.
> 

In the current design of the Linux dwc3 driver we actually need both
nodes to be extcon targets, as both device drivers needs to react to the
role change. So I think the patch accurately describes the intended
design of today.

That said, we do not want to do this for the Type-C case, where we use a
full port node. Combined with other reasons, we really should fix the
dwc3 driver model so that the core propagates the role changes to the
glue drivers, and as such I agree that we shouldn't pick this patch.

Regards,
Bjorn
