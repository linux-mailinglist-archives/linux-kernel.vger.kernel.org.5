Return-Path: <linux-kernel+bounces-122210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E6888F37E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B358D29827A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6678BA4D;
	Thu, 28 Mar 2024 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NB3wctXK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47401BE4F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585333; cv=none; b=koF4bF4tizzwKasQGpxogEYYG8ZHwvX0j1ukboIcXk8H4gQpUaeR5CIIpQreP1HAMDaI7Vo1X7sT6SZNoYZ8voSkGlGYAtMVO6188ordFz9k1zGlSYHrgnIICHdr3hJDaZxwmjVw/LqUgiAVHqPZVNFrbpcmwLVXYD2n/pAX4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585333; c=relaxed/simple;
	bh=ggJad3r1Me38vzL4zFSX3eh0yHbHRPyVOdnLa426/DU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofdTQSg90CfXCQvoMdq0fwECBrpQHI4N5zG4ngKqJ7YnlZHteHI1NiaOkgGVG+/SXq3QywQNxsH5Akl24zJDOJdGXIOYTljG0GI0tvYX74vZZhDwDuWJXhwd5qR4deGRhN80EFBxgDm2tTHCtb669TrUTlC0FyB7RDhoLkwmM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NB3wctXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711585330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mWWwnnOWfq06YB/Ymuc/Edm8EX5yVgqLY4BpR0fiI10=;
	b=NB3wctXKTEo0RKGMXdTXE5bnfiF9fWC/8UV5OEu3X0XaR3ET0PIZIeDQrkzAaoNtAJnbBd
	0VXopmB0U06LTadPwBTDU9TAfwfYi8uYlopgrM61iCLKOVGXIXuiyh9M67yYc9eparue6/
	5NC0SkwOMevfLeQBbEvh6lDPXcJnIiA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-RU8MFNU-OxqdIu-B8y5D4Q-1; Wed, 27 Mar 2024 20:22:06 -0400
X-MC-Unique: RU8MFNU-OxqdIu-B8y5D4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E452A800264;
	Thu, 28 Mar 2024 00:22:05 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 76D772166B31;
	Thu, 28 Mar 2024 00:22:01 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	will@kernel.org,
	davem@davemloft.net,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	keirf@google.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v3 0/3] vhost: Fix stale available ring entries
Date: Thu, 28 Mar 2024 10:21:46 +1000
Message-ID: <20240328002149.1141302-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The issue was reported by Yihuang Yu on NVidia's grace-hopper (ARM64)
platform. The wrong head (available ring entry) is seen by the guest
when running 'netperf' on the guest and running 'netserver' on another
NVidia's grace-grace machine.

  /home/gavin/sandbox/qemu.main/build/qemu-system-aarch64      \
  -accel kvm -machine virt,gic-version=host -cpu host          \
  -smp maxcpus=1,cpus=1,sockets=1,clusters=1,cores=1,threads=1 \
  -m 4096M,slots=16,maxmem=64G                                 \
  -object memory-backend-ram,id=mem0,size=4096M                \
   :                                                           \
  -netdev tap,id=tap0,vhost=true                               \
  -device virtio-net-pci,bus=pcie.8,netdev=tap0,mac=52:54:00:f1:26:b0
   :
  guest# ifconfig eth0 | grep 'inet addr'
  inet addr:10.26.1.220
  guest# netperf -H 10.26.1.81 -l 60 -C -c -t UDP_STREAM
  virtio_net virtio0: output.0:id 100 is not a head!

There is missed smp_rmb() in vhost_{vq_avail_empty, enable_notify}()
Without smp_rmb(), vq->avail_idx is advanced but the available ring
entries aren't arriving to vhost side yet. So a stale available ring
entry can be fetched in vhost_get_vq_desc().

Fix it by adding smp_rmb() in those two functions. Note that I need
two patches so that they can be easily picked up by the stable kernel.
With the changes, I'm unable to hit the issue again. Besides, the
function vhost_get_avail_idx() is improved to tackle the memory barrier
so that the callers needn't to worry about it.

v2: https://lore.kernel.org/virtualization/46c6a9aa-821c-4013-afe7-61ec05fc9dd4@redhat.com
v1: https://lore.kernel.org/virtualization/66e12633-b2d6-4b9a-9103-bb79770fcafa@redhat.com

Changelog
=========
v3:
  Improved change log                                         (Jason)
  Improved comments and added PATCH[v3 3/3] to execute
  smp_rmb() in vhost_get_avail_idx()                          (Michael)


Gavin Shan (3):
  vhost: Add smp_rmb() in vhost_vq_avail_empty()
  vhost: Add smp_rmb() in vhost_enable_notify()
  vhost: Improve vhost_get_avail_idx() with smp_rmb()

 drivers/vhost/vhost.c | 51 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

-- 
2.44.0


