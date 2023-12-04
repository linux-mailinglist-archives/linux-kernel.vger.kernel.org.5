Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FD78029F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 02:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbjLDBpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 20:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 20:45:08 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B659DF;
        Sun,  3 Dec 2023 17:45:12 -0800 (PST)
X-UUID: ee64416ed39e48bc895f2e239b83a94d-20231204
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:da4c46b1-07fa-4654-b582-41546c64ad46,IP:15,
        URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
        TION:release,TS:-25
X-CID-INFO: VERSION:1.1.33,REQID:da4c46b1-07fa-4654-b582-41546c64ad46,IP:15,UR
        L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-25
X-CID-META: VersionHash:364b77b,CLOUDID:b2281a96-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231204094504NWR6GREY,BulkQuantity:0,Recheck:0,SF:44|66|38|24|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: ee64416ed39e48bc895f2e239b83a94d-20231204
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1135152479; Mon, 04 Dec 2023 09:45:01 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jeffrey.t.kirsher@intel.com,
        shannon.nelson@amd.com
Cc:     kunwu.chan@hotmail.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunwu Chan <chentao@kylinos.cn>,
        Simon Horman <horms@kernel.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH v3 iwl-next] i40e: Use correct buffer size in i40e_dbg_command_read
Date:   Mon,  4 Dec 2023 09:44:55 +0800
Message-Id: <20231204014455.2444734-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of "i40e_dbg_command_buf" is 256, the size of "name"
depends on "IFNAMSIZ", plus a null character and format size,
the total size is more than 256.

Improve readability and maintainability by replacing a hardcoded string
allocation and formatting by the use of the kasprintf() helper.

Fixes: 02e9c290814c ("i40e: debugfs interface")
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Simon Horman <horms@kernel.org>
Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2
   - Update the size calculation with IFNAMSIZ and sizeof(i40e_dbg_command_buf)
v3
   - Use kasprintf to improve readability and maintainability
---
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index 88240571721a..a176de89de9c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -72,23 +72,22 @@ static ssize_t i40e_dbg_command_read(struct file *filp, char __user *buffer,
 {
 	struct i40e_pf *pf = filp->private_data;
 	int bytes_not_copied;
-	int buf_size = 256;
-	char *buf;
+	char *buf = NULL;
 	int len;
 
 	/* don't allow partial reads */
 	if (*ppos != 0)
 		return 0;
-	if (count < buf_size)
-		return -ENOSPC;
 
-	buf = kzalloc(buf_size, GFP_KERNEL);
+	buf = kasprintf(GFP_KERNEL, "%s: %s\n",
+			pf->vsi[pf->lan_vsi]->netdev->name,
+			i40e_dbg_command_buf);
 	if (!buf)
 		return -ENOSPC;
 
-	len = snprintf(buf, buf_size, "%s: %s\n",
-		       pf->vsi[pf->lan_vsi]->netdev->name,
-		       i40e_dbg_command_buf);
+	len = strlen(buf);
+	if (count < len)
+		return -ENOSPC;
 
 	bytes_not_copied = copy_to_user(buffer, buf, len);
 	kfree(buf);
-- 
2.34.1

