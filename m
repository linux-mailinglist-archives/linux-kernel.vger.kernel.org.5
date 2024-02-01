Return-Path: <linux-kernel+bounces-48744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F041846098
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EB3EB2663B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E10585274;
	Thu,  1 Feb 2024 19:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4riNidI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E4084FD3;
	Thu,  1 Feb 2024 19:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706814391; cv=none; b=togpDCXSPCHhSRfIXoXEIDE1GoX0T0xr564zfsSqfCfEoC1mIvqjgxgq//trzy+v9yimSNgwnF5u+z0vX289aU+iFWrKrwfus1+F5YKlwBmKzNmU4+rstHhloolQVChGYAG3V+i6x6Te/Zg7JGh8aQ0McgkQ6bV/uQefq209tfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706814391; c=relaxed/simple;
	bh=UFdbdYDvAPWYwEH4H+sTZoi40RASTnVr7NExWeWKa1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F35IsFe0FsfrYDMQZwrVaXMp1q/CG6+bc6lFDvrSQOusP/tQHomxIFCaWZAUganb8+WOE1b/GWjgB2poGhgy4VHBtZ6FDvxUsE9B3UrQYi6QTXDZI3SFBD8EoY2IFBc92CCxIkS/4cVqnySagta6SaBwif8TDOwIdkaR1lplLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4riNidI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23094C433C7;
	Thu,  1 Feb 2024 19:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706814391;
	bh=UFdbdYDvAPWYwEH4H+sTZoi40RASTnVr7NExWeWKa1U=;
	h=From:To:Cc:Subject:Date:From;
	b=Z4riNidIswR8n6TXHT54Ikr2ScCpXEqZyrIJ8CiRqcwUQ/a+p+xXndyM8Tj2X3W4+
	 vIxSGDhVdiLH7BHuNzT6dcvSpy/SnwWTV2mG7+SueQYA8Kb8fwAxvkU0WW6yR3M79l
	 r2xVdM9/C+bnLoneQj8eFEqhRdaAl+/pONbzRdAKFVDAliTSfmB8iQN2nS9k3lBtVH
	 7TDEpMbrOEza9WYDsqh+Vy5p9LYz1tbOlD5gEKOV+TECRGAbUsBzCByWK60LB3sizx
	 8Vwa2R+j+NbQzt5Jx0yASbufk5vMEKNnNje8hCqGIclhXrjAm/emqmszdHk+XwIHMu
	 VE4nxwhJ5H9Fw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH] workqueue: rust: sync with `WORK_CPU_UNBOUND` change
Date: Thu,  1 Feb 2024 20:06:20 +0100
Message-ID: <20240201190620.18064-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e563d0a7cdc1 ("workqueue: Break up enum definitions and give
names to the types") gives a name to the `enum` where `WORK_CPU_UNBOUND`
was defined, so `bindgen` changes its output from e.g.:

    pub type _bindgen_ty_10 = core::ffi::c_uint;
    pub const WORK_CPU_UNBOUND: _bindgen_ty_10 = 64;

to e.g.:

    pub type wq_misc_consts = core::ffi::c_uint;
    pub const wq_misc_consts_WORK_CPU_UNBOUND: wq_misc_consts = 64;

Thus update Rust's side to match the change (which requires a slight
reformat of the code), fixing the build error.

Closes: https://lore.kernel.org/rust-for-linux/CANiq72=9PZ89bCAVX0ZV4cqrYSLoZWyn-d_K4KpBMHjwUMdC3A@mail.gmail.com/
Fixes: e563d0a7cdc1 ("workqueue: Break up enum definitions and give names to the types")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Tejun: here is the formal patch as you requested. Please feel free to
either take it or to rebase to fix the old commit. Thanks!

 rust/kernel/workqueue.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 498397877376..d00231e18007 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -199,7 +199,11 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
         // stay valid until we call the function pointer in the `work_struct`, so the access is ok.
         unsafe {
             w.__enqueue(move |work_ptr| {
-                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _, queue_ptr, work_ptr)
+                bindings::queue_work_on(
+                    bindings::wq_misc_consts_WORK_CPU_UNBOUND as _,
+                    queue_ptr,
+                    work_ptr,
+                )
             })
         }
     }

base-commit: 15930da42f8981dc42c19038042947b475b19f47
--
2.43.0

