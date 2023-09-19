Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A50F7A67B9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjISPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjISPNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:13:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC394;
        Tue, 19 Sep 2023 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=XYVo0DIlVrsGyb15YB580Gp7jA08wMao19ef99+f2co=; b=51K66dbVjhEQD1mTpJSuIag79U
        zndzKI2iEruUJ/3n8QYNfH8NLcaB8qykpb/y9TnDc2CPLOIFbcM9gHjvIFzuejWZVJ8GNGgdaspv2
        xepuIuKyu8Adx9j15wU8aJtu46n9h2wm1I0aXrO2v5nRVxXspBk2+2qESEJcHhctlerk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qicPn-006vKZ-CJ; Tue, 19 Sep 2023 17:13:27 +0200
Date:   Tue, 19 Sep 2023 17:13:27 +0200
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
Message-ID: <deff3e64-a10f-4d07-9651-502442a86987@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
 <14c089d7-4d34-9cd5-7f77-55c80815e003@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14c089d7-4d34-9cd5-7f77-55c80815e003@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> +static void oa_tc6_prepare_ctrl_buf(struct oa_tc6 *tc6, u32 addr, u32 val[],
> >> +                                 u8 len, bool wnr, u8 *buf, bool ctrl_prot)
> >> +{
> >> +     u32 hdr;
> >> +
> >> +     /* Prepare the control header with the required details */
> >> +     hdr = FIELD_PREP(CTRL_HDR_DNC, 0) |
> >> +           FIELD_PREP(CTRL_HDR_WNR, wnr) |
> >> +           FIELD_PREP(CTRL_HDR_AID, 0) |
> >> +           FIELD_PREP(CTRL_HDR_MMS, addr >> 16) |
> >> +           FIELD_PREP(CTRL_HDR_ADDR, addr) |
> >> +           FIELD_PREP(CTRL_HDR_LEN, len - 1);
> >> +     hdr |= FIELD_PREP(CTRL_HDR_P, oa_tc6_get_parity(hdr));
> >> +     *(u32 *)buf = cpu_to_be32(hdr);
> >> +
> >> +     if (wnr) {
> > 
> > What does wnr mean? Maybe give it a more meaningful name, unless it is
> > actually something in the standard. Kerneldoc would also help.
> Ah, it is "write not read". Shall I name it as "write_not_read" ?

You might want to describe the high level concept as well in this
file. What i _think_ this is about is that SPI is sort of a full
duplex bus. While you are sending data to the SPI device, the device
could also be sending a data to the CPU? And 'write not read' here
means ignore what we receive from the device?

> Ok, as per OA spec, up to 128 consecutive registers read or write can be 
> possible. So the maximum possible size would be 1032. As you suggested 
> will allocate this size of memory in the startup.

Yes, 1032 bytes it not huge, so allocate it once and keep it for the
lifetime of the device.

> >> +void oa_tc6_deinit(struct oa_tc6 *tc6)
> >> +{
> >> +     kfree(tc6);
> >> +}
> >> +EXPORT_SYMBOL_GPL(oa_tc6_deinit);
> > 
> > Maybe consider a devm_ API to make the MAC driver simpler.
> Sorry I don't get your point. Could you please explain bit more?

At least at this stage in the patch series, all you are doing is
allocating memory. You add more code later, which might invalidate my
point. But if all you are doing is allocating memory, you could use
devm_kmalloc(). The driver core will then take care of releasing the
memory when the driver is unloaded, or probe fails. That makes cleanup
simpler and memory leaks less likely. There are a lot of devm_
helpers, see if you can use them.

	Andrew
