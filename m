Return-Path: <linux-kernel+bounces-59961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3CE84FDEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DA028AEDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5EFDF61;
	Fri,  9 Feb 2024 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0jSjilJ"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF04263B3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511811; cv=none; b=lmivtXsvLpUk/1u4PGhoztq2Fj8JzPkzslSqQu6KFVAgytNB2M9z159ZiX+bCblVAX8Zsb7yKklicxNFljkJ2/i1FMeYDBgrCGWsI3RMeqnezjIbpbj+e7YJasWY+6NsylfPftJH7knk55J9zPQp5cRlLMuowrUHY8DGwJErjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511811; c=relaxed/simple;
	bh=AWQhEFkQNqk0DJOWRxIBRwsWcI4uCFqmUyezjrNxX3E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=vD03w1sO14TYbW47ikzcdiSidRw7AKawQYsG1yI4vcUrFQer2SoJR0/cigenHXQH+p5vlzJPTzY3gLZ2Twuhr2nlvf5NKdL/hn2EGB4D+jbTGjcRvmsGj9ldoVf8RNiqc3nQeAdO68z1HEsLVEBDQ/N8GLo8Ldlfy6nJpNpJ1Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0jSjilJ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6049f6b7406so32494867b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511808; x=1708116608; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKzeACn/rbwniRnpt/iV4ZJI2z4DRKLR+RaQopldiAM=;
        b=q0jSjilJRJwC9fwNvGq78uMD2DwBwJitqgoHRkd+X9XLtF8ilOoE0CWRWNSpOHxpo0
         aCClgbP7S1p42Y+GqaQeQGyl28Zv4goSZ1DLRxikERO4IA3Q3DhUtZ2aEJZTxco3cu1Y
         AXWbzPt3ur+qGc82H1oLfuAF1JEQvW3wc6BAXKPkr5aOb9dziDEM4Ytf3gkE/N33ArOY
         dKimEN/ARaPX1dQAbhWaD6X1D/Ocixqzli35OKUJ2I1vjAQ+cKGMloJ3vO8gsauK7E1S
         U9sYvylRFew0gPLT8SyBKjiZg88FXQUao3H2BrK9YAssLmj/2lUzh6WzttmZQ9MBEvrD
         pNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511808; x=1708116608;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKzeACn/rbwniRnpt/iV4ZJI2z4DRKLR+RaQopldiAM=;
        b=Xa0bqUlvjwwFPaERg/RpEKo9oNdv1XeluvFsAvs0+nOLDS5Xf8M4RUb48svXRGjxu5
         w5V3fSNlLsKgzLkRkn0koL37u0cofqTm1pM8vWVuYdR8jpJDDFRVF1JFAVnaDJQ5gkVf
         TTHUAf+wb2dq4weZecGKxaYRXZnvl2UsYiRliMH1qUrkAowalG4euhrYzwxGjaWmtQio
         VcSufPg1ZmmNqqu9yrFiMc8UExwJTCwKEshJXHeOnJeoGf/znETakGzRmrBaVS1+bKKi
         SzAMO6WcsoU1OgJRTlTUjOjvYntUcYFVcilRudjhggWz0IfJtTGZJeYNLogL1SFKCYCZ
         uIgw==
X-Forwarded-Encrypted: i=1; AJvYcCWdWYvtX0a6HyZYfYTE58Ry2kFU0G3fi0ml6G+dMQDTcpCk6SkMXIXZlQeMaAUCpSgyr8C/WGlMlG0D3e4YYS5Y2c3YCOGVakjrmDsh
X-Gm-Message-State: AOJu0Yzd7or0L/JQRJO2QI0uoVpF6wR0H9MoMD/geFe3uq4EUZlzGXX4
	5F3ffpmXmvtB3eGyzcOV7YSo1WHeabEXYjraqLU3Ix2t9mlZwTRE3/EJss+HR5eluccqnDRH1ag
	V/V7/ag==
X-Google-Smtp-Source: AGHT+IGudD6Op2tEhoXmhrEvDE4Judp8qNeTd/bqcpbNtrTEVT5WVllu2tMEtZdLyG7zohzrrwQF6Qq2jUjo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:1109:b0:dc6:5396:c0d4 with SMTP
 id o9-20020a056902110900b00dc65396c0d4mr74616ybu.1.1707511808761; Fri, 09 Feb
 2024 12:50:08 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:43 -0800
Message-Id: <20240209204947.3873294-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 0/4] Fixes/improvements to metric output
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A small addition to allow NaNs to be encoded in metrics and then 3
fixes to various metric related issues.

Ian Rogers (4):
  perf expr: Allow NaN to be a valid number
  perf expr: Fix "has_event" function for metric style events
  perf stat: Avoid metric-only segv
  perf metric: Don't remove scale from counts

 tools/perf/util/expr.c         | 20 +++++++++++++++++++-
 tools/perf/util/expr.l         |  9 +++++++++
 tools/perf/util/stat-display.c |  2 +-
 tools/perf/util/stat-shadow.c  |  7 +------
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


