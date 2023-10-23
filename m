Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A37D42D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 00:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjJWWn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 18:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjJWWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 18:43:24 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB910D;
        Mon, 23 Oct 2023 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=24p8BHx6MaOc5tKzsfG7lYznwTHMjop8dTU1j4DR320=; b=ZgFIcAUVRCZO2ubTTUA88FsjRr
        Y4LTCoihimQS+pWb8UxiOZOXhMJACHJddOFM1AVa6z1Ex62njjJ/TrOEXurT311O6aIVo8Azxei64
        Xr57fgZAmOOrwvrI/dpWXXP1axHELW7Zj3bAASc52WT8q3QNSKUny7+tz7+ubYwk48tA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qv3dZ-0001HN-Ba; Tue, 24 Oct 2023 00:43:05 +0200
Date:   Tue, 24 Oct 2023 00:43:05 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy
 software reset
Message-ID: <219ae3d7-0c75-49c0-b791-5623894ba318@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	ret = oa_tc6_perform_ctrl(tc6, RESET, &regval, 1, true, true);
> +	ret = oa_tc6_perform_ctrl(tc6, RESET, &regval, 1, true, false);

Just looking at this, it is not clear what these true/false mean. Maybe add some #defines

#define TC6_READ true
#define TC6_WRITE false
#define TC6_PROTECTED true
#define TC6_UNPROTECTED false

> +	if (ret)
> +		return ret;
> +
> +	/* The chip completes a reset in 3us, we might get here earlier than
> +	 * that, as an added margin we'll conditionally sleep 5us.
> +	 */
> +	udelay(5);
> +
> +	ret = oa_tc6_perform_ctrl(tc6, STATUS0, &regval, 1, false, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Check for reset complete interrupt status */
> +	if (regval & RESETC) {
> +		regval = RESETC;

People don't always agree, but i found STATUS0_RESETC easier to see
you have the correct bit for the register you just read.

	Andrew
