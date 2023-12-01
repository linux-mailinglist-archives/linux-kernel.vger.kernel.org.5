Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194A800FA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjLAQEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378661AbjLAQD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:03:59 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888A10DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:04:05 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-54c69c61b58so4363a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701446643; x=1702051443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIw3vEF2EG/mTMxw2khY1FH0qqPJ+aeReW5VuqhMwP0=;
        b=V8aYhMYGPG7qXDSgQZV048cN3bvc4ya+jEedS0ehzqcpE8A7T25Ve09tW1ILDL0yQg
         cxAJKjbiIcAmghFPbzabY6ZJqAg9bj8M7I53mgMMmG8ATpRLdj+pgPKe+La2Oqneah5t
         UljG21HuOsew014XfiEEsiXdbDxELwqlPj7QCAuVBKEHtpIqrxxPFE7vdzhC81nRVDzM
         bPD0I6zMqgKwPprPzP2iNZOxu0ClP63y8NFWDy28H/Y2ZHcu8/rp3cz2bc5Qbq7UFHQQ
         f7pryyhSQqi5wk9/BJ8PSKU7Jjc74qIg6pA4aKF+G5ndlZ01EQqCXVL5djZyNHC05Utz
         cS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701446643; x=1702051443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIw3vEF2EG/mTMxw2khY1FH0qqPJ+aeReW5VuqhMwP0=;
        b=NNhNdESHHSy/TdhT52sXLsSofoNY2pXPVlPse4fu5mE1757aOJqTThoT5N5i4kBEZE
         m0Vf2+2dAWP+xPb/rg1vt77fDsouYBpd73ggcQVDMnU6EFtVWx1bD3Amm1/TkxdDEQzx
         MG5fhwOLLJOxKETL88z82EOPO1d5TKV6fmMVlCjUI0uN+vccL8aeLpkUfBwg2xLaoOX5
         zlZGQERQ2RN2WZh+SkomTh+Y/vWbJ7wV5FmG5VN0d5in7F0yfql8dwmw1iJrnmF/t3+x
         s2Dard8fday5cdB5Qe5GdiMX9dgDW9hy7jefCtRcLxtZAdGwkHXWPsEbv9Zl4RAixlWZ
         vlKQ==
X-Gm-Message-State: AOJu0YzdqtyoIzrOlQhrH+2/sUH2wyzyYvUYap4isD5wqk6FQLZS0hVS
        NM/QY2doLsS/tzPQ3GQHdOUqEyNUD/yYUEmXGoRsTQ==
X-Google-Smtp-Source: AGHT+IFbKGM7joZp4qw2RzfIG1a+QAT2tCZJbbGRakYxypzXhqZtf5JyGalyvKMXGjmVbhgvNVqlwR+qh/bbdS/yzjc=
X-Received: by 2002:a50:d49c:0:b0:543:fb17:1a8 with SMTP id
 s28-20020a50d49c000000b00543fb1701a8mr83893edi.3.1701446643476; Fri, 01 Dec
 2023 08:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20231130204817.2031407-1-jannh@google.com> <06c05c8b-9a3b-4c04-b898-0f82e98da70f@redhat.com>
 <CAG48ez1a=VuEWwPTjcXFAwCyt9bRH-WzAfw0uP-qVu83kdxkZw@mail.gmail.com> <a9e19ad0-9a27-4885-a6ac-bebd3e997b02@redhat.com>
In-Reply-To: <a9e19ad0-9a27-4885-a6ac-bebd3e997b02@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 Dec 2023 17:03:25 +0100
Message-ID: <CAG48ez29cS9KKC_0g_eCxiUsSpg1CjJzt83sBViY0izzf4K5yQ@mail.gmail.com>
Subject: Re: [PATCH] locking: Document that mutex_unlock() is non-atomic
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 4:52=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
> On 12/1/23 10:01, Jann Horn wrote:
>> I think this pattern anyway only works when you're only trying to wait
>> for the current holder of the lock, not tasks that are queued up on
>> the lock as waiters - so a task initially holds a stable reference to
>> some object, then acquires the object's lock, then drops the original
>> reference, and then later drops the lock.
>> You can see an example of such mutex usage (which is explicitly legal
>> with userspace POSIX mutexes, but is forbidden with kernel mutexes) at
>> the bottom of the POSIX manpage for pthread_mutex_destroy() at
>> <https://pubs.opengroup.org/onlinepubs/007904875/functions/pthread_mutex=
_destroy.html>,
>> in the section "Destroying Mutexes".
>
> The POSIX mutex is reference-counted.

I don't understand what you mean by that.

Anyway, I guess this thread of discussion is moot - I'm not suggesting
that kernel mutexes should support this behavior.
