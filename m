Return-Path: <linux-kernel+bounces-91112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF568709B5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E79A1C20D41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FCB7BAEE;
	Mon,  4 Mar 2024 18:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rDvc6prN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BBA78B56
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577361; cv=none; b=c824nR0Rn6VtzEITRES9oXvLHfACA2Sp1dBmiLRKPiWc3HffKHJAmfYaiZtQXetqd3KijbRVd28dGSlaZ7S5UITnhmdHVoVaCu3F9mHxht8ZiMPs7Eh2SucOr8O5vcqTJkDm98FYZFzb942/uqPESLJ/D/OF9jCuE6bY9yDyoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577361; c=relaxed/simple;
	bh=CZkR57hQcQrkhGytXRM4xF2MlCqow8Z4OqCiQhiG4pA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=W1byjH+OltFj/emqaSzWnFHLyQk98y6G+3IKG/IyyJCX4dGQER7BVpB4ItmPlpZnJn3qvAzFHpcqtJh1SL7czcgpEhToaSocaJtVQayGK5FoXL2eTeYYEDcUnIwx6yv7b1eCsS87AUwbZqGRviHL5UxZdQuCUU5OStq7D9G/lpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rDvc6prN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc15b03287so6779681276.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 10:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577359; x=1710182159; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOWh+g9Q9JUhhGeaiBmqrvTn9QnADeOhoHMQtJtTZls=;
        b=rDvc6prNpLxCB+MakX9vEuH9dlbC2AuE3nfS0Nkk3Ey3RVXleVk4Yn4FCk+IYtuwFz
         xUJB0Duwj2ldtjAziGBuoFOR2Y5RP5ISK71JNttly3fJpKw33fBRxSDJZBs5ezSO+6kX
         JyrJBNagq3WSYFOn5hz7ufWAbrcLT/Fn25UPLPpqTsQ4lvUuDEQL/dSrkq9yNShShSxF
         2ErrdeWgKmCXJsmBo0LGNCbqY/WhBmC29/WXKkjnYBO+F7z8Nz/trBd/coCSbTfcnfGc
         6f7ITH3X0rq/vrNEehOSq+fYTUFxET6yKCzdc3ohmdo7wU4w+zbw8Aoy2+88KzazaGxi
         qYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577359; x=1710182159;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOWh+g9Q9JUhhGeaiBmqrvTn9QnADeOhoHMQtJtTZls=;
        b=X7EENLvlXOOv4wO6kqCARuZ2fsx2mVgoOz98tBFSSpyuwv8rTdEDx+CAEqgxPt3ewX
         xKM1tziiytQV2H0jQpHMJZtOg2TLy1ZrmcwlDc8ywA8uLSOG5D9DmzoFo9JkXtcmc+p1
         ZwY+WAF7E8HTHUzdopSgK059i4VImOcxFmq/usuNyWt0XdP2CSLDHBMf8SsMcYKfnvVL
         r8U3Ih9biwC0OjGf2XO6JwYtzCfL6g8/mjmwitM5YwkygH1z0um57mf140DtTE80ifYt
         v2/5kQpGr5qARpeM4JIIMjIVflVi57Tr0sUIXvQDekUpQ4z48n+IZgRbXBiYQMHkk4vY
         GTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQAbpX5pE/gWhgVxRt0cVllUJcGmxii2+MK/w0rNWimbO0EWPoN/BKGgv7LcYt9eDS7Qyxq0QozGSJRGquONVBycmQu3SWIQXXntPx
X-Gm-Message-State: AOJu0YwrshuUOKzFL1mBTp9s/o9FDOUyE0jIBDOjyAXV8+nTVqNz5rac
	T3qzPfc78SzUlSVj5/OC/p14xjrjrc+oIocj5+RexlCMNPsuAERThtUvcrzRySb1FsEZyo8svHq
	11MqrsQ==
X-Google-Smtp-Source: AGHT+IE2SlrqQrQFL7OXuBsWvTMEtUMAPbRLL8d7FVUTeuNn52rsc0zoGdrJkSWIIU0yIr/O/h7Z5okfZN6T
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:38b7:9cbf:f246:dafb])
 (user=irogers job=sendgmr) by 2002:a25:c794:0:b0:dcb:c2c0:b319 with SMTP id
 w142-20020a25c794000000b00dcbc2c0b319mr417162ybe.9.1709577359098; Mon, 04 Mar
 2024 10:35:59 -0800 (PST)
Date: Mon,  4 Mar 2024 10:35:19 -0800
In-Reply-To: <20240304183525.3222581-1-irogers@google.com>
Message-Id: <20240304183525.3222581-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240304183525.3222581-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 08/13] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Colin Ian King <colin.i.king@gmail.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, Leo Yan <leo.yan@linaro.org>, 
	Song Liu <song@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kan Liang <kan.liang@linux.intel.com>, German Gomez <german.gomez@arm.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.44.0.278.ge034bb2e1d-goog


