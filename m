Return-Path: <linux-kernel+bounces-39406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB8183D07D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F32B1F25E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44B812E40;
	Thu, 25 Jan 2024 23:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hS492V+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C51111A2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706224727; cv=none; b=b/X/XsoYbGfHRjC6giQLitW+pgE/xaUOzXv0pMlBniXTPcvlUGyyAWALSxnATp9HrFPyMx7cs7i+ZJOojtqycOtk3RI+ePoCrXJ6vSEUqNibbrxkIuz5wT3unH63amc46jEpWEtdGINGFoxBR0cdIEYHi/e6CmYGuM2A09vWTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706224727; c=relaxed/simple;
	bh=RotBxlAtW+YSIecozFRxnDfIZbqP8HzOrGqMrTwaCas=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=PZAIgvn6edtEHdG8oSrIpvMVFRb8szGr5VUowsC4cohmrCCyH8sJUC7Urv/b7PGJrf95Jp9LCqKHLp/A/vVwKTB8MMaSHeD2s4MWJXpEkltUX3U5gkEqa5MPcc3xsimOYFoSfqEKUmwKU11lcLUgjcC9RilHpGWsuNdfculS+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hS492V+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ecfd153ccfso112188627b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706224724; x=1706829524; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZGC8s6hqJqU5gEeMxQdnAY4g/NVMV1X9Z2j42laoOYQ=;
        b=2hS492V+8ey+zrLQAahLNArduOq7turfQ2diaSpw3iYiW2TJuTAg8/CX/9PK84A9Fk
         tCiUpjvzyCvDi+/4UpJS4iRhvUJcSqR3bfWmtw9lLWqvTb7+7ivyUSk6qgKGy1j8GolJ
         frTyJunfW8xqf1WRV6yKvIaIndpHQZnrFPYGDa1C7pyy/HrtOzvyOgrDNzdWC9Qwj+qd
         BzPfO2LLioF7xkHknOEqYEhdOMHDODEHE8Qu34NSafe7FhDvc6VXbd/3yitJG0Rg7bnB
         yaEFk5MTG3guPJy9DO4YZfeIc1m5S7hiag7I3C7/CFFOniaUtndkTKAhq5w5KrWzcyw1
         UFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706224724; x=1706829524;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGC8s6hqJqU5gEeMxQdnAY4g/NVMV1X9Z2j42laoOYQ=;
        b=XkDj/fWsfI16g9Qxo1YKVKi4DFlmSCr7VnB7cbRJhEscdBdJutAL+vrGNOJtxf3Ks7
         kLaMUYcWqCpFeFVpAt2f4UKyQCfzEQCfIjsFwbDamOkzWrzva2MjED6Al8Td1rlESaET
         7jFvqQQ1o23irZSHX1bJuKdjHXyUTPbMgPrqti9f7bF0RMYakSZeq0IsYgzhqF5P7nqv
         4XqCVCBQDHY+zZUEqQCNybGG8MHuOcBZajahSyzOQJp7dKbwSzyqQHeXHc//26Tlm283
         NxmNTeaP3C+g5F2Y3ELkJkZzF/ZcJDDMwJqBc3KCOZzZMD2yYYkKu/c7M+ZBrr0EzHfM
         FGHA==
X-Gm-Message-State: AOJu0YwrgD2kV/FS/aGCrUg1yqHMaDTD4Kr6oh0DAo3O8A9mLNVJ13ww
	AaXGue6tQKFdZS3cJgFtw/sdYlN+/JaCr2EdyG6pHM20ARU95scXVmqhHgLMiQyXXmVX0QNtJ8p
	5qZGFwg==
X-Google-Smtp-Source: AGHT+IHAKFjIvVDRshNDR8YJpg9uhXgerPopEsGzHSwzie01CrDlMBACw5+xe6FWrfY3EAiEi8Y8kHfcdlmz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bdfa:36de:3c1f:cd82])
 (user=irogers job=sendgmr) by 2002:a05:6902:2485:b0:dc2:50cd:bee6 with SMTP
 id ds5-20020a056902248500b00dc250cdbee6mr301672ybb.9.1706224724631; Thu, 25
 Jan 2024 15:18:44 -0800 (PST)
Date: Thu, 25 Jan 2024 15:18:40 -0800
Message-Id: <20240125231840.1647951-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v3] libbpf: Add some details for BTF parsing failures
From: Ian Rogers <irogers@google.com>
To: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
valid kernel BTF" message makes diagnosing the kernel build issue some
what cryptic. Add a little more detail with the hope of helping users.

Before:
```
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
```

After not accessible:
```
libbpf: access to canonical vmlinux (/sys/kernel/btf/vmlinux) to load BTF failed: No such file or directory
libbpf: was CONFIG_DEBUG_INFO_BTF enabled?
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
```

After not readable:
```
libbpf: unable to read canonical vmlinux (/sys/kernel/btf/vmlinux): Permission denied
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
```

Closes: https://lore.kernel.org/bpf/CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>

---
v3. Try to address review comments from Andrii Nakryiko.
---
 tools/lib/bpf/btf.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ec92b87cae01..45983f42aba9 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4932,10 +4932,9 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
  */
 struct btf *btf__load_vmlinux_btf(void)
 {
+	const char *canonical_vmlinux = "/sys/kernel/btf/vmlinux";
+	/* fall back locations, trying to find vmlinux on disk */
 	const char *locations[] = {
-		/* try canonical vmlinux BTF through sysfs first */
-		"/sys/kernel/btf/vmlinux",
-		/* fall back to trying to find vmlinux on disk otherwise */
 		"/boot/vmlinux-%1$s",
 		"/lib/modules/%1$s/vmlinux-%1$s",
 		"/lib/modules/%1$s/build/vmlinux",
@@ -4946,14 +4945,34 @@ struct btf *btf__load_vmlinux_btf(void)
 	};
 	char path[PATH_MAX + 1];
 	struct utsname buf;
-	struct btf *btf;
+	struct btf *btf = NULL;
 	int i, err;
 
-	uname(&buf);
+	/* is canonical sysfs location accessible? */
+	err = faccessat(AT_FDCWD, canonical_vmlinux, F_OK, AT_EACCESS);
+	if (err) {
+		pr_warn("access to canonical vmlinux (%s) to load BTF failed: %s\n",
+			canonical_vmlinux, strerror(errno));
+		pr_warn("was CONFIG_DEBUG_INFO_BTF enabled?\n");
+	} else {
+		err = faccessat(AT_FDCWD, canonical_vmlinux, R_OK, AT_EACCESS);
+		if (err) {
+			pr_warn("unable to read canonical vmlinux (%s): %s\n",
+				canonical_vmlinux, strerror(errno));
+		}
+	}
+	if (!err) {
+		/* load canonical and return any parsing failures */
+		btf = btf__parse(canonical_vmlinux, NULL);
+		err = libbpf_get_error(btf);
+		pr_debug("loading kernel BTF '%s': %d\n", canonical_vmlinux, err);
+		return btf;
+	}
 
+	/* try fallback locations */
+	uname(&buf);
 	for (i = 0; i < ARRAY_SIZE(locations); i++) {
 		snprintf(path, PATH_MAX, locations[i], buf.release);
-
 		if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
 			continue;
 
@@ -4965,9 +4984,9 @@ struct btf *btf__load_vmlinux_btf(void)
 
 		return btf;
 	}
-
 	pr_warn("failed to find valid kernel BTF\n");
-	return libbpf_err_ptr(-ESRCH);
+	/* return the last error or ESRCH if no fallback locations were found */
+	return btf ?: libbpf_err_ptr(-ESRCH);
 }
 
 struct btf *libbpf_find_kernel_btf(void) __attribute__((alias("btf__load_vmlinux_btf")));
-- 
2.43.0.429.g432eaa2c6b-goog


