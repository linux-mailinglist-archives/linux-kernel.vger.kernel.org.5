Return-Path: <linux-kernel+bounces-85872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E590786BC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A229D288A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC5517CB;
	Thu, 29 Feb 2024 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wglfz99P"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF037E5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165612; cv=none; b=qKc6rhFQ2v0ZbXhYppNDq9mpTkeEqlslRtvbyH9NVigYolnfx68SuBtoRf++koFkUXrPKD17oZ9tcQEwBh/7BskNU8fOPUC3mrs032J2f+mX7gmsetRnlCh7b5ZE5iWdfvKFd6VKEiBe/WhMbZEctIFEz/lDfEQGBWo8KO5quAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165612; c=relaxed/simple;
	bh=DiQfpMa8lJ3Yy3nDuKHD3YLgV6KdpxbHfUerTaEQnlI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=BxlX3L13PdcvaGoXqqL8YZdoHefEUgr/y4r+z/930calj2ZHKkj3YLIUOOSUDxagBtAsnU2frG/oRIxI0MRqlg6QWN0l44eMg1rk62u5X8OpOkiUaZw0hPbzQQxAhocpoaMKD1sC7qRk6RKWCXlB6v+UBqjL+UyvqsZ6IbBEpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wglfz99P; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so664435276.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165610; x=1709770410; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ecAegdmUWetUlYDMpDDdMbez8oRVEzxOZ5mMUPLtCLQ=;
        b=wglfz99Ph503gggCqEWf6l8bg9PHfCGkgPO5b257uWlpqz96sfTVGW7N50UelLjs6x
         PbpTnOkYh7NRkI58nOW87nGfZGxVws+lQ1fgG47FLB/F7BssO8CsBM+B5WTnDK8chhGv
         tgxcylGPPB2hYyqjFGlUl9xYwGjubOsq5gUpOjUDOPdisJZBMdHqFIDq/d/Vq9Gg7aRm
         en0SmQf3Q6QFmkLW3pax5/uFkoPWkwyCScjnL7WexX6WHvJWjnvt2un0hOeDfE1/qs47
         6qwlsX+srBGXHHAWWrFnHM00kflB5/d3YsSTR+XCBFhkQ0eoY1PD4GJvw2bHYi5op4Hk
         CgZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165610; x=1709770410;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecAegdmUWetUlYDMpDDdMbez8oRVEzxOZ5mMUPLtCLQ=;
        b=hoQMJehJqB1GwToWHO89M2TPXasQOiz9MQalF5PoIrMZuv79d9yBZaKeyC7IitbXkx
         Iqd2pCN9aQJeAWEHtyHHkUuv4O0Qbf4pL4q+JkA7OhOsvY+yW1W+t79105dNXbe1uH0L
         GLfJXz6Imzi7K7JF/O1vFlhlseDcwGAutOjbqmJxZ+9crTepGHkrrSD/ZoP1iMsRBPWj
         IsaG4nxIsgKot5x/hoLhPWueEPmYaLWU642voAK/oeGO/jPfjgpLCddvU7FaAp2++QK2
         9xkGES17qxXxrhk2GrErKccE1OriIZDBkTvY1GTXS0Q6YCmmNQcnACqx8JyO/+r7idhx
         AnPA==
X-Forwarded-Encrypted: i=1; AJvYcCXr2RIWTn1vrGDezxPmCPhFSt821+ITUGAnjV+/v8aviS/QVHugPVUClupZNnx7q3yvq0EVU3BjrQ5DUUu1Qe4wM8pfh69Z4xT37haQ
X-Gm-Message-State: AOJu0YxN+QKbP69N1oyvMt8ZBs8eYRKGO/mkqIPv4BYtEOX31lTt91v7
	j2DDRnU92NDBdjTZ+rXEIiSATYUb1HMWwbdkayobmamEPPAZ/zCKJfe4Vg+FhzVv1t92DyI8B/t
	2Q0Nviw==
X-Google-Smtp-Source: AGHT+IG9uKix1jZ1tmh4G8sUS/J72z7l+3YfBXm14IKg6IrAneTpgyesYVQPG0UD7H1A4Kw4BhGTf9aaSILt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:72b:b0:dc7:68b5:4f3d with SMTP id
 l11-20020a056902072b00b00dc768b54f3dmr190345ybt.11.1709165610530; Wed, 28 Feb
 2024 16:13:30 -0800 (PST)
Date: Wed, 28 Feb 2024 16:13:23 -0800
Message-Id: <20240229001325.4157655-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 0/2] Python generated Arm64 metrics
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
https://lore.kernel.org/lkml/20240228175617.4049201-1-irogers@google.com/

Ian Rogers (2):
  perf jevents: Add collection of topdown like metrics for arm64
  perf jevents: Add cycles breakdown metric for arm64

 tools/perf/pmu-events/arm64_metrics.py | 163 ++++++++++++++++++++++++-
 1 file changed, 160 insertions(+), 3 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


