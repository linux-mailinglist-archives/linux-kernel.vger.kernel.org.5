Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91848753F48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjGNPsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjGNPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:48:49 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B035A4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:48:45 -0700 (PDT)
Date:   Fri, 14 Jul 2023 15:48:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689349722; x=1689608922;
        bh=0lqNdDH6LPN+JYqLoAFZXEutF5tk2wh85PFo7XkYyi8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bnNpbEtQCOcvZ6skp4Y5IYEiKJaTG2eV0DMFNQ1mwGtpz7ya+wHQcuvZKRgX6fJbS
         lCGQef8K30+DW7bPWEUx0p2fUfM2qNqzjJvAJF7nU9hcp95smEI5vwOl8dEMti4A1y
         zvOU9TwEVa++40DrEbAscouZjpjWHJKkMYKHOfuxHEZ8LmgwEbwfbvVn0DcPOpbCkT
         wILRfWtdA9yhiaDCPPSV7D9BLtHM0oEVMYvn/mdwLHNmRG1YYSxlnqi/z86OXYl/B0
         lq65FaXTDrZcB3MobFgnMa21NWwuYAf8b0tX1wVwrfBLbMyWoak/dgalUytvXZlyts
         V47aXqlhXKwMg==
To:     Qingsong Chen <changxian.cqs@antgroup.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] rust: kernel: add basic abstractions for device-mapper
Message-ID: <WCPFASroITvSjkBsoj04wbZMd7zWj-DiUVMJWWSLM3Lfx8oDWVtV4-EvQ_O9LeLwVzHG1rr_RrkYB2_oFc2suCcZpzJSztNfyha-If6d8z4=@proton.me>
In-Reply-To: <20230625121657.3631109-2-changxian.cqs@antgroup.com>
References: <20230625121657.3631109-1-changxian.cqs@antgroup.com> <20230625121657.3631109-2-changxian.cqs@antgroup.com>
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

> - Declare `vtable` for basic target operations.
> - Wrap `target_type` to register/unregister target.
> - Wrap `dm_target`/`dm_dev` to handle io request.
> - Add a dummy `bio` wrapper.
>=20
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

On my system this patch series (I did not test which patch exactly) does
not compile.

I have left some comments below, they show some patterns present in
the other patches as well.

> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/device_mapper.rs    | 382 ++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs              |   1 +
>  3 files changed, 384 insertions(+)
>  create mode 100644 rust/kernel/device_mapper.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 3e601ce2548d..807fc9cf41b8 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/device-mapper.h>
>=20
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
> diff --git a/rust/kernel/device_mapper.rs b/rust/kernel/device_mapper.rs
> new file mode 100644
> index 000000000000..28286b373b59
> --- /dev/null
> +++ b/rust/kernel/device_mapper.rs
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Device Mapper.
> +//!
> +//! C header: [`include/linux/device-mapper.h`](../../../../include/linu=
x/device-mapper.h)
> +
> +use core::marker::PhantomData;
> +use core::ops::Index;
> +use core::ptr::{addr_of, NonNull};
> +
> +use crate::error::to_result;
> +use crate::prelude::*;
> +use crate::str::CStr;
> +use crate::types::Opaque;
> +
> +/// Declare operations that a device mapper target can do.
> +#[vtable]
> +pub trait TargetOperations: Sized {
> +    /// Persist user data.
> +    type Private: Sync;
> +
> +    /// Constructor. The target will already have the table, type, begin=
 and
> +    /// len fields filled in. A `Private` struct can be returned to pers=
ist
> +    /// its own context.
> +    fn ctr(t: &mut Target<Self>, args: Args) -> Result<Box<Self::Private=
>>;
> +
> +    /// Destructor. The target could clean up anything hidden in `Privat=
e`,
> +    /// and `Private` itself can be dropped automatically.
> +    fn dtr(t: &mut Target<Self>);
> +
> +    /// Map block IOs. Return [`MapState`] to indicate how to handle the=
 `bio`
> +    /// later (end or resubmit).
> +    fn map(t: &mut Target<Self>, bio: Pin<&mut Bio>) -> MapState;
> +}
> +
> +/// Wrap the kernel struct `target_type`.
> +///
> +/// It contains a struct `list_head` for internal device-mapper use, so =
it
> +/// should be pinned. Users can use this struct to register/unregister t=
heir
> +/// own device mapper target.
> +#[pin_data(PinnedDrop)]
> +pub struct TargetType {
> +    #[pin]
> +    opaque: Opaque<bindings::target_type>,
> +}
> +
> +/// Define target feature type.
> +pub type Feature =3D u64;
> +
> +// SAFETY: It's OK to access `TargetType` from multiple threads. The
> +// `dm_register_target` and `dm_unregister_target` provides its own
> +// synchronization.
> +unsafe impl Sync for TargetType {}
> +
> +macro_rules! check_target_operations {
> +    ($tt:expr, $(($op:ident, $filed:ident, $func:ident),)+) =3D> {$(
> +        if <T as TargetOperations>::$op {
> +            (*$tt).$filed =3D Some(TargetType::$func::<T>);
> +        }
> +    )+};
> +}

This macro should be called `set_target_operations`.

> +
> +impl TargetType {
> +    /// Provide an in-place constructor to register a new device mapper =
target.
> +    pub fn register<T: TargetOperations>(
> +        module: &'static ThisModule,
> +        name: &'static CStr,
> +        version: [u32; 3],
> +        feature: Feature,
> +    ) -> impl PinInit<Self, Error> {
> +        // SAFETY: `slot` is valid while the closure is called.
> +        unsafe {
> +            init::pin_init_from_closure(move |slot: *mut Self| {
> +                // `slot` contains uninit memory, avoid creating a refer=
ence.
> +                let opaque =3D addr_of!((*slot).opaque);
> +                let tt =3D Opaque::raw_get(opaque);
> +
> +                (*tt).module =3D module.0;
> +                (*tt).name =3D name.as_char_ptr();
> +                (*tt).version =3D version;
> +                (*tt).features =3D feature;
> +
> +                check_target_operations!(
> +                    tt,
> +                    (HAS_CTR, ctr, dm_ctr_fn),
> +                    (HAS_DTR, dtr, dm_dtr_fn),
> +                    (HAS_MAP, map, dm_map_fn),
> +                );
> +
> +                to_result(bindings::dm_register_target(tt))
> +            })
> +        }

This `unsafe` block should be split into multiple.

> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for TargetType {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: `self.opaque` are initialized by the `register` const=
ructor,
> +        // so it's valid.

This should be a type invariant of `TargetType`.

> +        unsafe {
> +            bindings::dm_unregister_target(self.opaque.get());
> +        }
> +    }
> +}
> +
> +impl TargetType {
> +    unsafe extern "C" fn dm_ctr_fn<T: TargetOperations>(
> +        target: *mut bindings::dm_target,
> +        argc: core::ffi::c_uint,
> +        argv: *mut *mut core::ffi::c_char,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: the kernel splits arguments by `dm_split_args`, then =
pass
> +        // suitable `argc` and `argv` to `dm_ctr_fn`. If `argc` is not z=
ero,
> +        // `argv` is non-null and valid.
> +        let args =3D unsafe { Args::new(argc, argv) };
> +
> +        // SAFETY: the kernel should pass a valid `dm_target`.
> +        let t =3D unsafe { Target::borrow_mut(target) };
> +        T::ctr(t, args).map_or_else(
> +            |e| e.to_errno(),
> +            // SAFETY: the kernel should pass a valid `dm_target`.
> +            |p| unsafe {
> +                (*target).private =3D Box::into_raw(p) as _;
> +                0
> +            },
> +        )
> +    }
> +    unsafe extern "C" fn dm_dtr_fn<T: TargetOperations>(ti: *mut binding=
s::dm_target) {
> +        // SAFETY: the kernel should pass a valid `dm_target`.
> +        let t =3D unsafe { Target::borrow_mut(ti) };
> +        T::dtr(t);
> +        // SAFETY: `private` is constructed in `dm_ctr_fn`, and we drop =
it here.
> +        unsafe {
> +            let ptr =3D (*ti).private as *mut T::Private;
> +            drop(Box::from_raw(ptr));
> +            (*ti).private =3D core::ptr::null_mut();
> +        }
> +    }
> +    unsafe extern "C" fn dm_map_fn<T: TargetOperations>(
> +        ti: *mut bindings::dm_target,
> +        bio: *mut bindings::bio,
> +    ) -> core::ffi::c_int {
> +        // SAFETY: the kernel should pass a valid `dm_target` and `bio`.
> +        unsafe {
> +            let t =3D Target::borrow_mut(ti);
> +            let bio =3D Bio::from_raw(bio);
> +            T::map(t, bio) as _
> +        }
> +    }
> +}
> +
> +/// Wrap the kernel struct `dm_target`.
> +///
> +/// This struct represents a device mapper target. And the device mapper
> +/// core will alloc/free `dm_target` instances, so we just `borrow` it.
> +/// It also holds a `Private` struct, which is used to persist user's da=
ta,
> +/// and can be accessed by the `private` method.
> +pub struct Target<T: TargetOperations + Sized> {
> +    opaque: Opaque<bindings::dm_target>,
> +    _p: PhantomData<*mut T::Private>,
> +}
> +
> +impl<T: TargetOperations> Target<T> {
> +    unsafe fn borrow<'a>(ptr: *const bindings::dm_target) -> &'a Self {

`unsafe` functions need to have a `# Safety` section.

> +        // SAFETY: the caller should pass a valid `ptr`.

This requirement needs to be documented on the function.

> +        unsafe { &*(ptr as *const Self) }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *mut bindings::dm_target) -> &'a mut S=
elf {
> +        // SAFETY: the caller should pass a valid `ptr`.

This requirement needs to be documented on the function.

> +        unsafe { &mut *(ptr as *mut Self) }
> +    }
> +
> +    /// Access user's private data.
> +    pub fn private(&mut self) -> Option<Pin<&mut T::Private>> {
> +        let t =3D self.opaque.get();
> +        // SAFETY: `self.opaque` is borrowed from foreign pointer, shoul=
d be valid.

This should be a type invariant.

> +        // And 'p' is non-null and assigned in `dm_ctr_fn`, so it's vali=
d.
> +        unsafe {
> +            ((*t).private as *mut T::Private)
> +                .as_mut()
> +                .map(|p| Pin::new_unchecked(p))
> +        }

Split this `unsafe` block.

> +    }
> +
> +    /// Return the target name.
> +    pub fn name(&self) -> &CStr {
> +        // SAFETY: `self.opaque` is borrowed from foreign pointer, shoul=
d be valid.
> +        unsafe {
> +            let name =3D (*(*self.opaque.get()).type_).name;
> +            CStr::from_char_ptr(name)
> +        }

Split this `unsafe` block.

> +    }
> +
> +    /// Return the target version.
> +    pub fn version(&self) -> [u32; 3] {
> +        // SAFETY: `self.opaque` is borrowed from foreign pointer, shoul=
d be valid.
> +        unsafe { (*(*self.opaque.get()).type_).version }
> +    }
> +
> +    /// Return the target begin sector.
> +    pub fn begin_sector(&self) -> usize {
> +        // SAFETY: `self.opaque` is borrowed from foreign pointer, shoul=
d be valid.
> +        unsafe { (*self.opaque.get()).begin as _ }
> +    }
> +
> +    /// Return the target total sectors.
> +    pub fn total_sectors(&self) -> usize {
> +        // SAFETY: `self.opaque` is borrowed from foreign pointer, shoul=
d be valid.
> +        unsafe { (*self.opaque.get()).len as _ }
> +    }
> +
> +    /// Get the underlying device by `path`. The `dm_put_device` will be=
 called when
> +    /// [`TargetDevice`] is dropped.
> +    pub fn get_device(&mut self, path: &CStr) -> Result<TargetDevice<T>>=
 {
> +        let mut dd =3D core::ptr::null_mut();
> +        // SAFETY: `self.opaque` is borrowed from foreign pointer, shoul=
d be valid.
> +        unsafe {
> +            let mode =3D bindings::dm_table_get_mode((*self.opaque.get()=
).table);
> +            match bindings::dm_get_device(self.opaque.get(), path.as_cha=
r_ptr(), mode, &mut dd) {
> +                0 =3D> {
> +                    let ti =3D self.opaque.get();
> +                    Ok(TargetDevice::from_raw(ti, dd))
> +                }
> +                err =3D> Err(Error::from_errno(err)),
> +            }
> +        }

Split this `unsafe` block.

> +    }
> +}
> +
> +/// Represent an underlying device of a device mapper target.
> +///
> +/// We also holds a pointer to `dm_target`, so that we can call
> +/// `dm_put_device` in `drop`, to close the device correctly.
> +pub struct TargetDevice<T: TargetOperations + Sized> {
> +    ti: NonNull<bindings::dm_target>,
> +    dev: NonNull<bindings::dm_dev>,
> +    _p: PhantomData<*mut Target<T>>,
> +}
> +
> +impl<T: TargetOperations> TargetDevice<T> {
> +    unsafe fn from_raw(ti: *mut bindings::dm_target, dd: *mut bindings::=
dm_dev) -> Self {
> +        // SAFETY: the caller should pass valid `dm_target` and `dm_dev`=
.
> +        unsafe {
> +            Self {
> +                ti: NonNull::new_unchecked(ti),
> +                dev: NonNull::new_unchecked(dd),
> +                _p: PhantomData,
> +            }
> +        }
> +    }
> +
> +    /// Borrow the device mapper target.
> +    pub fn target(&self) -> &Target<T> {
> +        // SAFETY: the `from_raw` caller should pass valid `ti` pointer.
> +        unsafe { Target::borrow(self.ti.as_ptr()) }
> +    }
> +
> +    /// Borrow the device mapper target mutably.
> +    pub fn mut_target(&mut self) -> &mut Target<T> {
> +        // SAFETY: the `from_raw` caller should pass valid `ti` pointer.
> +        unsafe { Target::borrow_mut(self.ti.as_ptr()) }
> +    }
> +
> +    /// Return the device name.
> +    pub fn device_name(&self) -> &CStr {
> +        // SAFETY: the `from_raw` caller should pass valid `dev` pointer=
.
> +        unsafe {
> +            let name =3D (*self.dev.as_ptr()).name.as_ptr();
> +            CStr::from_char_ptr(name)
> +        }
> +    }
> +
> +    /// Return the total device sectors.
> +    pub fn device_sectors(&self) -> usize {
> +        // SAFETY: the `from_raw` caller should pass valid `dev` pointer=
.
> +        unsafe { (*(*self.dev.as_ptr()).bdev).bd_nr_sectors as _ }
> +    }
> +}
> +
> +impl<T: TargetOperations> Drop for TargetDevice<T> {
> +    fn drop(&mut self) {
> +        // SAFETY: the `from_raw` caller should pass valid `ti` and `dev=
`.
> +        unsafe { bindings::dm_put_device(self.ti.as_ptr(), self.dev.as_p=
tr()) }
> +    }
> +}
> +
> +/// The return values of target map function, i.e., [`TargetOperations::=
map`].
> +#[repr(u32)]
> +pub enum MapState {
> +    /// The target will handle the io by resubmitting it later.
> +    Submitted =3D bindings::DM_MAPIO_SUBMITTED,
> +
> +    /// Simple remap complete.
> +    Remapped =3D bindings::DM_MAPIO_REMAPPED,
> +
> +    /// The target wants to requeue the io.
> +    Requeue =3D bindings::DM_MAPIO_REQUEUE,
> +
> +    /// The target wants to requeue the io after a delay.
> +    DelayRequeue =3D bindings::DM_MAPIO_DELAY_REQUEUE,
> +
> +    /// The target wants to complete the io.
> +    Kill =3D bindings::DM_MAPIO_KILL,
> +}

Is it really necessary to have these correspond to the exact values?
Could we also just have a conversion function and leave the repr to
the compiler?

> +
> +/// Wrap the `c_char` arguments, which yields `CStr`.
> +pub struct Args {
> +    argc: core::ffi::c_uint,
> +    argv: *mut *mut core::ffi::c_char,
> +}
> +
> +impl Args {
> +    /// The caller should ensure that the number of valid `argv` pointer=
s
> +    /// should be exactly `argc`.

This should be in the `# Safety` section.

> +    unsafe fn new(argc: core::ffi::c_uint, argv: *mut *mut core::ffi::c_=
char) -> Self {
> +        Self { argc, argv }
> +    }
> +
> +    /// Return the number of arguments.
> +    pub fn len(&self) -> usize {
> +        self.argc as _
> +    }
> +
> +    /// Return the `nth` (from zero) argument.
> +    ///
> +    /// If the index is out of bounds, return `None`.
> +    pub fn get(&self, index: usize) -> Option<&CStr> {
> +        if self.argc =3D=3D 0 || index >=3D self.argc as _ {
> +            None
> +        } else {
> +            // SAFETY: the `new` caller should ensure the number of vali=
d `argv`.

Needs to be a type invariant.

--
Cheers,
Benno

> +            unsafe { Some(CStr::from_char_ptr(*self.argv.add(index))) }
> +        }
> +    }
> +}
> +
> +impl Index<usize> for Args {
> +    type Output =3D CStr;
> +
> +    /// When using the indexing operator(`[]`), the caller should check =
the
> +    /// length of [`Args`]. If the index is out of bounds, this will [`p=
anic`].
> +    fn index(&self, index: usize) -> &Self::Output {
> +        if self.argc =3D=3D 0 || index >=3D self.argc as _ {
> +            panic!(
> +                "Index out of bounds: the length is {} but the index is =
{}.",
> +                self.argc, index
> +            )
> +        } else {
> +            // SAFETY: the `new` caller should ensure the number of vali=
d `argv`.
> +            unsafe { CStr::from_char_ptr(*self.argv.add(index)) }
> +        }
> +    }
> +}
> +
> +/// Wrap the kernel struct `bio`.
> +///
> +/// Dummy.
> +#[pin_data]
> +pub struct Bio {
> +    #[pin]
> +    opaque: Opaque<bindings::bio>,
> +}
> +
> +impl Bio {
> +    unsafe fn from_raw<'a>(ptr: *mut bindings::bio) -> Pin<&'a mut Self>=
 {
> +        // SAFETY: the caller should pass a valid `bio` pointer.
> +        unsafe { Pin::new(&mut *(ptr as *mut Self)) }
> +    }
> +
> +    fn op_and_flags(&self) -> u32 {
> +        // SAFETY: the `from_raw` caller should pass valid `bio`, so
> +        // `self.opaque` is valid too.
> +        unsafe { (*self.opaque.get()).bi_opf }
> +    }
> +
> +    /// Return `true` if the bio request is write.
> +    pub fn is_write(&self) -> bool {
> +        self.op_and_flags() & bindings::req_op_REQ_OP_WRITE !=3D 0
> +    }
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..3dc19f4642f0 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -31,6 +31,7 @@
>  #[cfg(not(testlib))]
>  mod allocator;
>  mod build_assert;
> +pub mod device_mapper;
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> --
> 2.40.1
>=20

