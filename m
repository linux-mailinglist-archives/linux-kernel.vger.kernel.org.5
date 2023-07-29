Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3EB767E65
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 13:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjG2LBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 07:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjG2LBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 07:01:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22CD35A8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 04:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2326A60B7F
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 11:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36426C433C8;
        Sat, 29 Jul 2023 11:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690628497;
        bh=r4ub2sfb+3RGyLzoPfGridl9iQmattPqXfX7+exr16M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lGbKm1rMkfGoHjsONfO6cumIoG2Jf2qe4UP2rgQe6sDRG/jOdD/Kxr0mklt1tacfp
         cXbPigsXbB8SsTDdNWosUXxHM2wv020pbiaVX72aIgHv+HsBczN4TVb22kItJIGWTI
         H/LA7UYgfUbxyNHEKw7LbDxftDosNGj8zg2Q8AnM7c3IoB+jd2GSdF12UTrqzuUuuU
         YRn+0u9j2QGiXBoTo9Fm+BnHHp6oc1C/51sAd+aIxSAMxsvt+XM46aI+KkeVOD7ZiJ
         HfIkOOWjInK36k2T3kxTok9UIEW2viq4jeNhhXR2kT4p2xAFsAbuset+MaxswhAW+O
         NY7MR7iQaS5Jw==
Date:   Sat, 29 Jul 2023 13:01:32 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] net: dsa: microchip: KSZ9477 register regmap alignment
 to 32 bit boundaries
Message-ID: <ZMTxjP5dReD6+B3P@kernel.org>
References: <20230727081342.3828601-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727081342.3828601-1-lukma@denx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:13:42AM +0200, Lukasz Majewski wrote:
> The commit (SHA1: 5c844d57aa7894154e49cf2fc648bfe2f1aefc1c) provided code
> to apply "Module 6: Certain PHY registers must be written as pairs instead
> of singly" errata for KSZ9477 as this chip for certain PHY registers
> (0xN120 to 0xN13F, N=1,2,3,4,5) must be accesses as 32 bit words instead
> of 16 or 8 bit access.
> Otherwise, adjacent registers (no matter if reserved or not) are
> overwritten with 0x0.
> 
> Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
> bit access are out of valid regmap ranges.
> 
> As a result, following error is observed and KSZ9477 is not properly
> configured:
> 
> ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
> ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
> ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
> ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0
> 
> 
> The solution is to modify regmap_reg_range to allow accesses with 4 bytes
> boundaries.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Simon Horman <horms@kernel.org>

