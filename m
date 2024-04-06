Return-Path: <linux-kernel+bounces-133871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304CB89AA23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 11:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E171F222DA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA2376EB;
	Sat,  6 Apr 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dTTemcW8"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CC23A8E4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712395222; cv=none; b=LL9TvjbVJt2H1S7HaG2FEEW/HpihwX/jet13Jil5gxi+URKPWkubqmQDlbBWdEazcV9r0wxNbbzCi0dpNrDUqKQxWdRRNtGzJGVAsozPU8GMqH2YU3kqZa9dvbTrF0COqc1XOPYT5pv7M/LJvnR/fR0jHWb6zWuQtGNtLExyrVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712395222; c=relaxed/simple;
	bh=wls7Uj9lvj1C2cR+9fWVS8Sq79ZqlDYd8ckzjVd9vKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQBVJeQ/gmN0T56UQWpmu1RDxmDSyGs4cBG6iGhEkxASnTPCO37yK7h3qNvlCi6JZkfcBH9r0bE/qnBwmBUIr/TJ/wk7bzUryJj6toOvvMZLZRT5zTUj/Wc/bJl/gMpons7nPgzsVtIV0W93iZxVrruwTih/kIeYi5q9ZTqir/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dTTemcW8; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 18AF142491
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 09:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712395216;
	bh=yx7vpzXIHTYh5j3nTDQp+mlNbiWJAYHc0w9red4g/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=dTTemcW89wPCE3kxSJqUC+M/Rqs9uBto0yzTF+UN4tDLeX2jOrTnyB38xMu/SZOm5
	 6HmXr2+otfYFvoyS7+fGWESgb4eUJkyA0eECdQWTjbjZu08DPoY8dbMVeN0ODVLIWI
	 IDPA4uoA8vXs9MDALGlkZZaBmdDWifYGdjH4n5D4Em3DVc5plJGd5gwWdkNbDCQNEw
	 ceRX3YNwnoI4NU2mgWQlHbDUpPK8lTuGrZ5ONvLLapcb20YBiaNF6ssT80LHSJ6B6o
	 TKmSeTRmpZiauZUaELT9NhsU0YRyAIwqyBHR2HcR7cZmI7cSGev/KO3Y4s+2hpe4Ud
	 3GT/vQX5Clp0w==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41489c04e3aso13581185e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 02:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712395212; x=1713000012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx7vpzXIHTYh5j3nTDQp+mlNbiWJAYHc0w9red4g/BM=;
        b=n3EPhVtPZ3rpm8cYyHxNa/bE6HRWOyxufBpsc687ljWm/GWW0r2YGg0XA87sNcQ49d
         oDH7JvRY9r+73fguLU6J5AMgCkls0579dDZdqWHz7oz9eY0hInBK2S8FZ1IWetETyonm
         gV1uABivDk4oKFhSIwukSa2E33ntuvfsQJAUB4IxwN4IWvpCf0HBQi2p1JL0OSrqRb26
         JlOfaj2HA6p+29JmMPQ9CEo+3muDtIQA1x6fiFrrNWvpJYwXYC8rGwxRyYwQrPLbC6aC
         rrRW2LrgpnIqJn1lznZR8i1IuXUJPEVqqWwJqPDXlvhxM0F+NsLpippW4/FKrUaCDXuu
         fgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLVzgczU+C/vf9bpdrp4auEJjRV3mm/k7sGxWekyTd5GCjX6b+X6wm+cgix3II8XBKEpQ5/NP6Zv9fjnTgQJmIfbrM3abpzS63pMb1
X-Gm-Message-State: AOJu0Yzo5UhARqa4rYtLcWY1S+n2IVKpGtUrpoOma9yhsn2uGWbDHDyv
	3m8V4f5im4VHxGymuqAoAQ6Wjon9vS1OJeG1C3ZUl7YSXMr2Zyf9tmvluruO31FAS0DgBcHI/0b
	HlBr+EdVj/hw6ao+CgJb6RkG1wmvuVrqhIBIwZ4/iTJofouvp3T6OempiJJvIUXX452iTvg9wfm
	favw==
X-Received: by 2002:a05:600c:4e93:b0:415:691c:f83d with SMTP id f19-20020a05600c4e9300b00415691cf83dmr2852396wmq.33.1712395212471;
        Sat, 06 Apr 2024 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHit5kOPUjw5jx+vy2tg5jUYvea3lG9TQoPRZVf5aXYZyCaWrS8RAEXac+i+7u4IVkSCPt8Yg==
X-Received: by 2002:a05:600c:4e93:b0:415:691c:f83d with SMTP id f19-20020a05600c4e9300b00415691cf83dmr2852376wmq.33.1712395211958;
        Sat, 06 Apr 2024 02:20:11 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id l23-20020a7bc457000000b00414924f307csm5779993wmi.26.2024.04.06.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 02:20:11 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] libbpf: API to partially consume items from ringbuffer
Date: Sat,  6 Apr 2024 11:15:40 +0200
Message-ID: <20240406092005.92399-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ring__consume_n() and ring_buffer__consume_n() API to
partially consume items from one (or more) ringbuffer(s).

This can be useful, for example, to consume just a single item or when
we need to copy multiple items to a limited user-space buffer from the
ringbuffer callback.

Practical example (where this API can be used):
https://github.com/sched-ext/scx/blob/b7c06b9ed9f72cad83c31e39e9c4e2cfd8683a55/rust/scx_rustland_core/src/bpf.rs#L217

See also:
https://lore.kernel.org/lkml/20240310154726.734289-1-andrea.righi@canonical.com/T/#u

v4:
 - add a selftest to test the new API
 - open a new 1.5.0 cycle

v3:
 - rename ring__consume_max() -> ring__consume_n() and
   ring_buffer__consume_max() -> ring_buffer__consume_n()
 - add new API to a new 1.5.0 cycle
 - fixed minor nits / comments

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (4):
      libbpf: Start v1.5 development cycle
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n
      selftests/bpf: Add tests for ring__consume_n and ring_buffer__consume_n

 tools/lib/bpf/libbpf.h                           | 12 +++++
 tools/lib/bpf/libbpf.map                         |  6 +++
 tools/lib/bpf/libbpf_version.h                   |  2 +-
 tools/lib/bpf/ringbuf.c                          | 59 ++++++++++++++++++++----
 tools/testing/selftests/bpf/prog_tests/ringbuf.c |  8 ++++
 5 files changed, 76 insertions(+), 11 deletions(-)

