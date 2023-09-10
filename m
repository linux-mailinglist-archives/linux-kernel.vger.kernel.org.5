Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FA4799F34
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 19:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjIJR6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 13:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjIJR6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 13:58:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C21180;
        Sun, 10 Sep 2023 10:58:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65527C433C7;
        Sun, 10 Sep 2023 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694368710;
        bh=NH8cClsBXDOEH39n3025iXsEaUUDx0eXXxKoTLrsTfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nw1169OdRDD27uQy6uZv9dnITBYxHgo+JW2YfIRjTb+SrKxvk96R7dhKWXFTuUuOd
         QzvFa0FU0aXP0Dn5dSxdHGMRSqn9HXJo9qq6E6sLqHeUdwaCN4m/Fc18dsV9+nx8aF
         vrvYUky2hIb0H7BnGLutaJUrtREANLGqLLlZm+lcpX/tGrEZsPgPOAK74+cqia7KZI
         jNYY2BtRk7UZ47V3lMrsFaJVUdB+430XAv23IDypced/r1ARFcP7I07J0hn+Lb4uq/
         TvJQLpjtvL6cbxp1jIrqFm3GDqlbrN637P51Q88Kj0oJ/p6x3FZ2/Pr/B27wN43zMB
         si7gR6HPyzOqg==
Date:   Sun, 10 Sep 2023 19:58:24 +0200
From:   Simon Horman <horms@kernel.org>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, casper.casan@gmail.com, andrew@lunn.ch,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Message-ID: <20230910175824.GL775887@kernel.org>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 07:59:17PM +0530, Parthiban Veerasooran wrote:
> The ethernet frame to be sent to MAC-PHY is converted into multiple
> transmit data chunks. A transmit data chunk consists of a 4-byte data
> header followed by the transmit data chunk payload.
> 
> The received ethernet frame from the network is converted into multiple
> receive data chunks by the MAC-PHY and a receive data chunk consists of
> the receive data chunk payload followed by a 4-byte data footer at the
> end.
> 
> The MAC-PHY shall support a default data chunk payload size of 64 bytes.
> Data chunk payload sizes of 32, 16, or 8 bytes may also be supported. The
> data chunk payload is always a multiple of 4 bytes.
> 
> The 4-byte data header occurs at the beginning of each transmit data
> chunk on MOSI and the 4-byte data footer occurs at the end of each
> receive data chunk on MISO. The data header and footer contain the
> information needed to determine the validity and location of the transmit
> and receive frame data within the data chunk payload. Ethernet frames
> shall be aligned to a 32-bit boundary within the data chunk payload.
> 
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Hi Parthiban,

this patch seems to introduce new Sparse warnings.
Please consider addressing those, and ideally the warnings
flagged in the existing oa_tc6.c code.

Thanks in advance!
