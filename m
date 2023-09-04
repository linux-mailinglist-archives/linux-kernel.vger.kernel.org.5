Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44719791A55
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbjIDPLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDPLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:11:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015781B7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jpUXSSH8Y11T8+ytHsKHPLwnFxqw4wAoGIJkmTxXvjQ=; b=L/WXqXKEuCiU7ibkR5kuvrM4TK
        qvMqL062Rzq4B5Xg15FKJBHkCZgqp95Pjt9V/fFioKZNWawcG6fgo+FmYD6JBNMDc4EB3RDGjzbkl
        3DRYSdtE4nBwh/dBoG7AFKzR8U5uKicdt5UM2Wwmceu1oEO8T47Vah+o4EanX0Zn1iU4WxqUVsCgX
        RCXGilK5eO3PPWcl0UFB/OHugaq9uWMXU/oR4TIN5htjgwtDOUgY4aJ7zGDoK6UJtSDAn+Nitn41X
        KZE/f9XbCafDO1dvxXLPYF5PMQjNKmLGE+7w312QDv1uws+NXcyi+NKbH5TOb8pUVqWES+NCQsEW3
        XK6F7Duw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdBEA-00H9jJ-Mz; Mon, 04 Sep 2023 15:10:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F9EF30058C; Mon,  4 Sep 2023 17:10:58 +0200 (CEST)
Date:   Mon, 4 Sep 2023 17:10:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Bongkyu Kim <bongkyu7.kim@samsung.com>
Cc:     mingo@redhat.com, will@kernel.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/2] locking/rwsem: Make reader optimistic spinning
 optional
Message-ID: <20230904151058.GB25717@noisy.programming.kicks-ass.net>
References: <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CGME20230901010734epcas2p1490c6648e41dfddeb0cc9c39a101da8b@epcas2p1.samsung.com>
 <20230901010704.18493-3-bongkyu7.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901010704.18493-3-bongkyu7.kim@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 10:07:04AM +0900, Bongkyu Kim wrote:

> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 9c0462d515c1..47c467880af5 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -117,6 +117,17 @@
>  # define DEBUG_RWSEMS_WARN_ON(c, sem)
>  #endif
>  
> +static bool __ro_after_init rwsem_opt_rspin;
> +
> +static int __init opt_rspin(char *str)
> +{
> +        rwsem_opt_rspin = true;
> +
> +        return 0;
> +}
> +
> +early_param("rwsem.opt_rspin", opt_rspin);
> +
>  /*
>   * On 64-bit architectures, the bit definitions of the count are:
>   *
> @@ -1083,7 +1094,7 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  	return false;
>  }
>  
> -static inline bool rwsem_no_spinners(sem)
> +static inline bool rwsem_no_spinners(struct rw_semaphore *sem)
>  {
>  	return false;
>  }
> @@ -1157,6 +1168,9 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
>  		return sem;
>  	}
>  
> +	if (!IS_ENABLED(CONFIG_RWSEM_SPIN_ON_OWNER) || !rwsem_opt_rspin)
> +		goto queue;
> +

At the very least this should be a static_branch(), but I still very
much want an answer on how all this interacts with the handoff stuff.
