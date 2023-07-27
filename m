Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC6765B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjG0SCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjG0SCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:02:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AC02D5B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:02:01 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2209404e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690480919; x=1691085719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgVYZd/78+/O2NatRupV28b+UFJ4EhyFHfWo2O8AZQc=;
        b=Yj/vpp25ZUIvO6N/U/QM9aowGr4KaB0g7afTBf7DGyIDu1G1V3EENWpXTQzvi6qkw/
         TlA7IQtC80kM+dmzcOD/CtfqgqNRZfGfw1Rfh95l2olGG09qZ7hCzKsc2Gc0df4Aak0y
         AJT2CfiAHregytIW4zc6PtI3doJreA4RD9wrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690480919; x=1691085719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgVYZd/78+/O2NatRupV28b+UFJ4EhyFHfWo2O8AZQc=;
        b=NA3/vcdzWvyzQCsQ3DQQ4fOlWG4aJOhw7Fn5Uk7EmPJM3FSpBWeddvRjvx9aA+6Vqi
         gCF27LHpyQVphlhzzTN0AxEDm8Q0wVdF3aojZ2T+wVduhaUt/stQEDPCu9AWn+WscCb/
         4rpZhTY1L4Vpd6uOXI7o/yeh4ZTKdDrxXv0BQIlhgXXpJsrINYSZdfA4fInCThTy+4Y/
         4nqBVZ16nCWfWT9p7G/lWrEz2wD6wxByxzTmrRBIkEuJI5Jo9VMpDPdei8gae8PxGeRm
         yyIwYq5ZFUzoYExG0M+41AQ4h2DMiSDC0+NAcA3Vy6eSTB+2Y8w6DnjO/QBGD6PePipF
         4DZQ==
X-Gm-Message-State: ABy/qLY9Vth8E+m+eb06MoF5Bi52kiL9vpHsdDQ6pdg8e0eozTSaNMhQ
        KdV6Di+6b0y2W+Qe750IoUdGCkybA91LToJ0VdIdCtvp
X-Google-Smtp-Source: APBJJlE4V4PVdcHx8C5WC0kB9LcKjxStMgQ+I7AW/JaZYqPzYV8Zn3t0Eqhi0+X6lCC8klwLGG3qvQ==
X-Received: by 2002:ac2:4bd5:0:b0:4fe:6fc:1fc7 with SMTP id o21-20020ac24bd5000000b004fe06fc1fc7mr2787869lfq.27.1690480919653;
        Thu, 27 Jul 2023 11:01:59 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id p15-20020a19f00f000000b004fdfd4c1fcesm411363lfc.36.2023.07.27.11.01.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 11:01:57 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2209284e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:01:56 -0700 (PDT)
X-Received: by 2002:ac2:4f15:0:b0:4fe:181f:2736 with SMTP id
 k21-20020ac24f15000000b004fe181f2736mr2122365lfr.33.1690480916074; Thu, 27
 Jul 2023 11:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck> <13dc448b-712e-41ce-b74b-b95a55f3e740@rowland.harvard.edu>
 <CAHk-=whGjpt77tUYRQA6TxiGERp_rSbcNhuKaWbvoJ6yXPwhhQ@mail.gmail.com> <af1eed90-a1d5-4da0-84a0-05e61767ab37@rowland.harvard.edu>
In-Reply-To: <af1eed90-a1d5-4da0-84a0-05e61767ab37@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 27 Jul 2023 11:01:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXP+27F-k7qrkmMYRZLD1Q05expC2x=esgC5qJJS7M1A@mail.gmail.com>
Message-ID: <CAHk-=whXP+27F-k7qrkmMYRZLD1Q05expC2x=esgC5qJJS7M1A@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        paulmck@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 10:41, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> But in the presence of data races (as in the example that Will posted
> earlier), all bets are off.  So if you want to use a plain access rather
> than READ_ONCE, you need to be certain that it won't race with anything.

So in this case, the initial NULL check really is just checking for
"has the smp_store_release() happened". The reason even tearing
wouldn't matter is that seeing *any* value other than all-zeroes (aka
NULL) is already sufficient information.

Because once the smp_store_release() has been seen by this CPU, the
data race no longer exists, and the value is stable.

Which is why I argue that even without READ_ONCE() the code would
*work* due to all the circumstances around it (one of them is that we
just took a lock, after doing an optimistic check that really has no
semantic effect at all except for the "don't even take the lock if it
looks like things are going to fail").

But if we want to have the code be obvious, and not have to refer to
those kinds of arguments, I think smp_load_acquire() is the only
actual "obvious" thing to use. At that point it's no longer some chain
of "because of X, Y and Z".

              Linus
