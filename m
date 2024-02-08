Return-Path: <linux-kernel+bounces-57614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2611484DB66
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF33128B28F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46EB6A8DC;
	Thu,  8 Feb 2024 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dxJaOvPk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E069305
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380711; cv=none; b=P6+ZdRUPqC0MSFTRZ7ajjFupiljpdRBqkxNXKD2hXjc4rOdqaky2HMVSaaoqIMZjp0P6Cuz0tT8En9skTR0H8kuwoagZvBzsvt5sA5Ygzwg0Kcp+YKBqeS6iw3Wqkz0bWMOPNDHIu4KNuvr7XdCUW9//vNgvt+omUI1Ah6KfXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380711; c=relaxed/simple;
	bh=O2IKBBmeitmD4XG1lBAjgSZnpt0IxoMEUP0YLEVDT4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FAn25SJXSolAve9CNNHc17yU3KV2vwhVieQF/W1qJFEHU4YltEg4lEQJszdf+D16NlslgtJjzDkxjU0DqmWlTSn394B2AnWJJ/LuTCv4jn5tM04o9QrYT5aUyVNuq9XQeTXSTL9Fbhhf0ir4pg1jRTLdQB18+Euq2lN/oBEklxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dxJaOvPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707380708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SAalLMEPsSD/09IiHiwS+PzKyKGItg6LwK/MHBE68Iw=;
	b=dxJaOvPktBwEQtt20GFB8OtKTSo0C+/Yi37OGxU58WJBuLvxTdmfOCQ0LUBqg9E9zY1sIN
	u3vGAgkAjxaAxwD4RfNEBPqCQcQYSmol6GymvoiqBK6KOlMuMVjVrhBQFLDCAtfQTFsVK8
	Po3EZbYYdMpiuA6Wu95eT8Rt6vYXZb8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5--56nbYMXOe67JYmp2I98qA-1; Thu,
 08 Feb 2024 03:25:05 -0500
X-MC-Unique: -56nbYMXOe67JYmp2I98qA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81FAE38143B7;
	Thu,  8 Feb 2024 08:25:04 +0000 (UTC)
Received: from ksundara-mac.redhat.com (unknown [10.74.17.171])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 597301103A;
	Thu,  8 Feb 2024 08:24:58 +0000 (UTC)
From: Karthik Sundaravel <ksundara@redhat.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pmenzel@molgen.mpg.de,
	jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com,
	rjarry@redhat.com,
	aharivel@redhat.com,
	vchundur@redhat.com,
	ksundara@redhat.com,
	cfontain@redhat.com
Subject: [PATCH v2] ice: Add get/set hw address for VFs using devlink commands
Date: Thu,  8 Feb 2024 13:54:54 +0530
Message-Id: <20240208082455.66726-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5



Thanks for the review comments and suggestions.
In the V2 version of the patch, I have called ice_set_vf_mac() directly from the devlink port function handlers.

I did the following testing to verify the changes.

root@10:~# ethtool -i enp8s0f0np0 | grep bus
bus-info: 0000:08:00.0

root@10:~# devlink dev eswitch set pci/0000:08:00.0 mode switchdev
Warning: ice: Changed eswitch mode to switchdev.

root@10:~# echo 4 > /sys/class/net/enp8s0f0np0/device/sriov_numvfs 

root@10:~# devlink port show
pci/0000:08:00.0/0: type eth netdev enp8s0f0np0 flavour physical port 0 splittable true lanes 8
pci/0000:08:00.0/2: type eth netdev enp8s0f0npf0vf0 flavour pcivf controller 0 pfnum 0 vfnum 0 external false splittable false
  function:
    hw_addr 1a:33:f2:e7:64:d8
pci/0000:08:00.0/3: type eth netdev enp8s0f0npf0vf3 flavour pcivf controller 0 pfnum 0 vfnum 3 external false splittable false
  function:
    hw_addr 4e:ef:ca:9e:e7:5d
pci/0000:08:00.0/4: type eth netdev enp8s0f0npf0vf1 flavour pcivf controller 0 pfnum 0 vfnum 1 external false splittable false
  function:
    hw_addr 5a:f0:e3:f8:41:93
pci/0000:08:00.0/5: type eth netdev enp8s0f0npf0vf2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false
  function:
    hw_addr 1a:62:c6:4b:d2:f0
pci/0000:08:00.1/0: type eth netdev enp8s0f1np1 flavour physical port 1 splittable false

root@10:~# devlink port function set  pci/0000:08:00.0/5 hw_addr 00:11:22:33:44:55

root@10:~# devlink port show
pci/0000:08:00.0/0: type eth netdev enp8s0f0np0 flavour physical port 0 splittable true lanes 8
pci/0000:08:00.0/2: type eth netdev enp8s0f0npf0vf0 flavour pcivf controller 0 pfnum 0 vfnum 0 external false splittable false
  function:
    hw_addr 1a:33:f2:e7:64:d8
pci/0000:08:00.0/3: type eth netdev enp8s0f0npf0vf3 flavour pcivf controller 0 pfnum 0 vfnum 3 external false splittable false
  function:
    hw_addr 4e:ef:ca:9e:e7:5d
pci/0000:08:00.0/4: type eth netdev enp8s0f0npf0vf1 flavour pcivf controller 0 pfnum 0 vfnum 1 external false splittable false
  function:
    hw_addr 5a:f0:e3:f8:41:93
pci/0000:08:00.0/5: type eth netdev enp8s0f0npf0vf2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false
  function:
    hw_addr 00:11:22:33:44:55
pci/0000:08:00.1/0: type eth netdev enp8s0f1np1 flavour physical port 1 splittable false

root@10:~# ip link show enp8s0f0np0
12: enp8s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 40:a6:b7:18:dd:68 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 1a:33:f2:e7:64:d8 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 1     link/ether 5a:f0:e3:f8:41:93 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 2     link/ether 00:11:22:33:44:55 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 3     link/ether 4e:ef:ca:9e:e7:5d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    
root@10:~# ip link set dev enp8s0f0np0 vf 2 mac AA:BB:CC:DD:EE:FF

root@10:~# ip link show enp8s0f0np0
12: enp8s0f0np0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 40:a6:b7:18:dd:68 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 1a:33:f2:e7:64:d8 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 1     link/ether 5a:f0:e3:f8:41:93 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 2     link/ether aa:bb:cc:dd:ee:ff brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off
    vf 3     link/ether 4e:ef:ca:9e:e7:5d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state enable, trust off

root@10:~# devlink port show
pci/0000:08:00.0/0: type eth netdev enp8s0f0np0 flavour physical port 0 splittable true lanes 8
pci/0000:08:00.0/2: type eth netdev enp8s0f0npf0vf0 flavour pcivf controller 0 pfnum 0 vfnum 0 external false splittable false
  function:
    hw_addr 1a:33:f2:e7:64:d8
pci/0000:08:00.0/3: type eth netdev enp8s0f0npf0vf3 flavour pcivf controller 0 pfnum 0 vfnum 3 external false splittable false
  function:
    hw_addr 4e:ef:ca:9e:e7:5d
pci/0000:08:00.0/4: type eth netdev enp8s0f0npf0vf1 flavour pcivf controller 0 pfnum 0 vfnum 1 external false splittable false
  function:
    hw_addr 5a:f0:e3:f8:41:93
pci/0000:08:00.0/5: type eth netdev enp8s0f0npf0vf2 flavour pcivf controller 0 pfnum 0 vfnum 2 external false splittable false
  function:
    hw_addr aa:bb:cc:dd:ee:ff
pci/0000:08:00.1/0: type eth netdev enp8s0f1np1 flavour physical port 1 splittable false


