Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E287E825F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjKJTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbjKJTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:17:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C5AB409
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 11:00:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C71C433C7;
        Fri, 10 Nov 2023 19:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699642803;
        bh=6EnUes9wTH1mI2Pr2tlR3oBu4IGmtLezlfYoFlsdZ8E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OPQgb5JlaM+x+2Dekdbo9oDYHDwX+9NJoWCXpqAcb2qbcBvv6DKNY4REflr39/OI9
         tCehhLFF5L1w7+0uX9RZ7L7U2vs9oKfPcBdVQqpq2mah3RWHtRoP/9hF6ZoFhTlCje
         BYOAtl8GTJgprK6sQaYUMCU28cHAR06bcF+NZ2FE00nXeTldDyvXJS6RSgH/yJDfi1
         QACKelD8f/asbPLLZw9PPl7zuDnB2Ps/x53rFnBjn3wkzrtd1V4cyDsmImhynte/Sw
         gDbO2DEwjgrEtlqlOtMS325TvL5M3c15/JFMMfLwegUxc4YDhADHX+cqNmejuKsMCw
         TSlIXA71e7OZA==
Date:   Fri, 10 Nov 2023 11:00:02 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jong eon Park" <jongeon.park@samsung.com>
Cc:     "'Paolo Abeni'" <pabeni@redhat.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Dong ha Kang'" <dongha7.kang@samsung.com>
Subject: Re: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Message-ID: <20231110110002.7279f895@kernel.org>
In-Reply-To: <000001da13e5$d9b99e30$8d2cda90$@samsung.com>
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
        <20231103072209.1005409-1-jongeon.park@samsung.com>
        <20231106154812.14c470c2@kernel.org>
        <25c501da111e$d527b010$7f771030$@samsung.com>
        <20231107085347.75bc3802@kernel.org>
        <000001da13e5$d9b99e30$8d2cda90$@samsung.com>
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

On Fri, 10 Nov 2023 23:54:48 +0900 Jong eon Park wrote:
> Interestingly, in this issue, even though netlink overrun frequently 
> happened and caused POLLERRs, the user was managing it well through 
> POLLIN and 'recv' function without a specific POLLERR handler. 
> However, in the current situation, rcv queue is already empty and 
> NETLINK_S_CONGESTED flag prevents any more incoming packets. This makes 
> it impossible for the user to call 'recv'.
> 
> This "congested" situation is a bit ambiguous. The queue is empty, yet 
> 'congested' remains. This means kernel can no longer deliver uevents 
> despite the empty queue, and it lead to the persistent 'congested' status.
> 
> The reason for the difference in netlink lies in the NETLINK_S_CONGESTED 
> flag. If it were UDP, upon seeing the empty queue, it might have kept 
> pushing the received packets into the queue (making possible to call 
> 'recv').

I see, please add a comment saying that NETLINK_S_CONGESTED prevents
new skbs from being queued before the new test in netlink_poll().

Please repost next week (i.e. after the merge window) with subject
tagged [PATCH net-next v2].
