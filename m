Return-Path: <linux-kernel+bounces-59963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B4A84FDF1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ACBC1F22226
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F36D52D;
	Fri,  9 Feb 2024 20:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKSu/MlE"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96914F75
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511816; cv=none; b=DMrJ6zVvNptUCnMHYzXLKpF7DZuJ1FU0ERil6aIxvKtBkuMRUBbbIrvpmu/cBoulmY4hOle9Z5YwkfPJ8W0wEUhJ87lWcRcnfdvgP3K8VMhKO56Oxfy7eAQi1SXY2zHxCvoUc1X/OWBOnRuC8GpVbzEWXO/ZBivtdrzcUTdphM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511816; c=relaxed/simple;
	bh=CbVycyAyqWnjOhqGXZ0kFJxI7/ZRDcDTc9Vb1+mg4QU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m1qrnPaBcTBk38My2I6q0/fl0VcOVoMugpLtTz5ReqYdF1FWoEcWFkhk8B0UFQYlNv1icaGEQdDywZ8b7BLhTPzlJQHrpxvF/ITmfgejGTIGVVQ4udUNhQXhI1dcFdo9hk1v6KwuLn9+eQmL3/N5bd/PGxbVsNIICqBuOFWRosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKSu/MlE; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso1987569276.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707511814; x=1708116614; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qR84mNrslfcjY8XyWDHEQaLVA/4KGd9xMsI7WbfV4Ig=;
        b=NKSu/MlEPjqRlXp2ajUFxbptngSq73PdhmcXYYJQxXkCeNkHLDQvO5N7rRS3KsAmO+
         l8eVBCYgMTl3TT6A0utsFOZtMbPfLzbbMuUC+8Ew8d18IS0Lz9T/u9KeEbDoQ60K+lEl
         QbvvNlTkfnDKt6zgOSU4CumTyXtONpNBVB+Pn7oz3h31Nvgz4Gw1xcs7uHCXYzPoeEQd
         fM0LcnaRATYRZAjWslvZ1qtc+DT+YqTb97/dHTzR1Pw3hp03h6jWr3AYP6fWHWBI3bNS
         kZrzhMLva2jF/76kLLSwtJr9hRUB0zTTgXBgpYxj/1KNffiF1c24A2Zk4z1D3Sw6gnkF
         yr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707511814; x=1708116614;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qR84mNrslfcjY8XyWDHEQaLVA/4KGd9xMsI7WbfV4Ig=;
        b=Wiqiz+ZLIkJ0OUfM1/RAr4iI0V1D0E6ptKbplW11mKatpCj7WT5Mn9bCNHlWwFLNHt
         wNe9V6X1FBZMnm5TVfvKAZIc6KsZusXlM45ve6SDfxTRBgoBJEpQDVNiBqzLoLmfSzF/
         5C2SS4V4c9yCPi3oOxx7OMfS33CPvWrqJzCMERihqsd3UC33nnBzibAbR3DHfuNb/S9T
         hTEyF/GMfEbypgdoMUZbMU1cjO+OFOqKLsP+G5R5DjBlwiSaRNU5gt7AN4S8dP+zFcSc
         MMmpv05bJsRViKXZsK9OwzL5pXimA1rT416okxKMSC5O99bxDYqyAimmRxUHaKfnZV4t
         cI8w==
X-Forwarded-Encrypted: i=1; AJvYcCUmm/V6tqgYFv5YDn/fuMGj01bk6dSLWM79chnw5XcFaLHNvRin4jcGfMlJ8UjtShiiKdb9DfdfHiWQwI554DWY/678BIXTF/6nG2X8
X-Gm-Message-State: AOJu0YzC7dSI28wRmIF+i4La4gZQFOOFjW9kkr5IwBEL0kIOKZOY3T1a
	rJ+g4DGEtJeJQbPag8XZeVft/ZNSUlmw22/zXvJqGH/2cZs9WU5y0vSaqoEyy8R3Qgz1sAKnpny
	kbJp/Xg==
X-Google-Smtp-Source: AGHT+IGG1Rxf3SMcCpxfxkRqDUz7dHOOD8Ki4rNA4wYhKtISteoWwvV3FknwBD0NosqhldKZg4qJbWokC5mc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:877:241d:8c35:1c5b])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:b0:dc7:59d9:7b46 with SMTP id
 k9-20020a056902070900b00dc759d97b46mr11144ybt.3.1707511813991; Fri, 09 Feb
 2024 12:50:13 -0800 (PST)
Date: Fri,  9 Feb 2024 12:49:45 -0800
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
Message-Id: <20240209204947.3873294-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209204947.3873294-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 2/4] perf expr: Fix "has_event" function for metric style events
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

Events in metrics cannot use '/' as a separator, it would be
recognized as a divide, so they use '@'. The '@' is recognized in the
metricgroups code and changed to '/', do the same in the has_event
function so that the parsing is only tried without the @s.

Fixes: 4a4a9bf9075f ("perf expr: Add has_event function")
Signed-off-by: Ian Rogers <irogers@google.com>
---
Note, this fixes a has_event issue but as no metrics currently use
metric style events like cpu@inst_retired.any@ no current metrics are
broken.
---
 tools/perf/util/expr.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7be23b3ac082..b8875aac8f87 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -500,7 +500,25 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	tmp = evlist__new();
 	if (!tmp)
 		return NAN;
-	ret = parse_event(tmp, id) ? 0 : 1;
+
+	if (strchr(id, '@')) {
+		char *tmp_id, *p;
+
+		tmp_id = strdup(id);
+		if (!tmp_id) {
+			ret = NAN;
+			goto out;
+		}
+		p = strchr(tmp_id, '@');
+		*p = '/';
+		p = strrchr(tmp_id, '@');
+		*p = '/';
+		ret = parse_event(tmp, tmp_id) ? 0 : 1;
+		free(tmp_id);
+	} else {
+		ret = parse_event(tmp, id) ? 0 : 1;
+	}
+out:
 	evlist__delete(tmp);
 	return ret;
 }
-- 
2.43.0.687.g38aa6559b0-goog


