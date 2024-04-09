Return-Path: <linux-kernel+bounces-136134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B4789D05F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD44B1F21D96
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E57548F3;
	Tue,  9 Apr 2024 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BWLA7b5x"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E4B54792
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 02:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629942; cv=none; b=rB4szUkKn7iJeB7nQJ9X3K08dRS3YnPno6tewS7DzhsaeQ0qZCQNbesoAMrEmVPe6TRubPd6CRdVbegsAHvSGHs7j6J49sHpbvIUAgTLzpAJpsh6+vxej83TJeLO0LQXKKwS7vVF+LbYUZEhABMNF5SEwP48DSEKXfao2xDyfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629942; c=relaxed/simple;
	bh=Ig1KBbQC+Wey0nk2eqBsqNOecgBt4OBUm9yv3zQ5v3c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=XWQT+AAiuHlk1pgMyXxCGyCnZCZerP6TIDo1cH3igwdlEq8VYdgNok42aqZYV1K5vRjeLtRfiFw4iwyfIotcTJj+SUoSDVwNdAnV/D/V6ElEoThi/5B2R8Goukz3W+Ljhd0ZSqH8qrfJvbej/k3TR/3jlQRhRjqDshdNsvZOe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BWLA7b5x; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd944567b6cso6726011276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 19:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712629940; x=1713234740; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KUIS0MyTzJCVZ+gD/HZpV18hXpIYqV5o1vAPtPINFuE=;
        b=BWLA7b5xa0LQOm1Oe+68LZhu6+oFcL6XB8p/nKFY1TzLW2nEoPYWoz+376MchTjJ+l
         0WB5OPnEMRtzwzZVUTfLx6i6jBx0Zi24i6cj540T8gphGPu0/ohXkzKTIlutyUIpg58z
         CwCCpytxe+r9FkdRgBE2D7uP+RtU6txNEfVVck40ca7ul3C771pbjDcyPOl7JEpkajWo
         QBNQuobiNFun4EQVGinwvpnjvsj2qJj4/SvrVeYiwFIN7nsJeVpEu2To3iPIi34wXUB3
         YEwhrLjCy4SN7RJ1SPcnVnW9RzOEbFeliqqJXy551/kxXEv2PnqckxrySx1kVTXjFXoa
         5UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712629940; x=1713234740;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUIS0MyTzJCVZ+gD/HZpV18hXpIYqV5o1vAPtPINFuE=;
        b=eKsGcRPGjRk1Y+3TDdrEq34V57BB5itFo7dqz/yVeeZyfO1FKiHgFAq1VERS9agnOJ
         7D6St3xX7WKoz0qS0SKdna7UZlQRcjO/coINDqAqjL4+oc8h0p4Eh3rvZphmJpmJqKk6
         mpNLBOIWFCi8Kmznp80d/n4sngT8iDrvZrQhGbwmrF2ZbR1z9M7c4NPlNcvSFc12hGcZ
         UBqk9wPOv1u8twei3dqHDDJp6tyfGxB+Dk0MN4KDLamouZ25Vj/FGH4njaaMeHgsBarC
         jlKDL52qVlHUAoO1shTY/dCqh04D7GK7BiHXD0K4Gafiy//jtgoIFw0y0lI1hgtolGpP
         5fbA==
X-Forwarded-Encrypted: i=1; AJvYcCWw/dUeSGxPV4L4eTH3HGsx4auzNAnJg5XlIDL/HNXWo8QrIK+tB2vcewkiYUVbeaBG8CDH38yUngi9vnG3aqsRwKdUxnH+t5mJ3ESk
X-Gm-Message-State: AOJu0YyrgCgOBlB/bIf9Z/X7AMhM7EavhA3Dm4yia4kmkuD4wNvIUuUD
	iq98sBzoyDa2EEoBLy22Rr9B8FaKIgE3UsMc3OvWjjWzVK0v0o9KGwT+xLTJ9ES3OfA8kl20oZ+
	aq+9ggw==
X-Google-Smtp-Source: AGHT+IFLk3uhl9FNy1Hb+p1VyRcNScSA1q8SStSpGeuCj4ki57fZYqE1fDks/q160igDIs/p6DJDVcbL5IOQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5520:7788:6b7d:7115])
 (user=irogers job=sendgmr) by 2002:a25:c712:0:b0:dcc:4785:b51e with SMTP id
 w18-20020a25c712000000b00dcc4785b51emr811897ybe.12.1712629939984; Mon, 08 Apr
 2024 19:32:19 -0700 (PDT)
Date: Mon,  8 Apr 2024 19:32:12 -0700
Message-Id: <20240409023216.2342032-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v1 0/4] Add shellcheck beyond perf/tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shellcheck to other locations of shell scripts, not just
tools/perf/tests. Fix issues detected by shellcheck.

Ian Rogers (4):
  perf build: Add shellcheck to tools/perf scripts
  perf arch x86: Add shellcheck to build
  perf util: Add shellcheck to generate-cmdlist.sh
  perf trace beauty: Add shellcheck to scripts

 tools/perf/Build                              | 14 +++++++++++
 tools/perf/arch/x86/Build                     | 14 +++++++++++
 tools/perf/arch/x86/tests/Build               | 14 +++++++++++
 tools/perf/arch/x86/tests/gen-insn-x86-dat.sh |  2 +-
 tools/perf/perf-archive.sh                    |  2 +-
 tools/perf/perf-completion.sh                 | 23 +++++++++++++------
 tools/perf/trace/beauty/Build                 | 14 +++++++++++
 tools/perf/trace/beauty/arch_errno_names.sh   |  8 ++++---
 tools/perf/util/Build                         | 14 +++++++++++
 9 files changed, 93 insertions(+), 12 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


