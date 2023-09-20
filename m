Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61EC7A8B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjITSJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjITSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:09:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D8C94;
        Wed, 20 Sep 2023 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695233359; x=1726769359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9v3tuq5QMpq6FKi4RwFSg7GiSz0pETN22pnlW81jpvc=;
  b=Gu0oIzlie/ACL7UpdhI6pUocntPigOJQG8c571qNh37/+8SqSL/fgt08
   b/hZf/sNAAm/FtrJSpPQG3CnsAayvI/UaeRqq1fXUI04mxlbYx71x8DsL
   lbM3rEudLP9wIGkW6MC43/BW+wxaoNVD408q7wUhqLDDmOapXkYeuumGC
   EP4rVBYZq1bGtlx9cICJ4qBwFeTcQEy+eklusA3VdidequtXufPMOPV8b
   0/ujVcllyGIovf0p0dAVCVfS9YoNyXSVxc57GoYQRwvx+8x8wxLj6eGAo
   /gsyvTv2OUqwK3oRN5+UW2RQIyV7Yrfm3tM/8BYjPxA8EAEXvTHiAeCWH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359685198"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359685198"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:09:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="870469703"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="870469703"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga004.jf.intel.com with ESMTP; 20 Sep 2023 11:09:16 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Michal Michalik <michal.michalik@intel.com>,
        Milena Olech <milena.olech@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next 3/3] idpf: fix undefined reference to tcp_gro_complete() when !CONFIG_INET
Date:   Wed, 20 Sep 2023 20:07:45 +0200
Message-ID: <20230920180745.1607563-4-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INET is not set, tcp_gro_complete is not compiled, although
the drivers using it may still be compiled (spotted by Randy):

aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o:
in function `idpf_rx_rsc.isra.0':
drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc):
undefined reference to `tcp_gro_complete'

The drivers need to guard the calls to it manually.
Return early from the RSC completion function if !CONFIG_INET, it won't
work properly either way. This effectively makes it be compiled-out
almost entirely on such builds.

Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 6fa79898c42c..aa45afeb6496 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2876,6 +2876,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
 	if (unlikely(!(ipv4 ^ ipv6)))
 		return -EINVAL;
 
+	if (!IS_ENABLED(CONFIG_INET))
+		return 0;
+
 	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
 	if (unlikely(rsc_segments == 1))
 		return 0;
-- 
2.41.0

