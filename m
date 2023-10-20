Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7017D1930
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJTWc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 18:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjJTWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 18:32:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13616D5B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697841094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=U9iwHq/WW92wIMDf4fjn3PaKiv4Qj6cmxyyqbItQ0rE=;
        b=FxqLagcY2XmiDsZp9BOxMlfAFwdbngXnu0psfBWJZLSdGIjRdZJotonjw4n/KLEGLoA0oT
        Rd+3Apl/CLaSL+vNWaAqXXyw94I0CVZbfV7ftbgpZUQq/nF00Hj91HUNA/MA2kJtNJWt3f
        bmZQQgrQmhNU3ZC8c0JhfMXmlInXS/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-3YA-EhpHPiWHBYrhBxhaQw-1; Fri, 20 Oct 2023 18:31:33 -0400
X-MC-Unique: 3YA-EhpHPiWHBYrhBxhaQw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-407f9d07b41so7921145e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 15:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697841091; x=1698445891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9iwHq/WW92wIMDf4fjn3PaKiv4Qj6cmxyyqbItQ0rE=;
        b=FDKfaEcKdT/BeJxCptf6LmIh9grHDkr4FNC1H0Ug2OG8FwCwRCwHNQKS8I9NLj5+Iq
         dD785vlLPRIxa53P4uWiGcpo9NXeu0laRecbtNjA6sONhmXHnLQ5hsaiXvh+bipoNdJB
         ivOeMgKny+2+KzBSGPimoe4WBa5MVLfF8F9zj5XtiXAxaMXI9/GrM6rjmMJkN4mvyrvt
         rtNfwwZBkouZyALVWKIotBMVrIoOLQPJW2pFB73EVQEKrIHFB7iDg38A6AhY9GxPdxNd
         b2eG87jdm1DeafeMoeWDVp6lace6EqkLYwidnF9JzhJKR3p9y34OoeUwxChoaJvRsr6b
         Td7A==
X-Gm-Message-State: AOJu0YwzuT3FbZH6/LED5mSvMKO1Yh519L+dRInqm/eoArysnpZi0Z/y
        /tpP7MMEkcQvRkuediR38KKpR/CsWzMn3TfeKNUe14xA83vUu/2DnqNEqPwFEtoIrW9JpBA9HLr
        RjFRJoHrX24gvuW5ux0P55RLj/vpl235+q5A61fWnjrXgDkeZ84m/WaNFMZBfEeo1g278AneHqv
        zda6HXWAc=
X-Received: by 2002:a05:600c:1c21:b0:408:4cf1:e9d7 with SMTP id j33-20020a05600c1c2100b004084cf1e9d7mr2415660wms.20.1697841091494;
        Fri, 20 Oct 2023 15:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEli5PDwUY2pVZDmRAcMX/xPEvIZZL1cQUyUecghxpFLxqzMscliuiWSb8kQaNJ3fTi6Xu9nA==
X-Received: by 2002:a05:600c:1c21:b0:408:4cf1:e9d7 with SMTP id j33-20020a05600c1c2100b004084cf1e9d7mr2415635wms.20.1697841091092;
        Fri, 20 Oct 2023 15:31:31 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c3b9000b003fee6e170f9sm3113382wms.45.2023.10.20.15.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 15:31:28 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] dt-bindings: display: ssd132x: Remove '-' before compatible enum
Date:   Sat, 21 Oct 2023 00:30:17 +0200
Message-ID: <20231020223029.1667190-1-javierm@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a leftover from when the binding schema had the compatible string
property enum as a 'oneOf' child and the '-' was not removed when 'oneOf'
got dropped during the binding review process.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/dri-devel/CAL_Jsq+h8DcnpKqhokQOODCc8+Qi3M0PrxRFKz_Y4v37yMJvvA@mail.gmail.com/
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 .../devicetree/bindings/display/solomon,ssd132x.yaml      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
index 0aa41bd9ddca..37975ee61c5a 100644
--- a/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
+++ b/Documentation/devicetree/bindings/display/solomon,ssd132x.yaml
@@ -11,10 +11,10 @@ maintainers:
 
 properties:
   compatible:
-    - enum:
-        - solomon,ssd1322
-        - solomon,ssd1325
-        - solomon,ssd1327
+    enum:
+      - solomon,ssd1322
+      - solomon,ssd1325
+      - solomon,ssd1327
 
 required:
   - compatible
-- 
2.41.0

