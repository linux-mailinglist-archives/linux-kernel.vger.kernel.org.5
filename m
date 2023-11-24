Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193CE7F70A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbjKXJ6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKXJ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:58:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038601A5;
        Fri, 24 Nov 2023 01:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lQ2sEyo0urN4jqBS+Brek2Bt3vMQro1GUUqvYK8rVKg=; b=BjHyofms7LwAPkjS/tCo81dqdf
        liv0pQJOMBKG92oyTeTaSxR7JKhtPG90Qk+jDVwl0eXgFwZXTK8iTJfaV3tOAA+2158stf9cmoccC
        cWA1T3V/bsTghJosQRtjs9NXmAC5n4+ZR7+g45jyi4yhCbskaLjYxPeQ1ZRkNQOyFL1DyP0x5iN6c
        KdUjrm3+OtMB75K1RKaII80q8Gj6LymQcaCudX1TbnA7OoJ11MLCerN1VuiotnlLtjyhMkzpfYkFi
        5aICT41xJ1YubZnl1s0uHdYIXjDOqCz27eUg8cBCouyWDgjlrtQQNkvlBrK5qdWHnVUy5UaYCaYrq
        IzN65htw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r6Swm-008Rgh-Se; Fri, 24 Nov 2023 09:58:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87E75300338; Fri, 24 Nov 2023 10:58:04 +0100 (CET)
Date:   Fri, 24 Nov 2023 10:58:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH 2/6] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <20231124095804.GO3818@noisy.programming.kicks-ass.net>
References: <20231122235113.180132-1-kent.overstreet@linux.dev>
 <20231122235113.180132-3-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122235113.180132-3-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:51:09PM -0500, Kent Overstreet wrote:
> This adds a method to tell lockdep not to check lock ordering within a
> lock class - but to still check lock ordering w.r.t. other lock types.
> 
> This is for bcachefs, where for btree node locks we have our own
> deadlock avoidance strategy w.r.t. other btree node locks (cycle
> detection), but we still want lockdep to check lock ordering w.r.t.
> other lock types.

So earlier you added custom sort order.

Additionally there is the wound-wait mutexes that also have semantics
similar to what you describe.

Explain why you can't use either your own added feature or the existing
infrastructure to solve this?
