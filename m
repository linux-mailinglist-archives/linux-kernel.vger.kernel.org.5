Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB44793E5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjIFOKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjIFOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:10:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731A3B4;
        Wed,  6 Sep 2023 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tt4D3SaV+KPBRyJX3TDIXz1/qOjMegHojpxvbyzkBnI=; b=SGpP4R9alvo//Vg65rp/0ue9Aw
        s95I1yGwzMYmfGAUk3hv73Bgjhlsu78uHy24OJ1stkPjsxqQqOu+fRBJymxuEE+TX293wKm4s0AMz
        E6CZOLY+JgIvm5TShKY7WZVVARfRifIOg0+bms6wz2j7BDvbZM0s2MQiY/7/ariuC+ujTXF15jy1i
        Q94dIOelEIOqd8uT/wC+C3K06XQD3Fd7AOU2PyLxv8ahISq9ya4RLer9i+nlJCso0+LI7vn12oK2z
        TuQq3sFbjz8nSmfReSU3pWtGAIj+v57PRDjo6hCthmIolfdb9oxigY0bxY1BYvpAHZb9V56bus/j+
        lmmMKGrQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdtE3-002vwH-KQ; Wed, 06 Sep 2023 14:09:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D6FF3003F2; Wed,  6 Sep 2023 16:09:47 +0200 (CEST)
Date:   Wed, 6 Sep 2023 16:09:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Yury Norov <yury.norov@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] smp: Change function signatures to use
 call_single_data_t
Message-ID: <20230906140947.GA33104@noisy.programming.kicks-ass.net>
References: <20230831063129.335425-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831063129.335425-1-leobras@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 03:31:28AM -0300, Leonardo Bras wrote:
> call_single_data_t is a size-aligned typedef of struct __call_single_data.
> 
> This alignment is desirable in order to have smp_call_function*() avoid
> bouncing an extra cacheline in case of an unaligned csd, given this
> would hurt performance.
> 
> Since the removal of struct request->csd in commit 660e802c76c8
> ("blk-mq: use percpu csd to remote complete instead of per-rq csd") there
> are no current users of smp_call_function*() with unaligned csd.
> 
> Change every 'struct __call_single_data' function parameter to
> 'call_single_data_t', so we have warnings if any new code tries to
> introduce an smp_call_function*() call with unaligned csd.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Fair enough, I'll go queue it somewhere.
