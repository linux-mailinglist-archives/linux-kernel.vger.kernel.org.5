Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AFF805E05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjLESsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjLESsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:48:10 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56DBD44
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:48:15 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58de9deec94so470730eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701802095; x=1702406895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDgn1SrDftxmBi54zNdMtJUWGA9ZxIzk+fgRKHhw/lM=;
        b=QtEMLXZR5fcHbcLUT4m6kHVdo/6Rk4WgCFLe8+Wzei1nyhxKG/CO046VvhXG5s+von
         i3FjB3oStaA7mNvXRZGy7c6bkqfPvM/chff/5l6veCF/5LNhLxvkaXtVHBuHbxniBrUD
         eY0/r2q+GWA2SxnfRdJZVdIspWd058+ENn784=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802095; x=1702406895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDgn1SrDftxmBi54zNdMtJUWGA9ZxIzk+fgRKHhw/lM=;
        b=GXSz1B6kJm0wmb9H+qvFX08DWyEyDt43VlpEWue6lxnf/xKaztOVRVQNiSR0yNCaX1
         y9scQ/Z0+1YVNOKmKN2v1DrSswdeo4UYm3FQZRb60vNAjqLd1CV9bSpgSNO05eVHL2vS
         gYQJ5thBf6jFJYsCw95+dzAS1J3AHv4EZKHkHBCslEq+vpB+j8RjPBrbxJIomNr5M231
         JxFAcFYULgDze4vaa5r8sIlZoGCetfZPAABtgkJ2+sVvuzPGAv1J2abqMUai7kW83Rqb
         QYJ8sn4Rmgr8opWrunau06bOCRrk16ATYeUiWz9/pXJP3LGrb5RfwqVFW2hIxRvZZxg/
         OuTA==
X-Gm-Message-State: AOJu0YxqXaHiZsAqjrSCRPXCOzFG42+nO+Vroby63MSCAbCNbbJekGKy
        lpANW0mzqy9m4HYqFof/ICfQ0g==
X-Google-Smtp-Source: AGHT+IFI1UF+i4Lmh7XXhTATcjR+n/TABBYg+KiFDvGwEmkJJjxPFfcqdC4o+UQvAJ0jSDdQON+qcg==
X-Received: by 2002:a05:6359:a25:b0:16e:4d4c:68a2 with SMTP id el37-20020a0563590a2500b0016e4d4c68a2mr20644814rwb.2.1701802094712;
        Tue, 05 Dec 2023 10:48:14 -0800 (PST)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id m27-20020a637d5b000000b005c6746620cfsm3151046pgn.51.2023.12.05.10.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:48:13 -0800 (PST)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id DC55DD02; Tue,  5 Dec 2023 10:48:10 -0800 (PST)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] dt-bindings: memory: additional compatible strings for Broadcom DPFE
Date:   Tue,  5 Dec 2023 10:47:34 -0800
Message-ID: <20231205184741.3092376-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205184741.3092376-1-mmayer@broadcom.com>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add versioned compatible strings for Broadcom DPFE. These take the form
brcm,dpfe-cpu-v<N> where <N> is a number from 1 to 4.

These API version related compatible strings are more specific than the
catch-all "brcm,dpfe-cpu" and more generic than chip-specific compatible
strings.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 .../bindings/memory-controllers/brcm,dpfe-cpu.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
index 08cbdcddfead..6dffa7b62baf 100644
--- a/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
@@ -16,6 +16,11 @@ properties:
       - enum:
           - brcm,bcm7271-dpfe-cpu
           - brcm,bcm7268-dpfe-cpu
+      - enum:
+          - brcm,dpfe-cpu-v1
+          - brcm,dpfe-cpu-v2
+          - brcm,dpfe-cpu-v3
+          - brcm,dpfe-cpu-v4
       - const: brcm,dpfe-cpu
 
   reg:
@@ -40,7 +45,8 @@ additionalProperties: false
 examples:
   - |
     dpfe-cpu@f1132000 {
-        compatible = "brcm,bcm7271-dpfe-cpu", "brcm,dpfe-cpu";
+        compatible = "brcm,bcm7271-dpfe-cpu", "brcm,dpfe-cpu-v1",
+              "brcm,dpfe-cpu";
         reg = <0xf1132000 0x180>,
               <0xf1134000 0x1000>,
               <0xf1138000 0x4000>;
-- 
2.43.0

