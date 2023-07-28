Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3157667F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjG1I6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbjG1I6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:58:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9ABA1731;
        Fri, 28 Jul 2023 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XO04uRIxA4guTxkcu7RQ08+aVzvwwBtSGQVQXA0Q9qY=; b=YW8CDX+BSc+DoSsnuaaZktrZz2
        kCfgSWqWG0mc07IWwSkwV/nAj+QpdmxsgqTPkwBQpN9FJJeOKZOXtYLxMm34DK5b+RHS6hbFKjZl5
        b6AhT3lsOPdaQE5iBux5Jvos5RJvBE/gmISN4uj4lfahQnSkPejXnEpXUpgSPUiMtuTw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qPJII-002WG8-IX; Fri, 28 Jul 2023 10:57:54 +0200
Date:   Fri, 28 Jul 2023 10:57:54 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, wangpeiyang1@huawei.com,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728075840.4022760-6-shaojijie@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 03:58:39PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> This patch will fix a wrong print "device link down/up". Consider a case
> that set autoneg to off with same speed and duplex configuration. The link
> is always up while the phy state is set to PHY_UP and set back to
> PHY_RUNNING later. It will print link down when the phy state is not
> PHY_RUNNING. To avoid that, the condition should include PHY_UP.

Does this really happen? If autoneg is on, and there is link, it means
the link peer is auto using auto-neg. If you turn auto-neg off, the
link peer is not going to know what speed to use, and so the link will
go down. The link will only come up again when you reconfigure the
link peer to also not use auto-neg.

I don't see how you can turn auto-neg off and not loose the link.

  Andrew
