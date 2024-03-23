Return-Path: <linux-kernel+bounces-127941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F1389530C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A9D2811E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BA778B63;
	Tue,  2 Apr 2024 12:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="YQVNpIMO"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8547D634EA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061319; cv=none; b=uLECNzKBt5AAsKGsHK8CUzOLHr+EY57uZkNEiNG8c+36exW3gagAqZ6PwdQqxj+uBtx0gFhZTBNv5lYYhUwZRUjEZOQIzsGYmhK29uMr0vBYaKux8vkFXIs9aWsvl+ryDZRCimT+I2g+NZSnV9kwctGQFiT8A1rSsJB3dudWr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061319; c=relaxed/simple;
	bh=Tep4S1Q715UFOx/wLk4+C1NCgjCpeAjutGDVVwux6e0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:Message-ID:
	 MIME-Version:Content-Type; b=ETSmcL3KbaK0PScl4E0Rx+X558bzF+3xxqfTFv46x/RPf5qKacCA87FW6w7w8ic0AbTbX7N2/I18P4wPA2I9/nvQj8PyqdhU60DlIQq6OmFIyKZ/bRIfnnkbfPf3G05WEtv2kcenasLtgh9QHvzRxtTTanb07KLo5r7C6mNoqEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=YQVNpIMO; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-415523d9824so32482275e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712061313; x=1712666113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :references:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94NmtpISCe1DyOWRxAt9pd/Vy2VYBeZeRAEqDACXBAQ=;
        b=YQVNpIMO2UHck47200xVZgKKQkNxm31UIfAbKjXr1oHZ7lHxTk+1q+3IpTImZMPi+t
         Q7gX8rPe6IsflUIbpRfro0iD48usyhrHwEj6/Sb1UveA9K+uxVnKyN0oAnZkuQozxaiJ
         rD9v+KByWN712YmbRiVQHHMt3kMNZMCQc6YhfDHtY6TWwwM2BV/L/uNOakpQpwKA+gbG
         3+Sa5oz6tidI6ajWIFt6CZYQccR8wIyco+d5quzZVM9XuNWF0SBvCSlWUKPVkrRK/SMN
         5nshFFJ2+Y0JyBkuHzw+DzNSXtGjR9ZHgHR+zk8qQTGqyCME9yVbaEY6SHDhAmR4Azo6
         W9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061313; x=1712666113;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :references:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94NmtpISCe1DyOWRxAt9pd/Vy2VYBeZeRAEqDACXBAQ=;
        b=anqFglvDuvqwmd+owyvTbOm5e6YN5Vl4FqnOWuxV1twdQFlvsGU/NfXCAQBJGOlDnS
         Ok/o9bq9HvQJPJMonX7escVdHJqyKto4oJ7Tn1KDzz+DuGBlK9sGPTyjwTBtZ6f5S2zg
         Ngz80Yl4bumlxMRbSqsRacW0UekOaVNVsb0he8C/ZYJ9PFE0VsiTnQDcGqQ6Zg90Ojk5
         BZkHQhrS0lXBSqxA/bKSWGuG/MAxGOKklAhWuMw3ffn1U4ZJii1Dah30WCePwzV1dA9I
         asYmgK8UPq/sZ0Th/uRofGeX6MSvP7ULeq9Fiv0MrKgla0XM5EgkRPmNKhUFgZ5r6Rq4
         tA6A==
X-Forwarded-Encrypted: i=1; AJvYcCVxaiJwoCZ4lpraWk4ihPn+B4r1s/+yaOugBqzNfE7nQ2simz/rS8MPZswD3qyQG7LwKFnjqjEh3oAP04Y2Ws3cHnjX/lw07n9ofIy9
X-Gm-Message-State: AOJu0YyWkiA0GURTJ3m70H5MiMrGfr54jv4JPPArZEvMimLLGqemsN9r
	U/oUqHZiMNG3EyVms7zo2OMXyCYjp0YtKbvDjHvh6aEKL9/9AuwcvhwYs2kF9Mg=
X-Google-Smtp-Source: AGHT+IHcieVheldqhM4UoWK5vICzNsoxsy4JvMAL43HoaZQG5XxVSRSnhuJd6A8CWg5rElbDAvsNOw==
X-Received: by 2002:a05:600c:17c7:b0:414:392:38d2 with SMTP id y7-20020a05600c17c700b00414039238d2mr1359936wmo.24.1712061313040;
        Tue, 02 Apr 2024 05:35:13 -0700 (PDT)
Received: from localhost ([165.225.194.196])
        by smtp.gmail.com with ESMTPSA id k4-20020a5d6e84000000b0033ea499c645sm14159661wrz.4.2024.04.02.05.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:35:12 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me> (Benno Lossin's
	message of "Fri, 22 Mar 2024 23:40:37 +0000")
Date: Sat, 23 Mar 2024 07:32:35 +0100
References: <86cd5566-5f1b-434a-9163-2b2d60a759d1@proton.me>
User-Agent: mu4e 1.12.0; emacs 29.2
Message-ID: <871q7o54el.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Benno Lossin <benno.lossin@proton.me> writes:

> On 3/13/24 12:05, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>>=20
>> Add initial abstractions for working with blk-mq.
>>=20
>> This patch is a maintained, refactored subset of code originally publish=
ed by
>> Wedson Almeida Filho <wedsonaf@gmail.com> [1].
>>=20
>> [1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268=
bbd4382a891/rust/kernel/blk/mq.rs
>>=20
>> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>   block/blk-mq.c                     |   3 +-
>>   include/linux/blk-mq.h             |   1 +
>>   rust/bindings/bindings_helper.h    |   2 +
>>   rust/helpers.c                     |  45 ++++
>>   rust/kernel/block.rs               |   5 +
>>   rust/kernel/block/mq.rs            | 131 +++++++++++
>>   rust/kernel/block/mq/gen_disk.rs   | 174 +++++++++++++++
>>   rust/kernel/block/mq/operations.rs | 346 +++++++++++++++++++++++++++++
>>   rust/kernel/block/mq/raw_writer.rs |  60 +++++
>>   rust/kernel/block/mq/request.rs    | 182 +++++++++++++++
>>   rust/kernel/block/mq/tag_set.rs    | 117 ++++++++++
>>   rust/kernel/error.rs               |   5 +
>>   rust/kernel/lib.rs                 |   1 +
>>   13 files changed, 1071 insertions(+), 1 deletion(-)
>
> Do you think that it's possible to split this into smaller
> patches? It would make review a lot easier.

Probably, I'll look into that.

>
>>   create mode 100644 rust/kernel/block.rs
>>   create mode 100644 rust/kernel/block/mq.rs
>>   create mode 100644 rust/kernel/block/mq/gen_disk.rs
>>   create mode 100644 rust/kernel/block/mq/operations.rs
>>   create mode 100644 rust/kernel/block/mq/raw_writer.rs
>>   create mode 100644 rust/kernel/block/mq/request.rs
>>   create mode 100644 rust/kernel/block/mq/tag_set.rs
>
> [...]
>
>> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
>> new file mode 100644
>> index 000000000000..4c93317a568a
>> --- /dev/null
>> +++ b/rust/kernel/block.rs
>> @@ -0,0 +1,5 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Types for working with the block layer
>
> Missing '.'.

=F0=9F=91=8D

>
>> +
>> +pub mod mq;
>> diff --git a/rust/kernel/block/mq.rs b/rust/kernel/block/mq.rs
>> new file mode 100644
>> index 000000000000..08de1cc114ff
>> --- /dev/null
>> +++ b/rust/kernel/block/mq.rs
>> @@ -0,0 +1,131 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides types for implementing block drivers that inte=
rface the
>> +//! blk-mq subsystem.
>> +//!
>> +//! To implement a block device driver, a Rust module must do the follo=
wing:
>> +//!
>> +//! - Implement [`Operations`] for a type `T`
>
> I think it would be nicer to use `Driver` (or `MyBlkDevice`) instead of
> `T`.

I think I like `T` better, because it signals placeholder more
effectively.

>
>> +//! - Create a [`TagSet<T>`]
>> +//! - Create a [`GenDisk<T>`], passing in the `TagSet` reference
>> +//! - Add the disk to the system by calling [`GenDisk::add`]
>> +//!
>> +//! The types available in this module that have direct C counterparts =
are:
>> +//!
>> +//! - The `TagSet` type that abstracts the C type `struct tag_set`.
>> +//! - The `GenDisk` type that abstracts the C type `struct gendisk`.
>> +//! - The `Request` type that abstracts the C type `struct request`.
>> +//!
>> +//! Many of the C types that this module abstracts allow a driver to ca=
rry
>> +//! private data, either embedded in the stuct directly, or as a C `voi=
d*`. In
>> +//! these abstractions, this data is typed. The types of the data is de=
fined by
>> +//! associated types in `Operations`, see [`Operations::RequestData`] f=
or an
>> +//! example.
>> +//!
>> +//! The kernel will interface with the block evice driver by calling th=
e method
>
> Typo: "block evice driver"

Thanks.

>
>> +//! implementations of the `Operations` trait.
>> +//!
>> +//! IO requests are passed to the driver as [`Request`] references. The
>> +//! `Request` type is a wrapper around the C `struct request`. The driv=
er must
>> +//! mark start of request processing by calling [`Request::start`] and =
end of
>> +//! processing by calling one of the [`Request::end`], methods. Failure=
 to do so
>> +//! can lead to IO failures.
>
> I am unfamiliar with this, what are "IO failures"?
> Do you think that it might be better to change the API to use a
> callback? So instead of calling start and end, you would do
>
>      request.handle(|req| {
>          // do the stuff that would be done between start and end
>      });
>
> I took a quick look at the rnull driver and there you are calling
> `Request::end_ok` from a different function. So my suggestion might not
> be possible, since you really need the freedom.
>
> Do you think that a guard approach might work better? ie `start` returns
> a guard that when dropped will call `end` and you need the guard to
> operate on the request.

I don't think that would fit, since the driver might not complete the
request immediately. We might be able to call `start` on behalf of the
driver.

At any rate, since the request is reference counted now, we can
automatically fail a request when the last reference is dropped and it
was not marked successfully completed. I would need to measure the
performance implications of such a feature.

The comment needs update too. Failure to complete requests will lead to
either deadlock or timeout errors, depending on configuration.

>
>> +//!
>> +//! The `TagSet` is responsible for creating and maintaining a mapping =
between
>> +//! `Request`s and integer ids as well as carrying a pointer to the vta=
ble
>> +//! generated by `Operations`. This mapping is useful for associating
>> +//! completions from hardware with the correct `Request` instance. The =
`TagSet`
>> +//! determines the maximum queue depth by setting the number of `Reques=
t`
>> +//! instances available to the driver, and it determines the number of =
queues to
>> +//! instantiate for the driver. If possible, a driver should allocate o=
ne queue
>> +//! per core, to keep queue data local to a core.
>> +//!
>> +//! One `TagSet` instance can be shared between multiple `GenDisk` inst=
ances.
>> +//! This can be useful when implementing drivers where one piece of har=
dware
>> +//! with one set of IO resources are represented to the user as multipl=
e disks.
>> +//!
>> +//! One significant difference between block device drivers implemented=
 with
>> +//! these Rust abstractions and drivers implemented in C, is that the R=
ust
>> +//! drivers have to own a reference count on the `Request` type when th=
e IO is
>> +//! in flight. This is to ensure that the C `struct request` instances =
backing
>> +//! the Rust `Request` instances are live while the Rust driver holds a
>> +//! reference to the `Request`. In addition, the conversion of an inege=
r tag to
>
> Typo: "of an ineger tag"

Thanks. Looks like I need to properly configure my editor to spell check
in comments.

>
>> +//! a `Request` via the `TagSet` would not be sound without this bookke=
eping.
>> +//!
>> +//! # =E2=9A=A0 Note
>> +//!
>> +//! For Rust block device drivers, the point in time where a request
>> +//! is freed and made available for recycling is usualy at the point in=
 time
>> +//! when the last `ARef<Request>` is dropped. For C drivers, this event=
 usually
>> +//! occurs when `bindings::blk_mq_end_request` is called.
>> +//!
>> +//! # Example
>> +//!
>> +//! ```rust
>> +//! use kernel::{
>> +//!     block::mq::*,
>> +//!     new_mutex,
>> +//!     prelude::*,
>> +//!     sync::{Arc, Mutex},
>> +//!     types::{ARef, ForeignOwnable},
>> +//! };
>> +//!
>> +//! struct MyBlkDevice;
>> +//!
>> +//! #[vtable]
>> +//! impl Operations for MyBlkDevice {
>> +//!     type RequestData =3D ();
>> +//!     type RequestDataInit =3D impl PinInit<()>;
>> +//!     type QueueData =3D ();
>> +//!     type HwData =3D ();
>> +//!     type TagSetData =3D ();
>> +//!
>> +//!     fn new_request_data(
>> +//!         _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowe=
d<'_>,
>> +//!     ) -> Self::RequestDataInit {
>> +//!         kernel::init::zeroed()
>> +//!     }
>> +//!
>> +//!     fn queue_rq(_hw_data: (), _queue_data: (), rq: ARef<Request<Sel=
f>>, _is_last: bool) -> Result {
>> +//!         rq.start();
>> +//!         rq.end_ok();
>> +//!         Ok(())
>> +//!     }
>> +//!
>> +//!     fn commit_rqs(
>> +//!         _hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
>> +//!         _queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<=
'_>,
>> +//!     ) {
>> +//!     }
>> +//!
>> +//!     fn complete(rq: &Request<Self>) {
>> +//!         rq.end_ok();
>> +//!     }
>> +//!
>> +//!     fn init_hctx(
>> +//!         _tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowe=
d<'_>,
>> +//!         _hctx_idx: u32,
>> +//!     ) -> Result<Self::HwData> {
>> +//!         Ok(())
>> +//!     }
>> +//! }
>> +//!
>> +//! let tagset: Arc<TagSet<MyBlkDevice>> =3D Arc::pin_init(TagSet::try_=
new(1, (), 256, 1))?;
>> +//! let mut disk =3D GenDisk::try_new(tagset, ())?;
>> +//! disk.set_name(format_args!("myblk"))?;
>> +//! disk.set_capacity_sectors(4096);
>> +//! disk.add()?;
>> +//!
>> +//! # Ok::<(), kernel::error::Error>(())
>> +//! ```
>
> This piece of documentation is **really** valuable, thanks a lot for
> taking the time to write it.

Great!

>
>> +
>> +mod gen_disk;
>> +mod operations;
>> +mod raw_writer;
>> +mod request;
>> +mod tag_set;
>> +
>> +pub use gen_disk::GenDisk;
>> +pub use operations::Operations;
>> +pub use request::{Request, RequestDataRef};
>> +pub use tag_set::TagSet;
>> diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen=
_disk.rs
>> new file mode 100644
>> index 000000000000..b7845fc9e39f
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/gen_disk.rs
>> @@ -0,0 +1,174 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Generic disk abstraction.
>> +//!
>> +//! C header: [`include/linux/blkdev.h`](srctree/include/linux/blkdev.h)
>> +//! C header: [`include/linux/blk_mq.h`](srctree/include/linux/blk_mq.h)
>> +
>> +use crate::block::mq::{raw_writer::RawWriter, Operations, TagSet};
>> +use crate::{
>> +    bindings, error::from_err_ptr, error::Result, sync::Arc, types::For=
eignOwnable,
>> +    types::ScopeGuard,
>> +};
>> +use core::fmt::{self, Write};
>> +
>> +/// A generic block device
>> +///
>> +/// # Invariants
>> +///
>> +///  - `gendisk` must always point to an initialized and valid `struct =
gendisk`.
>> +pub struct GenDisk<T: Operations> {
>> +    _tagset: Arc<TagSet<T>>,
>> +    gendisk: *mut bindings::gendisk,
>> +}
>> +
>> +// SAFETY: `GenDisk` is an owned pointer to a `struct gendisk` and an `=
Arc` to a
>> +// `TagSet` It is safe to send this to other threads as long as T is Se=
nd.
>> +unsafe impl<T: Operations + Send> Send for GenDisk<T> {}
>> +
>> +impl<T: Operations> GenDisk<T> {
>> +    /// Try to create a new `GenDisk`
>> +    pub fn try_new(tagset: Arc<TagSet<T>>, queue_data: T::QueueData) ->=
 Result<Self> {
>> +        let data =3D queue_data.into_foreign();
>> +        let recover_data =3D ScopeGuard::new(|| {
>> +            // SAFETY: T::QueueData was created by the call to `into_fo=
reign()` above
>> +            unsafe { T::QueueData::from_foreign(data) };
>> +        });
>> +
>> +        let lock_class_key =3D crate::sync::LockClassKey::new();
>> +
>> +        // SAFETY: `tagset.raw_tag_set()` points to a valid and initial=
ized tag set
>> +        let gendisk =3D from_err_ptr(unsafe {
>> +            bindings::__blk_mq_alloc_disk(
>> +                tagset.raw_tag_set(),
>> +                data.cast_mut(),
>> +                lock_class_key.as_ptr(),
>> +            )
>> +        })?;
>> +
>> +        const TABLE: bindings::block_device_operations =3D bindings::bl=
ock_device_operations {
>> +            submit_bio: None,
>> +            open: None,
>> +            release: None,
>> +            ioctl: None,
>> +            compat_ioctl: None,
>> +            check_events: None,
>> +            unlock_native_capacity: None,
>> +            getgeo: None,
>> +            set_read_only: None,
>> +            swap_slot_free_notify: None,
>> +            report_zones: None,
>> +            devnode: None,
>> +            alternative_gpt_sector: None,
>> +            get_unique_id: None,
>> +            // TODO: Set to THIS_MODULE. Waiting for const_refs_to_stat=
ic feature to be merged
>> +            // https://github.com/rust-lang/rust/issues/119618
>> +            owner: core::ptr::null_mut(),
>> +            pr_ops: core::ptr::null_mut(),
>> +            free_disk: None,
>> +            poll_bio: None,
>> +        };
>> +
>> +        // SAFETY: gendisk is a valid pointer as we initialized it above
>> +        unsafe { (*gendisk).fops =3D &TABLE };
>> +
>> +        recover_data.dismiss();
>> +        Ok(Self {
>> +            _tagset: tagset,
>> +            gendisk,
>
> Missing INVARIANT comment.

Will fix.

>
>> +        })
>> +    }
>> +
>> +    /// Set the name of the device
>
> Missing '.'.

Thanks.

>
>> +    pub fn set_name(&mut self, args: fmt::Arguments<'_>) -> Result {
>> +        let mut raw_writer =3D RawWriter::from_array(
>> +            // SAFETY: By type invariant `self.gendisk` points to a val=
id and initialized instance
>> +            unsafe { &mut (*self.gendisk).disk_name },
>
> To create a `&mut` reference, you need exclusive access, it should be
> sufficient to add to the invariant that `gendisk` is owned/unique.

Hmm, we don't actually _always_ have unique ownership of this string
buffer. I will change the API to only allow configuration of the
instance before it is hooked in. Thanks for spotting this.

>
>> +        );
>> +        raw_writer.write_fmt(args)?;
>> +        raw_writer.write_char('\0')?;
>> +        Ok(())
>> +    }
>
> [...]
>
>> +impl<T: Operations> Drop for GenDisk<T> {
>> +    fn drop(&mut self) {
>> +        // SAFETY: By type invariant of `Self`, `self.gendisk` points t=
o a valid
>> +        // and initialized instance of `struct gendisk`. As such, `queu=
edata`
>> +        // was initialized by the initializer returned by `try_new` wit=
h a call
>> +        // to `ForeignOwnable::into_foreign`.
>
> This should also be an invariant of `GenDisk`.

Ok.

>
>> +        let queue_data =3D unsafe { (*(*self.gendisk).queue).queuedata =
};
>> +
>> +        // SAFETY: By type invariant, `self.gendisk` points to a valid =
and
>> +        // initialized instance of `struct gendisk`
>> +        unsafe { bindings::del_gendisk(self.gendisk) };
>> +
>> +        // SAFETY: `queue.queuedata` was created by `GenDisk::try_new()=
` with a
>> +        // call to `ForeignOwnable::into_pointer()` to create `queuedat=
a`.
>> +        // `ForeignOwnable::from_foreign()` is only called here.
>> +        let _queue_data =3D unsafe { T::QueueData::from_foreign(queue_d=
ata) };
>> +    }
>> +}
>> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/o=
perations.rs
>> new file mode 100644
>> index 000000000000..53c6ad663208
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/operations.rs
>> @@ -0,0 +1,346 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides an interface for blk-mq drivers to implement.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::Request,
>> +    error::{from_result, Result},
>> +    init::PinInit,
>> +    types::{ARef, ForeignOwnable},
>> +};
>> +use core::{marker::PhantomData, ptr::NonNull};
>> +
>> +use super::TagSet;
>> +
>> +/// Implement this trait to interface blk-mq as block devices
>> +#[macros::vtable]
>> +pub trait Operations: Sized {
>> +    /// Data associated with a request. This data is located next to th=
e request
>> +    /// structure.
>> +    ///
>> +    /// To be able to handle accessing this data from interrupt context=
, this
>> +    /// data must be `Sync`.
>> +    type RequestData: Sized + Sync;
>> +
>> +    /// Initializer for `Self::RequestDta`. Used to initialize private =
data area
>> +    /// when requst structure is allocated.
>> +    type RequestDataInit: PinInit<Self::RequestData>;
>
> Just to let you know, this dance with the associated types is not needed
> any longer. RPITIT (return position impl trait in trait) has been
> stabilized in 1.75 and you should be able to just write this:
>
>      fn new_request_data(
>          //rq: ARef<Request<Self>>,
>          tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
>      ) -> impl PinInit<Self::RequestData>;
>

Thanks =F0=9F=91=8D

>
>> +
>> +    /// Data associated with the `struct request_queue` that is allocat=
ed for
>> +    /// the `GenDisk` associated with this `Operations` implementation.
>> +    type QueueData: ForeignOwnable;
>> +
>> +    /// Data associated with a dispatch queue. This is stored as a poin=
ter in
>> +    /// the C `struct blk_mq_hw_ctx` that represents a hardware queue.
>> +    type HwData: ForeignOwnable;
>> +
>> +    /// Data associated with a `TagSet`. This is stored as a pointer in=
 `struct
>> +    /// blk_mq_tag_set`.
>> +    type TagSetData: ForeignOwnable;
>> +
>> +    /// Called by the kernel to get an initializer for a `Pin<&mut Requ=
estData>`.
>> +    fn new_request_data(
>> +        //rq: ARef<Request<Self>>,
>> +        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
>
> Since you need to use this pattern a lot, it might be a good idea to
> introduce a type alias to help with this:
>
>      type ForeignBorrowed<'a, T> =3D <T as ForeignOwnable>::Borrowed<'a>;
>
> What do the others think?
>
> The function would then become (with the RPITIT improvement as well):
>
>      fn new_request_data(
>          //rq: ARef<Request<Self>>,
>          tagset_data: ForeignBorrowed<'_, Self::TagSetData>,
>      ) -> impl PinInit<Self::RequestData>;

A bit more concise, I think it is better. I'll go ahead and kill that
commented out argument that sneaked into the patch as well :)

>
>
>> +    ) -> Self::RequestDataInit;
>> +
>> +    /// Called by the kernel to queue a request with the driver. If `is=
_last` is
>> +    /// `false`, the driver is allowed to defer commiting the request.
>> +    fn queue_rq(
>> +        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
>> +        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
>> +        rq: ARef<Request<Self>>,
>> +        is_last: bool,
>> +    ) -> Result;
>> +
>> +    /// Called by the kernel to indicate that queued requests should be=
 submitted
>> +    fn commit_rqs(
>> +        hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>,
>> +        queue_data: <Self::QueueData as ForeignOwnable>::Borrowed<'_>,
>> +    );
>> +
>> +    /// Called by the kernel when the request is completed
>> +    fn complete(_rq: &Request<Self>);
>> +
>> +    /// Called by the kernel to allocate and initialize a driver specif=
ic hardware context data
>> +    fn init_hctx(
>> +        tagset_data: <Self::TagSetData as ForeignOwnable>::Borrowed<'_>,
>> +        hctx_idx: u32,
>> +    ) -> Result<Self::HwData>;
>> +
>> +    /// Called by the kernel to poll the device for completed requests.=
 Only
>> +    /// used for poll queues.
>> +    fn poll(_hw_data: <Self::HwData as ForeignOwnable>::Borrowed<'_>) -=
> bool {
>> +        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
>> +    }
>> +
>> +    /// Called by the kernel to map submission queues to CPU cores.
>> +    fn map_queues(_tag_set: &TagSet<Self>) {
>> +        crate::build_error(crate::error::VTABLE_DEFAULT_ERROR)
>> +    }
>> +
>> +    // There is no need for exit_request() because `drop` will be calle=
d.
>
> I think it would be a good idea to mention this in the documentation of
> the trait.

Yes.

>
>> +}
>
> [...]
>
>> diff --git a/rust/kernel/block/mq/raw_writer.rs b/rust/kernel/block/mq/r=
aw_writer.rs
>> new file mode 100644
>> index 000000000000..f7857740af29
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/raw_writer.rs
>> @@ -0,0 +1,60 @@
>> +use core::{
>> +    fmt::{self, Write},
>> +    marker::PhantomData,
>> +};
>> +
>> +/// A mutable reference to a byte buffer where a string can be written =
into
>> +///
>> +/// # Invariants
>> +///
>> +/// * `ptr` is not aliased and valid for read and write for `len` bytes
>
> You probably also want to add "for the duration of `'a`".

=F0=9F=91=8D

>
>> +///
>> +pub(crate) struct RawWriter<'a> {
>> +    ptr: *mut u8,
>> +    len: usize,
>> +    _p: PhantomData<&'a ()>,
>> +}
>> +
>> +impl<'a> RawWriter<'a> {
>> +    /// Create a new `RawWriter` instance.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// * `ptr` must be valid for read and write for `len` consecutive =
`u8` elements
>> +    /// * `ptr` must not be aliased
>> +    unsafe fn new(ptr: *mut u8, len: usize) -> RawWriter<'a> {
>> +        Self {
>> +            ptr,
>> +            len,
>> +            _p: PhantomData,
>> +        }
>> +    }
>
> Since this function is not used (except in the function below), what is
> the reason for using a raw pointer?
> I looked in your other patches, but did not find another user, so could
> this be improved by using mutable references?

I am not sure. But I think the code could benefit from getting passed a
mutable slice instead, move the safety comment to the call site. I will
try that.

>
>> +
>> +    pub(crate) fn from_array<const N: usize>(a: &'a mut [core::ffi::c_c=
har; N]) -> RawWriter<'a> {
>> +        // SAFETY: the buffer of `a` is valid for read and write for at=
 least `N` bytes
>> +        unsafe { Self::new(a.as_mut_ptr().cast::<u8>(), N) }
>> +    }
>> +}
>> +
>> +impl Write for RawWriter<'_> {
>> +    fn write_str(&mut self, s: &str) -> fmt::Result {
>> +        let bytes =3D s.as_bytes();
>> +        let len =3D bytes.len();
>> +        if len > self.len {
>> +            return Err(fmt::Error);
>> +        }
>> +
>> +        // SAFETY:
>> +        // * `bytes` is valid for reads of `bytes.len()` size because w=
e hold a shared reference to `s`
>> +        // * By type invariant `self.ptr` is valid for writes for at le=
st `self.len` bytes
>> +        // * The regions are not overlapping as `ptr` is not aliased
>> +        unsafe { core::ptr::copy_nonoverlapping(&bytes[0], self.ptr, le=
n) };
>> +
>> +        // SAFETY: By type invariant of `Self`, `ptr` is in bounds of an
>> +        // allocation. Also by type invariant, the pointer resulting fr=
om this
>> +        // addition is also in bounds.
>> +        self.ptr =3D unsafe { self.ptr.add(len) };
>> +        self.len -=3D len;
>> +        Ok(())
>> +    }
>> +}
>> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/requ=
est.rs
>> new file mode 100644
>> index 000000000000..b4dacac5e091
>> --- /dev/null
>> +++ b/rust/kernel/block/mq/request.rs
>> @@ -0,0 +1,182 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! This module provides a wrapper for the C `struct request` type.
>> +//!
>> +//! C header: [`include/linux/blk-mq.h`](srctree/include/linux/blk-mq.h)
>> +
>> +use crate::{
>> +    bindings,
>> +    block::mq::Operations,
>> +    error::{Error, Result},
>> +    types::{ARef, AlwaysRefCounted, Opaque},
>> +};
>> +use core::{ffi::c_void, marker::PhantomData, ops::Deref};
>> +
>> +/// A wrapper around a blk-mq `struct request`. This represents an IO r=
equest.
>> +///
>> +/// # Invariants
>> +///
>> +/// * `self.0` is a valid `struct request` created by the C portion of =
the kernel
>> +/// * `self` is reference counted. a call to `req_ref_inc_not_zero` kee=
ps the
>> +///    instance alive at least until a matching call to `req_ref_put_an=
d_test`
>> +///
>> +#[repr(transparent)]
>> +pub struct Request<T: Operations>(Opaque<bindings::request>, PhantomDat=
a<T>);
>> +
>> +impl<T: Operations> Request<T> {
>> +    /// Create a `&mut Request` from a `bindings::request` pointer
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// * `ptr` must be aligned and point to a valid `bindings::request=
` instance
>> +    /// * Caller must ensure that the pointee of `ptr` is live and owned
>> +    ///   exclusively by caller for at least `'a`
>> +    ///
>> +    pub(crate) unsafe fn from_ptr_mut<'a>(ptr: *mut bindings::request) =
-> &'a mut Self {
>> +        // SAFETY:
>> +        // * The cast is valid as `Self` is transparent.
>> +        // * By safety requirements of this function, the reference wil=
l be
>> +        //   valid for 'a.
>> +        unsafe { &mut *(ptr.cast::<Self>()) }
>> +    }
>> +
>> +    /// Get the command identifier for the request
>> +    pub fn command(&self) -> u32 {
>> +        // SAFETY: By C API contract and type invariant, `cmd_flags` is=
 valid for read
>> +        unsafe { (*self.0.get()).cmd_flags & ((1 << bindings::REQ_OP_BI=
TS) - 1) }
>> +    }
>> +
>> +    /// Call this to indicate to the kernel that the request has been i=
ssued by the driver
>
> I am a bit confused, is this not supposed to signal that the processing
> of the request is going to start now? cf C documentation:
>
>      /**
>       * blk_mq_start_request - Start processing a request
>       * @rq: Pointer to request to be started
>       *
>       * Function used by device drivers to notify the block layer that a =
request
>       * is going to be processed now, so blk layer can do proper initiali=
zations
>       * such as starting the timeout timer.
>       */

Yes, it is to indicate that the request is now considered in-flight by
the driver. I'll change the wording a bit.

>
>> +    pub fn start(&self) {
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>> +        unsafe { bindings::blk_mq_start_request(self.0.get()) };
>> +    }
>> +
>> +    /// Call this to indicate to the kernel that the request has been c=
ompleted without errors
>
> I dislike the "Call this", it feels redundant, what about "Signal the
> block layer that the request has been completed without errors.".
>
> Also with the other functions below.

I agree.

>
>> +    pub fn end_ok(&self) {
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>> +        unsafe { bindings::blk_mq_end_request(self.0.get(), bindings::B=
LK_STS_OK as _) };
>> +    }
>> +
>> +    /// Call this to indicate to the kernel that the request completed =
with an error
>> +    pub fn end_err(&self, err: Error) {
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`. By
>> +        // existence of `&mut self` we have exclusive access.
>> +        unsafe { bindings::blk_mq_end_request(self.0.get(), err.to_blk_=
status()) };
>> +    }
>> +
>> +    /// Call this to indicate that the request completed with the statu=
s indicated by `status`
>> +    pub fn end(&self, status: Result) {
>> +        if let Err(e) =3D status {
>> +            self.end_err(e);
>> +        } else {
>> +            self.end_ok();
>> +        }
>> +    }
>> +
>> +    /// Call this to schedule defered completion of the request
>> +    pub fn complete(&self) {
>> +        // SAFETY: By type invariant, `self.0` is a valid `struct reque=
st`
>> +        if !unsafe { bindings::blk_mq_complete_request_remote(self.0.ge=
t()) } {
>> +            T::complete(self);
>> +        }
>> +    }
>> +
>> +    /// Get the target sector for the request
>> +    #[inline(always)]
>> +    pub fn sector(&self) -> usize {
>> +        // SAFETY: By type invariant of `Self`, `self.0` is valid and l=
ive.
>> +        unsafe { (*self.0.get()).__sector as usize }
>> +    }
>> +
>> +    /// Returns an owned reference to the per-request data associated w=
ith this
>> +    /// request
>> +    pub fn owned_data_ref(request: ARef<Self>) -> RequestDataRef<T> {
>> +        RequestDataRef::new(request)
>> +    }
>> +
>> +    /// Returns a reference to the oer-request data associated with thi=
s request
>
> Typo: "the oer-request"

Thanks.

>
>> +    pub fn data_ref(&self) -> &T::RequestData {
>> +        let request_ptr =3D self.0.get().cast::<bindings::request>();
>> +
>> +        // SAFETY: `request_ptr` is a valid `struct request` because `A=
Ref` is
>> +        // `repr(transparent)`
>> +        let p: *mut c_void =3D unsafe { bindings::blk_mq_rq_to_pdu(requ=
est_ptr) };
>> +
>> +        let p =3D p.cast::<T::RequestData>();
>> +
>> +        // SAFETY: By C API contract, `p` is initialized by a call to
>> +        // `OperationsVTable::init_request_callback()`. By existence of=
 `&self`
>> +        // it must be valid for use as a shared reference.
>> +        unsafe { &*p }
>> +    }
>> +}
>> +
>> +// SAFETY: It is impossible to obtain an owned or mutable `Request`, so=
 we can
>
> What do you mean by "mutable `Request`"? There is the function to obtain
> a `&mut Request`.

The idea behind this comment is that it is not possible to have an owned
`Request` instance. You can only ever have something that will deref
(shared) to `Request`. Construction of the `Request` type is not
possible in safe driver code. At least that is the intention.

The `from_ptr_mut` is unsafe, and could be downgraded to
`from_ptr`, since `Operations::complete` takes a shared reference
anyway. Bottom line is that user code does not handle `&mut Request`.

> Also this should probably be an invariant if you use it as a
> justification here.

Ok.

>
>> +// mark it `Send`.
>> +unsafe impl<T: Operations> Send for Request<T> {}
>> +
>> +// SAFETY: `Request` references can be shared across threads.
>
> Does not explain why that is the case.

Will add.

>
>> +unsafe impl<T: Operations> Sync for Request<T> {}
>> +
>> +/// An owned reference to a `Request<T>`
>> +#[repr(transparent)]
>> +pub struct RequestDataRef<T: Operations> {
>> +    request: ARef<Request<T>>,
>> +}
>
> Is this extra type really needed? I have not yet taken a look at patch 3,
> which uses this. But would it hurt if you implemented the traits
> there directly on `ARef<Request<T>>`?

Yes, thanks :) Way better with just `ARef<Request<T>>`.

>
>> +
>> +impl<T> RequestDataRef<T>
>> +where
>> +    T: Operations,
>> +{
>> +    /// Create a new instance.
>> +    fn new(request: ARef<Request<T>>) -> Self {
>> +        Self { request }
>> +    }
>> +
>> +    /// Get a reference to the underlying request
>> +    pub fn request(&self) -> &Request<T> {
>> +        &self.request
>> +    }
>> +}
>
> I really like how you improved the safety comments and documentation. It
> was a lot easier to wrap my head around this time (might also me getting
> more experienced, but I think it helped a lot).

That's great!

Best regards,
Andreas


