Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6ED75FC19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjGXQ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjGXQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CED710F8;
        Mon, 24 Jul 2023 09:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCFC76126E;
        Mon, 24 Jul 2023 16:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC4AC433C8;
        Mon, 24 Jul 2023 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690216147;
        bh=eF3rouZ7M3mM23J0Rl2L9y1sX3hRLIEFaylZ/RgLC50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VgK1V67Tr2QGe0sqS7IQmzXn8S+FNL+FRKUAtOH7NVI6vKQRloHgzNdv2iPXEa7y2
         SOEjgEWrxFqpgw5nMosN4T3x+LKzqajZuDXxNRsE/3vTvKYpt2z5nzDrPCEeLMS+SD
         MJh236UZyIO8NkzgUs5VrDs+WS1miMsmAw/wraIdP5h6OleYGYy93Jq6V3dpM1YaQ0
         ESQdJL9xIcjK2t1hpQmtTk0VBuPicrmcbcKw9Al+GUIvghceHvOoOIyvYIDdVHNUOl
         hztB9jmm36styQxkOp97KVF89UIXvdw26T/rfw/BwZUKUT+gkcN+P4WJbAWp8J3Bcc
         Uz1/mDvPdhkkw==
Received: (nullmailer pid 3789936 invoked by uid 1000);
        Mon, 24 Jul 2023 16:29:04 -0000
Date:   Mon, 24 Jul 2023 10:29:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: usb: qcom,dwc3: correct SDM660 clocks
Message-ID: <169021614422.3789872.6754474181715597278.robh@kernel.org>
References: <20230723141550.90223-1-krzysztof.kozlowski@linaro.org>
 <20230723141550.90223-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723141550.90223-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Jul 2023 16:15:50 +0200, Krzysztof Kozlowski wrote:
> SDM660 SoC has two instances of DWC3 USB controller: one supporting USB
> 3.0 and one supporting only up to USB 2.0.  The latter one does not use
> iface clock, so allow such variant to fix dtbs_check warnings:
> 
>   sda660-inforce-ifc6560.dtb: usb@c2f8800: clocks: [[37, 48], [37, 88], [37, 89], [37, 90]] is too short
>   sda660-inforce-ifc6560.dtb: usb@c2f8800: clock-names:2: 'iface' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 24 ++++++++++++-------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

