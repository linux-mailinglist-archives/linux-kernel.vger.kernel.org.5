Return-Path: <linux-kernel+bounces-109678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37160881C48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B00A1C214C0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECA577F26;
	Thu, 21 Mar 2024 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kVoRj+i/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC486A8B0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000853; cv=none; b=EJL7mNeJVIegoXdHhXzgSyKVumRxd42rS2CwhA4blEA0vhliZVqbp+LX5PpZXjXgSTL/K7yZUynxQbW4ogf0F5PJxid3AxqrISYjTK4knp21aWrWykROKY17ZmUIHs4swsi31lflWxiyzw9fdZ7QQmEZSUlmb6PiXpjqX1a6Jak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000853; c=relaxed/simple;
	bh=3CUuWN5mFedE06XRtzvoq6eeNhNZk6t9nHea5VIKcJo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=O5r/rPhkJ++a0YI/7lbeGmM2QUI0HXA7eVJo9dnpSPDZIyH3u2vf+p8Lv2BkQ0xHfXdxJsBJL4AaE5LY+1V5msNzo6+sPcuapU8UsoFQTH4LW378ITfyCLMr3yl6L3i6UQ4+yCUamIhL+igknOWysnSAbdUtWkIECYGFC9CD2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kVoRj+i/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cc00203faso10241657b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000850; x=1711605650; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=np2QumN1h6fgxnCGlgp+PMqcKtDylkaJb74jkcWyG60=;
        b=kVoRj+i/q7NYCE1oKlbw4vD2l/2Y7epSBSHXF1qYExVJ/5aw/kRbdsD3kspr9Z6MN3
         yWDd3Wv7Rdb+fky2bJ4Rt4N7xEmh5Q3O+F4MmM0RihFpqqBIf6SDqM2BbAyrsUWTIv5I
         qPLXVn+WtTlTHxdCKvB4XniJjmXKwmiWBTOGS0hfdKmjNAxW9BYjV0weTlTxRnRr76Kv
         7+bBRZjomeaRsIJUDSLIJAAQa/52Ktr1D1VDz7rjUqM+subQ0wGhjNT95QYMA/XTOXGt
         t7/FooBzMruY1K/McymXw7sxenBF0GFrar9lDPrtixEaDFz363UQBcZw/qBIISMQNRoq
         iCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000850; x=1711605650;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=np2QumN1h6fgxnCGlgp+PMqcKtDylkaJb74jkcWyG60=;
        b=LJoPmSHRKYIlHc8HLPIwa051SpCzll7RDhGmEvpRtC+0SXG1zcvjR6SKSMgzuHBzNz
         mFDjIKN1XKWSmOljgI/DfXZqOmwWe7sWuctI4AlgeiPnlq5z9srs2UJsrdWKcnx2cqCv
         DkAiTLlKTDB4DWhZlxpeKQPHzJTCLEg83o0976D56pF3wcBd0uEfc6P5uCdD3dyaYtyP
         eVr0saLp/8cVv453J5y5vvaGzZdSRRnpTMwXOLacNOEnIuxL0Kfg5IWLtKgVBELpt2hr
         GnFVeAmIOS9lYH+aYc9d6Ah2aw5zJjARyC1sCa7sL1bOhFJCZWwIjhM2vX4LfAjit2lA
         TDFg==
X-Forwarded-Encrypted: i=1; AJvYcCWy4N54iwim/QsVQUHBU9mseLUsa86niqu3rZeAkE57sDAGE/HJzp8OW1bByeZ0/A+dS6StoPJTz8Zw2zxEmg0tJvVBIYJoMqA3l5Yv
X-Gm-Message-State: AOJu0YzBv/41bMQKF9OL7eCwUllhPcKgT8zBFKkykvQUiMEEp9qhzX/7
	4zTJzaiLfic8iJIv79zXNtIYyCQWPRu3Lf+yEnaCw8gr6tA/hXrtmI/qaVtsbJyYMCrvY8SssgN
	V1yDcJA==
X-Google-Smtp-Source: AGHT+IEMZaiBjgcDfbrr2cJRYYtb5ejmmzSgg8cR1+i4Bw9QscRLqzUpcWHPm4DvnlHxrrrLxAulyBo5IWVC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a81:a0d7:0:b0:610:e3f8:fbb7 with SMTP id
 x206-20020a81a0d7000000b00610e3f8fbb7mr1308344ywg.7.1711000850690; Wed, 20
 Mar 2024 23:00:50 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:15 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 11/12] perf vendor events intel: Update snowridgex to 1.22
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from 1.21 to 1.22 as released in:
https://github.com/intel/perfmon/commit/ba4f96039f96231b51e3eb69d5a21e2b00f=
6de5b

Updates various descriptions and removes the event
UNC_IIO_NUM_REQ_FROM_CPU.IRP.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv            |  2 +-
 .../pmu-events/arch/x86/snowridgex/uncore-cache.json  |  4 ++--
 .../arch/x86/snowridgex/uncore-interconnect.json      |  6 +++---
 .../pmu-events/arch/x86/snowridgex/uncore-io.json     | 11 -----------
 4 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-ev=
ents/arch/x86/mapfile.csv
index e67e7906b2cf..c372e3594a69 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -31,7 +31,7 @@ GenuineIntel-6-AF,v1.02,sierraforest,core
 GenuineIntel-6-(37|4A|4C|4D|5A),v15,silvermont,core
 GenuineIntel-6-(4E|5E|8E|9E|A5|A6),v58,skylake,core
 GenuineIntel-6-55-[01234],v1.33,skylakex,core
-GenuineIntel-6-86,v1.21,snowridgex,core
+GenuineIntel-6-86,v1.22,snowridgex,core
 GenuineIntel-6-8[CD],v1.15,tigerlake,core
 GenuineIntel-6-2C,v5,westmereep-dp,core
 GenuineIntel-6-25,v4,westmereep-sp,core
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json b/=
tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
index a68a5bb05c22..4090e4da1bd0 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-cache.json
@@ -1444,7 +1444,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.DATA_READ_LOCAL",
+        "BriefDescription": "This event is deprecated.",
         "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.DMND_READ_LOCAL",
@@ -1638,7 +1638,7 @@
         "Unit": "CHA"
     },
     {
-        "BriefDescription": "This event is deprecated. Refer to new event =
UNC_CHA_LLC_LOOKUP.RFO_LOCAL",
+        "BriefDescription": "This event is deprecated.",
         "Deprecated": "1",
         "EventCode": "0x34",
         "EventName": "UNC_CHA_LLC_LOOKUP.RFO_PREF_LOCAL",
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.=
json b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
index 7e2895f7fe3d..7cc3635b118b 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-interconnect.json
@@ -38,7 +38,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.CLFLUSH",
         "PerPkg": "1",
-        "PublicDescription": "Coherent Ops : CLFlush : Counts the number o=
f coherency related operations servied by the IRP",
+        "PublicDescription": "Coherent Ops : CLFlush : Counts the number o=
f coherency related operations serviced by the IRP",
         "UMask": "0x80",
         "Unit": "IRP"
     },
@@ -65,7 +65,7 @@
         "EventCode": "0x10",
         "EventName": "UNC_I_COHERENT_OPS.WBMTOI",
         "PerPkg": "1",
-        "PublicDescription": "Coherent Ops : WbMtoI : Counts the number of=
 coherency related operations servied by the IRP",
+        "PublicDescription": "Coherent Ops : WbMtoI : Counts the number of=
 coherency related operations serviced by the IRP",
         "UMask": "0x40",
         "Unit": "IRP"
     },
@@ -454,7 +454,7 @@
         "EventCode": "0x11",
         "EventName": "UNC_I_TRANSACTIONS.WRITES",
         "PerPkg": "1",
-        "PublicDescription": "Inbound Transaction Count : Writes : Counts =
the number of Inbound transactions from the IRP to the Uncore.  This can be=
 filtered based on request type in addition to the source queue.  Note the =
special filtering equation.  We do OR-reduction on the request type.  If th=
e SOURCE bit is set, then we also do AND qualification based on the source =
portID. : Trackes only write requests.  Each write request should have a pr=
efetch, so there is no need to explicitly track these requests.  For writes=
 that are tickled and have to retry, the counter will be incremented for ea=
ch retry.",
+        "PublicDescription": "Inbound Transaction Count : Writes : Counts =
the number of Inbound transactions from the IRP to the Uncore.  This can be=
 filtered based on request type in addition to the source queue.  Note the =
special filtering equation.  We do OR-reduction on the request type.  If th=
e SOURCE bit is set, then we also do AND qualification based on the source =
portID. : Tracks only write requests.  Each write request should have a pre=
fetch, so there is no need to explicitly track these requests.  For writes =
that are tickled and have to retry, the counter will be incremented for eac=
h retry.",
         "UMask": "0x2",
         "Unit": "IRP"
     },
diff --git a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json b/too=
ls/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
index ecdd6f0f8e8f..de156e499f56 100644
--- a/tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
+++ b/tools/perf/pmu-events/arch/x86/snowridgex/uncore-io.json
@@ -2505,17 +2505,6 @@
         "UMask": "0x10",
         "Unit": "IIO"
     },
-    {
-        "BriefDescription": "Number requests sent to PCIe from main die : =
From IRP",
-        "EventCode": "0xC2",
-        "EventName": "UNC_IIO_NUM_REQ_FROM_CPU.IRP",
-        "FCMask": "0x07",
-        "PerPkg": "1",
-        "PortMask": "0xFF",
-        "PublicDescription": "Number requests sent to PCIe from main die :=
 From IRP : Captures Posted/Non-posted allocations from IRP. i.e. either no=
n-confined P2P traffic or from the CPU",
-        "UMask": "0x1",
-        "Unit": "IIO"
-    },
     {
         "BriefDescription": "Number requests sent to PCIe from main die : =
From ITC",
         "EventCode": "0xC2",
--=20
2.44.0.396.g6e790dbe36-goog


