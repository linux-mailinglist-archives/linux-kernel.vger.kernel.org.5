Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFF7C4F30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjJKJh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjJKJh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:37:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627691;
        Wed, 11 Oct 2023 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZZWhJTb7VIJxHwosENExWUwMq4pQEqYalf1VKDcUJSY=; b=ovTUowYuIK2ByyWFlTHOCnr0rm
        cE5yqDViCSCD9LAakFwhFU1M3KNs/7juMDchNdlKCpR5yUOGlvjrrFwLS+R+LBDb55puwdjNpekvu
        JdNI6Fkqsme8l+NILntinSWdheJdzZoZQBxetTsN5Z8LE011Z/1t+5zmkfIkCDsA1liLDR3hovX0t
        XAi4kSEXY8J2+k8y2MMC7/OTzHLztc8h5zFvb9j974LNY1eI+LHGDJV9zryurLxp7ndlpduff4H0J
        AqVWZAVGPQcidk7BBScBwsH2skpYnGr+DUcRM8T1HdLaEH4w/qKuF41/bmnrvjEY5moT5Gog78K5P
        Moad9gqQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqVeg-00A0N0-9Z; Wed, 11 Oct 2023 09:37:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF83F30026F; Wed, 11 Oct 2023 11:37:25 +0200 (CEST)
Date:   Wed, 11 Oct 2023 11:37:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2] x86/alternatives: Disable KASAN in apply_alternatives()
Message-ID: <20231011093725.GD6307@noisy.programming.kicks-ass.net>
References: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
 <20231011074616.GL14330@noisy.programming.kicks-ass.net>
 <ZSZYwvHTSapAaJQv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSZYwvHTSapAaJQv@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:11:46AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >  	DPRINTK(ALT, "alt table %px, -> %px", start, end);
> > > +
> > > +	/*
> > > +	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
> > > +	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
> > > +	 * During the process, KASAN becomes confused and triggers
> > 
> > 	because of partial LA57 convertion ..
> 
> Not all LA57 related sites are patched yet at this point, and KASAN sees
> a weird & broken mixture of LA48 and LA57 runtime semantics, right?
> 
> Ie. as far as KASAN is concerned, the LA48 -> LA57 behavioral switchover
> must be atomic, but during the kernel code patching process it isn't.

Yep, half-way through the patching it observes inconsistencies and goes
WTF :-)
