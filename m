Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EEE7824A1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjHUHkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjHUHkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:40:00 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CF735D7;
        Mon, 21 Aug 2023 00:39:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id AED8C6062130A;
        Mon, 21 Aug 2023 15:39:37 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     Hawking.Zhang@amd.com, le.ma@amd.com, lijo.lazar@amd.com,
        yifan1.zhang@amd.com, candice.li@amd.com, guchun.chen@amd.com,
        Yuliang.Shi@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        Su Hui <suhui@nfschina.com>
Subject: [PATCH v2] drm/amdgpu: Avoid possible buffer overflow
Date:   Mon, 21 Aug 2023 15:37:28 +0800
Message-Id: <20230821073727.225341-1-suhui@nfschina.com>
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

smatch error:
drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1257 amdgpu_discovery_reg_base_init() error:
testing array offset 'adev->vcn.num_vcn_inst' after use.

change the assignment order to avoid buffer overflow.

Fixes: c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
changes in v2:
 - fix the error about ip->revision (thanks to Christophe JAILLET).
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8e1cfc87122d..b07bfd106a9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1250,11 +1250,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 *     0b10 : encode is disabled
 				 *     0b01 : decode is disabled
 				 */
-				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
-					ip->revision & 0xc0;
-				ip->revision &= ~0xc0;
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
+					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
 						(1U << ip->instance_number);
@@ -1265,6 +1264,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
 				}
+				ip->revision &= ~0xc0;
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
-- 
2.30.2

