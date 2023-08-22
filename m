Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E646784AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjHVUBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHVUBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:01:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2FB1AD;
        Tue, 22 Aug 2023 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=LXHug3TLN9P2+6rbiOjOGu7mrHI3vo5m1kq9IAwgsjM=; b=mipLXy/CGBIquuykD+YLEvlNHU
        ab3aPgI7yTiDB6Q34WJY9XJ2g3Vn85W15Br9SUduydtZ8eGaEzMoXZlfepBd9RtS20YHCYU3M6LDF
        w56212iOrtzLuHiIfEwYz3xRuI5+yHYHT2SSpkaQaX4msuJ4m+55nCFgtUehWdLoGyfM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qYXYa-004oiQ-AT; Tue, 22 Aug 2023 22:00:52 +0200
Date:   Tue, 22 Aug 2023 22:00:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] net: hpe: Add GXP UMAC Driver
Message-ID: <befbee5a-7b11-4948-a837-6311dd4d7276@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-5-nick.hawkins@hpe.com>
 <01e96219-4f0c-4259-9398-bc2e6bc1794f@lunn.ch>
 <88B3833C-19FB-4E4C-A398-E7EF3143ED02@hpe.com>
 <1b8058e1-6e7f-4a4a-a191-09a9b8010e0a@lunn.ch>
 <CF9BD927-B788-4554-B246-D5CC6D06258F@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF9BD927-B788-4554-B246-D5CC6D06258F@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 07:00:49PM +0000, Hawkins, Nick wrote:
> 
> > <include/net/page_pool/helpers.h>
> 
> Hi Andrew,
> 
> I can't seem to find this file in linux master. Where is it?

~/linux$ ls include/net/page_pool/helpers.h
include/net/page_pool/helpers.h

When you say master, do you mean net-next/main? This is a network
driver, so you should be based on top of that tree.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

> > Take a look at driver/net/ethernet/freescale/fec_main.c That
> > driver/device is of similar complexity to yours. It had a recent
> > change from its own buffer management to page pool. It
> > started with
> 
> I have looked over this driver and have a couple questions
> about the pages in general.
> 
> How do I determine what the correct pool size should be for the
> RX and TX?

There has been some recent discussion about that. Search the netdev
list over the last couple of week. 

> I must admit I am not familiar with XDP.
> Is it required for the page pool library?

Nope, not required at all. The FEC driver was first converted to page
pool, and then XDP support added. The conversion to page pool made the
driver faster, it could handle more packets per second. That is why i
suggested using it, plus it means less driver code, which means less
bugs.

	Andrew
