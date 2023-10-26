Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6CD7D8921
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344696AbjJZTq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjJZTqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:46:54 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBFD1B2;
        Thu, 26 Oct 2023 12:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=iSmsri1S5YsHLGyRgvyYOQUdppxAE4tSQENMgUEYJTk=; b=Lj49dNdxL88asba/4AQ4/rbxuB
        uiYG0+vP8JAHgjyRrAg489KvzAsLU2SAuEWnT1oUtY3l5TamzP9W+KdNMmxSeG1Gbjnevz/rKhWiP
        /L7/mcm++PhmfdHdlU+oRqttclmche12Z9/GXbNVQAKzGUJwavfbd1CNNzfuYNNuY0gQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qw6JQ-000HAX-D9; Thu, 26 Oct 2023 21:46:36 +0200
Date:   Thu, 26 Oct 2023 21:46:36 +0200
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
Subject: Re: [PATCH net-next v2 1/9] net: ethernet: implement OPEN Alliance
 control transaction interface
Message-ID: <3c7a04a3-4ae2-4f83-b7bf-0db75f58f5be@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-2-Parthiban.Veerasooran@microchip.com>
 <c51d9660-d6c3-4202-9fc6-b9add06b64ce@lunn.ch>
 <8430c607-4a62-47fc-9c13-9ba17cf09679@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8430c607-4a62-47fc-9c13-9ba17cf09679@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Still if you feel like using "write" instead of "wnr" and "protect" 
> instead of "prote", I will change them in the next revision.

There is some value in using names from the standard, if they are
actually good names. But i guess most developers don't have a copy of
the standard by there side. 

You actually wrote in the patch:

+/* Control header */
+#define CTRL_HDR_DNC           BIT(31)         /* Data-Not-Control */
+#define CTRL_HDR_HDRB          BIT(30)         /* Received Header Bad */
+#define CTRL_HDR_WNR           BIT(29)         /* Write-Not-Read */
+#define CTRL_HDR_AID           BIT(28)         /* Address Increment Disable */
+#define CTRL_HDR_MMS           GENMASK(27, 24) /* Memory Map Selector */

The comments suggest you also don't think the names are particularly
good, otherwise you would not of added comments.

But if you instead had:

/* Control header */
#define CTRL_HDR_DATA_NOT_CTRL           BIT(31)
#define CTRL_HDR_HDR_RX_BAD              BIT(30)
#define CTRL_HDR_WRITE           	 BIT(29)
#define CTRL_HDR_ADDR_INC_DISABLE        BIT(28)
#define CTRL_HDR_MEM_MAP_SELECTOR        GENMASK(27, 24)

the names are probably sufficient that comments are not needed.  And
is should be easy for somebody to map these back to the names used in
the standard.

This also to some extent comes into the comment about coding style, a
function does one thing, is short, etc. Short functions tend to have
less indentation, meaning you can use longer names. And longer names
are more readable, making the function easier to understand, so it
does that one thing well.

    Andrew
