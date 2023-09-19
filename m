Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA047A5922
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjISFDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjISFDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:03:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C5CFC
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:03:11 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-578b407045bso293665a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695099791; x=1695704591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=laTm7dnxWOCcW2RIknshlwm/kbQUB6RtmbdVs9LREqk=;
        b=bh838skYf6q2+kziJFwbN6I9NdK2rrEx14g0w0D7LeYAig8uyCed0K90mzyrD3fn8Q
         QTUd9N1BoXa5xiuUjcXGWb2VvuolhEftKzoZ0pdM+c0ZGukEZ44C4DunILe37EsH7slz
         YMLrCQPJfpmA92Ce9fWMeIrdMDwmk7SERw9fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695099791; x=1695704591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laTm7dnxWOCcW2RIknshlwm/kbQUB6RtmbdVs9LREqk=;
        b=SdKPs/jeb0bwV5altuJ2lLvuxSt0M6OEP+dKJtGhWTnT+IiigAdDmYovuxJ7iSX/UP
         MyLHXG//+T4qkDBDflncfxWskSeiJdqs1bVcqiXbtoU2I8IpvY550dTmq7kdu+6yWahM
         Xmklrt+rBc6AMXls/jzdaYdYUonsJBM5WzMzoTD4uWDTBM2Op1HO3vEsSp/rE7kRmD87
         aATMFNX9WONeUq56pNB0hLYuMCUbJIQD4w//Vf6SLqWQMegaxYa+tQNvr6z5R6FjLpBj
         Z/1PL9OmHBVxDIRz/c/uyuvIflQ6JsMoyhMT1j3XGMTp1cFtK50QWKy34wAipLxdYuYo
         cyzg==
X-Gm-Message-State: AOJu0YwET7L8XpGmGRrhI47o9gEC7PSFRdgwLd0O6IYmYGyCCP3PPfr6
        nU/mY+WRcumZHVipXJiBJN69mg==
X-Google-Smtp-Source: AGHT+IGycmQsNFwgoBQwKURop8RFXZn7kdUvjCHaXVun+krQq3OvwV8JGEXJPbCRePSXThTCs6siig==
X-Received: by 2002:a05:6a20:5611:b0:14e:b4d5:782e with SMTP id ir17-20020a056a20561100b0014eb4d5782emr11869037pzc.29.1695099790851;
        Mon, 18 Sep 2023 22:03:10 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:40a:900d:e731:5a43])
        by smtp.gmail.com with ESMTPSA id z13-20020aa785cd000000b00686edf28c22sm313169pfn.87.2023.09.18.22.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:03:10 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>
Subject: [PATCH] remoteproc: mediatek: Detect single/multi core SCP with rpmsg-name property
Date:   Tue, 19 Sep 2023 13:03:04 +0800
Message-ID: <20230919050305.3817347-1-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the just landed multi-core SCP work, detection of single/multi core
SCP is done by checking the immediate child node of the SCP complex
device node. In the original work this was done by matching the child
node's name. However the name wasn't previously standardized. This
resulted in breakage on MT8183 and MT8192 Chromebooks while the driver
side changes were picked up and the device tree changes were not picked
up.

Instead, match against the "mediatek,rpmsg-name" property, which is
required to be present in the rpmsg sub-node. This makes the
aforementioned devices running old device trees working again.

Reported-by: Laura Nao <laura.nao@collabora.com>
Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
The patch is based on next-20230918 with a whole bunch of local patches
stacked on top. None of my local patches are related to remoteproc, so
it should be fine.

I tested on both MT8183 Juniper and MT8192 Hayato and on both systems
the SCP successfully probed again.

 drivers/remoteproc/mtk_scp.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index ea227b566c54..ca15d9f382a1 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -1149,13 +1149,23 @@ static int scp_is_single_core(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev_of_node(dev);
 	struct device_node *child;
+	bool has_rpmsg;
 
 	child = of_get_next_available_child(np, NULL);
 	if (!child)
 		return dev_err_probe(dev, -ENODEV, "No child node\n");
 
+	/*
+	 * On single core SCP systems, the immediate child of the SCP device
+	 * is the rpmsg node; on multi core systems, there's an intermediate
+	 * level node, one describing each core. Instead of matching on the
+	 * node name, which was recently changed in the DT binding in a
+	 * backward incompatible way, match against the "mediatek,rpmsg-name"
+	 * property, which is required in all rpmsg sub-nodes.
+	 */
+	has_rpmsg = of_property_present(child, "mediatek,rpmsg-name");
 	of_node_put(child);
-	return of_node_name_eq(child, "cros-ec-rpmsg");
+	return has_rpmsg;
 }
 
 static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
-- 
2.42.0.459.ge4e396fd5e-goog

