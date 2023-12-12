Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061E80F3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjLLRFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjLLRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:05:23 -0500
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2894CB7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=xubov7wakjac3b3avdvdckasam.protonmail; t=1702400727; x=1702659927;
        bh=Yb396aKFrmXDBySgBnliEUcRESnxNJ3dzgc1iddiAhI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=XkbzSdxglIApKSopXr7ytzrpSmgREOq67HNN236/cXP6F3eGCx6so5jKpsit4NG9w
         o5TNdBpQT1ZK3hqY699HaBE505agu8o9DLNdZ93BWm1rZD6oRiFTtaXtMAhLX7laYB
         zecgtqmjw4tJj8WfM6aixl/xgXMyfZWuvPO+K7+qgnlOVApCRRLUfxwTqv+Tym6C/q
         Z90WxAM10CmCN4X/c6RIcZWpQ7CmjgzQLj7Soxawi+grihE6m0G7ti1f0xoKbdv7rw
         eNKeVqySR+iDTlWrkNOvVJlVhfsIhF013GZ4aHe++jCoN0ucD0yHs+zp0KtiRqXE71
         jwk+X7J3MJKQQ==
Date:   Tue, 12 Dec 2023 17:05:09 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
Message-ID: <5IXvyecf8pjdrhCW-71mwHOHFXRdLiCQCwgeVjljGhAJZEegyRxLC3hRr2NZGoNM0HCihiCjdcas1Ib_oWC7y5u8HBAQkN0-8IS5JlwikCU=@proton.me>
In-Reply-To: <CAH5fLghkyk7yuLvt+pPfQnB2j=-ehQLb4rf4b50sOgm33t-YkA@mail.gmail.com>
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com> <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com> <nAEg-6vbtX72ZY3oirDhrSEf06TBWmMiTt73EklMzEAzN4FD4mF3TPEyAOxBZgZtjzoiaBYtYr3s8sa9wp1uYH9vEWRf2M-Lf4I0BY9rAgk=@proton.me> <CAH5fLghkyk7yuLvt+pPfQnB2j=-ehQLb4rf4b50sOgm33t-YkA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 10:51, Alice Ryhl wrote:
> On Fri, Dec 8, 2023 at 8:04=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On 12/6/23 11:09, Alice Ryhl wrote:
>>> +    /// Atomically releases the given lock (whose ownership is proven =
by the guard) and puts the
>>> +    /// thread to sleep. It wakes up when notified by [`CondVar::notif=
y_one`] or
>>> +    /// [`CondVar::notify_all`], or when the thread receives a signal.
>>> +    ///
>>> +    /// Returns whether there is a signal pending.
>>> +    fn wait_internal_timeout<T, B>(
>>> +        &self,
>>> +        wait_state: u32,
>>> +        guard: &mut Guard<'_, T, B>,
>>> +        timeout: u64,
>>> +    ) -> u64
>>> +    where
>>> +        T: ?Sized,
>>> +        B: Backend,
>>> +    {
>>> +        let wait =3D Opaque::<bindings::wait_queue_entry>::uninit();
>>> +
>>> +        // SAFETY: `wait` points to valid memory.
>>> +        unsafe { bindings::init_wait(wait.get()) };
>>> +
>>> +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
>>> +        unsafe {
>>> +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), =
wait.get(), wait_state as _)
>>
>> Does `.into()` work here? If for some reason the type here changes, we
>> probably want to know about it.
>=20
> I think we may be able to eliminate this cast by using c_int for the
> integer type.

Sounds good.

>>> +        };
>>> +
>>> +        // SAFETY: Switches to another thread.
>>> +        let timeout =3D
>>> +            guard.do_unlocked(|| unsafe { bindings::schedule_timeout(t=
imeout as _) as _ });
>>
>> Ditto.
>=20
> Here, we're casting u64->long and then long->u64. How about this?
>=20
> u64->long - Use timeout.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT),
> since MAX_SCHEDULE_TIMEOUT is LONG_MAX.
>=20
> long->u64 - This value is guaranteed to be less than the argument
> passed to schedule_timeout. Use .into() for infallible cast.

Also sounds good :)

--=20
Cheers,
Benno
