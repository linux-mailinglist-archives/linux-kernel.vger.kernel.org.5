Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8EF7A6E56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjISWIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjISWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC94185
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695161203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t78KfXKberB7LCTSOilNAgD6u/R5o5hHWWl/DfBmcQE=;
        b=al0GDVEXme7feCpC/XhqcYBiGqn2s8p2RbUREoxe7w9F3n/Bzza8o60UWP/ViRNpNrnoyv
        WOhdSqtRObdXb2TXZmxBpm3U3qgKRWU5xwALXhwuIpNSRKjOUSDm1QhNzPbn6Q+db2KzUS
        h7pWbxVdEjZFQG2ylsUbxEcxjeoVtVM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-IdMc3jmMN4OjMMAdLbzAGg-1; Tue, 19 Sep 2023 18:06:41 -0400
X-MC-Unique: IdMc3jmMN4OjMMAdLbzAGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21865185A790;
        Tue, 19 Sep 2023 22:06:41 +0000 (UTC)
Received: from emerald.lyude.net (unknown [10.22.18.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8E5F40C2064;
        Tue, 19 Sep 2023 22:06:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Danilo Krummrich <me@dakr.org>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 24/44] drm/nouveau/disp: add output lvds config method
Date:   Tue, 19 Sep 2023 17:56:19 -0400
Message-ID: <20230919220442.202488-25-lyude@redhat.com>
In-Reply-To: <20230919220442.202488-1-lyude@redhat.com>
References: <20230919220442.202488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

- was previously part of acquire()

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Acked-by: Danilo Krummrich <me@dakr.org>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c          |  2 +-
 drivers/gpu/drm/nouveau/include/nvif/if0012.h    | 16 ++++++++++------
 drivers/gpu/drm/nouveau/include/nvif/outp.h      |  3 ++-
 drivers/gpu/drm/nouveau/nvif/outp.c              | 15 +++++++--------
 drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 14 ++++++++------
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 50a0ff304291e..11b11284a3218 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1665,7 +1665,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_state *sta
 				lvds_8bpc = true;
 		}
 
-		nvif_outp_acquire_lvds(&nv_encoder->outp, lvds_dual, lvds_8bpc);
+		nvif_outp_lvds(&nv_encoder->outp, lvds_dual, lvds_8bpc);
 		break;
 	case DCB_OUTPUT_DP:
 		nvif_outp_acquire_dp(&nv_encoder->outp, nv_encoder->dp.dpcd, 0, 0, hda, false);
diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
index f878784593b43..ee4cec541a90e 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
@@ -24,6 +24,8 @@ union nvif_outp_args {
 #define NVIF_OUTP_V0_BL_GET        0x30
 #define NVIF_OUTP_V0_BL_SET        0x31
 
+#define NVIF_OUTP_V0_LVDS          0x40
+
 #define NVIF_OUTP_V0_HDMI          0x50
 
 #define NVIF_OUTP_V0_INFOFRAME     0x60
@@ -67,7 +69,6 @@ union nvif_outp_acquire_args {
 #define NVIF_OUTP_ACQUIRE_V0_DAC  0x00
 #define NVIF_OUTP_ACQUIRE_V0_SOR  0x01
 #define NVIF_OUTP_ACQUIRE_V0_PIOR 0x02
-#define NVIF_OUTP_ACQUIRE_V0_LVDS    0x03
 #define NVIF_OUTP_ACQUIRE_V0_DP      0x04
 		__u8 type;
 		__u8 or;
@@ -77,11 +78,6 @@ union nvif_outp_acquire_args {
 			struct {
 				__u8 hda;
 			} sor;
-			struct {
-				__u8 dual;
-				__u8 bpc8;
-				__u8 pad02[6];
-			} lvds;
 			struct {
 				__u8 link_nr; /* 0 = highest possible. */
 				__u8 link_bw; /* 0 = highest possible, DP BW code otherwise. */
@@ -135,6 +131,14 @@ union nvif_outp_bl_set_args {
 	} v0;
 };
 
+union nvif_outp_lvds_args {
+	struct nvif_outp_lvds_v0 {
+		__u8  version;
+		__u8  dual;
+		__u8  bpc8;
+	} v0;
+};
+
 union nvif_outp_hdmi_args {
 	struct nvif_outp_hdmi_v0 {
 		__u8 version;
diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/drm/nouveau/include/nvif/outp.h
index ef63d22b62f84..0ddaec9416eed 100644
--- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
+++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
@@ -31,7 +31,6 @@ int nvif_outp_load_detect(struct nvif_outp *, u32 loadval);
 int nvif_outp_acquire_dac(struct nvif_outp *);
 int nvif_outp_acquire_sor(struct nvif_outp *, bool hda);
 int nvif_outp_acquire_pior(struct nvif_outp *);
-int nvif_outp_acquire_lvds(struct nvif_outp *, bool dual, bool bpc8);
 int nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_SIZE],
 			 int link_nr, int link_bw, bool hda, bool mst);
 int nvif_outp_inherit_rgb_crt(struct nvif_outp *outp, u8 *proto_out);
@@ -50,6 +49,8 @@ nvif_outp_acquired(struct nvif_outp *outp)
 int nvif_outp_bl_get(struct nvif_outp *);
 int nvif_outp_bl_set(struct nvif_outp *, int level);
 
+int nvif_outp_lvds(struct nvif_outp *, bool dual, bool bpc8);
+
 int nvif_outp_hdmi(struct nvif_outp *, int head, bool enable, u8 max_ac_packet, u8 rekey, u32 khz,
 		   bool scdc, bool scdc_scrambling, bool scdc_low_rates);
 
diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouveau/nvif/outp.c
index 5a3c0dd7d5324..dbb0986f05558 100644
--- a/drivers/gpu/drm/nouveau/nvif/outp.c
+++ b/drivers/gpu/drm/nouveau/nvif/outp.c
@@ -150,18 +150,17 @@ nvif_outp_hdmi(struct nvif_outp *outp, int head, bool enable, u8 max_ac_packet,
 }
 
 int
-nvif_outp_acquire_lvds(struct nvif_outp *outp, bool dual, bool bpc8)
+nvif_outp_lvds(struct nvif_outp *outp, bool dual, bool bpc8)
 {
-	struct nvif_outp_acquire_v0 args;
+	struct nvif_outp_lvds_v0 args;
 	int ret;
 
-	args.lvds.dual = dual;
-	args.lvds.bpc8 = bpc8;
+	args.version = 0;
+	args.dual = dual;
+	args.bpc8 = bpc8;
 
-	ret = nvif_outp_acquire(outp, NVIF_OUTP_ACQUIRE_V0_LVDS, &args);
-	NVIF_ERRON(ret, &outp->object,
-		   "[ACQUIRE proto:LVDS dual:%d 8bpc:%d] or:%d link:%d",
-		   args.lvds.dual, args.lvds.bpc8, args.or, args.link);
+	ret = nvif_mthd(&outp->object, NVIF_OUTP_V0_LVDS, &args, sizeof(args));
+	NVIF_ERRON(ret, &outp->object, "[LVDS dual:%d 8bpc:%d]", args.dual, args.bpc8);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
index c1775524919fd..ad75dc5c50cf7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
@@ -171,13 +171,17 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void *argv, u32 argc)
 }
 
 static int
-nvkm_uoutp_mthd_acquire_lvds(struct nvkm_outp *outp, bool dual, bool bpc8)
+nvkm_uoutp_mthd_lvds(struct nvkm_outp *outp, void *argv, u32 argc)
 {
+	union nvif_outp_lvds_args *args = argv;
+
+	if (argc != sizeof(args->v0) || args->v0.version != 0)
+		return -ENOSYS;
 	if (outp->info.type != DCB_OUTPUT_LVDS)
 		return -EINVAL;
 
-	outp->lvds.dual = dual;
-	outp->lvds.bpc8 = bpc8;
+	outp->lvds.dual = !!args->v0.dual;
+	outp->lvds.bpc8 = !!args->v0.bpc8;
 	return 0;
 }
 
@@ -253,9 +257,6 @@ nvkm_uoutp_mthd_acquire(struct nvkm_outp *outp, void *argv, u32 argc)
 	case NVIF_OUTP_ACQUIRE_V0_SOR:
 		ret = nvkm_outp_acquire_or(outp, NVKM_OUTP_USER, args->v0.sor.hda);
 		break;
-	case NVIF_OUTP_ACQUIRE_V0_LVDS:
-		ret = nvkm_uoutp_mthd_acquire_lvds(outp, args->v0.lvds.dual, args->v0.lvds.bpc8);
-		break;
 	case NVIF_OUTP_ACQUIRE_V0_DP:
 		ret = nvkm_uoutp_mthd_acquire_dp(outp, args->v0.dp.dpcd,
 						       args->v0.dp.link_nr,
@@ -406,6 +407,7 @@ nvkm_uoutp_mthd_acquired(struct nvkm_outp *outp, u32 mthd, void *argv, u32 argc)
 {
 	switch (mthd) {
 	case NVIF_OUTP_V0_RELEASE      : return nvkm_uoutp_mthd_release      (outp, argv, argc);
+	case NVIF_OUTP_V0_LVDS         : return nvkm_uoutp_mthd_lvds         (outp, argv, argc);
 	case NVIF_OUTP_V0_HDMI         : return nvkm_uoutp_mthd_hdmi         (outp, argv, argc);
 	case NVIF_OUTP_V0_INFOFRAME    : return nvkm_uoutp_mthd_infoframe    (outp, argv, argc);
 	case NVIF_OUTP_V0_HDA_ELD      : return nvkm_uoutp_mthd_hda_eld      (outp, argv, argc);
-- 
2.41.0

