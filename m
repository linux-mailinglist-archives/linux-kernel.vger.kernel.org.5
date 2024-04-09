Return-Path: <linux-kernel+bounces-137043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72789DB89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B2AE1F22D3F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A380512FF97;
	Tue,  9 Apr 2024 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/vZLIAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5012F38D;
	Tue,  9 Apr 2024 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671268; cv=none; b=QMsoU/iHfLeaCRRiwLHzRraDu/6rkc8It85x4VK0POM/7MXBM5A4ltrfVjAe59bzY//mHdsFjRZYHK9hrFi8lgJ+ap3T/rUjnSpV4c8DeDB8/oHe2Sn+q8GexI6XhbGqTEwbHXMnafmdds+zzN/AHVvDJfVUgL2iPTW9pIetyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671268; c=relaxed/simple;
	bh=OwmOVUjCxv1ceoUcK0JKEZS/f6zK2xJ2fR3OQpIwvAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UGQgl0mZWrt53GcmeNVpLhbF9VgX3ufS46qTVlT9ZFgsvbg8UIe8zllnDKQSiXb/+AiKEKCdOXtm4XhHFlqgdlna7z7xEiRmDPd747co6EFtXXOXoij+AxgYJBWnq3Exhj8kyzqX81dyMcRZqzk0aXTeRozczoYtm2QgDixh9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/vZLIAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D32C433F1;
	Tue,  9 Apr 2024 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671268;
	bh=OwmOVUjCxv1ceoUcK0JKEZS/f6zK2xJ2fR3OQpIwvAk=;
	h=From:To:Cc:Subject:Date:From;
	b=o/vZLIAowEbtnS5yLJVyXyO73vrmHagQ76P0tGPcQ70MLclvTK2i/UKemgdQ3Nro+
	 P/xczUtUI+2b3ID1wswWAz7p25VS4eVvJHj9mpZ7i4Pzdska69X+Q5ofmrHEN8SyM1
	 syUL0xPahY5GjXe4iQ99mDr4Ut3fDHcLJjjz8yRKwoBLahebfCMyqLUiGFo2UojABY
	 JnQy77wbUltj1iCFq74CbM7s6WoPhAWUzelnqDjAubKqhwaBnuSSvW6fNxUzGAxOXo
	 qQ4qTT+0Z+JABWRWbiGjufXRHzpEhOY1rbLuhCDh9dby0QgI5Q/OcWG3RK4l2EIecL
	 VIZSyv6cK7O7g==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Richard Russon" <ldm@flatcap.org>,
	Jens Axboe <axboe@kernel.dk>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Lin Ming <ming.m.lin@intel.com>,
	Alexey Starikovskiy <astarikovskiy@suse.de>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/5 v2] address remaining stringop-truncation warnings
Date: Tue,  9 Apr 2024 16:00:53 +0200
Message-Id: <20240409140059.3806717-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

We are close to being able to turn on -Wstringop-truncation
unconditionally instead of only at the 'make W=1' level, these five
warnings remain after the previous round and three patches I sent
separately for drivers/staging.

I hope I managed to include all the feedback on v1, so please apply
directly to subsystem trees if v2 looks ok to you.

     Arnd

Arnd Bergmann (5):
  [v2] test_hexdump: avoid string truncation warning
  [v2] acpi: disable -Wstringop-truncation
  [v2] block/partitions/ldm: convert strncpy() to strscpy()
  [v2] blktrace: convert strncpy() to strscpy_pad()
  [v2] kbuild: enable -Wstringop-truncation globally

 block/partitions/ldm.c       | 6 ++----
 drivers/acpi/acpica/Makefile | 1 +
 kernel/trace/blktrace.c      | 3 +--
 lib/test_hexdump.c           | 2 +-
 scripts/Makefile.extrawarn   | 1 -
 5 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.39.2

Cc: "Richard Russon" <ldm@flatcap.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Robert Moore <robert.moore@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Lin Ming <ming.m.lin@intel.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org


