Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77347D895B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjJZUBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbjJZUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:01:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E00E10CE;
        Thu, 26 Oct 2023 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=vKObmcd+bmpwndDhxnFsTImwwHwCmQi0gNuW0Otfi50=; b=icdFqdMTeZroD4aWMc9ieNuqQc
        Rg+qHzTO4C+UKoT/erL/j8EpUIGcgwxRoPG/gUb47CRUUoMXyjRZy6pfCl4gxIX13jaJMCjO8HP8T
        HwyjEp85r6+jKeHcPYSF7stVOVv0Jj+lkyrOp2b8Ra9P+AsU5RcwoCVjO/VjYg8iMfX8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qw6Xo-000HFI-Gs; Thu, 26 Oct 2023 22:01:28 +0200
Date:   Thu, 26 Oct 2023 22:01:28 +0200
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
Subject: Re: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Message-ID: <005b6980-4aa3-4bf7-92cc-d9f938b04006@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
 <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
 <fe52e414-c2a7-4e29-bb37-73a5614b3951@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe52e414-c2a7-4e29-bb37-73a5614b3951@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +     ret = oa_tc6_perform_ctrl(tc6, STATUS0, &regval, 1, false, false);
> >> +     if (ret)
> >> +             return ret;
> >> +
> >> +     /* Check for reset complete interrupt status */
> >> +     if (regval & RESETC) {
> >> +             regval = RESETC;
> > 
> > People don't always agree, but i found STATUS0_RESETC easier to see
> > you have the correct bit for the register you just read.
> Do you want me to define STATUS0_RESETC instead of RESETC or is my 
> understanding wrong?

Correct, STATUS0_RESETC. It avoids silly typos like:

     ret = oa_tc6_perform_ctrl(tc6, STATUS0, &regval, 1, false, false);
     if (ret)
             return ret;

     /* Check for reset complete interrupt status */
     if (regval & RESET) {
             regval = RESETC;

where RESET is a valid register name, but not a bit. Or say:

     ret = oa_tc6_perform_ctrl(tc6, STATUS0, &regval, 1, false, false);
     if (ret)
             return ret;

     /* Check for reset complete interrupt status */
     if (regval & SWRESET) {
             regval = STATUS0_;

where SWRESET is a valid bit, but not for STATUS0.

I've made silly mistakes like this, and learnt that good naming helps
to avoid it.

     Andrew
