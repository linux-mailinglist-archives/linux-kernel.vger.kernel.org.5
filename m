Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CF87EE66C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbjKPSID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjKPSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C33D49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700158077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hPxzOncy5HIGVOblAN4i/IW7KR+JFRLvP+iQR6fOxe0=;
        b=g3NlFgy2WNFABIQMSA6+FYULD1hl+ZrQ1uavutzgH//ayBV2OksIxEsj1m2x+pyAyEwbOr
        33+CrX6aFlcczFmd6wIwCEYOMSxwVpERHOvyVAc+UYKW8lRJjKbXXJtuYiUnTMG9O1baUX
        nGkCOz8963FLWx73omQYqudv52rEIyw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-hduKsP3VO6eiiLkjePYDqg-1; Thu, 16 Nov 2023 13:07:56 -0500
X-MC-Unique: hduKsP3VO6eiiLkjePYDqg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40a3efec9a7so6964435e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700158073; x=1700762873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPxzOncy5HIGVOblAN4i/IW7KR+JFRLvP+iQR6fOxe0=;
        b=mNCCezryEw07UYd3kQKZeeSTVMXtuwBhOhEFYr1qIqwitIqgI2dTHneQrOxtqcYGHU
         FLHT+eIaKW82YSw5Ziv7ZzriM07bg9cuoZKGd28HWBD05vTwXWVUcD89bbZBfq+zha6u
         nOMp95DfmGKpBH329BFT7OjmqmDZ2ve7j3qT77q4k4/SLguf+H69W8YGFpoCIkk59z0W
         JFCj1FOId4mfyYGiRDHuHqW9qFmACrCvsnkqhzLXkm1AbQRk+Gzno6FsYm0hCbF1d+ta
         etO+KtwPaidcA6idcITjhDVxhMZM8nFLgPeI5mww39EIhmjG3n4EYRZVi/bAvgmShy+I
         iMPg==
X-Gm-Message-State: AOJu0Yxup4L1PTK7KyQt4ZJa+iMvZ0AJ3np64vFetdy1krep1HmuWhg7
        QTx3K29Cbxto3Ee8yc7ItBtaKvk8YRIM1m+RkpgSbFdGH1B51/a7i4K41pcaNdUrClYRfFTc+BO
        elXFKXu/ZtEpozZmgdSS+RygUC4PmeClNI1WtFP9ztjOfYKZ0WGs5qQghIN6ia7VeWu7wgoaUFK
        ESDIpjraA=
X-Received: by 2002:a05:600c:c0f:b0:402:e68f:8896 with SMTP id fm15-20020a05600c0c0f00b00402e68f8896mr14609083wmb.0.1700158073656;
        Thu, 16 Nov 2023 10:07:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmdfeAnuQFuohht1CLAm2Stx5W5EGXlcnDY8tsQEAn2nKKlrvW/+NDUyqH/j1nM9uFFuRyLA==
X-Received: by 2002:a05:600c:c0f:b0:402:e68f:8896 with SMTP id fm15-20020a05600c0c0f00b00402e68f8896mr14609042wmb.0.1700158073266;
        Thu, 16 Nov 2023 10:07:53 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w8-20020a05600c474800b0040836519dd9sm61664wmo.25.2023.11.16.10.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 10:07:52 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sahaj Sarup <sahaj.sarup@linaro.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] dt-bindings: display: ssd1307fb: Change "solomon,page-offset" default value
Date:   Thu, 16 Nov 2023 19:07:37 +0100
Message-ID: <20231116180743.2763021-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used to specify the page start address offset of the display RAM.

The value is used as offset when setting the page start address with the
SSD130X_SET_PAGE_RANGE command, and the driver currently sets its value to
1 if the property is not present in the Device Tree.

But the datasheet mentions that the value on reset for the page start is a
0, so it makes more sense to also have 0 as the default value for the page
offset if the property is not present.

In fact, using a default value of 1 leads to the display not working when
the fbdev is attached to the framebuffer console.

Reported-by: Sahaj Sarup <sahaj.sarup@linaro.org>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .../devicetree/bindings/display/solomon,ssd1307fb.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
index 3afbb52d1b7f..badd81459aaa 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml
@@ -35,7 +35,7 @@ properties:
 
   solomon,page-offset:
     $ref: /schemas/types.yaml#/definitions/uint32
-    default: 1
+    default: 0
     description:
       Offset of pages (band of 8 pixels) that the screen is mapped to
 
-- 
2.41.0

