Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC35E7EBF67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 10:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjKOJYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjKOJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 04:24:01 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A157011C;
        Wed, 15 Nov 2023 01:23:57 -0800 (PST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E98BC602582C0;
        Wed, 15 Nov 2023 17:23:53 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     kvalo@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com
Cc:     Su Hui <suhui@nfschina.com>, briannorris@chromium.org,
        lukas@wunner.de, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mwifiex: remove some useless code
Date:   Wed, 15 Nov 2023 17:23:29 +0800
Message-Id: <20231115092328.1048103-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang static analyzer complains that value stored to 'priv' is never read.
'priv' is useless, so remove it to save space.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 3756aa247e77..9eff29a25544 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -1244,8 +1244,6 @@ mwifiex_process_sleep_confirm_resp(struct mwifiex_adapter *adapter,
 				   u8 *pbuf, u32 upld_len)
 {
 	struct host_cmd_ds_command *cmd = (struct host_cmd_ds_command *) pbuf;
-	struct mwifiex_private *priv =
-		mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
 	uint16_t result = le16_to_cpu(cmd->result);
 	uint16_t command = le16_to_cpu(cmd->command);
 	uint16_t seq_num = le16_to_cpu(cmd->seq_num);
@@ -1260,12 +1258,6 @@ mwifiex_process_sleep_confirm_resp(struct mwifiex_adapter *adapter,
 		    "cmd: CMD_RESP: 0x%x, result %d, len %d, seqno 0x%x\n",
 		    command, result, le16_to_cpu(cmd->size), seq_num);
 
-	/* Get BSS number and corresponding priv */
-	priv = mwifiex_get_priv_by_id(adapter, HostCmd_GET_BSS_NO(seq_num),
-				      HostCmd_GET_BSS_TYPE(seq_num));
-	if (!priv)
-		priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-
 	/* Update sequence number */
 	seq_num = HostCmd_GET_SEQ_NO(seq_num);
 	/* Clear RET_BIT from HostCmd */
-- 
2.30.2

