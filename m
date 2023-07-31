Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEED769018
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGaI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:29:50 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED8F3;
        Mon, 31 Jul 2023 01:29:48 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TX6d054896;
        Mon, 31 Jul 2023 03:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690792173;
        bh=7rJDLj3T8cLCJQRX0eYplE/1TiRzoHqS/jXQuxRZZZ0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=W5DOHI8QC21ckSbmbrQr7600kMz9WleIB510bR3amjTN9bC2DXoTivNYxqDjxF6RB
         9KXfGlZySXy5iYswDpHSI1xsRAxGclJ0qzHJuZ+C1JbLaAdnaM93rzdHGvTpQ8VIB9
         GJYgeGijUF+ADA4bzxAunz+6w4MURMIY9ysfQPmo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36V8TXeW011880
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 03:29:33 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 03:29:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 03:29:33 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36V8TWhr031919;
        Mon, 31 Jul 2023 03:29:33 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        <niklas.soderlund+renesas@ragnatech.se>,
        Benoit Parrot <bparrot@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <devarsht@ti.com>, <j-luthra@ti.com>
Subject: [PATCH v8 01/16] media: subdev: Export get_format helper for link validation
Date:   Mon, 31 Jul 2023 13:59:19 +0530
Message-ID: <20230731-upstream_csi-v8-1-fb7d3661c2c9@ti.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
References: <20230731-upstream_csi-v8-0-fb7d3661c2c9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=hchN4nU1yjfLjYGzib3vC33TVA07NDQjiP16zuMScbI=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkx2xjGpyUeOHWpsroGlw9rL7Idjbhfh51R7P8D
 aptBltinqGJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZMdsYwAKCRBD3pH5JJpx
 RQ/3EADD+iB9qv7H4CMzmtXtjHPb769+6dU4E34lrEfOXjnkPewgGcmXuSZxK0kS4N+Js9YpI0K
 oOs7ncrYn9PGE8yH59o0HzQv/vh2oHI1h7tlSTbVYNJ47+Naanrlw74QsUhFZtNPBAaVtQJEDAx
 TUgtdmMe69JSYxlRkiC1VX8Fcj8vWQy1hD9D3j94iOwbb1cdmHYgdHeSFL8yhauMgbqxOm8mP7t
 K4rpvBFpIitLj4taWYKfF4O7aptCm/sJC0cyyj1/2BLjEaAteOFprBaQwxEPceLoHkVy+EQgj2y
 BzbjqUO9fhkEJrbwbd2Pj1idWHP6GPkezs1STCRFSJz5JC23Lb+hSZEKUKJY3EO5TUud3+mStkY
 RAmXxWhe+4HA0VaUDP+ycnHC2+oOGeCb6QYL28DN3kQDRVykm8m7W2k/+a+JpRHuOnql3yV++5e
 ETqSP020tZA9FjZWBUuDp6h65V8dGA3BVfImvvc+SOybudNjL7oUzNVNmqyH6/zzTYehrpv+Q1v
 A99tSjMBdO/kkJdHZqQZgjlIaYnMl8t+ESIhckqikTkhoCmMNRxPFUBYv1bMOcE+1iubQsGsdSt
 qfkZNRwlWTSOrsAGC9cPf5iBMvIylS91MoDuk77BOTDSBW8IqehIzl/mbQ/gdgurEBQqaLlt8kA
 rY3oy0/TNHxRCjQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For link validation on video device drivers, it may be required to
match the formats set on the source subdev with the formats set on the
video device.

Export the existing v4l2_subdev_link_validate_get_format() helper so it
can be reused by such drivers.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
New in v8

 drivers/media/v4l2-core/v4l2-subdev.c |  8 ++++----
 include/media/v4l2-subdev.h           | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 217b8019fb9b..0d3b5ff5cacc 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -1130,10 +1130,9 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 }
 EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_default);
 
-static int
-v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
-				     struct v4l2_subdev_format *fmt,
-				     bool states_locked)
+int v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
+					 struct v4l2_subdev_format *fmt,
+					 bool states_locked)
 {
 	struct v4l2_subdev_state *state;
 	struct v4l2_subdev *sd;
@@ -1165,6 +1164,7 @@ v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(v4l2_subdev_link_validate_get_format);
 
 #if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
 
diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index a012741cc876..ef7007f46889 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1301,6 +1301,18 @@ int v4l2_subdev_link_validate_default(struct v4l2_subdev *sd,
 				      struct v4l2_subdev_format *source_fmt,
 				      struct v4l2_subdev_format *sink_fmt);
 
+/**
+ * v4l2_subdev_link_validate_get_format - get format for media link validation
+ *
+ * @pad: pad id
+ * @stream: stream id
+ * @fmt: pointer to &struct v4l2_subdev_format
+ * @states_locked: is the subdev state already locked
+ */
+int v4l2_subdev_link_validate_get_format(struct media_pad *pad, u32 stream,
+					 struct v4l2_subdev_format *fmt,
+					 bool states_locked);
+
 /**
  * v4l2_subdev_link_validate - validates a media link
  *

-- 
2.41.0
