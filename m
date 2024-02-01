Return-Path: <linux-kernel+bounces-47420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284B8844DB7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B814F1F27D17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502EE5683;
	Thu,  1 Feb 2024 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l4UK/Ish"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC95399
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746540; cv=none; b=UoYtNTGhGODFQIYMk1USfksUHp/0QWArcVfGAIzwA9An2vmIHhApht+gAgTLRHm8K9aNQELrIrldATFuC856Zgb4vUKE0JMVkFpNpxD/ARmWDu07M7uZR02ss9FovSfe+HhaMU7gbgmqyhrN9EsisLEa0+6Rsy4a1T60KAhWdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746540; c=relaxed/simple;
	bh=BgbevzhY5rXwE/cxiO5W7UDDeP39KQp1tv4kTf0nGCo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZgigcNZeijLi/IpzuktfFrbyaERk67M8XVcxfCwvptrhH7u2dYGA5mwkZZd3K3wapRNFYTm/q4uet/CzCk+QQd5NubBVeQVpx6yNlz0YPgRn40PkdZOulozeqQRcpgQxwqx8Wjk4jdpAlmD5SyKCIzqv4fqO8MDb4i4RYUiJ2gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l4UK/Ish; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso7183437b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746537; x=1707351337; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjs9Prdq5u0ou9NuYNbnA11pYi3QUD5UfnclKxl1vhM=;
        b=l4UK/IshzIPonDImmOkfylXz83QurfCJ9ayFXyYzdYbolcbaDNC0dwFeSryJdbn/8e
         FaqVNZelNKeff4gNxtva8Ptb5+kDOGzadg3bd5iLdvzUzP+FQAb978pF1UI9/Q/sP9WL
         tiYstvYQZ7ZlY3RDobCqthx/sKUfhwtDYsS+KbCA6c9PPGDMQQ+ldB7ahbQfv6en8aJC
         Ee7iq9aF29+SwBke4zsGPir/noCXzGzwuihMmW+c6F7csAVa5tFlgTrMvZ4HHKlqUVsy
         kjw4eyDLbwPlpKaXwLFVGqExLuQ+G7CPrKypX05b/Gi9IUYHzomu5jfs9k6gyJ+ucUJg
         N1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746537; x=1707351337;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjs9Prdq5u0ou9NuYNbnA11pYi3QUD5UfnclKxl1vhM=;
        b=jPWpzQ71YZGNFRANjCEXq1uIDRu/xcJguHQ0LE8JwRQtQ1IANIIF+MPqg3FvNkuB01
         H75lxf4C3ksUPMmwpKhZCbgZ6qD8vS4otPi4TAy/Uwme7S+5WFtlLlSPFv1a26JnijvD
         J3s2H6r9BugzXhBIL5BjfzkTAX51UCjx8ED/K9Ibsn3/YuUmexUOgevsl20tOdx2JOQs
         4VoAXVb9WMxdMLVBnZqC9HslbByjHnUXLhwK294KeC9Zq+/jH0qYGxHkKn4McVEa5OVE
         6m+Aha20/hh9dKF8ZbKC3OvmvbxnL6DXQzvQkjvRoqp0IBcnNQugIHzcgRDDS1Cgn2vs
         Xc/w==
X-Gm-Message-State: AOJu0YzkpRY6qu/w+BhCcCKhYnm/tSNLH+/R4MjrZzRixvhTb4+KUBtQ
	cY0aKk37yimAI44czcuOSUdLM0m2ykgNe0sZhDYHFZaXblHI4MzLPtLGDn5NVFbsMKsAfAMQPfI
	5mcCTtA==
X-Google-Smtp-Source: AGHT+IG9f55j5uLbOnosxQV9gtm60AVV6VLPCDRs6eZec5XZgYDiDclOGHQZ3LhLStMno2rqZyYBHJGAGdPv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a81:9b4d:0:b0:604:5ca:5ab2 with SMTP id
 s74-20020a819b4d000000b0060405ca5ab2mr727828ywg.9.1706746537532; Wed, 31 Jan
 2024 16:15:37 -0800 (PST)
Date: Wed, 31 Jan 2024 16:15:02 -0800
In-Reply-To: <20240201001504.1348511-1-irogers@google.com>
Message-Id: <20240201001504.1348511-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201001504.1348511-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 8/9] perf srcline: Add missed addr2line closes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

The child_process for addr2line sets in and out to -1 so that pipes
get created. It is the caller's responsibility to close the pipes,
finish_command doesn't do it. Add the missed closes.

Fixes: b3801e791231 ("perf srcline: Simplify addr2line subprocess")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 034b496df297..7addc34afcf5 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -399,6 +399,8 @@ static void addr2line_subprocess_cleanup(struct child_process *a2l)
 		kill(a2l->pid, SIGKILL);
 		finish_command(a2l); /* ignore result, we don't care */
 		a2l->pid = -1;
+		close(a2l->in);
+		close(a2l->out);
 	}
 
 	free(a2l);
-- 
2.43.0.429.g432eaa2c6b-goog


