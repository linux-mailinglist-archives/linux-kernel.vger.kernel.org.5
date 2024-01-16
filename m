Return-Path: <linux-kernel+bounces-27554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3782F212
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D901F228C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4815C1CA80;
	Tue, 16 Jan 2024 16:02:55 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025C1C686;
	Tue, 16 Jan 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.245.156.100]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MeToK-1qpL9E40VY-00aWQh; Tue, 16 Jan 2024 17:02:37 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH 02/13] rust: error: move unsafe block into function call
Date: Tue, 16 Jan 2024 17:01:27 +0100
Message-ID: <20240116160141.165951-3-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116160141.165951-1-kernel@valentinobst.de>
References: <20240116160141.165951-1-kernel@valentinobst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8YpdJM1GEeWDxH67CiH/gY2p2t5FekIWFaebx3JG/FApIvD6c+1
 KA1ivQpbnXVGPZeHY18lF7JbGHwSuJRGTYFEfs4t8pO1LTRhw2gArE1+9Nghc4PRRgOns+U
 IQ+7ns++opvOiuh7FmD9yXxaLBMiDMRoWbO0ri95uXOGonyDeAeDsqBN8Oayq0vJd+rqdf9
 Ni4CnrD/TGCtSaogYzKFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vfE4pxrJzRA=;T6tpxL0/72IvcsGh63L8yn0ff9A
 en6NnaOJkZzpWwHGTP1pOi+MM9TVMmCJpOz/NvS6h9DdGFy03ClTT+MorjaXDpdw6NIx4JVlP
 TOT+8ZY8pu/9PPwvsKOtMvzv72GjDAio2dYXQ4el/F+l1RVOnNbGbpWc5tAD8NpMrdW4+IjIw
 98lJzIPkODHjOZ2GC1MflMf+YpcNBQsFQ1ruzzRIAHAC/rLjzXqSXMVCYXtnPeJKaVqIMX6K4
 8xB5zdZHCBLm0cwUFufFVtQU1vWxpGUp1xr8a2CUsdVe6D+QqQVZDHupPYPXL/w9DrnKAHk2g
 eqyque/ZqUQBQ0Q4V26zxjcOW0Ct1nHDrY06SZJ7JhYEKaf7aCE/p9zdxNcywEzXq2p36UKVo
 ItqQa+MwHZbrG6AZreYne3g4JTtkAaC9M4sWMyiFWpKvXe9y54Ituvw3x29n5QZMtNll3Ezge
 aJmBY4XulN5wa+76YGhaXeLmsuU6plPyYWycoBgG8u2NuHmjoGBEVQLEzeZllweWrRSA7/BOq
 WbORVUU/pL461S8YUOrSbwTYqaMEdjPLDLvRQju7qDGf478O8XMC9LW5MPW6/yEJs+I5CuQp1
 HJeax00F/Me8wooTp9AG24DEMVjBINVSxZy/Aco90gowOcNwjG/SAh4siOstSjALc98kIbG2h
 r419+NVaYPMCGcM6nSHcf/5OW59og0kk7HyruPO96KcCyDGy8PKbQIyg0SlDE8K8Fu1ACM5Rp
 vTTfk9dq2KJYjG/PeBxM3CAKHgOwJC9VWvsvujFS6bcPBZ2e19K3AfwqJBDd14XptY7Oiqinl
 OcOZS0NE1nLQe3YtVIbn/KkuaGkc7EqApKXYGscg9nzHTFd/FYGLNCo05DCBs5kw64+BGScW3
 h6skzvWUQCoZaRPif6kgfLjDRyCZuQU5Jgd0=

The `from_err_ptr` function is safe. There is no need for the call to it
to be inside the unsafe block.

Signed-off-by: Valentin Obst <kernel@valentinobst.de>
---
 rust/kernel/error.rs | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4f0c1edd63b7..6f6676bc0eb9 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -265,12 +265,7 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
 ///     index: u32,
 /// ) -> Result<*mut core::ffi::c_void> {
 ///     // SAFETY: FFI call.
-///     unsafe {
-///         from_err_ptr(bindings::devm_platform_ioremap_resource(
-///             pdev.to_ptr(),
-///             index,
-///         ))
-///     }
+///     from_err_ptr(unsafe { bindings::devm_platform_ioremap_resource(pdev.to_ptr(), index) })
 /// }
 /// ```
 // TODO: Remove `dead_code` marker once an in-kernel client is available.
-- 
2.43.0


