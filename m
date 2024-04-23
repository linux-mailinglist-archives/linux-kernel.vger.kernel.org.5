Return-Path: <linux-kernel+bounces-154442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758348ADC24
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5E81F22691
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A4919478;
	Tue, 23 Apr 2024 03:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjF54Z+u"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF518641
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842260; cv=none; b=X0rXn/mS7VuXJYBvQozmq9HwMhYuIpl/b+A54lFa9OdjHWXRGzzSHVqbu9W+eckqIFNC42ouMCBmiepQzJWs86uGSgh9yTnN/FaBRe9wTDk64bFBPlO47ifFa+xrQB2gDmR+FFMcd/+4Onn95ta5xdKJZis0TbTSSCzU4Xfqop4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842260; c=relaxed/simple;
	bh=ODsaSBQvTG5z4HQCqgUmvBgU79/QRqvZ1WHr5Rn79tw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=oQBE2+1Mz20lTRgIrFM6QqB4bYBIB7CKxWfq7LJPvtLYPiv28s5k3JWfvDgzLp3w/iDQGNL8hb3+xkvEpL0nmwTzY8I2oLgPa2y/f+6Y6VA5eQOVlZ1KBJyci5L76fULhiIWv/E4gvSAaMDjmOdE/646qFEEGYmPZYZjBNTBee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjF54Z+u; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de549a4ea65so959675276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842258; x=1714447058; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KQshy6f5GLra24bbWQxcdEd2+p/UYzIgRRdnVXDwumE=;
        b=rjF54Z+uYOobd69WGemhoeuteatXi9oUd0xOpCUBuWYDvpoly0RbEQz1xE9mXlTIAs
         k7EWcGk+SwdkJiAWUQsDL/UVEx6Z0Ea7SV+K4HCLctRz3E076CA6PZ4Fzq9bzaGmVki2
         iy2KRvNNIrryyjcZkOeLIiJq32svyWzaARVQOqwDiJXbIrME5uTW7KPaOgxjZVSYMtOR
         zCGzVWaV3FvPZ3deq38QjCqxt4ArqzdOG04QjwStpKtPHaKGUwGlefnlos8iDIRLFsJa
         uVpEBaWW70cwSE3Qg63Mao7raGf46TjzZICFWXLRpz2Dx0RMs+XAa5s4MYOJz6YAArCT
         oGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842258; x=1714447058;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQshy6f5GLra24bbWQxcdEd2+p/UYzIgRRdnVXDwumE=;
        b=DCpnmEXIYFiMg65yY+WYAkm0BoyeHK0rT2jmxJ1RrMJ+ZhdU3k7x1XgS7i0ygx3I03
         SjpEkYJpaLcUAMkMLsukynW2M9QtylVg4V/3xN925/RSHJAWPbsRoHIbYNXiQZEwdImt
         /uzhORtxGAmBHaKVcw/eBBRqrSbykTOi3IvO1lCTHO00vyctIsCInpyH5CBqk/xcYU1E
         FvpKRJqVVvuzlt68SuczejGeOlZMcSMvY6ZADu8RaISUwBAiscNZCC4pOQbOA6R/601s
         /juHQHFC7rmbZCIVAj6me521eywFmD8k7GiM3cmCQVcgdbKGgi6zhShNp16pvZdRP4vi
         1QyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsBARZQ30L5IPjZ47LNwdYwf9deMcBrDuXPWxdiNUkrXZ9EIrpVVq3up8XtFZvbmdO5lsTJn//9wZ+ysCe2ZIYj3s2AZmrVKCxOn52
X-Gm-Message-State: AOJu0Yxvv8rOjw9i+f5RwurV4v5/QoGgLMg2FMeaxDAAf11Z4zGk60kr
	IomZ/cs4mj7cY2+0bXUYwvac4pqB5DofdXPF+MEuNm+OxGcdwF83tcnAxocVBMEvFzOK+/98QDS
	o/M9vKQ==
X-Google-Smtp-Source: AGHT+IGr8wcfu3UIGUVqdM88TEQofrqyAUeFo/hd7ozAS5/UO9kqLYWDKADo0gI6rRS0LOTbMj7NoFUeGnoC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a05:6902:1103:b0:de5:250a:f1e7 with SMTP
 id o3-20020a056902110300b00de5250af1e7mr1519612ybu.8.1713842257886; Mon, 22
 Apr 2024 20:17:37 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:13 -0700
Message-Id: <20240423031719.1941141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 0/6] Assume sysfs event names are always lowercase
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

By assuming sysfs events are lower case, the case insensitive event
parsing can probe for the existence of a file rather then loading all
events in a directory. When the event is a json event like
inst_retired.any on Intel, this reduces the number of openat calls on
a Tigerlake laptop from 325 down to 255.

v1 sent as an RFC:
    https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/

v2: addresses review feedback from Kan Liang, by updating
    documentation and adding tests.

Ian Rogers (6):
  perf test pmu-events: Make it clearer that pmu-events tests json
    events
  perf Document: Capture that sysfs event names must be lower case
  perf test pmu: Refactor format test and exposed test APIs
  perf test pmu: Add an eagerly loaded event test
  perf test pmu: Test all sysfs PMU event names are lowercase
  perf pmu: Assume sysfs events are always lowercase

 .../sysfs-bus-event_source-devices-events     |   6 +
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/tests/pmu.c                        | 444 +++++++++++-------
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/pmu.c                         |  97 ++--
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/pmus.c                        |  16 +-
 tools/perf/util/pmus.h                        |   2 +
 9 files changed, 377 insertions(+), 198 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


