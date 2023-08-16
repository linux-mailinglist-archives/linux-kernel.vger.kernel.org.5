Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763B77DD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjHPJRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbjHPJRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:17:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E791926A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vg8fQ/pZJxXr7ML8z4R4MgPdSZpsCgCIgx3lQNPl/o8=; b=rqKlOfyXc52ON/JixgLYaLckQr
        PxeZXqtbZBYS3IVsBmF/MxLmhegnjU8LOQ+LiQjrJeZaWssOeN79ajvNRm5nQtOL2CAul2Dz1FAWE
        qssgcEMHxjlbd8n2dBBa9IyNjcK1l3m413zuzpf+KueEVI2BVlZeBhLWxwzmq3Fn5dr7RvjKLvOUP
        0iRNu3FESr0WbtXJOPkTkppCGNrKFBWCCbu9owtV/7/lDZMXk2QSI0B2ZTkPy5wv/ne5Tgyu4j/Az
        S/X9/E5eCOlrO/GWyDd7C2/lkxrlvGUsyzvxpDmVLJrPa6BcIOAIK+476zzxfEflJmBqQcMJiMhR1
        yh4vEPcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWCeK-00Dn7N-4p; Wed, 16 Aug 2023 09:17:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4902F30020C;
        Wed, 16 Aug 2023 11:17:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EAEB2C71837C; Wed, 16 Aug 2023 11:17:07 +0200 (CEST)
Date:   Wed, 16 Aug 2023 11:17:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: cleanup: Make no_free_ptr() __must_check
Message-ID: <20230816091707.GA980931@hirez.programming.kicks-ass.net>
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
 <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
 <20230815135339.GA966323@hirez.programming.kicks-ass.net>
 <a68424ff-b5e5-4dab-5705-5b63084c98eb@rasmusvillemoes.dk>
 <CAHk-=wiOXePAqytCk6JuiP6MeePL6ksDYptE54hmztiGLYihjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOXePAqytCk6JuiP6MeePL6ksDYptE54hmztiGLYihjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:00:17AM +0000, Linus Torvalds wrote:

> So I think it needs to be something like
> 
>   #define __get_and_free_ptr(p) \
>       ({ __auto_type __ptr = &(p); \
>          __auto_type __val = *__ptr; \
>          *__ptr = NULL;  __val; })
> 
>   static inline __must_check
>   const volatile void * __must_check_fn(const volatile void *val)
>   { return val; }
> 
>     #define no_free_ptr(p) \
>         ((typeof(p)) __must_check_fn(__get_and_free_ptr(p)))
> 
> the above is entirely untested. Of course.

That works and is *much* saner than the horrible thing I did.
