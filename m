Return-Path: <linux-kernel+bounces-109677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2A881C47
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A874B1F223CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25373C684;
	Thu, 21 Mar 2024 06:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YQ5xAJo"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5369314
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711000850; cv=none; b=P167wW8AS7JnQueDZ+PHP7eO/PW/NrApPmuGBlrbq8lDAWOmds3aYSVP+ZHpGkvCdC1Gg6QyqTAbUA6pADLdaTOmiwozLgggcz3J2a7cAJev3Iauh06Q5lDUJcr+P6xH9gtwc/qkEe3QOyy4zys4FqQ5U9gh/4frSV1lc+uAUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711000850; c=relaxed/simple;
	bh=UcTXMzN5XjmNz4mXyJUvFAJ+Ye7gKqduSauTfGk454U=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t2cBedr4NUiRKT1s4SmKuqRuBhhtzcdA+7h6flF4PzL9XkXaP62KGn44Gi1e+eudIUrD77EeTelqNzZ7FTd3+6QPZmW1BOv0MzIGuLVB//o06mNPlowT+zmLFq/ua6h9wbQ9vAEMHJBlm/2tAy91KyyHhBhbOzygOG7RMMEb5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YQ5xAJo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd1779adbeso955911276.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711000847; x=1711605647; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBXsDG26RDetec+RtJngUiNJ/aj4h1wrNrd3NLI8QMg=;
        b=3YQ5xAJodF1b3H9Asd3Jgx8GQsDixCNmscFDjcEI6CZI92VP7r0vMt/rF3yO6/ndr3
         Aki+6Lpxq0xoq7XglsO3cWiCNlS3bWQV0VRFJ35HsJNot9g5DY/VOfKCxs9TdtGzavCr
         jQ0TK+jQuKOpDwxs7yRT+lVOfquqdvir06Z6gJqcLYrBXAbKI7qOA9Lu/q+CsqGq7e2L
         ZZ8Bgd88cCzyx9Hr5LMnqVucGPxLcDw7I3OrUT3qJpe6zpo9QnhG78b32rhdTyi87kR2
         lfy+UlGEhYh6R57RX6EIKeEJuBKEFLFLFzC23xEOkJTDS1piLwZXZ8aaLus+F3d3wr8h
         p4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711000847; x=1711605647;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oBXsDG26RDetec+RtJngUiNJ/aj4h1wrNrd3NLI8QMg=;
        b=D+ju00pXqF/kx0R0YVngl63SD1f6ONi2mhqdJpICG5e3VMz+XD001vMQI/58vyVdrh
         R4FODWSTkVy03SNXGR3MFIO95+b2DpomHCLmg3DL9/f25v4wuFPs0udC38PEFCdBGHOq
         FtlHy7TZSwdUBILRI3+U7stXMHb3veRVA/AMP6Zd5w63Ixa6JH2JpWCp8XfIqmX2sBMd
         MBoYh0sZ2Te/gqaFI8sEc3FXfvV+gIbADtDCqoLkjhTtRqNY1WOKypauaazigev6bbQz
         G5wvoMpwfviA25sniX2Rb8F3R2SE8hwKzKbaGvcIr/KibT8021eBy0zYoGt1hqz5EJWJ
         33mg==
X-Forwarded-Encrypted: i=1; AJvYcCVWlX9bY+Og7YRGFq6BeadOpSTG/ONM4jXNQYK2dgG6jCrcF1ZR4vbYPQyF+2GnZRpMaFQHD7wV8DevTX5y9V1OuiBfGxuctIyxSmC4
X-Gm-Message-State: AOJu0YxDTQavqpU8adM3PgSQ4t7rS0rIDgouTaUEwOrNEEo0Muh82+41
	otEPS9vsJBPvUJ8Xtgv3c4d6nTXBcgjWIZikusfglprHwIm7uqBdkxEkbOX4qKgMV673euIg2Xt
	WUSX/uQ==
X-Google-Smtp-Source: AGHT+IHsr/Jmxd6KElg4qmTHQW9HDtm7XljFLHLHKO6vO+yE3ZCVj5BkiPUMU7aWj+QJMELanTKkm5FkJjw4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7f3:cf74:42c4:c0a])
 (user=irogers job=sendgmr) by 2002:a05:6902:983:b0:dcb:b9d7:2760 with SMTP id
 bv3-20020a056902098300b00dcbb9d72760mr2040720ybb.13.1711000847179; Wed, 20
 Mar 2024 23:00:47 -0700 (PDT)
Date: Wed, 20 Mar 2024 23:00:14 -0700
In-Reply-To: <20240321060016.1464787-1-irogers@google.com>
Message-Id: <20240321060016.1464787-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321060016.1464787-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Subject: [PATCH v1 10/12] perf vendor events intel: Update skylake to v58
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Update events from:
https://github.com/intel/perfmon/commit/f2e5136e062a91ae554dc40530132e66f92=
71848
This change didn't increase the version number from v58.

Updates various descriptions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylake/frontend.json | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylake/frontend.json b/tools/p=
erf/pmu-events/arch/x86/skylake/frontend.json
index 095904c77001..d6f543471b24 100644
--- a/tools/perf/pmu-events/arch/x86/skylake/frontend.json
+++ b/tools/perf/pmu-events/arch/x86/skylake/frontend.json
@@ -19,7 +19,7 @@
         "BriefDescription": "Decode Stream Buffer (DSB)-to-MITE switches",
         "EventCode": "0xAB",
         "EventName": "DSB2MITE_SWITCHES.COUNT",
-        "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses.\nNote: Invoking=
 MITE requires two or three cycles delay.",
+        "PublicDescription": "This event counts the number of the Decode S=
tream Buffer (DSB)-to-MITE switches including all misses because of missing=
 Decode Stream Buffer (DSB) cache and u-arch forced misses. Note: Invoking =
MITE requires two or three cycles delay.",
         "SampleAfterValue": "2000003",
         "UMask": "0x1"
     },
@@ -267,11 +267,11 @@
         "UMask": "0x4"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.DSB_CYCLES_OK]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.ALL_DSB_CYCLES_4_UOPS",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.DSB_CYCLES_OK]",
+        "PublicDescription": "Counts the number of cycles 4 or more uops w=
ere delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buff=
er (DSB) path. Count includes uops that may 'bypass' the IDQ. [This event i=
s alias to IDQ.DSB_CYCLES_OK]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
@@ -321,11 +321,11 @@
         "UMask": "0x18"
     },
     {
-        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "BriefDescription": "Cycles Decode Stream Buffer (DSB) is deliveri=
ng 4 or more Uops [This event is alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
         "CounterMask": "4",
         "EventCode": "0x79",
         "EventName": "IDQ.DSB_CYCLES_OK",
-        "PublicDescription": "Counts the number of cycles 4 uops were deli=
vered to Instruction Decode Queue (IDQ) from the Decode Stream Buffer (DSB)=
 path. Count includes uops that may 'bypass' the IDQ. [This event is alias =
to IDQ.ALL_DSB_CYCLES_4_UOPS]",
+        "PublicDescription": "Counts the number of cycles 4 or more uops w=
ere delivered to Instruction Decode Queue (IDQ) from the Decode Stream Buff=
er (DSB) path. Count includes uops that may 'bypass' the IDQ. [This event i=
s alias to IDQ.ALL_DSB_CYCLES_4_UOPS]",
         "SampleAfterValue": "2000003",
         "UMask": "0x18"
     },
--=20
2.44.0.396.g6e790dbe36-goog


