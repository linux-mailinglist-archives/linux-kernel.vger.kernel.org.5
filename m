Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181B87680F1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 20:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjG2SYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjG2SYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 14:24:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4430DC;
        Sat, 29 Jul 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=SLDeV9Gd0ll0x0Hf3YTkvfpLnzT91YtzBOUBJcb/X+8=; b=3TU1y5Y8c+Axhgz66VEX8P6UcT
        riakLfdBFGt+BWlumDp30tDKIHGECoxfpHXvr4wvx4TpC+5f25wCf8O+nmtSGPg41Aahg9AQ6PwCL
        0iXh5nrYW/0SUYH3dA07Gro2G25TvnToaw9IStPi2glcXzQT2LIN9F4coyPmUIfStcO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qPobf-002bUX-Ex; Sat, 29 Jul 2023 20:23:59 +0200
Date:   Sat, 29 Jul 2023 20:23:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>     Now i wounder if you are fixing the wrong thing. Maybe you should be
>     fixing the PHY so it does not report up and then down? You say 'very
>     snall intervals', which should in fact be 1 second. So is the PHY
>     reporting link for a number of poll intervals? 1min to 10 minutes?
> 
>               Andrew
> 
> Yes, according to the log records, the phy polls every second,
> but the link status changes take time.
> Generally, it takes 10 seconds for the phy to detect link down,
> but occasionally it takes several minutes to detect link down,

What PHY driver is this?

It is not so clear what should actually happen with auto-neg turned
off. With it on, and the link going down, the PHY should react after
about 1 second. It is not supposed to react faster than that, although
some PHYs allow fast link down notification to be configured.

Have you checked 802.3 to see what it says about auto-neg off and link
down detection?

I personally would not suppress this behaviour in the MAC
driver. Otherwise you are going to have funny combinations of special
cases of a feature which very few people actually use, making your
maintenance costs higher.

	    Andrew
