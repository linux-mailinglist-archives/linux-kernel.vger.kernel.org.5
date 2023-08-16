Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B317377E829
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbjHPSEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345401AbjHPSEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:04:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3FE10C0;
        Wed, 16 Aug 2023 11:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3E762E25;
        Wed, 16 Aug 2023 18:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FB9C433C8;
        Wed, 16 Aug 2023 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692209045;
        bh=VIZplUQWDEfLgSE4zA0pe93EPJ0XYGhoZfQF7z/VLtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjvIipi7hME4kMUUM9gbC7AP8Oud5NAyZstGoIaGq46r1E725MsBb8ZJe17xQUcVg
         8iZ8mgVgf2CHcT2E5o5DG0HitZiK1rdtbqHjfBpT+N/NBnj668l4vXaqc/udxBHWwt
         XvfkN3mArqgwbtwNVzX08QayJjDbaal2EpRJhFBLJJf+NPHprpfMkFxm9R4SZV8V81
         zGZ6TKPlyIp+MkEaxT8VTOQU3b7pUxsluRp87BPVTo+m9/x3ulrUucAZfB9aHMmrRg
         vIHupO4thIkfzft0S1KShhglVzK1F7MqhJotjQM7N4E8sVNKi6TEMYYt2j6Gda4nvb
         w4HRE/I1vIpXw==
Date:   Wed, 16 Aug 2023 12:05:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2][next] nouveau/svm: Split assignment from if conditional
Message-ID: <6b900e80b5587187c68efc788f5b042ca747d374.1692208802.git.gustavoars@kernel.org>
References: <cover.1692208802.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692208802.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl ERROR: do not use assignment in if condition.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 00444ad82d18..cc03e0c22ff3 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -1063,7 +1063,8 @@ nouveau_svm_init(struct nouveau_drm *drm)
 	if (drm->client.device.info.family > NV_DEVICE_INFO_V0_PASCAL)
 		return;
 
-	if (!(drm->svm = svm = kzalloc(struct_size(drm->svm, buffer, 1), GFP_KERNEL)))
+	drm->svm = svm = kzalloc(struct_size(drm->svm, buffer, 1), GFP_KERNEL);
+	if (!drm->svm)
 		return;
 
 	drm->svm->drm = drm;
-- 
2.34.1

