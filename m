Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A166C7A641B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjISM65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjISM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:58:45 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9413F3;
        Tue, 19 Sep 2023 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=6pJg57Rcm0bmG3CDzyP2i9I6PKCyoCY99pTc1UrpBC8=; b=bZh8QSHyXJjGveMP/Dkg4hr+hR
        KOM1GS26Sr/9iplc+88NCDHXRHqKbCRO6pbQPLx2EGjjgycmX8CDMoo7Zf9wZ1DDABIu2TeGYOByQ
        f0JEpxvknIcw6dPbKvpLgPdC0W7+fSGaOZU9X/Jwu/c55ONcBRBSdWyqOb9TciWeZTC8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qiaJB-006uaR-El; Tue, 19 Sep 2023 14:58:29 +0200
Date:   Tue, 19 Sep 2023 14:58:29 +0200
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
Message-ID: <4c1d0d38-c459-4722-bead-7660d85f4925@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
 <9615b403-52c1-f24f-382f-8eea3ddfcf04@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9615b403-52c1-f24f-382f-8eea3ddfcf04@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:13:13AM +0000, Parthiban.Veerasooran@microchip.com wrote:
> Hi Andrew,
> 
> On 13/09/23 7:46 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> >> +struct oa_tc6 {
> >> +     struct spi_device *spi;
> >> +     bool ctrl_prot;
> >> +};
> > 
> > Should this be considered an opaque structure which the MAC driver
> > should not access the members?

Opaque vs not opaque is an important design decision. If the MAC
driver is allowed to directly access this structure, you should
document the locking concept. If the MAC is not supposed to access it
directly, only uses getters/setters, that also needs documenting, and
maybe even make it a void * in the MAC driver.

      Andrew
