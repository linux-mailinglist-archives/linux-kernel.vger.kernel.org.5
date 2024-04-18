Return-Path: <linux-kernel+bounces-150855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F848AA5AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2381F1C212CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1F757E7;
	Thu, 18 Apr 2024 23:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EO4vCHu8"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A32495CB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482427; cv=none; b=oFOUlH4GVgrK+3CKs5qFiWYGPsJGRJmRflAvFkzQJQVkagqy7xid0T04d7EHBrJlLb0GtaVX4YjB1dkoKVlixqwUfG59UN0of76q3d4NSXtjG/zj4yC9HtuTKvUV4jg4hm34X8lAEFNf5i6Y4iK/goa8h0FeqotoEmTBpyPEjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482427; c=relaxed/simple;
	bh=h4Z5MLdi8J9t3gzna+fG2ThqFUoIZcOZaNd46qMwcq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCpQoDzj4nLjYrC4Ci/YKK3gAczg7oxPUz824QUz1lP4FrlDqGlu5ezzlVwC4l4VwQ6s/Hrlzj18ZbFm80zXLtofT00KQzcgcG1FW+FFvTivEo1o6PR+BGTsd++E0qF13TRusgNgS116rULwFz2vWUfNMICEKLg+J+NhZIwnIm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EO4vCHu8; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso1540051b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482424; x=1714087224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=26meAcCrC16s/TSKv+80D/MrO7azFsmm58EfNKygcv8=;
        b=EO4vCHu8HBfTVlRaYF4hN4ngr9nr3qbtyKtJSUkHJQHdegu/AvaB3O7kAYVbXAM6aB
         YCRXQ7RuhsFyro6my4lIq3h8He2yZFsksiBhqXUnuMIXzPlA4RVuIMNtCirEBhyAujDQ
         7GlKkYYzh7Qhiyucq7m2hV7dGqW2God9C5jIUVNGxjfHOau3nlgGEZcRX6YlFt6W3sF7
         K5X2ppIpoURVfuISZ92jNfzCe3RuQLl/31K+KvK4gkVvAMCHtayzG0z+GNS+Uq2Di9Jy
         pHMKiaYk7joykLG6ArEPWuRVHozL0Y6vEsC7ehWppYWJhN+zsfvgEmS4jMCxRQicVKgU
         z3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482424; x=1714087224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26meAcCrC16s/TSKv+80D/MrO7azFsmm58EfNKygcv8=;
        b=Oimvfy7N7uCMQM+u0TgwwEio30cD80DxQgA/f57X2F6dOrWgL2rG+d82Lvx+5Py04o
         Uic3TiUf1jD/EF2nEOXhsrL7YMyOqKPCvLgN4/UbkyvRrgl5niGad5u9et/wlNCCJDYP
         8aP6a+CWEsBZm+Dj7rDiIS6s4cKkaECSmCjUQWTOVE7pmLR+CpQ0INP6xvI0lUyoHe0k
         5JOuaaZCIyKLMVWHYHzbG8M240cP9et74AZgbMi4CLDOaBlQV+YJJGqG9O3l50wjTC5s
         4f7ckTupJPjzah2aQyphkN1TApWACaXSP+3iUWML9noVdKtBbyDPPC/+vMxOMfKw09yT
         jiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBH2kkbVzbVGqAxFJz4tz8fB4E9CVkwQxpKFwyi0pKCTdbBydMbHY5v0HQoz+OFWPAn9hXOLrjIWZv60UjBr6/Wc2FbuW7ZSsQMCre
X-Gm-Message-State: AOJu0YwkHf+jIMhZztIFi+vcVamDXF4VozZl2swH6JJhuTteZ4WYUaqR
	ZeHYdPGDybagEG3+oz+aBqll/daQ3Zy/mqS+U/3piAZ/FlsOt0DaDys4NnZhM4Of+KdIR1bI9OV
	iuA==
X-Google-Smtp-Source: AGHT+IFCT+LD8L7Ydyey8ugQxfC4hQL7hz4SeRVez+Chgb/ZmrwQpoWBky8hs4o0JI2AHzcCAT53BPCTo9c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3998:b0:6ea:f425:dba2 with SMTP id
 fi24-20020a056a00399800b006eaf425dba2mr50612pfb.0.1713482424349; Thu, 18 Apr
 2024 16:20:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:46 +0000
In-Reply-To: <16430256912363@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-1-edliaw@google.com>
Subject: [PATCH 5.15.y v3 0/5] Backport bounds checks for bpf
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These backports fix CVE-2021-4204, CVE-2022-23222 for 5.15.y.

This includes a conflict resolution with 45ce4b4f9009 ("bpf: Fix crash
due to out of bounds access into reg2btf_ids.") which was cherry-picked
previously.
Link: https://lore.kernel.org/all/20220428235751.103203-11-haoluo@google.com/

They were tested on 5.15.156 to pass LTP test bpf_prog06 with no
regressions in test_verifier in bpf selftests.

v2:
Made a mistake of not including the out of bounds reg2btf_ids fix
v3:
Merged in prog_type fix from f858c2b2ca04 ("bpf: Fix calling global
functions from BPF_PROG_TYPE_EXT programs") and rebased to 5.15.156


Daniel Borkmann (4):
  bpf: Generalize check_ctx_reg for reuse with other types
  bpf: Generally fix helper register offset check
  bpf: Fix out of bounds access for ringbuf helpers
  bpf: Fix ringbuf memory type confusion when passing to helpers

Edward Liaw (1):
  bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

 include/linux/bpf.h          |  9 +++-
 include/linux/bpf_verifier.h |  4 +-
 kernel/bpf/btf.c             | 93 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        | 66 +++++++++++++++++--------
 4 files changed, 129 insertions(+), 43 deletions(-)

--
2.44.0.769.g3c40516874-goog


