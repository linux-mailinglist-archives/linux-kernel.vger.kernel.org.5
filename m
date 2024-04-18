Return-Path: <linux-kernel+bounces-150859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F83C8AA5BC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C71F22B75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442497EEE2;
	Thu, 18 Apr 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WSGbe+l"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297D5762D7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482442; cv=none; b=qEgv5jYAEvXPYBYnImgzQj9uEz+4jJpK9r2vD3CWQvRx5196ARnSaWmvHeu6KtBewNW63BB1GIOUY2NbX4WPJWEG0nk4VR1g+bOimPOcywHN5C1tQRENx9G7N78gZmTU8iZozGYr/WL5puXNazaWyx4XqGGR837vIGo7iAJ9Lhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482442; c=relaxed/simple;
	bh=Q+72qrXtm3Xqm1QYlQ/ARcpBQmoPZPgK3ApUYdbDx7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9jxBbxjMU6eq3UnFYLx7pQCCdjOJfiSj1U9Xu3VPWVML4TKvUZ4hZd2OiBo4F7q4M7zgnJWNLd2Hl35/s9KWmn4zLszO/ZgxOWQumJH1uL7R+HAXW/faw62K8BA5VA4Esdr1FelLHijwFgjzB7o94+yhWTDAmXbZCntzIYNH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WSGbe+l; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61aecbcb990so27440577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482440; x=1714087240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9HSeHzPuGtWyHVXG0SBH6UyvQOr79hE7Vg79sXvjgU=;
        b=2WSGbe+lgquQp/VFNauRnLmTTFiykoWFbsEvN+waloQqhnLNwhTtv3BW8m7p01mHc6
         qrZMi8sTe0gHcP5yJLjJmUK+l3teVVlKkaxqIk3FaN/Q2CyImGqm8HKNsVlPnFUr0/GO
         p1SYqqOkZ/DH+zELOqjK9988QGyDtb109H7gZZrOErLmqZEmvolgix0+dwNCXZlK7+1e
         OhIVoZFMd40HoPYXmC53bm8UTLsu2GB4AdkcBw+tU9KIJ+odi49mvS0hzrhJYa2twhvP
         u/arTdaX/rsMpnTbubG/pi2SdL5Zx/RSOY98YIFt48nrZ1UajoTEMua7wonnhf938YZd
         48sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482440; x=1714087240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9HSeHzPuGtWyHVXG0SBH6UyvQOr79hE7Vg79sXvjgU=;
        b=slzQY+YpexKDlIniys36UYJp3WVMyjoqVFtUE3yNQo+VTe8RmEh8dZNLKGcPLUjRZb
         jDPYsPZW2SnBjhia/o4Z+VdmbAk3/BJV+XM9Ix4oCAdsHAz6DM4png3pQrpSqIzjW9/W
         165vGg71LL5Eo+20h69qzEYfqYn/AJlZyNOdWlbif+MxTdEGwlpNDyHRNuNnG9PUoMqv
         wVnuQp9Ed2WFR71xRj/HW3Zf1qLPgCLti5oEOZwPYm7UaaGxumB/El+If86B033ZHmu5
         KQJEJJbtjLXXluTo9XyvwuwLbAjWTPx46O7E4hu6Wcq436pYJ5qr1RYyZqe5OFK5p9/j
         +rMw==
X-Forwarded-Encrypted: i=1; AJvYcCWeDn3R0q0PRI8B84fSu7unowrm2NbSLD+6ewpUOaLehfPZk0dBJeCaUXYOmVZuITE4GsBmMAO9PHn84u67AB+1PoJUIqa0hyVc6SnI
X-Gm-Message-State: AOJu0Yw/+LAtlwcg4GP8dbDEhgkGbwuiJcOMo6UQf3IdkmmI9DC3hN07
	SFOsi4qMk5NK7de98S3Yswq+8tSLDEc9KI58Ok9waivZnLPyL+u58iQRPEf5CwekMOSGjm5HKZC
	kCw==
X-Google-Smtp-Source: AGHT+IFVENWOQrhyE9ZFDpAXDlThECm3CQcbnYXp2g9WsRBiAe+oNdRYITno5N/z+Nt1e8YR6fxhOoF7uMs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:52c6:0:b0:61b:3a8:330f with SMTP id
 g189-20020a8152c6000000b0061b03a8330fmr112441ywb.5.1713482440230; Thu, 18 Apr
 2024 16:20:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:50 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-5-edliaw@google.com>
Subject: [PATCH 5.15.y v3 4/5] bpf: Fix out of bounds access for ringbuf helpers
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org, 
	tr3e.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Both bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument. They both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

Meaning, after a NULL check in the code, the verifier will promote the register
type in the non-NULL branch to a PTR_TO_MEM and in the NULL branch to a known
zero scalar. Generally, pointer arithmetic on PTR_TO_MEM is allowed, so the
latter could have an offset.

The ARG_PTR_TO_ALLOC_MEM expects a PTR_TO_MEM register type. However, the non-
zero result from bpf_ringbuf_reserve() must be fed into either bpf_ringbuf_submit()
or bpf_ringbuf_discard() but with the original offset given it will then read
out the struct bpf_ringbuf_hdr mapping.

The verifier missed to enforce a zero offset, so that out of bounds access
can be triggered which could be used to escalate privileges if unprivileged
BPF was enabled (disabled by default in kernel).

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: <tr3e.wang@gmail.com> (SecCoder Security Lab)
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 64620e0a1e712a778095bd35cbb277dc2259281f)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8cd265d1df34..33fb379b9f58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5340,9 +5340,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
+			goto force_off_check;
 		break;
 	/* All the rest must be rejected: */
 	default:
+force_off_check:
 		err = __check_ptr_off_reg(env, reg, regno,
 					  type == PTR_TO_BTF_ID);
 		if (err < 0)
-- 
2.44.0.769.g3c40516874-goog


