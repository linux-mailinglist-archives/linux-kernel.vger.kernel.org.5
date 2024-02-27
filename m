Return-Path: <linux-kernel+bounces-84073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9933986A1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556122864CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988BB14F98E;
	Tue, 27 Feb 2024 21:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FH8Edpiz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00014E2C6;
	Tue, 27 Feb 2024 21:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070932; cv=none; b=VEE2iu521bJgzDCaUL2LquIPcCHJiCraypBXgh24+KtFtUh0NOz9WzoGgZFRpUgbum254h+xBc5Kvdvq2vGRbqVYV+adns9o76+fiO8mRmVCDQuADZYnBRpLihh3Q46S5m0wJ0ES2RU4mi4bq/Obw+6UdCSEg6I1cCVXiNwLxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070932; c=relaxed/simple;
	bh=e1sJK/J43or4Yn+Tnle7a01Z2cbHcL9R7yNgNSUHEBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBj2VKGaXc078ZuC9TI7cuVtGH0Bzg/7B/qQVGjyia2Yg5m0nT9bPykYl3XF/rrHladQawva8oNXw9lwV6Jqx2Ex7eNgElsWHXSmtwAkdnart66uCyooF/0vQX8tQqQzUttw7BQ/F30w2119vlbfM+w5JNNOKLzh8iKhK6T5di4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FH8Edpiz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709070929;
	bh=e1sJK/J43or4Yn+Tnle7a01Z2cbHcL9R7yNgNSUHEBQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FH8EdpizWvTWeaqEOwangY428L+hYT1Z070TRSxH6anJs/dR81pgF2nqfbwg28C9s
	 /crjsJztYRe/z8qqKuSXtDygARI74dctk8PoBmiVEBQnpkiitQxtKK2+bmTFr4tyu9
	 jb5tZDs0Ll7+y3GVHKUFpOn951iU2n0J0tEO8fSFw7mUdfW1nAArIFF+oop7SCoH42
	 b3ze17aWfvcCFS06DmglKw3VRQNLaYxrFHI+X4sB6ZJYU80TnD/2WU3mLX8iYnjP/g
	 wWx8lx7k6R6mZzackvoIgCPsMrwgNzMdAYBB6uH1Q6PLQ+G5FFSzgkt1laW6OB0KXw
	 1v1VUatgokLhQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9AC183782051;
	Tue, 27 Feb 2024 21:55:26 +0000 (UTC)
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
Subject: [RFC PATCH 0/1] Rewrite the VP9 codec library in Rust
Date: Tue, 27 Feb 2024 18:51:44 -0300
Message-ID: <20240227215146.46487-1-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi everyone,

This patch ports the VP9 library written by Andrzej into Rust as a
proof-of-concept. This is so that we can evaluate the Rust in V4L2 initiative
with source code in hand.

It converts rkvdec and hantro to use the Rust version of the library. These two
were chosen merely because that's the hardware I currently own. Fluster scores
remain the same when using either the Rust or C version. Please test this.

Much has been spoken at various occasions about drivers and I feel that the
consensus is to wait for now. This is why I am proposing a different approach:
porting our codec libraries to Rust.

IMHO, these components can benefit greatly from Rust, as they implement
complicated algorithms that also happen to process data received from userspace
through V4L2 controls. These algorithms use the data received from userspace in
order to index into a lot of arrays and thus benefit from Rust's memory safety.

The first thing about the code is that it does not include any layer of
bindings. This was pointed out as a blocker several times due to the need of
keeping them in sync with the C code.

The Rust code here also offers a C API for C drivers.This C API is
automatically generated by cbindgen and I have provided instructions on how to
do so. We can even use functions from both the C and Rust libraries at the same
time since the ABI is the same.

The above can come in handy because it means that we can convert a given
codebase piece by piece if need be. C drivers will work as usual through the C
API and any new Rust driver will get to benefit from a native Rust interface.

Please take note that most of the code is *not* in the media tree, so I do not
see how this can further stress our subsystem. I take responsibility for
maintaining stuff in rust/kernel/media and honestly, this library will not need
any further updates for the same reason we have never touched its C
counterpart.

I hope to convince the community that this is a feasible way to slowly
experiment with Rust code without tying us up too much to it.

Lastly, please note that this code is just a proof of concept, we can settle on
a proper patch - with all that entails - if it is well received.

Those with hardware can follow the steps below to test this patch:

a) enable Rust (https://www.kernel.org/doc/html/latest/rust/quick-start.html).
Make sure CONFIG_RUST=y.

b) enable one of the converted drivers (CONFIG_VIDEO_HANTRO or
CONFIG_VIDEO_ROCKCHIP_VDEC). This will select V4L2_VP9_RS.

c) download the Fluster tool (https://github.com/fluendo/fluster)

d) download the VP9 test suite from libvpx (fluster.py download VP9-TEST-VECTORS)

e) make sure you have a recent version of GStreamer (`gst-inspect-1.0
v4l2codecs` must not be empty) 

f) run the test suite (fluster.py run -d GStreamer-VP9-V4L2SL-Gst1.0 -ts VP9-TEST-VECTORS)

g) results should be the same both with and without this patch

-- Daniel


Applies on top of:

commit d9c1fae3e5b225f2e45e0bca519f9a2967cd1062
Author: Alice Ryhl <aliceryhl@google.com>
Date:   Fri Feb 9 11:18:22 2024 +0000

    rust: file: add abstraction for `poll_table`




For those looking for a branch instead:

https://gitlab.collabora.com/dwlsalmeida/for-upstream/-/tree/vp9-rs?ref_type=heads


Daniel Almeida (1):
  v4l2-core: rewrite the VP9 library in Rust

 drivers/media/platform/verisilicon/Kconfig    |    2 +-
 .../platform/verisilicon/hantro_g2_vp9_dec.c  |   38 +-
 .../media/platform/verisilicon/hantro_hw.h    |    8 +-
 drivers/media/v4l2-core/Kconfig               |    4 +
 drivers/staging/media/rkvdec/Kconfig          |    2 +-
 drivers/staging/media/rkvdec/rkvdec-vp9.c     |   52 +-
 include/media/v4l2-vp9-rs.h                   |   97 +
 rust/bindings/bindings_helper.h               |    1 +
 rust/kernel/lib.rs                            |    2 +
 rust/kernel/media.rs                          |    5 +
 rust/kernel/media/v4l2_core.rs                |    6 +
 rust/kernel/media/v4l2_core/cbindgen.toml     |   26 +
 rust/kernel/media/v4l2_core/vp9.rs            | 1999 +++++++++++++++++
 13 files changed, 2192 insertions(+), 50 deletions(-)
 create mode 100644 include/media/v4l2-vp9-rs.h
 create mode 100644 rust/kernel/media.rs
 create mode 100644 rust/kernel/media/v4l2_core.rs
 create mode 100644 rust/kernel/media/v4l2_core/cbindgen.toml
 create mode 100644 rust/kernel/media/v4l2_core/vp9.rs

-- 
2.43.0


