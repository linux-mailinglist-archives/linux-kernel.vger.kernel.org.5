Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E59768929
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 00:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjG3WmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 18:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjG3WmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 18:42:11 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE3BAB;
        Sun, 30 Jul 2023 15:42:09 -0700 (PDT)
Date:   Sun, 30 Jul 2023 22:41:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1690756925; x=1691016125;
        bh=7noDWhw9qbH9bbmDZ+mnoEvlUKMZe2LiLK48dmHENgQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=RNr9dgZfi9jyPH/0Rrer91IoUFSMoz9Yf2Fj+jW55M4HxSuzalwr2Vt+xpBSbdGjP
         2rUSV8LoZ9T5siafIa7w8ou6oWg72zJgi4oKjV+ztzZwKA5YUc3R7r6bgYULsgAaqp
         bSz4PS3wYtR8JQt/69+7Jy/zPXT/l18fTFe6LzhaARWS8YBLqpeUxqhzJeDAwOrrzs
         rcrqTO6cWHOJ6K/FAo++rYvaPgC1HLOjk9Y5wGjIajNDlXPdombk7rZ9U6WNUhMrtt
         sAagJVB7Jnt34fR3tKC7SPSVvLlB1zUepcJpCqiSxDNS544MZwrn9I+ML6TIIuoC+P
         ke2hdW/c5iSKw==
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Andreas Hindborg <nmi@metaspace.dk>
Subject: Re: [PATCH 1/3] rust: allocator: Prevent mis-aligned allocation
Message-ID: <AWaNaTAJOJWWnEqJGgGsUTg8NiFGODsiRHl2OJRPb6XvWdXR8IuH7AjLgFn0OH1m_UZKHAcDFoElSPNXKQvgahydWGy3sE4lGEH2W9S-Kdg=@protonmail.com>
In-Reply-To: <CANiq72nf4N_HXOAZupM_Gq=c0jg-L__YUQtx4fSRpNuRqt4JAw@mail.gmail.com>
References: <20230730012905.643822-1-boqun.feng@gmail.com> <20230730012905.643822-2-boqun.feng@gmail.com> <CANiq72nf4N_HXOAZupM_Gq=c0jg-L__YUQtx4fSRpNuRqt4JAw@mail.gmail.com>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 30, 2023, 10:43 PM, Miguel Ojeda < miguel.ojeda.sandonis@gmail.com> =
wrote:
> On Sun, Jul 30, 2023 at 3:29=E2=80=AFAM Boqun > Feng <boqun.feng@gmail.co=
m> wrote:
> >
> > +// Note: Although these are *safe* functions, but they are only genera=
ted at
> > +// `GlobalAlloc` callsites, hence we assume the parameters obey the sa=
me
> > +// `GlobalAlloc` function safety requirements: size and align should f=
orm a
> > +// valid layout, and size is greater than 0.
>
> Thanks for adding all the `// SAFETY` comments here Boqun!
>
> Bj=C3=B6rn, do they look good to you? (since you fixed the issue in the c=
ompiler)

Based on a quick look, yes. The __rust_* methods that are normally generate=
d by the compiled directly jump to the respective global allocator method, =
so they have the same safety requirements.

>
> On this comment in particular, "generated at `GlobalAlloc` callsites"
sounds a bit confusing to me. Would "... called by the compiler with
parameters that obey ..." make sense? Or does the sentence refer to
the normal case (i.e. when the functions are generated)? Anyway, it is
not a big deal.
>
> Cheers,
> Miguel

Cheers,
Bj=C3=B6rn

(resent as I accidentally sent html instead of plain text)
