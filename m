Return-Path: <linux-kernel+bounces-96076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DC8756CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841A81C211D6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD8213665B;
	Thu,  7 Mar 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fj8M2ivZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0144A12FF8C;
	Thu,  7 Mar 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838770; cv=none; b=OGkcaxq24kqxI29s0AAf+De2PprVYiXiMt+pg/29zXcwlqylKEF0bVL8ZFQoJUkVMplYPTDNIusBL2Cf+sclg7boondxw9nMmRm6U0STDOSj63YTDgKbVoj85CdCRjxjjdLcdV1NP0f6MrcvAqc0J1wJojAZvT6fHe6WP00qRgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838770; c=relaxed/simple;
	bh=vJ7LaEt7kyqzJ6o9iMWGsli/kZkXe16BjtgLrXPJV/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlIquDrZ3U1BagQWLAkcYKB/gdgnMZsWyYjNA5zAXJPVeyVDBlZ/WEs2wAfLJjJg6zsudnSyQ5gxB2KyK6v1vgqwCGJ0vw5gWRtOj3tcnoQMDqmTac+Y1jkSksQKNOZLKlyN6nxJ5K1+E+hKzRGPgl+Tm0JDEJjQOGjOHE+TUEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fj8M2ivZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709838767;
	bh=vJ7LaEt7kyqzJ6o9iMWGsli/kZkXe16BjtgLrXPJV/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fj8M2ivZWby4St/DX80CFQWhvBb8XEXsdZXdK+HyzYXLzxoqeUj/F5b0DAXoRFs1C
	 PZL6KI60zJYPQc6qOJ8cPEAH1m7dz9n7sdPYZkU4eegrbPMdkgw/wgs76HiU859JRK
	 iLMTN0mgUtyhYXqvPmJJffk56mwG2sWdexAUIoL75CN5UOZ3SXSqKdZIUOd4sGNT6T
	 OXGKW104wIpAxxC2BdTdUEWEtGfGcrmmnqIX7C3aTfdi/WGSINAPemTqzLOVbuk9SO
	 XZ21Tdp1lUs38FXlSZmL6tH0oA1G2JoeT3zv2DhGQPYpdE+YA3U/XsYTWC5sL/an/e
	 o5whbniC5z57g==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2E8E037802F2;
	Thu,  7 Mar 2024 19:12:43 +0000 (UTC)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: wedsonaf@gmail.com,
	ojeda@kernel.org,
	mchehab@kernel.org,
	hverkuil@xs4all.nl
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com
Subject: [RFC PATCH v2 0/2] Rewrite parts of rkvdec driver and the VP9 codec library in Rust
Date: Thu,  7 Mar 2024 16:08:14 -0300
Message-ID: <20240307190841.10260-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227215146.46487-1-daniel.almeida@collabora.com>
References: <20240227215146.46487-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Mauro, Hans,

While working on v1 for this patchset, I realized that we can go further by
converting the error-prone sections of our codec drivers to Rust. This also
does not need any bindings in order to work.

As yet another proof-of-concept, I have converted parts of the rkvdec driver.
Refer to instructions in v1 to test this.

Notice how:

1) many problematic memcpy's go away, these become a simple assignment in Rust.

2) it can interop seamlessly with the code in rkvdec-vp9.c that was already
converted in v1 of this series.

3) it can use the Rust version of `seg_feat_enabled` directly in vp9.rs, while
also using the C APIs from the v4l2-vp9-rs library in rkvdec-vp9.c

4) more modern things become available for the programmer, like iterators and
their methods without a performance penalty.

I want to propose the following:

Let's merge a non-RFC version of this series and gate it behind some kconfigs
so that we can switch between the C and Rust implementations. Users get the C
version by default, while we continuously test the Rust components on a CI for
a few months. This will hopefully be enough time until the next Media Summit.

My aim is to eventually deprecate the C parts once we're confident that the
Rust code is stable enough. I will keep my own tree, and send PRs to the media
tree if a rebase or fix is needed.

I believe this will not be disruptive nor require any extra work from anyone
but me.

-- Daniel


Again, applies on top of:

commit d9c1fae3e5b225f2e45e0bca519f9a2967cd1062
Author: Alice Ryhl <aliceryhl@google.com>
Date:   Fri Feb 9 11:18:22 2024 +0000

    rust: file: add abstraction for `poll_table`

For those looking for a branch instead: https://gitlab.collabora.com/dwlsalmeida/for-upstream/-/tree/vp9-rs-rkvdec?ref_type=heads

Daniel Almeida (2):
  v4l2-core: rewrite the VP9 library in Rust
  media: rkvdec: rewrite parts of the driver in Rust

 drivers/media/platform/verisilicon/Kconfig    |    2 +-
 .../platform/verisilicon/hantro_g2_vp9_dec.c  |   38 +-
 .../media/platform/verisilicon/hantro_hw.h    |    8 +-
 drivers/media/v4l2-core/Kconfig               |    5 +
 drivers/staging/media/rkvdec/Kconfig          |    3 +-
 drivers/staging/media/rkvdec/Makefile         |    2 +-
 drivers/staging/media/rkvdec/cbindgen.toml    |   36 +
 drivers/staging/media/rkvdec/common.rs        |   19 +
 drivers/staging/media/rkvdec/regs.rs          |  237 ++
 drivers/staging/media/rkvdec/rkvdec-vp9.c     |  607 +----
 drivers/staging/media/rkvdec/rkvdec_rs.h      |  125 +
 drivers/staging/media/rkvdec/rkvdec_rs.rs     |   14 +
 drivers/staging/media/rkvdec/vp9.rs           |  636 +++++
 include/media/v4l2-vp9-rs.h                   |   99 +
 rust/bindings/bindings_helper.h               |    1 +
 rust/helpers.c                                |    7 +
 rust/kernel/lib.rs                            |    2 +
 rust/kernel/media.rs                          |    5 +
 rust/kernel/media/v4l2_core.rs                |    6 +
 rust/kernel/media/v4l2_core/cbindgen.toml     |   26 +
 rust/kernel/media/v4l2_core/vp9.rs            | 2053 +++++++++++++++++
 21 files changed, 3415 insertions(+), 516 deletions(-)
 create mode 100644 drivers/staging/media/rkvdec/cbindgen.toml
 create mode 100644 drivers/staging/media/rkvdec/common.rs
 create mode 100644 drivers/staging/media/rkvdec/regs.rs
 create mode 100644 drivers/staging/media/rkvdec/rkvdec_rs.h
 create mode 100644 drivers/staging/media/rkvdec/rkvdec_rs.rs
 create mode 100644 drivers/staging/media/rkvdec/vp9.rs
 create mode 100644 include/media/v4l2-vp9-rs.h
 create mode 100644 rust/kernel/media.rs
 create mode 100644 rust/kernel/media/v4l2_core.rs
 create mode 100644 rust/kernel/media/v4l2_core/cbindgen.toml
 create mode 100644 rust/kernel/media/v4l2_core/vp9.rs

-- 
2.43.0


