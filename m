Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10C7730EF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 23:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHGVLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 17:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjHGVL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 17:11:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BA81715
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 14:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691442639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0UqcugjS0RccYNXeQE8DX5IYJH0+T9wqvZIkdmfE2c=;
        b=fRdmZ2x5YxRqdxQ3/iRR50ePpLwMgxMVCb7Vh9uY1I4cEiBEwxYtBOmJifT+QOJ6HdXFSR
        1Dd7YREMfc9NbDqg8NjInOlSrlDphFdLUxTVn9UykuwRG2Y1nZ4tk0XhgPnXPxKYZ83K1l
        kjErt8rJhN1gMtuvoysFPBBPboU78UA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-R0W9W8urM-y36Xq1rgLIaQ-1; Mon, 07 Aug 2023 17:10:37 -0400
X-MC-Unique: R0W9W8urM-y36Xq1rgLIaQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-63d0b65ae89so41804706d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 14:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691442637; x=1692047437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0UqcugjS0RccYNXeQE8DX5IYJH0+T9wqvZIkdmfE2c=;
        b=UOT2SNWil4YtCyuZKilztZaYXnOLGnUNrKc4XOzzaW9Oqo76i1IuMbRWeo74fMWYBI
         WLj4s4lXcQBJ3V2L/SZOcWcTVdeoA7r7yq890nJHxiAtp1rB5sWiHxhdMAXyzazdeO19
         fcz0z49JKeN+Z6U27T/2aWWciNgqI0zF4B5UjuOgarTy56kSNFnlA0B1Ud1YA6GxHRs9
         B/hxIzcNlscGtaMMKlEjL8Ki2/24trFXKshfB/AuwKUHyipPMvn1QuXvLGY6JwF7ZadX
         8sM8XXSDSYmVA1wtGyvdS2EM73x2m5XOAmTCYQp/gb0iCBv4PeyoIPxxu/tDEuTOkbYP
         GjPg==
X-Gm-Message-State: AOJu0Yyzts15d0VYmBRbiQhN5KfkXsTHiKNt8lyYemUGVELyEFQ93hzz
        BTDidugiEGovS3ow+0kWwLDdcYm3MrBbyhn/Bdx+bIVitvicP+4KdNC2VSb/Pu1/e4ZlFbKR5oU
        jJ9NJhhlDygz95zbOjgIHH7og
X-Received: by 2002:a05:6214:5285:b0:637:2eb:6c23 with SMTP id kj5-20020a056214528500b0063702eb6c23mr10940436qvb.18.1691442637342;
        Mon, 07 Aug 2023 14:10:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+zDgMXaVHPxp5LJzPa58rANcJME3055x5SPbjCrUnzx2WN7zSjd+W5Z5TVRpgxbKxPeoiLw==
X-Received: by 2002:a05:6214:5285:b0:637:2eb:6c23 with SMTP id kj5-20020a056214528500b0063702eb6c23mr10940418qvb.18.1691442637101;
        Mon, 07 Aug 2023 14:10:37 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id q15-20020a0cf5cf000000b0063d4631d1e4sm3134431qvm.68.2023.08.07.14.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 14:10:36 -0700 (PDT)
Date:   Mon, 7 Aug 2023 16:10:34 -0500
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
Subject: Re: [PATCH 1/9] arm64: dts: qcom: sa8775p: add a node for the second
 serdes PHY
Message-ID: <qdagbipfnukpsn5a7f6hswbktrwutizluf3zom2gq6q4q6w6df@h4lkoi3mjzes>
References: <20230807193507.6488-1-brgl@bgdev.pl>
 <20230807193507.6488-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807193507.6488-2-brgl@bgdev.pl>
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

On Mon, Aug 07, 2023 at 09:34:59PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a node for the SerDes PHY used by EMAC1 on sa8775p-ride.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

FWIW this seems to match downstream sources.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 7b55cb701472..38d10af37ab0 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -1846,6 +1846,15 @@ serdes0: phy@8901000 {
>  			status = "disabled";
>  		};
>  
> +		serdes1: phy@8902000 {
> +			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
> +			reg = <0x0 0x08902000 0x0 0xe10>;
> +			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
> +			clock-names = "sgmi_ref";
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>  		pdc: interrupt-controller@b220000 {
>  			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
>  			reg = <0x0 0x0b220000 0x0 0x30000>,
> -- 
> 2.39.2
> 

