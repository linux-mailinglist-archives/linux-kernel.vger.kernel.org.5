Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78275753F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbjGNPtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbjGNPtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:49:41 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D4430FC;
        Fri, 14 Jul 2023 08:49:39 -0700 (PDT)
Date:   Fri, 14 Jul 2023 15:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=v4jpm7se3nfztbr4wviilsd24a.protonmail; t=1689349777; x=1689608977;
        bh=Is3/pY3myqWUzbl0nHi5owhMs2jWa90lwvb1AfrYAU8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=W76/HIV0PAhXEKzFp6ClWSLjYTO3vVbpwZnjeXTa35Nh/q5oHnzek7Bpw99YiCh3v
         HpLC1pAm4smhXPtCxbdBWIGH8c9wtTtHVmIC5+ACp6bTd7N9lT6F5VpFM58Ho2LyAP
         2rZQCMk1jRD+5TAapOmoCl1o1lidkZkDchrLYMnNb/wqVxIl+QNIxtmgP0Bo0fRuPv
         lPzH7GucTRVYJwPT5GFsZEn4qDFlk9i+EQTSfQ6MQ44DJozs2oICNb7p7DZ9go4xj/
         sZQGqP+S8RN4ZwfGkhvLbBTeWEyTlLx3v69MwFDnmDphnqLDjBWNJyoW7l6RDy4SZf
         N+1BFeuwCZxzA==
To:     Qingsong Chen <changxian.cqs@antgroup.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 2/8] rust: kernel: add `request` related TargetOperations
Message-ID: <-IRG_a-qIx3Io5P-2p2t7mTbhsaV-Jizcvu0frlx6Pfj5mrnYL92vL5ZGfhY5lXdfAP-g3B02SpBAKWgPwpfxVpWBjMMWmTnhF9DLdU9808=@proton.me>
In-Reply-To: <20230625121657.3631109-3-changxian.cqs@antgroup.com>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com> <20230625121657.3631109-3-changxian.cqs@antgroup.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> - Add `request` related and end_io TargetOperations.
> - Add a dummy `request` wrapper and `blk_status_t`.
>=20
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
>  rust/kernel/device_mapper.rs | 199 +++++++++++++++++++++++++++++++++++
>  1 file changed, 199 insertions(+)
>=20
> diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
> index 28286b373b59..153bae3aad79 100644
> --- a/rust/kernel/device_mapper.rs
> +++ b/rust/kernel/device_mapper.rs
> @@ -31,6 +31,39 @@ pub trait TargetOperations: Sized {
>      /// Map block IOs. Return [`MapState`] to indicate how to handle the=
 `bio`
>      /// later (end or resubmit).
>      fn map(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> MapState;
> +
> +    /// Map `request`. Return [`MapState`] and the optional cloned `requ=
est`.
> +    #[allow(unused)]
> +    fn clone_and_map_rq<'a>(
> +        t: &mut Target<Self>,
> +        rq: Pin<&mut Request>,
> +        map_ctx: &mut MapInfo,
> +    ) -> (MapState, Option<Pin<&'a mut Request>>) {
> +        unimplemented!()

Note that these should be implemented when you submit this as an actual
patch. (Not sure what you would do in this case, but throwing a panic is
not a good idea.) This also applies to all subsequent patches.
I think you might have done this, because you want the C side to choose
the default implementation. But it should also be possible to call these
from the Rust side.

--
Cheers,
Benno

> +    }
> +
> +    /// Release the cloned `request`.
> +    #[allow(unused)]
> +    fn release_clone_rq(rq: Pin<&mut Request>, map_ctx: &mut MapInfo) {
> +        unimplemented!()
> +    }
> +
> +    /// End the `bio`. Return [`EndState`] and [`BlkStatus`].
> +    #[allow(unused)]
> +    fn end_io(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> (EndState, Bl=
kStatus) {
> +        unimplemented!()
> +    }
> +
> +    /// End the `request`. Return [`EndState`].
> +    #[allow(unused)]
> +    fn rq_end_io(
> +        t: &mut Target<Self>,
> +        rq: Pin<&mut Request>,
> +        map_ctx: &mut MapInfo,
> +        err: BlkStatus,
> +    ) -> EndState {
> +        unimplemented!()
> +    }
>  }
>=20
>  /// Wrap the kernel struct `target_type`.
> @@ -85,6 +118,18 @@ pub fn register<T: TargetOperations>(
>                      (HAS_CTR, ctr, dm_ctr_fn),
>                      (HAS_DTR, dtr, dm_dtr_fn),
>                      (HAS_MAP, map, dm_map_fn),
> +                    (
> +                        HAS_CLONE_AND_MAP_RQ,
> +                        clone_and_map_rq,
> +                        dm_clone_and_map_request_fn
> +                    ),
> +                    (
> +                        HAS_RELEASE_CLONE_RQ,
> +                        release_clone_rq,
> +                        dm_release_clone_request_fn
> +                    ),
> +                    (HAS_END_IO, end_io, dm_endio_fn),
> +                    (HAS_RQ_END_IO, rq_end_io, dm_request_endio_fn),
>                  );
>=20
>                  to_result(bindings::dm_register_target(tt))
> @@ -148,6 +193,64 @@ impl TargetType {
>              T::map(t, bio) as _
>          }
>      }
> +    unsafe extern "C" fn dm_clone_and_map_request_fn<T: TargetOperations=
>(
> +        ti: *mut bindings::dm_target,
> +        rq: *mut bindings::request,
> +        map_context: *mut bindings::map_info,
> +        clone: *mut *mut bindings::request,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: the kernel should pass valid `dm_target`, `request`
> +        // and `map_info` pointers.
> +        unsafe {
> +            let t =3D Target::borrow_mut(ti);
> +            let rq =3D Request::from_raw(rq);
> +            let map_ctx =3D MapInfo::borrow_mut(map_context);
> +            let (map_state, rq_cloned) =3D T::clone_and_map_rq(t, rq, ma=
p_ctx);
> +            *clone =3D rq_cloned.map_or(core::ptr::null_mut(), |rq| rq.o=
paque.get());
> +            map_state as _
> +        }
> +    }
> +    unsafe extern "C" fn dm_release_clone_request_fn<T: TargetOperations=
>(
> +        clone: *mut bindings::request,
> +        map_context: *mut bindings::map_info,
> +    ) {
> +        // SAFETY: the kernel should pass valid `request` and `map_info`=
 pointers.
> +        unsafe {
> +            let rq =3D Request::from_raw(clone);
> +            let map_ctx =3D MapInfo::borrow_mut(map_context);
> +            T::release_clone_rq(rq, map_ctx);
> +        }
> +    }
> +    unsafe extern "C" fn dm_endio_fn<T: TargetOperations>(
> +        ti: *mut bindings::dm_target,
> +        bio: *mut bindings::bio,
> +        error: *mut bindings::blk_status_t,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: the kernel should pass valid `dm_target`, `bio` and
> +        // `error` pointers.
> +        unsafe {
> +            let t =3D Target::borrow_mut(ti);
> +            let bio =3D Bio::from_raw(bio);
> +            let (end_state, blk_status) =3D T::end_io(t, bio);
> +            *error =3D blk_status as _;
> +            end_state as _
> +        }
> +    }
> +    unsafe extern "C" fn dm_request_endio_fn<T: TargetOperations>(
> +        ti: *mut bindings::dm_target,
> +        clone: *mut bindings::request,
> +        error: bindings::blk_status_t,
> +        map_context: *mut bindings::map_info,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: the kernel should pass valid `dm_target`, `request`
> +        // and `map_info` pointers.
> +        unsafe {
> +            let t =3D Target::borrow_mut(ti);
> +            let rq =3D Request::from_raw(clone);
> +            let map_ctx =3D MapInfo::borrow_mut(map_context);
> +            T::rq_end_io(t, rq, map_ctx, (error as u32).into()) as _
> +        }
> +    }
>  }
>=20
>  /// Wrap the kernel struct `dm_target`.
> @@ -305,6 +408,33 @@ pub enum MapState {
>      Kill =3D bindings::DM_MAPIO_KILL,
>  }
>=20
> +/// The return values of target end_io function.
> +#[repr(u32)]
> +pub enum EndState {
> +    /// Ended successfully.
> +    Done =3D bindings::DM_ENDIO_DONE,
> +
> +    /// The io has still not completed (eg, multipath target might
> +    /// want to requeue a failed io).
> +    Incomplete =3D bindings::DM_ENDIO_INCOMPLETE,
> +
> +    /// The target wants to requeue the io.
> +    Requeue =3D bindings::DM_ENDIO_REQUEUE,
> +
> +    /// The target wants to requeue the io after a delay.
> +    DelayRequeue =3D bindings::DM_ENDIO_DELAY_REQUEUE,
> +}
> +
> +/// Wrap the c struct `map_info`.
> +pub struct MapInfo(Opaque<bindings::map_info>);
> +
> +impl MapInfo {
> +    unsafe fn borrow_mut<'a>(ptr: *mut bindings::map_info) -> &'a mut Se=
lf {
> +        // SAFETY: the caller should pass a valid `ptr`.
> +        unsafe { &mut *(ptr as *mut Self) }
> +    }
> +}
> +
>  /// Wrap the `c_char` arguments, which yields `CStr`.
>  pub struct Args {
>      argc: core::ffi::c_uint,
> @@ -380,3 +510,72 @@ pub fn is_write(&self) -> bool {
>          self.op_and_flags() & bindings::req_op_REQ_OP_WRITE !=3D 0
>      }
>  }
> +
> +/// Wrap the kernel struct `request`.
> +///
> +/// Dummy.
> +#[pin_data]
> +pub struct Request {
> +    #[pin]
> +    opaque: Opaque<bindings::request>,
> +}
> +
> +impl Request {
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::request) -> Pin<&'a mut S=
elf> {
> +        // SAFETY: the caller should pass a valid `request` pointer.
> +        unsafe { Pin::new_unchecked(&mut *(ptr as *mut Self)) }
> +    }
> +}
> +
> +/// Wrap the block error status values (see [blk_status_t]).
> +///
> +/// [`blk_status_t`]: ../../../../include/linux/blk_types.h
> +#[repr(u32)]
> +#[allow(missing_docs)]
> +pub enum BlkStatus {
> +    Ok,
> +    NotSupp,
> +    TimeOut,
> +    NoSpc,
> +    Transport,
> +    Target,
> +    Nexus,
> +    Medium,
> +    Protection,
> +    Resource,
> +    IoErr,
> +    DmRequeue,
> +    Again,
> +    DevResource,
> +    ZoneResource,
> +    ZoneOpenResource,
> +    ZoneActiveResource,
> +    Offline,
> +    Undefined,
> +}
> +
> +impl From<u32> for BlkStatus {
> +    fn from(value: u32) -> Self {
> +        match value {
> +            0 =3D> Self::Ok,
> +            1 =3D> Self::NotSupp,
> +            2 =3D> Self::TimeOut,
> +            3 =3D> Self::NoSpc,
> +            4 =3D> Self::Transport,
> +            5 =3D> Self::Target,
> +            6 =3D> Self::Nexus,
> +            7 =3D> Self::Medium,
> +            8 =3D> Self::Protection,
> +            9 =3D> Self::Resource,
> +            10 =3D> Self::IoErr,
> +            11 =3D> Self::DmRequeue,
> +            12 =3D> Self::Again,
> +            13 =3D> Self::DevResource,
> +            14 =3D> Self::ZoneResource,
> +            15 =3D> Self::ZoneOpenResource,
> +            16 =3D> Self::ZoneActiveResource,
> +            17 =3D> Self::Offline,
> +            _ =3D> Self::Undefined,
> +        }
> +    }
> +}
> --
> 2.40.1
>=20

