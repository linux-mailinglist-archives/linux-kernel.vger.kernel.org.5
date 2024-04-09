Return-Path: <linux-kernel+bounces-136137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5176B89D064
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0EBDB24C3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9DA6A340;
	Tue,  9 Apr 2024 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PthwBvX"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E325464A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629949; cv=none; b=SiE9yNW2UwsPZqHYGH+gyS2pyuEdBEGgIHhOoBGJcRxHDcwGRcOjlVhQLbY2kpu4wayih42n+tPBBg2MRhryoMMEnPlGyZxYT5Cu+W/vIN4O8vP4IAreF+tCLkGOwKRStjbFtlYvZEjt1hWD2UDwO7qrh7aUtWoVuT2fQvXiNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629949; c=relaxed/simple;
	bh=PL/A3WVadEL63FKjbVqnoa/RshNov2kFBvTQ0RAhX60=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Ep+q3h+HxNrYRVdAxT04u2tUMlK6b5x+GVkJTCB7n9kvPZKYack30G1qoay89/o49CKomHLgl/BT8VLZGUbH7ipldmMSXQACYEPVUN/fTIlUrg8dVfSsWCFITRqhBiFFkIly4lyEssWFi7hj4t8iBVNoub9NN3U/MnUSsQnNTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PthwBvX; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso7225386276.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712629947; x=1713234747; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4JjU99n3cntJzSuWKEHlCabsCaDKhMo8d9uJcAKSqpE=;
        b=1PthwBvXPHwvvmq6plmmvmLYVnOlygUuuRIINo98O3rrNKn0jObdQAfTok4aTPei3j
         XxRd+tcDDPf4pf7l4J6UQw3IJ+cbnFitt79aa+J9EUZYkMn6Fps9YKuaLfWO7s5LFcNS
         ktU5ez2sUtVi7XH+dNL64ESAS69nA8IAD31AdnzyWMQehJHlJii+LMo9S8TKTA369Pcn
         xmyRHXTLVYbNx8XknFWtmo9Ee/ifK79tiPt5uOK0fXK5j5hkwjmh1nOtEMbAGBp37aST
         oumd1fc5uy/1m//A1fepNCDQbGCy1UYYn23Vza9eb3fNf3dydx+udtWIKUGNdj5r5+BD
         G6TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629947; x=1713234747;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JjU99n3cntJzSuWKEHlCabsCaDKhMo8d9uJcAKSqpE=;
        b=xGDg1ZnWu4de4EvDq4SoXmmRpcLKW/w6h4joRlO9gljVTcpV2TuCRznooQUzFjxp+F
         KzvMRaDYP5aasanIkbLDjQpIQ90SS3bcKdAqVc9DxF3CeSOTPDwA1S2DY3WPyWDhjaEZ
         4P/w5GuSCeKCyIOljYDIpuJFqO0X6VHFqHErTVzKqJEP9URuGXWtJRxVVdizpdtc3grG
         xY1++iGckgGqbiEiIb2eeYGopHQ8O6gHpvh6KebG3Z9dYZG9HfsIAcJKbkBl9stqRbPg
         FSM7mYS+eb1V4dTF3u7aP/nopFpwU+wbEHFDiHRA5MbeuK3eIRAYyj2OhNkVpHbpaj+y
         xctw==
X-Forwarded-Encrypted: i=1; AJvYcCXCjJybhqVK2nWsV5xpWWfVBXHbs1yWOpokTlAJTC4/AfIustkPT/kvOTq9yNpTRpkhUOgVrtrcZ0Mvz8u4yevCoFISk6mSL9MwOJDV
X-Gm-Message-State: AOJu0YzdrYbldICsTZ4fDbPhmZlS+6ui2qH2snbYADjFjJ0sYD8Cd0q0
	XbqyqFMDnHRbenfMJPU+vZJLuUzZq6S10X3y9G6fDQfJ/AWZ05K7oO6rJTG+V9gHzOVnOwvfXTx
	PDZ44Iw==
X-Google-Smtp-Source: AGHT+IHrxNdg3AbPwFqBK+ciQlIUmbNjVBlMy/hHjaGqY4bavIjah0RyNlXtnMe94CNiX51z2K7BxkRbPJfh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5520:7788:6b7d:7115])
 (user=irogers job=sendgmr) by 2002:a25:a288:0:b0:dc9:5ef8:2b2d with SMTP id
 c8-20020a25a288000000b00dc95ef82b2dmr3131277ybi.4.1712629947067; Mon, 08 Apr
 2024 19:32:27 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:32:15 -0700
In-Reply-To: <20240409023216.2342032-1-irogers@google.com>
Message-Id: <20240409023216.2342032-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409023216.2342032-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 3/4] perf util: Add shellcheck to generate-cmdlist.sh
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shellcheck to generate-cmdlist.sh to avoid basic shell script
mistakes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index aec5a590e349..292170a99ab6 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -389,3 +389,17 @@ $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
 $(OUTPUT)util/list_sort.o: ../lib/list_sort.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
+
+ifdef SHELLCHECK
+  SHELL_TESTS := generate-cmdlist.sh
+  TEST_LOGS := $(SHELL_TESTS:%=%.shellcheck_log)
+else
+  SHELL_TESTS :=
+  TEST_LOGS :=
+endif
+
+$(OUTPUT)%.shellcheck_log: %
+	$(call rule_mkdir)
+	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
+
+perf-y += $(TEST_LOGS)
-- 
2.44.0.478.gd926399ef9-goog


