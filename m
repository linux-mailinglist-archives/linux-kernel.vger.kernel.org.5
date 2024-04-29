Return-Path: <linux-kernel+bounces-162987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585778B630F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57CC1F22A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFF3140E5E;
	Mon, 29 Apr 2024 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEF4gbkb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84213F006
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420960; cv=none; b=csCVCnTz6hK0TWeCDjOx51h93BULEebbvjM4Y+2RHl54jsDsOOVWuU6Y3gHkRGGp1dgB4GCx+QbHs5E1NUSzkZ6Na5Hra5eUVVwXbuRRSnWsAcP2ziOpUndvKGS6iI3TeWtk0DrGtcxCGIlfwQbHDztyQvJ8yxrIILGTBMEOsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420960; c=relaxed/simple;
	bh=YyvsWLWngfSh9nnSqgcZese8fTAPRzDb4ZSWq14LiNg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=OQIYLfPTXjc4R2Z1Snt2mjJdxPOJap5Y+L5ke/PH44fDxzoPbgJpAzbCmB/jU21+XnihN7XcJ0eZgVMYpzm6WSb8xlo6dxFEhj03qP5sqVpeXqr58IwG5ceYj7iiyyBJrIy+Kx5g/zildRLKRlfy6jSEMQTzU/h92/ZaE2DJnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEF4gbkb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61acc68c1bdso59647437b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420958; x=1715025758; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mbGOcW4P3upkfkJhKMRnRlo5SQ4rO5/K3xu4UpOuH9M=;
        b=vEF4gbkb4kV/PRvrMoYDD95JN0oLGF7hFZ+cITex1TdqIKCigG229g9SK0OqfZe4df
         SJiRKcJgXmXLLAv1VXbTu87WPzeQ1neWa2C2iHFtDJMMu4XikLQB9xWcbUyLZM5+oBBE
         xIolGzr45/80bL3KPjad4lKist5O4aHzHogOBJRhAtKQq6+pgvj24VCbpwx7KYI2MtWN
         /vT394zpjapPli+FuYdXbYA6KoU0y5hcjQRQzzn4MFzyWmTQlSc34+SWJdw1BKx/IWwj
         BZ6XL4EUqszIeD45DB7kYG5n3/KdbA0moFrC6ooLpcrNkfjEWX0Y6lV8JR7RqNRKm3eG
         6g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420958; x=1715025758;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbGOcW4P3upkfkJhKMRnRlo5SQ4rO5/K3xu4UpOuH9M=;
        b=Yi8+Gci7BVz02cZdT4uMwuDVxFPsrFzIybx0mlF2YxXnEZQwfrMsylVPcUEOEd9FAR
         fH/Zk63b8SKD7wqCCkMlllyswqX8/YsKHDjaumbV8QZazcZ4l2lhbPdRVWXYArJmzDNh
         KtTXl3WedtRWnnhck82GFUzA4E3iGcBHTCfa+f2cJol8vQS9AELTJu/UXdBiCGyo8wOQ
         jGnSiF1q3o+y7+8VOxW0CWntAd671nyRzjvV5set9OyFoApTGRQmNW7KsTDIZ8HKUjd1
         Q6w3Vrk8xD0Jd06/ySpds6W4pzmwlJIUVLoJiWHZhN5p7eMN6kP6D1yfk9q4C3IztY7z
         E5/g==
X-Forwarded-Encrypted: i=1; AJvYcCVY5l/An1aOuBaFRWiUDtckEg3B6bHHIPQh3Z4MU2hl/C+8gocssKxwLSDipesC8ZCBlXFqjZjYQoNg+c5fqKfcqutfhPHmLEjYr2Bv
X-Gm-Message-State: AOJu0Yz8YZqiEwk+Tf1XK8+LtJnXjJ8JoQdZL2zso2H+r6BTj82cb5BO
	LgDzhvpPS1ZLVGdnIRlzMeqfUU6XYMOIueGuVH3QwlyrIas8WyfU4tez9sj/Epajj589lMpD+3e
	sWFDCRQ==
X-Google-Smtp-Source: AGHT+IHidjJKOQ3Mb39cydoxlPwjZkrNOD/yd72CZlEPerBURKz1ZE/xpzGhWNmPJbjfvIyKvRY/38f2JUBp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a05:6902:150b:b0:dda:c4ec:7db5 with SMTP
 id q11-20020a056902150b00b00ddac4ec7db5mr207193ybu.4.1714420958248; Mon, 29
 Apr 2024 13:02:38 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:19 -0700
Message-Id: <20240429200225.1271876-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 0/6] Assume sysfs event names are always the same case
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
 tools/perf/tests/pmu.c                        | 457 ++++++++++++------
 tools/perf/util/parse-events.c                |   2 +-
 tools/perf/util/parse-events.h                |   2 +-
 tools/perf/util/pmu.c                         | 111 +++--
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/pmus.c                        |  16 +-
 tools/perf/util/pmus.h                        |   2 +
 9 files changed, 405 insertions(+), 197 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


