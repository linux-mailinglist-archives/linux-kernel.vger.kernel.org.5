Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9766B780B98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376807AbjHRMPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376785AbjHRMO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89151E7C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DD1064BD5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4960C433C8;
        Fri, 18 Aug 2023 12:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692360897;
        bh=w6FNTVBuQt9tbVAVP1ItJQdCLgQiAdvFQrWq6PaI3kU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcJ3C3ny9mIZx0FXxtuJwFKaw8F61tdSt/SjB6QmDoWk6rDxJFsHMR1oUl/8KL/hg
         rZLPVvMa1oKLNtV6LTr6h2GOupMcxQD4CQYtIaBngSFgUn18CIsfuJyf1xLa6aqu5+
         25SWoITQRwIe1IlDTrIeII1zdclqhbptChES3erfaisJjIXBhvsj2/rvPQQbDj6pLz
         SLVSkCRW5SQA6ndKG5pkK8kOpALN1wleFWWlTMuwc3izyKwVfujrkqGuINwvsCiJaP
         J4d5erWPIc5q0mbY29LXC1U2AkhddHu2lcJenzpir6o90afDwNV8xdFfzxAPfW73Nm
         vrmBtMkotoYpw==
Date:   Fri, 18 Aug 2023 14:14:52 +0200
From:   Simon Horman <horms@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Richie Pearn <richard.pearn@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: felix: fix oversize frame dropping for
 always closed tc-taprio gates
Message-ID: <ZN9gvGTV4qXnFs3c@vergenet.net>
References: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 03:01:11PM +0300, Vladimir Oltean wrote:
> The blamed commit resolved a bug where frames would still get stuck at
> egress, even though they're smaller than the maxSDU[tc], because the
> driver did not take into account the extra 33 ns that the queue system
> needs for scheduling the frame.
> 
> It now takes that into account, but the arithmetic that we perform in
> vsc9959_tas_remaining_gate_len_ps() is buggy, because we operate on
> 64-bit unsigned integers, so gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS
> may become a very large integer if gate_len_ns < 33 ns.
> 
> In practice, this means that we've introduced a regression where all
> traffic class gates which are permanently closed will not get detected
> by the driver, and we won't enable oversize frame dropping for them.
> 
> Before:
> mscc_felix 0000:00:00.5: port 0: max frame size 1526 needs 12400000 ps, 1152000 ps for mPackets at speed 1000
> mscc_felix 0000:00:00.5: port 0 tc 0 min gate len 1000000, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 1 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 2 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 3 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 4 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 5 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 6 min gate len 0, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 5120 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 615 octets including FCS
> 
> After:
> mscc_felix 0000:00:00.5: port 0: max frame size 1526 needs 12400000 ps, 1152000 ps for mPackets at speed 1000
> mscc_felix 0000:00:00.5: port 0 tc 0 min gate len 1000000, sending all frames
> mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
> mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 5120 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 615 octets including FCS
> 
> Fixes: 11afdc6526de ("net: dsa: felix: tc-taprio intervals smaller than MTU should send at least one packet")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

