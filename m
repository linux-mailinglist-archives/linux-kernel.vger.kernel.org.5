Return-Path: <linux-kernel+bounces-85479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B995186B686
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E3FB260D2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814E215E5AE;
	Wed, 28 Feb 2024 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcIKqnPO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385F161B5E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143007; cv=none; b=j+KOaNE1zK1HgYAZXrpmNUSMj9fN0VhxY4LZOnrxPurJ1FCfnJYmz2WSdtH9o6W1fTLsGguhljiaNL7hczSDvF8OQBageq9H+ohgj51YN5wVhwRpGlD4EhYzOxaKu6uefHXAP2b07UUHLCsmoeHt/X63At0LWXpxX0fOgcpllfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143007; c=relaxed/simple;
	bh=0IeSdmWuvcjIVBTAhF6kJkhdSlGmwLTCZHLsTn46VzI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uO1n0GKTrtTamyL3pvsB2fSCXb6+QGUtvTKP/z0JagA+tANQCbeaefD68tMVQ4YMbc6Bk3Z3W6qi39RoWsrTx8yv1s2W+uba/L7s1Lqr7+wrQDTR2CUSzRwbkQngEi/ViIBL0tfOUXyDZKUY68jqiNvwrwe/E+2o272WIorlfxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcIKqnPO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso461487b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709143005; x=1709747805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=kcIKqnPOKw9EJqisLSIhEUzgsmkv672BDsQe3FsP7iPJkgPtUuKr3zSuzI22hMErze
         ol43m/rT+lVrP3Z38szF6HI1bwWgQ6qYlLqA+EH3Y8WGHwfXf3vbSZjsTDyBdynBJAO1
         LkUJTQkGM2IcYc3vBusGr+lRhe2RlPWjz0NEhdehywATWRf4cMIJ01sG2y0c3OyDF+cP
         skf7RvD7RYv8tTNRSVqmUYzJIS8ww54wBKCtXCI5hLXODdYeY65qZjH9AT6It8g0flhJ
         dl2gXlssCjT269TaGmPB06M+3oV8b0ypyYhw3kgOLZ94Ezf9WozFsrFMIBoU/ZFuAdcj
         /kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143005; x=1709747805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0l9FS4zSa3KVc8IImImj1SVx9SNoPylTIMS2zSJSapM=;
        b=vpC8ezQUg9t7sRloF9dCGghG0+6OsNbJUJWtdkPPwE1qs0OZm0eNPzVT/aH7JEIeRk
         up1r+7kg5TcoVwrEbRUGcALQt5UjhJ6Uu+nsa4lmukVc2zgtxx3JaxO3ZBDCsSwT0b0u
         IWLAlDN2mRzYU+dZ3F2pP3IfE9oIDy/3RfvDkGVd4cZYqTRJYVD/noZqmMC6sOF8P3X4
         bPyEmSwVLu6U1IG+Ky2oXzyh/p4mbhRkqRyu0KnutA+9hwGMTOO8f3yRt7XAA+clnoiN
         FGKE3FEWGTpXZ7IZoxS9bIbWXUSrg1T6mtpuZCNuDBfRDMRCOZPrfQ0IMhuYgOFs3ABT
         z0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtLpk3hFDeLJLKv9KOs7w4aoJJzgr30+myyYaukRME1p+CUrfgY+NckRCwFN9jaeowM64bWEOhaZ/nXm7n2u+ThjexKVn1R7suMUof
X-Gm-Message-State: AOJu0YycmeI9OOoXBrH3wnoHM1CKUmiinZAT4YxDiNQoG/bKqBKddsKM
	o/9cOvkdWaRH3E/25Oc6EoeI3yMtEV4fAFWYVPxGWrdvIFCedt5Jz1EHPi0nTk+V01XKKNS+Wr4
	SaZ/xdA==
X-Google-Smtp-Source: AGHT+IHsINZA48Q5X3n2AH7IzCU/B3JkuS4FWrgQKBOEp5jVqhZwPNx3ucRHAcYfkHSetLWFo0hXmy99EfVQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a0d:cb10:0:b0:609:3c14:b700 with SMTP id
 n16-20020a0dcb10000000b006093c14b700mr601418ywd.5.1709143005547; Wed, 28 Feb
 2024 09:56:45 -0800 (PST)
Date: Wed, 28 Feb 2024 09:56:09 -0800
In-Reply-To: <20240228175617.4049201-1-irogers@google.com>
Message-Id: <20240228175617.4049201-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228175617.4049201-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 04/12] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.44.0.278.ge034bb2e1d-goog


