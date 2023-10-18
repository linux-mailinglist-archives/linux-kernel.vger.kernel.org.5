Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035F7CE4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJRRh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJRRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:37:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F74198
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:37:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24585C433CA;
        Wed, 18 Oct 2023 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697650625;
        bh=geOBo95O/K4ooFlTQc6NiW8YW2+mC1AuPcK2r9RbM60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXJfEeKWIEFL037wd9Kx1uRUp4vBF0hK+5pVBFk/LlLMQnkZgzbXWX/0iVZCFJSyP
         W7sTaRni2aOXaaP1bp9sZ/yR4HHmCvBAxxsNVcBx4OEsquhbG91/IikvmM+WTyW5l8
         /+g/dDC6FOZ7erRdJLiMMIocyKhi2BnvQWip987zLwn9qZMEQhwPy4MCdbtuyr4/La
         dtzuMIcwKRLG628usEnptkqlz5W1Y7Va6KsX563a6krV4cKmg5Gymp2yD/TUv6hywL
         G2cEeyg745JJ5zm3X34im7j7hiII8pxpWtcf+A1YRvyaKEdwWh05DBow2Ke0mrWGT+
         P3dyAc8SrFrFg==
Date:   Wed, 18 Oct 2023 10:37:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     takeru hayasaka <hayatake396@gmail.com>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Harald Welte <laforge@gnumonks.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231018103703.41fd4d9b@kernel.org>
In-Reply-To: <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
References: <20231012060115.107183-1-hayatake396@gmail.com>
        <20231016152343.1fc7c7be@kernel.org>
        <CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
        <CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
        <20231017164915.23757eed@kernel.org>
        <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 10:53:02 +0900 takeru hayasaka wrote:
> For instance, there are PGWs that have the capability to separate the
> termination of communication of 4G LTE users into Control and User
> planes (C/U).
> This is quite convenient from a scalability perspective. In fact, in
> 5G UPF, the communication is explicitly only on the User plane
> (Uplane).
> 
> Therefore, services are expected to receive only GTPU traffic (e.g.,
> PGW-U, UPF) or only GTPC traffic (e.g., PGW-C). Hence, there arises a
> necessity to use only GTPU.
> 
> If we do not distinguish packets into Control/User (C/U) with options
> like gtp4|6, I can conceive scenarios where performance tuning becomes
> challenging.
> For example, in cases where we want to process only the control
> communication (GTPC) using Flow Director on specific CPUs, while
> processing GTPU on the remaining cores.
> In scenarios like IoT, where user communication is minimal but the
> volume of devices is vast, the control traffic could substantially
> increase. Thus, this might also be possible in reverse.
> In short, this pertains to being mindful of CPU core affinity.
> 
> If we were to propose again, setting aside considerations specific to
> Intel, I believe, considering the users of ethtool, the smallest units
> should be gtpu4|6 and gtpc4|6.
> Regarding Extension Headers and such, I think it would be more
> straightforward to handle them implicitly.
> 
> What does everyone else think?

Harald went further and questioned use of the same IP addresses for 
-U and -C traffic, but even within one endpoint aren't these running
on a different port? Can someone reasonably use the same UDP port
for both types of traffic?
