Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094767603C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjGYAU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjGYAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CF4172D
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 297046147D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C0B6C433AB;
        Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690244421;
        bh=/CYJf6waf/5H+qoHbl8j40uIaY97gRV1gVYHmtkTc60=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DY9qFiBJU1eT6ASnLKNZ7Y0v2xiqyg9ocqEnuDYE5rqHY8HBjpwZ0okTPw0rjRQQi
         v8Fhs7FU0DeYVqUc0LB6r1LP0gHyHpdFe9+XFpg84eEuohx5Hko9mR5j8NJPesF6xe
         d6zCbPZoBdkwMWaB1tSVKEWrgPnZTcl4eyXrKHtXnab2PGkJWQCuHsv75ocqUXKdx7
         9bKtKgQVFdV9AbOnZuxHiHmTGQ4CcYU7bmdIAPQr+9CvH0jZ3lVA58tqmh2i91oWVm
         rrf0cjOtufB2JXe76WMJa8D6z04boxYmw9LKsnxNROOLrgfpGebqZZLgGmLkBjol11
         1H7/lcDTIvVXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46D96E21EDD;
        Tue, 25 Jul 2023 00:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169024442128.15014.7119910740780685151.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Jul 2023 00:20:21 +0000
References: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
In-Reply-To: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, edumazet@google.com, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, martineau@kernel.org,
        soheil@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Jul 2023 20:47:50 +0200 you wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> The MPTCP code uses the assumption that the tcp_win_from_space() helper
> does not use any TCP-specific field, and thus works correctly operating
> on an MPTCP socket.
> 
> The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
> broke such assumption, and as a consequence most MPTCP connections stall
> on zero-window event due to auto-tuning changing the rcv buffer size
> quite randomly.
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: fix rcv buffer auto-tuning
    https://git.kernel.org/netdev/net-next/c/b8dc6d6ce931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


