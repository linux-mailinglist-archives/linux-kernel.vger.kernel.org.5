Return-Path: <linux-kernel+bounces-104910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920C787D59A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41F61C2301C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853F5D8FB;
	Fri, 15 Mar 2024 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be/K8OlJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A45490F;
	Fri, 15 Mar 2024 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535723; cv=none; b=Kra3TRtauxgDn5+hgB5v8vpKvHCPBu6Z+CtKpKfxyqgjjE7R1FVZVIpH/aGtO/02aitAKHReWpQ9gKHJoQqpt5t/2mRa+ixkN4bOkY5g2Su1mcl50y/IiTzKoZCjGPyM3tVEK21vCRCcpeppOkGRAwXbA6UxjLZ+v2hqHQv5fQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535723; c=relaxed/simple;
	bh=n4mnq2bQoZFQmkQWAONSQIZqwOxc8OXB1FXSujoaH0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DnuFnlBOrSOylejir9oHKhvNQgWXbdTuyVT88+9rkdkGxaFHo9csIqdxWoEwaLC4ZnbLiDH/0SDz1DnjwqEgokxQ+687g138qAgP4nqBZyy+E4QSdSGVbo3EvFBllyMNog+R0O3VJxZeySffC6+mHoIc1RBUN62PQvCui8U/d7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be/K8OlJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549E1C43609;
	Fri, 15 Mar 2024 20:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710535723;
	bh=n4mnq2bQoZFQmkQWAONSQIZqwOxc8OXB1FXSujoaH0E=;
	h=From:To:Cc:Subject:Date:From;
	b=be/K8OlJrOmZxrW8MKTT/mLucN1MW1ro91IY2YrOUY9HwEAiwRVe7HGBarsZRcYQC
	 yPq0Y4v/YwRnQVmJm2m469h6ZaxjJg5cU1Fp7q6BSa9p7DKZx1thS3QKI10miTTgC+
	 mrNH3rncE/bP4ug1Odb0mBAN7PaY20Aue7USHCfqjtcDotzBMvf9v9NW04NfJeqM/y
	 /gVTb6RDVCP+G8ofbEOdSfJWgp2dX4QVMV5F6lbOaGeZyFnCsBZ5z8qNaGw97sLHe6
	 KJ0HRTdaACsRRcUWFI28EfBP1ZKWzkKJd0VwsBL25RhmR4FB7Hc2H3+fddh1uoCnZz
	 0oSmW5R1fA0oA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 0/5] move more stuff to trace/beauty
Date: Fri, 15 Mar 2024 17:48:30 -0300
Message-ID: <20240315204835.748716-1-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ian,

	I have those in the tmp.perf-tools-next branch, please take a
look to see if you spot any problem.

Thanks,

- Arnaldo

Arnaldo Carvalho de Melo (5):
  perf beauty: Stop using the copy of uapi/linux/prctl.h
  perf beauty: Move prctl.h files (uapi/linux and x86's) copy out of the
    directory used to build perf
  perf beauty: Use the system linux/fcntl.h instead of a copy from the
    kernel
  tools headers: Remove now unused copies of uapi/{fcntl,openat2}.h and
    asm/fcntl.h
  tools headers: Remove almost unused copy of uapi/stat.h, add few
    conditional defines

 tools/include/uapi/asm-generic/fcntl.h        | 221 ------------------
 tools/include/uapi/linux/fcntl.h              | 123 ----------
 tools/include/uapi/linux/openat2.h            |  43 ----
 tools/include/uapi/linux/stat.h               | 195 ----------------
 tools/perf/Makefile.perf                      |  11 +-
 tools/perf/check-headers.sh                   |   7 +-
 .../beauty}/arch/x86/include/uapi/asm/prctl.h |   0
 tools/perf/trace/beauty/fcntl.c               |   2 +-
 tools/perf/trace/beauty/flock.c               |   2 +-
 .../trace/beauty}/include/uapi/linux/prctl.h  |   0
 tools/perf/trace/beauty/prctl.c               |   2 +-
 tools/perf/trace/beauty/prctl_option.sh       |   6 +-
 tools/perf/trace/beauty/statx.c               |  14 +-
 tools/perf/trace/beauty/x86_arch_prctl.sh     |   4 +-
 14 files changed, 27 insertions(+), 603 deletions(-)
 delete mode 100644 tools/include/uapi/asm-generic/fcntl.h
 delete mode 100644 tools/include/uapi/linux/fcntl.h
 delete mode 100644 tools/include/uapi/linux/openat2.h
 delete mode 100644 tools/include/uapi/linux/stat.h
 rename tools/{ => perf/trace/beauty}/arch/x86/include/uapi/asm/prctl.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/prctl.h (100%)

-- 
2.43.2


