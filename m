Return-Path: <linux-kernel+bounces-127270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F80894906
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04663281B0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E2FDDA9;
	Tue,  2 Apr 2024 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="DtY4M0Vu"
Received: from mr85p00im-ztdg06021101.me.com (mr85p00im-ztdg06021101.me.com [17.58.23.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F30BA2D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022827; cv=none; b=Rsr4lAR7CqEN2JuOsb/p3HMzvb1vDJw0I1IYhoOFETek0KQBFX6xKdblwxlljTCEJgzLtMs4Z0Qt9JqiC4I5Q4SIk88NC0fnk0peeV9gPJJHJY7/eZWt8ned7WvUzssFsfhpjIQ5gh1o3AjZjM3+ybn32atFWqysT7/GDy8NfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022827; c=relaxed/simple;
	bh=xo0xyMSV0jNOIMVjhXr3ayA4jB+lb62eMckivVCAKgU=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=oa5X+ugir6NJRLX3YL+7ltca0gydPFYI2u48d34KiJOWlmY4Ip/eMA3gL1WxB2vNFam2qQ+nC5IuXhq7FZMdybDHGs0tsuIJyF96eNa8F1ssjSvW+HGf8bQxCZX+ekmQyn211cYSYtOFWE1onvYuLdOSKFgkHdVhnPYtjmVbBUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=DtY4M0Vu; arc=none smtp.client-ip=17.58.23.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1712022825; bh=a9BDp/1jjLjWeDQ44X53i+aMmbsiLzmj4SIBII6L6qg=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=DtY4M0VuaqJ1HkCHLKbouGac6BCyQWa/zlBPxDWcwDdae9XCXKlvcOKfQKL+ZkSFa
	 uaFSu4mEDEsGF/b0vo3o+lx1rvxb7SB8XOKbviH561lsFTU33BiPKCHVpaLllJkcGK
	 MsBHi61BRad+4kKh3CAPfBnFsk5DN2xeQa1L4xkUeSfr7t71saj9aXZK7fTQFnPhNI
	 mXrVirKYD3e3pjMuu6IsYTB7K9k7KQGN7MW9UJab2hEzDHMLC5PlDnbuQx5bvMF7/M
	 gYN8+/xT8pYoYsOakKsxa7kBnUXGoFIbz2LRhjIOST/L88EfjTExxx05Y+YaRpcuj/
	 qEC388jsoUwnQ==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06021101.me.com (Postfix) with ESMTPSA id 55F1F802E7;
	Tue,  2 Apr 2024 01:53:43 +0000 (UTC)
From: Laine Taffin Altman <alexanderaltman@me.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: [PATCH v2] rust: init: remove impl Zeroable for Infallible
Message-Id: <9D0C95D2-6239-4A3B-B9DD-66299B9911EF@me.com>
Date: Mon, 1 Apr 2024 18:53:31 -0700
Cc: Laine Taffin Altman <alexanderaltman@me.com>,
 stable@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 lkml <linux-kernel@vger.kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: Apple Mail (2.3774.500.171.1.1)
X-Proofpoint-GUID: DYwoeEeKxN9Zee3bPJz-tAkjniafdXqO
X-Proofpoint-ORIG-GUID: DYwoeEeKxN9Zee3bPJz-tAkjniafdXqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2404020012

A type is inhabited if at least one valid value of that type exists; a =
type is uninhabited if no valid values of that type exist.  The terms =
"inhabited" and "uninhabited" in this sense originate in type theory, a =
branch of mathematics.

In Rust, producing an invalid value of any type is immediate undefined =
behavior (UB); this includes via zeroing memory.  Therefore, since an =
uninhabited type has no valid values, producing any values at all for it =
is UB.

The Rust standard library type `core::convert::Infallible` is =
uninhabited, by virtue of having been declared as an enum with no cases, =
which always produces uninhabited types in Rust.

The current kernel code allows this UB to be triggered, for example by =
code like:
`pr_info!("{}=E2=80=9D, =
Box::<core::convert::Infallible>::init(kernel::init::zeroed())?);`

Thus, remove the implementation of `Zeroable` for `Infallible`, thereby =
avoiding the UB.

Cc: stable@vger.kernel.org
Fixes: 38cde0bd7b67 ("rust: init: add `Zeroable` trait and =
`init::zeroed` function")
Closes: https://github.com/Rust-for-Linux/pinned-init/pull/13
Signed-off-by: Laine Taffin Altman <alexanderaltman@me.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
=E2=80=94
V1 -> V2: Added more documentation to the comment, with links; also =
added more details to the commit message.

 rust/kernel/init.rs | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..9353c9919fd4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1292,8 +1292,11 @@ macro_rules! impl_zeroable {
     i8, i16, i32, i64, i128, isize,
     f32, f64,
=20
-    // SAFETY: These are ZSTs, there is nothing to zero.
-    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, =
Infallible, (),
+    // SAFETY: These are inhabited ZSTs; there is nothing to zero and a =
valid value exists.
+    // Note: do not add uninhabited types (such as ! or Infallible) to =
this list; creating an instance of an uninhabited type is immediate =
undefined behavior.
+    // For more on uninhabited/empty types, consult The Rustonomicon: =
https://doc.rust-lang.org/stable/nomicon/exotic-sizes.html#empty-types
+    // The Rust Reference also has information on undefined behavior: =
https://doc.rust-lang.org/stable/reference/behavior-considered-undefined.h=
tml
+    {<T: ?Sized>} PhantomData<T>, core::marker::PhantomPinned, (),
=20
     // SAFETY: Type is allowed to take any value, including all zeros.
     {<T>} MaybeUninit<T>,
--=20
2.44.0=

