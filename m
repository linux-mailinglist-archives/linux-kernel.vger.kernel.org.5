Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185F976D966
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbjHBVVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjHBVV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:21:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEB2D6A;
        Wed,  2 Aug 2023 14:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FC861B29;
        Wed,  2 Aug 2023 21:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53901C433C7;
        Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691011221;
        bh=r3kCRVSYFBLItWe2GV/TfNk+pBsHmyVL2Z8MBrXrPg0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KfzHGHMko0UeGp/f2ND5mAbBMYnRoflMYUXrOCIrcKUS2s+QQwiHjK8oIKAzyCbub
         RKxePwuIa8y+637dazizHtwLEoUZkgCLyh03bGBDvp46nZ66fmHqG8dQnpZnPFgAF0
         Y40jmjeZiFYBByXk5XQ/tqHpuMLg2GDMIsewf7ioYwzjOGogm6oz4AJ1ikb4JUL19e
         OtK6eUQ0HqjrU02q8IUiqmu4N5WnPq6G6PSLAJzD8ILUzc37XkGGtO18sqFpi2l4n7
         1HnJ00IZk+JwweFreVP19PhWZ6o5FXkBHWiuMsDxTb2TK1fP+6ChiDT7jiL7ZACtUG
         vyJdLb+Fw4LyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 339AFE270D7;
        Wed,  2 Aug 2023 21:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v5] bpf: fix bpf_probe_read_kernel prototype mismatch
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169101122119.28051.8597932529135437329.git-patchwork-notify@kernel.org>
Date:   Wed, 02 Aug 2023 21:20:21 +0000
References: <20230801111449.185301-1-arnd@kernel.org>
In-Reply-To: <20230801111449.185301-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        arnd@arndb.de, stable@vger.kernel.org, john.fastabend@gmail.com,
        martin.lau@linux.dev, yonghong.song@linux.dev, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        memxor@gmail.com, davemarchevsky@fb.com, void@manifault.com,
        peterz@infradead.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Tue,  1 Aug 2023 13:13:58 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
> 
> Since the two are incompatible, there cannot be a shared declaration in
> a header file, but the lack of a prototype causes a W=1 warning:
> 
> [...]

Here is the summary with links:
  - [v5] bpf: fix bpf_probe_read_kernel prototype mismatch
    https://git.kernel.org/bpf/bpf-next/c/6a5a148aaf14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


