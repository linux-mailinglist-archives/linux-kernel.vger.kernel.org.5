Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D8E804069
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjLDUxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbjLDUxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5285CD4F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701722590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CcxV6xsv8L+uEPwt5UPfpW3moxDE6BTcpdqQtS3FRXw=;
        b=ZnbU+T9zom5AwwUMkbVKw/El09aBgYNj5n/PHBEkzVXNzPQXkRJMc7IixYNMK2heSuOtc6
        +68IzjyqLY4jw/dl4srMKtN877h2iexLZMJZPAdczme9pXD/Jf+dQTPAii8C7xjFd9iPCx
        /LuJwa/gFMWo+BuRbUzf0So1ADwc/A8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-jhXzeYUmMmaXEk7djJLXDQ-1; Mon, 04 Dec 2023 15:43:06 -0500
X-MC-Unique: jhXzeYUmMmaXEk7djJLXDQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-67ab4382912so36922936d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:43:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722586; x=1702327386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcxV6xsv8L+uEPwt5UPfpW3moxDE6BTcpdqQtS3FRXw=;
        b=OrOTxM5LTlWGI2qaxfZdtpV/FrQ36dDKlaZdGJWW+k2/tGAbns9zrvrWkW+GbmoosX
         r65Sxxth0NoFuzVRActSmW+zJrESswnS4qwhxPv60KbVsh/jYmiAXaNlzBrwl6/QGKDV
         u+qH3+G2Ty74fnAX+8c+VsYXgKzDMTUbzuFWBU6v3G/8xPuEKwuC372O+JOQOxOU0EOx
         HW75aV3JJVtpZKW02oPPnRUKMxVGCRffCzbt6t1DSeaF02qSlUSde1vASaSr4mq9lvoq
         BnFjbEmJWj6Mobi2a1cATb5bBPDbcPwxCtYNBoVvDLJ8/J51GwYYRpD/7wcl/SWwlGHd
         a4ig==
X-Gm-Message-State: AOJu0YxmvdMlzXoP1Ma4W769L9tv8jx0PY5lP/hgwz2tjSyLo7QtMKkj
        YH7vwK0C4gAj3GLxIcKr8sUQSXN+BUrdwBtK4iuOv/0/vV3tGOUFpBXD6On0vhHhi7wnl57B96F
        3JRrkn/K5SMEmcTPqgQK28XeT
X-Received: by 2002:a05:6214:2b48:b0:67a:a721:720c with SMTP id jy8-20020a0562142b4800b0067aa721720cmr135470qvb.41.1701722585901;
        Mon, 04 Dec 2023 12:43:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH27xWS3K2jcZSn77U+0BZD1FMi3abTl2HyZC4yJvCVWmqKhlNAvT/9jKiUYfBDcwREA09qjg==
X-Received: by 2002:a05:6214:2b48:b0:67a:a721:720c with SMTP id jy8-20020a0562142b4800b0067aa721720cmr135442qvb.41.1701722585632;
        Mon, 04 Dec 2023 12:43:05 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id qd23-20020ad44817000000b0067a8cd6f034sm4247472qvb.138.2023.12.04.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:43:05 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:43:02 -0600
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
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Add driver support for
 DWMAC5 safety IRQ Support
Message-ID: <b7uaftelklsquxv5apq5cpkegxfsdsefx3vjdh2kuqdlrq5oia@r4ahkp4dxs6z>
References: <cover.1701695218.git.quic_jsuraj@quicinc.com>
 <d915004a7c45dc96fa326924c467e1f59af9ccbd.1701695218.git.quic_jsuraj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d915004a7c45dc96fa326924c467e1f59af9ccbd.1701695218.git.quic_jsuraj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 06:56:17PM +0530, Suraj Jaiswal wrote:
> Add IRQ support to listen HW safety IRQ like ECC,DPP,FSM
> fault and print the fault information in the kernel
> log.
> 
> Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/common.h   |  1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h   |  2 ++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c  | 18 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_platform.c  |  9 +++++++++
>  4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> index 6b935922054d..c4821c7ab674 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> @@ -347,6 +347,7 @@ enum request_irq_err {
>  	REQ_IRQ_ERR_SFTY_UE,
>  	REQ_IRQ_ERR_SFTY_CE,
>  	REQ_IRQ_ERR_LPI,
> +	REQ_IRQ_ERR_SAFETY,
>  	REQ_IRQ_ERR_WOL,
>  	REQ_IRQ_ERR_MAC,
>  	REQ_IRQ_ERR_NO,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> index 686c94c2e8a7..8eac37ff002d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -33,6 +33,7 @@ struct stmmac_resources {
>  	int irq;
>  	int sfty_ce_irq;
>  	int sfty_ue_irq;
> +	int safety_common_irq;
>  	int rx_irq[MTL_MAX_RX_QUEUES];
>  	int tx_irq[MTL_MAX_TX_QUEUES];
>  };
> @@ -343,6 +344,7 @@ struct stmmac_priv {
>  	/* XDP BPF Program */
>  	unsigned long *af_xdp_zc_qps;
>  	struct bpf_prog *xdp_prog;
> +	int safety_common_irq;

This probably belongs with the other IRQs instead of the "XDP BPF Program"
section for readability.

>  };
>  
>  enum stmmac_state {
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index c2ac88aaffed..46a5cb20e4b4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3591,6 +3591,10 @@ static void stmmac_free_irq(struct net_device *dev,
>  		if (priv->wol_irq > 0 && priv->wol_irq != dev->irq)
>  			free_irq(priv->wol_irq, dev);
>  		fallthrough;
> +	case REQ_IRQ_ERR_SAFETY:
> +		if (priv->safety_common_irq > 0 && priv->safety_common_irq != dev->irq)
> +			free_irq(priv->safety_common_irq, dev);
> +		fallthrough;
>  	case REQ_IRQ_ERR_WOL:
>  		free_irq(dev->irq, dev);
>  		fallthrough;
> @@ -3797,6 +3801,18 @@ static int stmmac_request_irq_single(struct net_device *dev)
>  		}
>  	}
>  
> +	if (priv->safety_common_irq > 0 && priv->safety_common_irq != dev->irq) {
> +		ret = request_irq(priv->safety_common_irq, stmmac_safety_interrupt,
> +				  0, "safety", dev);
> +		if (unlikely(ret < 0)) {
> +			netdev_err(priv->dev,
> +				   "%s: alloc safety failed %d (error: %d)\n",
> +				   __func__, priv->safety_common_irq, ret);
> +			irq_err = REQ_IRQ_ERR_SAFETY;
> +			goto irq_error;
> +		}
> +	}
> +
>  	return 0;
>  
>  irq_error:
> @@ -7459,6 +7475,8 @@ int stmmac_dvr_probe(struct device *device,
>  	priv->lpi_irq = res->lpi_irq;
>  	priv->sfty_ce_irq = res->sfty_ce_irq;
>  	priv->sfty_ue_irq = res->sfty_ue_irq;
> +	priv->safety_common_irq = res->safety_common_irq;
> +
>  	for (i = 0; i < MTL_MAX_RX_QUEUES; i++)
>  		priv->rx_irq[i] = res->rx_irq[i];
>  	for (i = 0; i < MTL_MAX_TX_QUEUES; i++)
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 1ffde555da47..41a4a253d75b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -726,6 +726,15 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  		dev_info(&pdev->dev, "IRQ eth_lpi not found\n");
>  	}
>  
> +	stmmac_res->safety_common_irq =
> +		platform_get_irq_byname_optional(pdev, "safety");
> +
> +	if (stmmac_res->safety_common_irq < 0) {
> +		if (stmmac_res->safety_common_irq == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		dev_info(&pdev->dev, "IRQ safety IRQ not found\n");
> +	}
> +
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>  
>  	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> -- 
> 2.25.1
> 

