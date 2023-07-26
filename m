Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C108D763B37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbjGZPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A09B5;
        Wed, 26 Jul 2023 08:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAEA661B89;
        Wed, 26 Jul 2023 15:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33DAC433C8;
        Wed, 26 Jul 2023 15:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690385829;
        bh=Dq3Ew/vR82lY45pv151dWz7lZf5a3r9zNeKkTHvnIOw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAQKLJHUSj7N6nB7nqA7D2wq15UgMU1sLUJhsItCoNbGWx4RxK/3tXHA+BPterl62
         IYer6rwkc8fXxRR6BkXxWk57IIMvem1Hq8En3KDwJf5aIqOy64ned6rFuerVgujt4V
         L96DFs3RQSj5w1or8/1IJkMBeIJTb6i9aNPCTMTy7sF483rM5//aNHO/Ap4Op1WFfD
         wmvdpqeGbRHyKj72DzAknDRiRG7Xuj9kHb2muJvDfq4b9vO0pMKnxpOk+KbW/VZmQm
         siPALaGza9JQOWmBfhuXwLQBT/XDS50RYBpeFh/Rz4sERMaGo3BpnM89CZ14zsqJvk
         WOfa35WGIIpGw==
Date:   Wed, 26 Jul 2023 08:37:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Md Danish Anwar <a0501179@ti.com>
Cc:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXTERNAL] Re: [PATCH v11 06/10] net: ti: icssg-prueth: Add
 ICSSG ethernet driver
Message-ID: <20230726083707.623da581@kernel.org>
In-Reply-To: <9b11e602-6503-863a-f825-b595effd5e1d@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
        <20230724112934.2637802-7-danishanwar@ti.com>
        <20230725210939.56d77726@kernel.org>
        <9b11e602-6503-863a-f825-b595effd5e1d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 16:01:23 +0530 Md Danish Anwar wrote:
> I think MAX_SKB_FRAGS is OK. If the available pool = MAX_SKB_FRAGS we should be
> able to wake the queue.

MAX_SKB_FRAGS only counts frags and you also need space to map the head, no?

In general we advise to wait until there's at least 2 * MAX_SKB_FRAGS
to avoid frequent sleep/wake cycles. But IDK how long your queue is,
maybe it's too much. 

> No I don't think any lock is required here. emac_set_port_state() aquires lock
> before updating port status. Also emac_ndo_set_rx_mode_work() is scheduled by a
> singlethreaded workqueue.

if (netif_running()) outside of any locks is usually a red flag, but if
you're confident it's fine it's fine :)
