Return-Path: <linux-kernel+bounces-102812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE487B77A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812D5284BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D87D520;
	Thu, 14 Mar 2024 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0G/U59I0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20ED271
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395893; cv=none; b=jbkHdlebv/yWa4kEvIMWouhsjqIRbMUbh7Ms7lLYBBOh6uzDHFsxzefjt3qfzDWIr244CDzGJCfTLODJyPo+STz3nsHv1vfF36EjROhegNLdKwOfOswcXQXw8ExyyStEtpXNFkyQgZxgf3dCZymjRRvLkFF937GU0gAX8ZPVUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395893; c=relaxed/simple;
	bh=03ZquAkgZuKfg9867OF0UbEgrA/nyh23S+zddaZNATY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MQw8slzB5UWEwjjzb3QWZTIKU2KBYMtPT9tyAPy08ZHlpAlBkS2NDtSJn8sxxJxKruBZOt2mfBkZspn54LhnvLaNCXBPveCdDylueyBR8yCHQOMn78QXhWmT8M7s0Rr/BZLuX5AzCmlqP1dc/oMmcXmNTeIP0loCROE/9Ythr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0G/U59I0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd0ae66422fso1344445276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395890; x=1711000690; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xhjE7fpXfJYWlNLkSGei0pvVwgkX4FM59qo6J0CXpqw=;
        b=0G/U59I0ruOI6pq/F240C2x6bF/+55aSaJiW6Fgm1TkOLbY8sqi7uWv9TjcYg3FXU1
         VWoNQJLQ3R6B8ZlJ4JAKtobBPBRLaIeLhQWx7uZxX0AOTB+WdNsmGLeaf7KBpPxpYynB
         ZSrSOLmlXKVMB1rJmTtcQqANA3FxbovoOhJduqAaDNdylHSWOtVQuVo1BeX+RqygI8u1
         4ZV47esNQsSgO9hZywlCof3EX39068+SF3o7JAt32TpRpijyKniT9N/4bPm1022X6j3P
         4nCcGhbRqL7hR3/aj1OtFXkQ9UWpcdjcKXDAXN2t4XdhIrfXMzRfHFtk93VZSVtK7sOh
         NqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395890; x=1711000690;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xhjE7fpXfJYWlNLkSGei0pvVwgkX4FM59qo6J0CXpqw=;
        b=MkzkqQJKmcCijtjQQU4Hw+HwXUAVTvHwFDtd2zMZQI3KXHOVSCKcY/i74F2D5upQsG
         VEfu9jt4dY7+jL2cRgmpRSDlf0BZZ552vl1Q/Vvk6se2S38GwCpdil29Ou6Be4YTmX91
         MrlQToRH4AYaYlvY/89dSBtCWq5F6kZpp7i5mityaHsrlISFXK4KSyA0zuw9hJGAhhEH
         jttrrneYAGNAR6culGiQ3SMmnWU1A8gWWe984opBtKY65cyScmMpDhqojQ9PM4EZFPYz
         ORPIRcyU9ZBobbpM/0FWgAuaYelAEwfW3Tq7VRkvJxM1G9KB7i89d+1LP/VrytAmGvas
         9aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL9fSuB/n2+OrAmHcUooUu/J3/M74p0t1DuX03lm71hdBDKclK9EyAdlRcXduk3mUA39ykvssiEumEXztI7nX8mX+/LLZ7k5zDw+4o
X-Gm-Message-State: AOJu0YxtoAer3UsqQ6ZAqwlQG9aZRXiIqA1x6Tg0e/qg5dFDKRxnhWzK
	z9G9EOHan5nvwoCtrFpuTBTcJCkcWayx2KxFZ3Jb4TR7i8ORBvWdRosnlFYJ0H9cVhG2flogzAN
	mtXPuXQ==
X-Google-Smtp-Source: AGHT+IGiGx6/4JTv4dtbyB5GfxGjAmXwYsRLnG30vVXF8B218FjQ4b8p1THuS//JYipH59oS2nI5ach3VylW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dbe:d0a9:2be3 with SMTP
 id w10-20020a056902100a00b00dbed0a92be3mr257463ybt.3.1710395890629; Wed, 13
 Mar 2024 22:58:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:57:59 -0700
Message-Id: <20240314055801.1973422-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 0/2] Python generated Arm64 metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate two sets of additional metrics for Arm64, where the topdown
set decomposes yet further. The metrcs primarily use json events,
where the json contains architecture standard events. Not all events
are in the json, such as for a53 where the events are in
sysfs. Workaround this by adding the sysfs events to the metrics but
longer-term such events should be added to the json.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v3. Some minor code cleanup changes.
v2. The cycles metrics are now made common and shared with AMD and
    Intel, suggested by Kan Liang <kan.liang@linux.intel.com>. This
    assumes these patches come after the AMD and Intel sets.

Ian Rogers (2):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64/AMD/Intel

 tools/perf/pmu-events/amd_metrics.py    |   3 +
 tools/perf/pmu-events/arm64_metrics.py  | 147 +++++++++++++++++++++++-
 tools/perf/pmu-events/common_metrics.py |  18 +++
 tools/perf/pmu-events/intel_metrics.py  |   2 +
 4 files changed, 167 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/pmu-events/common_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog


