Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5C7765E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjG0Vwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbjG0Vwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:52:37 -0400
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21BF2D7D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494752; bh=EKT0P4uKrlnLCWiETQ0sfCoQQG3MVyK9PAIfabQ3Emk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=d/MlOAXS/mEyU3KCJwIW33yeUvH+eZuVBK2BS5PL9BSyLuQ12XTllK9CghVqlBTlp
         Q0VvyFFfoTCgE1W35W7HZVNDORG3ZtOKnZWj7gadC9RtUHaKYvY8tPrUOewIIJNabK
         XSjxXnnpsfIAcn0u45WKcJNjgFMrN4S1rd1c3WG6zgm6b1kpvd5TGlHNZN2bVfuYQX
         s0LbGQwsMfKbK+RMlPhVwbi4W5Zdhzgo1RI5kTN3R3JlvmUZnGzfG6QS1/+3I95qfx
         zgpiBqauUHy9l+egeTqnGtJjKdIHv68WzhhdcgedaJOIrlzgsOS8WqR2Mi8tiO7886
         QAl2LYw912jLA==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id 79C2A168029B;
        Thu, 27 Jul 2023 21:52:31 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alain Volmat <avolmat@me.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] drm/sti: add STih418 platform support in sti mixer
Date:   Thu, 27 Jul 2023 21:51:28 +0000
Message-Id: <20230727215141.53910-5-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PvSYlyyofV4n7uFJ2g7UV5nGOgilZbu_
X-Proofpoint-GUID: PvSYlyyofV4n7uFJ2g7UV5nGOgilZbu_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the STiH418, since there are more planes attached to the
mixer, the bit field for each depth of is now coded using 4 bits
instead of 3 bits.  Some registers as well differ between STiH407
and STiH418 leading on relying on the st,stih418-compositor compatible
to distinguish proper behavior.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/gpu/drm/sti/sti_mixer.c | 71 ++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
index 7e5f14646625..9cd780403d7b 100644
--- a/drivers/gpu/drm/sti/sti_mixer.c
+++ b/drivers/gpu/drm/sti/sti_mixer.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/seq_file.h>
 
 #include <drm/drm_print.h>
@@ -23,10 +24,12 @@ module_param_named(bkgcolor, bkg_color, int, 0644);
 /* regs offset */
 #define GAM_MIXER_CTL      0x00
 #define GAM_MIXER_BKC      0x04
+#define GAM_MIXER_OFF	   0x08 /* Only for STiH418 */
 #define GAM_MIXER_BCO      0x0C
 #define GAM_MIXER_BCS      0x10
 #define GAM_MIXER_AVO      0x28
 #define GAM_MIXER_AVS      0x2C
+#define GAM_MIXER_CRB2     0x30 /* Only for STiH418 */
 #define GAM_MIXER_CRB      0x34
 #define GAM_MIXER_ACT      0x38
 #define GAM_MIXER_MBP      0x3C
@@ -102,13 +105,22 @@ static void mixer_dbg_ctl(struct seq_file *s, int val)
 		seq_puts(s, "Nothing");
 }
 
-static void mixer_dbg_crb(struct seq_file *s, int val)
+static void mixer_dbg_crb(struct seq_file *s, struct sti_mixer *mixer, u64 val)
 {
 	int i;
+	u32 shift, mask_id;
+
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor")) {
+		shift = 4;
+		mask_id = 0x0f;
+	} else {
+		shift = 3;
+		mask_id = 0x07;
+	}
 
 	seq_puts(s, "\tDepth: ");
 	for (i = 0; i < GAM_MIXER_NB_DEPTH_LEVEL; i++) {
-		switch (val & GAM_DEPTH_MASK_ID) {
+		switch (val & mask_id) {
 		case GAM_DEPTH_VID0_ID:
 			seq_puts(s, "VID0");
 			break;
@@ -133,7 +145,7 @@ static void mixer_dbg_crb(struct seq_file *s, int val)
 
 		if (i < GAM_MIXER_NB_DEPTH_LEVEL - 1)
 			seq_puts(s, " < ");
-		val = val >> 3;
+		val = val >> shift;
 	}
 }
 
@@ -149,6 +161,7 @@ static int mixer_dbg_show(struct seq_file *s, void *arg)
 {
 	struct drm_info_node *node = s->private;
 	struct sti_mixer *mixer = (struct sti_mixer *)node->info_ent->data;
+	u64 val;
 
 	seq_printf(s, "%s: (vaddr = 0x%p)",
 		   sti_mixer_to_str(mixer), mixer->regs);
@@ -161,11 +174,18 @@ static int mixer_dbg_show(struct seq_file *s, void *arg)
 	DBGFS_DUMP(GAM_MIXER_AVO);
 	DBGFS_DUMP(GAM_MIXER_AVS);
 	DBGFS_DUMP(GAM_MIXER_CRB);
-	mixer_dbg_crb(s, sti_mixer_reg_read(mixer, GAM_MIXER_CRB));
+	val = sti_mixer_reg_read(mixer, GAM_MIXER_CRB);
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor")) {
+		DBGFS_DUMP(GAM_MIXER_CRB2);
+		val |= ((u64)sti_mixer_reg_read(mixer, GAM_MIXER_CRB2) << 32);
+	}
+	mixer_dbg_crb(s, mixer, val);
 	DBGFS_DUMP(GAM_MIXER_ACT);
-	DBGFS_DUMP(GAM_MIXER_MBP);
-	DBGFS_DUMP(GAM_MIXER_MX0);
-	mixer_dbg_mxn(s, mixer->regs + GAM_MIXER_MX0);
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih407-compositor")) {
+		DBGFS_DUMP(GAM_MIXER_MBP);
+		DBGFS_DUMP(GAM_MIXER_MX0);
+		mixer_dbg_mxn(s, mixer->regs + GAM_MIXER_MX0);
+	}
 	seq_putc(s, '\n');
 	return 0;
 }
@@ -238,7 +258,16 @@ int sti_mixer_set_plane_depth(struct sti_mixer *mixer, struct sti_plane *plane)
 {
 	int plane_id, depth = plane->drm_plane.state->normalized_zpos;
 	unsigned int i;
-	u32 mask, val;
+	u64 mask, val;
+	u32 shift, mask_id;
+
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor")) {
+		shift = 4;
+		mask_id = 0x0f;
+	} else {
+		shift = 3;
+		mask_id = 0x07;
+	}
 
 	switch (plane->desc) {
 	case STI_GDP_0:
@@ -266,26 +295,37 @@ int sti_mixer_set_plane_depth(struct sti_mixer *mixer, struct sti_plane *plane)
 
 	/* Search if a previous depth was already assigned to the plane */
 	val = sti_mixer_reg_read(mixer, GAM_MIXER_CRB);
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor"))
+		val |= ((u64)sti_mixer_reg_read(mixer, GAM_MIXER_CRB2) << 32);
 	for (i = 0; i < GAM_MIXER_NB_DEPTH_LEVEL; i++) {
-		mask = GAM_DEPTH_MASK_ID << (3 * i);
-		if ((val & mask) == plane_id << (3 * i))
+		mask = mask_id << (shift * i);
+		if ((val & mask) == plane_id << (shift * i))
 			break;
 	}
 
-	mask |= GAM_DEPTH_MASK_ID << (3 * depth);
-	plane_id = plane_id << (3 * depth);
+	mask |= mask_id << (shift * depth);
+	plane_id = plane_id << (shift * depth);
 
 	DRM_DEBUG_DRIVER("%s %s depth=%d\n", sti_mixer_to_str(mixer),
 			 sti_plane_to_str(plane), depth);
 	dev_dbg(mixer->dev, "GAM_MIXER_CRB val 0x%x mask 0x%x\n",
-		plane_id, mask);
+		plane_id, (u32)(mask & 0xffffffff));
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor"))
+		dev_dbg(mixer->dev, "GAM_MIXER_CRB2 val 0x%x mask 0x%x\n",
+			plane_id, (u32)(mask >> 32));
 
 	val &= ~mask;
 	val |= plane_id;
-	sti_mixer_reg_write(mixer, GAM_MIXER_CRB, val);
+	sti_mixer_reg_write(mixer, GAM_MIXER_CRB, val & 0xffffffff);
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor"))
+		sti_mixer_reg_write(mixer, GAM_MIXER_CRB2, val >> 32);
 
 	dev_dbg(mixer->dev, "Read GAM_MIXER_CRB 0x%x\n",
 		sti_mixer_reg_read(mixer, GAM_MIXER_CRB));
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor"))
+		dev_dbg(mixer->dev, "Read GAM_MIXER_CRB2 0x%x\n",
+			sti_mixer_reg_read(mixer, GAM_MIXER_CRB2));
+
 	return 0;
 }
 
@@ -352,6 +392,9 @@ int sti_mixer_set_plane_status(struct sti_mixer *mixer,
 	val |= status ? mask : 0;
 	sti_mixer_reg_write(mixer, GAM_MIXER_CTL, val);
 
+	if (of_device_is_compatible(mixer->dev->of_node, "st,stih418-compositor"))
+		sti_mixer_reg_write(mixer, GAM_MIXER_OFF, 0x02);
+
 	return 0;
 }
 
-- 
2.34.1

