Return-Path: <linux-kernel+bounces-88025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A186DC51
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC9628C36A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B655669E0C;
	Fri,  1 Mar 2024 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwkVXkq+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D5F69DEE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279231; cv=none; b=HiE48u0dYx6tWc+O9g/Juk/dgdyO5E8U6YBLsVisVBAiDE1qnueqrBqHOu/suTwlgfvdYzShVa04A+1bnogl4b+WD8EfRFGzYICQ3u1MJXSP2hQplqYbyFG/J6S5PAvNZc4zOvkjAotsXj8bmM5nOEHYu8wVj/fMyLvzYgUgFzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279231; c=relaxed/simple;
	bh=tJ5hV3qK33fMQXhssQ6GzZXnGcMVFTbMlJ9s5yCl8rw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=H4smrZNpuJNMqOkA8RA9xPAG2ZJJ/iZV9nMEsNychiIQ5kU9i8SudC1jcNTKPOPI7/fRVbNr0ZxqzUJt+y2HRzH9Asi6VtjDtdaou8OFbh1HNOVQc9pD4YN0pOrZPS5jPb/L7+SJt/iqgRFqj/bEMhws89hwcA8v/oKUPUXOOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwkVXkq+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60948e99cd4so27137117b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279228; x=1709884028; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cr3bvTQSOwUcL44V3OWG/EQ3k43z0nNlQO3ZPO+cuQ=;
        b=EwkVXkq+HbPb74rzNH68QmLtn6Ppye5ynfhaCcxaVindUJY2fnUUTxOl6phR/W9iis
         DSK1brP5QcrWwtx8RfU9RpOyBarasX8nAOqnHiMBchgWCJxQISUylYpnD5lIrHIm/K6b
         GdLrOQv4sRYp+EdxLOxb99MEoOXb/7TjaH63l4kJcyz2kXtbKVaAVPQ0mob1zHsfT/Ug
         hAMTRvHg2UluIa2p+HCZqnJeGst9UFhWVUYe1/bARNHYjI79upfvSeu7OKNSfviHR4CI
         FbDAJ8poWge5Oc70UzqbtyECHW3kttpR9aBWk+gMpICRN/P9Maa5MmWKH2nZ1Bc6Ob+X
         ZBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279228; x=1709884028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cr3bvTQSOwUcL44V3OWG/EQ3k43z0nNlQO3ZPO+cuQ=;
        b=IwdaRLrrej/Urb2NGftbzx5q0X4JUFinby2RfY/xe1E0jPEiV3j7WdTrFilTrQ8oqP
         bo3IUH97voV2heDhaF9R3p0Q85iSmiILtRoKfhiHWLlCDk1cKLnOFOl79v+jMgLakrvo
         msLEe8WNBkWs1zM45PdQrT+RmNfrxEeQAIlt1cd05K9s/WvF31V2fTSluuqRqqKyJ4TT
         QY8AHTqCLLHRygrL7pXM4nETEuZTQxkTbEQbvT8xjLnkxayMQRD/clmhoNwpKtom4g7/
         /T04OJPKNErOwfTwjL3ZkajPP7eMCpuuWtCwEJ2OyFLog9p6oDZFPqOpy+Q9cRUj29SW
         /Cjg==
X-Forwarded-Encrypted: i=1; AJvYcCXMZ9451sWl7mrjnPmLooqP9jM5w8U2vwCpFMOHeWPcMp2i/rio1NIPIPBLEWQxam4cYI5wcMBIBDJWL72/5fezXT9DR60yk5ytJS+H
X-Gm-Message-State: AOJu0YxaIy2wcoop2aL6nd6vcJRq7Tw5Zyud2I1i6P2C2EQpc4C9XXV/
	yirzotC1Wx9h9fstloimav46pSGDqx92qWa+L5goh5UH/AZxPk0W8OcjaTQjzXMihs2J+y7RckT
	FRbKW1Q==
X-Google-Smtp-Source: AGHT+IGz1E1c7M47HvG6AVrMNEVgIWHJwWURRdJYBFX7yDtVHORL5Dpa11qv+CBdBUGG0mIB6skYqMmLlkT9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:c92:b0:609:3bd3:31fd with SMTP id
 cm18-20020a05690c0c9200b006093bd331fdmr161226ywb.2.1709279228547; Thu, 29 Feb
 2024 23:47:08 -0800 (PST)
Date: Thu, 29 Feb 2024 23:46:39 -0800
In-Reply-To: <20240301074639.2260708-1-irogers@google.com>
Message-Id: <20240301074639.2260708-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 4/4] perf test: Read child test 10 times a second rather
 than 1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the perf test output smoother by timing out the poll of the child
process after 100ms rather than 1s.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e05b370b1e2b..ddb2f4e38ea5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -307,8 +307,8 @@ static int finish_test(struct child_test *child_test, int width)
 		char buf[512];
 		ssize_t len;
 
-		/* Poll to avoid excessive spinning, timeout set for 1000ms. */
-		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/1000);
+		/* Poll to avoid excessive spinning, timeout set for 100ms. */
+		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
 		if (!err_done && pfds[0].revents) {
 			errno = 0;
 			len = read(err, buf, sizeof(buf) - 1);
-- 
2.44.0.278.ge034bb2e1d-goog


