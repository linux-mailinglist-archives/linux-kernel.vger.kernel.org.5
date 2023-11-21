Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219AD7F302D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjKUOEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjKUOEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:04:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F30D79
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700575475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lg4k/3dlZcCU56aN6iGyLYrEU5FjTnslfS62KZBVgEc=;
        b=BH4Ws3hQSE9TwFsKj4MUeHe0/Kn2MTxsTeSHDLpwYP4rL2yR0cWHsM0Uob/ZU4P4wMU/E2
        HxTsZbDGXi1r+6caEBDGkbv9awP/Y6YOyKx8RpJHmT3hLjm2zxqOrNb5p31SnZaZ38jH11
        S/v9i8b+5ap1qE89SEYWNk5PjmIMf4E=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-P93gJmW7OWWTljHyXSJR2g-1; Tue, 21 Nov 2023 09:04:26 -0500
X-MC-Unique: P93gJmW7OWWTljHyXSJR2g-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66fe14725aeso43404796d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700575458; x=1701180258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg4k/3dlZcCU56aN6iGyLYrEU5FjTnslfS62KZBVgEc=;
        b=onRuIRE0mc2J4zfpeiGDyQSNiwr6eI2yykCmnhWNPqu0/akIehMRIj4xQLXtVUe+DQ
         2Xxx5vw2VuqmEOgbMESFaAf7OduQePDzr8HSuQiN6yf7JAxlnt0wgDup/NAajnEJ2DDH
         WGA02VUUg47zkhfiCxWzpCUoPvqFRNZ/XfL3lVYeNtQnfcm7T9QujyApImmgIzOEnHWf
         BHjhyE0kSPf0mcYl9H1GyAa4f/gStJpdgMvTNvHgT1S6fo4y+CFTCwdxrSiwenMvse3Q
         iiROmPnORw4T7srmEz2FEbGncm5JUNPpuozU4oNvFiUinM/U1gbLQ0NSFP1QFXlC0pXu
         ELoA==
X-Gm-Message-State: AOJu0YyjWFRIPECx2iBapbcnmlc3p/F3KGmkV3JC74GRqROVBSoWImR4
        faVryTVzTCWgomtwi/ar/2bgXUmoFFy5S+XYsZCdKTuYLzPMgwhJi7vYOtdanIRRoQNwuYKnHwx
        J242k9WKnROd6+Am43HZP9eRs
X-Received: by 2002:a05:6214:e4f:b0:679:d33e:352a with SMTP id o15-20020a0562140e4f00b00679d33e352amr8633028qvc.1.1700575458632;
        Tue, 21 Nov 2023 06:04:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnLik0eV74HqD/F8NKb24Z8lRgzXhSPmwf6CP38CjCe1HMvqTyw81qfCQiYOQyIHdj/5K0Rw==
X-Received: by 2002:a05:6214:e4f:b0:679:d33e:352a with SMTP id o15-20020a0562140e4f00b00679d33e352amr8632999qvc.1.1700575458385;
        Tue, 21 Nov 2023 06:04:18 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id b9-20020a0cfe69000000b0065b0554ae78sm3930045qvv.100.2023.11.21.06.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 06:04:18 -0800 (PST)
Date:   Tue, 21 Nov 2023 08:04:15 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: dwc3: qcom: fix wakeup after probe deferral
Message-ID: <syszua6kmso3k4zfvwwsfjaq4ok6gkexhfli34r3dtjhn63vio@dwhhnn5b2s5b>
References: <20231120161607.7405-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120161607.7405-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 05:16:04PM +0100, Johan Hovold wrote:
> When testing a recent series that addresses resource leaks on probe
> deferral [1] I realised that probe deferral can break wakeup from
> suspend due to how the wakeup interrupts are currently requested.
> 
> I'll send a separate series for the Qualcomm devicetrees that used
> incorrect trigger types for the wakeup interrupts. Included here is just
> a patch fixing the binding example which hopefully will make it less
> likely that more of these gets introduced. Fortunately, there should be
> no dependency between this series and the devicetree one.
> 
> Note also that I decided to include a related trivial cleanup patch.
> 
> Johan
> 
> 
> [1] https://lore.kernel.org/lkml/20231117173650.21161-1-johan+linaro@kernel.org/
> 
> 
> Johan Hovold (3):
>   dt-bindings: usb: qcom,dwc3: fix example wakeup interrupt types
>   USB: dwc3: qcom: fix wakeup after probe deferral
>   USB: dwc3: qcom: simplify wakeup interrupt setup

For the series:

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> 
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml |  4 ++--
>  drivers/usb/dwc3/dwc3-qcom.c                         | 12 ++++--------
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> -- 
> 2.41.0
> 
> 

