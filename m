Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B6879F3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjIMVnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjIMVnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:43:06 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134701739
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:43:02 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79565370a93so11106839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694641381; x=1695246181; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWw/GgRkO6GSoA0lYdFcK3fV5kiUwH+NqpK5ZJCXdHU=;
        b=fZRPU2JQXjGIqE6BxLzRuKqifOnMq65jd/CEON042Z5bdNJQyzlvee3KVCpHvveAI5
         IdSQP+aq9zWdcAPM4i8sTaFWrJ9garZ3K5SPXd+FKcFAmo8ElNSfrqsRraf8MkLV1CKE
         6gmk4YJfA+vLdmCsGaHfAQ4iKPmErifV62LuBRTZ63BKH2qrcuVo/BCjmV2NHFNJT2zT
         NiIlk+gkReHUfrv8NmxFkt4oqNJHkMBZZ7BOg++1OIm5xAezQY7KaxAP3Pn4RH6KFj3d
         YCYEvX21/YHVadGkILkIne4nbqOyCkKTVermjoZOi5ggcSQnA/8AmIwWzeIYuav7zQYs
         8cdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694641381; x=1695246181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWw/GgRkO6GSoA0lYdFcK3fV5kiUwH+NqpK5ZJCXdHU=;
        b=ODhsjzWCnnN1Yn+3wPfM/cWEIuhMO0ySPnFotbrEaIKkC1NS6EMMfiwZFgqma11jBF
         zajZpmBFZtAClFVeVGR0PiY8fioClL9gozSEoiw9715dSdeN2EbTJZ0mkMDqm5yNbXvQ
         ePu7kVOir1/DSvaemUY6bHztxz1aaF+O6ubUvoiYAL6wdYL2IMgrWqwVEpX4TOUBnXWW
         rGMSz+oaSMz5w8MVXfhvDOvz/EwoRc1mdfOWM+YpbabukmFD8Y6SdpZvBr/U8gcVVQwh
         rcK2ydcE13mjfIKMAnwKRJRvoqFSWbsova8/G9RdYhBCmI8Qs7legG/UKbVe6K3cp0G1
         Derg==
X-Gm-Message-State: AOJu0YzIhJeX9gUOPBdg+5kdPsFcNXnMssRsdMi6XVH/KYVyHWbJsiek
        kMPWr84gGFvCTezONtosmOZNIA==
X-Google-Smtp-Source: AGHT+IEW9tSNFuxjhVWsQo//UJue72qdTRJDT7UqhRqtQNQzNxPtNM01ZBxmyCinF0Ee+0CnJZ1m9Q==
X-Received: by 2002:a05:6e02:1d93:b0:34b:aa34:a5c4 with SMTP id h19-20020a056e021d9300b0034baa34a5c4mr4118911ila.30.1694641381373;
        Wed, 13 Sep 2023 14:43:01 -0700 (PDT)
Received: from google.com (26.103.132.34.bc.googleusercontent.com. [34.132.103.26])
        by smtp.gmail.com with ESMTPSA id b11-20020a02a58b000000b0042b09036e5fsm21283jam.175.2023.09.13.14.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:43:00 -0700 (PDT)
Date:   Wed, 13 Sep 2023 21:42:57 +0000
From:   Justin Stitt <justinstitt@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kent.overstreet@linux.dev, bfoster@redhat.com,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH 1/7] bcachefs: Fix -Wformat in
 bch2_set_bucket_needs_journal_commit()
Message-ID: <20230913214257.vsjt5qrpa57sjcg7@google.com>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
 <20230912-bcachefs-warning-fixes-v1-1-a1cc83a38836@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-1-a1cc83a38836@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 12:15:38PM -0700, Nathan Chancellor wrote:
> When building bcachefs for 32-bit ARM, there is a compiler warning in
> bch2_set_bucket_needs_journal_commit() due to a debug print using the
> wrong specifier:
>
>   fs/bcachefs/buckets_waiting_for_journal.c:137:30: error: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Werror,-Wformat]
>     136 |         pr_debug("took %zu rehashes, table at %zu/%zu elements",
>         |                                                   ~~~
>         |                                                   %lu
>     137 |                  nr_rehashes, nr_elements, 1UL << b->t->bits);
>         |                                            ^~~~~~~~~~~~~~~~~
>   include/linux/printk.h:579:26: note: expanded from macro 'pr_debug'
>     579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
>         |                          ~~~    ^~~~~~~~~~~
>   include/linux/dynamic_debug.h:270:22: note: expanded from macro 'dynamic_pr_debug'
>     270 |                            pr_fmt(fmt), ##__VA_ARGS__)
>         |                                   ~~~     ^~~~~~~~~~~
>   include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
>     250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
>         |                                                                  ^~~~~~~~~~~
>   include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
>     248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
>         |                                                                        ^~~~~~~~~~~
>   include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
>     224 |                 func(&id, ##__VA_ARGS__);                       \
>         |                             ^~~~~~~~~~~
>   1 error generated.
>
> On 64-bit architectures, size_t is 'unsigned long', so there is no
> warning when using %zu but on 32-bit architectures, size_t is
> 'unsigned int'. Use the correct specifier to resolve the warning.
>
> Fixes: 7a82e75ddaef ("bcachefs: New data structure for buckets waiting on journal commit")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  fs/bcachefs/buckets_waiting_for_journal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/bcachefs/buckets_waiting_for_journal.c b/fs/bcachefs/buckets_waiting_for_journal.c
> index 81ab685cdef9..ec1b636ef78d 100644
> --- a/fs/bcachefs/buckets_waiting_for_journal.c
> +++ b/fs/bcachefs/buckets_waiting_for_journal.c
> @@ -133,7 +133,7 @@ int bch2_set_bucket_needs_journal_commit(struct buckets_waiting_for_journal *b,
>  	b->t = n;
>  	kvfree(t);
>
> -	pr_debug("took %zu rehashes, table at %zu/%zu elements",
> +	pr_debug("took %zu rehashes, table at %zu/%lu elements",
>  		 nr_rehashes, nr_elements, 1UL << b->t->bits);
>  out:
>  	mutex_unlock(&b->lock);
>
> --
> 2.42.0
>
