Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD7E7EA5F0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjKMWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:20:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46611D50
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:20:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A0EC433C7;
        Mon, 13 Nov 2023 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699914024;
        bh=R+gas78q/rvPvc1kUH78XbnbTKo2Ls44dPUWBDGT9JY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H2oFoJ4JwWcow7QQVGWT7o7+6BKqYDkBpd/F37ak0T9fnxswoa5dmcnZ++ryAbVv4
         DMWx1dDwgEsJPFGxjLwOHexcnf4qA78WlQOdWo3YKehBb+iPvN8Yy8+5YkUDLvnhpL
         yWNxMyN3aw1az9HCCuvrSQ2KVZN8aFkw9VJjD9cLDvNc2XSpkh4xojMkCUpLQiMu5R
         9cdrKm4OC7qrZc32mLEQh9yYshy4htBQ9xO0ijTLRXQxUYqh6M0F+l9SBNMXPw1Dbk
         sFKGfNDJI9vFFf9ahSFoa1LCKSEmgGMnY8pl5OEK/urBfuBOE8cRS+gLIkQb2T/GKi
         qomBR0lIPTeAA==
Date:   Mon, 13 Nov 2023 17:20:20 -0500
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem
 TCP
Message-ID: <20231113172020.728cdf6a@kernel.org>
In-Reply-To: <CAHS8izMQQekAdkLF7eFHfwGJJ=LFmGLHpSpOYiQeLs96ByEK7w@mail.gmail.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
        <20231106024413.2801438-13-almasrymina@google.com>
        <20231110151335.38a1c6ec@kernel.org>
        <CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com>
        <20231110183556.2b7b7502@kernel.org>
        <CAHS8izMQQekAdkLF7eFHfwGJJ=LFmGLHpSpOYiQeLs96ByEK7w@mail.gmail.com>
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

On Sun, 12 Nov 2023 20:08:10 -0800 Mina Almasry wrote:
> 1. For (b), would it be OK to implement a very minimal version of
> queue_[stop|start]/queue_mem_[alloc|free], which I use for the sole
> purpose of reposting buffers to an individual queue, and then later
> whoever picks up your queue API effort (maybe me) extends the
> implementation to do the rest of the things you described in your
> email? If not, what is the minimal queue API I can implement and use
> for devmem TCP?

Any form of queue API is better than a temporary ndo.
IIUC it will not bubble up into uAPI in any way so we can extend/change
it later as needed.

> 2. Since this is adding ndo, do I need to implement the ndo for 2
> drivers or is GVE sufficient?

One driver is fine, especially if we're doing this instead of the reset
hack.
