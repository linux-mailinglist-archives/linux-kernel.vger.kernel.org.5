Return-Path: <linux-kernel+bounces-89062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41086EA1B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5273B28453C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D893C697;
	Fri,  1 Mar 2024 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4uuUvcJP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DC3C470
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324003; cv=none; b=WOgB02p1OtWjW588rMP3aXBSDX9E1RXbFoQOI8hgmExgTeZySG+pjL11C0clL4LaKEdfcAw6Vkm5b/jaymtDv0QgRkT1tBjtJIWGNjS5zfPT5bseSw3iGuTs8+fvwj+YI8OPPwDvwBZjsLhF0CbPr3ZYbFjonhkhx4KFI6AWwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324003; c=relaxed/simple;
	bh=+kXeHXthEWZD7iWx2K1wgOR5WC1VJeE1+Ab0otEfR+s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q0Zwn4Q9Sxochww1gwpGJ9x2duabU2SvV32fh2HtmoYEtIFTbbWCct9kAm4FKjVnAWo4Whhu4ECscx4EdvBtK//tsgjvIBdbaoZAdYXnIOGwm7MhmUcf975qI1naNFoGCcbZDLMWQJ4rLhZJtnIkqxY2yXfLXdgNYS1ywT98kWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4uuUvcJP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so3523051276.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709324001; x=1709928801; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leHy2ZuaaIVqOoEaFIcU0dOPh3TtFIVXPy4dpXtCtQQ=;
        b=4uuUvcJP4diR1DgxCzpfQ0oXzCEZRYp7YbVphmRn3/ubpFdYpJqYn1W031AhxHbpU9
         HgFOCH1qHJDvMyrosnPmJKgZsrgZvAq6FPVcREKlLKFUJzb0a/iOVpskNZ8ZpK2xnFVd
         /bU6HPEQXgeyA0C6zMMP3mFlVqvmzhm5EgmTuXjPS977SvRKtiSu/fO2B+YXCJe/6WHM
         f7MNR+5LpRoGXjJgupuo+vIrzEukBZVmK/r2wTw4kd9KXr3jPlmkqUQNQEyifLrJ0ZG3
         WL7LUzU3TnWNEl8qiYlkdn+qDSKz8dwtCtuerR/aIeul1vkW/Dfnbdgqvz2EBjU21sem
         F80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324001; x=1709928801;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leHy2ZuaaIVqOoEaFIcU0dOPh3TtFIVXPy4dpXtCtQQ=;
        b=f054WW925USVO45b50Z+IHPb8WW3YsPV9jchDubQRUrgjCfN8RlYKa0vjEijX1Ptsc
         q9ckqRNCzRAwmtSx7ypFhaqyl2ETOvKPfabERKTImnhgAVVJjsFpWZ0NRdiayEa5cN+I
         rYGz+ce52ySnzFdKqOo3XNouOXGmzdJF2Ud207jyanTh9zDVLzGwtihapYVwRyc1kRoC
         gtCX3XRr22tDDXk5QaqJCyDxCEE6A7whe0mJ2IWLhX8LIFBediM0JSmEotpZRLM4F2Wg
         XzrEw5MgshftidqZ3FDRHZ1USJXdCZs6/nqFdLT2m+zO0JFgBq8WyHmMSuqgpVo6oiJp
         3YXg==
X-Forwarded-Encrypted: i=1; AJvYcCXx5HNrCzJ7c4m6LpXMADhF80+OSoV1kJJpKFCXAlWMgZXCmEveEZKFGc9S5VdrEGP6GneXqPEUWWlsvktir7Rp5AfY1p5GGrSqwLlv
X-Gm-Message-State: AOJu0Yx3quOV+NrjgVECxtVCxxdovddW1nYR8fYWL5q3bf2DoUjSjGqI
	wh8TcSNToBo4IzLJJ7pDteUrlxQUklrpERzrSV39MKAnA1bJGGd9bq4frRnR/0qQHoIvuarrkLu
	8y9P59Q==
X-Google-Smtp-Source: AGHT+IEUiEJgQKhFhf5xIrWptGoM/WUTdtVbrogONGApTvzoFpWCMS1CeyeugDGls8ujT2Nb1x5Zs7wqJnl4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:ce8a:0:b0:dcc:8927:7496 with SMTP id
 x132-20020a25ce8a000000b00dcc89277496mr102198ybe.5.1709324000837; Fri, 01 Mar
 2024 12:13:20 -0800 (PST)
Date: Fri,  1 Mar 2024 12:13:06 -0800
In-Reply-To: <20240301201306.2680986-1-irogers@google.com>
Message-Id: <20240301201306.2680986-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301201306.2680986-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 2/2] perf help: Lower levenshtein penality for deleting character
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The levenshtein penalty for deleting a character was far higher than
subsituting or inserting a character. Lower the penalty to match that
of inserting a character.

Before:
```
$ perf recccord
perf: 'recccord' is not a perf-command. See 'perf --help'.
```

After:
```
$ perf recccord
perf: 'recccord' is not a perf-command. See 'perf --help'.

Did you mean this?
        record
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/help-unknown-cmd.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index 2ba3369f1620..a0a46e34f8d1 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -73,10 +73,14 @@ const char *help_unknown_cmd(const char *cmd, struct cmdnames *main_cmds)
 
 	if (main_cmds->cnt) {
 		/* This reuses cmdname->len for similarity index */
-		for (i = 0; i < main_cmds->cnt; ++i)
+		for (i = 0; i < main_cmds->cnt; ++i) {
 			main_cmds->names[i]->len =
-				levenshtein(cmd, main_cmds->names[i]->name, 0, 2, 1, 4);
-
+				levenshtein(cmd, main_cmds->names[i]->name,
+					/*swap_penalty=*/0,
+					/*substition_penality=*/2,
+					/*insertion_penality=*/1,
+					/*deletion_penalty=*/1);
+		}
 		qsort(main_cmds->names, main_cmds->cnt,
 		      sizeof(*main_cmds->names), levenshtein_compare);
 
-- 
2.44.0.278.ge034bb2e1d-goog


