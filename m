Return-Path: <linux-kernel+bounces-133687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CA689A75A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 306D01C214E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0133080;
	Fri,  5 Apr 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tU3grDjv"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B923746
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356577; cv=none; b=RcmWAu3xqZSIZO+Hv+GTNGLSbCJSJXltexKamjRidTJcyYaUSXJQwwFW7Q1VcWxH5JGySgArhEeWyr6Bf4wSrkb8TKJfyZ3gB+oIxSzeBVF0NB4yzC63ltvP5Ere6CGHhcJKc4wJP/Tbe6H2Ax3rHjgizDViPr2ZLvxxwvb5In4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356577; c=relaxed/simple;
	bh=/px09ujzAHJr7wkYdKqkViF89YvaXMh7Oizbh/L9Ky0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a8rK7yy4bFte+9+eJAvf4O931CKxS8mBNF48bgg1KDHHh4zysPc3pOgjxLUwq4OT0nAXRYIUIphrT+t3tm3zca73V7roh6dsqGX0W/6JpP/BjTWVVrG4flg5QuL4a041vnzmLgz1hfFsh8ysR1WU3q3Y9kjRAfanU3uZhNdEodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tU3grDjv; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 586D23F15B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712356561;
	bh=fSrDD1m/j/08PTY1wUCU2vVtrS5jJDIUizunq/Dwn6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=tU3grDjv3nPbNovc07dVGb/k0caLVrM5CgSbbBSJWwXojcQAXh9JBgnSmCAvCsVTx
	 /Ayq8LKhn0o0gyY3OJGYINhixSJRqk+DGCoMaMI38VKGWpXg3O2k6mgFcm46AWj+Iz
	 S9uF4wnwwSgVweSkWd22ih/BRW4YHh+Zu4MOM+EOQi47DcKHOXE3wNQlUy6wFJ4ZRV
	 iLBHQ/6/bHvutw8CqFWWu+nnvU6BxpuLfFZdbunxTduFdH/a1DxOubyi6qXucdr5do
	 WO0IRdxkge0AmorM2IsHh8iU+BMqptNgoIbLl1v3JYQsl0wjIj9Lyaihuxo6JXJeI2
	 PMrEmPwLvRTHw==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4154b265b93so13556805e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 15:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712356561; x=1712961361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSrDD1m/j/08PTY1wUCU2vVtrS5jJDIUizunq/Dwn6s=;
        b=AG8YCh9KiNrDUAPkKAHgJ2/Rjo3OZzNwlxYoippfUNye/YJv1EOcMw2Nh1HF12fZCS
         l+8y+DYVFf20pTwPI+V+wG7JngVRcCBSklltRMMsCmcfuIbPIF9ulelXrOIVr6uXUbE/
         dW4+ziHt90ELVI98znmAlPhlNQSV22uO1YsTPky4d79LtFrHEoGVX0t2d2xgQ+Z8ou7C
         OP3vg4Rj43j6uBlfLK0GyppGrKd46rFBU0J6xoVVVy3/35wV2rOq8xouvVtvZUNka2Ku
         KlZqMbhaL4EjkOFmh+l4uqiDHyoo2YVyoOsRxhchbVn5AjqN7HJzpGw7XQG4ZW9cATur
         xEGw==
X-Forwarded-Encrypted: i=1; AJvYcCXRgYgfaurS8FmxDT7G3UMNQrQMJx7rMhMUOBFNI15Z4kub7IKr6RuYhV+KXAmKbmgP0LS/dbXIa/I9ARLSfue2wyViGRbUhfrW84uv
X-Gm-Message-State: AOJu0YzvAUB985ylA56yMf4g5FIprJ6LiOlZqGC0C2V5/+ISwxl7/VCD
	p4vwBsr4XK/t4nw2o6r6NZuWG/8xnH/EUGsVsnax0ZZeH24eCZ6kT9MSR36u3O0ixJat5jgeHW9
	+kg2oTMJDaygPh55t1jnz64yhyOKerrzutTFrmEc8ISfDnIFQ4c08J7znQ+EMRFVkNkz3oYyDUl
	rkfA==
X-Received: by 2002:a05:600c:19c6:b0:414:6ee:a37e with SMTP id u6-20020a05600c19c600b0041406eea37emr1931739wmq.19.1712356560903;
        Fri, 05 Apr 2024 15:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFQ6g1NqU4K3c/Xc3WNJ6JUvle0WbR6bLipgaKBNr4stR/TDUIEuDx9Uy0DMzD+l+UwmWExQ==
X-Received: by 2002:a05:600c:19c6:b0:414:6ee:a37e with SMTP id u6-20020a05600c19c600b0041406eea37emr1931729wmq.19.1712356560354;
        Fri, 05 Apr 2024 15:36:00 -0700 (PDT)
Received: from gpd.station (net-2-39-142-110.cust.vodafonedsl.it. [2.39.142.110])
        by smtp.gmail.com with ESMTPSA id bi21-20020a05600c3d9500b004163334df40sm1475698wmb.19.2024.04.05.15.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 15:36:00 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] libbpf: API to partially consume items from ringbuffer
Date: Sat,  6 Apr 2024 00:16:03 +0200
Message-ID: <20240405223556.11142-1-andrea.righi@canonical.com>
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

[ Note: I haven't implemented the special case of n == 0 as "no limit",
because we still need to add a bunch of extra checks for INT_MAX, making
the code less readable and, from a performance perspective, it seems
that we may get more downsides than benefits, but I can try to look more
at this if you think it's worth it ]

v3:
 - rename ring__consume_max() -> ring__consume_n() and
   ring_buffer__consume_max() -> ring_buffer__consume_n()
 - add new API to a new 1.5.0 cycle
 - fixed minor nits / comments

v2:
 - introduce a new API instead of changing the callback's retcode
   behavior

Andrea Righi (2):
      libbpf: ringbuf: allow to consume up to a certain amount of items
      libbpf: Add ring__consume_n / ring_buffer__consume_n

 tools/lib/bpf/libbpf.h   | 12 ++++++++++
 tools/lib/bpf/libbpf.map |  6 +++++
 tools/lib/bpf/ringbuf.c  | 59 ++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 10 deletions(-)

