Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AFC801C16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjLBKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjLBKDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:03:35 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1BA19F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 02:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701511417; x=1701770617;
        bh=ozFyIxYG1eV92CI6lLkyQ7Lh/CozJJPAZNA/ZOBz2dA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Pdo79YX+qRTRMR0IGvXzfSAgr71hSODe1JFF+1EI+szHo3hmkUFa3mkSLU1Az3+97
         vA9aSUvN3TdpV0MfSvV300pt3EM+0B53g40Y45ERotqARuuKA2KGbhqK/r04UyVr8h
         l4HufFJ3FkCQDaPBQM15sYfMNxs18S9dNVjqWHUDRHdUJ23uYb4oVxJdy/TaaIcdKr
         0VHlnhu+9MyMFeicUtZVsUDKw7Wt542zMXgOls56eeYMzBigU191GWwcgsb6DOxB/i
         C0eGxmOEQ3o9tjg6Z3XrqMSVIKJdi96PjfpsxrgU9evidyCcvfdWKNfF6XxMufiv2P
         CHeLBsr5lhFxg==
Date:   Sat, 02 Dec 2023 10:03:11 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 3/7] rust: security: add abstraction for secctx
Message-ID: <TdIzHaMBCR_0nM5Vvj7NWAG4feqbl2J7FcUgdCvXgHejuysujgtwXze0TEHNBpOWw26N4zgJzMvbfoFICQgPcmWfK4PyWl08MYIpxWuvPxE=@proton.me>
In-Reply-To: <20231201104831.2195715-1-aliceryhl@google.com>
References: <qwxqEq_l1jj3cAKSEh7gBZCUyBGCDmThdz6JJIQiFVl94ASI4yyNB6956XLrsQXnE4ulo48QRMaKPjgt7JZoolisVEiGOUP7IyRdecdhXqw=@proton.me> <20231201104831.2195715-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 11:48, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 11/29/23 14:11, Alice Ryhl wrote:
>>> +    /// Returns the bytes for this security context.
>>> +    pub fn as_bytes(&self) -> &[u8] {
>>> +        let mut ptr =3D self.secdata;
>>> +        if ptr.is_null() {
>>> +            // Many C APIs will use null pointers for strings of lengt=
h zero, but
>>
>> I would just write that the secctx API uses null pointers to denote a
>> string of length zero.
>=20
> I don't actually know whether it can ever be null, I just wanted to stay
> on the safe side.

I see, can someone from the C side confirm/refute this?

I found the comment a bit weird, since it is phrased in a general way.
If it turns out that the pointer can never be null, maybe use `NonNull`
instead (I would then also move the length check into the constructor)?
You can probably also do this if the pointer is allowed to be null,
assuming that you then do not need to call `security_release_secctx`.

>>> +            // `slice::from_raw_parts` doesn't allow the pointer to be=
 null even if the length is
>>> +            // zero. Replace the pointer with a dangling but non-null =
pointer in this case.
>>> +            debug_assert_eq!(self.seclen, 0);
>>
>> I am feeling a bit uncomfortable with this, why can't we just return
>> an empty slice in this case?
>=20
> I can do that, but to be clear, what I'm doing here is also definitely
> okay.

Yes it is okay, but I see this similar to avoiding `unsafe` code when it
can be done safely. In this example we are not strictly avoiding any
`unsafe` code, but we are avoiding a codepath with `unsafe` code. You
should of course still keep the `debug_assert_eq`.

--=20
Cheers,
Benno
