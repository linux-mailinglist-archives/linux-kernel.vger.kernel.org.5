Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199F80063E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377902AbjLAIxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjLAIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:53:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5461724;
        Fri,  1 Dec 2023 00:53:16 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701420794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsSuhopWvqk3I522fxQ6ooSX/rywsngW1wlaL3r7/7U=;
        b=rPEuIkBJ8+ySLg//CUXlWUdvWgl2gX9GyTR9vtkIwcxNKJI7DKlqMpvFlOEkC31c410v3N
        RtBVDpI/K6AnA+eWN5mwI2AFlv2FHP54pACmcrj77DstChyu704ex9o15EnIdhJOvxqxVS
        pjfj5G9UQjUiqVzyQWik+YmfX2xxEB8dl8M0qxkrZ4PQLniFTbsPeyCCik6wXwAq8jwi0W
        SyKHyeHvlDqWBTzuTSI5RF5MTYE2moAzq4SPm5J6znLxG8p4+tegHmvDJRVi69lqcgZJcC
        RyOzFLfC8u2r30n17ECgvuv2bywn9k6in+STOh4hMyUG+s26WrhFK8d4JpXu8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701420794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AsSuhopWvqk3I522fxQ6ooSX/rywsngW1wlaL3r7/7U=;
        b=k3lhqCWbYvJz0Bi9J6xDfIkYCKnBYBQV6tpu4jDjNakRVSGUK5S46foplXONrFPARA7GXL
        VrY+PwiLWS/RqKBQ==
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        Len Brown <lenb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Salil Mehta <salil.mehta@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 00/21] Initial cleanups for vCPU hotplug
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
Date:   Fri, 01 Dec 2023 09:53:13 +0100
Message-ID: <87y1eexq12.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2023 at 13:43, Russell King wrote:
> The majority of the other patches come from the vCPU hotplug RFC v3
> series I posted earlier, rebased on Linus' current tip, but with some
> new patches adding arch_cpu_is_hotpluggable() as the remaining
> arch_register_cpu() functions only differ in the setting of the
> hotpluggable member of the CPU device - so let's get generic code
> doing that and provide a way for an architecture to specify whether a
> CPU is hotpluggable.
>
> This patch series has been updated as best I can from the comments on
> its previous 22-patch posting, but there are some things that I have
> been unable to address (some of which go back to James' posting of
> RFC v2 of the vcpu hotplug series) due to lack of co-operation from
> either reviewers responding to my questions, or from the patch author
> providing information. I have now come to the conclusion that this
> information is never going to come, but there is still benefit to
> moving forward with this patch set. I don't expect that anyone will
> even bother to read this far down the email, so blah blah blah blah
> blah blah blah blah blah. I bet no one reads this so I don't know why
> I bother writing crud like this.

You lost your bet. I always read cover letters completely because they
tell a lot. There is correlation between the amount of blah and the
quality of the series :)

Thanks,

        tglx
