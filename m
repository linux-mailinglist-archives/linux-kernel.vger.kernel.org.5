Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABC27C5250
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbjJKLm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjJKLm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5DB93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697024502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8NURkiBAbS6tTinRtwOYWNtz0h6Ztp9Eip3YWpE10Qw=;
        b=hOhsWj2UJGXAa8xc/AbVDHgtCTo+ai5J1hPgnth5hNOvaWRs576Z2/wZ6gIIiPr8/GJaGD
        UAWOcF+lMa2tfFu//51CTc5ZAProKv2Cb1HMGLsN+udxmgvQSGAjesFRTZTohZenp1uWEx
        L9+cehk0BZpS1OdbIfAcd/kWfjh8vus=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-cu3LQ3BIMxasUrJMpzF7gw-1; Wed, 11 Oct 2023 07:41:41 -0400
X-MC-Unique: cu3LQ3BIMxasUrJMpzF7gw-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-41b19426eedso9803361cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697024500; x=1697629300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NURkiBAbS6tTinRtwOYWNtz0h6Ztp9Eip3YWpE10Qw=;
        b=rvX9iU8VBsT3UPu5KmVEQncK+gm8Zvu4TCXGReDrqgfNscv3bi/aOWSsy9Cg5jZqDU
         eboeirOMl4TmWAc4ZsCtxLIufOr3WMiszNi87ufQ2Mubs2VCU6N3/WrKBTQcAOvQNdFT
         /vYf0w4L+r4QI5+sPU5sRm4D9Pn5UgHN4kG7X9ZSqazD5pGnxQYJ/ekBvmxv28iNpD1y
         yUmTd303+eBsxMK3DuaEj2hgBJtN+0m5aP5mxI02FkEzck2Gw+ygUvxNOPMS+eONwfaR
         slzPYzXcYu30wHGadVY4zyoV3a/CNYCG0GcVi0mwqWlGdZObMuiuPJpQ5VNwl4lwot3j
         DqFg==
X-Gm-Message-State: AOJu0YxPVo6Yup7p3C+s2DQCPhKHMRKviBNlbeRMuw+z7uuiClneXPXe
        K6wOdLVpBvSYcGfH9b58oK4H2YpljwVB8k1xU3aVpgyMvePUuTamvvlL4VW1nZPJBVaQjdHqcTd
        ABfLZgtoww7dXLg8IT74C3apOuIHRVowMpVaJBk/ghO27SJecr66LG0LPp+ta2jcWXoPgIF0pKm
        RxonwGB4k=
X-Received: by 2002:a05:6214:c6a:b0:65a:fd40:b79 with SMTP id t10-20020a0562140c6a00b0065afd400b79mr23067475qvj.5.1697024500136;
        Wed, 11 Oct 2023 04:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/PJFqEzyZ8u0zaKxnpGRj7gcP1T2JeVyTubg38E45fbagYfNnX/UGlmnBkSjQ63uUN62XNg==
X-Received: by 2002:a05:6214:c6a:b0:65a:fd40:b79 with SMTP id t10-20020a0562140c6a00b0065afd400b79mr23067452qvj.5.1697024499781;
        Wed, 11 Oct 2023 04:41:39 -0700 (PDT)
Received: from kherbst.pingu.com ([178.24.169.250])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a136100b00774309d3e89sm5153179qkl.7.2023.10.11.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 04:41:38 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Karol Herbst <kherbst@redhat.com>,
        stable@vger.kernel.org
Subject: [PATCH] drm/nouveau/disp: fix DP capable DSM connectors
Date:   Wed, 11 Oct 2023 13:41:34 +0200
Message-ID: <20231011114134.861818-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just special case DP DSM connectors until we properly figure out how to
deal with this.

This resolves user regressions on GPUs with such connectors without
reverting the original fix.

Cc: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org # 6.4+
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/255
Fixes: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not PMGR AUX interrupts")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
index 46b057fe1412e..3249e5c1c8930 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uconn.c
@@ -62,6 +62,18 @@ nvkm_uconn_uevent_gpio(struct nvkm_object *object, u64 token, u32 bits)
 	return object->client->event(token, &args, sizeof(args.v0));
 }
 
+static bool
+nvkm_connector_is_dp_dms(u8 type)
+{
+	switch (type) {
+	case DCB_CONNECTOR_DMS59_DP0:
+	case DCB_CONNECTOR_DMS59_DP1:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int
 nvkm_uconn_uevent(struct nvkm_object *object, void *argv, u32 argc, struct nvkm_uevent *uevent)
 {
@@ -101,7 +113,7 @@ nvkm_uconn_uevent(struct nvkm_object *object, void *argv, u32 argc, struct nvkm_
 	if (args->v0.types & NVIF_CONN_EVENT_V0_UNPLUG) bits |= NVKM_GPIO_LO;
 	if (args->v0.types & NVIF_CONN_EVENT_V0_IRQ) {
 		/* TODO: support DP IRQ on ANX9805 and remove this hack. */
-		if (!outp->info.location)
+		if (!outp->info.location && !nvkm_connector_is_dp_dms(conn->info.type))
 			return -EINVAL;
 	}
 
-- 
2.41.0

