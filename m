Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34E77CFD46
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjJSOt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346311AbjJSOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:49:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979F130;
        Thu, 19 Oct 2023 07:49:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9bdf5829000so983465466b.0;
        Thu, 19 Oct 2023 07:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697726979; x=1698331779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1UrROzncfUZarmm/TSy/yEjSWVF3nSkzcxEecGv20ms=;
        b=f6sa1O596y9G4NoMsoUsq+3d2n7oKBD37gAJkBHhtY0qhHsweUkFp2xrm8cO73dSE2
         7FyCmT7a0Ho8OZg3gwV02nevLTPakkjGq98knA6PSfjRcGeYqZUn9BPCbf/6XDqZcsEX
         wUIVb8RFbDa4VN15V5PvE+xkynHX0pLOhI/Ywza2nRdfUs5EcymCy17bFLpBi4MOANnw
         NA9ytRIzGcTRW23FjmiLb9o67nRu/j0SgesxiETq9YM9QDdAmIl9lMGxSz6DqtfRoV4b
         ETxNkKD6ZrGdylS3oFmV8bxO6z+abmkxFgo6LqAbHEwPtW5DREUUp40M6L5oc+J4YPkR
         m0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697726979; x=1698331779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UrROzncfUZarmm/TSy/yEjSWVF3nSkzcxEecGv20ms=;
        b=QfgLkCXlSQsvHIHP/95EgBnmEtxBa0+4K2WVndKcKTq9ZACkJ1N12j0L1yCfTBszJV
         oG9S3dww0wgYqJ8r8p0HdZVyiEzvFzXhQ9U3YhKFo4zDZDtrJT3NC79Afs2CmGp5PejP
         Zi1J8rdJ8ecJ15XDXdu6WELFXcSYxJmD7lr0tFTC/KKA3LPEoEQ2UaFjV6okaTNJBL6G
         cfO3zUsstSAfGIeIbRSqyCpFeQLWOT23+Zt/k98a8kfDgcQVeohqV+7cQiLAuDB+Srfw
         uWBjrGpf9w4YoAlfIBP2amPWHga6pPXhCLm/b+wvtWHG/GyvDdk1D3p7hA0fda5OS1O6
         23OA==
X-Gm-Message-State: AOJu0YwuhpVL67MtYN0KYeh9Jk6+Euhc1gaFQmQNdGbCDAla8Nmre1td
        yqD7kZS0nn0sGCJI+/mQgp8=
X-Google-Smtp-Source: AGHT+IEikpJiGCrfEciG/A1zcBBKrzN+hrLe/h7mhbzpCNe9XJuqFeUVwUwqnJukEn/D2p0KFDhUNg==
X-Received: by 2002:a17:907:6eac:b0:9bf:792:d696 with SMTP id sh44-20020a1709076eac00b009bf0792d696mr2261658ejc.46.1697726977896;
        Thu, 19 Oct 2023 07:49:37 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709063b4300b009b9aa8fffdasm3654934ejf.131.2023.10.19.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 07:49:37 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:49:35 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
Message-ID: <20231019144935.3wrnqyipiq3vkxb7@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-5-3ee0c67383be@linaro.org>
 <20231019144021.ksymhjpvawv42vhj@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019144021.ksymhjpvawv42vhj@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 05:40:22PM +0300, Vladimir Oltean wrote:
> +Marek
> 
> On Wed, Oct 18, 2023 at 11:03:44AM +0200, Linus Walleij wrote:
> > Fix some errors in the Marvell MV88E6xxx switch descriptions:
> > - The top node had no address size or cells.
> > - switch0@0 is not OK, should be switch@0.
> > 
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > index 9eab2bb22134..c69cb4e191e5 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > @@ -305,7 +305,7 @@ phy1: ethernet-phy@1 {
> >  	};
> >  
> >  	/* switch nodes are enabled by U-Boot if modules are present */
> > -	switch0@10 {
> > +	switch@10 {
> 
> As the comment says: U-Boot
> (https://elixir.bootlin.com/u-boot/latest/source/board/CZ.NIC/turris_mox/turris_mox.c#L728)
> sets up status = "okay" for these nodes depending on the MOXTET
> configuration. It doesn't look as if it's doing that by alias, just by
> path ("%s/switch%i@%x").
> 
> I have a Turris MOX, please allow me some time to test if the node name
> change is going to be significant and cause regressions. I expect the
> answer to be yes (sadly).

Yeah, it's bad.

U-Boot 2018.11 (Dec 16 2018 - 12:50:19 +0000), Build: jenkins-turris-os-packages-kittens-mox-90

DRAM:  1 GiB
Enabling Armada 3720 wComphy-0: SGMII1        3.125 Gbps
Comphy-1: PEX0          5 Gbps
Comphy-2: USB3_HOST0    5 Gbps
MMC:   sdhci@d8000: 0
Loading Environment from SPI Flash... SF: Detected w25q64dw with page size 256 Bytes, erase size 4 KiB, total 8 MiB
OK
Model: CZ.NIC Turris Mox Board
Net:   eth0: neta@30000
Turris Mox:
  Board version: 22
  RAM size: 1024 MiB
  SD/eMMC version: SD
Module Topology:
   1: Peridot Switch Module (8-port)
   2: Peridot Switch Module (8-port)
   3: Peridot Switch Module (8-port)
   4: SFP Module

Hit any key to stop autoboot:  0
=> run sd_tftp_boot
neta@30000 Waiting for PHY auto negotiation to complete....... done
BOOTP broadcast 1
BOOTP broadcast 2
DHCP client bound to address 10.0.0.117 (254 ms)
Using neta@30000 device
TFTP from server 10.0.0.1; our IP address is 10.0.0.117
Filename 'mox/armada-3720-turris-mox.dtb'.
Load address: 0x4f00000
Loading: ####
         1.5 MiB/s
done
Bytes transferred = 19479 (4c17 hex)
Using neta@30000 device
TFTP from server 10.0.0.1; our IP address is 10.0.0.117
Filename 'mox/Image'.
Load address: 0x5000000
Loading: #################################################################
         ##########################################
         6 MiB/s
done
Bytes transferred = 54069760 (3390a00 hex)
## Flattened Device Tree blob at 04f00000
   Booting using the fdt blob at 0x4f00000
   Loading Device Tree to 000000003bf16000, end 000000003bf1dc16 ... OK
ERROR: board-specific fdt fixup failed: FDT_ERR_NOTFOUND
 - must RESET the board to recover.

FDT creation failed! hanging...### ERROR ### Please RESET the board ###
