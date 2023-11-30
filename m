Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515457FFAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346780AbjK3TBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3TBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:01:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0D2194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:01:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E862DC433C8;
        Thu, 30 Nov 2023 19:01:00 +0000 (UTC)
Date:   Thu, 30 Nov 2023 19:00:58 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>, jannh@google.com,
        linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZWjb6r0RWPo199pC@arm.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for putting this together and sorry it took me some time to catch
up (well, still not fully, so rather more questions below).

On Tue, Nov 28, 2023 at 06:22:38PM +0000, Mark Brown wrote:
> Since clone3() is readily extensible let's add support for specifying a
> shadow stack when creating a new thread or process in a similar manner
> to how the normal stack is specified, keeping the current implicit
> allocation behaviour if one is not specified either with clone3() or
> through the use of clone().  Unlike normal stacks only the shadow stack
> size is specified, similar issues to those that lead to the creation of
> map_shadow_stack() apply.

My hope when looking at the arm64 patches was that we can completely
avoid the kernel allocation/deallocation of the shadow stack since it
doesn't need to do this for the normal stack either. Could someone
please summarise why we dropped the shadow stack pointer after v1? IIUC
there was a potential security argument but I don't think it was a very
strong one. Also what's the threat model for this feature? I thought
it's mainly mitigating stack corruption. If some rogue code can do
syscalls, we have bigger problems than clone3() taking a shadow stack
pointer.

My (probably wrong) mental model was that libc can do an mmap() for
normal stack, a map_shadow_stack() for the shadow one and invoke
clone3() with both these pointers and sizes. There is an overhead of an
additional syscall but if some high-performance app needs to spawn
threads quickly, it would most likely do some pooling.

I'm not against clone3() getting a shadow_stack_size argument but asking
some more questions. If we won't pass a pointer as well, is there any
advantage in expanding this syscall vs a specific prctl() option? Do we
need a different size per thread or do all threads have the same shadow
stack size? A new RLIMIT doesn't seem to map well though, it is more
like an upper limit rather than a fixed/default size (glibc I think uses
it for thread stacks but bionic or musl don't AFAIK).

Another dumb question on arm64 - is GCSPR_EL0 writeable by the user? If
yes, can the libc wrapper for threads allocate a shadow stack via
map_shadow_stack() and set it up in the thread initialisation handler
before invoking the thread function?

Thanks.

-- 
Catalin
