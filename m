Return-Path: <linux-kernel+bounces-84079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817286A207
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3F81C22342
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35C14EFF3;
	Tue, 27 Feb 2024 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NAQjr5l2"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6FC14F972
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071323; cv=none; b=dvggYzAz3h/jDaomJBrOgUOPcuK0WZf1OC5JPTUmhtRmXronNEtGto32UdxMHPfEtowtkKAmwl3Mkki/kmkPCvRtFtbmixIsJitctxRI8rz6ZgWvm6O56SgSWnHIMTh9QiUsCwpq65FAhRHZ9iOnxcvvT8zNb7NDHJqGPB+WQTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071323; c=relaxed/simple;
	bh=ukWrWX/4QAJImSWXYY9VHw3tM0MRjPKz7OGm8pghIEE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=j4d/joLPxncii2K2oR30JuHdYvLTxcSzcXuBhw/kNtBP2/4aMIij4A5Og7iSZCtXwb6FcJFcnWwgVSqX9cXIpVBM3biPZMjO17sODBVjstTVVnGseLGtmoWp296xg0hv1YuvUN+c4Zpaxi422GAUYxjR/l+NZT23la7j1K92MHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NAQjr5l2; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so5973290276.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071321; x=1709676121; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oJ3hOQ4sjw8PBE4NTH5bCPktPJ1q6cfg+IS2J6sU/VQ=;
        b=NAQjr5l257jm1gv8jDmx2tFDw/wgZulnnPZ5bqUJrWR66P44wMmguOuKe9zS+ll74S
         3g9u1pLv0f7mLjdnmxp1LS0fRI/kflnnOhnmJbCbKhnTeKpXQkvGhSe9PHtMKwH1fl+5
         dV/5MM23ez7Q0vw1nE7i3SmHdJ98ksnMAGTTEjj59omYvgpYHtD6VzaHWdUdVPw32Tzd
         LMi0OA3NujgLQbQIhEE9iymb3H6NT2nJpEAIz3WML81TiDUBJLzMNI8M/BJYRGiYfW4k
         exAkr0tVWCWAk9HTnY7LhymptE34zt9zo/mY/uuvVM4eIKIY5L2Xh5b3z3lhEiUIoOcF
         /qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071321; x=1709676121;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oJ3hOQ4sjw8PBE4NTH5bCPktPJ1q6cfg+IS2J6sU/VQ=;
        b=RcefxHt+vBTkn12qhiZkjQa3ldWK/t07NonXLyTcXhLQIgUqg1MVM7MPzmDDrcYAjC
         i477D/n+DNEZdHkiDzSTT/aJ10C8h60FcOhvqbi/jNwbaW6q1NC7/XXcBSBxqSz3xyP0
         xLlDuKomvmsmzeCWcFc0lG7U1rrrnruF5snJEYFoj4f7y8FQQ5THlneyR64ehaQ3yicf
         6rQIKP3eKAn9fTB/XNy6n3HUY9+Ok5EJVIjisiEKG83NbYyln1wngMTVKvXpCG/jO01O
         /yzU4Yry5xBScUw0prM4DXfJ/hesMwoBb8t2eHFgFoDz/w3DPgTmsEBcRo0S32sG9FSA
         Dc9g==
X-Forwarded-Encrypted: i=1; AJvYcCWWpLxVR2qdHiSHcU+V/Xw9tJ0aQTnKbpkzU9F0AgpiQoVQSDfITNgRN0RmN8rj65EgAvLu3Yuxvwb4+ckuWEsvGuAO6RMbSPdaXx2k
X-Gm-Message-State: AOJu0Yy5bypX1xt8gjkcISXqvnT7nFwtJNxEETiQcFNHYAxnPQHZd8g4
	KUCpDrM8v8weccMxTZGi58T0j2WihVcCqXOdCiZQy+RePpYV8HtWeJaoS9gO1Mdi3soub+hImOH
	zf9hTbA==
X-Google-Smtp-Source: AGHT+IG/cUONmoV+4UzbT+d/Hd3lVMVO8hBLQGFKSS3+qo3Oz7AGukS9JYSGimVkX4knBHbcAzSdbLvwNS/x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a05:6902:1891:b0:dc7:82ba:ba6e with SMTP
 id cj17-20020a056902189100b00dc782baba6emr55224ybb.7.1709071321432; Tue, 27
 Feb 2024 14:02:01 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:44 -0800
Message-Id: <20240227220150.3876198-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 0/6] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
now the initial maps fixes have landed:
https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/

Separate out and reimplement threads to use a hashmap for lower memory
consumption and faster look up. The fixes a regression in memory usage
where reference count checking switched to using non-invasive tree
nodes.  Reduce threads default size by 32 times and improve locking
discipline. Also, fix regressions where tids had become unordered to
make `perf report --tasks` and `perf trace --summary` output easier to
read.

v2: improve comments and a commit message.

Ian Rogers (6):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 217 +++++++++-------
 tools/perf/builtin-trace.c            |  41 +--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   8 +-
 tools/perf/util/machine.c             | 344 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 186 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 477 insertions(+), 398 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.44.0.rc1.240.g4c46232300-goog


