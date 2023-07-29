Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69141767D03
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 09:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjG2H60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 03:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjG2H6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 03:58:24 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15CF3;
        Sat, 29 Jul 2023 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jeX6gnaLyhsoAgNas3HST4lthFFpKYPYStpcK6Njo6g=; b=D1qdioZucg2bpafH4c1Mq9fc56
        W5GlUEtNAw+xQd2R6YXXqCGYRCTKIhIA9R7o9ZHQaCcUiZuZnZpLN75y9m/S0FxMJPkVyR8nAxl7I
        Uyf1LvfFCRDHCaLHAUpgUJIf5thNQUJvLMLbJOcKdVIwlQgB937aWKzNWQIJClTFEQn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qPepr-002a1W-U6; Sat, 29 Jul 2023 09:57:59 +0200
Date:   Sat, 29 Jul 2023 09:57:59 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 11:11:48AM +0800, Jijie Shao wrote:
> Hi Andrew,
> I understand what you mean, and sorry for my wrong description. The link
> is not always up. If I turn auto-neg off, the link will go down finally.
> However, there is an intervel between my operation and the link down. In
> my experiment, it may be 1 min or evn 10 mins. The phy state is set to
> PHY_UP immediately when I set auto-neg off. And the phy machine check the
> state during a very small intervals. Thus, during my experiment, the phy
> state has a followed varietion:
> PHY_RUNNING -> PHY_UP -> PHY_RUNNING -> PHY_NOLINK.
> 
> We print link up/down based on phy state and link state. In aboved case,
> It print looks like:
> eth0 link down -- because phy state is set to PHY_UP
> eth0 link up -- because phy state is set to PHY_RUNNING
> eth0 link down -- because link down
> 
> This patch wants to fix the first two wrong print.
> We will modify this patch description

Now i wounder if you are fixing the wrong thing. Maybe you should be
fixing the PHY so it does not report up and then down? You say 'very
snall intervals', which should in fact be 1 second. So is the PHY
reporting link for a number of poll intervals? 1min to 10 minutes?

	  Andrew

