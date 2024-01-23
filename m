Return-Path: <linux-kernel+bounces-34439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D54837915
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7331F26C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27511474CE;
	Tue, 23 Jan 2024 00:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmr27no4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10CE1474A5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968383; cv=none; b=L2A9/8882Fr48P2m3Xve699v2SiUGEY0rujYjT5mr3U3FgNhkT6NrQ4EJL7XF9otvzoJ3vmZiFJf0YdoFHavk5pW824/ial71VxL+AFyt+EmbE2A9jGYG6Qy1avXlF3xgXlyFbY4gSRGXk1mUUTIVzGA4W2zV9GBeqh5HYxcZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968383; c=relaxed/simple;
	bh=IEvafp8noNqOSfOmOKDMTOQOH5/R9XopGqVio4nEPyc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZfiY1Rupx6uuqsUdpxS5P5H2V7YJ2ROvv+XT9uBz/ti66RJthhKX8mzdDKz1+DAY7I8bcn2RIGx4/zOC+SoUfndIs8i+MI1aZNKbiy15NtrqAfgwN5KmeHpjuyqxlLlVW4G3sAj2ks1z4/GHHuzoq/YlaPBv4JHZMznHMgp+tWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmr27no4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc24eb13fecso4685816276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705968381; x=1706573181; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q79azOTXwSlimUfkUpJ2p/ZsQdIQmqJ7jFQrY/iqycY=;
        b=gmr27no4HkxKA6Oy5axRfTVGcB5pDb4hJOHV1Xf8ZPXxlh2gEmoozDSJo40O/9tzpd
         vg6ds6KjHZoVDxQgDs5sPUJnx5rWUxP11jck4JG9De9atfJo/8I+dX1InkRiVqFwFrzB
         Bk+Fr0hm8AqexjBS8lXDvtn0v6tz5GnMWXcpd+COIv4+ySgMTOlq/7ElmVK/aiy19LgO
         AxICSAwWVE/CycYPutxKp+p0gqhcIbNe4n8hWTW7Lr2+ikVoUd/ISM71i/gggjricoBB
         spbs6sP62Quo5WdTumzJe6n9TbKrmYBbW9hGTgWZlLWk0uMuz4sn2FJoh+DvKiCR20DC
         2sXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705968381; x=1706573181;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q79azOTXwSlimUfkUpJ2p/ZsQdIQmqJ7jFQrY/iqycY=;
        b=JgdCsbvnutlwqNfVG345hvv4XAb+9wO29KdAHzYW4NjmKyqh91wu3zMbjH9tN3RL2+
         hTmCl2nuX846aUoiCxmrvbMLfcoLLNKPyNMzkHsUEWzUvsjxar8hHt38voNKjH6kKJyj
         4mbH0qoLPiissV03RgCUFJzn+lGzxchL4rXKDtWLFXVrsn/Xu6mPpgqKrKxAJqRS8pGh
         YV/vMu+afAX1z4C5aIYrBHq/WUdEroy6MfJ/M6Id6Plz0coDWm5lkiYTk5ehw3cHn9Is
         E3uRIRO+jdQt1WT8mdsy5cq6rShb0LbaAb+/Mfn+PxgIkoQtkDSl36elsZndRG0Q6Mgq
         IzEQ==
X-Gm-Message-State: AOJu0Yx39bHVfT3VHIVfglUMc0Sax4Qnd3wb/3oCO6GS6xL9pAJD8SLz
	wQmtBewyXwn5ksiC3rSrNYoIsDsscAI+9azlcaUJy/WUVklHSLIyxLPxjdqCkQzZcXHioZg2AQ/
	kOofrnA==
X-Google-Smtp-Source: AGHT+IE//rM3tBa89THOE9itYLd9DpILsWAlR+A+hD2lh5TpNO7nBlKg5HNk8uzlJAmXvKyC9a3AmpIdfUGW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6aba:f97a:4dc7:7e92])
 (user=irogers job=sendgmr) by 2002:a05:6902:352:b0:dc3:696e:ffae with SMTP id
 e18-20020a056902035200b00dc3696effaemr438504ybs.3.1705968380873; Mon, 22 Jan
 2024 16:06:20 -0800 (PST)
Date: Mon, 22 Jan 2024 16:06:03 -0800
In-Reply-To: <20240123000604.1211486-1-irogers@google.com>
Message-Id: <20240123000604.1211486-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123000604.1211486-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1 4/5] perf test: Fix script test for python being disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Ross Zwisler <zwisler@chromium.org>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Shirisha G <shirisha@linux.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"grep -cv" can exit with an error code that causes the "set -e" to
abort the script. Switch to using the grep exit code in the if
condition to avoid this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/script.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/script.sh
index 5ae7bd0031a8..b43077dbaf98 100755
--- a/tools/perf/tests/shell/script.sh
+++ b/tools/perf/tests/shell/script.sh
@@ -36,8 +36,7 @@ test_db()
 	echo "DB test"
 
 	# Check if python script is supported
-	libpython=$(perf version --build-options | grep python | grep -cv OFF)
-	if [ "${libpython}" != "1" ] ; then
+        if perf version --build-options | grep python | grep -q OFF ; then
 		echo "SKIP: python scripting is not supported"
 		err=2
 		return
-- 
2.43.0.429.g432eaa2c6b-goog


