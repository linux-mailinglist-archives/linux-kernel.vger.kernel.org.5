Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB67F19CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjKTR0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjKTR0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:26:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532F685
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700501192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8aUUxFA022YpgE+kgLKSfCpFEiyXZX3VeVuIGH9hlI=;
        b=WvRbs6Vd1SYjXrPeUvUa6tQgi5A5Fw/4Y7ojGZ99MWxv+KehrR39bYzoItN32eBuf+8KTU
        JooxB/9bBGR+hSCcUBquxIcYpS0owN5JwUoQj2rumPdzhVwXmvMlLHDkOymhbnYYsk9c4h
        umqbRwuz7FDum8fwe472G3i0fN1yjdg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-BNBrxE3vNPubdByL55sHPA-1; Mon, 20 Nov 2023 12:26:30 -0500
X-MC-Unique: BNBrxE3vNPubdByL55sHPA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d120c28afso32883686d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700501189; x=1701105989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8aUUxFA022YpgE+kgLKSfCpFEiyXZX3VeVuIGH9hlI=;
        b=gK+vlYc5CoXKpVqtJMJI9kUjtwf8/3ylneQZuzbWoMc7vDa/5D5nLRWWU/X9l8hFwS
         0hCtC3oqfZh4OAdavuI7/fhW90oHOp5cQJkBrJafTTa//3YJXvKsTPrQdIPvGjao1Cxi
         iY0SPNE5GSgHRuELIucTbtV10j5EyzZG5N60CHNku2SzRvtZ28H8L4z1sYf/fdCZh6Jb
         q1AsUX/taws7d3mcfWnRcpnCAvCOBjCH7U03ZeZdeY8KntnFHYmY46fMc/+GA8TlScDX
         YWMwELaCh0eohlDxCRegomDBC8oB9MiINeBl6mJcpSGd3w1uMRgn33fgfuo6KFDoK8l9
         hQZg==
X-Gm-Message-State: AOJu0YyQBq6gR0gpowRCY9e7dV0KhDH6Gb4KFoZ03Wqqp//JHKjWp4qh
        o7q7kZWLURu92YIw1VnVqquu69c6dxQPKZMhVaayUEThqlkHVnJU+R/65tSKuCrZ/7SLHh8uoVD
        62736osN8G1gVg/TGYFlQGUt4fxPy9hMJ
X-Received: by 2002:a0c:f002:0:b0:66d:a301:e512 with SMTP id z2-20020a0cf002000000b0066da301e512mr8464884qvk.27.1700501189537;
        Mon, 20 Nov 2023 09:26:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8NqbXBCHlBTFyU0Oqc4To/gML4pdGHQ6PKI1u0iGxOpMLI/CuYR9Se7qPqoa8FdpAn03q6g==
X-Received: by 2002:a0c:f002:0:b0:66d:a301:e512 with SMTP id z2-20020a0cf002000000b0066da301e512mr8464860qvk.27.1700501189287;
        Mon, 20 Nov 2023 09:26:29 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id e15-20020a0cd64f000000b00674a45499dcsm3056221qvj.88.2023.11.20.09.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:26:28 -0800 (PST)
Date:   Mon, 20 Nov 2023 11:26:26 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Subject: Re: [PATCH 02/11] arm64: dts: qcom: sa8775p: fix USB wakeup
 interrupt types
Message-ID: <ow6hw44aqmi2gw4bnqa363jidmyoxhuzpasy4xg4c5a34brpmo@puehdmcibmfh>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <20231120164331.8116-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120164331.8116-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:43:22PM +0100, Johan Hovold wrote:
> The DP/DM wakeup interrupts are edge triggered and which edge to trigger
> on depends on use-case and whether a Low speed or Full/High speed device
> is connected.
> 
> Note that only triggering on rising edges can be used to detect resume
> events but not disconnect events.
> 
> Fixes: de1001525c1a ("arm64: dts: qcom: sa8775p: add USB nodes")
> Cc: Shazad Hussain <quic_shazhuss@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index b6a93b11cbbd..4b42a329460c 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -1610,8 +1610,8 @@ usb_0: usb@a6f8800 {
>  			assigned-clock-rates = <19200000>, <200000000>;
>  
>  			interrupts-extended = <&intc GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&pdc 14 IRQ_TYPE_EDGE_RISING>,
> -					      <&pdc 15 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 15 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 12 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "pwr_event",
>  					  "dp_hs_phy_irq",
> @@ -1697,8 +1697,8 @@ usb_1: usb@a8f8800 {
>  			assigned-clock-rates = <19200000>, <200000000>;
>  
>  			interrupts-extended = <&intc GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&pdc 8 IRQ_TYPE_EDGE_RISING>,
> -					      <&pdc 7 IRQ_TYPE_EDGE_RISING>,
> +					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 7 IRQ_TYPE_EDGE_BOTH>,
>  					      <&pdc 13 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "pwr_event",
>  					  "dp_hs_phy_irq",
> @@ -1760,8 +1760,8 @@ usb_2: usb@a4f8800 {
>  			assigned-clock-rates = <19200000>, <200000000>;
>  
>  			interrupts-extended = <&intc GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> -					      <&pdc 10 IRQ_TYPE_EDGE_RISING>,
> -					      <&pdc 9 IRQ_TYPE_EDGE_RISING>;
> +					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
>  			interrupt-names = "pwr_event",
>  					  "dp_hs_phy_irq",
>  					  "dm_hs_phy_irq";
> -- 
> 2.41.0
> 
> 

