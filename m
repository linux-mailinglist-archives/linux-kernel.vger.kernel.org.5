Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E7C7CF315
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbjJSIoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbjJSInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:43:47 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 31AF219B4;
        Thu, 19 Oct 2023 01:43:13 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id A03B0608BCF89;
        Thu, 19 Oct 2023 16:42:57 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] i40e: add an error code check in i40e_vsi_setup
Date:   Thu, 19 Oct 2023 16:42:42 +0800
Message-Id: <20231019084241.1529662-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check the value of 'ret' after calling 'i40e_vsi_config_rss'.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index de7fd43dc11c..9205090e5017 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14567,6 +14567,8 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
 	if ((pf->hw_features & I40E_HW_RSS_AQ_CAPABLE) &&
 	    (vsi->type == I40E_VSI_VMDQ2)) {
 		ret = i40e_vsi_config_rss(vsi);
+		if (ret)
+			goto err_rings;
 	}
 	return vsi;
 
-- 
2.30.2

