Return-Path: <linux-kernel+bounces-144164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F45E8A4295
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02381C20E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8945BFB;
	Sun, 14 Apr 2024 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raxyte.com header.i=@raxyte.com header.b="pAaePoZO"
Received: from gu.d.sender-sib.com (gu.d.sender-sib.com [77.32.148.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009641A84
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100899; cv=none; b=OgbjsKoh12PeUdEzexw4EtTju4kRIh/xxoOWhJjAPYzmHuxdJTSp6aFLexZqT0r8YjKElMdv8IQClWPcTS/2Nuo86SZi0qh0Q/r39/O2d953nGCnK+aXdCJGkGIae/IT5ieE+cqpoJxc8lBSPpzCwDLYTLnVP+WDHBKpgraWUjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100899; c=relaxed/simple;
	bh=TD6uMI7QAWgg3XSqO08rarrvGml8Sx7m6ell7wkf6CU=;
	h=Date:Subject:Mime-Version:Message-Id:To:From; b=uOYHdjuD0me9p+Z2i3cfb9Okwqtl1+XDg+Z5jgCczNvcbIYjaXo6U9QGaLWgWEPS3NpeZcthAHppBurObQG8tpUehEJHTRDrtiuB9l+RJ0kwnrPiYddLXbX1zDQ36i0aeJ2+uqZ4UuKoInHdoy1hFbpDjltFfVG+udLf10neIDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raxyte.com; spf=pass smtp.mailfrom=gu.d.sender-sib.com; dkim=pass (1024-bit key) header.d=raxyte.com header.i=@raxyte.com header.b=pAaePoZO; arc=none smtp.client-ip=77.32.148.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raxyte.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gu.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raxyte.com;
 q=dns/txt; s=mail; bh=CRndFbjNIKMcK8zR6tbvt/PU4cTYUy67e6MOk0bjXFY=;
 h=from:subject:date:to:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=pAaePoZOskZ9WmQ4QnxPKvkkeS6BJy+KJFQHrN0agCfWt/jKUc2I9adcEsEM32NB+mvU8WW9AVfo
        cmQfP9EOE3cTXI2+HLasz4OpdIZs1hici6RMcc3wuxJk5trW41oy+W4pDzqpXL3GHDZyNNEnE4zt
        NiHMwNO0gJh/HT36XEs=
Received: by smtp-relay.sendinblue.com with ESMTP id ca7b5992-61ae-4353-adcb-f81d7ca12f0d; Sun, 14 April 2024 13:20:26 +0000 (UTC)
X-Mailin-EID: MjY2MTUxODYyfmxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNDE0MTMxOTI4Ljg0NjYyNS0xLWRldkByYXh5dGUuY29tPn5ndS5kLnNlbmRlci1zaWIuY29t
Date: Sun, 14 Apr 2024 18:49:28 +0530
Subject: [PATCH] rust: update `dbg!()` to format column number
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Message-Id: <ca7b5992-61ae-4353-adcb-f81d7ca12f0d@smtp-relay.sendinblue.com>
Origin-messageId: <20240414131928.846625-1-dev@raxyte.com>
To: <ojeda@kernel.org>,<alex.gaynor@gmail.com>,<wedsonaf@gmail.com>,<boqun.feng@gmail.com>,<gary@garyguo.net>,<bjorn3_gh@protonmail.com>,<benno.lossin@proton.me>,<a.hindborg@samsung.com>,<aliceryhl@google.com>,<dev@raxyte.com>,<rust-for-linux@vger.kernel.org>,<linux-kernel@vger.kernel.org>
X-sib-id: tx-3UtHO3ro1AhphuDfZo2H2csw-KDWx18r1_y-zyyD5k6CBR-0p500iirHn-_v0t4umZi7PYt2f15O1HmJwVEJPKp57WmmDcEK1IU68I_hGnw1J8LFCP_QFUKvIklq1W1KzzL4FvIrfFzmiQSjSmNkFuSb_tcqzUNdOpEvMCmWCKCFJ-4XnqmTM
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.22:7517309_-1:7517309:Sendinblue
From: <dev@raxyte.com>

In Rust 1.76.0, the `dbg!()` macro was updated to also format the column
number. The reason cited was usage of a few characters worth of
horizontal space while allowing direct jumps to the source location. [1]

Link: https://github.com/rust-lang/rust/pull/114962 [1]
Link: https://github.com/Rust-for-Linux/linux/issues/1065

Signed-off-by: Raghav Narang <dev@raxyte.com>
---
 Branch rust-next=20

 rust/kernel/std=5Fvendor.rs | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/std=5Fvendor.rs b/rust/kernel/std=5Fvendor.rs
index 388d6a514..39679a960 100644
--- a/rust/kernel/std=5Fvendor.rs
+++ b/rust/kernel/std=5Fvendor.rs
@@ -146,15 +146,16 @@ macro=5Frules! dbg {
     // `$val` expression could be a block (`{ .. }`), in which case the =
`pr=5Finfo!`
     // will be malformed.
     () =3D> {
-        $crate::pr=5Finfo!(=22[{}:{}]\n=22, ::core::file!(), ::core::line!=
())
+        $crate::pr=5Finfo!(=22[{}:{}:{}]\n=22, ::core::file!(), =
::core::line!(), ::core::column!())
     };
     ($val:expr $(,)=3F) =3D> {
         // Use of `match` here is intentional because it affects the =
lifetimes
         // of temporaries - https://stackoverflow.com/a/48732525/1063961
         match $val {
             tmp =3D> {
-                $crate::pr=5Finfo!(=22[{}:{}] {} =3D {:#=3F}\n=22,
-                    ::core::file!(), ::core::line!(), ::core::stringify!=
($val), &tmp);
+                $crate::pr=5Finfo!(=22[{}:{}:{}] {} =3D {:#=3F}\n=22,
+                    ::core::file!(), ::core::line!(), ::core::column!(),
+                    ::core::stringify!($val), &tmp);
                 tmp
             }
         }

base-commit: 8db31d3f3bd5dbc8cf3a22bba04b4b4add7f984e
--=20
2.44.0



