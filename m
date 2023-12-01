Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37D68009E5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378545AbjLALZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378601AbjLALZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:25:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ADCC4;
        Fri,  1 Dec 2023 03:25:56 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701429955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTlhtH9a0LDiJlYkT6vgajK3kHtKUEVv+qg/KTKk4HU=;
        b=0+ilR1tNhs5VaMIv76WOvkPT0qv5Fi2xLMjWOd8iwpKFF2e1rQLr8de2mbc/bHnkaNjaQe
        LbiC5q4mkGd+Sj/kPhd1ERxWAS9+FoWokpwkA65PKVnzoPGIz6d5oLfQpSLkrkRNE3pzdQ
        //bcpn1X9PhQ9O1fXMhZdr1auoP18Z7eHjeOjyN9GFUebTn83i1KnnfcKG5x+dss03Xtki
        ttU09OzufBNos8ljNL69jCpLD5yOQ+wCs/EozGUtX5kcJ5FgGKvheIIRatcpoYJRoVyDnr
        D0DygGmWcdNwEcac6KOaBeh495U3limq2zXQEY3QChB6Uu522eK6w17xZwQlAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701429955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTlhtH9a0LDiJlYkT6vgajK3kHtKUEVv+qg/KTKk4HU=;
        b=EXq/pPMbI6sA6TcIEmqxncJn2e32OeM2qAllVTE4SFvTjeMaTIOAzfm4oL3PcYAI5mDcr2
        IYeKQ7k9Tpe0HrBQ==
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
Date:   Fri, 01 Dec 2023 12:25:54 +0100
Message-ID: <87plzqxiyl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Russell!

On Tue, Nov 21 2023 at 13:43, Russell King wrote:
> This series aims to switch most architectures over to using generic CPU
> devices rather than arch specific implementations, which I think is
> worthwhile doing even if the vCPU hotplug series needs further work.

I went through the whole series and I can't find anything
objectionable.

Vs. merging: It does not make sense to split this up and route
individual patches.

So I can pick the whole pile up and route it through tip smp/core unless
Rafael or Greg prefer to take it through one of their trees. For the
latter case:

       Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Greg, Rafael?

Thanks,

        tglx
