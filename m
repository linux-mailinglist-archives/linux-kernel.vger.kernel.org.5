Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0283C77B2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbjHNHpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjHNHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:45:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C31719
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 00:45:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7DC562FFF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0E5C433C8;
        Mon, 14 Aug 2023 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691999120;
        bh=UKxzW+x4Bhe85PmCQpAj1NUbjaWZu2yOxA+zzBepsrE=;
        h=From:To:Cc:Subject:Date:From;
        b=U+fU3YxMeUFcSIo7V3KmCJ2QTEc3AnZCdoNWjSghgVde7qgMy8l/dQzOTbk/ntBDP
         3KTqYUep+CFqdzcV07x8MUYit4roChSFCHX6BgrPdiuEkcuCgyDRI/27/95in9IG/R
         et6Rjp00/KXHufGqRtds2Abh1OPpVrCzcc+ivyhDtw1hSt/Ww/WaR1GZ6iy6zTrcw1
         EWrFsr1nRABg/B8Gk0YSJwHYN4pDoWwovImdPgnVoY/8yFg7hB0zLZ8azajnGM2qp7
         AByvzbPvevMO2D6vwg8gPSO0W8bbHCxQ9Xra2yTG02aGO2B0ve32Ry+tWrtqqIPcjn
         cfHJ2sd0PE8qw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Yuval Mintz <Yuval.Mintz@qlogic.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] qed: remove unused 'resp_size' calculation
Date:   Mon, 14 Aug 2023 09:45:03 +0200
Message-Id: <20230814074512.1067715-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Newer versions of clang warn about this variable being assigned but
never used:

drivers/net/ethernet/qlogic/qed/qed_vf.c:63:67: error: parameter 'resp_size' set but not used [-Werror,-Wunused-but-set-parameter]

There is no indication in the git history on how this was ever
meant to be used, so just remove the entire calculation and argument
passing for it to avoid the warning.

Fixes: 1408cc1fa48c5 ("qed: Introduce VFs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/qlogic/qed/qed_vf.c | 45 +++++++++---------------
 1 file changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_vf.c b/drivers/net/ethernet/qlogic/qed/qed_vf.c
index 7b0e390c0b07d..0e265ed1f501c 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_vf.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_vf.c
@@ -60,7 +60,7 @@ static void qed_vf_pf_req_end(struct qed_hwfn *p_hwfn, int req_status)
 #define QED_VF_CHANNEL_MSLEEP_ITERATIONS	10
 #define QED_VF_CHANNEL_MSLEEP_DELAY		25
 
-static int qed_send_msg2pf(struct qed_hwfn *p_hwfn, u8 *done, u32 resp_size)
+static int qed_send_msg2pf(struct qed_hwfn *p_hwfn, u8 *done)
 {
 	union vfpf_tlvs *p_req = p_hwfn->vf_iov_info->vf2pf_request;
 	struct ustorm_trigger_vf_zone trigger;
@@ -72,9 +72,6 @@ static int qed_send_msg2pf(struct qed_hwfn *p_hwfn, u8 *done, u32 resp_size)
 	/* output tlvs list */
 	qed_dp_tlv_list(p_hwfn, p_req);
 
-	/* need to add the END TLV to the message size */
-	resp_size += sizeof(struct channel_list_end_tlv);
-
 	/* Send TLVs over HW channel */
 	memset(&trigger, 0, sizeof(struct ustorm_trigger_vf_zone));
 	trigger.vf_pf_msg_valid = 1;
@@ -172,7 +169,7 @@ static int _qed_vf_pf_release(struct qed_hwfn *p_hwfn, bool b_final)
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 
 	if (!rc && resp->hdr.status != PFVF_STATUS_SUCCESS)
 		rc = -EAGAIN;
@@ -301,7 +298,7 @@ static int qed_vf_pf_acquire(struct qed_hwfn *p_hwfn)
 		memset(p_iov->pf2vf_reply, 0, sizeof(union pfvf_tlvs));
 
 		/* send acquire request */
-		rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+		rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 
 		/* Re-try acquire in case of vf-pf hw channel timeout */
 		if (retry_cnt && rc == -EBUSY) {
@@ -705,7 +702,7 @@ int qed_vf_pf_tunnel_param_update(struct qed_hwfn *p_hwfn,
 		    sizeof(struct channel_list_end_tlv));
 
 	p_resp = &p_iov->pf2vf_reply->tunn_param_resp;
-	rc = qed_send_msg2pf(p_hwfn, &p_resp->hdr.status, sizeof(*p_resp));
+	rc = qed_send_msg2pf(p_hwfn, &p_resp->hdr.status);
 
 	if (rc)
 		goto exit;
@@ -772,7 +769,7 @@ qed_vf_pf_rxq_start(struct qed_hwfn *p_hwfn,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->queue_start;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -822,7 +819,7 @@ int qed_vf_pf_rxq_stop(struct qed_hwfn *p_hwfn,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -867,7 +864,7 @@ qed_vf_pf_txq_start(struct qed_hwfn *p_hwfn,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->queue_start;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -918,7 +915,7 @@ int qed_vf_pf_txq_stop(struct qed_hwfn *p_hwfn, struct qed_queue_cid *p_cid)
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -968,7 +965,7 @@ int qed_vf_pf_vport_start(struct qed_hwfn *p_hwfn,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -997,7 +994,7 @@ int qed_vf_pf_vport_stop(struct qed_hwfn *p_hwfn)
 	qed_add_tlv(p_hwfn, &p_iov->offset,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -1075,12 +1072,10 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 	struct vfpf_vport_update_tlv *req;
 	struct pfvf_def_resp_tlv *resp;
 	u8 update_rx, update_tx;
-	u32 resp_size = 0;
 	u16 size, tlv;
 	int rc;
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	resp_size = sizeof(*resp);
 
 	update_rx = p_params->update_vport_active_rx_flg;
 	update_tx = p_params->update_vport_active_tx_flg;
@@ -1096,7 +1091,6 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 		p_act_tlv = qed_add_tlv(p_hwfn, &p_iov->offset,
 					CHANNEL_TLV_VPORT_UPDATE_ACTIVATE,
 					size);
-		resp_size += sizeof(struct pfvf_def_resp_tlv);
 
 		if (update_rx) {
 			p_act_tlv->update_rx = update_rx;
@@ -1116,7 +1110,6 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 		tlv = CHANNEL_TLV_VPORT_UPDATE_TX_SWITCH;
 		p_tx_switch_tlv = qed_add_tlv(p_hwfn, &p_iov->offset,
 					      tlv, size);
-		resp_size += sizeof(struct pfvf_def_resp_tlv);
 
 		p_tx_switch_tlv->tx_switching = p_params->tx_switching_flg;
 	}
@@ -1127,7 +1120,6 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 		size = sizeof(struct vfpf_vport_update_mcast_bin_tlv);
 		p_mcast_tlv = qed_add_tlv(p_hwfn, &p_iov->offset,
 					  CHANNEL_TLV_VPORT_UPDATE_MCAST, size);
-		resp_size += sizeof(struct pfvf_def_resp_tlv);
 
 		memcpy(p_mcast_tlv->bins, p_params->bins,
 		       sizeof(u32) * ETH_MULTICAST_MAC_BINS_IN_REGS);
@@ -1142,7 +1134,6 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 		tlv = CHANNEL_TLV_VPORT_UPDATE_ACCEPT_PARAM;
 		size = sizeof(struct vfpf_vport_update_accept_param_tlv);
 		p_accept_tlv = qed_add_tlv(p_hwfn, &p_iov->offset, tlv, size);
-		resp_size += sizeof(struct pfvf_def_resp_tlv);
 
 		if (update_rx) {
 			p_accept_tlv->update_rx_mode = update_rx;
@@ -1166,7 +1157,6 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 		p_rss_tlv = qed_add_tlv(p_hwfn,
 					&p_iov->offset,
 					CHANNEL_TLV_VPORT_UPDATE_RSS, size);
-		resp_size += sizeof(struct pfvf_def_resp_tlv);
 
 		if (rss_params->update_rss_config)
 			p_rss_tlv->update_rss_flags |=
@@ -1203,7 +1193,6 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 		tlv = CHANNEL_TLV_VPORT_UPDATE_ACCEPT_ANY_VLAN;
 		p_any_vlan_tlv = qed_add_tlv(p_hwfn, &p_iov->offset, tlv, size);
 
-		resp_size += sizeof(struct pfvf_def_resp_tlv);
 		p_any_vlan_tlv->accept_any_vlan = p_params->accept_any_vlan;
 		p_any_vlan_tlv->update_accept_any_vlan_flg =
 		    p_params->update_accept_any_vlan_flg;
@@ -1213,7 +1202,7 @@ int qed_vf_pf_vport_update(struct qed_hwfn *p_hwfn,
 	qed_add_tlv(p_hwfn, &p_iov->offset,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, resp_size);
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -1245,7 +1234,7 @@ int qed_vf_pf_reset(struct qed_hwfn *p_hwfn)
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -1303,7 +1292,7 @@ int qed_vf_pf_filter_ucast(struct qed_hwfn *p_hwfn,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -1332,7 +1321,7 @@ int qed_vf_pf_int_cleanup(struct qed_hwfn *p_hwfn)
 	qed_add_tlv(p_hwfn, &p_iov->offset,
 		    CHANNEL_TLV_LIST_END, sizeof(struct channel_list_end_tlv));
 
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -1364,7 +1353,7 @@ int qed_vf_pf_get_coalesce(struct qed_hwfn *p_hwfn,
 		    sizeof(struct channel_list_end_tlv));
 	resp = &p_iov->pf2vf_reply->read_coal_resp;
 
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
@@ -1402,7 +1391,7 @@ qed_vf_pf_bulletin_update_mac(struct qed_hwfn *p_hwfn,
 		    sizeof(struct channel_list_end_tlv));
 
 	p_resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &p_resp->hdr.status, sizeof(*p_resp));
+	rc = qed_send_msg2pf(p_hwfn, &p_resp->hdr.status);
 	qed_vf_pf_req_end(p_hwfn, rc);
 	return rc;
 }
@@ -1433,7 +1422,7 @@ qed_vf_pf_set_coalesce(struct qed_hwfn *p_hwfn,
 		    sizeof(struct channel_list_end_tlv));
 
 	resp = &p_iov->pf2vf_reply->default_resp;
-	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status, sizeof(*resp));
+	rc = qed_send_msg2pf(p_hwfn, &resp->hdr.status);
 	if (rc)
 		goto exit;
 
-- 
2.39.2

