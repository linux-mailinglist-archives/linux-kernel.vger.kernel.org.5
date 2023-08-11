Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45744778A34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjHKJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjHKJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:39:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A5A3C39
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:38:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691746732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKW6frnZPBO5k+LotvM4JpLFikbfsSCjaOX4sVGJgnk=;
        b=D0i22V92/L27VI+3UVhXvKn0jDvqnaJWZifCYe+RlNIYzydr5vMn8ePrh3o3Ac344yiA4w
        20NfmtAPP7o9PjlhcsSKCVzqWwTk8pzRLw6DneSMFiSBLs9EXbsXTyhXpTiMJZLCKX6zBW
        bqF3AphRjuSSgvH4bnGY+y/0oo0bAEl/JYUm0jDdxiScHEGm3jvYd80ut13EcWXgoPVCcc
        p9NxetnS73Jd44PZDpOVz8Ldtk9mzSNUe7TkjVzFWjrHP4KSOzymGJzN8QsEN2LcNEK04C
        q/a3Oxh5n5QV77Hy+6kwN9KIS3feJk51rEXRhcOXHd3bQVUFZY/sOWTpC6x7RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691746732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lKW6frnZPBO5k+LotvM4JpLFikbfsSCjaOX4sVGJgnk=;
        b=qagwCRX5cScfEeJVaZgCvgosUZxBoeq9Sr/GBvs7mgCBCjE+HKTU0A3X6D1cGfbAOsYucv
        fNSRuSI4MNLCCHAw==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 29/30] x86/microcode: Prepare for minimal revision check
In-Reply-To: <20230810205427.GG212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.617422055@linutronix.de>
 <20230810205427.GG212435@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Aug 2023 11:38:51 +0200
Message-ID: <871qg9j4us.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2023 at 22:54, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 08:38:09PM +0200, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> Applying microcode late can be fatal for the running kernel when the update
>> changes functionality which is in use already in a non-compatible way,
>> e.g. by removing a CPUID bit.
>
> This includes all compatibility constraints? Because IIRC we've also had
> trouble because a CPUID bit got set. Kernel didn't know about, didn't
> manage it, but userspace saw the bit and happily tried to use it.

We don't know. If the microcoders screw that minrev constraint up, then
we are up the creek w/o a paddle as before.

> Ofc I can't remember the exact case :/ but anything that changes the
> xsave size/state would obviously cause trouble.

Details. :)
