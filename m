Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8012776A5DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 03:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjHABAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 21:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjHABA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 21:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF74E7C;
        Mon, 31 Jul 2023 18:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6306137A;
        Tue,  1 Aug 2023 01:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7D47C433C7;
        Tue,  1 Aug 2023 01:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690851623;
        bh=OCmwlOTWPHIWCp3t7K6WyhLnDrlRp67gVDfyE58MgA4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C1s7XZIaFGtCx05pfwIXuVobCjVzEJah4/EUH5Zl7dg6LYMcq96sM0cOlXdrYUW5h
         ZAssyXvQFxHreP84eKIZY1zFIkz525HYTFobNatSAGMSZybYrR2Xdj4oy/z0yfgvW2
         KtYaaUyQ2gM+KfdYaGGJpBK6kK/tReaEguFOauVxOY0U+1DxEn5s7xycKolW2ddkwp
         Th/kFvcs+gi6jC3MEi+RlS4c3u9Yfdw2ixI7/Q+pU7kSTtrEeSoj2EyhU/bTkq0f8e
         OCL94u1jlli4hgDI0osRwat0VOagow+7/BxZFVgsJOsM/hhK1IimvJ7+AM3Zfu11vR
         gJ9ySvoPRPsQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBBB5E96ABF;
        Tue,  1 Aug 2023 01:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netfilter: bpf: Only define get_proto_defrag_hook() if
 necessary
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169085162282.11842.12642212227256267164.git-patchwork-notify@kernel.org>
Date:   Tue, 01 Aug 2023 01:00:22 +0000
References: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
In-Reply-To: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     kadlec@netfilter.org, davem@davemloft.net, pabeni@redhat.com,
        ast@kernel.org, edumazet@google.com, pablo@netfilter.org,
        kuba@kernel.org, fw@strlen.de, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org, lkp@intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 31 Jul 2023 15:55:00 -0600 you wrote:
> Before, we were getting this warning:
> 
>   net/netfilter/nf_bpf_link.c:32:1: warning: 'get_proto_defrag_hook' defined but not used [-Wunused-function]
> 
> Guard the definition with CONFIG_NF_DEFRAG_IPV[4|6].
> 
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG in netfilter link")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307291213.fZ0zDmoG-lkp@intel.com/
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> 
> [...]

Here is the summary with links:
  - netfilter: bpf: Only define get_proto_defrag_hook() if necessary
    https://git.kernel.org/bpf/bpf-next/c/81584c23f249

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


