Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3E770E1B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHEGal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:30:37 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DA44ED6;
        Fri,  4 Aug 2023 23:30:36 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-583fe10bb3cso31893187b3.2;
        Fri, 04 Aug 2023 23:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691217036; x=1691821836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1deVdX+LzYEoDf7vsg6ItDydaxzW1rpkypTtAc77Ldo=;
        b=hocI5qRhcmyXSgjK0+H06F/DigjmW9zNcUTkw8bGbSP8Up9QmREEicoxw5/UM8Y3Wu
         x1veUnSDlmxpiJ1nxJwRz9HMBJbnvHiqgVRwTQ5Sw20WUlAFxfkVgRv6UURPzyAOTt9+
         QN5GPOEvnmpVYr7bgREmtbFNtLBl6NS733cqoHaBGoHFy9Mik4gjgoLktMX1cB+t37xQ
         Lx+pIfpUygiBfoUelRcVmMVu3NN//KBXX/iD4MT3f/4rBmwCo7UA2kYhfJiE31zK63uF
         +1FUTwhCUfPlSL0t0ebPugTUmztYwYd4zKpZg4BCVqdpGgL6rFPhosDG9vY1XnckORFi
         RfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691217036; x=1691821836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1deVdX+LzYEoDf7vsg6ItDydaxzW1rpkypTtAc77Ldo=;
        b=UfxG638/nuw6WrmML/spPFu+pzFipIvg2p6GMzPdECgOksCAcBnaFAcVp/RhSwsS/A
         oArODamzH8+90RQfTsHtqWoRMFZrUUg6JOBK/tOT8B1B0rZUZKfzHVdtTPw6x/wvvVn5
         cLRORALp4yi94dxQJSMbF5822f8XQgXNSBARdMpmCqWujI1QchQYmPB+N5cbyu/Zc852
         yegjBiCCllLe0dSZfwRgLhnsh9gbzsZyVMOrPBZreynah2NSZAY2wXRwkgSaIc9vg3E/
         GgGviFSzC4SB4h0WtkSSDTkEjoQCf3/1gSyZJDoskBbv8W6y1LmjlRhaOZzEcbUuk6Gu
         SGvA==
X-Gm-Message-State: AOJu0YyDIcT1xYmYvvmQxlhuLutzYah/h0YqaeLxAbh6cu5aiGGi9UZc
        M4NoOwFWPny7nmQCkWZOu/eaWyMpRDFH1uRpDIo=
X-Google-Smtp-Source: AGHT+IGMjrTZavQsDldYd9gbdtphIVYBVyARzYtz6BxfZv89hhYckKzwAXTsUhzzg17ZR58DVPSYS4QbDnBC3XWXbnw=
X-Received: by 2002:a0d:d655:0:b0:586:9f60:72f6 with SMTP id
 y82-20020a0dd655000000b005869f6072f6mr5332389ywd.39.1691217035955; Fri, 04
 Aug 2023 23:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230804090621.400-1-elver@google.com> <20230804090621.400-2-elver@google.com>
 <20230804120308.253c5521@gandalf.local.home>
In-Reply-To: <20230804120308.253c5521@gandalf.local.home>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 5 Aug 2023 08:30:24 +0200
Message-ID: <CANiq72k_=aPidmk-BRVeKfsU=5FLkDxZN5iQKtHn3O1wZi2MUA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] list_debug: Introduce inline wrappers for debug checks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 6:03=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> Can we give actual real names to why the function is "special" besides th=
at
> it now has another underscore added to it?

+1, some docs on top of that can also help a lot to explain the
intended difference quickly to a reader.

Cheers,
Miguel
