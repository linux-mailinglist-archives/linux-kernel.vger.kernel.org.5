Return-Path: <linux-kernel+bounces-41724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A283F704
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58001B20E10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF05B5D5;
	Sun, 28 Jan 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMd1n2MC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841AB5B5BA;
	Sun, 28 Jan 2024 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458401; cv=none; b=J5PW0NLzNRwGExq1BLxFN7g4uDkIFVf9X1xb9i+iSlcbAOkPryqH0ycMvXDNV6Vkj+fzuLLzl9+BtMpP9iEPZ90mn9uVp0+XRVmuxkmhPWXXiQhCllmrEMJphC6euXaHZIhH77RLnmkVruZjYqQgw/KLqUGUEMvweCTTo1BhwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458401; c=relaxed/simple;
	bh=Fqc/uo6ExpDJaHd6Xd6fzWxlrwxDk6ABwIiIkzcrpsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sa7O9U9DFucV0au3LWJXgS6G9G8PuiYy1N8c6QS348TKQAqIrGHRFUcL4coVkrfy6YwnAWBRxShKD9RpmRqyzulP5cBvrBZ41UR2MDsQFQ+ToJQRJhwdsHNaHx8SS80u60yM6AhiHoO8DnTH+c2AgeqeltTwsEuoSPu6HKYZegI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMd1n2MC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36543C43394;
	Sun, 28 Jan 2024 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458401;
	bh=Fqc/uo6ExpDJaHd6Xd6fzWxlrwxDk6ABwIiIkzcrpsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMd1n2MCLcuFq854pS6dBYOQqahwr2XLpJtfMtWirSi4PgqKz5QLrfKQzHmYPmKbY
	 QfbC2L9FzXqUKyi2ZJ8rV9KzU2+s2a9q3Vqhm6XyeiJTsOAre3Cdw3j9cMoZ/2u+Hb
	 Qn/dEEGDaUht3c+rVg3mio1v9BNjxi0M6l82xDxIVdqFDJxQj8pmnFF0ONa/aQAHOR
	 0aIXd09np88fr6wYdbeJa0mc8+JzDYUkJpsm7TIK5sF4L+8i6L4N5Vpf8dtqIXewcw
	 T7Ambf1zUV8wLU8zTT7r243fUNxm9b3/wFMPNhworTw8oKJPAy8LB//VybaG1mDexu
	 xm+JGiuJQJQ/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	Leo Yan <leo.yan@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 03/31] perf cs-etm: Bump minimum OpenCSD version to ensure a bugfix is present
Date: Sun, 28 Jan 2024 11:12:33 -0500
Message-ID: <20240128161315.201999-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

[ Upstream commit 2dbba30fd69b604802a9535b74bddb5bcca23793 ]

Since commit d927ef5004ef ("perf cs-etm: Add exception level consistency
check"), the exception that was added to Perf will be triggered unless
the following bugfix from OpenCSD is present:

 - _Version 1.2.1_:
  - __Bugfix__:
    ETM4x / ETE - output of context elements to client can in some
    circumstances be delayed until after subsequent atoms have been
    processed leading to incorrect memory decode access via the client
    callbacks. Fixed to flush context elements immediately they are
    committed.

Rather than remove the assert and silently fail, just increase the
minimum version requirement to avoid hard to debug issues and
regressions.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20230901133716.677499-1-james.clark@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/build/feature/test-libopencsd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
index eb6303ff446e..4cfcef9da3e4 100644
--- a/tools/build/feature/test-libopencsd.c
+++ b/tools/build/feature/test-libopencsd.c
@@ -4,9 +4,9 @@
 /*
  * Check OpenCSD library version is sufficient to provide required features
  */
-#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
+#define OCSD_MIN_VER ((1 << 16) | (2 << 8) | (1))
 #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
-#error "OpenCSD >= 1.1.1 is required"
+#error "OpenCSD >= 1.2.1 is required"
 #endif
 
 int main(void)
-- 
2.43.0


