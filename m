Return-Path: <linux-kernel+bounces-165950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB318B93BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575781C20EEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7D1B7E9;
	Thu,  2 May 2024 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0ubfWNj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A288D527
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622493; cv=none; b=KGGUsF2xoaxDrnZvwg/gXNR5lQhZAU+fDJ5khtWreOjJXMbDDeR3uj5bwzt2ZaGy3Z6GcIANnb9ULmgKoAXFBJPNytGkibu/FUCCPkQbm9HvTV35/M3CraA5hw6rVWv68egHaEOmdkBzLlniJ5sGijmddVBVXx2ihntxQJ59Eds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622493; c=relaxed/simple;
	bh=37j/Z0B+XnloIjgIcP2R6qgOY6ShZO2LUmAQ9rdLv7o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=kyiQzQxmUWwYzc4hMwChFOQ42siuQpes7ckhPPM842MkJSTtCyciQWvUm5rxFjqyz76FrzaXnJiNcB/Qe2kvq/rrQMHndZ33e8G3ClG6ldQ8dfWuhoQFLe4/3J81riapeYHP6fCVcRVP1SUR6tkydpcNDVDRynHrwkwL2GRJW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0ubfWNj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be8f7ed6eso18840907b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622491; x=1715227291; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m4VDeNJAoZaS4Xs4WRhklAjJjfZZqn8kn9XarE54odw=;
        b=y0ubfWNjASQagDitG6ZmkKZKJiEMKJN2enAWLPpxtC01j/6S1yhZBWchJqszM+v7j4
         C/cXg33D+E1f4//yci8cjs7khMifiCMfHI29Xtq6b+ZTV4VqM18DsjlZKkTOiwo2NPpL
         ZEdSC0/0Tf0hprL9slYyd2YUU7qwe3Lshd1BwquGH80RA6Iz15aWee7ecTgtKg47B09V
         FvrwuCFldzgKpd/wcPNIMJXv4SnNlDfl8mnw/t9Kqy41GKt+eBpOfboVfIIPtd6ULswk
         IS7s8J5X8FOTGYIP5bWpV1c7sPhLYKF7/p7ckIlCECEcqh2zRVha97DSHqE5lNLTKWd8
         ztHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622491; x=1715227291;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4VDeNJAoZaS4Xs4WRhklAjJjfZZqn8kn9XarE54odw=;
        b=A+oxNrZY4veAR7Cvk63YkG1l3x5ecRRSrG0aLWPD+2KMVYODOuQNnMRh88QXu0Z4Xq
         t76cGrjpNt6I9hYAZWzQgz+P6tQ83wOnkWuwSE/3J0Qr0MPmgZ4ZdImPt5gq7l7isznx
         vC4gdV3X6YJD7dUDZ7NSv6+sUbgoNq6Qd/da4Aek9769x5IFdwHv5vlXWl6Hm5u5KHUn
         UsWIcFOgH++PmDbAm/wgUT1jJQdMzUSvlT/MugDEFyCwk9zhD87qyVPqn4mnTWvWSbUa
         n1Ec8/ucM97is1AO4Zo4pUcLSOSREBrW7yuSFmdHw0wgLYUatvyV58jKhv3uh1nsBZ7w
         5baQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEGw7vOKfxD9cC6VPbDxKV5D/+yT6G4kQLGpGX4HZXlHjIBDATW4axXRSAFb6XJhHAkmtscKThbUwLgDb9ZddAnzXvqomBlsKQ9Uiu
X-Gm-Message-State: AOJu0Yypfj2m415QBgo3Uj+nCo0K9J7m7wo7q02oH6JIwX3ozUMcvjgy
	UlTYkqmRo/kTidwa+MEGUEWbIH88ZaBrK0k8O4Mc7JwlHqx2ecSIGXaHQttzPH4lrV2r+nTRp/R
	QDsQObw==
X-Google-Smtp-Source: AGHT+IFq47a1+HUIL9gjy9nk8sbcRRxfuJtc3btqJfIm+Yz6izu0eLOiC4O5aefoRZdX/lBTLZYP+14GruPQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a0d:ea0d:0:b0:61b:32dc:881d with SMTP id
 t13-20020a0dea0d000000b0061b32dc881dmr414597ywe.3.1714622490822; Wed, 01 May
 2024 21:01:30 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:06 -0700
Message-Id: <20240502040112.2111157-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 0/6] Assume sysfs event names are always the same case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

By assuming sysfs events are either upper or lower case, the case
insensitive event parsing can probe for the existence of files rather
then loading all events in a directory. When the event is a json event
like inst_retired.any on Intel, this reduces the number of openat
calls on a Tigerlake laptop from 325 down to 255.

v1 sent as an RFC:
    https://lore.kernel.org/lkml/20240413040812.4042051-1-irogers@google.com/

v2: addresses review feedback from Kan Liang, by updating
    documentation and adding tests.

v3: incorporate feedback from Thomas Richter <tmricht@linux.ibm.com>
    that s390 event names are all upper case. Do a lower case probe
    then an upper case probe, make documentation and tests also agree.

v4: add checks to write (kernel test robot) and fix a typo.

Ian Rogers (6):
  perf test pmu-events: Make it clearer that pmu-events tests json
    events
  perf Document: Sysfs event names must be lower or upper case
  perf test pmu: Refactor format test and exposed test APIs
  perf test pmu: Add an eagerly loaded event test
  perf test pmu: Test all sysfs PMU event names are the same case
  perf pmu: Assume sysfs events are always the same case

 .../sysfs-bus-event_source-devices-events     |   6 +
 tools/perf/tests/pmu-events.c                 |   2 +-
 tools/perf/tests/pmu.c                        | 468 ++++++++++++------
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/pmu.c                         | 111 +++--
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/pmus.c                        |  16 +-
 tools/perf/util/pmus.h                        |   2 +
 9 files changed, 416 insertions(+), 197 deletions(-)

-- 
2.45.0.rc0.197.gbae5840b3b-goog


