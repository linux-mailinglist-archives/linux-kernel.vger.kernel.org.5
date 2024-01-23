Return-Path: <linux-kernel+bounces-35996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032B78399E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049BC1C20FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365B82D75;
	Tue, 23 Jan 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ym7vxU2D"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3432882D68
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039696; cv=none; b=fVqg2ETNfPwNI3+WZhgHDWMnlMN1kJ4hnsgJr/h8fodyvUIwKyJtwyGPTM/W9Dp3MzYKYgoNHx60GiWjNkHsh78HnjE7nVFtl8OND512wHY5QOauKU4todA0lYSD0YBSRsednaLPlqV0kPUWVZYEQQT2bbQ1fGS9Lg++5YQ9nr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039696; c=relaxed/simple;
	bh=HsE80BSDf3dP7dp3QIx/zCpzJs9ZWELkp2KEUKffScw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=GaBqs9kdjmyLKUeYxMTOTZAihoM4W5Yh6IheRV2v2PYZ/EQnce85sxzXcj/TnJAn2rwuzjjWEeJRSzW/U0lKkFEqDmQn/6oxWFhIHovVDWFbVu0FqIUrC7H+sxJvhPoUDUbJgwuPnr65t8y6PGn7D6YQVzezxkCHNHe1mf/DL5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ym7vxU2D; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc223d528cfso7113081276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706039693; x=1706644493; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhpX9hlE2Pci6VpOvhAwdkAo2oTmPgpj24BygTfmpHM=;
        b=ym7vxU2DD1SekWj+p8oY6xNLs/mGDhMzcWceyyPljE/L5dBzR3Ozz/7uTTRAssq2Ve
         GtsakM9yZA2SZT7QwhCU8FRiDrS3ti6mZOslkbfqiqXPEqxWy8a9AQ5O8+O9vpLVXbPe
         lT1WJGi1dmDhZlwVd/coY8xEhilGwIf1w0HPE6GfuvgGXTbUW2hbba1Ar0ZfB9YLkDSl
         n2Dsx8E2AC1p6hmv9PhCproTCAenKW5egLVixaaGuG7Ht8F5ac9a9lhTQ9SENH/6Et7Y
         IBtttE7yCsRNoZad5LGerQ7nYSH/sll+Rzp0GHVDvfcH+vtCxcg+ttNK7A/zbDsbv8Y4
         6O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039693; x=1706644493;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhpX9hlE2Pci6VpOvhAwdkAo2oTmPgpj24BygTfmpHM=;
        b=wRG1+uh6cTaDfqYRfv03Y0IWU8NU6ywAIDAsZSbWJfM8sXeLtQBT/9Rn3YNocOQMR0
         GlQZ2AvHvRmv/jcmXWknaCtOqtxYoO5PyXynsVDEMprqMyyaqgeR0dj4+aBBvG0oLkde
         QiszP8lfic3vHGuqxmfWnifyhxzNitGf8fD6ocg/Ls8h6TGHkxr2PkBrJAFUqoxQN17x
         y5VwflwYtWVZqnNkOOl2WnuGbnZBax+A1wzuYg0O0ghSTCXgheZ+4iIZCqwvC3kssshH
         ElaCH0ouDZuBj8KBkdG26wH6yVcY/byb6S+g3nyZDjxjAtFBE4wp13JZvBKPe8tRVrMu
         ksVQ==
X-Gm-Message-State: AOJu0YwWxLATivnaTeNT6oUD5Xuwed2brnieRmuj780+W2sMJpMNfB3i
	/a0H/qrpZMHjK4DhSpTr4YLn3jVX4fN2BDvDDoqAPC5F3nH5Gz6kMAf5T124Ohm8wLGN09c4Ioe
	0RBc0jA==
X-Google-Smtp-Source: AGHT+IGAmS9Av+aJTpDnAXc+u2Z8XPgjzx85lccoKtnPOVvsWpoyTGg+NCMM7VkLAT8XQa12c5Cht0GU8BAs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b12:b0:db5:4766:e363 with SMTP
 id eh18-20020a0569021b1200b00db54766e363mr2807736ybb.6.1706039693262; Tue, 23
 Jan 2024 11:54:53 -0800 (PST)
Date: Tue, 23 Jan 2024 11:54:49 -0800
Message-Id: <20240123195449.1303643-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1] libbpf: Add some details for BTF parsing failures
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
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

After no access:
```
libbpf: failed to find a kernel (typically /sys/kernel/btf/vmlinux) for BTF data
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

After no BTF:
```
libbpf: failed to find BTF in kernel (was CONFIG_DEBUG_INFO_BTF enabled?)
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

Closes: https://lore.kernel.org/bpf/CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/btf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d..505c0fb2d1ed 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4942,6 +4942,7 @@ struct btf *btf__load_vmlinux_btf(void)
 	struct utsname buf;
 	struct btf *btf;
 	int i, err;
+	bool found_path = false;
 
 	uname(&buf);
 
@@ -4951,6 +4952,7 @@ struct btf *btf__load_vmlinux_btf(void)
 		if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
 			continue;
 
+		found_path = true;
 		btf = btf__parse(path, NULL);
 		err = libbpf_get_error(btf);
 		pr_debug("loading kernel BTF '%s': %d\n", path, err);
@@ -4960,7 +4962,11 @@ struct btf *btf__load_vmlinux_btf(void)
 		return btf;
 	}
 
-	pr_warn("failed to find valid kernel BTF\n");
+	if (found_path)
+		pr_warn("failed to find BTF in kernel (was CONFIG_DEBUG_INFO_BTF enabled?)\n");
+	else
+		pr_warn("failed to find a kernel (typically /sys/kernel/btf/vmlinux) for BTF data\n");
+
 	return libbpf_err_ptr(-ESRCH);
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


