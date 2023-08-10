Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55B3778239
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbjHJUhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjHJUhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:37:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB64C2733
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=64AjX5aroH1a+1jJWfxVYh2PPt+mbIZOvML3HgFvUsA=; b=I6T+/kBJ5fSGYuOD1rsSOgmGbQ
        dt1/9cAORZnJHt3vMMYg+itWuobdGYkZyZYQyAj+crIS657/pbTPPUnPXhMfNeNNPK/xi9Q7OJeSb
        3qKqf8PUj3H23lpVojkm8RPEaEVcGu8VX6fp6wEDLtSCWNxFX81F2H2k4c3wWJkafEvwnWQk4C/uH
        hkP4UVJ5Fc6uKLza0OZgMRbm4zJOfJK19ykU5c6ERpOuuQvykXTRUZYb+CssMv9fkyZzZR3ERuYfX
        mHc8P1jgH443ffliIki4cqduIIm0aAUYxmcUpAE9Gkmq0QJmvDw/MAbXT8/uAWi0XvoY2Zaq6nhxX
        48ii9EKA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUCOe-00EaJi-SD; Thu, 10 Aug 2023 20:36:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EF6E30026C;
        Thu, 10 Aug 2023 22:36:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 342B32103B6B3; Thu, 10 Aug 2023 22:36:40 +0200 (CEST)
Date:   Thu, 10 Aug 2023 22:36:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 26/30] x86/microcode: Protect against instrumentation
Message-ID: <20230810203640.GE212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.448579267@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810160806.448579267@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:38:04PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The wait for control loop in which the siblings are waiting for the
> microcode update on the primary thread must be protected against
> instrumentation as instrumentation can end up in #INT3, #DB or #PF, which
> then returns with IRET. That IRET reenables NMI which is the opposite of
> what the NMI rendezvouz is trying to achieve.

asm_exc_nmi will re-enable NMIs when DEBUG_ENTRY before we reach C.
Late loading had better depend on !DEBUG_ENTRY.
