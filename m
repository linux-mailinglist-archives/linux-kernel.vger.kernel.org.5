Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181A77D896E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjJZUGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJZUGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:06:51 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34E9129;
        Thu, 26 Oct 2023 13:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=H+x7KSFCuyoVLXZIAzbFV9Xg0+lArjXJ8IqhdbCVoFM=; b=48YEcNME9rmeMScPY9mah6GKwW
        zIbJ0k6hQjOUpgS1q4Ro2dylENYfj3K1HBvLSpMWttzxRow3uULdMrlaAdnqCsUldcFnfDMDlLAzq
        OasZQoR0VMSLiZFaU6iJYbBdxav3qiFe0ASgqmIVCGIRjczgRgj6EmzKYKLyLtI1j3oI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qw6cq-000HHJ-C1; Thu, 26 Oct 2023 22:06:40 +0200
Date:   Thu, 26 Oct 2023 22:06:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban.Veerasooran@microchip.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, Steen.Hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 3/9] net: ethernet: oa_tc6: implement OA TC6
 configuration function
Message-ID: <7b3179e2-ac53-497e-94c8-ac364f5b47c6@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-4-Parthiban.Veerasooran@microchip.com>
 <423e0b42-a75e-4104-b445-7d9ff0991acf@lunn.ch>
 <97872e83-1490-4f1a-81ff-3f7692571dd1@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97872e83-1490-4f1a-81ff-3f7692571dd1@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> -struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote)
> >> +struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
> > 
> > Was there a reason to have prote initially, and then remove it here?
> The reason is, control communication uses "protect". But in the first 
> patch there was no dt used. Later in this patch, dt used for all the 
> configuration parameters and this also part of that. That's why removed 
> and moved this to dt configuration.
> 
> What's your opinion? shall I keep as it is like this? or remove the 
> protect in the first two patches and introduce in this patch?

It will actually depend on what goes into the DT binding. If using
protections costs very little, i would just hard code it on. Maybe you
can run some iperf tests and see if it makes a measurable difference.

How fast an SPI bus are you using on your development board? If you
have a 50Mbps SPI bus, it does not even matter, since the media
bandwidth is just 10Mbps.

    Andrew
