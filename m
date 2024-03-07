Return-Path: <linux-kernel+bounces-96158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BF8757E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68AE7B2438E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D871386BC;
	Thu,  7 Mar 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3AmaXLH4"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003012DDB6;
	Thu,  7 Mar 2024 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841855; cv=none; b=uXR00oY7RH1I5DV5K0XYiZ5Z0v2Rl1o4NI1jDj4kPQ5YJOGM3dm6bAtvM6I9jQIZ/K7KIyd8aJq6V6LAslI9HfF8W09WZErJc3833g5SoDdMYt6RnBOoXdfS2wGDeIbOus43fnm/q+lmR2HbwkXwvO456scBrm/cnLdS3GtUQG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841855; c=relaxed/simple;
	bh=MZVCDWeY67p3xAEfppQ8ZlXuHW8fbkeJZxUBcB3Nxuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7WW4G52vFcatZ0QpYgsgzUBwRYmXnItX9ITvjldrDm2XFsxs5JQ9s9Mb5r24+ypxvdcXCmuLIjen5wX+Jn+/6HAmGSu/z6pLd4XAsh9G7gPxKdEWljCTsuLiLiDVnfP6pD/Q1Cv4DWmoeCgqJrzgEf3zM/lTyzbRROy2begA1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3AmaXLH4; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709841852;
	bh=MZVCDWeY67p3xAEfppQ8ZlXuHW8fbkeJZxUBcB3Nxuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=3AmaXLH4gxhjk6TI1iHnWpL4M/ZYIXT6GXAHObinOQxwYTrK1x8t9DkSroZszS/xL
	 NLzOWz7SyxbQaRzNl86WOqxU4ZssdkE2IewixJ3ck2QHNBf6phPCLGtLIL82iGx6Nj
	 U+JI085IRm/HGeXYpPpXjCyn73ZLPZGw1wQnFDi8zEwFgCYnLswUmSjS/cmIQ97PQB
	 1w3kyaw3mHnTDiZcir8v1sjmGyQ0FyOePtyDeeflUVVutpVlyyUep7jOx6Y/EdyDVk
	 pHu+C8/xX1KilNVdG/XEC03nsFx1v0TguefUYi66PQOpr/R+msDjXXANxZsO1NYFPN
	 4hwvpNsc6qvCQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dbrouwer)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7CB5437810CD;
	Thu,  7 Mar 2024 20:04:11 +0000 (UTC)
Date: Thu, 7 Mar 2024 12:04:09 -0800
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
	hverkuil@xs4all.nl, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [RFC PATCH v2 0/2] Rewrite parts of rkvdec driver and the VP9
 codec library in Rust
Message-ID: <Zeodua65NJpJI1z6@mz550>
References: <20240227215146.46487-1-daniel.almeida@collabora.com>
 <20240307190841.10260-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307190841.10260-1-daniel.almeida@collabora.com>

Hi Daniel,

On Thu, Mar 07, 2024 at 04:08:14PM -0300, Daniel Almeida wrote:
> Hi Mauro, Hans,
> 
> While working on v1 for this patchset, I realized that we can go further by
> converting the error-prone sections of our codec drivers to Rust. This also
> does not need any bindings in order to work.
> 
> As yet another proof-of-concept, I have converted parts of the rkvdec driver.
> Refer to instructions in v1 to test this.

I tested this on rk3399 rkvdec with:
/fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0 -ts VP9-TEST-VECTORS -j1

And I get the same result as on mainline (6.8-rc3)
Ran 220/305 tests successfully               in 913.877 secs

So I can't say I understand all the Rust here but my testing didn't show
any regressions in the VP9 decoding. :)

Deb

> 
> Notice how:
> 
> 1) many problematic memcpy's go away, these become a simple assignment in Rust.
> 
> 2) it can interop seamlessly with the code in rkvdec-vp9.c that was already
> converted in v1 of this series.
> 
> 3) it can use the Rust version of `seg_feat_enabled` directly in vp9.rs, while
> also using the C APIs from the v4l2-vp9-rs library in rkvdec-vp9.c
> 
> 4) more modern things become available for the programmer, like iterators and
> their methods without a performance penalty.
> 
> I want to propose the following:
> 
> Let's merge a non-RFC version of this series and gate it behind some kconfigs
> so that we can switch between the C and Rust implementations. Users get the C
> version by default, while we continuously test the Rust components on a CI for
> a few months. This will hopefully be enough time until the next Media Summit.
> 
> My aim is to eventually deprecate the C parts once we're confident that the
> Rust code is stable enough. I will keep my own tree, and send PRs to the media
> tree if a rebase or fix is needed.
> 
> I believe this will not be disruptive nor require any extra work from anyone
> but me.
> 
> -- Daniel
> 
> 
> Again, applies on top of:
> 
> commit d9c1fae3e5b225f2e45e0bca519f9a2967cd1062
> Author: Alice Ryhl <aliceryhl@google.com>
> Date:   Fri Feb 9 11:18:22 2024 +0000
> 
>     rust: file: add abstraction for `poll_table`
> 
> For those looking for a branch instead: https://gitlab.collabora.com/dwlsalmeida/for-upstream/-/tree/vp9-rs-rkvdec?ref_type=heads
> 
> Daniel Almeida (2):
>   v4l2-core: rewrite the VP9 library in Rust
>   media: rkvdec: rewrite parts of the driver in Rust
> 
>  drivers/media/platform/verisilicon/Kconfig    |    2 +-
>  .../platform/verisilicon/hantro_g2_vp9_dec.c  |   38 +-
>  .../media/platform/verisilicon/hantro_hw.h    |    8 +-
>  drivers/media/v4l2-core/Kconfig               |    5 +
>  drivers/staging/media/rkvdec/Kconfig          |    3 +-
>  drivers/staging/media/rkvdec/Makefile         |    2 +-
>  drivers/staging/media/rkvdec/cbindgen.toml    |   36 +
>  drivers/staging/media/rkvdec/common.rs        |   19 +
>  drivers/staging/media/rkvdec/regs.rs          |  237 ++
>  drivers/staging/media/rkvdec/rkvdec-vp9.c     |  607 +----
>  drivers/staging/media/rkvdec/rkvdec_rs.h      |  125 +
>  drivers/staging/media/rkvdec/rkvdec_rs.rs     |   14 +
>  drivers/staging/media/rkvdec/vp9.rs           |  636 +++++
>  include/media/v4l2-vp9-rs.h                   |   99 +
>  rust/bindings/bindings_helper.h               |    1 +
>  rust/helpers.c                                |    7 +
>  rust/kernel/lib.rs                            |    2 +
>  rust/kernel/media.rs                          |    5 +
>  rust/kernel/media/v4l2_core.rs                |    6 +
>  rust/kernel/media/v4l2_core/cbindgen.toml     |   26 +
>  rust/kernel/media/v4l2_core/vp9.rs            | 2053 +++++++++++++++++
>  21 files changed, 3415 insertions(+), 516 deletions(-)
>  create mode 100644 drivers/staging/media/rkvdec/cbindgen.toml
>  create mode 100644 drivers/staging/media/rkvdec/common.rs
>  create mode 100644 drivers/staging/media/rkvdec/regs.rs
>  create mode 100644 drivers/staging/media/rkvdec/rkvdec_rs.h
>  create mode 100644 drivers/staging/media/rkvdec/rkvdec_rs.rs
>  create mode 100644 drivers/staging/media/rkvdec/vp9.rs
>  create mode 100644 include/media/v4l2-vp9-rs.h
>  create mode 100644 rust/kernel/media.rs
>  create mode 100644 rust/kernel/media/v4l2_core.rs
>  create mode 100644 rust/kernel/media/v4l2_core/cbindgen.toml
>  create mode 100644 rust/kernel/media/v4l2_core/vp9.rs
> 
> -- 
> 2.43.0
> 
> 

