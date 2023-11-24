Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B347F86B7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKXX3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 18:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjKXX3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 18:29:32 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46081987
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 15:29:38 -0800 (PST)
Date:   Fri, 24 Nov 2023 18:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700868576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/EGZD8n89wHgJ0e26+cxY5z+06768yEOt+oTNbIHBYA=;
        b=JAL5I4lnCAu68RX7Qa8cbnog5QL6gWHrJung9W66xlxroty3l8wzSyyPAe+yNzbglwQNP5
        XNqacQyIKxY4axkYGw9T6dSbEEFOUG9g8m4C/XQ1K0wo2QMK6sWOxOmK2+ZtInyFZI6HNA
        ZS77nxMwHsSG/Le2UTm1S8nSdD7hNAI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, will@kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH 2/6] locking/lockdep: lockdep_set_no_check_recursion()
Message-ID: <20231124232932.7kgjwi6s2h5oo4a2@moria.home.lan>
References: <20231122235113.180132-1-kent.overstreet@linux.dev>
 <20231122235113.180132-3-kent.overstreet@linux.dev>
 <20231124095804.GO3818@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124095804.GO3818@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 10:58:04AM +0100, Peter Zijlstra wrote:
> On Wed, Nov 22, 2023 at 06:51:09PM -0500, Kent Overstreet wrote:
> > This adds a method to tell lockdep not to check lock ordering within a
> > lock class - but to still check lock ordering w.r.t. other lock types.
> > 
> > This is for bcachefs, where for btree node locks we have our own
> > deadlock avoidance strategy w.r.t. other btree node locks (cycle
> > detection), but we still want lockdep to check lock ordering w.r.t.
> > other lock types.
> 
> So earlier you added custom sort order.

That was never merged? I've been meaning to revisit that though and
convert some other things to it, the original patchset just converted
bcache, not bcachefs.

But it's not applicable here, bcachefs doesn't have lock ordering, it
has cycle detection.

> Additionally there is the wound-wait mutexes that also have semantics
> similar to what you describe.

Yeah, we talked about that as well. Wait/wound is similar in principle
but aborts much more frequently, since it's just comparing transaction
start time and not doing full cycle detection.
