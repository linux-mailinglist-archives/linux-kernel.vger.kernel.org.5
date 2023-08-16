Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E29777E822
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345351AbjHPSDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345347AbjHPSDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:03:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B9210C0;
        Wed, 16 Aug 2023 11:03:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F20961F66;
        Wed, 16 Aug 2023 18:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1956C433C8;
        Wed, 16 Aug 2023 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692208985;
        bh=VZCc7I2wrs8o5Tj4LQsDy02WJ+lFyAmZfvikJnnhvOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URUt50Lpu68AZjwzUK65AbwaSQMzaypOHt0B77/aYMGDuEvcrVRbCP1+MjGsLnBHW
         rzrOzJrT2weHVZqP8tm26Qd/4bIXcDmqiLZe2hrRijXVql6cwBrIIxUpsDXz+dsYBU
         5cJb3E4/oK2SuTx8o3zmWvchiZHqLyzyjoUBoyqpT4o7hasfl+FkU2RbrdNKyzAWHT
         BWUtyLZzYstMWrB4xb2TRrxtWrtYkZ1QmyYJ3V6IEfpn9q5NdHvLA4XjO8PCcUJjdU
         XPzFthtDC41qhifOl7rC0jhRrqL78Asq6GZcISPt9FnNQ8K1q8OoJzfpauWfxnX3CV
         EBYQGtj5L6+lg==
Date:   Wed, 16 Aug 2023 12:04:06 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/2][next] nouveau/svm: Replace one-element array with
 flexible-array member in struct nouveau_svm
Message-ID: <087a1c335228bd245192bbb2fb347c9af1be5750.1692208802.git.gustavoars@kernel.org>
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

One-element and zero-length arrays are deprecated. So, replace
one-element array in struct nouveau_svm with flexible-array member.

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/338
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 186351ecf72f..00444ad82d18 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -67,7 +67,7 @@ struct nouveau_svm {
 			struct nouveau_svmm *svmm;
 		} **fault;
 		int fault_nr;
-	} buffer[1];
+	} buffer[];
 };
 
 #define FAULT_ACCESS_READ 0
@@ -1063,7 +1063,7 @@ nouveau_svm_init(struct nouveau_drm *drm)
 	if (drm->client.device.info.family > NV_DEVICE_INFO_V0_PASCAL)
 		return;
 
-	if (!(drm->svm = svm = kzalloc(sizeof(*drm->svm), GFP_KERNEL)))
+	if (!(drm->svm = svm = kzalloc(struct_size(drm->svm, buffer, 1), GFP_KERNEL)))
 		return;
 
 	drm->svm->drm = drm;
-- 
2.34.1

