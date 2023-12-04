Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753468040B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjLDVHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDVHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5DDB6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701724071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mJ2aLBuQ82UANlQlbiQPqkEKJKPRAic/HCDLBzYoX6s=;
        b=Ja5aFmlcZyUbLhazHqlV/VT87Yvplf96criRmMahTxxDd0WvrKFiV6Iq0TnYHaEg7CJTB5
        gti+jndQ2DRYf+U/x5FQJLFc2t+LlIca3wn4h112Nx/AeUhgOsqcUo9ySc/jdfKo+zgA54
        gf3PFUR0cbPttfd7d+a5cXv465C3JZo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-eaGxFcf8Ohaja3e0j8jO1Q-1; Mon, 04 Dec 2023 16:07:48 -0500
X-MC-Unique: eaGxFcf8Ohaja3e0j8jO1Q-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4239f5c1f0fso76520751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 13:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701724068; x=1702328868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJ2aLBuQ82UANlQlbiQPqkEKJKPRAic/HCDLBzYoX6s=;
        b=A2kftl3usY1wwCc/2HW94ZjIUxk9U5MoxFKPSqILQGGsiW9mSWVYGeP53ToLSfaJ7+
         zFo6y9kI4fD3Ai5ItHsJrZJbTkpE8SAmPeMmv28phWU0qIrcrcKEMzrehHT9VVSqZS/j
         WVwG6ZlyqV71KyjPCgkKFlAgqEApJIbCqKrfOgVY3QxgtnEhhdE5lH14MEiRDr7Th0IJ
         eqSjCxLrydTecXTPwYMaVDxadsJvDH7J8Rp9RYXBB7jP6vT4Q8IIleWQEw89C0yds8BB
         1F4t/kYXU/fvJN27SCXC+zNq+yNBz9z0cStS3IN+EI5DSm+Ap3ladh6UXX28i+c154+K
         MWTw==
X-Gm-Message-State: AOJu0Yz6eLaioZA1VH7sjnD5GU47SjYXqMfO3qsG+nqdk2Wek9TBkEvP
        JLiXnqWoNMlQPmDXYeIVRe5N2+Ztlg68tx+ZYlcvtK+Fmo8cBlpodLcoiJnldEbmhdAGHBa1SzJ
        ZJdxBNgH2v/vcTnpLdmNyHauM
X-Received: by 2002:a05:622a:612:b0:423:9887:cd3e with SMTP id z18-20020a05622a061200b004239887cd3emr209050qta.32.1701724068014;
        Mon, 04 Dec 2023 13:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbFKSKjTKx+Yam65LOYaKr2UKx4QIOdb9/HID8MZGjV0GNxiebXUhSTXBgxjLjto4QiruptA==
X-Received: by 2002:a05:622a:612:b0:423:9887:cd3e with SMTP id z18-20020a05622a061200b004239887cd3emr209036qta.32.1701724067678;
        Mon, 04 Dec 2023 13:07:47 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id o16-20020ac841d0000000b00423829b6d91sm4583237qtm.8.2023.12.04.13.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 13:07:47 -0800 (PST)
Date:   Mon, 4 Dec 2023 15:07:45 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Sneh Shah <quic_snehshah@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [PATCH v2] net: stmmac: update Rx clk divider for 10M SGMII
Message-ID: <zf4fsrtrd736kxweputr2fulu7ffagivwi7zodctcsdg3uj6e2@iquglstf2gqb>
References: <20231201100548.12994-1-quic_snehshah@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201100548.12994-1-quic_snehshah@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 03:35:48PM +0530, Sneh Shah wrote:
> SGMII 10MBPS mode needs RX clock divider to avoid drops in Rx.
> Update configure SGMII function with rx clk divider programming.
> 
> Fixes: 463120c31c58 ("net: stmmac: dwmac-qcom-ethqos: add support for SGMII")
> Signed-off-by: Sneh Shah <quic_snehshah@quicinc.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8775p-ride

I can confirm that without this patch traffic doesn't seem to work when
I force things in to SPEED_10 with ethtool (which required another
change to this driver in stmmac_ethtool.c to do so, which as far as I
understand Sarosh from your group will be upstreaming soon and is an
independent issue).

I am curious, I expected to see some dropped/errors output in ip link
when things weren't working. I guess the sgmii phy in the soc is
rejecting these prior to handing them to the mac? Or am I
misunderstanding how that works?

> ---
> v2 changelog:
> - Use FIELD_PREP to prepare bifield values in place of GENMASK
> - Add fixes tag
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index d3bf42d0fceb..df6ff8bcdb5c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -34,6 +34,7 @@
>  #define RGMII_CONFIG_LOOPBACK_EN		BIT(2)
>  #define RGMII_CONFIG_PROG_SWAP			BIT(1)
>  #define RGMII_CONFIG_DDR_MODE			BIT(0)
> +#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
>  
>  /* SDCC_HC_REG_DLL_CONFIG fields */
>  #define SDCC_DLL_CONFIG_DLL_RST			BIT(30)
> @@ -617,6 +618,9 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
>  	case SPEED_10:
>  		val |= ETHQOS_MAC_CTRL_PORT_SEL;
>  		val &= ~ETHQOS_MAC_CTRL_SPEED_MODE;
> +		rgmii_updatel(ethqos, RGMII_CONFIG_SGMII_CLK_DVDR,
> +			      FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR, 0x31),
> +			      RGMII_IO_MACRO_CONFIG);

Russell requested a comment about why you must program this every time,
I think it's a good idea too: https://lore.kernel.org/netdev/ZWch7LIqbMEaLRLW@shell.armlinux.org.uk/

Also on my wishlist is making 0x31 less magic, but Santa might not bring
that for me :)

>  		break;
>  	}
>  
> -- 
> 2.17.1
> 
> 

