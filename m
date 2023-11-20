Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6518F7F1513
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjKTOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjKTOCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:02:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762051BB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:02:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8796C433CA;
        Mon, 20 Nov 2023 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488922;
        bh=oZx5xHeGEnIrSNUKwRJe5Xj6DAKxmM6RLnxMrlsczdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwLkJUI9sDp+ZWBqpFXflKm2RbX5rEOTTsNBqsx0GiZL1uezsUh0ayIcVzYMP5FZs
         SmhmgTDEdvy3CjiGqSL6GqEa/mVnswD1Eiy5995PkzE6TLfDz/iR/q0/UHSWnJbFNV
         QX/tpCQCYycqxq9Bmcik/aPFb+Ctq5md+qO1tjN38G6jk+l2nbaLqDkHgvV1GTrJE3
         QzW6hkM16WuhJ2XoMkx3mgyR+eW/DxSr8YVCMxhwqfPGliZT+9Yq6GUUcxjpPhK1QM
         uIneP8BIDXnqZxDwRqm1o9bfGM9mO7t288K7Ya9RQpl0zVB/ZshIlgizevVWJD+rK/
         IaeFK+gXui16g==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 2/7] net: ethernet: am65-cpsw: cleanup TAPRIO handling
Date:   Mon, 20 Nov 2023 16:01:42 +0200
Message-Id: <20231120140147.78726-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120140147.78726-1-rogerq@kernel.org>
References: <20231120140147.78726-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle offloading commands using switch-case in
am65_cpsw_setup_taprio().

Move checks to am65_cpsw_taprio_replace().

Use NL_SET_ERR_MSG_MOD for error messages.
Change error message from "Failed to set cycle time extension"
to "cycle time extension not supported"

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 149 +++++++++++-------------
 1 file changed, 70 insertions(+), 79 deletions(-)

Changelog:

v6: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 4bc611cc4aad..3539fb31541b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -428,7 +428,7 @@ static void am65_cpsw_stop_est(struct net_device *ndev)
 	am65_cpsw_timer_stop(ndev);
 }
 
-static void am65_cpsw_purge_est(struct net_device *ndev)
+static void am65_cpsw_taprio_destroy(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
@@ -441,29 +441,66 @@ static void am65_cpsw_purge_est(struct net_device *ndev)
 	port->qos.est_admin = NULL;
 }
 
-static int am65_cpsw_configure_taprio(struct net_device *ndev,
-				      struct am65_cpsw_est *est_new)
+static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
+				struct tc_taprio_qopt_offload *to)
+{
+	int i;
+
+	*to = *from;
+	for (i = 0; i < from->num_entries; i++)
+		to->entries[i] = from->entries[i];
+}
+
+static int am65_cpsw_taprio_replace(struct net_device *ndev,
+				    struct tc_taprio_qopt_offload *taprio)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct netlink_ext_ack *extack = taprio->mqprio.extack;
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct am65_cpts *cpts = common->cpts;
 	int ret = 0, tact = TACT_PROG;
+	struct am65_cpsw_est *est_new;
 
-	am65_cpsw_est_update_state(ndev);
+	if (!netif_running(ndev)) {
+		NL_SET_ERR_MSG_MOD(extack, "interface is down, link speed unknown\n");
+		return -ENETDOWN;
+	}
 
-	if (est_new->taprio.cmd == TAPRIO_CMD_DESTROY) {
-		am65_cpsw_stop_est(ndev);
-		return ret;
+	if (common->pf_p0_rx_ptype_rrobin) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "p0-rx-ptype-rrobin flag conflicts with taprio qdisc\n");
+		return -EINVAL;
+	}
+
+	if (port->qos.link_speed == SPEED_UNKNOWN)
+		return -ENOLINK;
+
+	if (taprio->cycle_time_extension) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "cycle time extension not supported");
+		return -EOPNOTSUPP;
 	}
 
+	est_new = devm_kzalloc(&ndev->dev,
+			       struct_size(est_new, taprio.entries, taprio->num_entries),
+			       GFP_KERNEL);
+	if (!est_new)
+		return -ENOMEM;
+
+	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
+
+	am65_cpsw_est_update_state(ndev);
+
 	ret = am65_cpsw_est_check_scheds(ndev, est_new);
 	if (ret < 0)
-		return ret;
+		goto fail;
 
 	tact = am65_cpsw_timer_act(ndev, est_new);
 	if (tact == TACT_NEED_STOP) {
-		dev_err(&ndev->dev,
-			"Can't toggle estf timer, stop taprio first");
-		return -EINVAL;
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Can't toggle estf timer, stop taprio first");
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	if (tact == TACT_PROG)
@@ -476,62 +513,24 @@ static int am65_cpsw_configure_taprio(struct net_device *ndev,
 	am65_cpsw_est_set_sched_list(ndev, est_new);
 	am65_cpsw_port_est_assign_buf_num(ndev, est_new->buf);
 
-	am65_cpsw_est_set(ndev, est_new->taprio.cmd == TAPRIO_CMD_REPLACE);
+	am65_cpsw_est_set(ndev, 1);
 
 	if (tact == TACT_PROG) {
 		ret = am65_cpsw_timer_set(ndev, est_new);
 		if (ret) {
-			dev_err(&ndev->dev, "Failed to set cycle time");
-			return ret;
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Failed to set cycle time");
+			goto fail;
 		}
 	}
 
-	return ret;
-}
-
-static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
-				struct tc_taprio_qopt_offload *to)
-{
-	int i;
-
-	*to = *from;
-	for (i = 0; i < from->num_entries; i++)
-		to->entries[i] = from->entries[i];
-}
-
-static int am65_cpsw_set_taprio(struct net_device *ndev, void *type_data)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-	struct tc_taprio_qopt_offload *taprio = type_data;
-	struct am65_cpsw_est *est_new;
-	int ret = 0;
-
-	if (taprio->cycle_time_extension) {
-		dev_err(&ndev->dev, "Failed to set cycle time extension");
-		return -EOPNOTSUPP;
-	}
-
-	est_new = devm_kzalloc(&ndev->dev,
-			       struct_size(est_new, taprio.entries, taprio->num_entries),
-			       GFP_KERNEL);
-	if (!est_new)
-		return -ENOMEM;
-
-	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
-	ret = am65_cpsw_configure_taprio(ndev, est_new);
-	if (!ret) {
-		if (taprio->cmd == TAPRIO_CMD_REPLACE) {
-			devm_kfree(&ndev->dev, port->qos.est_admin);
+	devm_kfree(&ndev->dev, port->qos.est_admin);
+	port->qos.est_admin = est_new;
 
-			port->qos.est_admin = est_new;
-		} else {
-			devm_kfree(&ndev->dev, est_new);
-			am65_cpsw_purge_est(ndev);
-		}
-	} else {
-		devm_kfree(&ndev->dev, est_new);
-	}
+	return 0;
 
+fail:
+	devm_kfree(&ndev->dev, est_new);
 	return ret;
 }
 
@@ -558,34 +557,26 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	return;
 
 purge_est:
-	am65_cpsw_purge_est(ndev);
+	am65_cpsw_taprio_destroy(ndev);
 }
 
 static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 {
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct tc_taprio_qopt_offload *taprio = type_data;
-	struct am65_cpsw_common *common = port->common;
-
-	if (taprio->cmd != TAPRIO_CMD_REPLACE &&
-	    taprio->cmd != TAPRIO_CMD_DESTROY)
-		return -EOPNOTSUPP;
-
-	if (!netif_running(ndev)) {
-		dev_err(&ndev->dev, "interface is down, link speed unknown\n");
-		return -ENETDOWN;
-	}
-
-	if (common->pf_p0_rx_ptype_rrobin) {
-		dev_err(&ndev->dev,
-			"p0-rx-ptype-rrobin flag conflicts with taprio qdisc\n");
-		return -EINVAL;
+	int err = 0;
+
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		err = am65_cpsw_taprio_replace(ndev, taprio);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		am65_cpsw_taprio_destroy(ndev);
+		break;
+	default:
+		err = -EOPNOTSUPP;
 	}
 
-	if (port->qos.link_speed == SPEED_UNKNOWN)
-		return -ENOLINK;
-
-	return am65_cpsw_set_taprio(ndev, type_data);
+	return err;
 }
 
 static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
-- 
2.34.1

