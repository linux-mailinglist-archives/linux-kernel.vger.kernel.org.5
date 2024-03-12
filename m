Return-Path: <linux-kernel+bounces-100775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459FA879D19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76ACDB23480
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271DD143747;
	Tue, 12 Mar 2024 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6uwLSAI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A75143732;
	Tue, 12 Mar 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710276691; cv=none; b=PIQiSJodTKFeAlXRr7wASu+8OSuazMw6Xi8sXwmLDEq/92UKY7FyZo7kD+nDlSZfyVZoVeikYRauYySn15d16+EJOpLoaqGjO2ApE5gukpBjFGbRq0Ss34ixjoJmy/zrKnEEjTzX0KjaMoEAOXZXYd3I8pELyCWKw71fQQWu0TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710276691; c=relaxed/simple;
	bh=NdilFZkMwC/3FQbsBc0J7ASCdEIIrYIeoB93By0b0/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P04aQvpGAt/wMIcsWtbumNQz3QfwT9Rz3KHObWMqsNM2adRMN8jJbJWSuePS+oQUiTf51lZNpn0i8O5q0tAKoVUw/6ERS7D5Yv+3/rRnKDaEBHkVf3knpluqgk5eb5QVXz0/4PlbTk0e27S66TJUmeZ2M0/mZmlciBZ40MEDnYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6uwLSAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB2AC43390;
	Tue, 12 Mar 2024 20:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710276690;
	bh=NdilFZkMwC/3FQbsBc0J7ASCdEIIrYIeoB93By0b0/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6uwLSAI/wTeiTurEjYa9J+mqFOwjQkLDGaywtekVKFALwj4dSHyvujVn8AtNvwNU
	 8GvS1Av3gpkXkj1Z1LoCGwd4zM28709anyN6Rn5B66h+Q0tixcr44F9Q3RD6ubT7fz
	 kR1FQ8OD+uILg3nmPYik756FH8bB9gJAsc8axWXng3+CnsSge61BnmV0YJxN+nUNMy
	 xI98Bk410aZUfPzfCx4aQ/sWgmBmrgq7BvcowRnbhuXw1GaQT7aLXbM6oRjSsFfhNP
	 bbdax2BJ4pOjGcAFgUDAbzv9BQ+2fVxZsM+iK4djUtVIup1DH718tDP0/XXqbWCZcZ
	 Zp0yY42XwePKg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/2] perf beauty: Don't include uapi/linux/mount.h, use sys/mount.h instead
Date: Tue, 12 Mar 2024 17:51:11 -0300
Message-ID: <20240312205112.688776-2-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240312205112.688776-1-acme@kernel.org>
References: <20240312205112.688776-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The tools/include/uapi/linux/mount.h file is mostly used for scrapping
defines into id->string tables, this is the only place were it is being
directly used, stop doing so.

Define MOUNT_ATTR_RELATIME and MOUNT_ATTR__ATIME if not available in the
system's headers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fsmount.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/fsmount.c b/tools/perf/trace/beauty/fsmount.c
index 30c8c082a3c3b3b3..28c2c16fc1a80dfd 100644
--- a/tools/perf/trace/beauty/fsmount.c
+++ b/tools/perf/trace/beauty/fsmount.c
@@ -7,7 +7,14 @@
 
 #include "trace/beauty/beauty.h"
 #include <linux/log2.h>
-#include <uapi/linux/mount.h>
+#include <sys/mount.h>
+
+#ifndef MOUNT_ATTR__ATIME
+#define MOUNT_ATTR__ATIME	0x00000070 /* Setting on how atime should be updated */
+#endif
+#ifndef MOUNT_ATTR_RELATIME
+#define MOUNT_ATTR_RELATIME	0x00000000 /* - Update atime relative to mtime/ctime. */
+#endif
 
 static size_t fsmount__scnprintf_attr_flags(unsigned long flags, char *bf, size_t size, bool show_prefix)
 {
-- 
2.43.0


