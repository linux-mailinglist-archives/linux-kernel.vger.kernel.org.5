Return-Path: <linux-kernel+bounces-101830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8844687ABF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A54D1C21487
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07EC6DD0A;
	Wed, 13 Mar 2024 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbo1e3sV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8346D1B5;
	Wed, 13 Mar 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347864; cv=none; b=e0SrJ1M6CWr8/jm5IQNr3tg5k1CLWS7KRiKdtemRhPUcyHr/w9WEBZZqieQig0SPz+F09OK5NfWPnTJi/9yfUZeflDTUC7bC3oiKDn937cAHVhm8OYFLNhywA+485oApPG10f5B8YYg6PyGc4mVuzUr481SO8OcpdDnRW61j0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347864; c=relaxed/simple;
	bh=kolto2Jurltm4O2d84aCWETSNmbSu8O6ktjmxyJAh7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O54bjPhpdXCN+PchrXax98kwyQUZRplmaxHVuMaI56Ql1bCeHdFFVQTsPTd84jsduO4HBvWDHlP8mj2nQBOvdHtLew2TXcsNTFhhKXr5Ui5JiuoyaeYrzait9PeqdkLptwNOYsS2YJYIorVwI1t2ufO0py2xGqYDW0u332Pj1Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbo1e3sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47166C433C7;
	Wed, 13 Mar 2024 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347864;
	bh=kolto2Jurltm4O2d84aCWETSNmbSu8O6ktjmxyJAh7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dbo1e3sVsKY+TzzpdLisNUOoof52vJ/LemoBvAqY13UkF5PAEJ95cYGfUbXd71uaD
	 xjuTYFDME+nvBRRRGteEkfHxVToOckdHqNEJQueNC085mnwiTqjUM3p8CGVSjxD6Vg
	 Kflz2rs0LRyj4dv2hU4Z3x9PHmfjeOHan8rMshU+qkpLD4r6jkYuiVnNE7+AvLyl9H
	 euFNR3k9XFfQWKO2WwGaqnsbXBTShdy/CxpLRSWyTQxLDbPJxi4Vx0HWcIumt+NHEN
	 uNHwrhPoavU5Al4+fgvQiQpPR2rW6F5Jg46PFC3iu6rjyqvliFY1vWciwt2mdsh0ie
	 8Ij59sA7VzcYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 27/60] igc: avoid returning frame twice in XDP_REDIRECT
Date: Wed, 13 Mar 2024 12:36:34 -0400
Message-ID: <20240313163707.615000-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Florian Kauer <florian.kauer@linutronix.de>

[ Upstream commit ef27f655b438bed4c83680e4f01e1cde2739854b ]

When a frame can not be transmitted in XDP_REDIRECT
(e.g. due to a full queue), it is necessary to free
it by calling xdp_return_frame_rx_napi.

However, this is the responsibility of the caller of
the ndo_xdp_xmit (see for example bq_xmit_all in
kernel/bpf/devmap.c) and thus calling it inside
igc_xdp_xmit (which is the ndo_xdp_xmit of the igc
driver) as well will lead to memory corruption.

In fact, bq_xmit_all expects that it can return all
frames after the last successfully transmitted one.
Therefore, break for the first not transmitted frame,
but do not call xdp_return_frame_rx_napi in igc_xdp_xmit.
This is equally implemented in other Intel drivers
such as the igb.

There are two alternatives to this that were rejected:
1. Return num_frames as all the frames would have been
   transmitted and release them inside igc_xdp_xmit.
   While it might work technically, it is not what
   the return value is meant to represent (i.e. the
   number of SUCCESSFULLY transmitted packets).
2. Rework kernel/bpf/devmap.c and all drivers to
   support non-consecutively dropped packets.
   Besides being complex, it likely has a negative
   performance impact without a significant gain
   since it is anyway unlikely that the next frame
   can be transmitted if the previous one was dropped.

The memory corruption can be reproduced with
the following script which leads to a kernel panic
after a few seconds.  It basically generates more
traffic than a i225 NIC can transmit and pushes it
via XDP_REDIRECT from a virtual interface to the
physical interface where frames get dropped.

   #!/bin/bash
   INTERFACE=enp4s0
   INTERFACE_IDX=`cat /sys/class/net/$INTERFACE/ifindex`

   sudo ip link add dev veth1 type veth peer name veth2
   sudo ip link set up $INTERFACE
   sudo ip link set up veth1
   sudo ip link set up veth2

   cat << EOF > redirect.bpf.c

   SEC("prog")
   int redirect(struct xdp_md *ctx)
   {
       return bpf_redirect($INTERFACE_IDX, 0);
   }

   char _license[] SEC("license") = "GPL";
   EOF
   clang -O2 -g -Wall -target bpf -c redirect.bpf.c -o redirect.bpf.o
   sudo ip link set veth2 xdp obj redirect.bpf.o

   cat << EOF > pass.bpf.c

   SEC("prog")
   int pass(struct xdp_md *ctx)
   {
       return XDP_PASS;
   }

   char _license[] SEC("license") = "GPL";
   EOF
   clang -O2 -g -Wall -target bpf -c pass.bpf.c -o pass.bpf.o
   sudo ip link set $INTERFACE xdp obj pass.bpf.o

   cat << EOF > trafgen.cfg

   {
     /* Ethernet Header */
     0xe8, 0x6a, 0x64, 0x41, 0xbf, 0x46,
     0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
     const16(ETH_P_IP),

     /* IPv4 Header */
     0b01000101, 0,   # IPv4 version, IHL, TOS
     const16(1028),   # IPv4 total length (UDP length + 20 bytes (IP header))
     const16(2),      # IPv4 ident
     0b01000000, 0,   # IPv4 flags, fragmentation off
     64,              # IPv4 TTL
     17,              # Protocol UDP
     csumip(14, 33),  # IPv4 checksum

     /* UDP Header */
     10,  0, 1, 1,    # IP Src - adapt as needed
     10,  0, 1, 2,    # IP Dest - adapt as needed
     const16(6666),   # UDP Src Port
     const16(6666),   # UDP Dest Port
     const16(1008),   # UDP length (UDP header 8 bytes + payload length)
     csumudp(14, 34), # UDP checksum

     /* Payload */
     fill('W', 1000),
   }
   EOF

   sudo trafgen -i trafgen.cfg -b3000MB -o veth1 --cpp

Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 98de34d0ce07e..e549ffca88e39 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6489,7 +6489,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	int cpu = smp_processor_id();
 	struct netdev_queue *nq;
 	struct igc_ring *ring;
-	int i, drops;
+	int i, nxmit;
 
 	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
@@ -6505,16 +6505,15 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	/* Avoid transmit queue timeout since we share it with the slow path */
 	txq_trans_cond_update(nq);
 
-	drops = 0;
+	nxmit = 0;
 	for (i = 0; i < num_frames; i++) {
 		int err;
 		struct xdp_frame *xdpf = frames[i];
 
 		err = igc_xdp_init_tx_descriptor(ring, xdpf);
-		if (err) {
-			xdp_return_frame_rx_napi(xdpf);
-			drops++;
-		}
+		if (err)
+			break;
+		nxmit++;
 	}
 
 	if (flags & XDP_XMIT_FLUSH)
@@ -6522,7 +6521,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 
 	__netif_tx_unlock(nq);
 
-	return num_frames - drops;
+	return nxmit;
 }
 
 static void igc_trigger_rxtxq_interrupt(struct igc_adapter *adapter,
-- 
2.43.0


