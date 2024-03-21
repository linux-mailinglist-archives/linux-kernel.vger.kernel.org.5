Return-Path: <linux-kernel+bounces-110292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD0B885CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2947F1C22BC4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70012BF2C;
	Thu, 21 Mar 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5KcVdIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D61E12BF1C;
	Thu, 21 Mar 2024 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036922; cv=none; b=T2L4+JV9863mdriwJX4D/o5AW8ocOciqnbEZvWTcIz5RDsf7/F5XISuUPp/XifLoJcLxLQugpCdYnzPLkNnl0DLNUSr4er8Xk6Xl7S8dZr4l8m0Bv8GcONmIJqzELSk6WQQwr8mCsyY6KbghKszImkr1knaLtiWh+HNfnNS5tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036922; c=relaxed/simple;
	bh=zw11YjpMl3FoiTr/2sFaVVMvcMLI7sst8F38+AzzMmg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LTeX1UJ3J3VWC+SPLjEVz/2fMh8zs4Y/QPd0L4bFjhWKYTt8ZxQvecoMoBxCrr2UL+C3kSPXTjQPI78LJO/wyTK+zxYPcYItQ+TEoEiLSbIGA6fWcZJzEuwXH6U3zf1HENlK2hqpINiQYHWS4ztzgYGK+zziUdryBGUwZNzaugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5KcVdIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CDAC433C7;
	Thu, 21 Mar 2024 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711036922;
	bh=zw11YjpMl3FoiTr/2sFaVVMvcMLI7sst8F38+AzzMmg=;
	h=Date:From:To:Cc:Subject:From;
	b=Z5KcVdIb2aD4AR5R8XnG1HAFcm60tL4tdGJz7G0+V7OlqX8VdLVpnJMKkg8Qz5Sp5
	 agbUUp5mZfM/ngmwEIQY0/SqjeuVmtoT7hX9SqlygYgNTYRtwU9xRKLsQx6CNcFyOX
	 r5djo+RCIO02U70rI4B2ILVI/n2TGUublGv2Eilm1D64aiOkOXfpNvS8EZmteKyuVA
	 wI6RN8v61GWE3e59yk2VjOhDvfL+S8vPl5T0k7gR+8gCcWlHDJCydGn3NxhF9tsR/f
	 Gx4C7KYyUC6AFE2dzdaWtAz5hb+LYnC9lX/MaujNVtIP56dVu1M+r4v5LSNiId2biC
	 v10cXgp4svtZw==
Date: Thu, 21 Mar 2024 13:01:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] libbpf: Define MFD_CLOEXEC if not available
Message-ID: <ZfxZ9nCyKvwmpKkE@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since its going directly to the syscall to avoid not having
memfd_create() available in some systems, do the same for its
MFD_CLOEXEC flags, defining it if not available.

This fixes the build in those systems, noticed while building perf on a
set of build containers.

Fixes: 9fa5e1a180aa639f ("libbpf: Call memfd_create() syscall directly")
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index efab29b8935bd9f7..635a38c6f947a34d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1650,6 +1650,10 @@ static int sys_memfd_create(const char *name, unsigned flags)
 	return syscall(__NR_memfd_create, name, flags);
 }
 
+#ifndef MFD_CLOEXEC
+#define MFD_CLOEXEC 0x0001U
+#endif
+
 static int create_placeholder_fd(void)
 {
 	int fd;
-- 
2.44.0


