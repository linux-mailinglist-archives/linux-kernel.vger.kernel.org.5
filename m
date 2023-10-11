Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436327C4E54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345877AbjJKJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjJKJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:17:32 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB60394
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:17:31 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-66b024d26e2so6588286d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697015851; x=1697620651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0ui4FIOXF4erofK3EEiBiXcu0Hxm1HMmxaKkqRWWBw=;
        b=wh8oxInpFZtf6XXQiMQnRBsMtFbLoHpOZgY41h+uCfOcYjlAk+rwyA7EgR8X09IHXI
         al05NAmn5RT5CR7aCyx7mYSubWFrjnSyICRSOwGK9qeoBgVTXmFDo5gcModECI6w6yoh
         62RVPOunDUPP9MWog3JCEBLziWNMJcZZcZhDLvOko1r4bJ1aCjCscfk5s17cIe1ln3P9
         o/DgJA/V5gwbImmxr7A9Elum47fq6294BG+Bb5mMarLWuqkLLoj9SkiKqXJRi5KP0kHS
         x0979Y562zkSd1NUkseqfxSDZadZSZ+CVoaTNZBLwXPjOGCjsLzoWOXe5Ch2NOLmeA7/
         2SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697015851; x=1697620651;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0ui4FIOXF4erofK3EEiBiXcu0Hxm1HMmxaKkqRWWBw=;
        b=Q6944EQyI/U2U1IKg3sV8tNNAZ9aEGxkObFmdCSB3WsjLsRr1feKMw7jTKF+m8YTDH
         QVXryzJCM1WiPmagAJ9rKP8jqmBg0shB8e+NZaH/KevWOZdQQSIbQ8y6poeFy/uziDHX
         bu/DBQk4hoerrkDa1ME0mjXcY05S8S9hrvOEWlxpslvz/1kBHfNa1krhTlZz6XgNXJLm
         G4guAokn11Yu2kQVsDC2Qm5/05jir7GN0MDShW+/TgQd95xwvDUsdUHe2834fpeNhxTX
         J/BdczEOw7tEdv4od6qTbu3+1bg7eSHF6/v7G7aplgdymta4FDtPXX95+YkbpfVVIOPI
         aI/A==
X-Gm-Message-State: AOJu0YxSsrBWpwU7bRPjvEGb0j1bS6ub6sZRZOWfDEAcasrtDSx1WkJQ
        hsoLCwfGZNvuJ0j3dQ5uZH549dBuVjOcnIDiTBDLcA==
X-Google-Smtp-Source: AGHT+IG+rPyyOblyJSoglo8ncjt3dp7Z3DIXVrqQ4vGB7pn+rmpGmyxgol88V0zb3M685htN9UAVO3vWeH+qrZJ4lK4=
X-Received: by 2002:a0c:cc02:0:b0:65b:2738:9bb4 with SMTP id
 r2-20020a0ccc02000000b0065b27389bb4mr26931856qvk.23.1697015850728; Wed, 11
 Oct 2023 02:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-12-matteorizzo@google.com> <386c175e-bd10-2d5d-6051-4065f6f9b84a@intel.com>
In-Reply-To: <386c175e-bd10-2d5d-6051-4065f6f9b84a@intel.com>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Wed, 11 Oct 2023 11:17:18 +0200
Message-ID: <CAHKB1wLetbLZjhg1UVhA1QwZHo226BRL=Khm962JEfh0F+CVbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/14] mm/slub: allocate slabs from virtual memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 23:57, Dave Hansen <dave.hansen@intel.com> wrote:
>
> I assume that the TLB flushes in the queue are going to be pretty sparse
> on average.
>
> At least on x86, flush_tlb_kernel_range() falls back pretty quickly from
> individual address invalidation to just doing a full flush.  It might
> not even be worth tracking the address ranges, and just do a full flush
> every time.
>
> I'd be really curious to see how often actual ranged flushes are
> triggered from this code.  I expect it would be very near zero.

I did some quick testing with kernel compilation. On x86
flush_tlb_kernel_range does a full flush when end - start is more than 33
pages and a ranged flush otherwise. I counted how many of each we are
triggering from the TLB flush worker with some code like this:

if (addr_start < addr_end) {
if ((addr_end - addr_start) <= (33 << PAGE_SHIFT))
partial_flush_count++;
else
full_flush_count++;
}

Result after one run of kernbench:

# cat /proc/slab_tlbinfo
partial 88890 full 45223

So it seems that most flushes are ranged (at least for this workload).

-- Matteo
