Return-Path: <linux-kernel+bounces-162989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F168B6311
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503FC28395B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77114290F;
	Mon, 29 Apr 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ovhFGgAX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57371420C8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420965; cv=none; b=Cvs2yj1LvLMn7JOz0GmTjb8k1n/7JO+ydb9ORUodoP1W37O6OtoZm5uY4Sb0ZQOD7y2/1nJp/742DC77UfIB96zEL0YQ8xdD2dOZknGx3XtE0K3NSVSyJMjR0L+/zevWGpKsnKCrh3X3ljMCl6Hg/xanSubqLJWsUXUtKBvxXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420965; c=relaxed/simple;
	bh=r6Q0nzWd1ZDsObAExwG1cgxL3ocuqsKb/0LPlEHr6oo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=L0Yb6u5ABQfMbDvcwsLw5362jnbKoV5DpxyL6PAqz4WDiagScZdb7BbC8jDitNpDGJHLuIEgnCyGgwqu2IgRpAjyHcgrnz4TPC1GTbj6zAdTzbN1hTy/xvTaWIDSK7N6pQif71vgQfvcu0JuNornDNsTp3LO2BakdzBuud8kjz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ovhFGgAX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de5a8638579so5807653276.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714420963; x=1715025763; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PG3MsFbzKXuMYVhzdetV6dfQOniDDSPTL8GyKyGGWq0=;
        b=ovhFGgAX6TmrLu2MF3CS/BJ0x3w+AdBj1m/zWBec2ruFTX1dXO4KnoA+pwOzYoWhmS
         DF5YSp4VFwW/FmgBbREGuLN0fsFahJPpBINbOnFEo0AMeOt+Hpez2STWWp2lhOWNU18D
         wpjaDMvwyrgdDwbrEXMVEIFNh5fLbn7R2ZHmUIzbolPY6uYFgpfKFX9UA5rskDIoJguq
         pkKuXUQrIMR3dU3RlQ+fmj6CdHtUWOuzVx5HBV7lk6mO5A9W0xt5UqeIOhFw5YWBPjP+
         SOnhGvXxyI4dTx6q7KCmjMymXiUiObvMu+UAzUarLdnnZ7Ks1v9PktLxiwd+C9H32Eyo
         LNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420963; x=1715025763;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PG3MsFbzKXuMYVhzdetV6dfQOniDDSPTL8GyKyGGWq0=;
        b=pwCvt1XQ3UD/VvDI/8WDL0OsWaUp9smbt0i8+J+vXWo0J+8ZVV2mFfEJ6ZUdZmrebD
         rWYg3pJGfojbAGn/+QwyQ4MEgSM6ZbatIVUj4Lr7fonPV7oBwn9f5Kt9AwZL8T9LFZXs
         3lGBifm7E8in0jEk7pXmQKaq1FC1VId7ZK9QlyFh5M72t6mzOThRadDYoaMYA2/gICoQ
         L61YUXz9ntr0rqPFiymiCJgyyY2qQ6j2hyVfMzhP0wi7w/Al8wflVywV3lM6eXDPkmkY
         qX7vBpAynrGerh82dAz4Sjx+MGrOGOak3ApULY93/zKluYO1S1YrPjn2ZkNRPIUteFTh
         tyoA==
X-Forwarded-Encrypted: i=1; AJvYcCWHrclO3co2TXm9A8B7V8+xLNTCsweeOntDic7JkjHXFdPdqu/EHpbXEjT4Zeyg5EtqZ0LhgygNscXO3fgaSDS5wfSNu2nEJtRN3qg9
X-Gm-Message-State: AOJu0Yw/OevF541lrsyCcwnMXeRn6VyZmj1a7ggXYCAsTNITjmxR9750
	bIFWJ9LYKb8EvgKdMO1FCeSeMD7LXbP+ssEIawGGlb4SMoHzWHeNjfl3uVS493k3WzC1usiHnjc
	8/Foz2g==
X-Google-Smtp-Source: AGHT+IH7v18SP6SyNvViyH58YP8Uh+9qXPeg/EpSjD89cxZN5TRvsLnjH+Am76ywHnuHqGFQl4RUJD7Y7rZS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c137:aa10:25e1:8f1e])
 (user=irogers job=sendgmr) by 2002:a25:ea44:0:b0:de5:53f2:f614 with SMTP id
 o4-20020a25ea44000000b00de553f2f614mr66567ybe.12.1714420962772; Mon, 29 Apr
 2024 13:02:42 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:02:21 -0700
In-Reply-To: <20240429200225.1271876-1-irogers@google.com>
Message-Id: <20240429200225.1271876-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429200225.1271876-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v3 2/6] perf Document: Sysfs event names must be lower or
 upper case
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

To avoid directory scans in perf it is going to be assumed that sysfs
event names are either lower or upper case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..e7efeab2ee83 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower or upper case event names in sysfs to avoid
+		scanning the directory. It is therefore required the
+		name of the event here is either lower or upper case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.44.0.769.g3c40516874-goog


