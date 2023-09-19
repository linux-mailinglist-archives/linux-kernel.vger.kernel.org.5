Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B2D7A5D64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjISJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjISJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:07:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D0DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:07:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695114437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEZcqkbunLRF0TikvjJniAe2SOdd4y7HDzK57R4UZj4=;
        b=K6ZZnwREerdcZnimw9gy0GOuGD9EU7+YHAtqgRRRgpNr2xXae9gvZJCrzU3dFX+CwPXPeQ
        837Jmn+9/RU/8Z6eXhv/1HSY8fslIUADpTn3r3WhWo3b08AXeGAwjCCXXr9h7AhMvD/Gdt
        GaoLm9kYY8paVaEQLCf3kLNbWWkecqrF84lLL1sSlN5Q+bSm8hYHmJGMrSGe4Eq1LNmag2
        4FhyqMzPhRGeF8vdmqv9zvjYsth5uEel6xhOuKq65acSCZ6g1571+JfQVbrBZsKFxMDJF4
        f2V+D0xixsLNmqdE1thZ+oaJI/YE2o3KOous1YTBSTmVt3jiyVMbjIMtHDfQcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695114437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEZcqkbunLRF0TikvjJniAe2SOdd4y7HDzK57R4UZj4=;
        b=v4+qNROZLDiBWpNURscX8KwLHwnQ13p+waE6e8OKJt09dv7qxjJBODDBGbVOXRv48pCQpA
        e4jZ2QF31R+QeNCw==
To:     Andy Lutomirski <luto@kernel.org>,
        Brendan Jackman <jackmanb@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>, yosryahmed@google.com,
        reijiw@google.com, oweisse@google.com
Subject: Re: [PATCH RESEND] x86/entry: Don't write to CR3 when restoring to
 kernel CR3
In-Reply-To: <b2967925-0a57-4a19-8657-3d9f4da83a20@app.fastmail.com>
References: <20230817121513.1382800-1-jackmanb@google.com>
 <b2967925-0a57-4a19-8657-3d9f4da83a20@app.fastmail.com>
Date:   Tue, 19 Sep 2023 11:07:17 +0200
Message-ID: <87sf7awmyi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18 2023 at 20:28, Andy Lutomirski wrote:
> On Thu, Aug 17, 2023, at 5:15 AM, Brendan Jackman wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Skip resuming KERNEL pages since it is already KERNEL CR3
>>
>> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>> ---
>>
>> While staring at paranoid_exit I was confused about why we had this CR3
>> write, avoiding it seems like a free optimisation. The original commit
>> 21e94459110252 ("x86/mm: Optimize RESTORE_CR3") says "Most NMI/paranoid
>> exceptions will not in fact change pagetables" but I didn't't understand
>> what the "most" was referring to. I then discovered this patch on the
>> mailing list, Andy said[1] that it looks correct so maybe now is the
>> time to merge it?
>
> I did?
>
> Looking at the link, I think I was saying that the opposite patch
> (*always* flush) looked okay.

That always flush part was solely for the user CR3 restore path.

>> @@ -236,14 +236,13 @@ For 32-bit we have the following conventions - 
>> kernel is built with
>>  .macro RESTORE_CR3 scratch_reg:req save_reg:req
>>  	ALTERNATIVE "jmp .Lend_\@", "", X86_FEATURE_PTI
>> 
>> -	ALTERNATIVE "jmp .Lwrcr3_\@", "", X86_FEATURE_PCID
>> -
>>  	/*
>> -	 * KERNEL pages can always resume with NOFLUSH as we do
>> -	 * explicit flushes.
>> +	 * Skip resuming KERNEL pages since it is already KERNEL CR3.
>>  	 */
>>  	bt	$PTI_USER_PGTABLE_BIT, \save_reg
>> -	jnc	.Lnoflush_\@
>> +	jnc	.Lend_\@
>
> I don't get it.  How do you know that the actual loaded CR3 is correct?
>
> I'm willing to believe that there is some constraint in the way the
> kernel works such that every paranoid entry will, as part of its
> execution, switch CR3 to kernel *and leave it like that* *and that
> this will be the _same_ kernel CR3 that was saved*.  But I'm not
> really convinced that's true.  (Can we schedule in a paranoid entry?
> Probably not.  What about the weird NMI paths?  What if we do
> something that switches to init mm?  Hmm -- doing that in a paranoid
> context is probably not a brilliant idea.)

You have to differentiate between entry from kernel and entry from user.

Entry from user switches to the task stack, while entry from kernel
always runs on IST.

Entry from user cannot have kernel CR3 obviously, while entry from
kernel can have either kernel CR3 or user CR3. Entry from user does not
use the paranoid entry/exit paths at all, so that's a non-issue.

IST prevents that the exception can schedule, which in turn guarantees
that CR3 stays the same until it returns. Unless some completely stupid
code path would trie to switch to a different mm from an exception which
can hit into the middle of an mm switch. Then the failed restore is
probably the least of our problems.

> Maybe it is true, and maybe a convincing argument could be made.  But
> that seems like a lot of thinking and fragility for an optimization
> that seems pretty minor.

I don't think its pretty minor. CR3 writes even with the noflush bit set
are not necessarily cheap.

While most exceptions which go through the paranoid path are not
hotpath, the one which matters is #NMI due to perf. So I think it's
worth to spare the redundant CR3 switch in that case.

Thanks,

        tglx

