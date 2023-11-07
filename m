Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88467E3E02
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjKGMcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjKGMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:32:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4938032B56;
        Tue,  7 Nov 2023 04:21:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A3C433C9;
        Tue,  7 Nov 2023 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359673;
        bh=zRLYVJzEmMHhUfyTzu7p4rra2CVJwPd4o1lufCaMcWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YlwHoh4WMeqOKBDjLEZN7VGsuee58puePyVkjR1RZfWQG8EYqVluzcCUwKxjtd65Y
         2iSDMbB+53wwCabxGgui/gaoaydnd+v1vXNFdyCIyk05YJVxaZViSJtPdc2X5ByC+9
         b0+bQoJqaJ1og5udGKHzZ6fXx5pcB836b4BVmkjcEkpOuvE4DP9Nb4eYyE+J+Rqnaf
         g68hymVqYr/34H1T1naiYkGOK9sp/pXJL4wBwGNT2lJo5E6XZfIr6O7YnJpYgbNXYJ
         QM82QTPcipe9xiuLpZuZ0Du4W9MOlY0uyLoGlFe0dkElF9iprCb6XvE6YJtT2YpQix
         vO5q6xUlPNyrw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Lin.Cao" <lincao12@amd.com>, Jingwen Chen <Jingwen.Chen2@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, evan.quan@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, lijo.lazar@amd.com, mario.limonciello@amd.com,
        Hawking.Zhang@amd.com, guchun.chen@amd.com, Lyndon.Li@amd.com,
        bokun.zhang@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 33/40] drm/amd: check num of link levels when update pcie param
Date:   Tue,  7 Nov 2023 07:16:35 -0500
Message-ID: <20231107121837.3759358-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121837.3759358-1-sashal@kernel.org>
References: <20231107121837.3759358-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lin.Cao" <lincao12@amd.com>

[ Upstream commit 406e8845356d18bdf3d3a23b347faf67706472ec ]

In SR-IOV environment, the value of pcie_table->num_of_link_levels will
be 0, and num_of_levels - 1 will cause array index out of bounds

Signed-off-by: Lin.Cao <lincao12@amd.com>
Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 4aeb84572e5b8..5355f621388bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2430,6 +2430,9 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 	uint32_t smu_pcie_arg;
 	int ret, i;
 
+	if (!num_of_levels)
+		return 0;
+
 	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
 		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
 			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
-- 
2.42.0

