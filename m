Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778A9773169
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHGVm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjHGVmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7251986
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691444522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egEfNuDCQsLqKROh2lnl9MKou5WUYr7YaYDQH/tE4LI=;
        b=Ab+beWyNqlQ50iBqUEbFJrZ9DRCXRWp5GJKT9tMX8RUF7Q416V/gTp4GRoMLPoL6oTCKUX
        nsPVZD+lTNCFBFpNsiMDJGEm/4wG+gbaOvl7iikL6DYsp0/WH/QzwsEIGf2s3KgAV3ZZus
        YiAQbF0sVQlWOvCtFObnUpZ1GHvupZg=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-D0vd0ZTpN3qr4vSXXdDE6g-1; Mon, 07 Aug 2023 17:42:01 -0400
X-MC-Unique: D0vd0ZTpN3qr4vSXXdDE6g-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-56d5f4f4e25so4812361eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:42:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691444520; x=1692049320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egEfNuDCQsLqKROh2lnl9MKou5WUYr7YaYDQH/tE4LI=;
        b=B78cte0xsNAs0vUHI5evxCDA8kHxCrHOpcCHCxGwtxawLg34PvdeC7pJQR8iu6KZe7
         daa8xR7gM02iA8QiN2VL0pzv72VECBAG6bvQ15aPl7tfyeHhZAFN6YFjrHC5JmLWZC31
         VaoZNQBo4bX9Ua0/FmOVrTO3XN93kGU5acv3C2iREAhUWfN5SA+9NkO+P9fzAeow4CLO
         5hoSxRe8xSDsqOJZEMmMSpYGt9p3fV+ZoCbIdFabXxlBdj+Q2Ldz7G35ll694YO8xZ/S
         76hk48cForCD4+tfrD13PvKEHTHwJpSmpTerOiSa3yMVYWpErcFJVnH6DlfJKAPHsCo1
         2FSg==
X-Gm-Message-State: AOJu0YxlViuV7q1fZ9k2GREbIE6u7Kpx53nuFAizojkzK9OX2A0Ssm07
        qw3h9bXBlzQNbXAllhXik3guCYlvFEO3J6SuhC1L3U+3OGJ8Qp4ZwHBFVO64mzQ9BHY3W01ly7g
        v6IOMMjc95S60KmxWJCUs0X7s
X-Received: by 2002:a05:6358:4429:b0:135:a5fe:53e1 with SMTP id z41-20020a056358442900b00135a5fe53e1mr8941602rwc.14.1691444520219;
        Mon, 07 Aug 2023 14:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6cZjmnC7U7J1hQFk8/oMOgrg2mGiHV6bQeg+dmtlvwJQ4+nNS5V86I2xD8n11a+KElJ3Qlg==
X-Received: by 2002:a05:6358:4429:b0:135:a5fe:53e1 with SMTP id z41-20020a056358442900b00135a5fe53e1mr8941581rwc.14.1691444519877;
        Mon, 07 Aug 2023 14:41:59 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id t7-20020a0cde07000000b00632191a70aesm3142487qvk.88.2023.08.07.14.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:41:59 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:41:57 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6/9] arm64: dts: qcom: sa8775p-ride: index the first
 SGMII PHY
Message-ID: <mzluoncplmsjvaohf5jjuencqvevm2sjj6itogt7eof6hskewd@435rhivwyr7g>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-7-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:35:04PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We'll be adding a second SGMII PHY on the same MDIO bus, so let's index
> the first one for better readability.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 1c471278d441..55feaac7fa1b 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -263,7 +263,7 @@ vreg_l8e: ldo8 {
>  
>  &ethernet0 {
>  	phy-mode = "sgmii";
> -	phy-handle = <&sgmii_phy>;
> +	phy-handle = <&sgmii_phy0>;
>  
>  	pinctrl-0 = <&ethernet0_default>;
>  	pinctrl-names = "default";
> @@ -279,7 +279,7 @@ mdio {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		sgmii_phy: phy@8 {
> +		sgmii_phy0: phy@8 {
>  			compatible = "ethernet-phy-id0141.0dd4";
>  			reg = <0x8>;
>  			device_type = "ethernet-phy";
> -- 
> 2.39.2
> 

