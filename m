Return-Path: <linux-kernel+bounces-60263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9C4850268
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39FC11F22308
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370A3C2C;
	Sat, 10 Feb 2024 03:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkkOBcXa"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98C33C0
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707535078; cv=none; b=JT6TKnrr5dyByGp/kXekkLRaEN5E5KGzNW0YGiePnBmx8/uSch/Q9NIufmwiL/LcOjVNuCqYeq6wMWv/Ovj4puujSrl8RPNuPIuhETS2Ljuqeh7V5dhlm9KNHIcJyzcEORXVVArn+Aqpvz/dLsFqd4Qgj5fThKVOWLNSxFYUKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707535078; c=relaxed/simple;
	bh=YAb4FlNOlAfLeMVXc4h45YX0N5LZt0PmJHt3lr+GdM8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=nfd975ceoTXAqHN9lv0BOv906IhzVEgCPGHJ0KzlWGkDtgAtp6J/LoPZz2BhlB18MxJ5xOaDvdrNiU31za/ZReHtFa11hVRAIF4Fl3Jv2gErSavGrKBlhnjWrzl0GDqxNYVpCnn1goA1EID6saL7fJLB4rx9/VjjpSPsSKVUopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkkOBcXa; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc748365ba9so2565348276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 19:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707535076; x=1708139876; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cyyhzZNS8ki5ynML3KytcROjeKIHNvTXQuDKrxr/+s8=;
        b=rkkOBcXaCHIJwlM/NBMSaArU/iKtllJxFbcFW8N4r95XaP38e2jJsJCHl7sAsOyIXH
         zuyfXB3feNtzpwyBY1ulfjoA/O/LCXJPJwhElD6vqnf72UimHIric2MzuhE88zquvSrT
         s1kCJ3GL5+hp+Nw5pi9TtPOVyluCaC990S26E47D27gzhl2svLH6rc3dtpFPhPKRepRK
         GtJFsJvkn+x6565a9pNfcbzYCExEa1WlWyXDZoVesY0BOcdDRT+jSgaKvX2jgpM3WjyH
         GBoL2jPRjAp5uD5hjs7ov0CSe3gDJ5XGFM8Jzs9YsjOaPq1NexUCTGWDOHx6iRayDfes
         Dj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707535076; x=1708139876;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cyyhzZNS8ki5ynML3KytcROjeKIHNvTXQuDKrxr/+s8=;
        b=nnuETVBfl9NzHMO78E5gUhscqx1JmtzEpG+Gon12Gr/xfhJdn3nq2CfWyMmLYbs8Bn
         5haVAOYNDESV6RbAvb+bbSGFfECnEoJaUCMt39yNSsH2Hew8v20wLDHqntHfitWpT/Fr
         L7AxX5c9QQpFhzvLyMz6g6ghIsgTfOxV3G9YrDBv8K9oCf6N9EOpJr9e5YksRlPulROd
         klXoSaijRr+CFqn+uyLd9hetoCZkYWGp6fe4lWPP4krY3moLkzhy6c6tnXElrstV6TV6
         HpmxNEasdsL4gZAAbkhPsSJI8losVBIeLQClFUO1GYbQlWdeq5mOwrmFSBueRVbmUzef
         TwQw==
X-Forwarded-Encrypted: i=1; AJvYcCV5+hiP3/PHra1vr7LsUmSrhwjSkbO7lEoMEfyCZklQoFchTeDe4gUIykeim8afyKw169i2E/oUF645CvsUrawwthZECGPsEe3rc17Z
X-Gm-Message-State: AOJu0YxPg7Z+hg7jdE0wi39kev8RSi+hC2PaRH2KKi21rdgv1Sfo/VFN
	SMvhNfE84T3qhl9GzmfIjElUQvJNPE7fBW9D+NZMPVhbUt4UISwo9p1rqPUoofPhHWFCLTicX/y
	GJ4ut1w==
X-Google-Smtp-Source: AGHT+IF1SwDaOZUfH6p6f3vnVppObrWGYDyiolwE6lbi/prKPGdxMlVbinVXuYjFA0KQF2Caw7xd7oz5mCZc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1207:b0:dc6:dd76:34cc with SMTP
 id s7-20020a056902120700b00dc6dd7634ccmr31801ybu.1.1707535075759; Fri, 09 Feb
 2024 19:17:55 -0800 (PST)
Date: Fri,  9 Feb 2024 19:17:40 -0800
Message-Id: <20240210031746.4057262-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v3 0/6] maps memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Liam Howlett <liam.howlett@oracle.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Artem Savkov <asavkov@redhat.com>, 
	Changbin Du <changbin.du@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>, 
	James Clark <james.clark@arm.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

First 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/

v3. Fix latent concurrent modification bug in maps__for_each_map.
v2. Fix NO_LIBUNWIND=1 build issue.

Ian Rogers (6):
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps

 tools/perf/arch/x86/tests/dwarf-unwind.c |    1 +
 tools/perf/tests/maps.c                  |    3 +
 tools/perf/tests/thread-maps-share.c     |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c      |   10 +-
 tools/perf/util/bpf-event.c              |    1 +
 tools/perf/util/callchain.c              |    2 +-
 tools/perf/util/event.c                  |    4 +-
 tools/perf/util/machine.c                |   34 +-
 tools/perf/util/map.c                    |    1 +
 tools/perf/util/maps.c                   | 1302 ++++++++++++++--------
 tools/perf/util/maps.h                   |   65 +-
 tools/perf/util/probe-event.c            |    1 +
 tools/perf/util/symbol-elf.c             |    4 +-
 tools/perf/util/symbol.c                 |   31 +-
 tools/perf/util/thread.c                 |    2 +-
 tools/perf/util/unwind-libdw.c           |    2 +-
 tools/perf/util/unwind-libunwind-local.c |    2 +-
 tools/perf/util/unwind-libunwind.c       |    7 +-
 18 files changed, 906 insertions(+), 574 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


