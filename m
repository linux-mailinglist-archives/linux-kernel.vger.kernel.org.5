Return-Path: <linux-kernel+bounces-128794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A1895FA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84356B22613
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6B8225AF;
	Tue,  2 Apr 2024 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Y6alFi2P"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39011EB2B;
	Tue,  2 Apr 2024 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097347; cv=none; b=NkYOVngHUJUh8hT20AOrE4kRHs52wael3+oTbvYI/Y39W1wPyqtDb+UO7VUBFhq//zj2LwJX91RCQW/00YxL/rif16THWYoip06tOc3dZb9yR/9wjAvNQGCuGQLn22wSNjv0dr07UtHOYVN/qCVORK8B8KFiYykQpwUcCGHTbBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097347; c=relaxed/simple;
	bh=jkjZO7jwr0PCImAu66df4aVlb2K6kWhUeVLD66IVeD8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwvNCN7cryhpU27XcOOCZT8TAi1GRxM90UhCx4sdExTfIFzaAzK04MgF6F/nMYlH7SNRdMiGQbB6iQq8d5unAS8dk0jeWXOsxpffjipT5TKzCtuot/Bo9awjFo1ws389adOv6UxKb9ym0wW+fC4nSWR+fsVR/wAZwObYOmNJXVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Y6alFi2P; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1712097336; x=1712356536;
	bh=ZR6oanZJrjCoyu/0f+lqsJmEQvmkfNvERkB55FpMbLg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y6alFi2PVO8tJG/+5EOowTtK6yQ+6aIb1zfjGhrRz4XFdszTaso4nG7qq2q1l6LY+
	 UjBcXlcQgC1v+9CJIw/VhW9joS+lqyz4GMBIHL+jlObSUxBQAQqya602hokAIoiUFP
	 b3kQoeWnN5BPVxHGvKa9kLXAs+T3zKIyP7HzmNWETIAH/pB1V+ulitRQKT7+3/s908
	 1Czkrja20NNZrbd02NDy4tBSDb1XkLEWJ4/0CKsw0hbl36F8YidFnW6vrLaLG0HK0N
	 S+03aHDnbdVnBf9lFuYk+FA4/L2msRvXoAopXACBRbWwZTCzalO59KEDknT+nycfxA
	 l2Dax32bzBzbA==
Date: Tue, 02 Apr 2024 22:35:32 +0000
To: Andreas Hindborg <nmi@metaspace.dk>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Damien Le Moal <Damien.LeMoal@wdc.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, Niklas Cassel <Niklas.Cassel@wdc.com>, Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, Joel Granados <j.granados@samsung.com>, "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez
	<da.gomez@samsung.com>, open list <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, "gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 4/5] rust: block: add rnull, Rust null_blk implementation
Message-ID: <1e8a2a1f-abbf-44ba-8344-705a9cbb1627@proton.me>
In-Reply-To: <87msqc3p0e.fsf@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk> <20240313110515.70088-5-nmi@metaspace.dk> <QqpNcEOxhslSB7-34znxmQK_prPJfe2GT0ejWLesj-Dlse1ueCacbzsJOM0LK3YmgQsUWAR58ZFPPh1MUCliionIXrvLNsOqTS_Ee3bXEuQ=@proton.me> <87msqc3p0e.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.04.24 14:52, Andreas Hindborg wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 3/13/24 12:05, Andreas Hindborg wrote:
>>> +module! {
>>> +    type: NullBlkModule,
>>> +    name: "rnull_mod",
>>> +    author: "Andreas Hindborg",
>>> +    license: "GPL v2",
>>> +    params: {
>>> +        param_memory_backed: bool {
>>> +            default: true,
>>> +            permissions: 0,
>>> +            description: "Use memory backing",
>>> +        },
>>> +        // Problems with pin_init when `irq_mode`
>>
>> Can you elaborate?
>=20
> I think we discussed this before, but I do not recall what you decided
> was the issue.

Ah I vaguely remember.

> It is probably easier if you can apply the patches and try to build with
> this on top:
>=20
> diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
> index 04bdb6668558..bd089c5e6e89 100644
> --- a/drivers/block/rnull.rs
> +++ b/drivers/block/rnull.rs
> @@ -48,7 +48,7 @@
>              description: "Use memory backing",
>          },
>          // Problems with pin_init when `irq_mode`
> -        param_irq_mode: u8 {
> +        irq_mode: u8 {
>              default: 0,
>              permissions: 0,
>              description: "IRQ Mode (0: None, 1: Soft, 2: Timer)",
> @@ -101,7 +101,7 @@ fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Re=
sult<GenDisk<NullBlkDevice>
>          return Err(kernel::error::code::EINVAL);
>      }
>=20
> -    let irq_mode =3D (*param_irq_mode.read()).try_into()?;
> +    let irq_mode =3D (*irq_mode.read()).try_into()?;
>=20
>      let queue_data =3D Box::pin_init(pin_init!(
>          QueueData {
>=20
> ---
>=20
> There is some kind of name clash issue when using `pin_init!` in the expr=
ession on
> line 106:
>=20
>     let queue_data =3D Box::pin_init(pin_init!(
>         QueueData {
>             tree <- TreeContainer::new(),
>             completion_time_nsec: *param_completion_time_nsec.read(),
>             irq_mode,
>             memory_backed: *param_memory_backed.read(),
>             block_size,
>         }
>     ))?;
>=20
> I cannot immediately decipher the error message:
>=20
>   RUSTC [M] drivers/block/rnull.o
> error[E0277]: the trait bound `__rnull_mod_irq_mode: From<u8>` is not sat=
isfied
>    --> /home/aeh/src/linux-rust/linux/drivers/block/rnull.rs:104:39
>     |
> 104 |     let irq_mode =3D (*irq_mode.read()).try_into()?;
>     |                                       ^^^^^^^^ the trait `From<u8>`=
 is not implemented for `__rnull_mod_irq_mode`
>     |
>     =3D note: required for `u8` to implement `Into<__rnull_mod_irq_mode>`
>     =3D note: required for `__rnull_mod_irq_mode` to implement `TryFrom<u=
8>`
>     =3D note: required for `u8` to implement `TryInto<__rnull_mod_irq_mod=
e>`
>=20
> error[E0308]: mismatched types
>     --> /home/aeh/src/linux-rust/linux/drivers/block/rnull.rs:106:36
>      |
> 106  |       let queue_data =3D Box::pin_init(pin_init!(
>      |  ____________________________________^
> 107  | |         QueueData {
> 108  | |             tree <- TreeContainer::new(),
> 109  | |             completion_time_nsec: *param_completion_time_nsec.re=
ad(),
> ...    |
> 113  | |         }
> 114  | |     ))?;
>      | |     ^
>      | |     |
>      | |_____expected `IRQMode`, found `__rnull_mod_irq_mode`
>      |       arguments to this function are incorrect
>      |
> note: function defined here
>     --> /home/aeh/.rustup/toolchains/1.74.1-x86_64-unknown-linux-gnu/lib/=
rustlib/src/rust/library/core/src/ptr/mod.rs:1365:21
>      |
> 1365 | pub const unsafe fn write<T>(dst: *mut T, src: T) {
>      |                     ^^^^^
>      =3D note: this error originates in the macro `$crate::__init_interna=
l` which comes from the expansion of the macro `pin_init` (in Nightly build=
s, run with -Z macro-backtrace for more info)
>=20
> error[E0308]: mismatched types
>    --> /home/aeh/src/linux-rust/linux/drivers/block/rnull.rs:106:36
>     |
> 39  | / module! {
> 40  | |     type: NullBlkModule,
> 41  | |     name: "rnull_mod",
> 42  | |     author: "Andreas Hindborg",
> ...   |
> 71  | |     },
> 72  | | }
>     | |_- constant defined here
> ...
> 106 |       let queue_data =3D Box::pin_init(pin_init!(
>     |  ____________________________________^
>     | |____________________________________|
>     | |____________________________________|
>     | |____________________________________|
>     | |
> 107 | |         QueueData {
> 108 | |             tree <- TreeContainer::new(),
> 109 | |             completion_time_nsec: *param_completion_time_nsec.rea=
d(),
> ...   |
> 113 | |         }
> 114 | |     ))?;
>     | |     ^
>     | |_____|
>     | |_____expected `DropGuard<IRQMode>`, found `__rnull_mod_irq_mode`
>     | |_____this expression has type `DropGuard<IRQMode>`
>     | |_____`irq_mode` is interpreted as a constant, not a new binding
>     |       help: introduce a new binding instead: `other_irq_mode`
>     |
>     =3D note: expected struct `DropGuard<IRQMode>`
>                found struct `__rnull_mod_irq_mode`
>     =3D note: this error originates in the macro `$crate::__init_internal=
` which comes from the expansion of the macro `pin_init` (in Nightly builds=
, run with -Z macro-backtrace for more info)
>=20
> error: aborting due to 3 previous errors
>=20
> Some errors have detailed explanations: E0277, E0308.
> For more information about an error, try `rustc --explain E0277`.
> make[5]: *** [/home/aeh/src/linux-rust/linux/scripts/Makefile.build:293: =
drivers/block/rnull.o] Error 1


So I did some digging and there are multiple things at play. I am going
to explain the second error first, since that one might be a problem
with `pin_init`:
- the `params` extension of the `module!` macro creates constants with
   snake case names.
- your `QueueData` struct has the same name as a field.
- `pin_init!` generates `let $field_name =3D ...` statements for each
   field you initialize

Now when you define a constant in Rust, you are able to pattern-match
with that constant, eg:

     const FOO: u8 =3D 0;
    =20
     fn main() {
         match 10 {
             FOO =3D> println!("foo"),
             _ =3D> {}
         }
     }

So when you do `let FOO =3D x;`, then it interprets `FOO` as the constant.
This is still true if the constant has a snake case name.
Since the expression in the `pin_init!` macro has type
`DropGuard<$field_type>`, we get the error "expected
`DropGuard<IRQMode>`, found `__rnull_mod_irq_mode`".

Now to the first error, this is a problem with the parameter handling of
`module`. By the same argument above, your let binding in line 104:

     let irq_mode =3D (*irq_mode.read()).try_into()?;

Tries to pattern-match the `irq_mode` constant with the right
expression. Since you use the `try_into` function, it tries to search
for a `TryInto` implementation for the type of `irq_mode` which is
generated by the `module!` macro. The type is named
__rnull_mod_irq_mode.


Now what to do about this. For the second error (the one related to
`pin_init`), I could create a patch that fixes it by adding the suffix
`_guard` to those let bindings, preventing the issue. Not sure if we
need that though, since it will not get rid of the first issue.

For the first issue, I think there is no other way than to use a
different name for either the field or the constant. Since constants are
usually named using screaming snake case, I think it should be renamed.
I believe your reason for using a snake case name is that these names
are used directly as the names for the parameters when loading the
module and there the convention is to use snake case, right?
In that case I think we could expect people to write the screaming snake
case name in rust and have it automatically be lower-cased by the
`module!` macro when it creates the names that the parameters are shown
with.

Hope this helps!

--=20
Cheers,
Benno


