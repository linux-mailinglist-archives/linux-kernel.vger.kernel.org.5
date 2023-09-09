Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B642D79957F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238183AbjIIBSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjIIBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:18:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA33213F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 18:17:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE70CC433C7;
        Sat,  9 Sep 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221827;
        bh=kML9hZ7IDaG4XktJeZe7x8+x5w4mrLeBCCe8e1QV/lA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aEY6pwn2Yeo9yuQW7sBAUzeurEYWQEbrf1TSbgln+HHTWG2SjmzWtPJWHaHU99PfG
         1BLtxCba3iXLP+xbQMnKCeyxTW3DGV38psO0doZlALLot6WZQrHgVjPr0A/nX2aSar
         4rgXfcrn0IGyPPCM4E04o9hO62JO06oAISyEMBma7xcryXYfRcNsX+nmtQ26/Gw+fe
         AMmzV+Wh/Ld+j2+sJKSPVkaHZ26G1h+CSZgJI0tADDe+HUuxk9/LWAy6Kzw9zNjhKP
         NMvEbS3Qz1JqlBcTo9LtxPyeffaLqkoYq3X3XFif28aWLJXAxL1Pg8bPGDEyKJjBoJ
         s4JnLD6DaGwqg==
Date:   Fri, 8 Sep 2023 18:10:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH net v2] net: stmmac: fix handling of zero coalescing
 tx-usecs
Message-ID: <20230908181025.5a38c4f5@kernel.org>
In-Reply-To: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
References: <20230907-stmmac-coaloff-v2-1-38ccfac548b9@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 12:46:31 +0200 Vincent Whitchurch wrote:
> Setting ethtool -C eth0 tx-usecs 0 is supposed to disable the use of the
> coalescing timer but currently it gets programmed with zero delay
> instead.
> 
> Disable the use of the coalescing timer if tx-usecs is zero by
> preventing it from being restarted.  Note that to keep things simple we
> don't start/stop the timer when the coalescing settings are changed, but
> just let that happen on the next transmit or timer expiry.
> 
> Fixes: 8fce33317023 ("net: stmmac: Rework coalesce timer and fix multi-queue races")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Felix, good enough?
