Return-Path: <linux-kernel+bounces-165952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6326E8B93BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026E91F234B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3549200A0;
	Thu,  2 May 2024 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eURM4FrN"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6801CD02
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 04:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714622498; cv=none; b=VD0qiyhC+BIbFOTHjOyCSx3DCjdEV/JgVbdsrXZmu+D+rRRG5yXrT8itOsB4XGFc/MLwWYiT/OF2v+a5vEsFA2sbPCqpH1qVuE1QycV6NovAgT+yRsF2fpIi0aravaFm3zvpJ9J42ZpHEQTR72QAZFxbFqE1SeifPK72m69LM+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714622498; c=relaxed/simple;
	bh=RiQ3QH8Mevr7c85qmwqOFnFf8n7v8w8+896FGDtfLBk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=MhuDEMjt/EuxkTAYafQnSqmM/wkI3JEDE0NcQqpJgRoahPhV03HHefV8eAiZjisa3mf1RiHQ3Ez8ScKGYjUCoAhhXRUKngVj9BNL6i8QYAHcM3Az2ROKBL4kwqzk42uWEUl60FbHLKO+3hF1Nyi7VH3aUjKTAKJr935m2V4zHEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eURM4FrN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de8b66d59f7so609286276.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 21:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714622496; x=1715227296; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YK4M7DhO5mIJIFP1QifUvK0BbiOYwnyjSGyXVIhqvoc=;
        b=eURM4FrNL+rV5M5jGHtUmXebIP7s+6tV09lWMhLoOkB5oUe95jtHIZhHMSF8rOC/8a
         p3p61sV/fol1XY16MrcNf7uho3djCk7BMFxJD9NURm7ZeyJslSVg3clElCdP7BA1PKpb
         q/EaOwEOebVpdRdd+MADbQDCFdLY1wkQyjelDg9QE5jJjLu5dLFVBvWLZG8RJnsPw4Cz
         8fd16JwLyVvPf7TI7gbTZh1D/BaAE8Pja7WogT838qlIu/KpbLrCPR6Bo30gxpHh4cQ3
         c231EHottefKA5ZI0qvAFh/gg5k0AGs6JCovnszhmAjsW4nOGh7/S5HuDAMEN7CJXX0m
         3H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714622496; x=1715227296;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YK4M7DhO5mIJIFP1QifUvK0BbiOYwnyjSGyXVIhqvoc=;
        b=YTyEiVPxPArdN/f0dzUO0K7ZgxmYt/LCvd0Hf82xlNA4uI/CBXgOBrF3/5fRbcirCn
         1RjCplaEbznvSm7239LIxmK4GCAOiF6g84f71z4xCCooEz7xjkJaYWr/xQoc1dtL+WGg
         OFRxElF2nyhImZNQ63D6dVHoasHYqRLY4QwS6MeThTlfSHs3uAvHTYI180OK8Gs0P5vw
         /6MH4tjTyqYlK0Lezj8lekBOuaPMrgk6pHqcJfJd+zaJRO8gaXXTDkPjmBeNMeVcDEHa
         L0OEySh3gVnVza9SBHtvE8YF7NR9IqG485Avni82CFLRSzclp6L+2kfxZHZTaGuD5hs8
         ObFw==
X-Forwarded-Encrypted: i=1; AJvYcCWtRl/G8spNLBElRRNELNu+zOG/6yajqT4n+N/JoVCMUgprm+8pI/TvpEU34iz0HONIMXb+6dU8/c6Hgg4gpKJ6Q8VzU8mQNgeypR1M
X-Gm-Message-State: AOJu0YziQGz9keoQlPUBUirLr7X4fmwndm7c/BojCbE5LFXnoXSJDopA
	QbDV/TtJKapW4RhQaQEnq+w98wrU2NZU/fVTkO/fArcrxn1gocFN1iF1k01DqK5PS3vSOfD6uOH
	59wCcRg==
X-Google-Smtp-Source: AGHT+IFPc6nblxvkSStjTR2HZemwo65gYU0j5fOsBfVD2NY3SXd8R9XN1dTAVlFK+TBORZ9QnkCT8WE7n4M0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:53b9:bbda:1daa:17d3])
 (user=irogers job=sendgmr) by 2002:a05:6902:100a:b0:dd9:2782:d1c6 with SMTP
 id w10-20020a056902100a00b00dd92782d1c6mr419962ybt.1.1714622495773; Wed, 01
 May 2024 21:01:35 -0700 (PDT)
Date: Wed,  1 May 2024 21:01:08 -0700
In-Reply-To: <20240502040112.2111157-1-irogers@google.com>
Message-Id: <20240502040112.2111157-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502040112.2111157-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Subject: [PATCH v4 2/6] perf Document: Sysfs event names must be lower or
 upper case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

To avoid directory scans in perf it is going to be assumed that sysfs
event names are either lower or upper case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..e7efeab2ee83 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower or upper case event names in sysfs to avoid
+		scanning the directory. It is therefore required the
+		name of the event here is either lower or upper case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.45.0.rc0.197.gbae5840b3b-goog


