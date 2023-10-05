Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E377B7BAB7C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjJEUgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:35:58 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0332293
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:35:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27752a1e184so1104848a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696538156; x=1697142956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fshyiHld1iaT92zV4X7OYvw4ri66Z9VzIvd68VZWy7U=;
        b=cS/u7qHoGf0Y8B05WSNU4rQr0grOUuNjwbExXMfnynwkibHYBdffDusweNdX832+g7
         JrzGPypPeHwOAoQSb1aSgsJvHydlIyAEbSirkr2W+lRPVGbpK+DnCeGdr0HZHgAxg65U
         q964gwbDCxSGeNMnazr6XCGl/062cnz2hurz9PeghZ2D1fiOa/aCHUBCLRJ0j9CsWjuU
         E8Hl2/JMGT7zE/ORni7bJZkhAp8kv61SoNl4RLTPGqz6Ciee++aJbMmKUjcP/ai+huPJ
         UjP55kWC49zts2Xl5NlS4uLgq6GxOgMrAny3cXudm68XxiLBm15utRZvXk/lL7DkhB7C
         WKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696538156; x=1697142956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fshyiHld1iaT92zV4X7OYvw4ri66Z9VzIvd68VZWy7U=;
        b=WRkvzCv3Jua/kNF3jvRYpQUtXE4nfHFMSb3fEhwNfzo8Z7+t3yEGtP4A/1Io6jsqas
         vZbSCe4+nCIgx1gW9wZ0InoenG9OoDF3PAEjLotA+g1RvNH6xNuxVPv01DLYjOE6/SRI
         B9q2f7KU4uOsfwCBzdu7Xt6THV82+34FyeUSAL/PNdZClc6G/41dlEXYiC1G+szjI1EI
         GKlEa6qLxm9qD3mr2N8ikKNAqHK7DfKaAr8t1JsIA09eOdCndxGZUDgR/vcDpTU2Bcdx
         JHD0p9f2juyRLWt1XZoMmXoh0OY5ExaJxLXvprRMahnlD9fHGYZiCI6m/6Wfh4pGXtN3
         hxzQ==
X-Gm-Message-State: AOJu0YyzT+N+Z6O8SHmIHoFImJPRZNEwTT9x64tJDMQNtkRCvzym9x9K
        xkkbMWFwj5Sf7Fdo9o6CpFgu9nYlT+UCLPlizEOQmJii
X-Google-Smtp-Source: AGHT+IFBps+uCydflmoKIvVDVKyucI0EafiSnozTWDbyFVQCmCqmb87LUDvC8TqhYFtwK9pTKNpcY4CtSBh8QQ7CVXA=
X-Received: by 2002:a05:6a21:6d9b:b0:14b:8023:33cb with SMTP id
 wl27-20020a056a216d9b00b0014b802333cbmr7689179pzb.11.1696538156295; Thu, 05
 Oct 2023 13:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 5 Oct 2023 22:35:45 +0200
Message-ID: <CA+fCnZckOM0ycja3-=08=B3jwoWrYgn1w91eT=b6no9EN0UWLw@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] stackdepot: allow evicting stack traces
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 7:14=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Currently, the stack depot grows indefinitely until it reaches its
> capacity. Once that happens, the stack depot stops saving new stack
> traces.
>
> This creates a problem for using the stack depot for in-field testing
> and in production.
>
> For such uses, an ideal stack trace storage should:
>
> 1. Allow saving fresh stack traces on systems with a large uptime while
>    limiting the amount of memory used to store the traces;
> 2. Have a low performance impact.
>
> Implementing #1 in the stack depot is impossible with the current
> keep-forever approach. This series targets to address that. Issue #2 is
> left to be addressed in a future series.
>
> This series changes the stack depot implementation to allow evicting
> unneeded stack traces from the stack depot. The users of the stack depot
> can do that via new stack_depot_save_flags(STACK_DEPOT_FLAG_GET) and
> stack_depot_put APIs.
>
> Internal changes to the stack depot code include:
>
> 1. Storing stack traces in fixed-frame-sized slots; the slot size is
>    controlled via CONFIG_STACKDEPOT_MAX_FRAMES (vs precisely-sized
>    slots in the current implementation);
> 2. Keeping available slots in a freelist (vs keeping an offset to the nex=
t
>    free slot);
> 3. Using a read/write lock for synchronization (vs a lock-free approach
>    combined with a spinlock).
>
> This series also integrates the eviction functionality in the tag-based
> KASAN modes.
>
> Despite wasting some space on rounding up the size of each stack record,
> with CONFIG_STACKDEPOT_MAX_FRAMES=3D32, the tag-based KASAN modes end up
> consuming ~5% less memory in stack depot during boot (with the default
> stack ring size of 32k entries). The reason for this is the eviction of
> irrelevant stack traces from the stack depot, which frees up space for
> other stack traces.
>
> For other tools that heavily rely on the stack depot, like Generic KASAN
> and KMSAN, this change leads to the stack depot capacity being reached
> sooner than before. However, as these tools are mainly used in fuzzing
> scenarios where the kernel is frequently rebooted, this outcome should
> be acceptable.
>
> There is no measurable boot time performance impact of these changes for
> KASAN on x86-64. I haven't done any tests for arm64 modes (the stack
> depot without performance optimizations is not suitable for intended use
> of those anyway), but I expect a similar result. Obtaining and copying
> stack trace frames when saving them into stack depot is what takes the
> most time.
>
> This series does not yet provide a way to configure the maximum size of
> the stack depot externally (e.g. via a command-line parameter). This will
> be added in a separate series, possibly together with the performance
> improvement changes.

Hi Marco and Alex,

Could you PTAL at the not-yet-reviewed patches in this series when you
get a chance?

Thanks!
