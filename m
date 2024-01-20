Return-Path: <linux-kernel+bounces-31648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4A78331E7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB114B216C7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DC9804;
	Sat, 20 Jan 2024 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PyAacvR1"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A77392
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705711430; cv=none; b=YYES1SPuHl1+rRPg6C3qd/kZ93pgh/twygH3iSMRQKf/UiG0PDqUlLb7VjRUlOzziHni7qZbXhgsOVG1ITfbpZH0/ekx2QvErPUFprPIy7pAcKngalA7Y8GrVM6hvIVaHE/0JGe1GlwCXW7otjA4VhjtNjnXn2NDCT77dyHOyeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705711430; c=relaxed/simple;
	bh=5HG+b53C84Ypx7OXyBN4VTdPWHJvm6dijnFWhd1WFrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uVC6W9CXaAMyksfbWIlJ7/r/8gD8FaUumUybQ/2gxpeG5bhZr85Gnx2iOhclPb2cvxRW6qKZyF92g315yFaH2u2EZHEqdAAGuWvsKFVGHxucpgrmrECpCsDVngd2d1vrTotinJC1HpX+o53QtT9Zr1sTsbgMN+aEmIu058k9FaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PyAacvR1; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bbec1d1c9dso58195439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 16:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1705711428; x=1706316228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xv/LIsX6DuyDvwhk5hVzMgJVITeYTPHNZOG4F7N98kE=;
        b=PyAacvR10VPLnWGHhxp2x4+/1ssQGWgrkLUnRV6ENvii5KhjvVIuN9jCHjLWc01lc9
         D7AL1vpVIDH/r7TEFCgP72YV9L3LrazZmtxFfAfePwmoDg0/Omk+9DJDMlV1+25e1XYC
         7Iz4TaDJLrM2AOiC1bg6sd+SEMt3wPFKJhm8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705711428; x=1706316228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv/LIsX6DuyDvwhk5hVzMgJVITeYTPHNZOG4F7N98kE=;
        b=hfAeLE3TeMtcuN9nvYEXTv7CDnmi5hdZdde+8YDrIRdq4ICRMiSc2jwniNtCpq98Cr
         ECKEMIwLv8maCNIHy64je/Gi9MPoR1+VKbC5ISuZ4p5zAB1ecBIVSAhpA3XBMwELrBpB
         Uxbl/wCzMz1yxgFYx1vcm+a13epyBCDhTBSADJgcphM8oFJGMJ59RC5ysp6H2h4lFyAp
         XpThyeTLkws/iL/3TngcL5hyk7LadNk/w6qjjRCHACMXSblWi4jm0AC44Ne0HBSWg/DI
         3cdHjkZlqTAifOfy1m299j+9kZ0dxau/CmvTavWgf9ClFvmeMDotw1yV5Uh+ztkKpsSn
         q0Fg==
X-Gm-Message-State: AOJu0YwApDOGh40tNTATatw5v+DWDN6+4azfSmdZBnqzt6Wv3FJpp92K
	2dKb7gVqd76tEQzrpgeSmW5GEQhMqAUPrFEqgvceaewMH1VH1UQjD9aHdEUoanE=
X-Google-Smtp-Source: AGHT+IEp6bm3kMMWG7JMnNa3IQl4FOHtl850x8XfQbXEPegYhoQX6NR2wf1qyz5d5x1ffoQr00MQcQ==
X-Received: by 2002:a92:d1c7:0:b0:35f:e8a1:2b24 with SMTP id u7-20020a92d1c7000000b0035fe8a12b24mr757662ilg.61.1705711428053;
        Fri, 19 Jan 2024 16:43:48 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id p7-20020a170903248700b001cf6783fd41sm3563800plw.17.2024.01.19.16.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 16:43:47 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC 0/1] RFC: Allow busy poll to be set per epoll instance
Date: Sat, 20 Jan 2024 00:42:46 +0000
Message-Id: <20240120004247.42036-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

TL;DR This RFC builds on bf3b9f6372c4 ("epoll: Add busy poll support to
epoll with socket fds.") by adding two fcntl knobs for enabling
epoll-based busy poll on a per epoll basis instead of the current
system-wide sysctl. This change makes epoll-based busy poll much more
usable.

I have another implementation which uses epoll_ctl and adds a new
EPOLL_CTL_BUSY_POLL_TIMEOUT knob instead of using fcntl, but fcntl
seemed to be slightly cleaner.

I am happy to use whatever interface is desired by the kernel community
in order to allow for per-epoll instance busy poll to be supported.

Longer explanation:

Presently epoll has support for a very useful form of busy poll based on
the incoming NAPI ID (see also: SO_INCOMING_NAPI_ID [1]).

This form of busy poll allows epoll_wait to drive NAPI packet processing
which can allow for user applications to decide when it is appropriate
to process network data vs being pre-empted during less optimal times.

For example, a network application might process an entire datagram and
get better use of L2/L3 cache by deferring packet processing until all
events are processed and epoll_wait is called.

The documentation available on this is, IMHO, a bit confusing so please
allow me to explain how to use this kernel feature.

In order to use this feature, user applications must do three things:

1. Ensure each application thread has its own epoll instance mapping
1-to-1 with NIC RX queues. An n-tuple filter would likely be used to
direct connections with specific dest ports to these queues.

2. Ensure that all incoming connections added to an epoll instance
have the same NAPI ID. This can be done with a BPF filter when
SO_REUSEPORT is used or getsockopt + SO_INCOMING_NAPI_ID when a single
accept thread is used which dispatches incoming connections to threads.

3. Lastly, busy poll must be enabled via a sysctl
(/proc/sys/net/core/busy_poll).

The unfortunate part about step 3 above is that this enables busy poll
system-wide which affects all user applications on the system.

It is worth noting that setting /proc/sys/net/core/busy_poll has
different effects on different system calls:

- poll and select based applications would not be affected as busy
  polling is only enabled when this sysctl is set *and* sockets have
  SO_BUSY_POLL set.
- All epoll based applications on the system, however, will busy poll
  when this sysctl is set.

If the user wants to run one low latency epoll-based server application with
epoll-based busy poll, but would like to run the rest of the applications on
the system (which may also use epoll) without busy poll, this
system-wide sysctl presents a significant problem.

This change preserves the system-wide sysctl, but adds a mechanism (via
fcntl) to enable or disable busy poll for epoll instances as needed.

This change is extremely useful for low latency network applications
that need to run side-by-side with other network applications where
latency is not a major concern.

As mentioned above, the epoll_ctl approach I have (which works) seemed
less clean than the fcntl approach in this RFC. I would be happy to use
whatever interface the kernel maintainers prefer to make epoll based busy
poll more convenient for user applications to use.

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20170324170836.15226.87178.stgit@localhost.localdomain/

Joe Damato (1):
  eventpoll: support busy poll per epoll instance

 fs/eventpoll.c                   | 71 ++++++++++++++++++++++++++++++--
 fs/fcntl.c                       |  5 +++
 include/linux/eventpoll.h        |  2 +
 include/uapi/linux/fcntl.h       |  6 +++
 tools/include/uapi/linux/fcntl.h |  6 +++
 tools/perf/trace/beauty/fcntl.c  |  3 +-
 6 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.25.1


