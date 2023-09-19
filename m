Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2025C7A63EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbjISMzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjISMzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:55:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D441DF3;
        Tue, 19 Sep 2023 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1Npvrzyz+/TZN9YuhYrSAlYVBkFpFs1Wg2sTP1rKTzM=; b=XXl0VR2tj8IyKUOHxyeVKdBQ12
        QbqTt8W+/Un78rkZaHzfMrIOQfiPRpMR423vSz4l8tSzehXttY60c+iOpNCet9ysn7EAbYhBdUPyT
        KKUq+vcVhFuT4suCzdVfZvc1mfP7pWTaeatTbcKuDD3L4r1sYPzuYMaYJzyhP0c7UuQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiaFb-006uYS-1A; Tue, 19 Sep 2023 14:54:47 +0200
Date:   Tue, 19 Sep 2023 14:54:47 +0200
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
Subject: Re: [RFC PATCH net-next 3/6] net: ethernet: implement OA TC6
 configuration function
Message-ID: <d2d26c6c-0345-46cf-b806-15834ba8b40f@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-4-Parthiban.Veerasooran@microchip.com>
 <dd0a6cd5-91e5-4e13-8025-d6c88bdab5a2@lunn.ch>
 <46fab729-4c5a-1a6e-37d0-fea62c0717f7@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fab729-4c5a-1a6e-37d0-fea62c0717f7@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +/* Unmasking interrupt fields in IMASK0 */
> >> +#define HDREM                ~BIT(5)         /* Header Error Mask */
> >> +#define LOFEM                ~BIT(4)         /* Loss of Framing Error Mask */
> >> +#define RXBOEM               ~BIT(3)         /* Rx Buffer Overflow Error Mask */
> >> +#define TXBUEM               ~BIT(2)         /* Tx Buffer Underflow Error Mask */
> >> +#define TXBOEM               ~BIT(1)         /* Tx Buffer Overflow Error Mask */
> >> +#define TXPEM                ~BIT(0)         /* Tx Protocol Error Mask */
> > 
> > Using ~BIT(X) is very usual. I would not do this, Principle of Least
> > Surprise.
> Sorry, I don't get your point. Could you please explain bit more?

Look around kernel header files. How often do you see ~BIT(5)?  My
guess it is approximately 0. So i'm suggesting you remove the ~ and
have the user of the #define assemble the mask and then do the ~ .

     Andrew
