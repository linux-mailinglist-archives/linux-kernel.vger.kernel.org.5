Return-Path: <linux-kernel+bounces-144772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE868A4A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCB92813C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62A383BE;
	Mon, 15 Apr 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dsr87QKP"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47EA381C7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170490; cv=none; b=P7uTX+e1tJkxO3dXbmhal9UBNg+LMu1B6nnteaNHn//DyxWxCQMB38xTx9C3hjumKYKl5nDRTnhqQ8uUB/8dDvtymhJ7OXjKZ8/3a4tElFGEPamrtTojHmQUHP8OIHSGCNABS8VDQe/QRsnP6UiWh5Pv+FZbrpmGrSwiJycQkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170490; c=relaxed/simple;
	bh=v7SDKoILYnL+Q07ZcGpDsCXHHRJob/yG3/+kL9fGKLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OvXP50FcUhOfbpGWAFQHp6O73wIA4B6ScYSGBReeAJ0C4vMkwfbiWtL8KbAHjVDBNIirXyxYhSJYI0XmA8Jlm+dnLc4U3v7PNjx+viGbCwmZQ2eLpeh9G1tBbRxGhpdKLTgCGF6GPV6t4SauWmr0DDIKcMWW62PtANwef9K8JEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dsr87QKP; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a1140bd21so11770465ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170487; x=1713775287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wfjIlgO/QZNkC/nNAH/lmmSlY11ytftqlWP0lFvruo=;
        b=Dsr87QKPAnUNkAYELFVgXmennPa8VgpOGbELOggB63TLAy0Ox2r3jKwpmJz8HW+Sqv
         hdr/HFbewKxlOh9Oog9to5h6nnraLhX7UBHndSh+cVFytoBqT+Sbjevgioom+rW8Cgoy
         +B24hyWZD2/r0VR3/7nXbeRPLFFrjAsWkIcRgioIKvf579VMnw1r7I3QeHfrMl7dNyrU
         ZAo31phg3aqssjphKAnp/UsUT4+oise0gnHWLJnHjFs30wNbJ/iqYpkqWr/R+qeA+qs4
         HDYRirZY6N594jsudg9xhf5Z57+t+HeIHjiTa1RtiIxlD7qNHontz6Da3vYwf2/MXnAd
         2gMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170487; x=1713775287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wfjIlgO/QZNkC/nNAH/lmmSlY11ytftqlWP0lFvruo=;
        b=YeFYSX6f2q182oHkyUs/VSU8aFR7A1aoaA1TUx1zDb3aczqJCOnUiL1uGJjf4hukct
         FM1MjlrszYZ5Vy/wS4Ooo2U/wW5WBOCeEV2U7Ur3ztPt1YP4yvx50uQhJec+J4KAO2fy
         TkI9beLG6aGAZ+8ew8hXN0yII5RlSyCVhPKZVhswKyDo5GDGHDSUtXEu90CuzWj1eSO3
         k9nQD5sRZVddShX/BCGNJM/j/lqumacae0C8Gqu9wnCwgXQT2eRTMZz80K4cl4dSLpsp
         zJ0yTd4ZNfM4CRDiphTzsQhx/VC6FXNJqaVg1DJcHUBsP0HEdQM87/7Op/SJHbHUJA7X
         pRcQ==
X-Gm-Message-State: AOJu0YxSn+sT4I7MtEYHBxq+UUxeDn3dpGjwGwhBJhC2jqeJogZC138O
	udK/Q1qnhVQb4RL/wi+XV1t6Xxp6KQGyW3q4eOzP4apW8jYAJJcN5aCWCXMR1ZxS8PUmQfdkJFN
	d
X-Google-Smtp-Source: AGHT+IFVVhy+/eBfwZCCc946KkwERHHh+W5/607TDMXjGxAgcPrElcXF4+Vtf1WNq3+wczBthWoaiQ==
X-Received: by 2002:a05:6e02:1e07:b0:36b:85e:7d69 with SMTP id g7-20020a056e021e0700b0036b085e7d69mr13433947ila.10.1713170487436;
        Mon, 15 Apr 2024 01:41:27 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:27 -0700 (PDT)
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
Subject: [RFC 0/3] Improve memory statistics for virtio balloon
Date: Mon, 15 Apr 2024 16:41:10 +0800
Message-Id: <20240415084113.1203428-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

When the guest runs under critial memory pressure, the guest becomss
too slow, even sshd turns D state(uninterruptible) on memory
allocation. We can't login this VM to do any work on trouble shooting.

Guest kernel log via virtual TTY(on host side) only provides a few
necessary log after OOM. More detail memory statistics are required,
then we can know explicit memory events and estimate the pressure.

I'm going to introduce several VM counters for virtio balloon:
- oom-kill
- alloc-stall
- scan-async
- scan-direct
- reclaim-async
- reclaim-direct

Then we have a metric to analyze the memory performance:
[also describe this metric in patch
 'virtio_balloon: introduce memory scan/reclaim info']

y: counter increases
n: counter does not changes
h: the rate of counter change is high
l: the rate of counter change is low

OOM: VIRTIO_BALLOON_S_OOM_KILL
STALL: VIRTIO_BALLOON_S_ALLOC_STALL
ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT

- OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
  the guest runs under really critial memory pressure

- OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to cgroup, not the global memory
  pressure.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
  the memory allocation stalls due to global memory pressure. The
  performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
  quite effective memory reclaiming.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to global memory pressure.
  the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
  heavily, the serious case leads poor performance and difficult
  trouble shooting. Ex, sshd may block on memory allocation when
  accepting new connections, a user can't login a VM by ssh command.

- OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
  the low ratio between ARCLM/ASCAN shows that the guest tries to
  reclaim more memory, but it can't. Once more memory is required in
  future, it will struggle to reclaim memory.

zhenwei pi (3):
  virtio_balloon: introduce oom-kill invocations
  virtio_balloon: introduce memory allocation stall counter
  virtio_balloon: introduce memory scan/reclaim info

 drivers/virtio/virtio_balloon.c     | 30 ++++++++++++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h | 16 +++++++++++++--
 2 files changed, 43 insertions(+), 3 deletions(-)

-- 
2.34.1


