Return-Path: <linux-kernel+bounces-117327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC288AA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5A71C21EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2FA13E046;
	Mon, 25 Mar 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1j7S2Xn"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4B3DAC1F;
	Mon, 25 Mar 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379269; cv=none; b=ozlqWyD5asCM9fVYtRpSfUMgsUEWuzQ1oQ/3hEDy10VhSVwTDOf83G/Z88glYg/fSMRBDUWXkHk8FHkdHmZUewTX/7S08X6WGE6NeirY1gRRM82gAfAIMaLBgIrJvTu4+oOMoy4a3XFQbhAmk2PMtisiyk+r4PYUP3iqChNlVmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379269; c=relaxed/simple;
	bh=oF4dc2zv9px59M9+jVOFyy1eFe3OwepJb5zVZUKllQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBA2cTqEyp4OypUGbUK21esioxxoWwPKjlyv++qb0942COE96giS+ROG1aCHdHAaTZ5Yh3PcNR/chY6yMfTrDwLB+Kpt0RL97opzpxkK3cU/oyP38YlcXs/c1EHyz1U1FMPFaSnDEQIvmCVypur14nrzGWqPi9zDigmovCGJdAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1j7S2Xn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4148a139b1bso5149245e9.2;
        Mon, 25 Mar 2024 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711379266; x=1711984066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNggVnYXxU8aQa9rXUjV6daL6DGtWhyAhvl/znd0gWI=;
        b=H1j7S2Xn0Empx2i1mVXXO7RqF+B+80ZrtttBUn6H+86hN9rUa9GCJIJllIVFitSXCz
         yv4R1o0iQ1eVsrfkAwfX8nQN4cECMGRIyG6J9ZFLQrrn3m4A2GLXxdLBocSCuX4M6tx+
         E0ypPDbPM0RHRFtDzpCA1tdYF+p6P6JrHyOqjQc+aDkb3YjtXrZp8E4hrd1y2K0Kblh5
         umPqKgTEQZ/qeJJyMrAX6y0u2Jq6EtU+Mvf5p05AmjHhnl3uM+Octt43ki5QCqzjFIrp
         13uLzVRaeLofB9Y2dplOpeL1pq/nQUpdTeRGJjydgvKIS2xaLet5M9A1h9WQvddbOGJ3
         KaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379266; x=1711984066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNggVnYXxU8aQa9rXUjV6daL6DGtWhyAhvl/znd0gWI=;
        b=h+v8Yn7zmMBnbcb5bapeNKBXKPz5/w0o/CSTTzAa+F5i09hHQSCkJFqYcYxetlMHCo
         hKm6i2Zxygze9xUnk0DdDiCUbAfktrPZ1B1avuV1oIqD1ybpZ2SZ7agrh/Wu4GAjsPyV
         e3vCPinOH6shGilCi4JG8PrLSQt8vnuRhe12/6RCQH7bODLKmtr99mXhV5ojqJLayYiM
         XwFOrybaKrpaYDn4TLKNZFPNNgSCV4LxAJdeEW3VxJWpzPgPVaY8v87uLFjY+XKNi54c
         3naiilePmn8Fh+fibJ+CD4ZWau6YIUpGzKTuMhvunCNZibMmcZrcfTdZbTBYvkfbDawv
         KARg==
X-Forwarded-Encrypted: i=1; AJvYcCVY+GDCv0N+w57/djGmTtKKNGej9OIy1n4JX7oponf5KQxo1xAbh64DcLAx2WNtk7lvX7gyKLHOxm0ymv//2afoS893n7DTG3rAWkTIB9Rh/Etbg0CMJspn1h0eoS3IlkVL
X-Gm-Message-State: AOJu0YxbfZge9CbmKV13xoWET/j1TT0IwwNgXVQd0uZDrMv92NSd/k5b
	ksAZVTLRN2tNjQ3rrb8bN/BnM2DADb6NM9/PHd9n/mchgm+Pz/pv
X-Google-Smtp-Source: AGHT+IEto6KWjT3iA21Y586myE/+4NhidErEv+/ibNd2PFWFl0kHMKHhjBzIAjxGFD/YBDkxEdoe3g==
X-Received: by 2002:a05:600c:1986:b0:413:1f65:ec19 with SMTP id t6-20020a05600c198600b004131f65ec19mr5606716wmq.37.1711379265738;
        Mon, 25 Mar 2024 08:07:45 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b00414854cd257sm6588132wmo.20.2024.03.25.08.07.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 08:07:45 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v4 0/2] bpf,arm64: Add support for BPF Arena
Date: Mon, 25 Mar 2024 15:07:14 +0000
Message-Id: <20240325150716.4387-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in V4
V3: https://lore.kernel.org/bpf/20240323103057.26499-1-puranjay12@gmail.com/
- Use more descriptive variable names.
- Use insn_is_cast_user() helper.

Changes in V3
V2: https://lore.kernel.org/bpf/20240321153102.103832-1-puranjay12@gmail.com/
- Optimize bpf_addr_space_cast as suggested by Xu Kuohai

Changes in V2
V1: https://lore.kernel.org/bpf/20240314150003.123020-1-puranjay12@gmail.com/
- Fix build warnings by using 5 in place of 32 as DONT_CLEAR marker.
  R5 is not mapped to any BPF register so it can safely be used here.

This series adds the support for PROBE_MEM32 and bpf_addr_space_cast
instructions to the ARM64 BPF JIT. These two instructions allow the
enablement of BPF Arena.

All arena related selftests are passing.

  [root@ip-172-31-6-62 bpf]# ./test_progs -a "*arena*"
  #3/1     arena_htab/arena_htab_llvm:OK
  #3/2     arena_htab/arena_htab_asm:OK
  #3       arena_htab:OK
  #4/1     arena_list/arena_list_1:OK
  #4/2     arena_list/arena_list_1000:OK
  #4       arena_list:OK
  #434/1   verifier_arena/basic_alloc1:OK
  #434/2   verifier_arena/basic_alloc2:OK
  #434/3   verifier_arena/basic_alloc3:OK
  #434/4   verifier_arena/iter_maps1:OK
  #434/5   verifier_arena/iter_maps2:OK
  #434/6   verifier_arena/iter_maps3:OK
  #434     verifier_arena:OK
  Summary: 3/10 PASSED, 0 SKIPPED, 0 FAILED

This will need the patch [1] that introduced insn_is_cast_user() helper to
build.

The verifier_arena selftest could fail in the CI because the following
commit[2] is missing from bpf-next:


[1] https://lore.kernel.org/bpf/20240324183226.29674-1-puranjay12@gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=fa3550dca8f02ec312727653a94115ef3ab68445

Here is a CI run with all dependencies added: https://github.com/kernel-patches/bpf/pull/6641

Puranjay Mohan (2):
  bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
  bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.

 arch/arm64/net/bpf_jit_comp.c                | 86 +++++++++++++++++---
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 -
 2 files changed, 76 insertions(+), 12 deletions(-)

-- 
2.40.1


