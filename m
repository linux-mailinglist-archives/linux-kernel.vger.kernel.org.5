Return-Path: <linux-kernel+bounces-130311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D978976A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A14E1F2D377
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C311598E6;
	Wed,  3 Apr 2024 17:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul+686nh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2015958C;
	Wed,  3 Apr 2024 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164710; cv=none; b=hvN/iJaJ9mD+21HLfs93KnSoRDiPXBRwZkJdCGOTAVi9c8fgMLMZ19WGSUJHUaElyIZJPLC1zp5vfBu0vndxkG2Oew8vaMM2hmMgWV464qZZ1xLXVAz7/T5jzCNNrlVdKIP8Gztgkfuour5MDGfb8v8pXoz81WzEtodMJDA5R9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164710; c=relaxed/simple;
	bh=5AKT9JhsWlEPnXqDO98v7qdY906vzs2De+7mKjvG3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRD9nTaviDEa13BTChSM/6qwQz5+cMS7Kg02l5GHRMPn2prQKOP4l1ErWuEcRUo4RwhLC2B9jjkhNdRtHJ+0DEEK3CJx9bfr6bWbrUYRh0N/CYqr7AufTmnw8J5iiQjrW2jy2AmuTkf61lG2Luh97Nb6aMFpIwqUnd/wtIl/Vw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul+686nh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54DEC433F1;
	Wed,  3 Apr 2024 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164709;
	bh=5AKT9JhsWlEPnXqDO98v7qdY906vzs2De+7mKjvG3WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ul+686nhiFq1gYO4mgNopehPbjSaG6Q42G7YOdkGkH4LlFUIsT6gahMx0Djv7ejIi
	 wXq96rwqVLkKEa5t/5grbXAgzk1fuODEYc/IFIzv9kqO6mKsD0LkLsY4a+9Cs9q0vi
	 kx2whDFDqrrkcgYHVld2lVb7sErxZVXUf6kPsYpbGktEeo1qXBbOnNPVeUUh+N3S/7
	 JqMCJI9ZsRpNvp6sHFS3r04TtlTwy3W4y1A+C23QPTTeD8ia6pM4lSlOg8R6Pz7oii
	 NreXHOEVsaEutnf7/LUUgGEcoqd5PA1xCSdspNzcQB1kmpvz6VSadiY8Ia17TLthGD
	 jbeZd8FAlnbEA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/20] thunderbolt: Keep the domain powered when USB4 port is in redrive mode
Date: Wed,  3 Apr 2024 13:17:48 -0400
Message-ID: <20240403171815.342668-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit a75e0684efe567ae5f6a8e91a8360c4c1773cf3a ]

If a DiplayPort cable is directly connected to the host routers USB4
port, there is no tunnel involved but the port is in "redrive" mode
meaning that it is re-driving the DisplayPort signals from its
DisplayPort source. In this case we need to keep the domain powered on
otherwise once the domain enters D3cold the connected monitor blanks
too.

Since this happens only on Intel Barlow Ridge add a quirk that takes
runtime PM reference if we detect that the USB4 port entered redrive
mode (and release it once it exits the mode).

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thunderbolt/quirks.c | 14 +++++++++++
 drivers/thunderbolt/tb.c     | 49 +++++++++++++++++++++++++++++++++++-
 drivers/thunderbolt/tb.h     |  4 +++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/quirks.c b/drivers/thunderbolt/quirks.c
index e6bfa63b40aee..e81de9c30eac9 100644
--- a/drivers/thunderbolt/quirks.c
+++ b/drivers/thunderbolt/quirks.c
@@ -43,6 +43,12 @@ static void quirk_usb3_maximum_bandwidth(struct tb_switch *sw)
 	}
 }
 
+static void quirk_block_rpm_in_redrive(struct tb_switch *sw)
+{
+	sw->quirks |= QUIRK_KEEP_POWER_IN_DP_REDRIVE;
+	tb_sw_dbg(sw, "preventing runtime PM in DP redrive mode\n");
+}
+
 struct tb_quirk {
 	u16 hw_vendor_id;
 	u16 hw_device_id;
@@ -86,6 +92,14 @@ static const struct tb_quirk tb_quirks[] = {
 		  quirk_usb3_maximum_bandwidth },
 	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HUB_40G_BRIDGE, 0x0000, 0x0000,
 		  quirk_usb3_maximum_bandwidth },
+	/*
+	 * Block Runtime PM in DP redrive mode for Intel Barlow Ridge host
+	 * controllers.
+	 */
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_80G_NHI, 0x0000, 0x0000,
+		  quirk_block_rpm_in_redrive },
+	{ 0x8087, PCI_DEVICE_ID_INTEL_BARLOW_RIDGE_HOST_40G_NHI, 0x0000, 0x0000,
+		  quirk_block_rpm_in_redrive },
 	/*
 	 * CLx is not supported on AMD USB4 Yellow Carp and Pink Sardine platforms.
 	 */
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 27bd6ca6f99e4..ecfb5714e822d 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1416,6 +1416,49 @@ static void tb_tunnel_dp(struct tb *tb)
 	pm_runtime_put_autosuspend(&in->sw->dev);
 }
 
+static void tb_enter_redrive(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	/*
+	 * If we get hot-unplug for the DP IN port of the host router
+	 * and the DP resource is not available anymore it means there
+	 * is a monitor connected directly to the Type-C port and we are
+	 * in "redrive" mode. For this to work we cannot enter RTD3 so
+	 * we bump up the runtime PM reference count here.
+	 */
+	if (!tb_port_is_dpin(port))
+		return;
+	if (tb_route(sw))
+		return;
+	if (!tb_switch_query_dp_resource(sw, port)) {
+		port->redrive = true;
+		pm_runtime_get(&sw->dev);
+		tb_port_dbg(port, "enter redrive mode, keeping powered\n");
+	}
+}
+
+static void tb_exit_redrive(struct tb_port *port)
+{
+	struct tb_switch *sw = port->sw;
+
+	if (!(sw->quirks & QUIRK_KEEP_POWER_IN_DP_REDRIVE))
+		return;
+
+	if (!tb_port_is_dpin(port))
+		return;
+	if (tb_route(sw))
+		return;
+	if (port->redrive && tb_switch_query_dp_resource(sw, port)) {
+		port->redrive = false;
+		pm_runtime_put(&sw->dev);
+		tb_port_dbg(port, "exit redrive mode\n");
+	}
+}
+
 static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 {
 	struct tb_port *in, *out;
@@ -1432,7 +1475,10 @@ static void tb_dp_resource_unavailable(struct tb *tb, struct tb_port *port)
 	}
 
 	tunnel = tb_find_tunnel(tb, TB_TUNNEL_DP, in, out);
-	tb_deactivate_and_free_tunnel(tunnel);
+	if (tunnel)
+		tb_deactivate_and_free_tunnel(tunnel);
+	else
+		tb_enter_redrive(port);
 	list_del_init(&port->list);
 
 	/*
@@ -1459,6 +1505,7 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
 	tb_port_dbg(port, "DP %s resource available\n",
 		    tb_port_is_dpin(port) ? "IN" : "OUT");
 	list_add_tail(&port->list, &tcm->dp_resources);
+	tb_exit_redrive(port);
 
 	/* Look for suitable DP IN <-> DP OUT pairs now */
 	tb_tunnel_dp(tb);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index d2a55ad2fd3e6..4893d2c7ac968 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -23,6 +23,8 @@
 #define QUIRK_FORCE_POWER_LINK_CONTROLLER		BIT(0)
 /* Disable CLx if not supported */
 #define QUIRK_NO_CLX					BIT(1)
+/* Need to keep power on while USB4 port is in redrive mode */
+#define QUIRK_KEEP_POWER_IN_DP_REDRIVE			BIT(2)
 
 /**
  * struct tb_nvm - Structure holding NVM information
@@ -261,6 +263,7 @@ struct tb_bandwidth_group {
  * @group_list: The adapter is linked to the group's list of ports through this
  * @max_bw: Maximum possible bandwidth through this adapter if set to
  *	    non-zero.
+ * @redrive: For DP IN, if true the adapter is in redrive mode.
  *
  * In USB4 terminology this structure represents an adapter (protocol or
  * lane adapter).
@@ -289,6 +292,7 @@ struct tb_port {
 	struct tb_bandwidth_group *group;
 	struct list_head group_list;
 	unsigned int max_bw;
+	bool redrive;
 };
 
 /**
-- 
2.43.0


