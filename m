Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E8B7E4666
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjKGQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKGQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:53:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4F093
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:53:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE13C433C8;
        Tue,  7 Nov 2023 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699376029;
        bh=J8kF8O6HuNWUVs8FhZsdxEfm/t7nK7ZM7iAZsS1WKiY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RVEvaRcMCktnv+AMtTfsg5YBSNOHbNGrCM9b8Bejr2axHcAc5Y5e4en/sLrtwcMC2
         yBdAkkl436jTawAO7lQ6yrlUqxc8Dsdx6hth8f1rDzLQws7pUJaimhZ+pV71bsDCWy
         1Gy7SPZksIVI4GIuiiTDWvi2ww8M6j9MwEhJ0U28ILPWPAnfDTPFgyBjAEdhbOzjwn
         wQE8sRg4FCtIKYGOly/2CPalJulhSpPvIzoSuYmUCCC2EOCNHSCKi1v1LnnU9o6QCH
         XiNhy5l/0STz1XgjaKFb84eGrzAkpMD5uI7psLGGhG9zeGFKVJFdSewAQ8z4Cr6+G5
         LWCuSbDpGXUbg==
Date:   Tue, 7 Nov 2023 08:53:47 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Jong eon Park" <jongeon.park@samsung.com>
Cc:     "'Paolo Abeni'" <pabeni@redhat.com>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Dumazet'" <edumazet@google.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "'Dong ha Kang'" <dongha7.kang@samsung.com>
Subject: Re: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Message-ID: <20231107085347.75bc3802@kernel.org>
In-Reply-To: <25c501da111e$d527b010$7f771030$@samsung.com>
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
        <20231103072209.1005409-1-jongeon.park@samsung.com>
        <20231106154812.14c470c2@kernel.org>
        <25c501da111e$d527b010$7f771030$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2023 11:05:08 +0900 Jong eon Park wrote:
> The issue at hand is that once it occurs, users cannot escape from this 
> "busy running" situation, and the inadequate handling of EPOLLERR by users 
> imposes a heavy burden on the entire system, which seems quite harsh.
> 
> The reason for a separate netlink poll is related to the netlink state. 
> When it enters the NETLINK_S_CONGESTED state, sk can no longer receive or 
> deliver skb, and the receive_queue must be completely emptied to clear the 
> state. However, it was found that the NETLINK_S_CONGESTED state was still 
> maintained even when the receive_queue was empty, which was incorrect, and 
> that's why I implemented the handling in poll.

Why does the wake up happen in the first place? 
I don't see anything special in the netlink code, so I'm assuming 
it's because datagram_poll() returns EPOLLERR.

The man page says:

       EPOLLERR
              Error condition happened on the associated file
              descriptor.  This event is also reported for the write end
              of a pipe when the read end has been closed.

              epoll_wait(2) will always report for this event; it is not
              necessary to set it in events when calling epoll_ctl().

To me that sounds like EPOLLERR is always implicitly enabled, 
and should be handled by the application. IOW it's an pure application
bug.

Are you aware of any precedent for sockets adding in EPOLLOUT 
when EPOLLERR is set?
