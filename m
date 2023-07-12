Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271F750FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGLRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjGLRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:42:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06256CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:42:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9811B617DF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3482C433C7;
        Wed, 12 Jul 2023 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689183732;
        bh=wG8UUXNP3lOA9oLQq/E55c0IUNpqh5X988ZONVpNi1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h54a7qPL1C5+e+vdm81szDvXyNSBOWtx1CMu5QnsbncweaA9c6kZobdlNc0bbELxN
         fYgezlmaI09gWuV2meXrEroaPdAGaDvrH6yBkz6/z1I6nX2k1v/oTEOkoSPnKN8MEB
         e/Lb31yHKKIOrI7BX2UFWtHmal85yrJH+Qo2WgpA3QXENjfKIkyjYBRAnPm6NpipYM
         +0x+KtnveYOY5d0Aet1N4/zUElyO26VYyBZ8gJNOCQkiNCnak4b24ZIH1Pky8DAUZe
         59VIIshp7XG3aLKahSfkXgzQykXSwGyYENUswAiZHKibY0g10kqwce2SJ9sN27CUrn
         jO+AielX9JudQ==
Date:   Wed, 12 Jul 2023 10:42:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for
 tcp_listen_queue_drop
Message-ID: <20230712104210.3b86b779@kernel.org>
In-Reply-To: <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
References: <20230711043453.64095-1-ivan@cloudflare.com>
        <20230711193612.22c9bc04@kernel.org>
        <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote:
>   The issue with kfree_skb is not that it fires too frequently (not in
> the 6.x kernel now). Rather, it is unable to locate the socket info
> when a SYN is dropped due to the accept queue being full. The sk is
> stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
> tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
> socket lookup are used). A tracepoint with sk information will be more
> useful to monitor accurately which service/socket is involved.

No doubt that kfree_skb isn't going to solve all our needs, but I'd
really like you to clean up the unnecessary callers on your systems
first, before adding further tracepoints. That way we'll have a clear
picture of which points can be solved by kfree_skb and where we need
further work.
