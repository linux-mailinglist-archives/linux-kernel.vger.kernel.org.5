Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC2778ECAC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345312AbjHaMAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbjHaMA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F97E42
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B52063E72
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B193EC433C7;
        Thu, 31 Aug 2023 12:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693483223;
        bh=fQuCc+pT8AFDqLlZJ9XoMzF8snrZ0LhmySkKQUntOls=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OMOGH7e7firZvdmnxf6Qxbb152CYEpdg7uMNtuLnyeNYzxI4R1HSW3N/0kIMrKK2K
         NpEjpkPERWaQOn+nChQYn6o8S/7ciJaBsSlBkt0OzuhXYuSg4uIw5hpvgWsEefTyu2
         Qohz+q4/MHZG3+/j6nrEfaNUBMhXNeLttmCspzSTLv8N7e76y6drDHc09OS++zAEtf
         761k02erJppcGisbozdJtT434J98ELlb6pKPc5B0IhvCslYBgAVbhCVp5fLejIC9rm
         OYaRJCyBGESW0tmGjgIEUOYuZ2YO1838flrptqqh3Qmh5595H5EvMe2QpPIDFZuB/1
         csNNXzwMQGkcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92FDAC595D2;
        Thu, 31 Aug 2023 12:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Fix invalid escape sequence warnings
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169348322359.7795.11591685845254219512.git-patchwork-notify@kernel.org>
Date:   Thu, 31 Aug 2023 12:00:23 +0000
References: <20230829074931.2511204-1-vishalc@linux.ibm.com>
In-Reply-To: <20230829074931.2511204-1-vishalc@linux.ibm.com>
To:     Vishal Chourasia <vishalc@linux.ibm.com>
Cc:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev,
        netdev@vger.kernel.org, quentin@isovalent.com,
        sachinp@linux.ibm.com, sdf@google.com, song@kernel.org,
        srikar@linux.vnet.ibm.com, yhs@fb.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 29 Aug 2023 13:19:31 +0530 you wrote:
> The script bpf_doc.py generates multiple SyntaxWarnings related to invalid
> escape sequences when executed with Python 3.12. These warnings do not appear in
> Python 3.10 and 3.11 and do not affect the kernel build, which completes
> successfully.
> 
> This patch resolves these SyntaxWarnings by converting the relevant string
> literals to raw strings or by escaping backslashes. This ensures that
> backslashes are interpreted as literal characters, eliminating the warnings.
> 
> [...]

Here is the summary with links:
  - [v2] Fix invalid escape sequence warnings
    https://git.kernel.org/bpf/bpf/c/121fd33bf2d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


