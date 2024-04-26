Return-Path: <linux-kernel+bounces-160521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE48B3EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 799F21C223C1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD2171E69;
	Fri, 26 Apr 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThgRPWzE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B7F171661
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153818; cv=none; b=Ts/reYIf4M3XMAJwLR4pB00MXjzennBKtMYDEHdNk1yuoPQVtd+sDJ6zpDceQ1TlTvkSIXiGkT+K54lyU++N8cMMd/6u3LD0dzBWNeyEKwVeEMdIrJcwdS5oTB4bbKm3eLMddpfB4osW5p5WyEl8twjGmvtDiInPtiPZdPn/lYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153818; c=relaxed/simple;
	bh=7yrZ8coMikA+E4ydoDYkmPlbqqL6xFJeds4Psv/q0ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joGd/bWF0b9muHrnxw3DIW3edfB95YCpyb4DsUBCr5CUt21IFKstH0PTLdsICPEd79Vv0udzbZjK28/4GdFnY+/ZFf2vjey+hVvP429JXFq3VOjBfKIdJoO1qwUNaS0Y6SolBHmpA37emnEl0A/VF3uP6GM8/i564F9HC8w2Phk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ThgRPWzE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714153816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t02hgqrflAZO/dEUh3M5MYsY6GpRFnEdmslCRhsundQ=;
	b=ThgRPWzEMYLjQkZSKlP/puqDmLde84cuVmwtBqFc5XgRUDPlRDsv3dd0cc5GQ0tFiqeOW/
	Q7xMLqBuwikV4hgsb0Urut80z4KvgoBVQFgOUJspdv+Tk+L2aYTIdpDhadRphg8+Mz03RT
	oBjdS2b85dQGFRXNEC+ui6ED3qoAB6Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-pbUs6CbUP-arJ2oX6CNT1w-1; Fri,
 26 Apr 2024 13:50:14 -0400
X-MC-Unique: pbUs6CbUP-arJ2oX6CNT1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE4911C04B56;
	Fri, 26 Apr 2024 17:50:13 +0000 (UTC)
Received: from p1.luc.cera.cz (unknown [10.45.225.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1670AC13FA4;
	Fri, 26 Apr 2024 17:50:11 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 7/7] i40e: Add and use helper to reconfigure TC for given VSI
Date: Fri, 26 Apr 2024 19:49:46 +0200
Message-ID: <20240426174953.208591-8-ivecera@redhat.com>
In-Reply-To: <20240426174953.208591-1-ivecera@redhat.com>
References: <20240426174953.208591-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Add helper i40e_vsi_reconfig_tc(vsi) that configures TC
for given VSI using previously stored TC bitmap.

Effectively replaces open-coded patterns:

enabled_tc = vsi->tc_config.enabled_tc;
vsi->tc_config.enabled_tc = 0;
i40e_vsi_config_tc(vsi, enabled_tc);

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 31 +++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 26e5c21df19d..1051dbb1f42e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5917,6 +5917,27 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 	return ret;
 }
 
+/**
+ * i40e_vsi_reconfig_tc - Reconfigure VSI Tx Scheduler for stored TC map
+ * @vsi: VSI to be reconfigured
+ *
+ * This reconfigures a particular VSI for TCs that are mapped to the
+ * TC bitmap stored previously for the VSI.
+ *
+ * NOTE:
+ * It is expected that the VSI queues have been quisced before calling
+ * this function.
+ **/
+static int i40e_vsi_reconfig_tc(struct i40e_vsi *vsi)
+{
+	u8 enabled_tc;
+
+	enabled_tc = vsi->tc_config.enabled_tc;
+	vsi->tc_config.enabled_tc = 0;
+
+	return i40e_vsi_config_tc(vsi, enabled_tc);
+}
+
 /**
  * i40e_get_link_speed - Returns link speed for the interface
  * @vsi: VSI to be configured
@@ -14279,7 +14300,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	struct i40e_vsi *main_vsi;
 	u16 alloc_queue_pairs;
 	struct i40e_pf *pf;
-	u8 enabled_tc;
 	int ret;
 
 	if (!vsi)
@@ -14312,10 +14332,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	 * layout configurations.
 	 */
 	main_vsi = i40e_pf_get_main_vsi(pf);
-	enabled_tc = main_vsi->tc_config.enabled_tc;
-	main_vsi->tc_config.enabled_tc = 0;
 	main_vsi->seid = pf->main_vsi_seid;
-	i40e_vsi_config_tc(main_vsi, enabled_tc);
+	i40e_vsi_reconfig_tc(main_vsi);
 
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_rm_default_mac_filter(vsi, pf->hw.mac.perm_addr);
@@ -15074,11 +15092,8 @@ static int i40e_setup_pf_switch(struct i40e_pf *pf, bool reinit, bool lock_acqui
 		}
 	} else {
 		/* force a reset of TC and queue layout configurations */
-		u8 enabled_tc = main_vsi->tc_config.enabled_tc;
-
-		main_vsi->tc_config.enabled_tc = 0;
 		main_vsi->seid = pf->main_vsi_seid;
-		i40e_vsi_config_tc(main_vsi, enabled_tc);
+		i40e_vsi_reconfig_tc(main_vsi);
 	}
 	i40e_vlan_stripping_disable(main_vsi);
 
-- 
2.43.2


