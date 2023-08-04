Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372C577074E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjHDRua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHDRu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:50:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707334C03
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:50:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso3862935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691171426; x=1691776226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Im4dcEZwNsAe1Y2oMqCTaJQsYwxClHXtIW7/6pymoyo=;
        b=UphmCrMdpkSP7a4kk/vE3lUOeIiuyB34qLRvc1hVE1UR5N24Pb2doPpops1e0fJZO3
         l7+Bk3H7d5jOmKNeKhcDLsMZJNuIyHqNmGr75RUO5jWp2HPE5ptjfRqhQ0IrbU7mEv97
         MuSxSto9os2ONR7Oe9dcetZWP8f9vvHSvb+t8rF4ZYgDh27z2ODAr7TqttRRHIADws9s
         Ae5OPXRm1TlbOsahEMKzhYUMk1sQ9dGAdCwA0kmpXEK+3dKfbfK4mxVDVwPW58H6cw05
         yLRe304WmuDsKIOPh9865os6tl4CxYMAVH/YKDrjCu9dUNU4OoRCLk4W+tWKgRLfg3Nw
         KRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691171426; x=1691776226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Im4dcEZwNsAe1Y2oMqCTaJQsYwxClHXtIW7/6pymoyo=;
        b=iUpX0aHI8GmiGeI6hCoWzsTmeddpxOf8dlaeqf11aIbqfe+E9BAWZjvojqqG5HVkbg
         mhz6ozDzmy9eLf1i7JSWAjvbx1sb9Hi8D+zvTkoW1uNzIgdR+um22NsDpJpHdSE5CbOo
         7ORCgjpqz9c92ngT/2dWViP9kCk29m1t6uUE+irv/qbeNGc4LJxamGMAetRH5FG4TJuv
         ZEdIx2ZI8F1K0gtOLzMrkZijgM311RvICzt5k5kSpUjsv8DxdNfqkJx+YSPXAoGuSGZq
         uPleYx3Wqu/DHMWZw1oknDfI3DO2TZME7o+wWkZoLoZM3xOpZNAnLFylbWiOno20ASlt
         Gmwg==
X-Gm-Message-State: AOJu0Yxj07QZ18Fe3zwV87h4VuJDyyo2QS5M1SZda2swI+CBPahiteJq
        OReCABNNyS+HhaxIMnaCEmR3xDA4sKn1GGaxzySqOg==
X-Google-Smtp-Source: AGHT+IFCpKdw5xT0hmDqmMcqVOJlFAgL0wRRdu5YxGtWnPb4KKrgp8kcqaD2UASnRwTjmhmQD6u7JjQJgAG5sZzFLQo=
X-Received: by 2002:a1c:cc08:0:b0:3fe:485f:ed13 with SMTP id
 h8-20020a1ccc08000000b003fe485fed13mr2162276wmb.29.1691171425779; Fri, 04 Aug
 2023 10:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230804090621.400-1-elver@google.com> <20230804090621.400-2-elver@google.com>
 <20230804120308.253c5521@gandalf.local.home>
In-Reply-To: <20230804120308.253c5521@gandalf.local.home>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Aug 2023 19:49:48 +0200
Message-ID: <CANpmjNNN6b9L72DoLzu5usGGjLw5Li8rnfu0VuaCsL-p2iKTgg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] list_debug: Introduce inline wrappers for debug checks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 at 18:03, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri,  4 Aug 2023 11:02:57 +0200
> Marco Elver <elver@google.com> wrote:
>
> > Turn the list debug checking functions __list_*_valid() into inline
> > functions that wrap the out-of-line functions. Care is taken to ensure
> > the inline wrappers are always inlined, so that additional compiler
> > instrumentation (such as sanitizers) does not result in redundant
> > outlining.
> >
> > This change is preparation for performing checks in the inline wrappers.
> >
> > No functional change intended.
>
> I think the entire underscoring functions calling more underscoring
> functions in the kernel is an abomination. Yes, there's lots of precedence
> to this craziness, but let's not extend it.
>
> Can we give actual real names to why the function is "special" besides that
> it now has another underscore added to it?
>
> I've been guilty of this madness myself, but I have learned the errors of
> my ways, and have been avoiding doing so in any new code I write.

That's fair. We can call them __list_*_valid() (inline), and
__list_*_valid_or_report() ?
