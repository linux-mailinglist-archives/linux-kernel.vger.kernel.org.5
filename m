Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06A67EC6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKOPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbjKOPIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:08:52 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB0101
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 07:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700060925;
        bh=nQkiZfSShLRcObhQIvmnOb1jXWqfzmOANMc2r8jtDMo=;
        h=Date:To:Cc:From:Subject:From;
        b=Jgta6n9dwEH7u4TYXxOt0OzJJdlQxj0EEpZxxiGrGHWQnds3R/fcgM/dmbjcMNzG+
         g0w/jFadoCRWuGFP5RMb+tVNvAatvnUnLkAHZxZGs4Yzq2GwufrJlo3jSBYT7SLMG1
         KMku2un+T41Vn8/SvVqKcI4JHdIcXmUI++pX7V5JosO7gpxxuZClIa7SIHaajo+sCo
         +RFLN7ner60FzKKviFUAKAd7KIzuP1RhHTGFPUOT0XR3k7RQ2nn5mXx5ONOogLxxNP
         fINPdKcjIlsjZjN6ER8gTBXHfWu+zu2GFkIyy+LDJtG01BSnYUw9Uy5DcLXiHQe+MP
         c3Phazpp2oPnw==
Received: from [172.25.85.137] (unknown [12.186.190.1])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SVmlJ4pc9z1cf5;
        Wed, 15 Nov 2023 10:08:44 -0500 (EST)
Message-ID: <a79d1bc3-1aca-4169-a963-b7c9279aa7fd@efficios.com>
Date:   Wed, 15 Nov 2023 10:09:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>
Cc:     "carlos@redhat.com" <carlos@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Summary of discussion following LPC2023 sframe talk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[ With lkml and diamon-discuss in CC ]

I'm adding the following notes of the hallway track discussion we had
immediately after the sframe slot within the tracing MC [1]. I suspect it
is relevant (please correct me if I'm wrong or if there are conclusions
that are too early to tell):

- Handling of shared libraries:
   - the libc dynamic loader should register/unregister sframe sections
     explicitly with new prctl(2) options,
   - The prctl() for registration of the sframe sections can take the
     section address and size as arguments,
   - The prctl for unregistration could take the section address as argument,
     but this would require additional data in the linker map (within libc),
     which is unwanted.
   - One alternative would be to provide an additional information to
     sframe registration/unregistration: a key which is decided by the libc
     to match registration/unregistration. That key could be either the
     address of the text section associated with the sframe section, or it
     could be the address of the linker map entry (at the choice of userspace).
   - Overall, the prctl(3) sframe register could have the following parameters:
     { key, sframe address, sframe section length }
   - The prctl(3) sframe unregister would then take a { key } as parameter.

- The kernel backtrace code using the sframe information should consider
   it hostile:
   - can be corrupted by the application (by accident or maliciously),
   - can be corrupted on disk by modification of the ELF binary, either
     before registration or after (either by accident or maliciously),
   - can be malformed to contain loops (need to find a way to have upper
     bounds, sanity checks about the direction of the stack traversal),

- It was discussed that the kernel could possibly validate checksums on
   registration and write-protect the sframe pages. Considering that the
   kernel still needs to consider the content hostile even with those
   mechanisms in place, it is unclear whether they are relevant.

- Mark Rutland told me that for aarch64 the current sframe content is
   not sufficient to express how to walk the stack over code area at
   the beginning of functions before the stack pointer is updated.
   He plans to discuss this with Indu as a follow up.

- Interpreters:

   - Walking over an interpreter's own stack can be as simple as skipping
     over the interpreter's runtime functions. This is a first step to
     allow skipping over interpreters without detailed information about
     their own stack layout.

- JITs:

   - There are two approaches to skip over JITted code stacks:

     - If the jitted code has frame pointers, then use this.

     - If we figure out that some JITs do not have frame pointers, then
       we would need to design a new kernel ABI that would allow JITs
       to express sframe-alike information. This will need to be designed
       with the input of JIT communities because some of them are likely
       not psABI compliant (e.g. lua has a separate stack).

   - When we have a good understanding of the JIT requirements in terms
     of frame description content, the other element that would need to
     be solved is how to allow JITs to emit frame data in a data structure
     that can expand. We may need something like a reserved memory area, with
     a counter of the number of elements which is used to synchronize communication
     between the JITs (producer) and kernel (consumer).

   - We would need to figure out if JITs expect to have a single producer per
     frame description area, or multiple producers.

   - We would need to figure out if JITs expect to append frame descriptions in
     sorted function address order (append only for frame description, append only
     for functions text section as well), or if there needs to be support for unsorted
     function entries.

   - We would need information about how JITs reclaim functions, and how it impacts
     the frame description ABI. For instance, we may want to have a tombstone bit to
     state that a frame was deleted.

   - We may have to create frame description areas which content are specific to given
     JITs. For instance, the frame descriptions for a lua JIT on x86-64 may not follow
     the x86-64 regular psABI.

   - As an initial stage, we can focus on handling the sframe section for executable
     and shared objects, and use frame pointers to skip over JITted code if available.
     The goal here is to show the usefulness of this kind of information so we get
     the interest/collaboration needed to get the relevant input from JIT communities
     as we design the proper ABI for handling JIT frames.

Thanks,

Mathieu

[1] https://lpc.events/event/17/contributions/1467/ (for abstract/slides)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
