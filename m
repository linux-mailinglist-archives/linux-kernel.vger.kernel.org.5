Return-Path: <linux-kernel+bounces-117913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7888B12E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47B161F2CB3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274941C75;
	Mon, 25 Mar 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOqLjzvU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB5FC01
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397954; cv=none; b=D2PZlVtN1XWAIpA/hwJuJVKHO07Aa9yXvg+EZ5sh3QVg51j8/Hz/JLaD57DlWkuhsHBSwBDFHJMYO/ijiiLrshLfgPDqAGlItY6lFCTbycEwIfvYz0twcXCL0RKnxFwK8d5PrvM8MK+SW9yRw+SKmviwogddKMZ5ucddkO7YcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397954; c=relaxed/simple;
	bh=IdVCsrq7tOKkEg9iPBuyY/ynzK2AlcCUX1wvmPlnA74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OYUMzzwZ3RVDmpyedFebJWD7oW+jW2oucWAB69JuiQxgj06VyMRxEYpBgR43tBh89u5VllDQJhQM1NlXh0zBcfnZMwZSV7lRD1aHWKZ5prMpnLnkuiJMfK/UEj+EMqasKMvAK8PKNTn70clvVMDqgmznrSUOxoB7TIV0DzmT9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOqLjzvU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711397952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vHCr1hkVrt3zjsj8EZP+o7GfFXzd0IpEVKZBBTCHeI0=;
	b=fOqLjzvUM/Bzv1oJVtTzSgRt7Ol6IgG2YHuiWK2/hPb1WuA4JGFHOkMQ7dBQS6No/8QePl
	Z1v9LkjfN5ianMHtA6TMXrj80jjSrN6fsNosOKAafovBXGDrRPQdkL08TtmZLGk/+HME1o
	WdVCJp2UMEt0TscjQ+Kxsuk5e3EuXO0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-qwYNHUpaNJ6s8NxEaFpIGw-1; Mon,
 25 Mar 2024 16:19:08 -0400
X-MC-Unique: qwYNHUpaNJ6s8NxEaFpIGw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3100380671B;
	Mon, 25 Mar 2024 20:19:07 +0000 (UTC)
Received: from swamp.redhat.com (unknown [10.45.224.78])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DA6E492BD3;
	Mon, 25 Mar 2024 20:19:06 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	wojciech.drewek@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ice: fix enabling RX VLAN filtering
Date: Mon, 25 Mar 2024 21:19:01 +0100
Message-ID: <20240325201901.39365-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

ice_port_vlan_on/off() was introduced in commit 2946204b3fa8 ("ice:
implement bridge port vlan"). But ice_port_vlan_on() incorrectly assigns
ena_rx_filtering to inner_vlan_ops in DVM mode.
This causes an error when rx_filtering cannot be enabled in legacy mode.

Reproducer:
 echo 1 > /sys/class/net/$PF/device/sriov_numvfs
 ip link set $PF vf 0 spoofchk off trust on vlan 3
dmesg:
 ice 0000:41:00.0: failed to enable Rx VLAN filtering for VF 0 VSI 9 during VF rebuild, error -95

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Signed-off-by: Petr Oros <poros@redhat.com>
---
 .../ethernet/intel/ice/ice_vf_vsi_vlan_ops.c   | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
index 80dc4bcdd3a41c..b3e1bdcb80f84d 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
@@ -26,24 +26,22 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
 	struct ice_vsi_vlan_ops *vlan_ops;
 	struct ice_pf *pf = vsi->back;
 
-	if (ice_is_dvm_ena(&pf->hw)) {
-		vlan_ops = &vsi->outer_vlan_ops;
-
-		/* setup outer VLAN ops */
-		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
+	/* setup inner VLAN ops */
+	vlan_ops = &vsi->inner_vlan_ops;
 
-		/* setup inner VLAN ops */
-		vlan_ops = &vsi->inner_vlan_ops;
+	if (ice_is_dvm_ena(&pf->hw)) {
 		vlan_ops->add_vlan = noop_vlan_arg;
 		vlan_ops->del_vlan = noop_vlan_arg;
 		vlan_ops->ena_stripping = ice_vsi_ena_inner_stripping;
 		vlan_ops->dis_stripping = ice_vsi_dis_inner_stripping;
 		vlan_ops->ena_insertion = ice_vsi_ena_inner_insertion;
 		vlan_ops->dis_insertion = ice_vsi_dis_inner_insertion;
-	} else {
-		vlan_ops = &vsi->inner_vlan_ops;
 
+		/* setup outer VLAN ops */
+		vlan_ops = &vsi->outer_vlan_ops;
+		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
+		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
+	} else {
 		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
 	}
-- 
2.43.2


