Return-Path: <linux-kernel+bounces-36426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E59C83A099
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EDD283306
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B06C8C2;
	Wed, 24 Jan 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWRLfZ5A"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00DBE61
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706070621; cv=none; b=jkDnzhZwXl+AkZabAOY8qkLmyzpRK8qZyrXXrqgHPJyHzNxVxekbAf/W/dT1wG8ndXUAoyJoa8b9VRxMf//d3tZL/k6I5BGx1nr3NEDQuYPBZRcsQp9liw5vd21tnp5yFP/yb8D8XKApko1tIdtw55OaJgq9DaTww8y8FsU7zTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706070621; c=relaxed/simple;
	bh=kZckxd2Y2SmFxfYlXLIg5gka+elYmXwAwi4rkByho4w=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=PtJG02qP7dmlrMBouJshyh6oug6gF9ipq3nEpp60DSrz+7Zbo7xCnsbIJnhw6VqURoKOo7uDZyadWTlc/wLAckX9JCnZTrxAvMBorlDe+6tJSB66E/TR/Y7Xx8fUdWzx3kEYDdyg4Fouqfb6X5xzk1PQxBW7Hl5CcEc6eo57gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWRLfZ5A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eb6dba1796so79722407b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706070619; x=1706675419; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sx6gx3pXvR8/WWqfzfORTEMxkJMYhHXX7CfsT6ClFYU=;
        b=qWRLfZ5AjEWVsMKH7nor23szXKQg0AwBt52rIbuLI9r+8jcLRToqm76LAp1FAI41Xv
         J0zsWFksQRsFIM42+71V45m3dU/ogA6tmbbm/6ZnDVusm/o2SGcT3LtsSQqTM0/epOuG
         ZRexA0eunp2tQXWmxWpVcQreXvGSJJe7apq+pAU8cm6uNbY2KVFLhOBgng/yaPzwbMJN
         lHrHYszFa8lMCimwx2nyxMyzn4acoQWHvXp6BsFDS66Up0tx7YdPtH2jBE/hgxWEpwaW
         MTENQS+LLhIp2FMGTS319E0+fFC01n7fn57p0Py1NHcP16/pRDBqAQIjiw1A9bfnWo8P
         7dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706070619; x=1706675419;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sx6gx3pXvR8/WWqfzfORTEMxkJMYhHXX7CfsT6ClFYU=;
        b=cR/Mr+ByYNlfpkJHnmjyMO2yhj/TnKZ9oG3MXmQU7b0SfOjgYg9U0jO2j5Ts/ZJgFa
         3Yv4E+Ujddk65flJNJAA4FVOoi9T/Lv23uICtO+XjFFynJrL9toD0QkTBQktIdvgPJ6Y
         Z7qBajZAUXjOfwHIXiE+gjviIYMZ9/fFPx7zc3EYMMMw0yivJh+tWnSOeNeiu4KzdyxF
         c0AvcxBfWEKX/W0nsAR8LFOKiuRB5pKybhBfmcW0b1hAnEIR4xYGNInRpBt5tu7tctD/
         UwmOq0iupXdA1PBJoz7X5KImGsS12WzbvPEZ2jrrn6fm9lvsCY0dvVEY3nm+zETD6gmC
         eFhQ==
X-Gm-Message-State: AOJu0Yzd4GFyG/2LJKdvddIlf3LXYw1hTa+Dy1yOOz/x6zZvm3dsFUwq
	FSsO/liRJE+ErTzcoh/P99w2VL58DK44E0UwWPuagDkGNWCtEvOD41CipBXnrV+5q8ciPPYzKjj
	C5f4TVg==
X-Google-Smtp-Source: AGHT+IEIWuPYM79jBl7bn8VuT+ZBrK7h/m8zExOWK5gv4yLjDd00DRamQ23w7paSUMORtgPYYjwhhqA+T6TE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a81:994e:0:b0:5fb:7d88:a558 with SMTP id
 q75-20020a81994e000000b005fb7d88a558mr140250ywg.0.1706070618751; Tue, 23 Jan
 2024 20:30:18 -0800 (PST)
Date: Tue, 23 Jan 2024 20:30:10 -0800
Message-Id: <20240124043015.1388867-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 0/5] Fixes for 6.8 PR1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Discovered some testing issues around perf list, perf script and perf
daemon based on Linux 6.8-rc1. Some of the issues were discovered in
the context of an Alderlake system.

v2 - address Namhyung's review comment and add his Acked-by.

Ian Rogers (5):
  perf list: Switch error message to pr_err
  perf list: Add output file option
  perf test: Workaround debug output in list test
  perf test: Fix script test for python being disabled
  perf test: Make daemon signal test less racy

 tools/perf/Documentation/perf-list.txt |   4 +
 tools/perf/builtin-list.c              | 211 +++++++++++++++----------
 tools/perf/tests/shell/daemon.sh       |  34 ++--
 tools/perf/tests/shell/list.sh         |  21 ++-
 tools/perf/tests/shell/script.sh       |   3 +-
 tools/perf/util/print-events.c         |   2 +-
 6 files changed, 177 insertions(+), 98 deletions(-)

-- 
2.43.0.429.g432eaa2c6b-goog


