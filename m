Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300EF76E08F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbjHCGyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjHCGy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:54:28 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB3F1B2;
        Wed,  2 Aug 2023 23:54:24 -0700 (PDT)
X-UUID: 2769ce3df91a4798816c751763bf786a-20230803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:9f3df742-4fdc-4895-9502-8cb6f04badb1,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.28,REQID:9f3df742-4fdc-4895-9502-8cb6f04badb1,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:176cd25,CLOUDID:eb21a3d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230803145414YEBCW1HE,BulkQuantity:0,Recheck:0,SF:19|44|24|17|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 2769ce3df91a4798816c751763bf786a-20230803
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(111.48.58.12)] by mailgw
        (envelope-from <oushixiong@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 829056476; Thu, 03 Aug 2023 14:54:12 +0800
From:   oushixiong <oushixiong@kylinos.cn>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: [PATCH v4] tty: vt: Remove some repetitive initialization
Date:   Thu,  3 Aug 2023 14:54:09 +0800
Message-Id: <20230803065409.461031-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Members vc_col, vc_rows and vc_size_row of the struct vc_data have been
initialized in visual_init(), so it is no longer needed to initialize
them in vc_init() again.

Signed-off-by: oushixiong <oushixiong@kylinos.cn>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
v1->v2:
    - Fix the comment.
v2->v3:
    - Fix the comment again.
v3->v4:
    - Fix the comment one more time.

 drivers/tty/vt/vt.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 1e8e57b45688..cf77011a8f4e 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -140,8 +140,7 @@ EXPORT_SYMBOL(vc_cons);
 static const struct consw *con_driver_map[MAX_NR_CONSOLES];
 
 static int con_open(struct tty_struct *, struct file *);
-static void vc_init(struct vc_data *vc, unsigned int rows,
-		    unsigned int cols, int do_clear);
+static void vc_init(struct vc_data *vc, int do_clear);
 static void gotoxy(struct vc_data *vc, int new_x, int new_y);
 static void save_cur(struct vc_data *vc);
 static void reset_terminal(struct vc_data *vc, int do_clear);
@@ -1103,7 +1102,7 @@ int vc_allocate(unsigned int currcons)	/* return 0 on success */
 	if (global_cursor_default == -1)
 		global_cursor_default = 1;
 
-	vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
+	vc_init(vc, 1);
 	vcs_make_sysfs(currcons);
 	atomic_notifier_call_chain(&vt_notifier_list, VT_ALLOCATE, &param);
 
@@ -3398,16 +3397,10 @@ module_param_named(color, default_color, int, S_IRUGO | S_IWUSR);
 module_param_named(italic, default_italic_color, int, S_IRUGO | S_IWUSR);
 module_param_named(underline, default_underline_color, int, S_IRUGO | S_IWUSR);
 
-static void vc_init(struct vc_data *vc, unsigned int rows,
-		    unsigned int cols, int do_clear)
+static void vc_init(struct vc_data *vc, int do_clear)
 {
 	int j, k ;
 
-	vc->vc_cols = cols;
-	vc->vc_rows = rows;
-	vc->vc_size_row = cols << 1;
-	vc->vc_screenbuf_size = vc->vc_rows * vc->vc_size_row;
-
 	set_origin(vc);
 	vc->vc_pos = vc->vc_origin;
 	reset_vc(vc);
@@ -3475,8 +3468,7 @@ static int __init con_init(void)
 		visual_init(vc, currcons, 1);
 		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
 		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
-		vc_init(vc, vc->vc_rows, vc->vc_cols,
-			currcons || !vc->vc_sw->con_save_screen);
+		vc_init(vc, currcons || !vc->vc_sw->con_save_screen);
 	}
 	currcons = fg_console = 0;
 	master_display_fg = vc = vc_cons[currcons].d;
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
