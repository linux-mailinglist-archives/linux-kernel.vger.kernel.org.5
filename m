Return-Path: <linux-kernel+bounces-107773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767A88017B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C18B23D40
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C96823A6;
	Tue, 19 Mar 2024 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT7MUnOa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AAD657D2;
	Tue, 19 Mar 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864481; cv=none; b=fjP5J4xltmpUgSXH/alSrTvw3yy9IJUhydqxvx8Y+sSMbmRGJn/pgGOVYFo73RST6ZclohSGgrkZNCWcrp9qcQIC9EQTpiRSfNZHphRcf58r4DwWqsuZHd6xL3SZecc/FHG4id8KP5MxtZKU6DPIDtwhyj7PgLk02keFtFozZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864481; c=relaxed/simple;
	bh=o/PKCSwUsZmuWmeVx/z89aLoA51oNzjLUoOwlNrR4Q4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BKC7MiosAxwsuQYq9JtrUlkQzTNP9AY77ntRisUR4BqOb44mIJVWczdsw94iIYbpjPrvWSJ/YQSK6sVExpdQovveU55F703otgop8P280vxpbRbecwSv7wo1Ie6Vcl1+xmvZRhyYDKVurCDs7+xIG80j6Sp7JyNpKN6WeJuZySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT7MUnOa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFD1C433F1;
	Tue, 19 Mar 2024 16:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710864480;
	bh=o/PKCSwUsZmuWmeVx/z89aLoA51oNzjLUoOwlNrR4Q4=;
	h=From:Subject:Date:To:Cc:From;
	b=aT7MUnOatlsU3iLFb7x1PFqJgBginmUC4r8wAuI4JKGyjf5QUTcKtSmnaZFHhKFUB
	 7vSTm+NrH/l0L7AYy9oLfOHy1g1FoKKuU1NqBluqPThoXZa/0LKVumIUZnl9GJURRv
	 S0u4FmRxKF5+QjMMePm/WjrNz7bEKTp1KjNnAdec3k+pRBItr+B8sDCSrqDnVTq3PE
	 w8G+WQM/7grQkHMfrEAkfLLHJpBL/5ph7g3NGo1N9vyUzJ2gFHK3r3XeV6Z4+i3ta1
	 ilsZSOnrLDiqQ8+sDFz5CrWusvcc9yDVtfAzQlCkIneJqPtbYHSigV4f5cBelqdKcO
	 gIy/iSgk+j0Qw==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] tracing: Fully silence instance of -Wstring-compare
Date: Tue, 19 Mar 2024 09:07:51 -0700
Message-Id: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFe4+WUC/x2NzQ6CMBAGX4Xs2U1oNSH6KsZDLV9xk1rILv4Qw
 rtTPc4cZlYyqMDo0qykeIvJWCq4Q0PxEcoAlr4y+daf2qM786whShk4vXJe2CSjRPDHZv3ZOD6
 noGB0Dj71rrv7QLU1KZJ8/5/rbdt2MTfEmXcAAAA=
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, ndesaulniers@google.com, 
 morbo@google.com, justinstitt@google.com, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
 Linux Kernel Functional Testing <lkft@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=nathan@kernel.org;
 h=from:subject:message-id; bh=o/PKCSwUsZmuWmeVx/z89aLoA51oNzjLUoOwlNrR4Q4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDKk/d8St4s5M47fmk5Y1C/YxPHX/grao2pZTr+Uj+eP01
 CzOf5DvKGVhEONikBVTZKl+rHrc0HDOWcYbpybBzGFlAhnCwMUpABM5GcHwv3id0tkgheCbM09E
 zom5p8B6Qkz9Pus9yVxDxq2lbDr/gxl+MT/cP819qvZs9okvt4ibCG7j5PF6yZoauOSuvvnz0mc
 zGQA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

This series fully resolves the new instance of -Wstring-compare from
within the __assign_str() macro. The first patch resolves a build
failure with GCC that would be seen with just the second patch applied.
The second patch actually hides the warning.

NOTE: This is based on trace/for-next, which does not contain the
minimum LLVM version bump that occurred later in the current merge
window, so this uses

  __diag_ignore(clang, 11, ...

instead of

  __diag_ignore(clang, 13, ...

which will be required when this is merged into Linus's tree. If you can
base this series on a tree that has the merge commit e5eb28f6d1af ("Merge
tag 'mm-nonmm-stable-2024-03-14-09-36' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm") in it, then that
change can be done at application time, rather than merge time (or I can
send a v2). It would be really nice for this to make the merge window so
that this warning does not proliferate into other trees that base on
-rc1.

---
Nathan Chancellor (2):
      compiler_types: Ensure __diag_clang() is always available
      tracing: Ignore -Wstring-compare with diagnostic macros

 include/linux/compiler_types.h               | 4 ++++
 include/trace/stages/stage6_event_callback.h | 5 +++++
 2 files changed, 9 insertions(+)
---
base-commit: 7604256cecef34a82333d9f78262d3180f4eb525
change-id: 20240319-tracing-fully-silence-wstring-compare-e71e2fd17b2a

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


