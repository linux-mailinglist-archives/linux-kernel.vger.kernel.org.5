Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1038F7C961D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 21:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjJNTnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJNTnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 15:43:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020CB7
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 12:43:11 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso505316966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1697312589; x=1697917389; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HxHVZc6YcEpPz9+wvy4GvoTV26RHqH6Rd4h4faexEg=;
        b=D/PHpq6tLdygH+w0oPbuYLuF600kO1CPvHgwrw3L7QglZi4/xtYGJyGux1DvVSTba9
         Vk1EuqINcsUBhOF6ffAzxEZDPHruPy27Zsav5In76kN6JTvDC9Zuv3F6+qdZiSNVQD6S
         J+cNJ3JupMQ93tSj3kdGCFsOmROPKWXb5CiRL6Sr3RJmafz9ZIK+Iitf1fkagnmj5qsZ
         cqiQpqgrtr8X/EhQtEwEy/d7Dy3CJus+SGYPn5CURnc2hfWL7TMNFOOSPEXV2ZLOyzEe
         41XR5JQJRLwoMD/+NWSUB74Rtvso0V3lvE7a5CMZjWmMBcXR7d0sN5KSZcDvqiI2FcRv
         AaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697312589; x=1697917389;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HxHVZc6YcEpPz9+wvy4GvoTV26RHqH6Rd4h4faexEg=;
        b=dhUJaW9Wzp2mMo7d7IIYkBDu3kXEkzwqp0NdI64leN3j+7fUWXosgKxFCTmrnNVDUB
         FGa1PmAuNMHGg1masBIlz65gygA+dFw9rwBb2sYFZZhdGVEYJNnSCrqDpsqhjhaWcQro
         dP3UBvykseCiGSTdzOiGyNwaYIK2gAtHHu7UAxTRvdMaA946SZ9SkTCQ8UxBDcpOCDBT
         b/ddbX7lXQJKIxLq0sNtCMpkPiPM39AI+Xl7BHGW95sCr64ci/1pWJ2zfDPzmcGCNkup
         faODxlw9937zstACsEctxicd45ycPESO11/w0pJxbDq0ayEkWqFM2OLvNOrb0RHiGGv9
         gYaA==
X-Gm-Message-State: AOJu0YwroS/K2V9ayQZ4UiCmg4u/h+abcORFerNw3ZFnuVbdmh1yHMjH
        WqZufVAQ35G6If35rU0NDB3Seg==
X-Google-Smtp-Source: AGHT+IGl30Gorqg9oio+b+sZtLdUF1DgfPaothJCR+sUNvv/emVXwerBBHvRMx2mnxP8dh03QHmoBQ==
X-Received: by 2002:a17:907:31c2:b0:9be:30c2:b8ff with SMTP id xf2-20020a17090731c200b009be30c2b8ffmr3129489ejb.61.1697312589449;
        Sat, 14 Oct 2023 12:43:09 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id fi27-20020a170906da1b00b009934b1eb577sm1301000ejb.77.2023.10.14.12.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 12:43:08 -0700 (PDT)
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Date:   Sat, 14 Oct 2023 21:43:01 +0200
Subject: [PATCH] drm: bridge: adv7511: get edid in hpd_work to update CEC
 phys address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk>
X-B4-Tracking: v=1; b=H4sIAETvKmUC/x3MMQqAMAxA0atIZgNNVYpeRRxqk2oWlRZEkN7d4
 viG/1/IklQyTM0LSW7Neh4V1DYQdn9sgsrVYI3tyFCPnm83EGGQgMLKGKMbVu58GO0INbuSRH3
 +5byU8gFL8yvAYgAAAA==
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The adv7511 driver is solely responsible for setting the physical
address of its CEC adapter. To do this, it must read the EDID. However,
EDID is only read when either the drm_bridge_funcs :: get_edid or
drm_connector_helper_funcs :: get_modes ops are called. Without loss of
generality, it cannot be assumed that these ops are called when a sink
gets attached. Therefore there exist scenarios in which the CEC physical
address will be invalid (f.f.f.f), rendering the CEC adapter inoperable.

Address this problem by always fetching the EDID in the HPD work when we
detect a connection. The CEC physical address is set in the process.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
Pardon the insertion of the ugly adv7511_get_edid() prototype, but I did
not want to clobber git history by rearranging a bunch of functions. If
this is the preferred approach I will happily re-spin the patch.
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 2611afd2c1c1..3d32c109963c 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -424,6 +424,9 @@ static bool adv7511_hpd(struct adv7511 *adv7511)
 	return false;
 }
 
+static struct edid *adv7511_get_edid(struct adv7511 *adv7511,
+				     struct drm_connector *connector);
+
 static void adv7511_hpd_work(struct work_struct *work)
 {
 	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
@@ -457,6 +460,9 @@ static void adv7511_hpd_work(struct work_struct *work)
 		if (adv7511->connector.dev) {
 			if (status == connector_status_disconnected)
 				cec_phys_addr_invalidate(adv7511->cec_adap);
+			else
+				adv7511_get_edid(adv7511, &adv7511->connector);
+
 			drm_kms_helper_hotplug_event(adv7511->connector.dev);
 		} else {
 			drm_bridge_hpd_notify(&adv7511->bridge, status);

---
base-commit: 4366faf43308bd91c59a20c43a9f853a9c3bb6e4
change-id: 20231014-adv7511-cec-edid-ff75bd3ac929

