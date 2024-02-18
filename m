Return-Path: <linux-kernel+bounces-70557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D265F859926
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A74BB20F98
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502AF71B41;
	Sun, 18 Feb 2024 19:51:34 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF3D6F530
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708285893; cv=none; b=spLt8+qzkw7nU0ajhM/qnBb6H1X7wvRX8v5c9ucT1TJNdWlHLX4Jjj2fzMzuxUbuEOPL46ivHnDGu4ZwntL+Z9Xa24FK6vJ/r9LMpfbs2P0n569N5o2DZ/tHN5q0XvcOoyyimgjomdzjEYJoj0JxyutjSFsS5u3YBOr0p0pThwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708285893; c=relaxed/simple;
	bh=NCTX0VU3c7uspprCV+2aXLrCV3/0rWtBzeXwFk/kFIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bw+44OnQdJbYPwLNjvoftWN2A8Tr0jyMrkYVICd/VODm6wzcHuXJIo/xD6BMk8CmidoJHWFXXFOZzgahEgmks5J6UVi76024yc+vi9KWG3lx5kXcblv6LI51R14BezqdlrpVVx3EgNqMWR2WJz1vkAVDggV4A4k2cCrGBnQj0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from lindsay.fibertel.com.ar
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sun, 18 Feb 2024 19:51:29 +0000
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 0/4] Misc fixes for strlcpy() and strlcat()
Date: Sun, 18 Feb 2024 16:51:02 -0300
Message-ID: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As requested by Willy and Thomas[1], here go some more fixes and tests for
strlcpy() and strlcat().

The first patch just fixes the compilation when the compiler might replace some
code with its strlen() implementation, which will not be found. Therefore, we
just export it as that can happen also on user-code, outside of nolibc.

The rest of the commits:
	* Fix the return code of both functions
	* Make sure to always null-terminate the dst buffer
	* Honor the size parameter as documented
	* Add tests for both functions

All has been checked against the corresponding libbsd implementation[2].

Let me know what you think 🙂

---
Changes from v2:
 * Add v3 to the subject, previously I wasn't using v<revision>
 * Make strlcat() and strlcpy() have a shorter size when compiled
 * Make src and dst buffer sizes different in test and add trailing chars, so we
   can easily detect more bugs.

[1]: https://lore.kernel.org/all/9538a8fe-b92f-42a5-99d1-25969cf51647@sdfg.com.ar/
[2]: https://gitlab.freedesktop.org/libbsd/libbsd.git


Rodrigo Campos (4):
  tools/nolibc/string: export strlen()
  tools/nolibc: Fix strlcat() return code and size usage
  tools/nolibc: Fix strlcpy() return code and size usage
  selftests/nolibc: Add tests for strlcat() and strlcpy()

 tools/include/nolibc/string.h                | 47 ++++++++++++--------
 tools/testing/selftests/nolibc/nolibc-test.c | 40 +++++++++++++++++
 2 files changed, 69 insertions(+), 18 deletions(-)

-- 
2.43.0


