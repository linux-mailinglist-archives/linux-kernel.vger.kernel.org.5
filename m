Return-Path: <linux-kernel+bounces-102840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A57AA87B7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A33B21332
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3E39ACE;
	Thu, 14 Mar 2024 05:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1KwtR3TE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9E376F2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395987; cv=none; b=lCie7dUgbwEWSiC75TP/cjLCpxrfteiKl2GGQZgmhfTQmbCauDThlE1kN97oipSoKENlpCdD5cOeVRsSGIf6luNau7pCEAn/EtsebMbYHNTaVyBxh0tNJSEhJNNZAVF2As1pHYgWdi6Ju6pPxuhP7rW+Pz2YyXV0evyxBo0txs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395987; c=relaxed/simple;
	bh=eF7ssQY3Gy21CwAhmYSgaNrkiuCVKaXgj6K+L8MWMqQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GwfPGgZu7GsoMx7sYVUcGw5a/fFmMiBZZe/6/pE3xal3QIZLRmJjpWkjhJGeiYP6nES0SEVBs7bZTCgXTEhos2wAsd6ovhd7iqysf1nDGCf1J02gfwiQrQXhsbAq6C9euEXPpuAEkWh/5NPKoewHYZ1axVUPML23xSFeN4wJDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1KwtR3TE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so719063276.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395985; x=1711000785; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N0sG6qEZhABASQQZa8hhsLFbDsdErIcnzVgtt+v1EnQ=;
        b=1KwtR3TEbz2pSx9I9DDjVy11CEvYU64Rzy844tjN5ONp2k/nPVi/ktdpS4m8rtwHPL
         2ikDADxVUISluJ/OFc6K0BcI96NW9UIW44bsXzAxoyl5vtHUOmqKFSMBbpe+TEHFpvYJ
         CAkaz+z5l8j5llIEPhqunJtOvQkfyuT6uaWs/1O2dG4HPq3upTWoVekoz0LVHJ2lrfw0
         vsZPFswO32sPmLWHScrVoY57VAE4kMSBpM4gSB+ezghihUP71fCYI33lJb7SFETl0Xvv
         9gKW6MaPi4wbpgTjSrtdoB+45L6owFqb3xFVoe/ifg2bJyS33Xxzpws9OF/HieL7LKg7
         YJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395985; x=1711000785;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N0sG6qEZhABASQQZa8hhsLFbDsdErIcnzVgtt+v1EnQ=;
        b=kbFXXmggWeEruiCQAjv6lA4wO/b6RR0KUbIcfn565LhIStS7QVQGQKt6KLGW76bnBY
         Rp9kmRVNRvrAken5dNkqjZ/AK9BaS2pOJTOMRlkg3o/MZbPMDCZtg75XuVUh73klx8jn
         VmZHhog8JDCZw3v0Icuo1CHCjeCrFfZLmpx9GmaOgWwrYwbFoswUbzh51sRvkqTha7/e
         Vd+qyVUN4zlhmOueGDwN8iiIyLv1sD8popr9z9PEtlrRK1l3QJVAk2WjXt5DroXRLHxv
         9A8uuZl5uU8VUMp6v/sCNKaE4hSUSBpinvx5ll3kJnOu0ZxMzncqGb8ON8IHXEyFrKZ1
         /poQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGHUuuASsi0KWX2YCQmZIwEMm5IKf9rv0EDyt2OM+sImHRBCjdXx6Pib8ZdaCk8V2DlCGgR0SjrEo3qRpMctmQaK1spYH3k2ay92WQ
X-Gm-Message-State: AOJu0YwAY3X5JUnn5J/hE7t/mPPIpB/BjHJAvN2s+seCW03wYoDBvkka
	2Lfm8jp02Z19moLHgpTC5wWM10S4cu3beBUoyLMMZ+M0fQBUhHrTw2ttT0vlXXjPViqFqitizQx
	NhjKBzQ==
X-Google-Smtp-Source: AGHT+IHL6Y/lYpr4DVd9H5tWZ6+PnYPxXSSQjocWmXv3H8ehp9WgmcYOHntDqL0eAQFrhyAS4KgtIKhOXyZC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:1a46:b0:dc7:66ec:9038 with SMTP
 id cy6-20020a0569021a4600b00dc766ec9038mr20440ybb.1.1710395985568; Wed, 13
 Mar 2024 22:59:45 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:59:03 -0700
In-Reply-To: <20240314055919.1979781-1-irogers@google.com>
Message-Id: <20240314055919.1979781-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055919.1979781-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 04/20] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 03312cd6d491..e1847cccfdb0 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -8,10 +8,12 @@ import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_pmus = set()
 all_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_pmus
   global all_events
   all_events = {
       "context\-switches",
@@ -24,12 +26,18 @@ def LoadEvents(directory: str) -> None:
     filename = os.fsdecode(file)
     if filename.endswith(".json"):
       for x in json.load(open(f"{directory}/{filename}")):
+        if "Unit" in x:
+          all_pmus.add(x["Unit"])
         if "EventName" in x:
           all_events.add(x["EventName"])
         elif "ArchStdEvent" in x:
           all_events.add(x["ArchStdEvent"])
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.44.0.278.ge034bb2e1d-goog


