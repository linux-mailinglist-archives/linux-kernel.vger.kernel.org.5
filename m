Return-Path: <linux-kernel+bounces-124463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B549F891866
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2F0284AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B318563E;
	Fri, 29 Mar 2024 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="r8CbGAaL"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E487F4084D;
	Fri, 29 Mar 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714265; cv=none; b=jtA77TP4qXTsSzAucVHxMXX8G3g2ZciMZjgjRrr8PvB0HoP44zKcA1+lOmI3to3KdXByUZaopHT3EYc8fOoOSPJ4JAAmFpqqExbT1PeFGKWTjT1nO0SjPH3FLOFPLsWfVBKz6JCAq5w210m5lV/5jwCmtggpIrmDlp5dDPvlXK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714265; c=relaxed/simple;
	bh=R0qWopgaQHnime/JYViBEL3nxwtbS7LVyyyHiE1H22s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvQsx4ImnbrCgvTsVuvtXQaCi0gDnoFZ5zgVPF29YMAXf81KYUNzF7WEIU3+OY9nraJyywtbPJSif3bo7KMK6ESABWWRIhUOaogs5zw76Fdx+3tUyBdgpRIzjiCxZWHppVDgP0lqk9ci4RYT7BcUiC9wGZCSgL2l8DPd/EkcMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=r8CbGAaL; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1711714237; x=1712319037; i=kernel@valentinobst.de;
	bh=vKMrS23EYhu4oq51QI5Yk7mHTfQmIj1rr6qkWVwEFL8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=r8CbGAaLfUvAoBEm8E0RvDI8T8z+RDCJF+jRV3eioOKpQvouqsUTibi0Sup0Z7U6
	 m9ZouPf4Aq1G6QyCQW4ClAwtQIOB23Z3cRTTiPWF6ILLyFzLXmWmOm577xbmGqnmL
	 +JusJh31eNt4yVsMQYUvHXyZ4UxvnEzUyeMnkU0dV4LxXOE/3LVIdM5ZHPAwTVBJ1
	 uOaE/BCLis5eKLnMbat4WJrW9hDvg1/WG3MXbM/4xXPrQdGAWshyPU6yeJtxT1qQ1
	 fJHlpZO+c3rdHV4PzqyLDGgx9VYtgwgxNVjKKHCdg+Z72vDkTd6czieaoyVWdmOEP
	 QX8a0byqbs/5pq1kLQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.fritz.box ([217.249.70.154]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M58zc-1rp4bR1j9g-001BR1; Fri, 29 Mar 2024 13:10:37 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: wedsonaf@gmail.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	walmeida@microsoft.com
Subject: Re: [PATCH v2 0/5] In-place module initialisation
Date: Fri, 29 Mar 2024 13:10:33 +0100
Message-ID: <20240329121033.401403-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328195457.225001-1-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:+fB/8+MWj6qHO/yj86RJMlrpUN2M7GrecYoWh8yRFvw8MLp57dr
 IAIUcL97Qma81IzDG5TCdjHk6YUomez10IDR5K8faDx/Rc/PdUtCJ+wWwAf5vdEH1+RrCHz
 72MD9Iu1FOUi7PgOSS5UPsNSzseBqBci3pTauBurVRF+krWFNEjSwz3fDFr5qI2AC7837EE
 qrjKkfC8pbIUIdHDP85XQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GZ3mcmPnGl8=;i9TJrGnPDlTWlikV5zRua8uI+pV
 9ACvqXgr3w60PfiM9UGAb19wY9f+AN5RwyZpMsIToISicwUbxSRfnxniXjg0nlBMpOmZn5jva
 pO8R8c3/9XBR/LyCOVLR2fnO2BmozrFSEqk11xUbJoORrs9fvtJo4GHjUPjQqHZA9ocFEUpFS
 8mBF3rITI4Az8uN0vlg4ce23Dya2oCM1YTAeeu27t4FyE72RUS8oajprOfMBMgpjOZWbDbuIw
 K+1IU3hoDjHySccJgNojNd6MfFnpgwsQkRXmALqCGl9yFr/K2qp/8M9Q5+VOPni/3AaylCSPm
 DT3bRODzzZ+H3pc8I9pzrDLHnS4Bz9mrXV6tVmrdUPzC+4celkjJt/2w78Xqp8hGWYlXIsHU0
 697jYYQ39pNb4nzTEJDQxErNt/JhqFe1hvEEJ47sFyyVzUnSRvy17Y83/2AyVrwD/67CPYZi8
 fgqP0AIQiYPx/boHzozwn/hn4r2AXFEIxPEAWjsyGOvycLr5JOiabDF7mHgyAbLvx360DyQab
 bNEr0yxs+Aw5s1u0DY1jauWW2jIIQHIxAoI554wxL1PRWdLhVJ82JpeD3ojikp1SizAD3PfK0
 ak2e1decZeE1CiOibh3wCKvmDQ7PJnCeqc+4haTEY/0Yumi8g09gNs0H2x5t2/k9xvgaJCMO3
 3pHaXz9XIionF7cAUxtYZmfRIOQk8dLhOFC/T4UThcLw2emhP6w93Q1gCN0KOhUSuJaYUvYSF
 wu3kFxMwiDiKEZloOHTzYnhiPI+IyCaevvpVlV45ymcYOS9s8EyxzA=

> Introduce `InPlaceModule`, which allows modules to be initialised
> inplace, as opposed to the current state where modules must return an
> instance which is moved to its final memory location.
>
> This allows us to have modules whose state hold objects that must be
> initialised inplace like locks. It also allows us to implement
> registrations (e.g., driver registration) inplace and have them similar
> to their C counterparts where no new allocations are needed.
>
> This is built on top of the allocation APIs because the sample module is
> a modified version of rust_minimal, which would be incompatible with the
> allocation API series because it uses vectors.
>
> ---
>
> Changes in v2:
>
> - Rebased to latest rust-next
> - Split off adding `Send` requirement to `Module` into a separate patch

I think the idea in [1] was to have this patch being included in the
stable trees. I got little experience with stable trees but wouldn't the
easiest way be that you add:

	Cc: stable@vger.kernel.org # 6.8.x: 715dd8950d4e rust: phy: implement `Send` for `Registration`
	Cc: stable@vger.kernel.org
	Fixes: 247b365dc8dc ("rust: add `kernel` crate")

in the sign-off section for this patch? (Or mark the first one for stable
inclusion as well, [2] has more information on that).

	- Best Valentin

[1]: https://lore.kernel.org/rust-for-linux/20240327032337.188938-1-wedsonaf@gmail.com/T/#m4b4daf27038f920a0c6fafff453efb3c8da72067
[2]: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1

> - Prefixed all `core` and `kernel` references with `::` in
>   `module!` macro-generated code.
> - Calling `__pinned_init` with explicit full path.
> - Add `Mutex` to `rust_inplace`  sample.
> - Added `Send` implementation for `Registration` in net/phy.
> - Link to v1: https://lore.kernel.org/rust-for-linux/20240327032337.188938-1-wedsonaf@gmail.com/T/#t
>
> ---
> Wedson Almeida Filho (5):
>   rust: phy: implement `Send` for `Registration`
>   rust: kernel: require `Send` for `Module` implementations
>   rust: module: prefix all module paths with `::`
>   rust: introduce `InPlaceModule`
>   samples: rust: add in-place initialisation sample
>
>  rust/kernel/lib.rs           | 25 +++++++++++++++++++-
>  rust/kernel/net/phy.rs       |  4 ++++
>  rust/macros/module.rs        | 36 ++++++++++++-----------------
>  samples/rust/Kconfig         | 11 +++++++++
>  samples/rust/Makefile        |  1 +
>  samples/rust/rust_inplace.rs | 44 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 99 insertions(+), 22 deletions(-)
>  create mode 100644 samples/rust/rust_inplace.rs
>
>
> base-commit: 453275c66aa4d87c73c5152140b3573ab2435bb7
> --
> 2.34.1

