Return-Path: <linux-kernel+bounces-72917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C205285BAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9A1F224CD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE6967A09;
	Tue, 20 Feb 2024 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="myYCSnem"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9840766B4F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429011; cv=none; b=iMtGVbltpwwLZQz29p/B9yeRF0Heik7AU1Fsz2lmGF2ZTDqOZz0911/pY3eEFkQI6mzxE9Q5qQSjEhciFcZe3mZcym7baDCv0zLIfN0MoGo2qHtCh4RgiApvDRjfJdNGNypUONkViVAmd2WtoIai/qQ0NRIEkiO3gOTHQ+f99QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429011; c=relaxed/simple;
	bh=MJZTwvMAhXU1TEesSE5qck+Xlaoz9q2+OP1AZ3mvBy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQLo1efzBPoYgwxus4jQJ9Akzx5XF78xPBALdG2Sm5IxiRASGSBwygRmpd3uOTqBKn2j4NjF0F0pTJCOWntlikKYTiReZytivRvZn3Rvo3cRiR3ICNbE9H6bjm5dZKlpeBeEY+c+z4tIeYg9+nfI31UInkTT0juCgcXYSAQ09rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=myYCSnem; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708429001; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Cz1c5ISGmBdsxneLIlZx/BdFlZMirzknWzhxQibv2VY=;
	b=myYCSnem7v/BWmz0M7MvyuyhBIg4zODOaDg1YCDFptmor0rA7rPntF3nyD0WEKBXpCheZTtn9Gw9A+o/C4NkIpZKybcCkeYzAbJm5iegT0jzjpraD6P8ucGHbPpWQzi6zJr8klx57DPRwxA2FbMRTZlP6Cn96r1UNGHHpmMt4js=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0wabbT_1708428963;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0W0wabbT_1708428963)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 19:36:40 +0800
From: Rongwei Wang <rongwei.wang@linux.alibaba.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	pierre.gondois@arm.com,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	teng.ma@linux.alibaba.com
Subject: [PATCH v1 0/2] support NUMA emulation for genertic arch
Date: Tue, 20 Feb 2024 19:36:00 +0800
Message-Id: <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A brief introduction
====================

The NUMA emulation can fake more node base on a single
node system, e.g.

one node system:

[root@localhost ~]# numactl -H
available: 1 nodes (0)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 31788 MB
node 0 free: 31446 MB
node distances:
node   0
  0:  10

add numa=fake=2 (fake 2 node on each origin node):

[root@localhost ~]# numactl -H
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7
node 0 size: 15806 MB
node 0 free: 15451 MB
node 1 cpus: 0 1 2 3 4 5 6 7
node 1 size: 16029 MB
node 1 free: 15989 MB
node distances:
node   0   1
  0:  10  10
  1:  10  10

As above shown, a new node has been faked. As cpus, the realization
of x86 NUMA emulation is kept. Maybe each node should has 4 cores is
better (not sure, next to do if so).

Why do this
===========

It seems has following reasons:
  (1) In x86 host, apply NUMA emulation can fake more nodes environment
      to test or verify some performance stuff, but arm64 only has
      one method that modify ACPI table to do this. It's troublesome
      more or less.
  (2) Reduce competition for some locks. Here an example we found:
      will-it-scale/tlb_flush1_processes -t 96 -s 10, it shows obvious
      hotspot on lruvec->lock when test in single environment. What's
      more, The performance improved greatly if test in two more nodes
      system. The data shows below (more is better):

      ---------------------------------------------------------------------
      threads/process |   1     |     12   |     24   |   48     |   96
      ---------------------------------------------------------------------
      one node        | 14 1122 | 110 5372 | 111 2615 | 79 7084  | 72 4516
      ---------------------------------------------------------------------
      numa=fake=2     | 14 1168 | 144 4848 | 215 9070 | 157 0412 | 142 3968
      ---------------------------------------------------------------------
                      | For concurrency 12, no lruvec->lock hotspot. For 24,
      hotspot         | one node has 24% hotspot on lruvec->lock, but
                      | two nodes env hasn't.
      ---------------------------------------------------------------------

As for risks (e.g. numa balance...), they need to be discussed here.

Lastly, it seems not a good choice to realize x86 and other genertic
archs separately. But it can indeed avoid some architecture related
APIs adjustments and alleviate future maintenance. The previous RFC
link see [1].

Any advice are welcome, Thanks!

Change log
==========

RFC v1 -> v1
* add new CONFIG_NUMA_FAKE for genertic archs.
* keep x86 implementation, realize numa emulation in driver/base/ for
  genertic arch, e.g, arm64.

[1] RFC v1: https://patchwork.kernel.org/project/linux-arm-kernel/cover/20231012024842.99703-1-rongwei.wang@linux.alibaba.com/

Rongwei Wang (2):
  arch_numa: remove __init for early_cpu_to_node
  numa: introduce numa emulation for genertic arch

 drivers/base/Kconfig          |   9 +
 drivers/base/Makefile         |   1 +
 drivers/base/arch_numa.c      |  32 +-
 drivers/base/numa_emulation.c | 909 ++++++++++++++++++++++++++++++++++
 drivers/base/numa_emulation.h |  41 ++
 include/asm-generic/numa.h    |   2 +-
 6 files changed, 992 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/numa_emulation.c
 create mode 100644 drivers/base/numa_emulation.h

-- 
2.32.0.3.gf3a3e56d6


