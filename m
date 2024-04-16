Return-Path: <linux-kernel+bounces-146326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1CF8A638B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBF61C20AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 06:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD243D551;
	Tue, 16 Apr 2024 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4zthJnQ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889EF6CDC4
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248157; cv=none; b=L9ZtUHNh7NSw/0NHeJvgR+hkirCcixiep1ksOT5lYtmC7SfictauZLwdVfgZH5MQ7JameRRpHFh67ineCYlx7v7EG/4TQDDd/ByVnToT6MDWtwkcct93AagscFf01MgqxKR1FBIjarGQUqKDVWNwkxvzrCDutvroAXGOfROA3Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248157; c=relaxed/simple;
	bh=jUPnR8Eh1nwHTyI5wvU5SHFzAhN1eHw5S1/Bwquryzg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fCKcpY+g92RF9EWDeJzwGHTy+PPzj34Iuiu/sLofKlaW986sG+9XH+GqBzQ9zzyDP1NEfY54woYpx2CCfcdkNxcEKN3KILOQ4e2rukgXQzoXfAZE9UW8R5RlHlg79Wh1E1xZ0SVx5Nay6Ktziy+LhsRkRMLD58zsSpaZRKQZo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4zthJnQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd041665bso68734237b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248156; x=1713852956; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=T4zthJnQjIgsQSTjSiNfDEarAik0KXjq92p6b3EBIeUPznZRCGJ4Ar/gsCIUiWkotW
         l6t5+Zji2uVxVHC7mPk/vGoTeOHyf2C0WSmpPNhDsudRIp5QrHfIDqmdqcpCPw14lMqs
         fpGRN4h6vnZWfH0OA56y9WRVmS21SML5rQDx/gXlzLAsoFbwoQk8EixnBRw5d7gYAzSA
         2bCM48y7m/rBQWwYisR65iZYGpANvn6zJp4HAm8WNrxTmPeWxmqJT7ztSLIKvz5nlEkJ
         GLcTiW7Wswmdn7TXiRDFaW/89eOzdOyT9qpb9AobL/xZP+8cVCzay3ZwGrz0oDkY+BF/
         RZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248156; x=1713852956;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=Xk+JdaAxGkzeFkA9oYnvCPW3H92s8Dm8PaaXKjiNv0Xnr0lAYdfxq3qG/iDuCwKYpn
         vUfFls+wzw10oR/net0t/OA/yB7FkTdnIV6SkVygOrsg3ncTbuUTcpTckXZXRPjUkAfu
         2FqB9YfdghRMrLM/BjRuMENZoDUgLow+xh9WeoHlGQTiehL/YDACH3qmwytfxN47R1UT
         5W3FqByDxeoXWPO2pJfqrvPhEk27CHs0FmaoLQh4S20J2Q2orgYUwn7i8dDM/3n427/z
         Oy2ZX+7dNl0WIVtLulwhuScQsbSLal8VT5gNYUrtEePdigjNMqVBv86DjH2WyEBmysGw
         Tytg==
X-Forwarded-Encrypted: i=1; AJvYcCU0TTJbOFDxKGJsKvBU+Ytz7OkpBc78Hn7jShCPZu1bTQ/UKBsqU1VOnyzHW2C3QY0sXFKTLgBrL9pj39uwo8vn+1ayI6KYbJjNhiqh
X-Gm-Message-State: AOJu0Yw5QJefuCbH5sQse/IAI6NlROpFoRcGAk8ztVHG18AOs8Bnh/4S
	qMkTGDwKVIeiFPKHZcFIe7C6xeJeKH0aapHIzu5ockl3mMGGpLmwgQCD7Cejg7pk8C/UgHxcIsb
	KsBW/fw==
X-Google-Smtp-Source: AGHT+IFvz2/ElMb8sqisE4iRWPUFBqPFEJev0kX5N83qt2rasL8K27n6w9ssQTNUocmaX8KnE4uhTcFVZFa+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1509:b0:dc2:398d:a671 with SMTP
 id q9-20020a056902150900b00dc2398da671mr3887166ybu.10.1713248155750; Mon, 15
 Apr 2024 23:15:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:21 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 05/16] perf tests parse-events: Use branches rather than cache-references
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Switch from cache-references to branches in test as Intel has a sysfs
event for cache-references and changing the priority for sysfs over
legacy causes the test to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0b70451451b3..993e482f094c 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -942,8 +942,8 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES)) {
-			/* cache-references + :u modifier */
+		    test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS)) {
+			/* branches + :u modifier */
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -2032,7 +2032,7 @@ static const struct evlist_test test__events[] = {
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,cache-references}:u,cycles:k",
+		.name  = "{faults:k,branches}:u,cycles:k",
 		.check = test__group2,
 		/* 9 */
 	},
-- 
2.44.0.683.g7961c838ac-goog


