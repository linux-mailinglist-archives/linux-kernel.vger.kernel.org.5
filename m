Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DD37DFE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 03:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjKCCd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 22:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjKCCdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 22:33:23 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A661A3;
        Thu,  2 Nov 2023 19:33:15 -0700 (PDT)
X-UUID: a1b81360ae14479ebb8ae7d3bb98ee0b-20231103
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:6ab78e64-c05c-4841-bd7d-646fd518aa52,IP:10,
        URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:-10
X-CID-INFO: VERSION:1.1.32,REQID:6ab78e64-c05c-4841-bd7d-646fd518aa52,IP:10,UR
        L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-META: VersionHash:5f78ec9,CLOUDID:38acf594-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231103103311LO8N2NZS,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULS
X-UUID: a1b81360ae14479ebb8ae7d3bb98ee0b-20231103
X-User: chentao@kylinos.cn
Received: from vt.. [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 885977007; Fri, 03 Nov 2023 10:33:08 +0800
From:   Kunwu Chan <chentao@kylinos.cn>
To:     tvrtko.ursulin@linux.intel.com
Cc:     airlied@gmail.com, alan.previn.teres.alexis@intel.com,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        chentao@kylinos.cn, chris.p.wilson@intel.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jonathan.cavitt@intel.com,
        joonas.lahtinen@linux.intel.com, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, robdclark@chromium.org,
        rodrigo.vivi@intel.com, stable@vger.kernel.org
Subject: [PATCH v2] drm/i915: Fix potential spectre vulnerability
Date:   Fri,  3 Nov 2023 10:32:57 +0800
Message-Id: <20231103023257.58199-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
References: <d300506c-ab82-4cc1-b750-61e54ec2ad9e@linux.intel.com>
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

Fix smatch warning:
drivers/gpu/drm/i915/gem/i915_gem_context.c:847 set_proto_ctx_sseu()
warn: potential spectre issue 'pc->user_engines' [r] (local cap)

Fixes: d4433c7600f7 ("drm/i915/gem: Use the proto-context to handle create parameters (v5)")
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Link: https://lore.kernel.org/all/20231102101642.52988-1-chentao@kylinos.cn
---
 drivers/gpu/drm/i915/gem/i915_gem_context.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_context.c b/drivers/gpu/drm/i915/gem/i915_gem_context.c
index 9a9ff84c90d7..e38f06a6e56e 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_context.c
@@ -844,6 +844,7 @@ static int set_proto_ctx_sseu(struct drm_i915_file_private *fpriv,
 		if (idx >= pc->num_user_engines)
 			return -EINVAL;
 
+		idx = array_index_nospec(idx, pc->num_user_engines);
 		pe = &pc->user_engines[idx];
 
 		/* Only render engine supports RPCS configuration. */
-- 
2.34.1

