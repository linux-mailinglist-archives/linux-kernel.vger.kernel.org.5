Return-Path: <linux-kernel+bounces-127274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DF9894912
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C0C2814A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE855DDBE;
	Tue,  2 Apr 2024 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="IPXuw3Cr"
Received: from mr85p00im-zteg06022001.me.com (mr85p00im-zteg06022001.me.com [17.58.23.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E4D266
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712023093; cv=none; b=M77sAI3utPMrLHI7345PNGKDs6vrP1QnYL02j7DHYZ5UxezZw0Q3GOseK/VxrBsEr5QP0ZIFRHf6GpNKm1NdpjDo21tMXl/K/OCxZfrslz3SrDRSsHXG5nzUaS+bVSs/PWQnDt4VKFvW851sntzfYIRWchBoeMGt5mRbgPRGXdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712023093; c=relaxed/simple;
	bh=1RBSArEh8QGS05qLQAF1bGlFe1GjdQ5kjRKn/c7EPbc=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=A3mDHwNB2+ENsAxefDZqSl1Ii6SSH2hdx/jkNVGyhz6Mgn7AjA6+JUrtyaz9uWsr5cdOU3hIWDdsfbkkR3Clvd9CRN0eBpNH3lqjRhbZGvJG1Me9GkUTpfJ+NKPVkJVhgQ76RkPGTvTT75WjWEzweeH7gdRwWhgTu3jlJkuZi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=IPXuw3Cr; arc=none smtp.client-ip=17.58.23.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1712023091; bh=VJTsiH9hzGke4ec1DRPBlbL42vpED1MZbRrX3/FC3XY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
	b=IPXuw3CrtqIbc93AmmMCGdeTobpF2A4lQqsUc0+Z+37VR4G/g4BEDvkeATXlj6Quu
	 61GUnzU3NL+KKHqhoLFLHkP8oB73lii+mdEUX+/keiUXh8P+FIetYa8UrPnrgmQIOR
	 N1Hvhy7V2Enuo3984Q8umRooRYMgY0IJ7rUYMrSkaU4/6DKBOrf2Fn+fChM+82HOXR
	 IfTqsQWx0D39lSICp6K7Visd3AzSMKb257frpDCfNgUZo9lzIFFYt2e0EFlpyfotF0
	 u50oWX1VkKMb2Uk+JQaVHrlPgxcCtRre3E/onk8SrETlKlF8WdPRYtbqGk4rb+Jbq2
	 oFoDkQFffWT+A==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06022001.me.com (Postfix) with ESMTPSA id C64FC80047F;
	Tue,  2 Apr 2024 01:58:08 +0000 (UTC)
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
Subject: [PATCH v3] rust: init: remove impl Zeroable for Infallible
Message-Id: <98DBB275-AEA9-4B1A-94B0-99C01BD3BE50@me.com>
Date: Mon, 1 Apr 2024 18:57:57 -0700
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
X-Proofpoint-GUID: 3EyoHJIVdC84T1iLmPQtLn2XKNambtFs
X-Proofpoint-ORIG-GUID: 3EyoHJIVdC84T1iLmPQtLn2XKNambtFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_18,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2404020013

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
---
V2 -> V3: Email formatting correction.
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

    // SAFETY: Type is allowed to take any value, including all zeros.
    {<T>} MaybeUninit<T>,
--=20
2.44.0=

