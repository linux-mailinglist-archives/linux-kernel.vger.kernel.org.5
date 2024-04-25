Return-Path: <linux-kernel+bounces-159323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EB68B2D25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5FB1C2194D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5523F86268;
	Thu, 25 Apr 2024 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qoa4adkT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB12599
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084458; cv=none; b=YDBi8iKAEkjxOL6Gje2M0d0ESv5d3NSr12lVcsn2/IRTTx7er5ChODxxe3gUtHSEVFQao7UjGymvA8xMx7GC+dJMOhEIU1EAoBuSVs3jw8+VKc4lj0faYkM9kTrI4Ckhb8uIjFlgOJ2HrED3LNA+/ab/3b+oh8v+TRsM0mMsYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084458; c=relaxed/simple;
	bh=u3et4SImCb3YPPJX9fDXXvlB2s1vG4/taao+OPDBknE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=pbJQyCuh5JrM2pKRAXXKH9rZ+4Le+NWS3kW4DVkqpLq2M2lk2ST6CwKVBhv7/LYb1p+2NBFKxxQFz4AdHHDQcyPeOAy5VlDcJBFHZkIf8KRRhiXvi5eHFjLuDHoS9oZMSqt7hKmf5RdV826gXHIE9gNJogqZNExvZj46qMZW8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qoa4adkT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61ae546adf3so24898647b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714084455; x=1714689255; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJJk73p5r9jx3t8Jke0lmFYDY3+/7qA+0Gxv92CMnvA=;
        b=Qoa4adkTKdEGzt79TRvuIifoI5taET5PjO5tgtqQ8tkUkEie9XIfBP2py+LNPRvw1A
         LhlITKWD84084uOyYlXsw9kBtCxTfDQNtlRKoHv/wmMI8w7wIM2CoTYzwN10m44BArew
         zqCsoJbunhCI+QeRWUb61tYy6Xcf74QqaRCF/fQ7s73zsMVIhyqzSOjPNl5pDNs8ygKR
         slFhYTzdu53j16WOn0BVIkzvNt1oSmEMOzcePNP0Le5Va49Y1jJCCH++pisy5G6nFjSA
         H+NVN9TpO/e2XU8pZxggmgKpqDcwN9KBIx8Gw3d3MYJjcdFlrDKh7mETLX5+nw+9Lwlx
         DWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084455; x=1714689255;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJJk73p5r9jx3t8Jke0lmFYDY3+/7qA+0Gxv92CMnvA=;
        b=VfVBVQcPkYT080ZGDMaA0l7sfMV77YaH0Mbja8SJ2+JWP+LVJ89IQ4aNYSU/fY72kj
         9YNpsztFTDAogeSaTI22unYjnJCcQ13b74HGyvHUIO8ffu1yBQOFiBiZSBOgpherNn0E
         txAVYJ+3nHBdycqhdekcAfcNljVQxEFDbkIB+0GyFtMrDASf9Ey7WB+aJFdyoGAjIDbX
         UAo+3iUwg+43Wn5d/NQQbu4XBjxDlVDQwkUQ7Knufn+NjlzJIPVNPlFAQBp7DWMs2m/V
         VcINS4Hso+Wy/gs4kQZoKlR3ZtBDLhAfhIUsS80El7PyxKQ3y17Ch8o9HDW7c/kt4ixO
         GaBw==
X-Forwarded-Encrypted: i=1; AJvYcCXDGEs5YaSwjaK8hNzcbwv3PcgUpcIZegI99i/F12ZLeyn9c6LJWF7J5WrQn0PdfGPg09l2Dm6D8CkxDgLy60w56dSvJmA4H2UScKEK
X-Gm-Message-State: AOJu0Yy1ywEJW5eyUedpETIGES28tFTJJWzdrf7HieOKdm33h93d2ZyY
	JSTQaqeW4GwRqQvezZqp/TLrfORBHvSinE0WTK7h9bMyHLj9BCSY4mM2OG9OcLYH9PR8rDO7e3l
	bbze+PA==
X-Google-Smtp-Source: AGHT+IESkc4K7XHM6bNS+4yg1KNJp7FaXL9c5WJvsUk5NRy2l3NzTgt7ORt5BdiPwvkajo96EI9OSQB3G0pD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8708:517d:aade:8c87])
 (user=irogers job=sendgmr) by 2002:a05:6902:1028:b0:de5:3003:4b64 with SMTP
 id x8-20020a056902102800b00de530034b64mr120115ybt.1.1714084454877; Thu, 25
 Apr 2024 15:34:14 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:34:03 -0700
Message-Id: <20240425223406.471120-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [RFC PATCH v1 0/3] Retirement latency perf stat support
From: Ian Rogers <irogers@google.com>
To: weilin.wang@intel.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Song Liu <song@kernel.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support 'R' as a retirement latency modifier on events. When present
the evsel will fork perf record and perf report commands, parsing the
perf report output as the count value. The intent is to do something
similar to Weilin's series:
https://lore.kernel.org/lkml/20240402214436.1409476-1-weilin.wang@intel.com/

While the 'R' and the retirement latency are Intel specific, in the
future I can imagine more evsel like commands that require child
processes. We can make the logic more generic at that point.

The code is untested on hardware that supports retirement latency, and
with metrics with retirement latency in them. The record is also of
sleep and various things need tweaking but I think v1 is good enough
for people to give input.

The first patch stops opening a dummy event for tool events. I came
across this while looking into the issue and we can likely just pick
it first. I kept it in the series for cleanliness sake.

The code has benefitted greatly from Weilin's work and Namhyung's
great review input.

Ian Rogers (3):
  perf evsel: Don't open tool events
  perf parse-events: Add a retirement latency modifier
  perf evsel: Add retirement latency event support

 tools/perf/util/evsel.c        | 186 ++++++++++++++++++++++++++++++++-
 tools/perf/util/evsel.h        |   4 +
 tools/perf/util/parse-events.c |   2 +
 tools/perf/util/parse-events.h |   1 +
 tools/perf/util/parse-events.l |   3 +-
 5 files changed, 192 insertions(+), 4 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


