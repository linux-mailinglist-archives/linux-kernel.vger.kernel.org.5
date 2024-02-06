Return-Path: <linux-kernel+bounces-55745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E308B84C11B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D6A1C23C29
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E921CD36;
	Tue,  6 Feb 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1dPSKB+G"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659971CD2E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707263948; cv=none; b=kdcXzpu64ZLtvSci2dogm8m4RzHP56HjzMEI4JpheDfbtdA46NixuXZjpwl9EF3VvBrSz/A1wUNiIxWr2vVw1URfP1zivBWHVRDwrfbfaqOYKDso5cZCETro3o3bmI2HFaZKSKBiHnjYZkz48Bq/xk0BwlFJ4vKd8CNK72E6Mj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707263948; c=relaxed/simple;
	bh=J/QN8zKxBRKEaursFD0Y5X672RX9T9JXQd5PC4sd3i8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FTCBWVq3KTYzJ060zi7s/G3+wg3i0576d0NbXB9MVfwgMJuqO6b8HFsWlePANk2Z+YEhvcmDAa3GodyRGlW0Z1Ql3JPJD6cnPG5cTNK5gH1gazPMkpv/Li5BzXBywfoXpdHQe5HExaCQCiquVW5WaY+bu7xTXPNG3ZXJyurhU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1dPSKB+G; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5eba564eb3fso1294477b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707263946; x=1707868746; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BcvFG/3vRgvYTER/Aj2IaMSgKq/80efIXBEBLE9WTco=;
        b=1dPSKB+Gel2PpzNtC68eR1GoVZz8G4/qhp3TNd19ewayqAKBQstja4NhNFgYzxSMtX
         Vwujk0nVd/lgGH9QOFCWZ0RhAPtMRAIX3EkuBWppxasETtofXu/SVpgaEVdk9gcNOUjc
         zawiFIaGUooh4uV9rXVxfaXVs+avyW1iaEUz45JhEnJDYUDnWRxXhgGyQzfctwQPoUfa
         9jdV2BqD1x5iN8gWDmc0R/vm2AykA/u7LeVAtn9KeN09kbjFvEWuUE3I4Vx5fc4T8zoP
         7faqPed2mHTngj54MxGrhQ/95xextfQ3kA1A/GW9n/NA/pytXeU/I8lPKa6HEBFg/9Zo
         wGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707263946; x=1707868746;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcvFG/3vRgvYTER/Aj2IaMSgKq/80efIXBEBLE9WTco=;
        b=pBZEAPnujcdvuRozLoko6ObQzc3RQuWixp+rBibhrRTuBbO3WS4DbYhGGLcbO2INM3
         QbjCztF5bMBgGu6svnJvJgp/GhjeS84gxedMr7NVL9lZFJyCPFA+o2xto5EchtmUclWx
         3qYoeiHKng9oKxHQsmOOLkQcczMt6v20FXE0HgO/p+zJIRfNoslDCXI5UO5GEy++RZU5
         HXFWgBF3TxeulWPqAaGAbSfJn6n8E83wI8uRr1QpsiHJbaQtYrqjN2uXqkEvoehaFNNS
         OBFA5oziYmQnmvf9EdME6EctqGFvTs10dfFUXP67H+rwSMJGacBkXsBCmpIiP1LkC5iw
         iA0A==
X-Gm-Message-State: AOJu0YzbH17i2jhgnZ0KQvyN2hcRMiS6T9ijl7mtksoMUCSkchFCo1Es
	dCVjde8vKzuVqzQNZ2kBZbTbSai4rIInTLJo54Wvj7GrAQfqjxgCJ32HTI8/GFLRgYaCDvqpe/4
	yAOnp1A==
X-Google-Smtp-Source: AGHT+IESGOMBrNLysoqBfEec3Vp5mrNBDpipKfIEWH3i9r8/NRYTso38MmfMfZNYqoVy5gwpSx7XVVDq6+Nq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7842:a360:67f8:5683])
 (user=irogers job=sendgmr) by 2002:a81:9b82:0:b0:5fb:7e5b:b87f with SMTP id
 s124-20020a819b82000000b005fb7e5bb87fmr642235ywg.1.1707263946437; Tue, 06 Feb
 2024 15:59:06 -0800 (PST)
Date: Tue,  6 Feb 2024 15:59:02 -0800
Message-Id: <20240206235902.2917395-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1] perf kvm powerpc: Fix build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, 
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"

Updates to struct parse_events_error needed to be carried through to
PowerPC specific event parsing.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: fd7b8e8fb20f ("perf parse-events: Print all errors")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index d9a0ac1cdf30..c8357b571ccf 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -114,7 +114,7 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
 
 	parse_events_error__init(&err);
 	ret = parse_events(evlist, str, &err);
-	if (err.str)
+	if (ret)
 		parse_events_error__print(&err, "tracepoint");
 	parse_events_error__exit(&err);
 	return ret;
-- 
2.43.0.594.gd9cf4e227d-goog


