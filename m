Return-Path: <linux-kernel+bounces-79520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E7862392
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFE51F23C42
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A05199A7;
	Sat, 24 Feb 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Y548vkAX"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B871A175BF
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765486; cv=none; b=TnkgzzicaRkGjKFdgtnfLCnY6QAJaxg01BoikrBtT0uFa5uTrqvSZJYZ4o8E71pG1p3LWj+Gu04OYFJ8wNBWjxeNXLYSIXv2dsXrmgBqrINcKOiM49kWupeDBSLAEyDS9TJyAz3sN8bmcVPARDbJ4dfWrI0XoD1nLb30QULb18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765486; c=relaxed/simple;
	bh=2bvz0RaABemvB2mAnUI+y9KXZ+nJBiW2+3XKY5GafdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ajregrXzLOoE6bmPhokuDvo5Wa8VB8S2Ykl/b1nu6uQA1Q/52icaUUwiS5p9zzqXGK0oCF4n4LiiQfrdZEMoZZoD+Jw7LSfKY8ypuihnwuyj8ySPBOYaN8vs97d4UxUeD65FTmW+0XDVcn/ywUGwaeUHVFBB54nr5FxrBkCsiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=Y548vkAX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4129f33d2e8so291535e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765482; x=1709370282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9oap1u4maFj8x6QB6Yv5BBkUdae4vegOH6+ONA60ss=;
        b=Y548vkAXhubs8Z/ze6bQEzkKASCNo93gyEsT+0s9GIxzq/KL1q9hMtmWnHCPzXIP28
         kqQ+u3RMfxCkJXsOF9zF87r+VDTCSz+K56ZxMS3IunmHfct0Aa1npsrWdDFi1TCZbHC2
         /KIJHrohkamm9HdpalxaX5NwdG+Y7nrhwcMxtaJRseYm99++aX34Lo75QNYa4qaWyJRH
         j1bkoYHUWYxT6R2rpBhWhue1jAf02CP4Q2O448rP0dCwuHMIv3aVJDeQOvhphJOgDMVZ
         wRhmGGgYfEV/ICw9Q0rFEjhQdeEXG7D01IFTENx++zW42bWU+95s4S3JUG0PSqc2AeQg
         hlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765482; x=1709370282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9oap1u4maFj8x6QB6Yv5BBkUdae4vegOH6+ONA60ss=;
        b=NEKc6IevUZL3xA4OpUWBNr7iU90HY/TBHuahV488eJYjdZSe7osEk+6E4iHCjoIWpT
         5tNaD2weA9tAoXQA0R8zZXARlsKsHN7kkbPHsSr+4vU7iX0fWBmaKa3TOjYb4zriIHr0
         h/4/RBsU//GqHYt5nBZ98oj078AlhUSuMCVYYoEBWK1Hn5TWbjxGaoNfgZ3QIEOEEJKI
         nhIZUaoQc+Ioep6TMGmzj9Rb4dbFCeEQm9iv6pKjTc2g0RFg4+dYlRrxaHX2Yx9p0o55
         6I+ZouasEWHD7W0E1LF4Wg34tTR3YZfXpU2v6yWVGCWDSzM5STX7CCWt0E63Cgh82G92
         kb9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWst+g+INII7hQTGqSCJz/2GgL+fZddiXe46G8ZhOo7w74r6eoDn5C2XRnxDCekEuD89JN4TdW0g5Ty8P8lqCOrOcBmFWZq15RR1La8
X-Gm-Message-State: AOJu0YwaHvAVIYz9h7su5Ahd4Nx4KuFtvbFQd/J2+NFQPM5pb93xoLLF
	O5KnlES8mKxOCfU0uEx68AbKLyh0Ph0x+lMvGj2YA3l+txKoEZeQpe6xF56WZg==
X-Google-Smtp-Source: AGHT+IEcyO8NJxp+wsPVPxwvDnVNJrMpXXH3Qo40PN1JaIPl7oWt3xo4EP5Ts6f9gNiSH8Hq5NdeBw==
X-Received: by 2002:a05:600c:5023:b0:411:eb73:243b with SMTP id n35-20020a05600c502300b00411eb73243bmr1255421wmr.5.1708765482074;
        Sat, 24 Feb 2024 01:04:42 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:41 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 00/10] net/tcp: TCP-AO and TCP-MD5 tracepoints
Date: Sat, 24 Feb 2024 09:04:08 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=2977;
 i=dima@arista.com; s=20231212; h=from:subject:message-id;
 bh=lLZCReK3ZzYvXtLqDF+R0iwQ1yaEauus+KvH0+vWic8=;
 b=NugEbW75fCKkDgfn3+AcpEDu+0iEc0KVHGPrv1p3Os/iJMBhc+JXO8gFuW0FLA47yz2UET5GM
 WFA4lYfgHGlAbGlH144UecbPi9h9XBX2QkDHrzHPXMwxBJOvBO8pKkn
X-Developer-Key: i=dima@arista.com; a=ed25519;
 pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: quoted-printable

I tried to split it a bit, maybe I could even go further and split by=0D
TRACE_EVENT_CLASS() changes, but not sure if it adds any value.=0D
But at least all preparation patches are separate.=0D
=0D
I wasn't sure if I should just remove tcp_hash_fail() as I did in this=0D
version, or rather put it under CONFIG_TCP_..., making it disabled by=0D
default and with a warning of deprecated, scheduled for removal.=0D
Maybe this won't cause any problems for anybody and I'm just too=0D
cautious of breaking others.=0D
=0D
Anyways, version 1, thanks for any reviews!=0D
=0D
Signed-off-by: Dmitry Safonov <dima@arista.com>=0D
---=0D
Dmitry Safonov (10):=0D
      net/tcp: Use static_branch_tcp_{md5,ao} to drop ifdefs=0D
      net/tcp: Add a helper tcp_ao_hdr_maclen()=0D
      net/tcp: Move tcp_inbound_hash() from headers=0D
      net/tcp: Add tcp-md5 and tcp-ao tracepoints=0D
      net/tcp: Remove tcp_hash_fail()=0D
      selftests/net: Clean-up double assignment=0D
      selftests/net: Provide test_snprintf() helper=0D
      selftests/net: Be consistnat in kconfig checks=0D
      selftests/net: Don't forget to close nsfd after switch_save_ns()=0D
      selftest/net: Add trace events matching to tcp_ao=0D
=0D
 include/net/tcp.h                                  |  79 +-=0D
 include/net/tcp_ao.h                               |  42 +-=0D
 include/trace/events/tcp.h                         | 317 ++++++++=0D
 net/ipv4/tcp.c                                     |  86 ++-=0D
 net/ipv4/tcp_ao.c                                  |  24 +-=0D
 net/ipv4/tcp_input.c                               |   8 +-=0D
 net/ipv4/tcp_ipv4.c                                |   8 +-=0D
 net/ipv4/tcp_output.c                              |   2 +=0D
 tools/testing/selftests/net/tcp_ao/Makefile        |   2 +-=0D
 tools/testing/selftests/net/tcp_ao/bench-lookups.c |   2 +-=0D
 tools/testing/selftests/net/tcp_ao/connect-deny.c  |  18 +-=0D
 tools/testing/selftests/net/tcp_ao/connect.c       |   2 +-=0D
 tools/testing/selftests/net/tcp_ao/icmps-discard.c |   2 +-=0D
 .../testing/selftests/net/tcp_ao/key-management.c  |  18 +-=0D
 tools/testing/selftests/net/tcp_ao/lib/aolib.h     | 150 +++-=0D
 tools/testing/selftests/net/tcp_ao/lib/ftrace.c    | 846 +++++++++++++++++=
++++=0D
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c   |  31 +-=0D
 tools/testing/selftests/net/tcp_ao/lib/setup.c     |  15 +-=0D
 tools/testing/selftests/net/tcp_ao/lib/sock.c      |   1 -=0D
 tools/testing/selftests/net/tcp_ao/lib/utils.c     |  26 +=0D
 tools/testing/selftests/net/tcp_ao/restore.c       |  18 +-=0D
 tools/testing/selftests/net/tcp_ao/rst.c           |   2 +-=0D
 tools/testing/selftests/net/tcp_ao/self-connect.c  |  19 +-=0D
 tools/testing/selftests/net/tcp_ao/seq-ext.c       |  10 +-=0D
 .../selftests/net/tcp_ao/setsockopt-closed.c       |   2 +-=0D
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c  |  28 +-=0D
 26 files changed, 1576 insertions(+), 182 deletions(-)=0D
---=0D
base-commit: d662c5b3ce6dbed9d0991bc83001bbcc4a9bc2f8=0D
change-id: 20240224-tcp-ao-tracepoints-0ea8ba11467a=0D
=0D
Best regards,=0D
-- =0D
Dmitry Safonov <dima@arista.com>=0D
=0D

