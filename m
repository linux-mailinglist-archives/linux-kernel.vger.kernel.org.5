Return-Path: <linux-kernel+bounces-86171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910AF86C0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31BF1C20B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2960D2231F;
	Thu, 29 Feb 2024 06:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuJxVrNt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BE36B0A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 06:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188382; cv=none; b=F1g8UkWOaVoKtpzx2x9/aLLO3/7M/s552BfftULNgQbAIUpyeWbM2I60NvBK155DXt9Pow9v+OwhuRNFgF0jzQB9YI/95Q5YTPMxT9KYHd3CJoFpQFWAg+pHOVDoeRnyKkiJ3cAiRYrbayuVx2pdD9Dl11RG3TScRZvKqVCuxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188382; c=relaxed/simple;
	bh=dFZ2GSzmiKOQGB2rUKRoS+qE2/AFOzCta5z98wxR/38=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rFajXaUJChfFEd02HGUr4w5AzhLWj6S8Hs8VEG7Y0AHnP7A3a9fY3FXkqvedRL/OEE1lAhjzbeAiXLYKv7j10kXKMxbJS6tT1xPhSh2C34nPmHbPTOK72XQ5wPycUb4+cxlcM1UJ5twGQ5htVkc5QnYAQce2UDvSnQdw8O9scEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuJxVrNt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1141106276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709188380; x=1709793180; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FMG+g1RkoAeOPaJke1hkXlYl72J+qtVpVOKOhfjNYSk=;
        b=CuJxVrNt32UxA02WYQ5u5YLcpxiLfLpq239ASU4EmQgY4IWpoN198ncgK3Tu5y4xLR
         Ei8yONrgOqh8K5tegakx9UuLVZRNjMAXlCKA+kaO+l/Ap1chVMIh3d34pqyqBGB3VWgn
         PN87IKeaVe3cq5geSgXgy4LkaTQ1DP0MjiWhVeefbSLfKN3a8wvTIeRNLsRUmlc1lMox
         KRLt1GzKjmQXQVkQzyFW9pBbgp8liNJShsRq7/CBUllEwoLYHXebFCvW/BMEVpgXEIOH
         EnV5KAf9xzVuPJ79aJTCjwE1VmxDO2SAX0vLXj9cKsbNguO5279z2HF+FwbE6/oYoF6h
         5AhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709188380; x=1709793180;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMG+g1RkoAeOPaJke1hkXlYl72J+qtVpVOKOhfjNYSk=;
        b=I2lu6fYbJplVd28B95Gq8UErzgj3LpUf0FsB+JbBB1Zw9RTr3qJGiDVLQLVAYa9AhY
         75mlgwVT88MeHBkl0vcyNcL+rfa/IP4GHqlDT+u7kPYtOIZgNxhm2Ua0fxDfKWYXKff9
         UeyInZXEVa5iWFKbeUEN5jGlpC2MnuFhe8uYRGTwgY00gmPhNtgynqDLxc2xsgvZaMt3
         c/ziwhNXCx7RlOQifczALIRqoXBFrMyuCIhetL4WNyAssM8w5MkhK30SlFV2k14HbApr
         cof4UfJFjKo/y4CXPnHF2KcFT9EKX7fdaM8yBeh4uvbuCME02lIk219Jugn0nTYfZlly
         KOUg==
X-Forwarded-Encrypted: i=1; AJvYcCXajaE5jkJtcmxnbK3s0i8Aew0o8BI3egbCtORctvSGCPBtIf5zPHFUikEEME7zRk3vL1qMmdYQSGJ9IDKEjdN95slvLyaUr07VsU06
X-Gm-Message-State: AOJu0Yx9+eO6sogkiAjByJhypxJcA74bqCirKSuOSWsmil8/IVXRE32c
	4phjuaZ+4ygybyQ2xhM46JBIv9Iue3SeeiPUhz4H7Nj6ah7w7//JY7SK3WXKmN4GOkJkPtrn8z7
	oOe8WIw==
X-Google-Smtp-Source: AGHT+IF7rj4lUoHEesPzPUsnC4lJMMcXYg7gdHw2rz+BXHrmFkj7JWeUq42USj3bBpAEhwaiJ1Gz8ldQnGer
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a25:abc5:0:b0:dc6:eea0:1578 with SMTP id
 v63-20020a25abc5000000b00dc6eea01578mr346976ybi.13.1709188380051; Wed, 28 Feb
 2024 22:33:00 -0800 (PST)
Date: Wed, 28 Feb 2024 22:32:46 -0800
Message-Id: <20240229063253.561838-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 0/7] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches (now 7) from:
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

v3. Factor threads out of machine in 1 patch, then move threads
    functions in a second.
v2: improve comments and a commit message.

Ian Rogers (7):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf machine: Move machine's threads into its own abstraction
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 217 +++++++++-------
 tools/perf/builtin-trace.c            |  41 ++--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   4 +-
 tools/perf/util/machine.c             | 341 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 186 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 474 insertions(+), 394 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.44.0.278.ge034bb2e1d-goog


