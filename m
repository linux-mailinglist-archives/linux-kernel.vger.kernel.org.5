Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBB4800E43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379373AbjLAPOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379382AbjLAPOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:38 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46310DF;
        Fri,  1 Dec 2023 07:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701443676; x=1701702876;
        bh=CQrld9s0aEvaSp170xsyS5XrYFnhPFO9afBIK1y6HCo=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ESSodeRcWhQ69FRDO31zQsuhJ18eu49av4FlLHOs6Wa4p2y2FvTJ0fL+SrhTH5QwW
         SHY6UJVaydogC1YiZC3ANwAhEyGOqxkxfzJ3XAtJsJh+IOEd+jyBSxLlvuONp0hDbn
         wc0zCNMN/B8pqE2czBXysJfnN7r50wpMsCRDdc2KeEOJV/GQAWkmlQRSJ4nOF9fPm6
         JhlVlPhvJTBlwRT/Wnm8boUfKDWb7aWRPy5MySD9VIIWj/XkBNEbvg7i0eBvmGw8U1
         vRxATOK5aS5mylcY6bfXhHaT+ff25u7IS7IH15VDN5DlEvCsTczrREsEAoakySopEE
         heOFaUqUgKhhQ==
Date:   Fri, 01 Dec 2023 15:14:23 +0000
To:     Theodore Ts'o <tytso@mit.edu>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, david.laight@aculab.com,
        a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <zWaYgly6VpMZcvVUAILQWBSs9VnO7nFiAiCo4eTzT4SJEfqXY8G8w7f6az7kz9wEB4pA8EbajkQZRX4CuifI00Ce3EA_4muXjz_kfdAuzOU=@proton.me>
In-Reply-To: <20231201150442.GC509422@mit.edu>
References: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com> <20231201122740.2214259-1-aliceryhl@google.com> <20231201150442.GC509422@mit.edu>
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

On 12/1/23 16:04, Theodore Ts'o wrote:
> On Fri, Dec 01, 2023 at 12:27:40PM +0000, Alice Ryhl wrote:
>>
>> You can import it with a use statement. For example:
>>
>> use kernel::file::flags::O_RDONLY;
>> // use as O_RDONLY
>=20
> That's good to hear, but it still means that we have to use the XYZ_*
> prefix, because otherwise, after something like
>=20
> use kernel::file::flags::RDONLY;
> use kernel::uapi::rwf::RDONLY;
>=20
> that will blow up.  So that has to be
>=20
> use kernel::file::flags::O_RDONLY;
> use kernel::uapi::rwf::RWF_RDONLY;

You can just import the `flags` and `rwf` modules (the fourth option
posted by Alice):

    use kernel::file::flags;
    use kernel::uapi::rwf;
   =20
    // usage:
   =20
    flags::O_RDONLY
   =20
    rwf::RDONLY

Alternatively if we end up with multiple flags modules you can do this
(the sixth option from Alice):

    use kernel::file::flags as file_flags;
    use kernel::foo::flags as foo_flags;

    // usage:

    file_flags::O_RDONLY

    foo_flags::O_RDONLY

--=20
Cheers,
Benno
