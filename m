Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027207ABA42
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjIVTrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:47:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78752AC
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 12:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FGDuEdnl3l5utwLCLWhQ/pexaLBdevadmo9pKsXaJrY=; b=NU60oxKs5eFsUgnwNlpvYi7ubt
        2h73DuZ2PLfTZPKNim0BCD4q3jv+DSjLIPH6MR8FYPJisgz8PJyE4BAJBrwj7faJW5CGsJiCr0p3j
        w3oCLa3vwXdq/m1sgdeQknBDxQC63J0wXS8GbKiEVM/ay8fnbKPY9ix2n8agNOGfsPmbXJowIxrqe
        +UOfbe1BO5WxxelvwwSNrZMiFPP52dxlx4hMkNU37WXlmD7xi18wjKlyGY9H/u9rm8cSWyQQmD9JW
        afCbszdKJxLH73+GySe5Uv00TwEQAuQRCDqJTtvRiYj/7BTMSRWYxCWJlzXWjvSAG+KFK1MqyG4sb
        C5JCUVyQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjm7D-00GVno-2N;
        Fri, 22 Sep 2023 19:47:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9883B30042E; Fri, 22 Sep 2023 21:47:04 +0200 (CEST)
Date:   Fri, 22 Sep 2023 21:47:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <20230922194704.GA40277@noisy.programming.kicks-ass.net>
References: <20220909192848.963982-1-longman@redhat.com>
 <20230921074247.GC14803@noisy.programming.kicks-ass.net>
 <06163c13-03b2-bfe0-90b4-5267a039a02c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06163c13-03b2-bfe0-90b4-5267a039a02c@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 02:45:04PM -0400, Waiman Long wrote:

> I believe early_printk should only be used in the non-SMP boot process. The
> use of printk() is frequently used for debugging purpose and the insertion
> of printk at some lock critical section can cause the lockdep splat to come
> out obscuring the debugging process.

By default early_printk is disabled somewhere early, but it has a keep
argument to keep it around.

Anyway, printk() as it exists today is wholly unsuited for debugging.
There are too many contexts where it will flat out not work. When you
use early_print with keep then you can use early_printk() instead of
printk() to debug.

Also, see the patches I pointed John at. Perf would not be what it is
without those patches.

Serial lines and early printk are not optional. That is, I flat out
refuse to develop on machines without them.

