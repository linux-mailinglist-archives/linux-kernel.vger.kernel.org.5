Return-Path: <linux-kernel+bounces-32408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE98835B65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7241F230E4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C75F4F5;
	Mon, 22 Jan 2024 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiKg55Si"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21361DF70;
	Mon, 22 Jan 2024 07:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907450; cv=none; b=KtInvkGu8gh26b+etXWsjqTSOADvd16OFa345WA6GSluvxBH+pJDRcZ31XddEqHCGTw8GKtJKHUPrg6xSn1NO6PgGKuzyy4PrLUIT6TWLRBVSzz2I13ETFv3iUrX2/5MdfrBSQtvsc3yEzVQp5RxQ7v7A/pzN2JGGJjJZx15wng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907450; c=relaxed/simple;
	bh=tLmjOeut6pg+SKiv228NoATv90nxAzKxJkKMBxMz6ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eosqtUbi4yIONrfjx8QwH0b8M3k7jD687/kQ9q+vei3+rBs4nmbb35IEOUulJ7/jgeBzH1KEMdis6/gY1nU8LqaeBZcSZ48C3S+LyRghHwxhM7hx+sbk+f1qjvhWTD8ZbGWHq+fP3IR1BGdcPuXEDRd6kaZHohBqLMFU46QuPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aiKg55Si; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cda3e35b26so1039488a12.1;
        Sun, 21 Jan 2024 23:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705907448; x=1706512248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRxQwZAfT0nFVIiBEP7efXSgrXaSHC5qjp535Z9j6as=;
        b=aiKg55SiJ/g3M7D1qDR46KFedCbOiyYcVF90B0My+jdAKIJb/XAV0xxTkpTy+NNhW/
         GTcXdjdGhyNndWxv0tCcm6hL4apaJRbCQNlWgoFCVzmEmKMBB5z1/3ajt4tkwDuKGP+U
         AP4dLNuIU56kJuAQKGXYbnUnP3mDkn6dICZTa0oEkXTGxQoOFVSFX76jIiKnKwa98wlI
         +LRIOmJ6OcjwWmot0o3HhrGAsBYth1Zf6JxWnqOkVrTKhqBNl5ejlZXCB4a0lDFIhwim
         KHjDM3b1KayDioauDfY718qB3lxycpeuBUVeD1lw9fRmTLaL7FYWvSB05zihZyQ0NgYn
         Sx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907448; x=1706512248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRxQwZAfT0nFVIiBEP7efXSgrXaSHC5qjp535Z9j6as=;
        b=qASxdNwgCsIkUIbpNR6vk10RmlhNXgYcRcx5rnFxSOt7ke7aSJIZG8e+Hrt8jKGm7V
         z+N3kanhrgD02waq0ht1yhhNuI9iweUNa6NWrdIypc859WAr632QqgoA6vMAaFvzM+eS
         68ZN2wTDdT/GyosuIWjKzoWGx1LfpPxrN1QT9J/xSugGLhaev/f3J4p+AndtUW+bItx3
         6q98AmU0oFNElbkPUvUth9K5SVxDhKgvBHbZj3tFVqKMaAfADA3+bej7Mgv70yroYGbP
         z5ayaYTUQAIZSG35ik3P06RyZav6L1amxCtPWS/sYURP4/CY6A/vFhakUDV9HeRvI1iQ
         dBvw==
X-Gm-Message-State: AOJu0YzJJuAi2vb1rzesNhHQJYVmQU2BF6zUcmOo0KeUjU7NiToxDOBx
	w6VERavWBE0uvpIz3QhHUVuUjJDrEozuNpWjUhstPfsnm1gQ7OaZ
X-Google-Smtp-Source: AGHT+IEhZKWFgHcbtt8xfm9OHLky/h9zkRY/L/AZ6E00H333cIofnE+yVta2wWZ0j5zM2Y3bGNbaeQ==
X-Received: by 2002:a17:90a:db87:b0:290:78b7:64e with SMTP id h7-20020a17090adb8700b0029078b7064emr463511pjv.15.1705907448055;
        Sun, 21 Jan 2024 23:10:48 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.45])
        by smtp.googlemail.com with ESMTPSA id t10-20020a170902d28a00b001d72b3b0ee6sm3463365plc.248.2024.01.21.23.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:10:47 -0800 (PST)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v2 0/4] perf sched: Fix task state report
Date: Mon, 22 Jan 2024 02:08:55 -0500
Message-ID: <20240122070859.1394479-2-zegao@tencent.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes introduced in v2, just got v1 rebased onto
the tip of perf-tools-next for a clean apply.

---

Hi,

The problems of task state report in both libtraceevent
and perf sched has been reported in [1]. In short, they
parsed the wrong state due to relying on the outdated
hardcoded state string to interpret the raw bitmask
from the record, which left the messes to maintain the
backward compatibilities for both tools.

[1] has not managed to make itself into the kernel, the
problems and the solutions are well studied though.

Luckily, as suggested by Steven, perf/libtraceevent
records the print format, especially the __print_flags()
part of the in-kernel tracepoint sched_switch in its
metadata, and we have a chance to build the state str
on the fly by parsing it.

Now that libtraceevent has landed this solution in [2],
we now apply the same idea to perf as well.

Regards,

        -- Ze

[1]: https://lore.kernel.org/lkml/20230803083352.1585-1-zegao@tencent.com/
[2]: https://lore.kernel.org/linux-trace-devel/20231224140732.7d41698d@rorschach.local.home/

Ze Gao (4):
  perf sched: Sync state char array with the kernel
  perf util: Add helpers to parse task state string from libtraceevent
  perf util: Add evsel__taskstate() to parse the task state info instead
  perf sched: Commit to evsel__taskstate() to parse task state info

 tools/perf/builtin-sched.c |  57 +++------------
 tools/perf/util/evsel.c    | 146 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h    |   1 +
 3 files changed, 157 insertions(+), 47 deletions(-)

-- 
2.41.0


