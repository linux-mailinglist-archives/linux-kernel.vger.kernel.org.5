Return-Path: <linux-kernel+bounces-36363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B38839FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810CB282E62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCB7154B1;
	Wed, 24 Jan 2024 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xaca4ln+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00C134CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064866; cv=none; b=AWQR9mINNJPgi7mPakhPNayzJYzkuPfplwTfWyeQKPfsJkWhIoWh3aTwsyQSLZLFQulOVOCL3pwBspjJviNSsxG+StZtQKPH+TmKH7TR0mRt815LqRl9fvD2j7qskPv7utY0ADVnU1md5bwZJQJsP3Rs9C59tpfuic2cMzswM3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064866; c=relaxed/simple;
	bh=ZQ4vtsOIO+sx6pl2NLSWqLhdVeTyINduR6Wn0CldNr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lX92ITQIxxppnVwtOf5PCLh9pvRx5WKsE/jt9waPmfJVXO9vy81Mzgr77q4dz4wGNn5SGKV5WEghQug8ol6BK7sg7MJBi3u4nB4dxJ3qjpl5dMbENdwPv/vr+10c0gYvcpjt87mMSChFGVEqR+q6a99mpPX3rUNsROgVqxPedYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xaca4ln+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso3570726a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706064864; x=1706669664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWukwyy9wiRh1x6kV1LvOUsMPKDtwpdkTrjGMS5A3Oo=;
        b=xaca4ln+SQNNI1Hjt6NpfbWoEIQmJrOtUeqOdMIO3FNDSBOl1hUr5gA6AHyjnM4Qfh
         YgR0gwBQVXxOrRMXK6fO9ufJfj264r2HLeCZucwQnH9no1Fo4t1DSdgi35ja6RjGx6XH
         3G0mfdwzgLH++gzK0ubZEVieb/wSYH1NFB8/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064864; x=1706669664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWukwyy9wiRh1x6kV1LvOUsMPKDtwpdkTrjGMS5A3Oo=;
        b=AaFiMEIqbdC8+ePDHhwkkdOY9hjXsY41Ze7I3jJ96Ygi3Gz9N6G/05mPZ5SWeZrHwu
         EtMP0JQLDKrizlYhl/Z3WwMmbbxOBo97YqrI2Ud/wUWqhETGwXYMUmEmbT85+FnmMLFT
         Xvrz8fkPG7uufCnL8+bcyFC1mi8Rqcc+9Xf1H+ohCpknbJGy8XZThEY1gIFL8Opbg3E9
         4v7GzkyOTaCF5tV484NGFRluxypKf/aKz0KCOk4q+VZeOWPQ4FnIjnEWoQSYTeReLyDP
         A6w71riUIaeVoFefd+MXOuWmEy+bR4PKV2g5DGH895R5peI4BPxwz/67Stc0cY9op56n
         3M4w==
X-Gm-Message-State: AOJu0YwRxHUSpniG7vbyjCTcghjl9YLoriwv+UN9YhUn9Z0jLkFbhVmi
	K0Tk3L/6hNZagiE1vw10eAzpU92bx20dIBoGAlKxNPhuJJj60MZ4gv7IHnM5upg=
X-Google-Smtp-Source: AGHT+IHMoaRwDr49eBfpainoclB+KoIk9MjYaRHB8b3w7efiNB/8gEpuMNNGT1DWzOdBHaOkiXdl+Q==
X-Received: by 2002:a05:6a20:748c:b0:19a:542e:e56e with SMTP id p12-20020a056a20748c00b0019a542ee56emr243005pzd.23.1706064864661;
        Tue, 23 Jan 2024 18:54:24 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z14-20020a62d10e000000b006d9b38f2e75sm12974229pfg.32.2024.01.23.18.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 18:54:24 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next 0/3] Per epoll context busy poll support
Date: Wed, 24 Jan 2024 02:53:56 +0000
Message-Id: <20240124025359.11419-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by allowing user applications to enable
epoll-based busy polling and set a busy poll packet budget on a per epoll
context basis.

To allow for this, two ioctls have been added for epoll contexts for
getting and setting a new struct, struct epoll_params.

This makes epoll-based busy polling much more usable for user
applications than the current system-wide sysctl and hardcoded budget.

Longer explanation:

Presently epoll has support for a very useful form of busy poll based on
the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).

This form of busy poll allows epoll_wait to drive NAPI packet processing
which allows for a few interesting user application designs which can
reduce latency and also potentially improve L2/L3 cache hit rates by
deferring NAPI until userland has finished its work.

The documentation available on this is, IMHO, a bit confusing so please
allow me to explain how one might use this:

1. Ensure each application thread has its own epoll instance mapping
1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
direct connections with specific dest ports to these queues.

2. Optionally: Setup IRQ coalescing for the NIC RX queues where busy
polling will occur. This can help avoid the userland app from being
pre-empted by a hard IRQ while userland is running. Note this means that
userland must take care to call epoll_wait and not take too long in
userland since it now drives NAPI via epoll_wait.

3. Ensure that all incoming connections added to an epoll instance
have the same NAPI ID. This can be done with a BPF filter when
SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
accept thread is used which dispatches incoming connections to threads.

4. Lastly, busy poll must be enabled via a sysctl
(/proc/sys/net/core/busy_poll).

The unfortunate part about step 4 above is that this enables busy poll
system-wide which affects all user applications on the system,
including epoll-based network applications which were not intended to
be used this way or applications where increased CPU usage for lower
latency network processing is unnecessary or not desirable.

If the user wants to run one low latency epoll-based server application
with epoll-based busy poll, but would like to run the rest of the
applications on the system (which may also use epoll) without busy poll,
this system-wide sysctl presents a significant problem.

This change preserves the system-wide sysctl, but adds a mechanism (via
ioctl) to enable or disable busy poll for epoll contexts as needed by
individual applications, making epoll-based busy poll more usable.

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/

Joe Damato (3):
  eventpoll: support busy poll per epoll instance
  eventpoll: Add per-epoll busy poll packet budget
  eventpoll: Add epoll ioctl for epoll_params

 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 fs/eventpoll.c                                | 99 ++++++++++++++++++-
 include/uapi/linux/eventpoll.h                | 12 +++
 3 files changed, 107 insertions(+), 5 deletions(-)

-- 
2.25.1


