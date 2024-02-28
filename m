Return-Path: <linux-kernel+bounces-85475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88F86B682
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF89283903
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FF015E5C2;
	Wed, 28 Feb 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KB4hFA6Z"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13EF15B97D
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142999; cv=none; b=f5AN3PWUOubr80f5ZemixpKXAelB12tiG5zmRM7wrxfhJoT5EcijYYxhhDZ+opQgIpcmdVdC3RO6fpzKjzhADNoYmbVLgfMX+Ul96WgLKmpLPwOJ3YzKsfGoE5ALNO8Pybrwsj6lMDAsIstuBFE5pXIg9DNFcp6DS5X7eB2WmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142999; c=relaxed/simple;
	bh=cOSS/1Ua9wq56tvIpYDJ8CrDZP5VRQvshAeIJk9Xvn0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=SYdnt23twEm2luJNUDmmdKueM+LCzYpalW6U5SWJc5dsGfy+GWqG1eM+BiRcWdmolJUdxwv3Yn9BQwp7i+a3ZOKqDGQTUfymh/dJOg3yqFuV/6BqWUaKfkKGfD2FlKdA0INEHusot9zwxWtu8dvDovjhgEm668PR6lFDwTv3MMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KB4hFA6Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so139085276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709142996; x=1709747796; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7O4CvRNZfn+UEjOY44M9tpmLWuj++SEP/MSXm3BejXo=;
        b=KB4hFA6ZCGIjV8ZDZ2C0v5HaRiY8o0Qy0YM5AcnAQumXn1cumOjPgQtGhugxnJMt1H
         7p3Cn8R3FtD0iaiyb2Y5GL7oEjB4ZkyLvOPBUUsRWVjvmco2EjzRqo9UpiKjkDpRtWy7
         gcTeJD76av4aFtra5aamnDpi4IYTp+/T2SJqrmTb6XbvH9MImc0r7vyoXpQNGIcM81S5
         XzDf9PgcGhDbOQXGKBAaB4PiFAlEx3zqBGv6kbX8C5Lt6kgyeeFYODwuNnsXzZkAxeAI
         CmlrUVEvFaBiIq4/638I6Qlw6G/7bsuuCmsWSaN21me7TpGqw82HyRX00uJQCIiksMFc
         rReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142996; x=1709747796;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7O4CvRNZfn+UEjOY44M9tpmLWuj++SEP/MSXm3BejXo=;
        b=TrQnrxJRamqB3rKhBCVHRJE/nvG42i5NMZYdCNqEQzq3o4V0iqIA+73MImwH2w9LUo
         IVvh5D6HFCOfRYu8iY6v/PI8qw+hj+g8gu9ZyJKOvxm8+apfNqsGSTInGp8ATwkR0AKH
         WTfwaMzmncedwJMISlwHSos8IBDNg0nP4KrSA1O4YBQ3jmpG0ivbLSxgS7c/nL7hJMqy
         pTG36R3YeEKJKmKrhnCY99ULcCywSJZtrb0V9ub8V0/6w+0RQIA14hcljq2/uaYa91Q/
         K/1+IWJMHciQDDjf+hK87AkQ2CCNuMcTIERdJSSAHPXx9jTAZyM68HI7vR8rA4KMhv/x
         /1wA==
X-Forwarded-Encrypted: i=1; AJvYcCWJx96dQHYxfE6KZsjjDdG39YZeKlzx9AuZDGoi1oqlz9TQT17wHg62zKmr2cFkMUZwxPZzCK/CJGzNLRDBhpGAQhyJTPWx1ju/UzS2
X-Gm-Message-State: AOJu0YzOjq4lAJ0qGvaJGdPO9NRCs7Bx26hHbf4WGRJhou4iV+xeqg9i
	VZ5J6RBY9lvLKO/dclKUR5HsmgttIWCfXO4MbAM5nrNH2xrNv3Pss6acSk3IhjevR7kzk7wPj20
	jZwgHZg==
X-Google-Smtp-Source: AGHT+IHwE5Lde8r9OdRkQnnVGT5Vmdj0kN83iNwxsK7y0HzPs5jDUBlzWZZKIresVxcYRVTbmcpsx4U2SrNG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:72b:b0:dc7:68b5:4f3d with SMTP id
 l11-20020a056902072b00b00dc768b54f3dmr806170ybt.11.1709142996715; Wed, 28 Feb
 2024 09:56:36 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:05 -0800
Message-Id: <20240228175617.4049201-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 00/12] Foundations for metric generation with Python
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Sandipan Das <sandipan.das@amd.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics in the perf tool come in via json. Json doesn't allow
comments, line breaks, etc. making it an inconvenient way to write
metrics. Further, it is useful to detect when writing a metric that
the event specified is supported within the event json for a model.

These patches introduce infrastructure and fixes for the addition of
metrics written in python for Arm64, AMD Zen and Intel CPUs. Later
patches will introduce the metrics split apart by the vendor.

Ian Rogers (12):
  perf jevents: Allow multiple metricgroups.json files
  perf jevents: Update metric constraint support
  perf jevents: Add descriptions to metricgroup abstraction
  perf jevents: Allow metric groups not to be named
  perf jevents: Support parsing negative exponents
  perf jevents: Term list fix in event parsing
  perf jevents: Add threshold expressions to Metric
  perf jevents: Move json encoding to its own functions
  perf jevents: Drop duplicate pending metrics
  perf jevents: Skip optional metrics in metric group list
  perf jevents: Build support for generating metrics from python
  perf jevents: Add load event json to verify and allow fallbacks

 tools/perf/.gitignore                  |   2 +
 tools/perf/Makefile.perf               |  17 ++-
 tools/perf/pmu-events/Build            |  60 +++++++++-
 tools/perf/pmu-events/amd_metrics.py   |  22 ++++
 tools/perf/pmu-events/arm64_metrics.py |  23 ++++
 tools/perf/pmu-events/intel_metrics.py |  22 ++++
 tools/perf/pmu-events/jevents.py       |   6 +-
 tools/perf/pmu-events/metric.py        | 156 +++++++++++++++++++++----
 tools/perf/pmu-events/metric_test.py   |   4 +
 9 files changed, 277 insertions(+), 35 deletions(-)
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py

-- 
2.44.0.278.ge034bb2e1d-goog


