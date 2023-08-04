Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27B76FBC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHDIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjHDIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:14:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A414684
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ub9xozJdZmYxTZOsQ/cHAlZFGg0APeLOKKsChweCvEg=; b=j26W0VcEfwD9n/UESi4BExVT/L
        VJk4bonbMp1xZX0mQepndaBFYIBDdlPva/uOtad5UI1cci5luDCiFkU2uMY6slW6oDjPkWmAdZ4SJ
        QoWVoBp1sCbQrUhOxtRceJCJt75BhsIbtQoKfZVFiTS2Rkz6iUz1ZxmoG1z/+nLilKoVAWVaZPUnS
        qDCtVeVO5zprkLYxtfiY9HQGfpXbnXw6YCHlb/18k9Hc0yINNhfUgyP3yKD8xVK3HzbI6CxMPHAc1
        hCruKM387EpMA0P6xpiHB4T7eMFl5DJvdJE2kbLUOjOTTEs3uwnPlGCr5QQVIOJgm+OXVrYlBR2t0
        DXxU2YCw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRpwq-008lxH-0x; Fri, 04 Aug 2023 08:14:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C77730007E;
        Fri,  4 Aug 2023 10:14:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EED1D2107C444; Fri,  4 Aug 2023 10:14:10 +0200 (CEST)
Date:   Fri, 4 Aug 2023 10:14:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: Re: [PATCH v2 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <20230804081410.GK212435@hirez.programming.kicks-ass.net>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
 <20230802193616.GC231007@hirez.programming.kicks-ass.net>
 <ZMr4uBfjKY9dERl2@yury-ThinkPad>
 <20230803084125.GE212435@hirez.programming.kicks-ass.net>
 <ZMwRBqTgkvA7o9x3@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMwRBqTgkvA7o9x3@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 01:41:42PM -0700, Yury Norov wrote:
> Consider MAX_NUMNODES == 64 and nr_node_ids == 4. Then
> small_nodemask_bits == 64.
> 
> The nodes_full() will set all 64 bits:
> 
>   #define nodes_full(nodemask) __nodes_full(&(nodemask), small_nodemask_bits)
>   static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
>   {
>           return bitmap_full(srcp->bits, nbits);
>   }
> 
> And the following nodes_weight() will return 64:
> 
>   #define nodes_weight(nodemask) __nodes_weight(&(nodemask), small_nodemask_bits)
>   static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
>   {
>           return bitmap_weight(srcp->bits, nbits);
>   }

That would be a straight up bug. You're asking it: tell me how many of
these 4 bits are set, and they you say: 64. At which point I'll suggest
they go back to primary school and do the counting lessons again.

Hmm?
