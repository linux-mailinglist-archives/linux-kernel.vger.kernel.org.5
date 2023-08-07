Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AFC773002
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjHGT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHGT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:58:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37410C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 302F8621A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A55C433C7;
        Mon,  7 Aug 2023 19:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1691438284;
        bh=RLz87ohuiLScqAT9SuXVUOSNgPMhuG5oZwqpNWm6R4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cbnifTlAOlpZwWDcvj25mzyoBKVjxLB9C5OXFjyoEn+1ikjvWMe18msV1rE71SK5i
         hyDRHCyJj6JLY8zazSXY7cZYCl03N1Uw4HvNyjMV7H4ql3Wsr56Ezz4344S/2X4xmd
         3bW+kXjKV7wQZgUEioC9CtEhkFDwuLUTH5eBOxxU=
Date:   Mon, 7 Aug 2023 12:58:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pengfei Xu <pengfei.xu@intel.com>
Cc:     dvyukov@google.com, nogikh@google.com,
        linux-kernel@vger.kernel.org, Heng Su <heng.su@intel.com>,
        syzkaller@googlegroups.com, keescook@google.com, mingo@elte.hu,
        Mehta Sohil <sohil.mehta@intel.com>,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH RESEND v1 1/1] x86/kernel: Increase kcov coverage under
 arch/x86/kernel folder
Message-Id: <20230807125803.94dfb08402939e0080505a5e@linux-foundation.org>
In-Reply-To: <06c0bb7b5f61e5884bf31180e8c122648c752010.1690771380.git.pengfei.xu@intel.com>
References: <cover.1690771380.git.pengfei.xu@intel.com>
        <06c0bb7b5f61e5884bf31180e8c122648c752010.1690771380.git.pengfei.xu@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 11:04:18 +0800 Pengfei Xu <pengfei.xu@intel.com> wrote:

> Currently kcov instrument is disabled for object files under arch/x86/kernel
> folder.
> For object files under arch/x86/kernel, actually just disabling the kcov
> instrument of files:"head32.o or head64.o and sev.o" could achieve
> successful booting and provide kcov coverage for object files that do not
> disable kcov instrument.
> The additional kcov coverage collected from arch/x86/kernel folder helps
> kernel fuzzing efforts to find bugs.
> 
> Link to related improvement discussion is below:
> https://groups.google.com/g/syzkaller/c/Dsl-RYGCqs8/m/x-tfpTyFBAAJ
> Related ticket is as follow:
> https://bugzilla.kernel.org/show_bug.cgi?id=198443
> 
> ...
>
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -33,11 +33,10 @@ KCSAN_SANITIZE := n
>  KMSAN_SANITIZE_head$(BITS).o				:= n
>  KMSAN_SANITIZE_nmi.o					:= n
>  
> -# If instrumentation of this dir is enabled, boot hangs during first second.
> -# Probably could be more selective here, but note that files related to irqs,
> -# boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
> -# non-deterministic coverage.
> -KCOV_INSTRUMENT		:= n
> +# If instrumentation of the following files is enabled, boot hangs during
> +# first second.
> +KCOV_INSTRUMENT_head$(BITS).o				:= n
> +KCOV_INSTRUMENT_sev.o					:= n
>  
>  CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace

This patch exposes (but probably doesn't cause) an objtool warning:

arch/x86/kernel/traps.o: warning: objtool: ibt_selftest+0x18: sibling call from callable instruction with modified stack frame

gcc-12.2.0, x86_64 allmodconfig.

