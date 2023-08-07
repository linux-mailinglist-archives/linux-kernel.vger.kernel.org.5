Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E377311E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHGVTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjHGVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:19:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A417E74
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691443106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IoOblYBETmyEulfRzdGlHBsHmabJ0o2kE+I2LBLgwC8=;
        b=fPpp9VWGwUV+YmDUFwqxNykExHWovNpzA8V/rv3Jlpw3g4dIQbHrkeMl4qGe29Go7GwE2A
        ORLezFjmmL+lAXnqps+b7M/MQ8bgVqWjVxvF3Oqtia6jWkEMhZ1gLZgAYj8ZHCBR2RyPo7
        3R2HTWfqg4H9nG2UdBfROtV0wkHSxkA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-v8vI5or5MF6jGxGncl44QQ-1; Mon, 07 Aug 2023 17:18:24 -0400
X-MC-Unique: v8vI5or5MF6jGxGncl44QQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c93466e4cso469646785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443104; x=1692047904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoOblYBETmyEulfRzdGlHBsHmabJ0o2kE+I2LBLgwC8=;
        b=HjMEdtrbVVAaa2O6zSSzbwRRvgCoRayRBhQvtakOHyI7tg+kNXc8ZkQ/TkVtWy8SSO
         ciHQ7NtnuQeUHecessEXpas+oh92mjNcw0x2/NpF49HUGPsDyWtoZVBBhZlO3fMFceD5
         gxYLNwzJ6Uv4y15rplpfJxNG0znuGwu/ZTJk9NWzjDSlvpqFuFlZpPIrZdZCPIq2kTxQ
         LPM6rUUNF0S5F6Thh6kfycxe8VxJKc+izEZXwHjMX9aE0IBoTZjtAtyp+u8ZYWG/OQTe
         NcDtu4ogX1Wm01+cNpi3BLv0f1rUxVw9lc2mM4FB85HkVwPMcfTCkjUDuasPvbnB/PV7
         VXLg==
X-Gm-Message-State: AOJu0YwYkF/TbGdY4KwbEabZMW7Ubq84AwPELqXO2YONRvrfUfkIwkpi
        c2jO82U7SadhmNYF5jmBtFFMdeEUPDth9e8CKgokCcbXpuzoqPm+QiG2lIplDPFAz/7nq1aQtXP
        kBxV4ggVdk1XtXbYdI9hwQqhK
X-Received: by 2002:a05:620a:4407:b0:76c:5952:7317 with SMTP id v7-20020a05620a440700b0076c59527317mr12231406qkp.3.1691443104339;
        Mon, 07 Aug 2023 14:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJiZ/UaGfvXt9A7FbU4f37zUtzcv+NxPI0dw4fVHbqmXGCPAH9jAsqse5T/ZluBmnq31oYbQ==
X-Received: by 2002:a05:620a:4407:b0:76c:5952:7317 with SMTP id v7-20020a05620a440700b0076c59527317mr12231385qkp.3.1691443104055;
        Mon, 07 Aug 2023 14:18:24 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id pj48-20020a05620a1db000b0076cd5b510f1sm2855141qkn.38.2023.08.07.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:18:23 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:18:21 -0500
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
Subject: Re: [PATCH 4/9] arm64: dts: qcom: sa8775p-ride: add pin functions
 for ethernet1
Message-ID: <3ocnhpal77jmsqabcmnvekk4sqgookk5sunrvb3hstaupqfaj2@whnb7uj6w7ue>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-5-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:35:02PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the MDC and MDIO pin functions for ethernet1 on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index 09ae6e153282..38327aff18b0 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -480,6 +480,22 @@ ethernet0_mdio: ethernet0-mdio-pins {
>  		};
>  	};
>  
> +	ethernet1_default: ethernet1-default-state {
> +		ethernet1_mdc: ethernet1-mdc-pins {
> +			pins = "gpio20";
> +			function = "emac1_mdc";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +
> +		ethernet1_mdio: ethernet1-mdio-pins {
> +			pins = "gpio21";
> +			function = "emac1_mdio";
> +			drive-strength = <16>;
> +			bias-pull-up;
> +		};
> +	};
> +

With the whole "EMAC0 MDIO handles the ethernet phy for EMAC1", this
doesn't seem to make sense.

I don't have all the schematics, but these pins are not connected from
what I see.

