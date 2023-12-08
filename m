Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1215F80A909
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574128AbjLHQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573889AbjLHQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:33:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE54199B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702053226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hXw0XZZEim7nEEhz34fa5B4jxIHSBv8a2Eg+0Dnfzpg=;
        b=KyAoYNhXVJUv7MC4P6NNRagRGkmvQ7J4Jocst9wPoBkgjWO6NO6iIGb/iRGDG++m9UJ0xR
        QPUyU2AjkkxAxRdNlAFNw6gKH+rbgDFUropulT70wRpu4oAkrQbQ+lLRfGa6g81gQwCbWs
        s/fwfpvSNca/vzNs9bxd8ww3nKfIknQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-S33djehZO6ab79BmDdkZRA-1; Fri, 08 Dec 2023 11:33:44 -0500
X-MC-Unique: S33djehZO6ab79BmDdkZRA-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4259aafd543so14193331cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 08:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053224; x=1702658024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXw0XZZEim7nEEhz34fa5B4jxIHSBv8a2Eg+0Dnfzpg=;
        b=FEwxRXVnxK1L90K6HCuWlEsFu6miU3EcG/L5l0yy632fAATpCtG/y0z0aoOXN50CKa
         oh9yZWo00+nuxDv421hDhF/9SqkAIE4Sr4EWikXREYNUnA1NWuZnXP4n8OMDseZGo9Nr
         YNkpsb6DZjg+k2A92wCMgzL5W2dM+m5dfauHy8yJIDp9TDxqxYUQ8WOP/j1Tyhebe9PC
         MCbbM27wlkQSoHY6uj4iDDF2DS3Gy8Nh0mKMfQ13+3BM/ogh50HMN9+2LUgsRNH4K3QA
         la9/qyuHl4KmmGV632EdIzEkowNq+1ikzg116cdGZJvILWy9rMyrU4Ggzzg6gOlH1jzQ
         ZZKg==
X-Gm-Message-State: AOJu0Yzf/Aij9Gp+9UDR4loflB1SIvb9hZlvob69VA8aPuJ5zUW6d7/Y
        xSKSQ+89eosLS199bJacKrmLTvRSFwGb2p5qcDRNSckfPtOoJLYE3BRdlunb2R3UWgixclFkJNF
        c80pKNN3UgqnB3KfoDIXl2Nt7
X-Received: by 2002:ac8:5f8f:0:b0:423:b118:100a with SMTP id j15-20020ac85f8f000000b00423b118100amr397492qta.1.1702053224383;
        Fri, 08 Dec 2023 08:33:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHH9bHNB0WsJAVj+oZ5YejD6BIs/ceRUycn4p6BwtXybFF1QZpkQFOT/VWn88opyf/TmalPZw==
X-Received: by 2002:ac8:5f8f:0:b0:423:b118:100a with SMTP id j15-20020ac85f8f000000b00423b118100amr397476qta.1.1702053224087;
        Fri, 08 Dec 2023 08:33:44 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::47])
        by smtp.gmail.com with ESMTPSA id p20-20020ac87414000000b00423dfab8fc3sm929789qtq.32.2023.12.08.08.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:33:43 -0800 (PST)
Date:   Fri, 8 Dec 2023 10:33:41 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH net-next v2] net: stmmac: don't create a MDIO bus if
 unnecessary
Message-ID: <plvbqgi2bwlv5quvpiwplq7cxx6m5rl3ghnfhuxfx4bpuhyihl@zmydwrtwdeg6>
References: <20231206-stmmac-no-mdio-node-v2-1-333cae49b1ca@redhat.com>
 <e64b14c3-4b80-4120-8cc4-9baa40cdcb75@lunn.ch>
 <nx2qggr3aget4t57qbosj6ya5ocq47t6w33ve5ycabs5mzvo7c@vctjvc5gip5d>
 <9eddb32d-c798-4e1b-b0ea-c44d31cc29bf@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eddb32d-c798-4e1b-b0ea-c44d31cc29bf@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 02:14:41PM +0100, Andrew Lunn wrote:
> > I know you said the standard is to make the MDIO bus unconditionally, but
> > to me that feels like a waste, and describing say an empty MDIO bus
> > (which would set the phy_mask for us eventually and not scan a
> > bunch of phys, untested but I think that would work) seems like a bad
> > description in the devicetree (I could definitely see describing an
> > empty MDIO bus getting NACKed, but that's a guess).
> 
> DT describes the hardware. The MDIO bus master exists. So typically
> the SoC .dtsi file would include it in the Ethernet node. At the SoC
> level it is empty, unless there is an integrated PHY in the SoC. The
> board .dts file then adds any PHYs to the node which the board
> actually has.
> 
> So i doubt adding an empty MDIO node to the SoC .dtsi file will get
> NACKed, it correctly describes the hardware.

Agreed, thanks for helping me consider all the cases. In my particular
example it would make sense to have SoC dtsi describe the mdio bus,
leave it disabled, and boards enable it and describe components as
necessary.

So you have let's say these 8 abbreviated cases:

Case 1 (MDIO bus used with phy on bus connected to MAC):

	ethernet {
		status = "okay";
		phy-handle = <&phy0>;
		phy-mode = "rgmii";

		mdio {
			status = "okay";

			phy0: phy@0 {
			};
		};
	};

Case 2 (MDIO bus used but MAC's connect fixed-link):

	ethernet {
		status = "okay";
		phy-mode = "rgmii";

		fixed-link {
		};

		mdio {
			status = "okay";

			switch/unrelated-phy {
			};
		};
	};

Case 3 (MDIO bus used but MAC's connected to another bus's phy):

	ethernet {
		status = "okay";
		phy-handle = <&phy1>;
		phy-mode = "rgmii";

		mdio {
			status = "okay";

			switch/unrelated-phy {
			};
		};
	};

Case 4 (MDIO bus disabled/unused, connected fixed-link):

	ethernet {
		status = "okay";
		phy-mode = "rgmii";

		fixed-link {
		};

		mdio {
			status = "disabled";
		};
	};

Case 5 (MDIO bus disabled/unused, connected to another bus's phy):

	ethernet {
		status = "okay";
		phy-handle = <&phy1>;
		phy-mode = "rgmii";

		mdio {
			status = "disabled";
		};
	};

Case 6 (MDIO bus not described, connected fixed-link):

	ethernet {
		status = "okay";
		phy-mode = "rgmii";

		fixed-link {
		};
	};

Case 7 (MDIO bus not described, connected to a different bus's phy):

	ethernet {
		status = "okay";
		phy-handle = <&phy1>;
		phy-mode = "rgmii";
	};

Case 8 (MDIO bus not described, but phy on MDIO bus is connected to MAC,
        legacy description[2] in my commit message):

	ethernet {
		status = "okay";
	};


If we look at the logic in stmmac today about how to handle the MDIO
bus, you've got basically:

	if !fixed-link || mdio_node_present()
		of_mdiobus_register(np)

Applying current stmmac logic to our cases...

Case 1 (MDIO bus used with phy on bus connected to MAC):
    MDIO bus made, no unnecessary scanning

Case 2 (MDIO bus used but MAC's fixed-link):
    MDIO bus made, no unnecessary scanning

Case 3 (MDIO bus used but MAC's connected to another bus's phy):
    MDIO bus made, no unnecessary scanning

Case 4 (MDIO bus disabled/unused, connected fixed-link):
    MDIO bus attempted to be made, fails -ENODEV due to disabled
    and stmmac returns -ENODEV from probe too

Case 5 (MDIO bus disabled/unused, connected to another bus's phy):
    MDIO bus attempted to be made, fails -ENODEV due to disabled
    and stmmac returns -ENODEV from probe too

Case 6 (MDIO bus not described, connected fixed-link):
    MDIO bus not created

Case 7 (MDIO bus not described, connected to a different bus's phy):
    MDIO bus created, but the whole bus is scanned

Case 8 (MDIO bus not described, but phy on MDIO bus is connected to MAC,
        legacy description[2] in my commit message):
    MDIO bus created, the whole bus is scanned and the undescribed but
    necessary phy is found


The things I note of interest are cases 4, 5, 7, 8. Cases 4/5 are a bug in
stmmac IMO, which breaks the devicetree description you mentioned as
ideal in my case. Case 7 is the one I'm currently working with, and the
devicetree can be updated to match case 5, but right now case 7 makes a
bus and scans it needlessly which isn't great. It _sounds_ like to me
Serge knows of stmmac variants that also *do not* have an MDIO controller,
so they'd fall in this case too and really shouldn't create a bus. Case 8
is the legacy one that I wish didn't exist, but it does, and for that
reason we should continue to make a bus and scan the whole thing if we can't
figure out what the MAC's connected to.

So in my opinion there's 3 changes I want to make based on all the
use cases I could think of:

    1. This patch, which improves the stmmac logic and stops making
       a bus for case 7
    2. A new patch to gracefully handle cases 4/5, where currently if the
       MDIO bus is disabled in the devicetree, as it should be,
       stmmac handles -ENODEV from of_mdiobus_register() as a failure
       instead of gracefully continuing knowing this is fine and dandy.
    3. Clean up the sa8775p dts to have the MDIO bus described in the
       SoC dtsi and left disabled instead of undescribed (a more
       accurate hardware description).

Please let me know if you see any holes in my logic, hopefully the
wall of text is useful in explaining how I got here.

Thanks,
Andrew

