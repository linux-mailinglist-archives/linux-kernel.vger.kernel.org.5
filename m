Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1537ADC9A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjIYQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbjIYQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:03:14 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A17910E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:03:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so114219951fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695657784; x=1696262584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A3CURX8d3cYG1fQrKnA7galRUzLSX0ZMwE51Q1+NG/M=;
        b=ZTrDrz/AS+nSfWzz7rdVzupkBeLXtr5p9xwvSs6+QnY0E/LYcfTrUPcfYek0gVPZ8W
         dJ7+8EPXJmEqKaDsZIwXbCFR0/xUY0RFv9nPcvOKWjxdlXjI/y4Hoe7HmXl7ouppoKcg
         xdCHVDZuPyt92BMQu/FylPeRF5Jga7AZb/22s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657784; x=1696262584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3CURX8d3cYG1fQrKnA7galRUzLSX0ZMwE51Q1+NG/M=;
        b=Z3EAUKP3bfJMJ74/izw6/Skf2/LkP90nECkLELQOJCRXroqJemtrDb1PG4/7KzbHP2
         +olOQ0oSBvGCfgiRJWF9gKap4Uh657FB5OXRIFuXNVqa0qk4Tk33SmcHjBv0VSlTvLGE
         bWD6aXDuOtWeUALKfl9rxmkEeN5n7K1DmTcne1SruTtgq+7U0ENfHzs2s6BEWj2dpMrA
         lh2oHifD9EXwCfIx18mXR1EzuYykyG5liFINBXBBk4dZcGQONLJri6S75AoeERfNc/cD
         0XBnIRG3CNZtan4gI0ieotZ2WU130XrYc0dhs2EXT1M4SiXuhf8jwPOWT/MnPFN0GUzV
         RTFQ==
X-Gm-Message-State: AOJu0Yxx9gdCNdLXnfRuc4ZU4oPA0u16rT6SmI5X0bf5hJlW7waSCiGp
        WCBTiIHLK/Euu06EQGAtbFOqH4wPHer6AsnF+BAWAA==
X-Google-Smtp-Source: AGHT+IH5+ZYRn1YCS+s/fr2I3qLdqGrBP11n2Qzb5GJeUcrUzzehxFbro6nEmA0qp9/FhXwj3+cdDw==
X-Received: by 2002:a2e:720a:0:b0:2b6:bb21:8d74 with SMTP id n10-20020a2e720a000000b002b6bb218d74mr5829056ljc.1.1695657784389;
        Mon, 25 Sep 2023 09:03:04 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id p20-20020a2ea414000000b002bffa125afesm2259327ljn.48.2023.09.25.09.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 09:02:58 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so114213151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:02:56 -0700 (PDT)
X-Received: by 2002:a2e:800c:0:b0:2bc:dd96:147d with SMTP id
 j12-20020a2e800c000000b002bcdd96147dmr6582130ljg.28.1695657774017; Mon, 25
 Sep 2023 09:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com> <9ee3b65480b227102c04272d2219f366c65a14f3.camel@kernel.org>
In-Reply-To: <9ee3b65480b227102c04272d2219f366c65a14f3.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Sep 2023 09:02:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1YhGmwcWn4TfTC1fMaDjhbLJMge123rj2YEjZNy5KFQ@mail.gmail.com>
Message-ID: <CAHk-=wg1YhGmwcWn4TfTC1fMaDjhbLJMge123rj2YEjZNy5KFQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sept 2023 at 04:23, Jeff Layton <jlayton@kernel.org> wrote:
>
> The catch here is that we have at least some testcases that do things
> like set specific values in the mtime and atime, and then test that the
> same value is retrievable.

Yeah, I'm sure that happens. But as you say, we already have
per-filesystem granularity issues that means that there is some non-ns
granularity that those tests have to deal with.

Unless they currently just work on one or two filesystems, of course.

> Of course, that set truncates the values at jiffies granularity (~4ms on
> my box). That's well above 100ns, so it's possible that's too coarse for
> us to handwave this problem away.

Note that depending or enforcing some kind of jiffies granularity is
*particularly* bad, because it's basically a random value.

It will depend on architecture and on configuration. On some
architectures it's a fixed value (some have it at 100, which is, I
think, the original x86 case), on others it's "configurable", but not
really (ie alpha is "configurable" in our Kconfig, but the _hardware_
typically has a fixed clock tick at 1024 Hz, but then there are
platforms that are different, and then there's Qemu that likes a lower
frequency to avoid overhead etc etc).

And then we have the "modern default", which is to ask the user at
config time if they want a 100 / 250 / 300 / 1000 HZ value, and the
actual hw clock tick may be much more dynamic than that.

Anyway, what I'm saying is just that we should *not* limit granularity
to anything that has to do with jiffies. Yes, that's still a real
thing in that it's a "cheap read of the current time", but it should
never be seen as any kind of vfs granularity.

And yes, HZ will be in the "roughly 100-1000" range, so if we're
talking granularities that are microseconds or finer, then at most
you'll have rounding issues - and since any HZ rounding issues should
only be for the cases where we set the time to "now" - rounding
shouldn't be an issue anyway, since it's not a time that is specified
by user space.

End result: try to avoid anything to do with HZ in filesystem code,
unless it's literally about jiffies (which should typically be mostly
about any timeouts a filesystem may have, not about timestamps
themselves).

               Linus
