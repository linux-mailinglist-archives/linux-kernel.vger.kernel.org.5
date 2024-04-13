Return-Path: <linux-kernel+bounces-143748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63998A3CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223691C20AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2004501F;
	Sat, 13 Apr 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="cAPy4kkf"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F23FB1B
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713017811; cv=none; b=j/lPEjayTI+eUvAUSPVcLVpiiSRReaoc7HLjlvt181Qmb13c9DbaHaYLOx8VwdiBLKmE+EC0eXQBxcWaozlGW+z23j+CiBxEG2/8q06RWHY3FUaBjUpDsbLGTPMBdJQLbEylYwHnCi9gzBEjoudtwbLmXSGgUXsiTlC4MWu8HGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713017811; c=relaxed/simple;
	bh=DU50FXhrCuqhtNLOaapUXMuCslN3deTrvJGkJumTsUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/BJ3VDPpjtGmmiMUMhdRBYZ6eDtyLHJzyuPGGtou0uS8xhYb6AK9ldhESTzT/+qrn2ry1g8ZI8IMKqGPkwjR1UwQGTFsIA5BdsfbElaXvlZQI5azOVqMu7pCE6RJdekOcUHhn+xUT0IgGGtqbNXbJJXutu9QEbZw9tC212Q6sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com; spf=pass smtp.mailfrom=kylehuey.com; dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b=cAPy4kkf; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylehuey.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso1969195276.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google; t=1713017809; x=1713622609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDrdykoIXMbP7phUYiJI1yePs0EFYaz2XrXDwzySQjw=;
        b=cAPy4kkfSUmZR+hXckSUlPaaef5IwNiFk1XkRTaHmRByL/XdYZzAVkZQw3fQ2RkU/H
         PDsFtC1QBrJ9aFBk8g878ctQYK/V6YLzMLkGl0Bqrmka7nOk6KnPPPSK9Y+/W5bSPOsu
         OIUwymznFCGbP2wHqXfzNSAtBsk0cx7S885WCO1ru/X2bHU3PpZmG+3AMw8wNkDIu8QJ
         QaxuE71FaXyggY+CpM3JqIe77nuRMXEts1Msn9AqGrANKZSrW94MYnYaQJJ3s8BRTcR7
         fjd+LFixychMnKqi8syz/vjfg2/8v/WobLdfYLEIB423mgOOYi5x1r3Rnd8OWWVEIZts
         7f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713017809; x=1713622609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDrdykoIXMbP7phUYiJI1yePs0EFYaz2XrXDwzySQjw=;
        b=iJHc7KAPg+b7MDWHito1NGwOlVZU/tA5TEJ69oO8dqdc92bfkt5XyTtxZ5VhicGIxZ
         5WtRz0WVO8LdHDSUMcGSt+Ni6p7Bwpb+vFN7cLOSdBI977ZNkU05XrOJcfOojQ1yQTLn
         Vd+o9L6Xj6/B/Mz3mave8OEtk8uRpj8zSNmt++rtNvZsjEv+7h2t9HPF578rr8ayhwY4
         iqqTZKYLsuBlkOXram8RHVCTkcU1qUm4Vg38Obz20Zl21+FWtCM8wDluQPZB27aCmWR5
         kP1xsJ3ScUpEoR4CUFEhnmY+WvjtG8sOfes2bWz7t52daSv/x7muogto81x5ALZieTtD
         5tOg==
X-Forwarded-Encrypted: i=1; AJvYcCXgydomgYQtza5GFmraTvYXvbjraokRLOD9wf+yE94Y2uyzLpkcSwMs3AkQ5oYTpUhH2vLLaKbREWjSM4qM7XnnQW6L181G/y0iEP2S
X-Gm-Message-State: AOJu0Yx/eyh7TmAdZCoNHgc4GpciK2Sqt2Ow3yIyP6GGAyme6I8Ct4uf
	Sq9ICCPLWDA4ubRz90KnFstHeACdSVcmyGoaF43IxigWWB0D5dVXqjTsLVn6jw==
X-Google-Smtp-Source: AGHT+IEPuFA7BoJq94Q7691/uH1K4Hr0sbggqPd6G24r2jhNxtEzpxxCYcjtl26dmMUD1ygx7+PSww==
X-Received: by 2002:a5b:890:0:b0:dc7:4460:878a with SMTP id e16-20020a5b0890000000b00dc74460878amr4899160ybq.3.1713017809304;
        Sat, 13 Apr 2024 07:16:49 -0700 (PDT)
Received: from ip-172-31-11-157.us-east-2.compute.internal (ec2-3-145-99-109.us-east-2.compute.amazonaws.com. [3.145.99.109])
        by smtp.googlemail.com with ESMTPSA id v5-20020a254805000000b00dcdb6934617sm1193349yba.62.2024.04.13.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 07:16:48 -0700 (PDT)
From: Kyle Huey <me@kylehuey.com>
X-Google-Original-From: Kyle Huey <khuey@kylehuey.com>
To: Kyle Huey <khuey@kylehuey.com>,
	linux-kernel@vger.kernel.org,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rodgers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Robert O'Callahan <robert@ocallahan.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v3 2/3] perf/ring_buffer: Trigger IO signals for watermark_wakeup
Date: Sat, 13 Apr 2024 07:16:18 -0700
Message-Id: <20240413141618.4160-3-khuey@kylehuey.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413141618.4160-1-khuey@kylehuey.com>
References: <20240413141618.4160-1-khuey@kylehuey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

perf_output_wakeup() already marks the perf event fd available for polling.
Trigger IO signals with FASYNC too.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 kernel/events/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 60ed43d1c29e..4013408ce012 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -22,6 +22,10 @@ static void perf_output_wakeup(struct perf_output_handle *handle)
 	atomic_set(&handle->rb->poll, EPOLLIN);
 
 	handle->event->pending_wakeup = 1;
+
+	if (*perf_event_fasync(handle->event) && !handle->event->pending_kill)
+		handle->event->pending_kill = POLL_IN;
+
 	irq_work_queue(&handle->event->pending_irq);
 }
 
-- 
2.34.1


