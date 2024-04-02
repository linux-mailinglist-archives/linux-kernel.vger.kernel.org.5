Return-Path: <linux-kernel+bounces-127974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B848E8953E4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9E1F1C2264F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684181721;
	Tue,  2 Apr 2024 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="xsN/iSMT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23A77623
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062385; cv=none; b=lRB0vJQFdnV24B6uEkm1GehJY589Gs+xzUE2O9/a3gJMkLUWWcFeETi0qCuvuG5ZwkRJ65kVVlhj0VhLnJCXsI711nv2E0ux7HiWEVLtdDs7BU48xpc2UZZEypkNwWWNo/P36RantoldCtQWa4ReEdIUB4pcxmG2QCpK+1mglAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062385; c=relaxed/simple;
	bh=q2kPt6yjl30JqIa0seZEYYNUi+H5nFnRONvscP4kMok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PQHUcO1qZ6tjnTb2WPTCbBgXNXMJmdDXgBSNUzFunp+PUxISwp3/oMhEZgqOzZAov5FR16VCLdQ5LgSRpVzec4efhn7L3W19FYJRmFTxnq1z2yl6bQqSp22JYYy5wZIOr203ueWHtHa/PQHzvmBkAycUaZ1TC3UsKZq/dmK1ehU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=xsN/iSMT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so33852415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 05:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1712062381; x=1712667181; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqmgY3xDOiui/wAdPFJWohuj9sT1khau6i6swSwlQYg=;
        b=xsN/iSMTp1Fw4B3kEnTv+4/c5Mg8t2aHZZ2rBQZ716ZHggBOC4rwk7vqVbbCFuuCGV
         VSqBfdMjHvowHhLNcM1OHSqyUDNQ98jycbzU/jb1kQm4TVuxF9ba40KIRv8L02DVJDqe
         e3x40fSJbz4jnN+gr3vMN1BiM1dPq4g1oO6WlGDjH8B6Hmg8krrdsCrWsotgDhcXyu/W
         gOQTKJNuQ1BIPU0jVhszdRCMAmOPtSATybE3ETVGZ41a+4OKtleKYPNbAUpOhIt2PHN+
         wYoRjvMaybQnUotFdue/k9OJ+PseknpnrjhCfgRRP9TFblRF+NBRvaIUVgHFbHvIRwkw
         eKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062381; x=1712667181;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqmgY3xDOiui/wAdPFJWohuj9sT1khau6i6swSwlQYg=;
        b=i2Q2Aevj6SbBdP9kBRgP8MtlYhgkbHtqonh2nu1NnHELRRPHS5TFVshDREP04i5Ibi
         fhOfObkUbc5tV6iEI46bPqrhW4SGX02+nlfrjvL12I+U7XgrAvfrmJ5mAZd+YrOCUxkx
         U0RiVFEzfEVuzO/PZBLdi/nMnOsvLf/ZUgBdb0ZC/Jeq/EJO2GSnwNsIv9AiLu5TqCUO
         WL6Sw0eM5hdxcsEZhE9kIxJr8zSB0qyOXSg5Iazoex2CPLPqXhE7d6gEm1aRCL8n6WUH
         awpZAH9RhtitUocRmQ6IzQXl41E20sCUIfE1502TRMn7tblryVFjf/KABLwn/4w1/MVb
         7AYA==
X-Forwarded-Encrypted: i=1; AJvYcCVtgeTw0veu5g/HM1eMduUdj7a6YzK6+Fy2NEEaPEEaMufzG7Ofjp/6e6SrlHMT3zG1921kcuC8LgTikRt4ICnkBzgWZO06KweTBkUw
X-Gm-Message-State: AOJu0Yx/WDHRyY78EYciu4t0zcr8A9MU50aWFBgfXJWc0JFvDdoCZtVj
	SiZAWxiBWAIUDsA4/U52/HwwauIafyBx/xDFcElR0Vt/J/mz8dnZEPVI7lX0BuE=
X-Google-Smtp-Source: AGHT+IHxclVsDENAUON4rVhcSkQFjbXUsDazPWYbGOXYd0gI08wkjR8X6U1Z5rM/JUvg32AMwQso8g==
X-Received: by 2002:a05:600c:5188:b0:415:6e79:91dc with SMTP id fa8-20020a05600c518800b004156e7991dcmr2655357wmb.15.1712062380823;
        Tue, 02 Apr 2024 05:53:00 -0700 (PDT)
Received: from localhost ([147.161.155.112])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600c4f0d00b004161af729f4sm2029727wmq.31.2024.04.02.05.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 05:53:00 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>,  Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>,  Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,
  Greg KH <gregkh@linuxfoundation.org>,  Matthew Wilcox
 <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor
 <alex.gaynor@gmail.com>,  Wedson Almeida Filho <wedsonaf@gmail.com>,
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
Subject: Re: [RFC PATCH 4/5] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <QqpNcEOxhslSB7-34znxmQK_prPJfe2GT0ejWLesj-Dlse1ueCacbzsJOM0LK3YmgQsUWAR58ZFPPh1MUCliionIXrvLNsOqTS_Ee3bXEuQ=@proton.me>
	(Benno Lossin's message of "Sat, 23 Mar 2024 11:33:26 +0000")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-5-nmi@metaspace.dk>
	<QqpNcEOxhslSB7-34znxmQK_prPJfe2GT0ejWLesj-Dlse1ueCacbzsJOM0LK3YmgQsUWAR58ZFPPh1MUCliionIXrvLNsOqTS_Ee3bXEuQ=@proton.me>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Tue, 02 Apr 2024 14:52:49 +0200
Message-ID: <87msqc3p0e.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 3/13/24 12:05, Andreas Hindborg wrote:
>> +module! {
>> +    type: NullBlkModule,
>> +    name: "rnull_mod",
>> +    author: "Andreas Hindborg",
>> +    license: "GPL v2",
>> +    params: {
>> +        param_memory_backed: bool {
>> +            default: true,
>> +            permissions: 0,
>> +            description: "Use memory backing",
>> +        },
>> +        // Problems with pin_init when `irq_mode`
>
> Can you elaborate?

I think we discussed this before, but I do not recall what you decided
was the issue.

It is probably easier if you can apply the patches and try to build with
this on top:

diff --git a/drivers/block/rnull.rs b/drivers/block/rnull.rs
index 04bdb6668558..bd089c5e6e89 100644
--- a/drivers/block/rnull.rs
+++ b/drivers/block/rnull.rs
@@ -48,7 +48,7 @@
             description: "Use memory backing",
         },
         // Problems with pin_init when `irq_mode`
-        param_irq_mode: u8 {
+        irq_mode: u8 {
             default: 0,
             permissions: 0,
             description: "IRQ Mode (0: None, 1: Soft, 2: Timer)",
@@ -101,7 +101,7 @@ fn add_disk(tagset: Arc<TagSet<NullBlkDevice>>) -> Result<GenDisk<NullBlkDevice>
         return Err(kernel::error::code::EINVAL);
     }
 
-    let irq_mode = (*param_irq_mode.read()).try_into()?;
+    let irq_mode = (*irq_mode.read()).try_into()?;
 
     let queue_data = Box::pin_init(pin_init!(
         QueueData {

---

There is some kind of name clash issue when using `pin_init!` in the expression on
line 106:

    let queue_data = Box::pin_init(pin_init!(
        QueueData {
            tree <- TreeContainer::new(),
            completion_time_nsec: *param_completion_time_nsec.read(),
            irq_mode,
            memory_backed: *param_memory_backed.read(),
            block_size,
        }
    ))?;

I cannot immediately decipher the error message:

  RUSTC [M] drivers/block/rnull.o
error[E0277]: the trait bound `__rnull_mod_irq_mode: From<u8>` is not satisfied
   --> /home/aeh/src/linux-rust/linux/drivers/block/rnull.rs:104:39
    |
104 |     let irq_mode = (*irq_mode.read()).try_into()?;
    |                                       ^^^^^^^^ the trait `From<u8>` is not implemented for `__rnull_mod_irq_mode`
    |
    = note: required for `u8` to implement `Into<__rnull_mod_irq_mode>`
    = note: required for `__rnull_mod_irq_mode` to implement `TryFrom<u8>`
    = note: required for `u8` to implement `TryInto<__rnull_mod_irq_mode>`

error[E0308]: mismatched types
    --> /home/aeh/src/linux-rust/linux/drivers/block/rnull.rs:106:36
     |
106  |       let queue_data = Box::pin_init(pin_init!(
     |  ____________________________________^
107  | |         QueueData {
108  | |             tree <- TreeContainer::new(),
109  | |             completion_time_nsec: *param_completion_time_nsec.read(),
..    |
113  | |         }
114  | |     ))?;
     | |     ^
     | |     |
     | |_____expected `IRQMode`, found `__rnull_mod_irq_mode`
     |       arguments to this function are incorrect
     |
note: function defined here
    --> /home/aeh/.rustup/toolchains/1.74.1-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/ptr/mod.rs:1365:21
     |
1365 | pub const unsafe fn write<T>(dst: *mut T, src: T) {
     |                     ^^^^^
     = note: this error originates in the macro `$crate::__init_internal` which comes from the expansion of the macro `pin_init` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0308]: mismatched types
   --> /home/aeh/src/linux-rust/linux/drivers/block/rnull.rs:106:36
    |
39  | / module! {
40  | |     type: NullBlkModule,
41  | |     name: "rnull_mod",
42  | |     author: "Andreas Hindborg",
..   |
71  | |     },
72  | | }
    | |_- constant defined here
..
106 |       let queue_data = Box::pin_init(pin_init!(
    |  ____________________________________^
    | |____________________________________|
    | |____________________________________|
    | |____________________________________|
    | |
107 | |         QueueData {
108 | |             tree <- TreeContainer::new(),
109 | |             completion_time_nsec: *param_completion_time_nsec.read(),
..   |
113 | |         }
114 | |     ))?;
    | |     ^
    | |_____|
    | |_____expected `DropGuard<IRQMode>`, found `__rnull_mod_irq_mode`
    | |_____this expression has type `DropGuard<IRQMode>`
    | |_____`irq_mode` is interpreted as a constant, not a new binding
    |       help: introduce a new binding instead: `other_irq_mode`
    |
    = note: expected struct `DropGuard<IRQMode>`
               found struct `__rnull_mod_irq_mode`
    = note: this error originates in the macro `$crate::__init_internal` which comes from the expansion of the macro `pin_init` (in Nightly builds, run with -Z macro-backtrace for more info)

error: aborting due to 3 previous errors

Some errors have detailed explanations: E0277, E0308.
For more information about an error, try `rustc --explain E0277`.
make[5]: *** [/home/aeh/src/linux-rust/linux/scripts/Makefile.build:293: drivers/block/rnull.o] Error 1

