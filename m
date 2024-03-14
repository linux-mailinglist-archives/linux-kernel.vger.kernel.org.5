Return-Path: <linux-kernel+bounces-102817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5733887B784
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12184285AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1C6D27E;
	Thu, 14 Mar 2024 05:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8azedEn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AD012B93
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395928; cv=none; b=g7OgkxOMIf+nocq8/XC/H0Z2t0c6382V5jO7h8V5SuktSmMXsmvczYTbb/yuRQVPWzgv+/Gs/HZV640YZKtUFM5K8TOkDVaaCtw/IIQQD421ifjZJ/KML+KQ/WxvrtDt1FD0MgDdf8cyYfsQk+EgrOyiDB2lcs108Bf+dw0OQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395928; c=relaxed/simple;
	bh=SFnRyJCMSz3NfZEXGVAhzmYKO+L+zCZbOzEJqp9PJWE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fngCiUKhNUU4QzD2EraH42RYN9vze5Cf+tLvFt40MX+JVXCx/64nvhGNaOZhCO1HH8iH8ayx9z/05qO/0wY2EfT8QRkgexZA1ZsILoNjmGeo4Zh2iVNxuoliG7MJQoPX4eE1zqEtGdmZicAM9asY5/u4EkUuFs2OjOBWAsM9IzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8azedEn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so680552276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395926; x=1711000726; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YRB7kOoDxawdK6VhegAiSGEkcLRIKP4KVDKeyUalc2o=;
        b=s8azedEn+KepevEJX5SpN2PVrfhM+EzZ2YoM+nqIX+KjwHACI4ScxbPxM4YCPrhREN
         dJCATYpUPo15TipzFE9qx0qUtkFPHXyhMcxORm+e+7P3yOJ93JwZ8OPh/RW/U942RWae
         CFwdqWAjKmskQXT7voGFuSY3kW+ZQ10kllsDy19drUI5sXTcESUt7vBywQZnvXgHb9p0
         Jcal4Ukmhr9O27pKh/HnD1OTA4Ssfc35OC4iLDwNSnIfcC8z2r37B/sDWnn2l4GZMYWT
         B8hngklhgSIaTzbFWpAmm9+7NrX7K7KqyKw0D2Pf1YgFbk35hxeHVUDTGjOXTOFxQzDf
         5AiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395926; x=1711000726;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRB7kOoDxawdK6VhegAiSGEkcLRIKP4KVDKeyUalc2o=;
        b=I6VjcS5/3X9EGtoNOwpVUcm+RGGs01eoEX/vLk52ky+t4DZDrPiEvPYUTKilL/i5zM
         JwSOmSV6NG5iCR7KQad8gNd8EeDAou71NMjZpvJkibdcrBcgJDn+Vloi5wM09hiHndU8
         Lb285KByBc1WrGlZWOQw0CQ7w0BV4geMez4N3PEMrpLXseuA8UkSQlCyapkc3Ym512Fr
         VWcjK19zpisrKhEq1dgjl29jDBNpeLFBHD5GrbX2TKNMyTSN4pLsbLeaUB/SBLnYK4um
         bUEzCYoBTN/GNVLWwnwsZ176/f/7I6Tn1gRwTpAuC7XHMcLAJ+5lCEAjMETUdjSFTkBI
         kKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5i8CPTDzP4FTrh4ScNhV0VoSBt6B4opML+wDPmDQaDFSjcJ1OiX5UR/yvWT6uRSXyqGSXxMiO3oaMWWPD9wZoz0Jy9qvpGsi3sVBe
X-Gm-Message-State: AOJu0Yy0nTo0nNvFRq/jH+r5Dsh9pt+LZVOsMz2z7BiOsf1xNxnNuo7K
	ZLT5IApB8GnpeoVJ2QuR+W/RFi7XTsAkCVnUwOBkoO7vdkhElu6+xc4rRby4KPOi+u57HW1pZf5
	bhRqyOQ==
X-Google-Smtp-Source: AGHT+IESxgUgX1pBvQfMCDwvjsv/KfQ7yj04DfqqVzEGVI0jCFmxm55cadYn7E1/0zQS7Hl11sRsvaJk7u9E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a05:6902:240e:b0:dbe:387d:a8ef with SMTP
 id dr14-20020a056902240e00b00dbe387da8efmr22603ybb.1.1710395925934; Wed, 13
 Mar 2024 22:58:45 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:27 -0700
Message-Id: <20240314055839.1975063-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 00/12] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240314055051.1960527-1-irogers@google.com/

v3. Some minor code cleanup changes.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.

Ian Rogers (12):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD

 tools/perf/pmu-events/amd_metrics.py | 630 ++++++++++++++++++++++++++-
 1 file changed, 627 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


