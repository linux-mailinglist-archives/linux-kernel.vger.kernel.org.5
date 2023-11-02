Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487E87DF2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376352AbjKBMjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376388AbjKBMjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:39:33 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616D918A;
        Thu,  2 Nov 2023 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=TIQojWmE9MxmAPu4pmyVMZLAi3i+e6rSjQXCU7X4YpY=; b=wLOyVWzdffZ8kcZX/6Ys3nEbse
        myM3WjCJSuj+r5vPeouDkpm2JbV6fEKka8u7SxZhQ6P2wrdhh3luyxWDwjBApw2IGeXfP3MJUZn+i
        PmNaGyoYQQ7MjLJSSb66v2oUTnAKON8bv3cCDXlcRDTqoELixgcF70JeADqxhB0ozSf4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyWyS-000kd6-Az; Thu, 02 Nov 2023 13:39:00 +0100
Date:   Thu, 2 Nov 2023 13:39:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
Cc:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Message-ID: <f95b42ef-b7e0-44dc-b7c8-9353e9edc2df@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <ZUOUGf-PMGo8z1s-@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUOUGf-PMGo8z1s-@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 	spe1: ethernet@1{
> 		compatible = "microchip,lan865x";
> 		reg = <1>;
> 		interrupt-parent = <&gpio5>;
> 		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
> 		spi-max-frequency = <50000000>;

That is a pretty high frequency. It is actually running at that speed?

Have you tried lower speed?

> 		oa-tc6{
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			oa-cps = <32>;
> 			oa-prote;
> 			oa-dprac;
> 		};
> 	};
> };
> 
> With this setup I'm getting a maximum throughput of about 90kB/s.
> If I increase the chunk size / oa-cps to 64 I get a might higher
> throughput ~900kB/s, but after 0-2s I get dump below (or similar).

Is this tcp traffic? Lost packets will have a big impact. You might
want to look at the link peer with tcpdump and look for retries. Also,
look if there are frames with bad checksums.

     Andrew

