Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A2752DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbjGMXK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjGMXKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FEA1FEE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E885161B45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49F04C433C7;
        Thu, 13 Jul 2023 23:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289822;
        bh=BDg3M8vA3quRdTE6TXWmhbipnn7q2n/R0hfhXMmvExg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=f73RMbHVPq+Nol39XEeExcERjZWm9KN+lOeZLLSPLuymvP1LXptPS1A0qPqnyBDrZ
         9pifTPQ7kAri66NjcShlA1lkTjQFR4qkaBwuw3oM01Ebhct7RIt8wUqJI0wnpSXKqd
         /7aeXPRR25vqaQ0OzI/2NyY1XAcjkXVapFhDstSnCZiiJeoSG8a8DkYetNnXC4/3jB
         S9QbgPg0qT8jMomUwhiJ6vHcNjk134JH68lVMJiKdM2MGYP375tvPPr3J584RQb9gn
         csNY+Q9Y+ygBjYsRSTsnHgdYO2LCQpU+zmGw5HBTPmtm4/EtF8WI8PVXop3YnCv+E1
         /xKGISuzY1TIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 30828E4508F;
        Thu, 13 Jul 2023 23:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v10 0/3] bpf,
 x86: allow function arguments up to 12 for TRACING
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168928982219.26100.14061536595733832009.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Jul 2023 23:10:22 +0000
References: <20230713040738.1789742-1-imagedong@tencent.com>
In-Reply-To: <20230713040738.1789742-1-imagedong@tencent.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     yhs@meta.com, daniel@iogearbox.net, alexei.starovoitov@gmail.com,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        dsahern@kernel.org, jolsa@kernel.org, x86@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, imagedong@tencent.com
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

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu, 13 Jul 2023 12:07:35 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> For now, the BPF program of type BPF_PROG_TYPE_TRACING can only be used
> on the kernel functions whose arguments count less than or equal to 6, if
> not considering '> 8 bytes' struct argument. This is not friendly at all,
> as too many functions have arguments count more than 6. According to the
> current kernel version, below is a statistics of the function arguments
> count:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v10,1/3] bpf, x86: save/restore regs with BPF_DW size
    https://git.kernel.org/bpf/bpf-next/c/02a6dfa8ff43
  - [bpf-next,v10,2/3] bpf, x86: allow function arguments up to 12 for TRACING
    https://git.kernel.org/bpf/bpf-next/c/473e3150e30a
  - [bpf-next,v10,3/3] selftests/bpf: add testcase for TRACING with 6+ arguments
    https://git.kernel.org/bpf/bpf-next/c/5e9cf77d81f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


