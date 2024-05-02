Return-Path: <linux-kernel+bounces-166944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE9C8BA25B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FA31C22C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FE1A0B02;
	Thu,  2 May 2024 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKmUWmoh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7301836F0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685716; cv=none; b=GqW6BO23hToR8PJdacOnrekHRbGuT2TStqh1tkR6MC5wOIC5aWnmcCbPCzJ1iRqnbt999aRvrW7MioT1SbwHNwsNVDnNlOIWPRnezVvyTcuOlmTJYkVV4ZSiClXeyUr7beZKT3i12gnhWSdZxPGvUOhs5i3G6wQExPff2FOzbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685716; c=relaxed/simple;
	bh=+iC8656RV+1z9SNt/rVmkZ8TfblJJXHmOmw6MoV2AOA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=UB5QuwhqByJwFvhS6VCUR5661pXAjv973BTAWVouv+EvYnIK0TiEt3lIV7N+PmZLi6sNYyWHNva0q3BAS4LQ3IxIZ/JA0tok3aoEJLbFtVr+8FAiGpYNYVS5Ur4/1rGL9ygvOdZgJXZoaAGorfy8RCBKwtGW2Jt/mRTdvBwSlZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKmUWmoh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60321ce6cso8326630276.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714685714; x=1715290514; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgV4xf5fQxiR7aZHDngtpEH48nFcBFO3YN7qW93R/WY=;
        b=YKmUWmohHCI3nJNqF0x0QwKfeyQLFnr3qoAF3UJwHEcseRz57D1mJvvfgXq86Ob1HM
         q4vP+URgT99hwigCINta0rPI4elFwXbp5HU6Pdbv6qlYxGbH7xA+fzAREWVM9bhJmocC
         iuQ1FKbVzV3P7Dqcy/wt25N4cJHGQ7SNWgUYj7IlKus2uyHWGMbfVfWEn9cDMWgzMKUn
         AGuxGXtrDjT5JTQqTyC0EnhDVqY6Y6FSsF+4nAA2kfl0gFfvTDu+OtMcjGd/7wsM53Yv
         fAPnF1EaXEOZl5RILKLoSn4tkmEV1IWlqw6U0EKz0z6HNwhEtzST1Th4euXyOmURNGcK
         DTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685714; x=1715290514;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgV4xf5fQxiR7aZHDngtpEH48nFcBFO3YN7qW93R/WY=;
        b=wki/eeZpJpw5St/d6/TlS3Pe+TrBdkkRjAYqwYJT3of2LTsnOxRwDgkuLd0NlpkPCu
         V+yfnmKpCeZKt693NRVw2FLpmMOJofIvfIN5XCmG0xGZ2CJ3CxnR1DfYZr2+YQfKIEQc
         yypU7VSgWlE/LxUACQ6NUgtraJnJSFhXGjTJnGC9Son0ZuFuug6D+LBBIAA6D3abwNgM
         lCzkVNAmXkJDvawFYmwAWFNyf5ZWQ8YHvJUdV5Pp/FhfPoV9NcSMWMs+bM2NW95DujvG
         i1/APJKfryrrxw8XAakbkUMPeng6spRGk8IVSvphzxTQCbu1jYPWnzVPZG/x7yA0ZzKM
         D6Cg==
X-Forwarded-Encrypted: i=1; AJvYcCXvRXfPTDjewqu1xhEuQx98tg4veXZ8cr7B6cNQaHj0RFEJf6T2MIVp6QEBWrn6JLGotuZdkyO9t26CW1s6Rk8Lgpcffl1/SMXAg49x
X-Gm-Message-State: AOJu0Yyao+XnfuR0XgGhUKlUtznKlV7gJ1aKqAwsMYzcmcMAnLTb4HQr
	FsW4NYJtazcvAsqFl1lXpS3kPasR7IhLvXR6sMkFqVrmFhd6TZcziU2hi254z5VYOWN7IgrUdag
	ouxN7aA==
X-Google-Smtp-Source: AGHT+IEXj+L7mG/mFxFwq34rU15M9trIcDqflnvzeDMxWFJfivTAbhdOHNL6yQyts7hcKK3NVMlyQZ6Ci0F9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:deba:378d:2d3a:2641])
 (user=irogers job=sendgmr) by 2002:a05:6902:1007:b0:dc6:d233:ffdd with SMTP
 id w7-20020a056902100700b00dc6d233ffddmr322304ybt.0.1714685714546; Thu, 02
 May 2024 14:35:14 -0700 (PDT)
Date: Thu,  2 May 2024 14:35:03 -0700
In-Reply-To: <20240502213507.2339733-1-irogers@google.com>
Message-Id: <20240502213507.2339733-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240502213507.2339733-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v5 2/6] perf Document: Sysfs event names must be lower or
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
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
2.45.0.rc1.225.g2a3ae87e7f-goog


