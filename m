Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DAD7EE5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345297AbjKPRZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:25:23 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30FD52
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:25:19 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9d10972e63eso158444366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700155517; x=1700760317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U1iPlcZ3/XGhU6rtBc5tXppbT+kLnQ6bw9pSEmXipB0=;
        b=PQ9PsVnUZJLJecwswG0j3ImmVGuDiQhL23IkvIByC933XF35kvYMPOps84uSw0i81A
         ZiW5phGiL+jaYK/eGOPZVWP9MCe72T8WY27sVa+OWm8uxCfM1WGcY5i7ibEoDMtP65hW
         3PUESA8eTCwbLiUchzeuWnkviX8wNepxZNy88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700155517; x=1700760317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1iPlcZ3/XGhU6rtBc5tXppbT+kLnQ6bw9pSEmXipB0=;
        b=cogwH1h7f3GQcQhj/jAfE2KRy1Xqc8zU8WivURE94xNWeXGNj3cV9/KoNXQBQEPEuP
         e9+U78u5uml04ZSfXuvAhTHK1DPHMlfK2v3YLDoHFBBpEXKfEzjTZbzF9bYeIJ5wg0ej
         b5jbuta/rOM4c2JZ5l7lWNtnmBhxib9r6KUCf27mQkHtJePMceD+hm3irRHPFJ1jm35k
         uTjnxKtX1cc/iXkr/0PmrDIkvhtkZbXcioFD3QLjrnhQT5ZqgWS6PF+Mq8la18LkkGQx
         uHI4mG2me19atP4oRhwOuFrl6xIsB4TNmBhqjKcO43N8wISWqhTSdywqbaG1Vevb7Lyc
         /rcw==
X-Gm-Message-State: AOJu0YwuyF40nqRgV8MWeXaHH0NmM4/ZJQw37LUPq/A1J9ef57eLH+2R
        FnjOU515XFvz2DmrsAraLvrwlg1nRbqEEZt8K2xb/MbK
X-Google-Smtp-Source: AGHT+IGtlasRXQ19yP32HPG02a04YIhaHUgLS9Tq8twXaL6eKhmXYXsdsfEsg0Tcih3/4+R4An4l2w==
X-Received: by 2002:a17:906:6a1f:b0:9bd:d1e8:57f1 with SMTP id qw31-20020a1709066a1f00b009bdd1e857f1mr16389089ejc.50.1700155517623;
        Thu, 16 Nov 2023 09:25:17 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906d11600b009929ab17be0sm8668600ejz.162.2023.11.16.09.25.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 09:25:16 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1557453a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:25:16 -0800 (PST)
X-Received: by 2002:aa7:c993:0:b0:53d:a17a:7576 with SMTP id
 c19-20020aa7c993000000b0053da17a7576mr13094274edt.8.1700155516281; Thu, 16
 Nov 2023 09:25:16 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk> <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
 <42895.1700089191@warthog.procyon.org.uk> <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
 <4cfd4808cc694f169aa8b83547ebc74d@AcuMS.aculab.com>
In-Reply-To: <4cfd4808cc694f169aa8b83547ebc74d@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Nov 2023 12:24:58 -0500
X-Gmail-Original-Message-ID: <CAHk-=whuKOMn73oinrTQCcNwhXNOw5eksSBiCSzxycZ--asp4Q@mail.gmail.com>
Message-ID: <CAHk-=whuKOMn73oinrTQCcNwhXNOw5eksSBiCSzxycZ--asp4Q@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Laight <David.Laight@aculab.com>
Cc:     David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 at 11:55, David Laight <David.Laight@aculab.com> wrote:
>
> I presume lack of coffee is responsible for the s/movs/stos/ :-)

Yes.

> How much difference does FSRM actually make?
> Especially when compared to the cost of a function call (even
> without the horrid return thunk).

It can be a big deal.  The subject line here is an example. On that
machine, using the call to 'memcpy_orig' clearly performs *noticeably*
better. So that 16% regression was"fast  apparently at least partly
because of

  -11.0  perf-profile.self.cycles-pp.memcpy_orig
  +14.7  perf-profile.self.cycles-pp.copy_page_from_iter_atomic

where that inlined copy (that used 'rep movsq' and other things around
it) was noticeably worse than just calling memcpy_orig that does a
basic unrolled loop.

Now, *why* it matters a lot is unclear. Some machines literally have
the "fast rep string" code disabled, and then "rep movsb" is just
horrendous. That's arguably a machine setup issue, but people have
been known to do those things because of problems (most recently
"reptar").

And in most older microarchitectures it's not just the cycles in the
repat thing, it is also a pipeline stall and I think it's also a
(partial? full?) barrier for OoO execution. That pipeline stall was
most noticeable on P4, but it's most definitely there on other cores
too.

And the OoO execution batter can mean that it *benchmarks* fairly well
when you just do "rep movs" in a loop to test, but then if you have
code *around* it, it causes problems for the instructions around it.

I have this memory from my "push for -Os" (which is from over a decade
ago, to take my memory with a pinch of salt) of seeing "rep movsb"
followed by a load of the result causing a horrid stall on the load.

A regular load-store loop will have the store data forwarded to any
subsequent load, but "rep movs" might not do that and if it works on a
cacheline level you might lose out on those kinds of things.

Don't get me wrong - I really like the rep string instructions, and
while they have issues I'd *love* for CPU's to basically do "memcpy"
and "memset" without any library call overhead. The security
mitigations have made indirect calls much worse, but they have made
regular function call overhead worse too (and there's the I$ footprint
thing etc etc).

So I like "rep movs" a lot when it works well, but it most definitely
does not work well everywhere.

Of course, while the kernel test robot doesn't seem to like the
inlined "rep movsq", clearly the machine David is on absolutely
*hates* the call to memcpy_orig. Possibly due to mitigation overhead.

The problem with code generation at this level is that you win some,
you lose some. You can seldom make everybody happy.

                 Linus
