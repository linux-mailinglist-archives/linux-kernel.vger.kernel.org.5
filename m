Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59510773149
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjHGVda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHGVd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0AE7F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691443962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwU1XiRfwkyJv6HYxosHo3VvAVWgJ3KR/r6p07WGmVA=;
        b=KbAIgC2T044I1HgWfPlTOQhWcNtwjZxSyYQwrAZaqYsmIv28Ju8U/zwOpTePZdiqpqmbgP
        Aoz2PcEZCRnOkRPXYO2KgfN6yuF+Jki8tZpoinq0hnvfWKji2Heo0+aYwzt3DYwyeuPVw+
        eDP7FLZGaTLjfeTy0M6C/9f972qnZ2k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-IOv-r1-jM1OT0IETKBpdpw-1; Mon, 07 Aug 2023 17:32:41 -0400
X-MC-Unique: IOv-r1-jM1OT0IETKBpdpw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63ccbef84eeso42454076d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443961; x=1692048761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwU1XiRfwkyJv6HYxosHo3VvAVWgJ3KR/r6p07WGmVA=;
        b=kdXKOU14MUf1Nd+TlGZ3KWC5l51ypTfw9pcMTFOj24DRDHdhhK0/wj7g7Sxuq2w35M
         e2bo6LPtIj0Efc0XWN4IHp4cCdodNPg9N4w8v1snvBlYFryJ2smNECqVKUdVv9RomBwS
         MnfiY1Mtke5cHvKfYWUsc3l+Hc3ovfmuGKpK/8GVWSbajtI61v7nVlD59USfobQjWENU
         8yhWz4zGDOo72X+2CqHYA5OfBVi4K2UFWixTvvgpqfug26f4PDkc7dCo+KeMw/RbKRB3
         opsi+OqYnQB7rwIgA7X4XdTxcyX3HQG840CJFfYdL6R4XNeBMomRXiqnmiHhiytxNlsp
         Mw0A==
X-Gm-Message-State: AOJu0YzN+cBlufEXAvm/o3Zv12E/ltHHRqYj+HKfQolnqD5TFL8r958y
        uc6zTey4vs4IxUrZaiTZl0O2JWfv6gYOXQld6djIvck4xhRF+iQchl4Ze31KbBiE8uTut2FWH/j
        Gd2AB8F1PdGer9jS2iF6EiRE3
X-Received: by 2002:a0c:eb87:0:b0:63d:580:9c64 with SMTP id x7-20020a0ceb87000000b0063d05809c64mr8729614qvo.46.1691443961017;
        Mon, 07 Aug 2023 14:32:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/GPWMiKDgWyuS4LGvphcnZGiBXArlU9B91b10hFC9ZVHiyYsvMnj28lpxoYou3Fk2gmnqmw==
X-Received: by 2002:a0c:eb87:0:b0:63d:580:9c64 with SMTP id x7-20020a0ceb87000000b0063d05809c64mr8729600qvo.46.1691443960771;
        Mon, 07 Aug 2023 14:32:40 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id l1-20020a0c9781000000b0062fffa42cc5sm3200547qvd.79.2023.08.07.14.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:32:40 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:32:38 -0500
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
Subject: Re: [PATCH 5/9] arm64: dts: qcom: sa8775p-ride: move the reset-gpios
 property of the PHY
Message-ID: <siqiyihftz3musfjulpcqunhgi7npftumrfwfyh2pqnlx6zeb7@rrpwmkvjshfb>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-6-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:35:03PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Device-tree bindings for MDIO define per-PHY reset-gpios as well as a
> global reset-gpios property at the MDIO node level which controlls all

s/controlls/controls/

> devices on the bus. The latter is most likely a workaround for the
> chicken-and-egg problem where we cannot read the ID of the PHY before
> bringing it out of reset but we cannot bring it out of reset until we've
> read its ID.
> 
> I have proposed a solution for this problem in 2020 but it never got
> upstream. Now we have a workaround in place which allows us to hard-code
> the PHY id in the compatible property, thus skipping the ID scanning).

nitpicky, but I think that already existed at that time :D

> 
> Let's make the device-tree for sa8775p-ride slightly more correct by
> moving the reset-gpios property to the PHY node with its ID put into the
> PHY node's compatible.
> 
> Link: https://lore.kernel.org/all/20200622093744.13685-1-brgl@bgdev.pl/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 38327aff18b0..1c471278d441 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -279,13 +279,12 @@ mdio {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> -		reset-delay-us = <11000>;
> -		reset-post-delay-us = <70000>;
> -
>  		sgmii_phy: phy@8 {
> +			compatible = "ethernet-phy-id0141.0dd4";
>  			reg = <0x8>;
>  			device_type = "ethernet-phy";
> +			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> +			reset-deassert-us = <70000>;

Doesn't this need reset-assert-us?


