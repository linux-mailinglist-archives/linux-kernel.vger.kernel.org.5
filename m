Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A0279DD98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 03:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbjIMBdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 21:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIMBdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 21:33:03 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D7A10E6;
        Tue, 12 Sep 2023 18:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qJBQpBNYYlkyqxjelwZuKANH81OCTF0GID3/9TLiuoA=; b=c+vvtVlalT0CtfoSTtdGkB/6UX
        0vaEIh3WXqfy+MkjaZaczVeqG94U2ZqHfGvwJQdGjY4SMFi+mg/+zn7SaEWJrQ0bbpR+zvSIoq+Cb
        l+Ik+/TZWS07EvaM6iOsaD9eS0dW7FtF8D/wqURwPHbK0STlMYosg5AJttfo8hlls9OM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgEkK-006Grg-3h; Wed, 13 Sep 2023 03:32:48 +0200
Date:   Wed, 13 Sep 2023 03:32:48 +0200
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <2021acc6-bcf6-4dba-b7ce-ca1b3ca86088@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <74a6cd9c-fb30-46eb-a50f-861d9ff5bf37@lunn.ch>
 <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ecc8364-2bd7-a134-f334-2aff31f44498@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If I understand you correctly, this framework has to include the module 
> initialization as well using the below APIs and has to be compiled as a 
> loadable module so that other vendors module can make use of this, isn't it?
> 
> module_init(oa_tc6_init);
> module_exit(oa_tc6_exit);

You should not need these, unless there is actions which need to be
taken when the module is loaded. If there are no actions, it is purely
a library, don't have them. The module dependency tracking code will
see that the MAC driver modules has dependencies on symbols in this
library module, and will load it first. The MAC driver is then loaded,
and the kernel linker will resolve the missing symbols in the MAC
driver to those in the library. It also means that there is only ever
one copy of the library in the kernel, even if there is multiple MAC
drivers using it.

       Andrew
