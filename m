Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB85812499
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbjLNBbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNBbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:31:53 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09ABBE0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:32:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a1db99cd1b2so968745566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702517518; x=1703122318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bu41HfL0rPJ5dM5yXqa7CgHUFFdONYm5ZwaUE4WWVI=;
        b=K93ycnPBXuf0EIOZYvDQoqOY3sdlq7A1KZXqTHxnGl7NJV5Dh9XjfLsSXsli/2wweN
         +4/vCSQFukR2zFCXcM2oP98hkZ+XxWp/CDV9/9tc1zjhauCxGsUy6UzmUOLGBAd7//R5
         zYK4J8p4/oOCchhtOD5F65gu+a/gxWp1pa6b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517518; x=1703122318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Bu41HfL0rPJ5dM5yXqa7CgHUFFdONYm5ZwaUE4WWVI=;
        b=kPzCRqYRgLPlNfQyUX2leYJWrZBISSr4Hj3n6BzY8a0yvBYoNje+okipUrgnpwO8rL
         3V63wAJDrQ+uE1VXf3YpmE16miKE85mgr/Is9h4++aoojdVJll414Hr238bBz8qWFU8J
         UTOjAIlkt6bCDAwHMfBR3d0yG9iL1olpMWwd+QCSFKj75o1rS9T41WIWpG5X9sb4Xlan
         q5shyLFWZzhf8K/xwyCEpoRXfoVkw9bMX9M1afRPzf2aPsTJAVbiOmDLlIPWXD4Pl/Tv
         2z/8UA/57GWpvM0WN66o0ulPdXEQsNYJVMicZG7MVpX5J9owJc+9Q1KoVFwrC+cHK3xO
         RPDQ==
X-Gm-Message-State: AOJu0YwUq5QzY+1LnxLCLgMAKHCyCi5PAW0nRLY0+ODAGSaY4pimUIHD
        c0l6GkqaWZCEZyFpSZVkYaK+Vp8fiYcdu8FhtEXsV5qp
X-Google-Smtp-Source: AGHT+IEGgaNPXtNstpZ0mtA0Y871OGhuUZ2+WQsKhloqOzfAJNXmwlJ0LggpqFfxyoVc30/MIssHCA==
X-Received: by 2002:a17:906:6a13:b0:9be:834a:f80b with SMTP id qw19-20020a1709066a1300b009be834af80bmr3674302ejc.75.1702517518410;
        Wed, 13 Dec 2023 17:31:58 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b00a1c6e3e454fsm8537723ejc.166.2023.12.13.17.31.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:31:57 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so10327383a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:31:57 -0800 (PST)
X-Received: by 2002:a50:d592:0:b0:54c:4837:7d1e with SMTP id
 v18-20020a50d592000000b0054c48377d1emr3150337edi.93.1702517516946; Wed, 13
 Dec 2023 17:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
In-Reply-To: <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Dec 2023 17:31:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
Message-ID: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
        linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 at 16:36, Jeff Xu <jeffxu@google.com> wrote:
>
>
> > IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?
> >
> The MADV_DONTNEED is OK for file-backed mapping.

Right. It makes no semantic difference. So there's no point to it.

My point was that you added this magic flag for "not ok for RO anon mapping".

It's such a *completely* random flag, that I go "that's just crazy
random - make sealing _always_ disallow that case".

So what I object to in this series is basically random small details
that should just eb part of the basic act of sealing.

I think sealing should just mean "you can't do any operations that
have semantic meaning for the mapping, because it is SEALED".

So I think sealing should automatically mean "can't do MADV_DONTNEED
on anon memory", because that's basically equivalent to a munmap/remap
operation.

I also think that sealing should just automatically mean "can't do
mprotect any more".

And yes, the OpenBSD semantics of "immutable" apparently allowed
reducing permissions, but even the openbsd man-page seems to think
that was a bug, so we should just not allow it. And the openbsd case
seems to be because of how they made certain things immutable by
default, which is different from what this mseal() thing is.

End result: I'd really like to make the thing conceptually simpler,
rather than add all those random (*very* random in case of
MADV_DONTNEED) special cases.

Is there any actual practical example of why you'd want a half-sealed thing?

And no, I didn't read the pdf that was attached. If it can't just be
explained in plain language, it's not an explanation.

I'd love for "sealed" to be just a single bit in the vm_flags things
that we already have. Not a config option. Not some complicated thing
that is hard to explain. A simple "I have set up this mapping, you
can't change it any more".

And if it cannot be that kind of thing, I want to have clear and
obvious examples of why it can't be that simple thing.

Not a pdf file that describes some google-chrome design. Something
down-to-earth and practical (and not a "we might want this in the
future" thing either).

IOW, what is wrong with "THIS VMA SETUP CANNOT BE CHANGED ANY MORE"?

Nothing less, but also nothing more. No random odd bits that need explaining.

              Linus
