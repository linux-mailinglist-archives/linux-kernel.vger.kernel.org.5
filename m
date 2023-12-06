Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0FB807C9C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjLFX6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjLFX6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D611F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701907125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iMfMtI/O0jIiZbunMjgS2xYQfG8mFWEFBfbJJAbpGQ8=;
        b=bre9SM7gSQ1964IkHmGhTnxHUjmBOAv/z+sk8yxijsYj6jnaEUTteF3JPLbAu1K0Kvk4oj
        3htT8/RRQ2VjwVYirKZn+DYwO17Kzg0PaJljbfFO0V84Ec4vRJInr47zQcHyfTrax0+mmJ
        uXIP7jMAKw0orAUtvQphGxGaarD6q8c=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-RVrIJR0gO02hQe8zHc0EtA-1; Wed, 06 Dec 2023 18:58:43 -0500
X-MC-Unique: RVrIJR0gO02hQe8zHc0EtA-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d9aafe6575so428599a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 15:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701907123; x=1702511923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMfMtI/O0jIiZbunMjgS2xYQfG8mFWEFBfbJJAbpGQ8=;
        b=r0+LbeJfYPVbyMA83G5tFfrPD8U4T6pZ+yxWspqUmst5WzKV8qIGGgyasmPQUzInNR
         mOzj3aB2pFOl2lTyU0D9z7MZJ8GscXkVKkixsk2N8vM8wbIY19jkvFrkGkSQKgzfElT6
         Gy0UGIWM4qYk3THO90Mww4xfrOg1U/0C6Vq/C06UG1QA8wYOWcrHn5tiT6F9VTvtmRyP
         GQi3LeV5oom6LobmsWmIMRkPSf72QqdI7eYheESeYQJRv1UGKwyQfdQhrjS6o8CVQeTr
         iKZY6IDIQEU+MLYLR38jlD959C78OUpnb+p3xb9kQGoxtIxfJxAf+VveaDzBlL6+1ING
         JKdA==
X-Gm-Message-State: AOJu0YybTHN2TNXKOXJPE/MpyuwsWYAkq3fI7EMlglGlOOnotKF1EAVB
        WnpzLHzwDpnrv44eEXT61P7ouWnOPYpTjRB0DQkuw+EAzfp3mNiCwPsM5Cx1hsnOt2Gn3PdtSXe
        kiGhVurnWuFAc2MSK2EtQSgsN
X-Received: by 2002:a05:6830:7181:b0:6d8:20b3:b1db with SMTP id el1-20020a056830718100b006d820b3b1dbmr1816319otb.38.1701907123212;
        Wed, 06 Dec 2023 15:58:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmQIfsUa078g71FcFgEGySz43PAmZThnQyujRyHJ+s5jQA3gXSH1Xxl5XAcJeDcLqpXjZ6nQ==
X-Received: by 2002:a05:6830:7181:b0:6d8:20b3:b1db with SMTP id el1-20020a056830718100b006d820b3b1dbmr1816307otb.38.1701907122992;
        Wed, 06 Dec 2023 15:58:42 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id v7-20020ac87487000000b004255638e8b9sm37725qtq.79.2023.12.06.15.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:58:42 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:58:40 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <nmkpcss5pymkjitcf2o3pwu3r2rbu3kfy2ubtkpmktw6worj5p@rk5aljx6slwi>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
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

On Wed, Dec 06, 2023 at 05:46:09PM -0600, Andrew Halaney wrote:
> The stmmac_dt_phy() function, which parses the devicetree node of the
> MAC and ultimately causes MDIO bus allocation, misinterprets what
> fixed-link means in relation to the MAC's MDIO bus. This results in
> a MDIO bus being created in situations it need not be.
> 
> Currently a MDIO bus is created if the description is either:
> 
>     1. Not fixed-link
>     2. fixed-link but contains a MDIO bus as well
> 
> The "1" case above isn't always accurate. If there's a phy-handle,
> it could be referencing a phy on another MDIO controller's bus[1]. In
> this case currently the MAC will make a MDIO bus and scan it all
> anyways unnecessarily.
> 
> There's also a lot of upstream devicetrees[2] that expect a MDIO bus to
> be created and scanned for a phy. This case can also be inferred from
> the platform description by not having a phy-handle && not being
> fixed-link. This hits case "1" in the current driver's logic.
> 
> Let's improve the logic to create a MDIO bus if either:
> 
>     - Devicetree contains a MDIO bus
>     - !fixed-link && !phy-handle (legacy handling)
> 
> Below upstream devicetree snippets can be found that explain some of
> the cases above more concretely.
> 
> Here's[0] a devicetree example where the MAC is both fixed-link and
> driving a switch on MDIO (case "2" above). This needs a MDIO bus to
> be created:
> 
>     &fec1 {
>             phy-mode = "rmii";
> 
>             fixed-link {
>                     speed = <100>;
>                     full-duplex;
>             };
> 
>             mdio1: mdio {
>                     switch0: switch0@0 {
>                             compatible = "marvell,mv88e6190";
>                             pinctrl-0 = <&pinctrl_gpio_switch0>;
>                     };
>             };
>     };
> 
> Here's[1] an example where there is no MDIO bus or fixed-link for
> the ethernet1 MAC, so no MDIO bus should be created since ethernet0
> is the MDIO master for ethernet1's phy:
> 
>     &ethernet0 {
>             phy-mode = "sgmii";
>             phy-handle = <&sgmii_phy0>;
> 
>             mdio {
>                     compatible = "snps,dwmac-mdio";
>                     sgmii_phy0: phy@8 {
>                             compatible = "ethernet-phy-id0141.0dd4";
>                             reg = <0x8>;
>                             device_type = "ethernet-phy";
>                     };
> 
>                     sgmii_phy1: phy@a {
>                             compatible = "ethernet-phy-id0141.0dd4";
>                             reg = <0xa>;
>                             device_type = "ethernet-phy";
>                     };
>             };
>     };
> 
>     &ethernet1 {
>             phy-mode = "sgmii";
>             phy-handle = <&sgmii_phy1>;
>     };
> 
> Finally there's descriptions like this[2] which don't describe the
> MDIO bus but expect it to be created and the whole address space
> scanned for a phy since there's no phy-handle or fixed-link described:
> 
>     &gmac {
>             phy-supply = <&vcc_lan>;
>             phy-mode = "rmii";
>             snps,reset-gpio = <&gpio3 RK_PB4 GPIO_ACTIVE_HIGH>;
>             snps,reset-active-low;
>             snps,reset-delays-us = <0 10000 1000000>;
>     };
> 
> [0] https://elixir.bootlin.com/linux/v6.5-rc5/source/arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts
> [1] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
> [2] https://elixir.bootlin.com/linux/v6.6-rc5/source/arch/arm64/boot/dts/rockchip/rk3368-r88.dts#L164
> 
> Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---

Gah, I failed to describe my changes since Bart's v1 when picking this
up with b4 to make v2. Whoops!

Changes since v1:
    - Handle the fixed-link + mdio case (Andrew Lunn)
    - Reworded commit message
    - Handle the "legacy" case still mentioned in the commit
    - Bit further refactoring of the function

