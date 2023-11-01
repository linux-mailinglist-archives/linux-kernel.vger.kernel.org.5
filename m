Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FC7DE625
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjKASfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjKASfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:35:09 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB1185
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:34:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so159270b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698863694; x=1699468494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dMZ7WyxK/DRNQF6CaE0gUtE1hgVzyYnCNOFILkGCFw=;
        b=fCpl8m/JfajkNfkVL6N/mQd+k5aJWfT6IkM2Dh2ssj+ES2yDvXuhYmy4dmb0SyeaZr
         At4Xj116TQadV1my1v6uTiUsg4MjrSiWwFOfEdzNIJFRToWVZLqJfG5NZnrl7jGYM6sZ
         7ouQjwmcbwBk16imgVQ036ililwAwMksYAJccX1DllMkyo00XefexD0njFF1NbTB/KOX
         g0hbczNhY2rwCNIortYndokVA0uC+dwh1txF97hPDm642qf30i3sCPJmDSD0hF9qs8Mn
         a2rwZpsjY00tkCc82+bzkk5ODGWG7CkuqWQMWqtY+kjSUXLuRVe5D2T6nM5AmmgG5TUG
         8qXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698863694; x=1699468494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dMZ7WyxK/DRNQF6CaE0gUtE1hgVzyYnCNOFILkGCFw=;
        b=OikqIN4tfzbQBJlIfLcgbVVe95byoFgggbWw4qTTiwcJnf5U0aSDa36/SkFFto88kh
         kS3PUTVAkhLnFFXfdeDlzvCPBzWh5qIfY1wxEXeiHLwD0AxU4Ux7CpdI/BIXwX6bM1/p
         TQ+swOsAgXhvMGKxstd7cCzrfs8lxdE5VdIJfWoqPLLsMUZ5yJZZ7BBwXu05uVzLvoMw
         bHRQCGvkJgJMC4G1EeOXXatk21FRo4SHuGUCtxuHMGMIEzHva9/pghVDPNl2DSzwf++S
         xZQn/7C9UjnHFTFRZIETY/M078Zv3CosAfRVP+tibLlp8U/321WYWBX/RwclMQ0HTKP0
         2hLA==
X-Gm-Message-State: AOJu0YzuSrKaiihPRtlMoUrSDBEZNP2QADBA3ysqo9ER4F4Nj0XbpzBi
        0O2jfepnyPPUOF4Cj83hA6SB2gT/Hrn5FYufEIzkeylb
X-Google-Smtp-Source: AGHT+IHq5yuoTWK9GvXABpNmyWldkuYHiGtbT+x2Lz0jsuwY6bBa1q/MIqyQFA3kIssO9gKl4WlAsg==
X-Received: by 2002:a05:6a00:4a14:b0:6c3:1b7d:ecee with SMTP id do20-20020a056a004a1400b006c31b7deceemr297117pfb.15.1698863693495;
        Wed, 01 Nov 2023 11:34:53 -0700 (PDT)
Received: from google.com (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with ESMTPSA id g2-20020a056a001a0200b006b341144ad0sm1540953pfv.102.2023.11.01.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 11:34:52 -0700 (PDT)
Date:   Wed, 1 Nov 2023 18:34:48 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH RFC 00/20] Setting up Binder for the future
Message-ID: <ZUKaSD4sPtHzlqfT@google.com>
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 06:01:30PM +0000, Alice Ryhl wrote:
> We're generally not proponents of rewrites (nasty uncomfortable things
> that make you late for dinner!). So why rewrite Binder? 
> 
> Binder has been evolving over the past 15+ years to meet the evolving
> needs of Android. Its responsibilities, expectations, and complexity
> have grown considerably during that time. While we expect Binder to
> continue to evolve along with Android, there are a number of factors
> that currently constrain our ability to develop/maintain it. Briefly
> those are:
> 
> 1. Complexity: Binder is at the intersection of everything in Android and
>    fulfills many responsibilities beyond IPC. It has become many things
>    to many people, and due to its many features and their interactions
>    with each other, its complexity is quite high. In just 6kLOC it must
>    deliver transactions to the right threads. It must correctly parse
>    and translate the contents of transactions, which can contain several
>    objects of different types (e.g., pointers, fds) that can interact
>    with each other. It controls the size of thread pools in userspace,
>    and ensures that transactions are assigned to threads in ways that
>    avoid deadlocks where the threadpool has run out of threads. It must
>    track refcounts of objects that are shared by several processes by
>    forwarding refcount changes between the processes correctly.  It must
>    handle numerous error scenarios and it combines/nests 13 different
>    locks, 7 reference counters, and atomic variables. Finally, It must
>    do all of this as fast and efficiently as possible. Minor performance
>    regressions can cause a noticeably degraded user experience.
> 
> 2. Things to improve: Thousand-line functions [1], error-prone error
>    handling [2], and confusing structure can occur as a code base grows
>    organically. After more than a decade of development, this codebase
>    could use an overhaul.
> 
> 3. Security critical: Binder is a critical part of Android's sandboxing
>    strategy. Even Android's most de-privileged sandboxes (e.g. the
>    Chrome renderer, or SW Codec) have direct access to Binder. More than
>    just about any other component, it's important that Binder provide
>    robust security, and itself be robust against security
>    vulnerabilities.
> 
> It's #1 (high complexity) that has made continuing to evolve Binder and
> resolving #2 (tech debt) exceptionally difficult without causing #3
> (security issues). For Binder to continue to meet Android's needs, we
> need better ways to manage (and reduce!) complexity without increasing
> the risk.

I 100% agree with this as the vast majority of my time is spent chasing
after memory corruption issues. The fixes here may look simple on the
surface but the complexity makes them non-trivial and there are many
"hidden" things to watch out for.

> 
> The biggest change is obviously the choice of programming language. We
> decided to use Rust because it directly addresses a number of the
> challenges within Binder that we have faced during the last years. It
> prevents mistakes with ref counting, locking, bounds checking, and also
> does a lot to reduce the complexity of error handling. Additionally,
> we've been able to use the more expressive type system to encode the
> ownership semantics of the various structs and pointers, which takes the
> complexity of managing object lifetimes out of the hands of the
> programmer, reducing the risk of use-after-frees and similar problems.

The history in binder teach us that is quite hard to write a patch with
some confidence that it won't introduce one of these issues.

> 
> Rust has many different pointer types that it uses to encode ownership
> semantics into the type system, and this is probably one of the most
> important aspects of how it helps in Binder. The Binder driver has a lot
> of different objects that have complex ownership semantics; some
> pointers own a refcount, some pointers have exclusive ownership, and
> some pointers just reference the object and it is kept alive in some
> other manner. With Rust, we can use a different pointer type for each
> kind of pointer, which enables the compiler to enforce that the
> ownership semantics are implemented correctly.
> 
> Another useful feature is Rust's error handling. Rust allows for more
> simplified error handling with features such as destructors, and you get
> compilation failures if errors are not properly handled. This means that
> even though Rust requires you to spend more lines of code than C on
> things such as writing down invariants that are left implicit in C, the
> Rust driver is still slightly smaller than C binder: Rust is 5.5kLOC and
> C is 5.8kLOC. (These numbers are excluding blank lines, comments,
> binderfs, and any debugging facilities in C that are not yet implemented
> in the Rust driver. The numbers include abstractions in rust/kernel/
> that are unlikely to be used by other drivers than Binder.)
> 
> Although this rewrite completely rethinks how the code is structured and
> how assumptions are enforced, we do not fundamentally change *how* the
> driver does the things it does. A lot of careful thought has gone into
> the existing design. The rewrite is aimed rather at improving code
> health, structure, readability, robustness, security, maintainability
> and extensibility. We also include more inline documentation, and

Can you expand a bit more on what the plan is here? Is it a two step
process? e.g. replacing first and then revisiting the *how* binder does
things later?

> improve how assumptions in the code are enforced. Furthermore, all
> unsafe code is annotated with a SAFETY comment that explains why it is
> correct.
> 
> We have left the binderfs filesystem component in C. Rewriting it in
> Rust would be a large amount of work and requires a lot of bindings to
> the file system interfaces. Binderfs has not historically had the same
> challenges with security and complexity, so rewriting binderfs seems to
> have lower value than the rest of Binder.
> 
> Correctness and feature parity
> ------------------------------
> 
> Rust binder passes all tests that validate the correctness of Binder in
> the Android Open Source Project. We can boot a device, and run a variety
> of apps and functionality without issues. We have performed this both on
> the Cuttlefish Android emulator device, and on a Pixel 6 Pro.
> 
> As for feature parity, Rust binder currently implements all features
> that C binder supports, with the exception of some debugging facilities.
> The missing debugging facilities will be added before we submit the Rust
> implementation upstream.
> 
> Performance numbers
> -------------------
> 
> We have tested the driver using two different benchmarks:
> binderThroughputTest [3] and binderRpcBenchmark [4]. These benchmarks
> show that the Rust implementation has very promising performance
> characteristics. That said, these are only microbenchmarks with very
> simple workloads, and there is still a lot of work to be done before we
> can truly understand how the drivers compare in the real world.
> 
> binderThroughputTest:
> Some visualizations of the benchmarking results are available at the
> following links:
> 
> Average latency with no payload: https://raw.githubusercontent.com/Darksonn/linux/rust-binder-rfc/img-for-rust-binder-rfc/Average%20latency%20with%20no%20payload.png
> Average latency with 4k payload: https://raw.githubusercontent.com/Darksonn/linux/rust-binder-rfc/img-for-rust-binder-rfc/Average%20latency%20with%204k%20payload.png
> 99 percentile latency with no payload: https://raw.githubusercontent.com/Darksonn/linux/rust-binder-rfc/img-for-rust-binder-rfc/99%20percentile%20latency%20with%20no%20payload.png
> 99 percentile latency with 4k payload: https://raw.githubusercontent.com/Darksonn/linux/rust-binder-rfc/img-for-rust-binder-rfc/99%20percentile%20latency%20with%204k%20payload.png
> 
> Raw data with empty payloads:
>     +-----------+----------+---------+----------+---------+----------+----------+
>     | c/s pairs | Rust avg |  C avg  | Rust 99p |  C 99p  | Avg frac | 99p frac |
>     +-----------+----------+---------+----------+---------+----------+----------+
>     |         1 |   17.517 |  17.278 |   31.169 |  34.464 |   +1.38% |   -9.56% |
>     |         2 |   17.405 |  17.425 |   36.051 |  36.825 |   -0.11% |   -2.10% |
>     |         4 |   27.623 |  27.524 |   46.305 |  45.776 |   +0.36% |   +1.16% |
>     |         8 |   25.152 |  25.461 |   61.442 |  61.279 |   -1.21% |   +0.27% |
>     |        16 |   50.251 |  49.987 |  120.158 | 121.297 |   +0.53% |   -0.94% |
>     |        32 |   99.439 | 100.537 |  238.891 | 238.404 |   -1.09% |   +0.20% |
>     +-----------+----------+---------+----------+---------+----------+----------+
> Raw data with 4k payloads:
>     +-----------+----------+---------+----------+---------+----------+----------+
>     | c/s pairs | Rust avg |  C avg  | Rust 99p |  C 99p  | Avg frac | 99p frac |
>     +-----------+----------+---------+----------+---------+----------+----------+
>     |         1 |   19.422 |  19.811 |   30.233 |  31.616 |   -1.96% |   -4.37% |
>     |         2 |   18.393 |  18.277 |   34.790 |  35.319 |   +0.63% |   -1.50% |
>     |         4 |   29.350 |  29.283 |   48.544 |  47.730 |   +0.23% |   +1.71% |
>     |         8 |   25.075 |  25.283 |   66.040 |  65.226 |   -0.82% |   +1.25% |
>     |        16 |   58.608 |  58.949 |  156.657 | 159.709 |   -0.58% |   -1.91% |
>     |        32 |  127.404 | 129.459 |  321.249 | 326.945 |   -1.59% |   -1.74% |
>     +-----------+----------+---------+----------+---------+----------+----------+
> These tables depict roundtrip latencies of transactions as measured by
> binderThroughputTest. Each measurement is given in microseconds. Each
> row has a sample size of 10 million iterations. Negative percentages are
> better for Rust.
> 
> We've found that Rust binder has similar performance to C binder on the
> binderThroughputTest benchmark. The average latencies fluctuate between
> -1.96% and +1.38%.
> 
> binderRpcBenchmark:
>     +---------------------+-----------+---------+----------+---------+-----------+----------+
>     |      Benchmark      | Time Rust | Time C  | CPU Rust |   CPU C | Time frac | CPU frac |
>     +---------------------+-----------+---------+----------+---------+-----------+----------+
>     | pingTransaction     |    21.595 |  22.167 |    9.625 |   9.692 |    -2.58% |   -0.69% |
>     | repeatBinder        |    33.982 |  34.648 |   16.252 |  16.681 |    -1.92% |   -2.57% |
>     | throughput/64       |    26.774 |  26.587 |   11.995 |  11.823 |    +0.70% |   +1.45% |
>     | throughput/1024     |    33.679 |  33.867 |   15.140 |  15.137 |    -0.56% |   +0.02% |
>     | throughput/2048     |    39.744 |  40.092 |   17.898 |  17.926 |    -0.87% |   -0.16% |
>     | throughput/4096     |    52.585 |  53.457 |   23.788 |  24.067 |    -1.63% |   -1.16% |
>     | throughput/8182     |    76.352 |  77.148 |   35.135 |  35.228 |    -1.03% |   -0.26% |
>     | throughput/16364    |   121.875 | 122.877 |   57.342 |  57.614 |    -0.82% |   -0.47% |
>     | throughput/32728    |   212.380 | 212.765 |  101.838 | 101.589 |    -0.18% |   +0.25% |
>     | throughput/65535    |   442.983 | 421.935 |  222.642 | 212.494 |    +4.99% |   +4.78% |
>     | throughput/65536    |   431.250 | 416.916 |  216.634 | 210.160 |    +3.44% |   +3.08% |
>     | throughput/65537    |   512.902 | 492.272 |  242.472 | 232.786 |    +4.19% |   +4.16% |
>     | repeatTwoPageString |   456.546 | 445.398 |  222.921 | 219.821 |    +2.50% |   +1.41% |
>     +---------------------+-----------+---------+----------+---------+-----------+----------+
> This table depicts wall clock time and cpu time measurements over
> various test cases. Each measurement is given in microseconds. The
> throughput benchmarks correspond to the
> BM_throughputForTransportAndBytes test case, and the number is the size
> of the payload. Negative percentages are better for Rust.
> 
> From the above, we find that Rust binder is competitive for all test
> cases except for those with very large transaction sizes. However, this
> is a very rare case in practice [5] and we've been able to fix all other
> performance issues that we've run into, so there's no reason to think
> that we won't also be able to fix this issue. We did not fix it for this

This isn't terrible. Besides being rare binder shouldn't really be used
to send large transaction sizes. You are better off using something else
in those scenarios e.g. shm. However, it would be nice to get to the
bottom of this.

> RFC because we prioritized getting the RFC out to provide context for
> the upcoming discussion at Linux Plumbers Conference [6].
> 
> We ran all of the benchmarks with cross-language LTO enabled, so that C
> code can be inlined into Rust code. We get similar results on the
> Cuttlefish Android emulator (which has an x86 architecture).
> 
> The Binder driver is very performance critical, and although our initial
> numbers are promising, we must gain a better understanding of how it
> performs in realistic workloads and not just in simple benchmarks. What
> we ultimately care about is the performance impact that it has on the
> whole system. Much work remains to be done on this front.

I can send a "stress" test that would tell us more information about the
performance in critical scenarios. Perhaps this can land as kselftest.

> 
> Dependencies
> ------------
> 
> When implementing kernel drivers in Rust, you must write bindings for
> each subsystem that we need to call into from Rust. Binder requires
> quite a few of them. We have not included them in this patch series, but
> you can view them at the following branch:
> 
> https://github.com/Darksonn/linux/commits/rust-binder-rfc
> 
> The branch is based on top of commit 639409a4ac8e ("Merge tag
> 'wq-for-6.7-rust-bindings' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq"),
> which is available in mainline. I did not base it on a tag, since there
> is not yet any tag that includes the Rust workqueue abstractions.
> 
> This RFC uses the kernel's red-black tree for key/value mappings, but we
> are aware that the red-black tree is deprecated. We did this to make the
> performance comparison more fair, since C binder also uses rbtree for
> this. We intend to replace these with XArrays instead. That said, we
> don't think that XArray is a good fit for the range allocator, and we
> propose to continue using the red-black tree for the range allocator.
> (see patch 6)
> 
> Thank you
> ---------
> 
>  * Wedson Almeida Filho who wrote the first version of the driver and
>    started the project.
> 
>  * Miguel Ojeda for his support, and leading the Rust-for-Linux effort,
>    and helping us navigate the upstream community.
> 
>  * Matt Gilbride for his work on the range allocator and oneway spam
>    detection.
> 
>  * Carlos Llamas for patiently answering all my questions to help me
>    understand the C driver, and co-presenting with me at LPC and
>    Kangrejos.
> 
>  * Greg KH for reviews and guidance on upstream development.
> 
>  * Todd Kjos for reviewing the cover letter, answering questions, and
>    pointers on benchmarking the driver.
> 
>  * Matthew Maurer for his mentorship and help with navigating the build
>    system, including getting LTO working.
> 
>  * John Stultz for his help with debugging a performance issue.
> 
>  * Andreas Hindborg for his help with getting LTO working.
> 
>  * Benno Lossin, Gary Guo, Andreas Hindborg, Miguel Ojeda, Wedson
>    Almeida Filho, Martin Rodriguez Reboredo, Björn Roy Baron, Boqun
>    Feng, Tejun Heo, Nathan Huckleberry for reviewing various bindings
>    needed by Binder.
> 
> Thank you,
> Alice
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/android/binder.c?h=v6.5#n2896
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/android/binder.c?h=v6.5#n3658
> [3]: https://android-review.googlesource.com/c/platform/frameworks/native/+/2680818
> [4]: https://cs.android.com/android/platform/superproject/main/+/main:frameworks/native/libs/binder/tests/binderRpcBenchmark.cpp
> [5]: https://cs.android.com/android/_/android/platform/frameworks/native/+/b85e7f7dbd0463d2ba78d53d50e64489fcb01ec4:libs/binder/tests/binderRpcBenchmark.cpp;l=206-217;bpv=1;bpt=0
> [6]: https://lpc.events/event/17/contributions/1427/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (15):
>       rust_binder: add binderfs support to Rust binder
>       rust_binder: add threading support
>       rust_binder: add work lists
>       rust_binder: add nodes and context managers
>       rust_binder: add oneway transactions
>       rust_binder: serialize oneway transactions
>       rust_binder: send nodes in transactions
>       rust_binder: add BINDER_TYPE_PTR support
>       rust_binder: add BINDER_TYPE_FD support
>       rust_binder: add BINDER_TYPE_FDA support
>       rust_binder: add process freezing
>       rust_binder: add TF_UPDATE_TXN support
>       rust_binder: add binder_logs/state
>       rust_binder: add vma shrinker
>       binder: delete the C implementation
> 
> Matt Gilbride (1):
>       rust_binder: add oneway spam detection
> 
> Wedson Almeida Filho (4):
>       rust_binder: define a Rust binder driver
>       rust_binder: add epoll support
>       rust_binder: add non-oneway transactions
>       rust_binder: add death notifications
> 
>  drivers/android/Kconfig                         |   19 +-
>  drivers/android/Makefile                        |    2 +
>  drivers/android/allocation.rs                   |  541 ++
>  drivers/android/binder.c                        | 6630 -----------------------
>  drivers/android/binder_alloc.c                  | 1284 -----
>  drivers/android/context.rs                      |  225 +
>  drivers/android/defs.rs                         |  171 +
>  drivers/android/error.rs                        |   94 +
>  drivers/android/node.rs                         |  761 +++
>  drivers/android/process.rs                      | 1412 +++++
>  drivers/android/range_alloc.rs                  |  442 ++
>  drivers/android/rust_binder.rs                  |  389 ++
>  drivers/android/{binderfs.c => rust_binderfs.c} |  135 +-
>  drivers/android/thread.rs                       | 1552 ++++++
>  drivers/android/transaction.rs                  |  428 ++
>  include/linux/rust_binder.h                     |   16 +
>  include/uapi/linux/android/binder.h             |   30 +-
>  include/uapi/linux/magic.h                      |    1 +
>  rust/bindings/bindings_helper.h                 |    6 +
>  rust/helpers.c                                  |   48 +
>  rust/kernel/file.rs                             |    2 +-
>  rust/kernel/lib.rs                              |    9 +
>  rust/kernel/page_range.rs                       |  715 +++
>  rust/kernel/security.rs                         |   33 +
>  rust/kernel/seq_file.rs                         |   47 +
>  rust/kernel/sync/condvar.rs                     |   10 +
>  rust/kernel/sync/lock.rs                        |   24 +
>  rust/kernel/sync/lock/mutex.rs                  |   10 +
>  rust/kernel/sync/lock/spinlock.rs               |   10 +
>  rust/kernel/task.rs                             |    2 +-
>  scripts/Makefile.build                          |    2 +-
>  31 files changed, 7061 insertions(+), 7989 deletions(-)
> ---
> base-commit: b4be1bd6c44225bf7276a4666fd30b8da9cba517
> change-id: 20231101-rust-binder-464b89651887
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

Thanks Alice and others that have worked hard on this. This is a very
cool and exciting move for Android. I'm very much looking forward to
playing with this Rust binder and getting further on-field results.

--
Carlos Llamas
