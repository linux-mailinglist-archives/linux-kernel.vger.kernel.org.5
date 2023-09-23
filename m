Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7727AC4FF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjIWUEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWUEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 16:04:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A5D127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 13:04:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50437c618b4so4220365e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695499456; x=1696104256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3KHNqLCORfOJTNtw7tvckoFOgfFqHshijJO4Eh7ejvc=;
        b=AYVjzuSvWnytDfiVZAl4vazQywBrvSujHCyfOV8bcRWoR66krJnfNOY313kPVQnbXW
         n4uw50E5WThkhAbFdCM0Sp0PspsvJxUjLNGg6PDoKujg2mpHMW+yeKkE3EC3k2ZpSYnn
         KPOjagPNwuI3RisHXTcy8Do2Df3bUfKvayX7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695499456; x=1696104256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3KHNqLCORfOJTNtw7tvckoFOgfFqHshijJO4Eh7ejvc=;
        b=AiSk6Z3jZmP6n8Y31BR3LKKE9Bkx0ejNTgA720HPV4bFWdBZA02jv9GEgXYcQ/NpWT
         aYkNZfs5bm1DmCrwBaRok/Y+bf71hHKYVQcwop9pTrQNhuQKbXIR5AyQEeDtm6nD1Ql6
         7RetCUEmDxBgq+qKWpyWCxU1eRfmd4X3DwNAE+4CzOipswOrX/K5rnLtuy1bsSEqZ/sJ
         89ZdrVoGkAVbmlWrdkdVs7l1VY+CPrxP+EWzei8RE58qtkfSmi/BwtI1LOgImRQJAIFy
         PVhOiBiidk2N8TGtoG8F9Nnv8nFovI0QQe5veyHgEeaUcpowxDOO2RiuxuH1OA1GMvDD
         2tpw==
X-Gm-Message-State: AOJu0YwemEtfaRYrivgKhg3wteWEgLOnKOzu0ua8PvRnSxKZ4By6EWho
        J/26MQfnlVjm/MeSB0INJzSpu/fzlTeJf981GdRWng==
X-Google-Smtp-Source: AGHT+IGitHkDriFQ+3RaiP+p7aAbn6ePvqb380owgovTo7TkVVSN+3vBlfk4gsEDQXKyrq9QunMCRA==
X-Received: by 2002:a05:6512:31d4:b0:500:b8a3:1bf1 with SMTP id j20-20020a05651231d400b00500b8a31bf1mr2458111lfe.43.1695499456263;
        Sat, 23 Sep 2023 13:04:16 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id x21-20020ac24895000000b004fe27a050fdsm1202879lfc.259.2023.09.23.13.04.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 13:04:14 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c02e232c48so67674601fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 13:04:13 -0700 (PDT)
X-Received: by 2002:a05:6512:2820:b0:500:8fcb:e0c9 with SMTP id
 cf32-20020a056512282000b005008fcbe0c9mr2783936lfb.69.1695499453477; Sat, 23
 Sep 2023 13:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com> <ZQ884uCkKGu6xsDi@mit.edu>
In-Reply-To: <ZQ884uCkKGu6xsDi@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 13:03:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
Message-ID: <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
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

On Sat, 23 Sept 2023 at 12:30, Theodore Ts'o <tytso@mit.edu> wrote:
>
> It depends on what conversion we need to do.  If we're converting to
> userspace's timespec64 data structure, which is denominated in
> nanosecods, it's actually much easier to use decimal 100ns units:

Actually, your data format seems to be a mix of "decimal nanoseconds"
and then a power-of-two seconds (ie bit shift).

Except it looks like ext4 actually does full nanosecond resolution (30
bits for nanoseconds, 34 bits for seconds). Thus the "only a couple of
hundred years of range".

And yes, that's probably close to optimal. It makes it harder to do
*math* on those dates (because you have seconds and 100ns as separate
fields), but for file timestamps that's likely not a real issue.

It was for 'ktime_t()', where with timers etc the whole "subtract and
add times" happens *all* the time, but for file timestamps you
basically have "set time" together with possibly comparing them (and
you can do comparisons without even splitting the fields if you lay
things out reasonably - which you ext4 doesn't seem to have done).

So yeah, I think that would be a fine 'fstime_t' for the kernel.

Except we'd do it without the EXT4_EPOCH_MASK conditionals, and I
think it would be better to have a bigger range for seconds. If you
give the seconds field three extra bits, you're comfortable in the
"thousands of years", and you still have 27 bits that can encode a
decimal "100ns".

It means that when you convert a fstime_t to timespec64 at stat()
time, you'd have to do a 32-bit "multiply by 100" to get the actual
nanosecond field, but that's cheap everywhere (and obviously the
shift-and-masks to get the separate fields out of the 64-bit value).

               Linus
