Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9754D7731A4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjHGVvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjHGVvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:51:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA20C83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691445045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPSVK0q38/9ucO9elZwkMLmlNjwRAoZnlZuzPogEk1o=;
        b=eeEW6FsJ40f0jfcJwiIyW6DqanhEcj1GGPBbLfKKmms6EbtMjQbxpMGeqQHgUyOGiM1mX4
        WTaRCFp/ynnAXKPoOdaRgHN9deXnmRsj1f+C0Z3Hml4zdlo5yOJKWMicIMhiKqWdEkYCHF
        dbk3NKjwm6Wrk27z43htISI5mk1N8CY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-oNw8_oAcMGiUrA14hDZXKw-1; Mon, 07 Aug 2023 17:50:43 -0400
X-MC-Unique: oNw8_oAcMGiUrA14hDZXKw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76cf2dbfba6so479526685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691445043; x=1692049843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPSVK0q38/9ucO9elZwkMLmlNjwRAoZnlZuzPogEk1o=;
        b=Go8WhCIhBbRhnEKLknOR9EATY3v6yHGu7jUDLdYdxBVeuHwtq/e2yFTHzn7/2ASnN/
         tR897I0MqNRBH5mWRCSBj51XJ6Gla8veyeBy+6xdG/7dyF6J1Oo8uXBwCvvR7QKK9w2U
         RTgDzIi/LZ+VCSoCX40EK6YtjXGETvTBz1qRS9rRTRPYnb8J0t0cWyw/Q1EnHydNBFvA
         DWIwWsb1J7p6JzznAxnqmCYxCOpj+V9mMA3QMjuNaS9xRbcCXb8SWLtr93vXy0b5F6Jw
         bomVaVREkC0DwzqiFTv+ScHUa7cRYsnzYjq4XHW0rouJM69mgcAVfL6oyu+e449JMnTt
         +d8Q==
X-Gm-Message-State: AOJu0YypO75ohYiiFojIRzmuHMgYr3kvcTQZJW01/yzWZ4OWyrx1ynt2
        bqy6NgRUtOv0J0Kpt1aa3SeRwmh3/5LdzWZM/JfpZiZdJqyL3NC7Ul+eqt7Q4qSlMT0PFkUVJXT
        sxXk0E3YhbaCr7UZXye8RlyoN
X-Received: by 2002:a05:620a:4d3:b0:76c:caa5:4c18 with SMTP id 19-20020a05620a04d300b0076ccaa54c18mr9904835qks.28.1691445043381;
        Mon, 07 Aug 2023 14:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/uAedUeFA6q0hTTuBTst2fgrV1L9TgOpDMpX6Spyv8dfTx5yzRq5iY4OZL49sp+Yu/QrKtg==
X-Received: by 2002:a05:620a:4d3:b0:76c:caa5:4c18 with SMTP id 19-20020a05620a04d300b0076ccaa54c18mr9904831qks.28.1691445043103;
        Mon, 07 Aug 2023 14:50:43 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9e90c000000b0076c60b95b87sm2867118qkf.96.2023.08.07.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:50:42 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:50:40 -0500
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
Subject: Re: [PATCH 9/9] arm64: dts: qcom: sa8775p-ride: enable EMAC1
Message-ID: <ddgwq5io3fbjupdyy7ls3xrle64w52hnds663a25st2vnz2ubh@6fi5fgkcgu3s>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-10-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-10-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 09:35:07PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the second MAC on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 74 +++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> index af50aa2d9b10..0862bfb4c580 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> @@ -356,6 +356,80 @@ queue3 {
>  	};
>  };
>  
> +&ethernet1 {
> +	phy-mode = "sgmii";
> +	phy-handle = <&sgmii_phy1>;
> +
> +	pinctrl-0 = <&ethernet1_default>;
> +	pinctrl-names = "default";

As I stated in the earlier patch that added ethernet1_default, I don't
think it makes sense. All the MDIO is happening via the pins described
via ethernet0_default.

> +
> +	snps,mtl-rx-config = <&mtl_rx_setup1>;
> +	snps,mtl-tx-config = <&mtl_tx_setup1>;
> +	snps,ps-speed = <1000>;
> +	snps,shared-mdio = <&mdio0>;

same question as Andrew Lunn, but I'll let you respond to one of his
threads.

> +
> +	status = "okay";
> +
> +	mtl_rx_setup1: rx-queues-config {
> +		snps,rx-queues-to-use = <4>;
> +		snps,rx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x0>;
> +			snps,route-up;
> +			snps,priority = <0x1>;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +			snps,map-to-dma-channel = <0x1>;
> +			snps,route-ptp;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x2>;
> +			snps,route-avcp;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,map-to-dma-channel = <0x3>;
> +			snps,priority = <0xc>;
> +		};
> +	};
> +
> +	mtl_tx_setup1: tx-queues-config {
> +		snps,tx-queues-to-use = <4>;
> +		snps,tx-sched-sp;
> +
> +		queue0 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue1 {
> +			snps,dcb-algorithm;
> +		};
> +
> +		queue2 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +
> +		queue3 {
> +			snps,avb-algorithm;
> +			snps,send_slope = <0x1000>;
> +			snps,idle_slope = <0x1000>;
> +			snps,high_credit = <0x3e800>;
> +			snps,low_credit = <0xffc18000>;
> +		};
> +	};
> +};
> +
>  &i2c11 {
>  	clock-frequency = <400000>;
>  	pinctrl-0 = <&qup_i2c11_default>;
> -- 
> 2.39.2
> 

