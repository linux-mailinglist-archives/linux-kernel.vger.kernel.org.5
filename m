Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876427E319A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbjKFXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbjKFXsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:48:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F323192
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 15:48:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A0FC433C8;
        Mon,  6 Nov 2023 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699314493;
        bh=Iv24+mEJW7DXWrDVIYI3Vflj7t85vsr1hfSqUvp0TOc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dyDtD+NY1uSWj2twavzWD0Ojli/Woa0a9laU99VK+VxfnrgPDBVNPoElcZ1hr/iTz
         7Rz0AxmBX02V/NKLYj/VxrViXK9iZQZQUH/pyo60DUNGSqahEhtDik+NYzrd815Jps
         T67/aCQI1qjJT0+XcV0nWSWdb5e+bAbaGkToxIfg1iD98+fm2Ebdubb4rplVKezcgB
         61He1QXDEci5sqFlq6tRfAQ2gL6KFRNO6Jtnm3Ynu0X2oAq9OfyuUyzNTs1cQtJ/M/
         OL6cdsloZ6+sKcGare5314sV2Z4oS9kf5RciEk99YS0Zi1eRnAo895R+dhC8ZU3DN5
         +XWQ05WNQEenA==
Date:   Mon, 6 Nov 2023 15:48:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jong eon Park <jongeon.park@samsung.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dong ha Kang <dongha7.kang@samsung.com>
Subject: Re: [PATCH] netlink: introduce netlink poll to resolve fast return
 issue
Message-ID: <20231106154812.14c470c2@kernel.org>
In-Reply-To: <20231103072209.1005409-1-jongeon.park@samsung.com>
References: <CGME20231103072245epcas1p4471a31e9f579e38501c8c856d3ca2a77@epcas1p4.samsung.com>
        <20231103072209.1005409-1-jongeon.park@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Nov 2023 16:22:09 +0900 Jong eon Park wrote:
> In very rare cases, there was an issue where a user's poll function
> waiting for a uevent would continuously return very quickly, causing
> excessive CPU usage due to the following scenario.
> 
> Once sk_rcvbuf becomes full netlink_broadcast_deliver returns an error and
> netlink_overrun is called. However, if netlink_overrun was called in a
> context just before a another context returns from the poll and recv is
> invoked, emptying the rcvbuf, sk->sk_err = ENOBUF is written to the
> netlink socket belatedly and it enters the NETLINK_S_CONGESTED state.
> If the user does not check for POLLERR, they cannot consume and clean
> sk_err and repeatedly enter the situation where they call poll again but
> return immediately.
> 
> To address this issue, I would like to introduce the following netlink
> poll.
> 
> After calling the datagram_poll, netlink poll checks the
> NETLINK_S_CONGESTED status and rcv queue, and this make the user to be
> readable once more even if the user has already emptied rcv queue. This
> allows the user to be able to consume sk->sk_err value through
> netlink_recvmsg, thus the situation described above can be avoided

The explanation makes sense, but I'm not able to make the jump in
understanding how this is a netlink problem. datagram_poll() returns
EPOLLERR because sk_err is set, what makes netlink special?
The fact that we can have an sk_err with nothing in the recv queue?

Paolo understands this better, maybe he can weigh in tomorrow...
