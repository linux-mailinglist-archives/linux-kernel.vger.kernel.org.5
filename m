Return-Path: <linux-kernel+bounces-152887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477B8AC5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207791F21986
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4524D5BD;
	Mon, 22 Apr 2024 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EbozUQJB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066A4CE05
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771785; cv=none; b=JI2iGAjLAyrqOgBJqRvhnJDDrfWN3hKWyf5YZok0B8AiQgREpxjIw0m2qbVubkh9m8Zy9tUCTCHut2sWXo0fn8ML0cbzkV9RncGWhRo6BlnF1G8TwoLpmEDfqRuk47wBmI67m/WOjrbhaSw2Ay22H6babaRc9SWN1hWK/BDlXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771785; c=relaxed/simple;
	bh=BL2/0H6F8WBTWUlSs53lzMzQSUcfTxv4A65JDP4NViU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9wi8feU6jlPOAOAuzUiWOOQ/9tFKYGHQzKXQL9uWDWq/oh488TvF2cG4SP5hKw5uEGUV8u8jAPDmjO5hbRYoYGPY1GOHSTdJ07uFHxMgPG1gxntInUGnSCfYZRJH9JhO//qIyMMFyI299QSbKB5JbpKNqIwcl9emafMRwQuKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EbozUQJB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so39388095ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771782; x=1714376582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eYgATfqd8PwpzBjyvQ3X5QGhq7/z0CGn9EB+eG5v+V4=;
        b=EbozUQJBYUh4fUpK+2p1CnDkeSrpdZ+M3vquyElZMeDhP3xJoS/evdwZu3YJeUluF0
         9q7TKSA3U1L8WgexXa7thOovWUVUHOz4LhrRPhMiAyMCWBQ+eUjJdNOuUTVeEMPGzHKf
         zyxrJecgVsvOlnQEtaZhQsxzK0v1IPL1ndYZmfhQtnUps0UJB0nTBCD3/XyVSddLgWhj
         V2S12kkVmksbRo0Fl41C5/2mbSTvHSr9oZQUby2YhSqIU2B1j7wULs7W5F8WzQe/F94+
         MYFkPDM8QeF0D5V+ILZimjdARoCNUz6mALI+Ug/0EcVS5PH0NUrsT8a4/4juRqCzVGzv
         yLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771782; x=1714376582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eYgATfqd8PwpzBjyvQ3X5QGhq7/z0CGn9EB+eG5v+V4=;
        b=J8Iq8zigNJwMHmGiw/V1vjlZtNhjI8iPlNFhfWDsiIuhmm+1C+96xPrbEzTarQfwMi
         d8+i/6Yp/A1j0esqxGoNZLFLGjSxx00QWxoyXAQzJuNVewlxkFB+bIrlvAMohMMZGtHP
         vm9L+M3Sf2DUd0w7dCYRp4jiKjJlMQkhfRr2i39JZamR1FYZ1M8qF/EGEDP2wCJgZWLf
         whSsKC9Q0gjEF4LKDv+upnbY2nKWJqGxLKb0Z2wHkIjzOm0D6d2C0KX3zEN1oQXMhzDp
         FLNe9hWoKZ1cPCfy2j5q1LB7+810+TaL2cDN0yxBgzoojDpjIap8jO+wrfmTiIkzKHrU
         Wl3Q==
X-Gm-Message-State: AOJu0YzNzHudq5NLEJcXBZjL8EIp/8Mz6mLNeY1QoOGmSm18ifVAcStd
	M/01ty5acxM5bk5obgDT2q3JszR4YTNYy9MynC5XFE3h5A7eSgPSVp+ibnEwWCgEdqDZLquxcxK
	6
X-Google-Smtp-Source: AGHT+IFol5Y5ktMWyOI2cuPBIxmgu7AtxVOQpJvNM6eO27t1EtFMPHBED8lk/OFCqWjv6MNhStM2qg==
X-Received: by 2002:a17:902:ec8a:b0:1e9:a0ce:f60e with SMTP id x10-20020a170902ec8a00b001e9a0cef60emr3671572plg.19.1713771781857;
        Mon, 22 Apr 2024 00:43:01 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:01 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 0/4] Improve memory statistics for virtio balloon
Date: Mon, 22 Apr 2024 15:42:50 +0800
Message-Id: <20240422074254.1440457-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

v1 -> v2:
- Add a new patch 'virtio_balloon: separate vm events into a function'
  to avoid any compiler warnings(unused stack variable on
  CONFIG_VM_EVENT_COUNTERS=n)
- Suggested by David, use a loop 'for (zid = 0; zid < MAX_NR_ZONES; zid++)'
  to obtain all the stall events.

RFC -> v1:
- several text changes: oom-kill -> oom-kills, SCAN_ASYNC -> ASYN_SCAN.
- move vm events codes into '#ifdef CONFIG_VM_EVENT_COUNTERS'

RFC version:
Link: https://lore.kernel.org/lkml/20240415084113.1203428-1-pizhenwei@bytedance.com/T/#m1898963b3c27a989b1123db475135c3ca687ca84

zhenwei pi (4):
  virtio_balloon: separate vm events into a function
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 62 ++++++++++++++++++++++-------
 include/uapi/linux/virtio_balloon.h | 16 +++++++-
 2 files changed, 61 insertions(+), 17 deletions(-)

-- 
2.34.1


