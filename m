Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F00777471E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjHHTJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjHHTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D32FA31
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D254762456
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B41C433CA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:05:01 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jowMggc4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1691503497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chf8FUmzD77OYzSkcoByYk3SJOxrgbPfjK0UO5OV0XE=;
        b=jowMggc457l0w5P0KjjSAX4WEd2PHPOQ/ugvjwZM4d9jjUo3AgCCdFObT4lYdxZ/fNChGJ
        Czv1p/IIe8jBX0xX3/KoV5kpXXIwypzkMPHzu93xxbk7gRepmjckmzFC77pbMomHe/S10l
        jXKYkxyJIOHDLU4zkOlWVy0GBjO5FYI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 79122d4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 8 Aug 2023 14:04:56 +0000 (UTC)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56d0f4180bbso3821945eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 07:04:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YxtUbPFq56uDNw4Cg5Gi9DQyByRSv1aDtdpWDDCSAZa6FfRG2iI
        zAjbKohMdHyQctSbeWEOh3bBmRDEgIfDp0KMG/8=
X-Google-Smtp-Source: AGHT+IEAD7iSH8TL9w+ZLrmt0lZOmt9AR135oiy5wGsx3EMERX18Ewt2k2oSj+UeztzUAJxcUXcGWhV5bLsIAv+szTY=
X-Received: by 2002:a05:6358:2611:b0:135:96fa:bff3 with SMTP id
 l17-20020a056358261100b0013596fabff3mr10294439rwc.4.1691503493824; Tue, 08
 Aug 2023 07:04:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230808062658.391595-1-jstultz@google.com> <20230808062658.391595-2-jstultz@google.com>
 <20230808103637.GA212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230808103637.GA212435@hirez.programming.kicks-ass.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Aug 2023 16:03:09 +0200
X-Gmail-Original-Message-ID: <CAHmME9oB1PisGNqFTkE3M3YT1Q_bezS39s_xc9x4GkY87PtFtQ@mail.gmail.com>
Message-ID: <CAHmME9oB1PisGNqFTkE3M3YT1Q_bezS39s_xc9x4GkY87PtFtQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] test-ww_mutex: Use prng instead of rng to avoid
 hangs at bootup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Stultz <jstultz@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Li Zhijian <zhijianx.li@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, John,

On Tue, Aug 8, 2023 at 12:36=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, Aug 08, 2023 at 06:26:41AM +0000, John Stultz wrote:
> > Booting w/ qemu without kvm, I noticed we'd sometimes seem to get
> > stuck in get_random_u32_below(). This seems potentially to be
> > entropy exhaustion (with the test module linked statically, it
> > runs pretty early in the bootup).
> >
> > I'm not 100% sure on this, but this patch switches to use the
> > prng instead since we don't need true randomness, just mixed up
> > orders for testing ww_mutex lock acquisitions.
> >
> > With this patch, I no longer see hangs in get_random_u32_below()
> >
> > Feedback would be appreciated!
>
> Jason, I thought part of the 'recent' random rework was avoiding the
> exhaustion problem, could you please give an opinion on the below?

Thanks for looping me in. I actually can't reproduce this. I'm using a
minimal config and using QEMU without KVM. The RNG doesn't initialize
until much later on in the boot process, expectedly, yet
get_random_u32_below() does _not_ hang in my trials. And indeed it's
designed to never hang, since that would create boot deadlocks. So I'm
not sure why you're seeing a hang.

It is worth noting that in those early boot test-case scenarios,
before the RNG initializes, get_random_u32_below() will be somewhat
slower than it normally is, and also slower than prandom_u32_state().
(But only in this early boot scenario edge case; this isn't a general
statement about speed.) It's possible that in your QEMU machine,
things are slow enough that you're simply noticing the difference. On
my system, however, I replaced `get_random_u32_below()` with `static
u32 x; return ++x % ceil;` and I didn't see any difference running it
under TCG -- it took about 7 seconds either way.

So, from my perspective, you shouldn't see any hang. That function
never blocks. I'm happy to look more into what's happening on your end
though. Maybe share your .config and qemu command line and I'll see if
I can repro?

Jason
