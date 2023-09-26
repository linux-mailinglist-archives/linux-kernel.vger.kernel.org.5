Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF587AF010
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjIZPy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjIZPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1A210A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695743645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lfgMbT89bsKLE1BSsCK4Ts7guvT4LJ6gXy0Xq4JrQz0=;
        b=LtlwRBKlJ4NjxvgFlmIeUrDGuWnCmI9YVfee2pVRj6YP/OKshIjHIqMFJ95gu2kduzl1Gk
        79kxba85lGiXxAwaVz0zSLvFZzfdJTSnOQYrWhXaMD06HmB0flZ5Jccgl0OEiPY+Aiw5Sw
        a/Jj3cFqzAO18Bnt9cwuOSxlpev7F5c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-Yw0pgxDxPgKix6POpT2fmg-1; Tue, 26 Sep 2023 11:54:03 -0400
X-MC-Unique: Yw0pgxDxPgKix6POpT2fmg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7740cedd4beso1434132185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695743643; x=1696348443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfgMbT89bsKLE1BSsCK4Ts7guvT4LJ6gXy0Xq4JrQz0=;
        b=cidyEB9nxphwQTxn2qvYlCzV/9ce29JQONYoFdQ+ZGRmemBJpNEzFBRByDB19zslyk
         7IInd9uS0+En2268+a+NhgxgLaRrrPS2Bre6GcYeGgdnqDLzE+sQQnzLYNygEaxuHzYm
         ce7/TFsVPHiBq19BVZzneN0k2uSJZC7mop+axnpr+t74AdJNvGXnVTchUEqLhuczPgRu
         5OE4Knw3mvOTX3mwTd/7Xosme9RJseIVWIbMI+5l+upsy890vFEMnCYgrpIK+bzJdzUB
         KEcJiBWT4JSjsrawkFy1gPZIsau7vw5/zMrJoe8d53nzWPrjt1Yh1dmE+ghVg7QpsMxC
         ulMg==
X-Gm-Message-State: AOJu0YykXT19D5iwWoPO/+rdFH1pc/FQNxNhJRkqhZETFdR9yodNTagH
        KDdW+Xl7996v26tQXy3Se5JffOBsoFzwtcLWas/TVASl5qYhqlx5aJV2xuJyGLaeMoPAO86hegG
        o8Bs8vxDz2Y731nhsTNqet5jG
X-Received: by 2002:a05:620a:3951:b0:774:32e4:ebd1 with SMTP id qs17-20020a05620a395100b0077432e4ebd1mr5970531qkn.22.1695743642875;
        Tue, 26 Sep 2023 08:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjoNr9/0SjCFy/8t3CeR1WtVldmO0NlgbwZrROy7zzzQD3K5CryYq95FeP/1DRu822hONwiA==
X-Received: by 2002:a05:620a:3951:b0:774:32e4:ebd1 with SMTP id qs17-20020a05620a395100b0077432e4ebd1mr5970503qkn.22.1695743642528;
        Tue, 26 Sep 2023 08:54:02 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id op34-20020a05620a536200b00772662b7804sm4834805qkn.100.2023.09.26.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:54:02 -0700 (PDT)
Date:   Tue, 26 Sep 2023 10:53:59 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Raghavendra Kakarla <quic_rkakarla@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, quic_mkshah@quicinc.com,
        quic_lsrao@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8775p: Add RPMh sleep stats
Message-ID: <aefvlsdql6vv35mjm3h32bd7ttc2u7uzujs7rejvfnwxdzlrtj@7nprp3s5qvnv>
References: <20230926044814.535-1-quic_rkakarla@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926044814.535-1-quic_rkakarla@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 10:18:14AM +0530, Raghavendra Kakarla wrote:
> Add device node for sleep stats driver which provides various
> low power mode stats.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Raghavendra Kakarla <quic_rkakarla@quicinc.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

I took this for a quick spin when testing -next today, and I see the
qcom_stats directory, can view the file output, etc. Probably good enough
to consider this simple change tested. I also don't see any new issues
when running:
ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CHECK_DTBS=1 qcom/sa8775p-ride.dtb

> ---

Generally you should put a description of what changed since v1
in this section.

>  arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 9f4f58e831a4..cee7491de675 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -1912,6 +1912,11 @@
>  			#clock-cells = <0>;
>  		};
>  
> +		sram@c3f0000 {
> +			compatible = "qcom,rpmh-stats";
> +			reg = <0 0x0c3f0000 0 0x400>;
> +		};
> +
>  		spmi_bus: spmi@c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0x0 0x0c440000 0x0 0x1100>,
> -- 
> 2.17.1
> 

