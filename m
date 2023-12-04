Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C4803F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjLDUQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjLDUQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBAEF0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701720977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=scE6uJE/gsl0ExlvPlw1tvZXL0nwbCHoC6Ch9ngDrG8=;
        b=KQds8Gu9MN9fs665098G4bgXmbejxlRdEzdisgH4g/5hRlycImVcD7QdJRe6HH9qFxKPQh
        tT+WMUy6oLyLhdwSqMOsiZPd8pTjTgrd/cxUoVuI1qAvhYh+CuC5pnOpKHEpuC+X7YTUwJ
        +5+VB8QOJl9jI33hcWDrbOqyp+No5zs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-sHPsDwEwM2-Hf9NK_-M6Wg-1; Mon, 04 Dec 2023 15:16:15 -0500
X-MC-Unique: sHPsDwEwM2-Hf9NK_-M6Wg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67aa944afd6so15884596d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720975; x=1702325775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scE6uJE/gsl0ExlvPlw1tvZXL0nwbCHoC6Ch9ngDrG8=;
        b=QvvZPhWulNUjCzX0akl2g521TkI7PHqHostPcHdKTD4OEMTSz/j7Vie87yNXhCoUi5
         37KMjK/Frp+v+Vp3CReqWScwEosyDQ33zh9e7jfnNtc5ZB8Xd3yG4gExP88+Znk953eb
         g6tYtr+dWRrrSOtlVrq55tVAvwwGMC0cixerAlf/JmOYXvzzjemA1cjjoD2NejNRid9q
         WIomXU5hzethUMU6zcJqm8DFTLNoIscx+3/f1zPZipzvJ+UeY1Nc0M49DLNoranw2aW0
         nlXTm+YXiLnf5vHms7jjXlipS2AxjdTMiU6TmpLDBZQ+7Jk7pxHTzriv4/4uNHESthwF
         BsEg==
X-Gm-Message-State: AOJu0YyrjwtWLgYGZ4KDg2HtcFn5zAMXMZVpyXFIL6uiqTtBmQV3CQBC
        yscFgF71gdCKfpJrx0TV6ubhaY7P2bSJ6ACcVegvHZB1R20pDi8wylmVIsjHn2IaAMRU9g0jq2R
        MN8DDAMaOJLQPs0i9bCnnKaWb
X-Received: by 2002:ad4:4481:0:b0:67a:a721:ec1a with SMTP id m1-20020ad44481000000b0067aa721ec1amr127145qvt.94.1701720975330;
        Mon, 04 Dec 2023 12:16:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgoVrFG6EC//oL2uzFysj4twtnTf+9h/+HjOZVaxTJrf07QpXYwOj+ja1iSEQZGrynxBr/Ig==
X-Received: by 2002:ad4:4481:0:b0:67a:a721:ec1a with SMTP id m1-20020ad44481000000b0067aa721ec1amr127121qvt.94.1701720975037;
        Mon, 04 Dec 2023 12:16:15 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id r3-20020a0cb283000000b00677fb735738sm4618230qve.34.2023.12.04.12.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:16:14 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:16:12 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Suraj Jaiswal <quic_jsuraj@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Prasad Sodagudi <psodagud@quicinc.com>, kernel@quicinc.com
Subject: Re: [PATCH net-next v3 0/3] Ethernet DWMAC5 fault IRQ support
Message-ID: <rw5vfdvre5rt4rwytfsp3qy6sgsdr3dm6oefr4sap2aqbvpw42@c2dxz42tucby>
References: <cover.1701695218.git.quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701695218.git.quic_jsuraj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:56:14PM +0530, Suraj Jaiswal wrote:
> Add support to listen Ethernet HW safery IRQ. The safety IRQ will be

s/safery/safety/

> triggered for ECC, DPP, FSM error.
> 
> Changes since v3:

This is listed as v3 in the subject, but it should now be v4 since the
last version was v3.

> - Fix DT_CHECKER warning
> - use name safety for the IRQ.
>  
> 
> Suraj Jaiswal (3):
>   dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for
>     sa8775p
>   arm64: dts: qcom: sa8775p: enable safety IRQ
>   net: stmmac: Add driver support for DWMAC5 safety IRQ Support
> 
>  .../devicetree/bindings/net/qcom,ethqos.yaml   |  9 ++++++---
>  .../devicetree/bindings/net/snps,dwmac.yaml    |  5 +++--
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi          | 10 ++++++----
>  drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
>  7 files changed, 45 insertions(+), 9 deletions(-)
> 
> -- 
> 2.25.1
> 

