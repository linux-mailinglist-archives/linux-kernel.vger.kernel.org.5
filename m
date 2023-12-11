Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E725180CBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjLKNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKNw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2918B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8479C433C7;
        Mon, 11 Dec 2023 13:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302764;
        bh=Z4zFiJy8nVOqQvwvU48WTvdbUM9MltSNX1w9qcMnUeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3MOLufTBcFy5IJPKYIEmGGxlqaX+f8/BbOD7N/vEMotV90qbFIi05sVDkUOpai/5
         FbMDMongn800zVzXonIvOfBvqxHPDar1oV6T2WtSNVgyxNYn8hTcFcz+ov7pS4BzRn
         5wsoXYiKH83svg+RPWoZvYDQDew6IJLh7pOAmr1LCOJwPjFr3XITu2K8BpUTUCSw0Y
         PcO3G733rgdNBJGEqiS9Gt33a3shHXbqa3NmH5bfw+X3Uh5TiDJxNxcuThpcwlYwK0
         YfenhsG2/8+SL2vNAX9kYH6pWlmEJBaPwr5VPJm1lnLU5smyZ4a/7ymiq6Ej5o072c
         MOztx7w5BTksQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Airlie <airlied@redhat.com>,
        Danilo Krummrich <dakr@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kherbst@redhat.com,
        lyude@redhat.com, airlied@gmail.com, daniel@ffwll.ch,
        bskeggs@redhat.com, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 19/47] nouveau/tu102: flush all pdbs on vmm flush
Date:   Mon, 11 Dec 2023 08:50:20 -0500
Message-ID: <20231211135147.380223-19-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit cb9c919364653eeafb49e7ff5cd32f1ad64063ac ]

This is a hack around a bug exposed with the GSP code, I'm not sure
what is happening exactly, but it appears some of our flushes don't
result in proper tlb invalidation for out BAR2 and we get a BAR2
fault from GSP and it all dies.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231130010852.4034774-1-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
index 6cb5eefa45e9a..5a08458fe1b7f 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c
@@ -31,7 +31,7 @@ tu102_vmm_flush(struct nvkm_vmm *vmm, int depth)
 
 	type |= 0x00000001; /* PAGE_ALL */
 	if (atomic_read(&vmm->engref[NVKM_SUBDEV_BAR]))
-		type |= 0x00000004; /* HUB_ONLY */
+		type |= 0x00000006; /* HUB_ONLY | ALL PDB (hack) */
 
 	mutex_lock(&vmm->mmu->mutex);
 
-- 
2.42.0

