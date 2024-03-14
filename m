Return-Path: <linux-kernel+bounces-103423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCAF87BF31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FBA28286B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03F270CAB;
	Thu, 14 Mar 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNyTc1Wl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120D5D75A;
	Thu, 14 Mar 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427408; cv=none; b=L4DZvbeRTUEFxgk+7hFSeC+0JLoK5d/uX+5cyGIlU6dzyegfMbYUzzPjTYfDlnX9/9MlsNq6jodfUkXU/4hrVkievy9IqNhCcgOXAA0WcN8R52RLobyyo5yWE8Sz3fJ/BPuO7kteMd38vrrALNc8KkYkHYDXlHapCxjqRWPoCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427408; c=relaxed/simple;
	bh=p6OB1jptEvWyAVFOR0SPMeWm5Yd+w9YyWXJOnwztUyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U5dPHH5o3bMpiikhX8on1bm3lNWbl3PcL7ceZI4UHkSlYv6vPmf4A3jDt6uh2zz18J20r66pLSS84ppDfUjw1wxP5YF9nDmhGxSGcb7GoNvKbLoc5PoYeR0jepB38uE3HXBT/QfjTBA+h1Q6aChqOAykZQvhECueKAPVeGKEQQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNyTc1Wl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E0BC433F1;
	Thu, 14 Mar 2024 14:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427407;
	bh=p6OB1jptEvWyAVFOR0SPMeWm5Yd+w9YyWXJOnwztUyM=;
	h=From:To:Cc:Subject:Date:From;
	b=NNyTc1WlVF/xZIfvUUmx6pE/v1b7VdpMgwkzsXC8/uO/ZY/cASIKcxB3YKWlLIhYA
	 AWdKllZrGt1tmlEureu1Q0GnkWR5qN/vW+IeksM/PeoRV7CmW12d+9IJtnq46iF4iK
	 uoMiBP0RHNnZvnwJkEap6vLUjw0o0nmcAPLc7EbiHBMmAvQkrBeVXZneA/xdeg0hRU
	 B3v5Ilj5ViipP0r300TKazGZ4hnMjaN1PcXU/lDKj/jOjLkgssJPXc+JHfeezAMQC+
	 /RZOk4lGOQeZNh3bM2uNBzbIkwDp9bEkKcw9zl6/6f2+B4XxolkZ+KqvKtiMJCqdJk
	 B3gWQO86h7+lw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/3] Move some more header copies to tools/perf/trace/beauty/
Date: Thu, 14 Mar 2024 11:43:17 -0300
Message-ID: <20240314144320.743217-1-acme@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

   	Move a few more files that is used just by scrappers.

- Arnaldo

Arnaldo Carvalho de Melo (3):
  perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the directory
    used to build perf
  perf beauty: Move uapi/sound/asound.h copy out of the directory used
    to build perf
  perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the
    directory used to build perf

 tools/perf/Makefile.perf                      | 19 +++++++++++--------
 tools/perf/check-headers.sh                   |  6 +++---
 .../arch/x86/include/asm/irq_vectors.h        |  0
 .../beauty}/include/uapi/linux/usbdevice_fs.h |  0
 .../trace/beauty}/include/uapi/sound/asound.h |  0
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh    |  4 ++--
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh    |  4 ++--
 .../beauty/tracepoints/x86_irq_vectors.sh     |  6 +++---
 tools/perf/trace/beauty/usbdevfs_ioctl.sh     |  6 +++---
 9 files changed, 24 insertions(+), 21 deletions(-)
 rename tools/{ => perf/trace/beauty}/arch/x86/include/asm/irq_vectors.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/usbdevice_fs.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/sound/asound.h (100%)

-- 
2.43.2


