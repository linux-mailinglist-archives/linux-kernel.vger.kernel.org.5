Return-Path: <linux-kernel+bounces-166933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71A68BA23A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A2EA1F216B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAD91836F0;
	Thu,  2 May 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hR+Cs+f1"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B5A181B9A
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 21:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685196; cv=none; b=AILdAE0K3YifgqKa5vc/Vu13Iumejopm0oXP0Ajv30olS7YVTLXpiJkw6DDPSJCUME29s0BB9WN64PQC8Ia+csxMhb4EKMYdi8lyVk0GoB/eSl1laEFmhgo9H2phss92KnAcPqgrwPdGmLL9vPnLvWAFOQd2xwMeOj3pdA/BvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685196; c=relaxed/simple;
	bh=kD5voEcYDKeRwwIfHjfK9GYE6UqmYhrOC5if/+3GjEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mdYBn6AwsxdPMeilxtlBu0O25MU87knB5oBPpf7BGSqnpmxj15NVELVpZb3RDOittwmcInQbqp+o1pRELrNicQ8u9LC5JnIgBJjWMU4cKH5JY+cAgUVpAtoESDSIqMB5Wt8q+nvoorzf52MYaYwB7cUp6Z571dTa0FkrmycQwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hR+Cs+f1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f0aeee172dso1740071b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 14:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714685194; x=1715289994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dBH2WIOsVEMLuO8Ph2GPnS+rofvmn8ajCB1benluZQ8=;
        b=hR+Cs+f1//HxGo2Vomr737KGNwBPZBAlD2EOHBZ2QNcnW1bL/K06sBIyKuZWvDXET7
         i3v2aQQpvfshG1oIp3+FyvjuF6t0rzWW1bQdm4Ja4GLdZyEcEYEGOjvYafgkqZKvPSIB
         lMMWhE3UI8x5UKxq1pAVbDpUzIOCzW0pIbADE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714685194; x=1715289994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBH2WIOsVEMLuO8Ph2GPnS+rofvmn8ajCB1benluZQ8=;
        b=lpXXqIyZnaZarWzRbTGR5J8LeKth3Vv5rQj8f3l9k4Zxh8D5J+2j1mnBjr7gMLfspe
         LyAz+YmpuxAPrqqg3UtCwHzj3Ng30F0Mk0JdSMwZZOJ/s+yAyth5MjekXkLbGr5HI0X9
         fMq6HbGjhU2gHl0REKAQvJiDnUNEO5KRolBTYuxbHOmN10LKN8bKNnwAt1YgRjpQQ1yU
         9PlBOpqIE7vw8CJJuV28JvKHdH1JoOfEmvIsYETEiV5mIm3in3k3pv3Z+rgKkmRnnWob
         9cVWAw9UIa06BeBksGPOYn1YGPv+tYm0WCGSbNtqAW5VU/xly9OkHhSJun4h7HO9h4UL
         6agg==
X-Gm-Message-State: AOJu0YyfX6S+SDzGAsWDpOqrGoGeYo9wkS5f9XYKeurKiCGO/XeUV/l3
	ZpW/Tb2Ifq2tHcKbwQmJEDji8t/NeBoAq2D0vy+BNJK1emfothXnWecVuYoCxgai6O4zE+Jsoke
	KnkHvmlakHs4ZDB9vhLJDbyqej6SE18rDd4skkP+u0sokog9Xfm7S5nopJ71KwmZwZ70RQBbJEA
	W076v9YarwweA1qPkHvDUYFNG3gE3cz1aQCJr2ChJsgf4=
X-Google-Smtp-Source: AGHT+IHg1FzHqLJMYICia+FqpK9OERKO+x4bmt7KbcQjQqkhJUSlY1pTT9+EKqOtK8PT4GIa+8neSw==
X-Received: by 2002:a05:6a00:2d92:b0:6ec:f869:34c with SMTP id fb18-20020a056a002d9200b006ecf869034cmr5741219pfb.16.1714685194306;
        Thu, 02 May 2024 14:26:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id it21-20020a056a00459500b006f4401df6c9sm1371345pfb.113.2024.05.02.14.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 14:26:33 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca,
	gal@nvidia.com,
	nalramli@fastly.com,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 0/3] mlx4: Add support for netdev-genl API
Date: Thu,  2 May 2024 21:26:24 +0000
Message-Id: <20240502212628.381069-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v3.

This series adds support to mlx4 for the netdev-genl API which makes it
much easier for users and user programs to map NAPI IDs back to
ifindexes, queues, and IRQs. This is extremely useful for a number of
use cases, including epoll-based busy poll.

In addition, this series includes a patch to generate per-queue
statistics using the netlink API, as well.

To facilitate the stats, patch 1/3 makes use of an existing field,
"dropped" which was already being exported in the ethtool stats by the
driver, but was never incremented. As of patch 1/3, it is now being
incremented by the driver in an appropriate place and used in patch 3/3
as alloc_fail.

Please note: I do not have access to mlx4 hardware, but I've been
working closely with Martin Karsten from University of Waterloo (CC'd)
who has very graciously tested my patches on their mlx4 hardware (hence
his Tested-by attribution in each commit). His latest research work is
particularly interesting [1] and this series helps to support that (and
future) work.

Martin re-tested v2 using Jakub's tool [2] and the stats.pkt_byte_sum
and stats.qstat_by_ifindex tests passed. The v3 is only a very minor
change from v2 and was not re-tested.

[1]: https://dl.acm.org/doi/pdf/10.1145/3626780
[2]: https://lore.kernel.org/lkml/20240423175718.4ad4dc5a@kernel.org/

Thanks,
Joe

v2 -> v3:
 - Patch 1/3 no longer sets rx_missed_errors. dropped is still
   incremented on -ENOMEM, though, and reported as alloc_fail in the
   stats API introduced in patch 3/3.
 - Patch 2/3: Added Jakub's Acked-by to the commit message, no
   functional changes.
 - Patch 3/3: Added Jakub's Reviewed-by to the commit message, no
   functional changes.

v1 -> v2:
 - Patch 1/3 now initializes dropped to 0.
 - Patch 2/3 fix use of uninitialized qtype warning.
 - Patch 3/3 includes several changes:
   - mlx4_get_queue_stats_rx and mlx4_get_queue_stats_tx check if i is
     valid before proceeding.
   - All initialization to 0xff for stats fields has been omit. The
     network stack does this before calling into the driver functions, so
     I've adjusted the driver functions to only set values if there is
     data to set, leaving the network stack's 0xff in place if not.
   - mlx4_get_base_stats set all stat fields to 0 individually if there
     are RX and TX queues.


Joe Damato (3):
  net/mlx4: Track RX allocation failures in a stat
  net/mlx4: link NAPI instances to queues and IRQs
  net/mlx4: support per-queue statistics via netlink

 drivers/net/ethernet/mellanox/mlx4/en_cq.c    | 14 ++++
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 79 +++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx4/en_rx.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 4 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.25.1


