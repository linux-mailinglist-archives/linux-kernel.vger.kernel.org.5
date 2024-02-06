Return-Path: <linux-kernel+bounces-54736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17AC84B30C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196701C21D7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415512E1E9;
	Tue,  6 Feb 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMKCcY2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFFF58131;
	Tue,  6 Feb 2024 11:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217543; cv=none; b=MX3MVpNOwHOzYUQZb/HJBUN1U3p5tu92yHQj5GX6LZF0Ogy0XJRDdt6i0CBm/BtoBp2G9HrlWgFBf3so7kEr2VNas+xj+1fFEZ5PxCLBAM5tp9jrbpbLMvYEIYg1burYVakVJI38pslEvJL6SObgv10KKu+17hwYTnE3mhiql54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217543; c=relaxed/simple;
	bh=+sKgZu/0veJ04OfVo0LEnmbeU//UnOnHzs1l4gtuKKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbJKf0kDSjUqLXoiwwn3lKYpsOFHFUTZypVg1j2Sb+Vp1kszj8PJUPnCZZt70PtNJkqK0e7jJC3zAM/7Bkd/f3ltGP1c3t6O/SMbGDLVOC6HL7goKoF9xHf6p8fBnohK+rxlND1y4tyHsPshkxmsH/B/nlFTCy7E9Hq+m5qbHaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMKCcY2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01436C433F1;
	Tue,  6 Feb 2024 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707217542;
	bh=+sKgZu/0veJ04OfVo0LEnmbeU//UnOnHzs1l4gtuKKI=;
	h=From:To:Cc:Subject:Date:From;
	b=HMKCcY2Oh9+Ppy92uBJR6AEmhAkY7UPt3DD4Mgh6W9nSc9s7uX9Q6Ra3Mq/918mzU
	 6xjPoUNnP3iILjMRrokQIIoNlbZ4Hm4wwghuexuUKzFAYnQyJdSvvZljQKzIzcuET/
	 gn0ngDsj+gCML2STgi2TDVmljv8bVZkCmhrBEV05oSn/Y8VuKc04ufvkPLZG+UEite
	 PgjavT8OKptn/obWJ/EW8pR7kng9xVpi1DvrrGyg5m1lT3KX2pZ4knhO8mt7zbq8iD
	 hhb53HtUwDzjjCUQbGz7G3Eitxo3hNvkzinlbJaF+oM2r6OPcBliJSFXC3DEuymIay
	 0mxMNj3wOdY0w==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Donald Zickus <dzickus@redhat.com>,
	stable@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/6] tools: Fix rtla and rv problems (found) with clang
Date: Tue,  6 Feb 2024 12:05:28 +0100
Message-ID: <cover.1707217097.git.bristot@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RHEL people reported some errors when compiling rtla and rv with
clang. The command line used to compile the tools is:

$ make HOSTCC=clang CC=clang LLVM_IAS=1

The first problem is two unsupported flags passed to the compiler:
-ffat-lto-objects and -Wno-maybe-uninitialized. They will be
removed if the compile is clang.

Also, the clang linker does not automatically recognize the
-flto=auto option used at compilation time, so it is explicitly
set.

With the compiler working, it starts pointing to some warnings
and errors about uninitialized variables, variable size, and an
unused function. These problems are also fixed.


Daniel Bristot de Oliveira (6):
  tools/rtla: Fix Makefile compiler options for clang
  tools/rtla: Fix uninitialized bucket/data->bucket_size warning
  tools/rtla: Fix clang warning about mount_point var size
  tools/rtla: Remove unused sched_getattr() function
  tools/rv: Fix Makefile compiler options for clang
  tools/rv: Fix curr_reactor uninitialized variable

 tools/tracing/rtla/Makefile            | 7 ++++++-
 tools/tracing/rtla/src/osnoise_hist.c  | 3 +--
 tools/tracing/rtla/src/timerlat_hist.c | 3 +--
 tools/tracing/rtla/src/utils.c         | 8 +-------
 tools/verification/rv/Makefile         | 7 ++++++-
 tools/verification/rv/src/in_kernel.c  | 2 +-
 6 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.43.0


