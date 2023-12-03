Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423698025BE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 17:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjLCQwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 11:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjLCQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 11:52:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED08E8;
        Sun,  3 Dec 2023 08:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701622342; x=1733158342;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N9rjqssMGbAvr291sISynJdKrrI2CBF9OefB6kNHY6c=;
  b=NKC9j9i7fQN66ptshVzMwsPIkZ6w9V0TLjCogwmW6NfxoZ7E4KC9EH2v
   3fzRanbpbMgFXA0lJ/YHWEO6NpP3Mav7DaDMIe+ZZwAMRxNHQCKTSkM+6
   YiLt2pYP352za6SUGCL4OqQPwcuNyt21wEEplhMcm/yBhjkvsstpm2SsO
   WX22kMRmfM6VaUa2dOb7fArR16Ni7jQiGzwM9KXRWPqZml1Oh8iuZ9pnV
   f6c8s0gAVyHSdoD9tmk7UaC/wfOEob7fRLOxy1hZADIyFXgJHrKLPobu5
   DkTVtyNyvMIg0qA1Z/KHzrvf/Rp5wItutX2dJzwPVGoMxRMZ9WlXGTw0z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="706847"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="706847"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 08:52:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="799345480"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="799345480"
Received: from p12ill20yoongsia.png.intel.com ([10.88.227.28])
  by orsmga008.jf.intel.com with ESMTP; 03 Dec 2023 08:52:11 -0800
From:   Song Yoong Siang <yoong.siang.song@intel.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, bpf@vger.kernel.org,
        xdp-hints@xdp-project.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH bpf-next v3 2/3] net: stmmac: add Launch Time support to XDP ZC
Date:   Mon,  4 Dec 2023 00:51:28 +0800
Message-Id: <20231203165129.1740512-3-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203165129.1740512-1-yoong.siang.song@intel.com>
References: <20231203165129.1740512-1-yoong.siang.song@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables Launch Time (Time-Based Scheduling) support to XDP zero
copy via XDP Tx metadata framework.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 686c94c2e8a7..e8538af6e207 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -105,6 +105,8 @@ struct stmmac_metadata_request {
 	struct stmmac_priv *priv;
 	struct dma_desc *tx_desc;
 	bool *set_ic;
+	struct dma_edesc *edesc;
+	int tbs;
 };
 
 struct stmmac_xsk_tx_complete {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c2ac88aaffed..1fe80bfae24b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2465,9 +2465,20 @@ static u64 stmmac_xsk_fill_timestamp(void *_priv)
 	return 0;
 }
 
+static void stmmac_xsk_request_launch_time(u64 launch_time, void *_priv)
+{
+	struct stmmac_metadata_request *meta_req = _priv;
+	struct timespec64 ts = ns_to_timespec64(launch_time);
+
+	if (meta_req->tbs & STMMAC_TBS_EN)
+		stmmac_set_desc_tbs(meta_req->priv, meta_req->edesc, ts.tv_sec,
+				    ts.tv_nsec);
+}
+
 static const struct xsk_tx_metadata_ops stmmac_xsk_tx_metadata_ops = {
 	.tmo_request_timestamp		= stmmac_xsk_request_timestamp,
 	.tmo_fill_timestamp		= stmmac_xsk_fill_timestamp,
+	.tmo_request_launch_time	= stmmac_xsk_request_launch_time,
 };
 
 static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
@@ -2545,6 +2556,8 @@ static bool stmmac_xdp_xmit_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		meta_req.priv = priv;
 		meta_req.tx_desc = tx_desc;
 		meta_req.set_ic = &set_ic;
+		meta_req.tbs = tx_q->tbs;
+		meta_req.edesc = &tx_q->dma_entx[entry];
 		xsk_tx_metadata_request(meta, &stmmac_xsk_tx_metadata_ops,
 					&meta_req);
 		if (set_ic) {
-- 
2.34.1

