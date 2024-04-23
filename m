Return-Path: <linux-kernel+bounces-154444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7653E8ADC26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0841F22A99
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868181CD3B;
	Tue, 23 Apr 2024 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf7CR8Xo"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817251C6A4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713842264; cv=none; b=VkPZJbPEbQgKisiMNEVCt/Kas0ShL8D88DBMNbsVdtenZEsD/uskBnAyw+LqzKO7xI9EIw61g/tbM342TchIqd+mJbf1Ap9WSRftc4DF/uevZJVgZnwSmyyOGAN2hJpqER+O/P2k3vZMafF3JllgmX3RXBwka7gK0HLx7igjxHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713842264; c=relaxed/simple;
	bh=lH5HflBC8pWb+z+Kv7k5EJDzEizYIwE8s7tE/0qlMFw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PpmIG8EGhb/t+K5bPGeKF4o9NpF4ucTm0GMuNNrCCzrCXBZ0/qnqJYwXErj1E50EBuknXgHF6mkWmx5Es3KQX/HdljPQrVBkqT3FwRnNejfi7WKLvC1j7f85QEXEOg08ca7jGNFu8EaoFNcD7jXpPI5eMgmdKb8c67ecGymHPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf7CR8Xo; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2ef746c9so91038417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713842262; x=1714447062; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nhUNWHd/vBo68/OMf2V7DkzBC0fWIc9SzssVfvUJw4=;
        b=nf7CR8XopxMclIE2aAo6VLB6BIWihGvzw/uabd4cnJ7bJsjSsmAuYNBRXjnJaEu0GJ
         KikY/t1NVSjoh9dVKst1rfHeoL0esicXCFf9VUUG+T/w0HTQsJIKupDyVa0GRlEllNWB
         Bj8zGGZImj0zf3j86m33gOeiYSwtMDDvQ+LsRERafwbyhKKNGNNaKGr/uYJ8ssGjzD0s
         bWCdCkLPNf536T3W1qSzodKq5SVzLeuIhln8Z25v8lfV3sYkZ/9wxe0P6ha7lR4WO1FC
         dnDiLKFdCQHDUJCPpqnP63dY3q5dEWG+y/4g1hM2SxIrTyi6+jiUGph5e8uJGdboSguE
         rDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713842262; x=1714447062;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/nhUNWHd/vBo68/OMf2V7DkzBC0fWIc9SzssVfvUJw4=;
        b=WUmv/I4YTIP0+7cFgJ3iGJpIDsJ0aTpfXG/4qNw1j3fLxutfbymfYHtXjOnglc+NGj
         Fct791v8TR1DpAnLM3YIyUJnAN9UNQdF3Aq5TuULEid8MhCXapwpgJMqX7ZzgG7bdHSH
         3RTlTJvsOuj0yrH5lIzMiTUUe77oLutorZaN3d4d7NpKkVkY178geUl4e8RhiycPGVnr
         KCfrBRwdSH2LU5uGzUKCsphct0LKKd0s5Xwms1xrX42WzRo/j8gtjA8/F5Nejri3TRsO
         0j6Yq4dIycriTV2jTE9H00RxQ06gDeGSvFE3ol3iVTo5MTZZ28YVam2Y+zIbKGtAH0L1
         Cj/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBhggZ2PftAiGDY5p1+VOIxVLxNwsIR1RQu3TF7wtIqeEIfA9VamaKbjvL35wGgwjde7LhEPhg9xZ4XcysH8wZDvuU2Jc9UTbFraK5
X-Gm-Message-State: AOJu0YymNKQzcLueO/Ar2boLm3zs43rKVXCjS8KxuGK1WLGiqOrbKgxT
	tJsJvrZTrGiiVowxTymPvL6dU3lhCC/a/NWlX/yLN1yYIBAJx+q3crL2lTSOz4pNHUSrhNM3nAr
	dRrTbMw==
X-Google-Smtp-Source: AGHT+IHUb9CQO39gnMLndOg3/rTLB5xw24Gc5Hm+GfTLcEC7+RhHCe/Ji6Zw2FEV8Tag+UZIqiAVx4Y0hZQe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a0d:d48a:0:b0:618:931c:9a14 with SMTP id
 w132-20020a0dd48a000000b00618931c9a14mr2819322ywd.4.1713842262540; Mon, 22
 Apr 2024 20:17:42 -0700 (PDT)
Date: Mon, 22 Apr 2024 20:17:15 -0700
In-Reply-To: <20240423031719.1941141-1-irogers@google.com>
Message-Id: <20240423031719.1941141-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v2 2/6] perf Document: Capture that sysfs event names must be
 lower case
From: Ian Rogers <irogers@google.com>
To: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To avoid directory scans in perf it is going to be assumed that sysfs
event names are lower case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../ABI/testing/sysfs-bus-event_source-devices-events       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 77de58d03822..3e0100e9c664 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -37,6 +37,12 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 		performance monitoring event supported by the <pmu>. The name
 		of the file is the name of the event.
 
+		As performance monitoring event names are case
+		insensitive in the perf tool, the perf tool only looks
+		for lower case event names in sysfs to avoid scanning
+		the directory. It is therefore required the name of
+		the event here is lower case.
+
 		File contents:
 
 			<term>[=<value>][,<term>[=<value>]]...
-- 
2.44.0.769.g3c40516874-goog


