Return-Path: <linux-kernel+bounces-64801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2728542FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B5F285A12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2E218038;
	Wed, 14 Feb 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNGnupZf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF2017585
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892657; cv=none; b=BKuF3gtHj0kb1xCBW8bgaNat95locRyRuOIKx1FfftM87ypAbC9eOwqHc4usxTBu1LmHfrDAqQrPWm1ZekIlYXeehO3GJ/RXmTMNmdfOqpT3wEmc0PTJXC84Tvq+zw8Yp4tz44oGeWF8YCu1oNuNA9PEMRiTPfk0jrJWGox6noY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892657; c=relaxed/simple;
	bh=UV01xgO1m+X1+w1j0tsdOivqonwgpzUr5TVWVuyCS+c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dTsZGbShoOgkSc9KVU+npfrjLHvVwA/tX/fMR4ihSCfpj34zSkhraANbCc7w+KkpuMQRTjc25CHQEvOJSybXKjXhXFZUJyuwfas+XqeAEX4KKoH79lcGnHfQ0mAosURBioSUBmawXfD6VcpXGU+e0+bSQLzlF46HM87IUZO5XiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNGnupZf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso2588826276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892654; x=1708497454; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fauoScqMGb0T6W+waGwPLd0PTd+mrpoq3alj54i0j8Y=;
        b=dNGnupZf2D5yXYxrAoxIUNakQIi2pIcolGJADLKmjdaanYrjGbyFJGbA2Z18wCEyZi
         QmRcAtWjA0x0Y9ryuD2mTHRFsxAuj71EfkdBPfYyrap+WIKqyoWGJxzIAbvG/nAvUc5P
         0Ilh3V3hwGbpMN20G/l/V+5TKBGgnsXdmJ7hu+JkEX9shCxK41AD3kuLfIcrpna67m9F
         Mcmg3zCBL+DqBKykhwSXYIi1oMiZUh2C3YjHb9f4Y8FE/3rIwz6eB8tatUyKylnCbNlp
         4G5QJgsP7UUqV5sP5ZrrkllSDQP9ihbtSuy17djfN6m8ySPs6D93UeJumEP5zGy8vDce
         xz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892654; x=1708497454;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fauoScqMGb0T6W+waGwPLd0PTd+mrpoq3alj54i0j8Y=;
        b=bKj5sQNKaSNvubBF1xWWwBOOQqwnZ5djerU1vqyrmX/IZ7cKqb2t8vmfUg9oQAG33g
         M5V0JyCkmwVvGJt7a7XCTA+QWENpfiP5SP47x0nLuqU6OnIalQ/ECKT+Pbh/BpTYdz30
         /3Y55pAmQDStvKTM49mCeDVxN7bhiId4+mDn73BGjMMBUrgwiza7/JD+cIr5RzfFGLBt
         uJvmW/brqm21P+P5Xa7GPMXdplidr6V/apY7N9T6PoWQi6+AbIkqcUgSAMgGDX9sCBR1
         2na/PArQeKZQt+vAdZwzLFDtINb88X67ElWkiIdYiLtPk8+wZESG3ZN1tNLt4K1sQiDJ
         9UTg==
X-Forwarded-Encrypted: i=1; AJvYcCUA83uLMcB/0FqPbc3tNlUusGnzQHbdQGOSnKW8xsJrjy1pp8uAU0r0ExQDgQIO9aRYEG2+GqseiUkYoL5qu8/Li1vA8uqSO8LluwBh
X-Gm-Message-State: AOJu0Yz5PBgGADObwTBo17I/0oa9awOkbxOvEPZfBfpYl1OtGNFIj+Hq
	W4UREel+H3k80wR0EJOj1J3XF3tCiWw6YE6OlGNHGFjAIc4NN6IpY2IkPO1DcAm/HbSnqSNmSom
	+n+uOtA==
X-Google-Smtp-Source: AGHT+IFi3zXQvwnC/z5gX6vCW3M3+FZqgPpuASOu1UAfp5HpZ8Z2Ob9CLJ9tDZc3bIk+YeJf9imFZQHz+HCI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:120a:b0:dbe:d0a9:2be8 with SMTP
 id s10-20020a056902120a00b00dbed0a92be8mr57048ybu.0.1707892654638; Tue, 13
 Feb 2024 22:37:34 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:08 -0800
In-Reply-To: <20240214063708.972376-1-irogers@google.com>
Message-Id: <20240214063708.972376-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 6/6] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.43.0.687.g38aa6559b0-goog


