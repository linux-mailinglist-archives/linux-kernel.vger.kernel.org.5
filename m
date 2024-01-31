Return-Path: <linux-kernel+bounces-47065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561F8448C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384291C2317B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5212BF1A;
	Wed, 31 Jan 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSYEa0HD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A2405FD;
	Wed, 31 Jan 2024 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706732649; cv=none; b=P/pXmIc5LuyTgQOzb2sZwva4gIZQg7Cd0ksHCuAISQ0P3/3v6Nj0TlzVy9S/jiLONiuPExPk0c60fM+kBKs0A3B+omJy3/Qtsh2HHSYea/QF21N1XR6cRl5VKMfvPZwn1xAk6HJ1KSCofvAW2gKeNl2+YGkVN98rYYeckiv9yeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706732649; c=relaxed/simple;
	bh=7+HfyhzzCkGim8Q92q/WPjGDaBB/DO24UGQTf2LaIQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXAZc8bEKf65Cy/gOnmm2n7ccDl4mqs1t6pL0WVBpepPwM8sj/YtRI9utRB76gmJV/hOdyLE1g/rLGzO5PVF0zvGVPpZA7RtSDEQEv+YSg4SzjGERi901SN0Ej8bAg0vakj9j7AETE3ZbVvJ0naMtKQvOrVhWUoTF9vnthTXmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSYEa0HD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1C33C43394;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706732648;
	bh=7+HfyhzzCkGim8Q92q/WPjGDaBB/DO24UGQTf2LaIQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZSYEa0HDHmlAX4RfR0TPN42+rM0RHSUisBaQruyPofDeVyY46LsD0wbAzS1oc05Hi
	 8srel8f/3fpc7p+c1S21+O0XLhH0kOyBK9tEdY3eUxAepvrkluZ7PVslwHHxp5xt7E
	 o3Us+TH8H7cwIgNke7oi3Fx87Oe35g3Bt5/06EhmOCjDpQO5YOJ2YvrmfG4e+Au7Vm
	 /ac33OaEtoBMOq1oInW4SeOUwAU494ZlbNS4K2T86pggZ9dTAk+fSfQ1PAQ/bTbF8q
	 KIxQMu3ITLNddY8fmC99vBEtO5sEbVTKMWTOaYrd6iaU9gOMZkpMLaYOXlG2f7W/h6
	 yIF5U0evb/NfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8159C47DB3;
	Wed, 31 Jan 2024 20:24:08 +0000 (UTC)
From: Valentin Obst via B4 Relay <devnull+kernel.valentinobst.de@kernel.org>
Date: Wed, 31 Jan 2024 21:23:24 +0100
Subject: [PATCH v3 02/12] rust: error: improve unsafe code in example
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-doc-fixes-v3-v3-2-0c8af94ed7de@valentinobst.de>
References: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
In-Reply-To: <20240131-doc-fixes-v3-v3-0-0c8af94ed7de@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Wedson Almeida Filho <wedsonaf@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@samsung.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Valentin Obst <kernel@valentinobst.de>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706732646; l=1327;
 i=kernel@valentinobst.de; s=20240131; h=from:subject:message-id;
 bh=6+MgMwYSzO387ZH/l2u1ebga1PIh0bS6tqLpjrjT2uo=;
 b=Z/KZuTuucZxrwSZ2hrvH8wBevQGTrKv8ViFSulOXQ1vFBR+NAq8VtP/cKqkH5mqutwRli950E
 awsD2FxX7uKDb2cDfX6wfRCyUn4Pjr4siGeIBadFu//Jic/rXph6dUM
X-Developer-Key: i=kernel@valentinobst.de; a=ed25519;
 pk=3s7U8y0mqkaiurgHSQQTYWOo2tw5HgzCg5vnJVfw37Y=
X-Endpoint-Received:
 by B4 Relay for kernel@valentinobst.de/20240131 with auth_id=124
X-Original-From: Valentin Obst <kernel@valentinobst.de>
Reply-To: <kernel@valentinobst.de>

From: Valentin Obst <kernel@valentinobst.de>

The `from_err_ptr` function is safe. There is no need for the call to it
to be inside the unsafe block.

Reword the SAFETY comment to provide a better justification of why the
FFI call is safe.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/error.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4f0c1edd63b7..4786d3ee1e92 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -264,13 +264,9 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 ///     pdev: &mut PlatformDevice,
 ///     index: u32,
 /// ) -> Result<*mut core::ffi::c_void> {
-///     // SAFETY: FFI call.
-///     unsafe {
-///         from_err_ptr(bindings::devm_platform_ioremap_resource(
-///             pdev.to_ptr(),
-///             index,
-///         ))
-///     }
+///     // SAFETY: `pdev` points to a valid platform device. There are no safety requirements
+///     // on `index`.
+///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
 /// }
 /// ```
 // TODO: Remove `dead_code` marker once an in-kernel client is available.

-- 
2.43.0


