Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324467828A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjHUMK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjHUMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:10:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEBCE9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE2A61C64
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:10:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D07CC433C8;
        Mon, 21 Aug 2023 12:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692619854;
        bh=RjRb9BdupNx+xiC24F7DnlTGb1n6/oJFy2C9WHeWCko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PS3UUqO33/2+YxheK/j4VyAegBFzcAkRyUQ/YikAowF38UR/fIZZ5JG9H55fLiewN
         SwKiF3+xLM7ks+24jDKK8gQv/gvBDF7F+6Vn5vDocE1kmzF0vduFqnqVsAEFfTwLCb
         e0Bx1F3rC8Scj/v66LzsdDVQKOTYbkYSOzfClSKWbvJ6+xp5u/N26W6TmeHSMY/RSj
         Mu7FM3vx6tn5PViIonWe3ydBQt5eElXvC6PqRURTWzo90dnKRlgUmypq8ZvLx5G+9e
         a4kLNU55toDIpFuYyhp9AM1BP0E+NocAUVkkNU6sqT4MVEgNDOA/lknpxlZHaMQQId
         hqmq8WwnFEEKA==
Date:   Mon, 21 Aug 2023 13:10:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Message-ID: <20230821121049.GA19670@willie-the-truck>
References: <20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-arm64-sve-trap-mitigation-v1-1-d92eed1d2855@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 11:20:38PM +0100, Mark Brown wrote:
> When we are in a syscall we take the opportunity to discard the SVE state,
> saving only the FPSIMD subset of the register state. When we reload the
> state from memory we reenable SVE access traps, stopping tracking SVE until
> the task takes another SVE access trap. This means that for a task which is
> actively using SVE many blocking system calls will have the additional
> overhead of a SVE access trap.
> 
> As SVE deployment is progressing we are seeing much wider use of the SVE
> instruction set, including performance optimised implementations of
> operations like memset() and memcpy(), which mean that even tasks which are
> not obviously floating point based can end up with substantial SVE usage.
> 
> It does not, however, make sense to just unconditionally use the full SVE
> register state all the time since it is larger than the FPSIMD register
> state so there is overhead saving and restoring it on context switch and
> our requirement to flush the register state not shared with FPSIMD on
> syscall also creates a noticeable overhead on system call.
> 
> I did some instrumentation which counted the number of SVE access traps
> and the number of times we loaded FPSIMD only register state for each task.
> Testing with Debian Bookworm this showed that during boot the overwhelming
> majority of tasks triggered another SVE access trap more than 50% of the
> time after loading FPSIMD only state with a substantial number near 100%,
> though some programs had a very small number of SVE accesses most likely
> from startup. There were few tasks in the range 5-45%, most tasks either
> used SVE frequently or used it only a tiny proportion of times. As expected
> older distributions which do not have the SVE performance work available
> showed no SVE usage in general applications.
> 
> This indicates that there should be some useful benefit from reducing the
> number of SVE access traps for blocking system calls like we did for non
> blocking system calls in commit 8c845e273104 ("arm64/sve: Leave SVE enabled
> on syscall if we don't context switch"). Let's do this by counting the
> number of times we have loaded FPSIMD only register state for SVE tasks
> and only disabling traps after some number of times, otherwise leaving
> traps disabled and flushing the non-shared register state like we would on
> trap.
> 
> I pulled 64 out of thin air for the number of flushes to do, there is
> doubtless room for tuning here. Ideally we would be able to tell if the
> task is actually using SVE but without using performance counters (which
> would be substantial work) we can't currently tell. I picked the number
> because so many of the tasks using SVE used it so frequently.
> 
> This means that for a task which is actively using SVE the number of SVE
> access traps will be substantially reduced but applications which use SVE
> only very infrequently will avoid the overheads associated with tracking
> SVE state once the counter expires.
> 
> There should be no functional change resulting from this, it is purely a
> performance optimisation.

Do you have any performance numbers to motivate this change? It would be
interesting, for example, to see how changing the timeout value affects
the results for some real workloads.

Will
