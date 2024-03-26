Return-Path: <linux-kernel+bounces-120141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511588D2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369F11C2D81B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402BA13E051;
	Tue, 26 Mar 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyfkMe7P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2453387
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496355; cv=none; b=iPYiTZ45ebDGEMOjfSoS1tJetU0I5B+oWow7Y9J/4pXhLANtqqsrdPlVb9n1EwYKS3jL0In3NLSXEtZQoS7/w++To0ex+IhXMe9/f+f16volvykqS5m59AfEbAokgccFvW1kGDhR45btIN5P8j7KPrWdSfnb4r6g463Cyait2ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496355; c=relaxed/simple;
	bh=KSP5PW6Tat7+mvCBesGMHnxy9MBeZnYKX7fmi5RHl7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CIlB3VcooYJoo9GV8lDNpuadn5c7gfHsUbQt60/h+VCUNHi8O1Ip2YRWuv4id84W3qygXjSrybDzHxGlOrntYjGGnjYkSUb8GmLg0zrxCVXjn0jCrzvUDe8BbM+GaJmpvwO5CMCpjyRpon+SkBeOXJksaHkteFDXRJBTo64OCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyfkMe7P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711496352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LgVOWVaRotiQeKhXoxLI72etF+MpLQFws3pYRrc5Rhw=;
	b=WyfkMe7PXXgWE9LPOM3wldZJNvnKPPMLbHWIKMcmyJNlDdpIacmHwrV4Pe33UoYD7tSzL5
	xKqjWeni5F/nKozgKEmqfFSdcWoE+gwVRnAA0zHWifhZ9iVO6XAvUVqvqRYEuBEXU6LU50
	gkMoZUadFI3l5licyqEqSwa2TM3BX0I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-_S6MW8KnN2SVOZgD_Swqng-1; Tue,
 26 Mar 2024 19:39:09 -0400
X-MC-Unique: _S6MW8KnN2SVOZgD_Swqng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F038C380390C;
	Tue, 26 Mar 2024 23:39:08 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.81])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 549CB1121306;
	Tue, 26 Mar 2024 23:39:05 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: virtualization@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	keirf@google.com,
	yihyu@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH v2 0/2] vhost: Fix stale available ring entries
Date: Wed, 27 Mar 2024 09:38:44 +1000
Message-ID: <20240326233846.1086253-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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

There is missed smp_rmb() in vhost_vq_avail_empty() and vhost_enable_notify().
Without smp_rmb(), vq->avail_idx is increased but the available ring
entries aren't arriving to vhost side yet. So a stale available ring
entry can be fetched in vhost_get_vq_desc().

Fix it by adding smp_rmb() in those two functions. Note that I need
two patches so that they can be easily picked up by the stable kernel.
With the changes, I'm unable to hit the issue again.

Gavin Shan (2):
  vhost: Add smp_rmb() in vhost_vq_avail_empty()
  vhost: Add smp_rmb() in vhost_enable_notify()

 drivers/vhost/vhost.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.44.0


