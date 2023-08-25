Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE87885BA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbjHYL1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243934AbjHYL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:27:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417412682
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:07 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ff09632194so1214848e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962825; x=1693567625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxcpKq58Y0dVZy+8hut+gJq89Cu88bDtADLCXTUFucg=;
        b=xWcNX43Tu9tRhvZRust1sHusglipxG0/TudWhZhAeLAWJGb53bc1b3mnXfXZ33PaD2
         h/dgcZ/+5kCG/1wPxvAjiAbRCLyVudSHEEhWhi+PqbX2qQYEFZDon/j4/h5EoDrhk7l5
         4l0z8lNFTKKyxEnpvgggZKjIucMh89Mln/ur/eOB+01sqXgF691T/wvDfvghQl8AQszJ
         DI5my/j6re7sEYpVlb3mjO5TGlk3rRh/K5vV3Vyhb4wcPySP1I4hHpihQCThNIPngf69
         wEwCV8GsSn7YJYwAFqN1i7aMYQwWa+RYwCBlm0Y60WqwHxV+ujJxKHtiVerLygpBQiea
         6RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962825; x=1693567625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxcpKq58Y0dVZy+8hut+gJq89Cu88bDtADLCXTUFucg=;
        b=ZzlWxPIp4CDS3hB4NTF8YUndM0TYDJLLJ3EutBazUKCi6t6PMGYfTZE06fS7+4dHco
         kEy39OpD9PPIao3uD0cWpYEPzZ5Xi7K4LZU4U3XnzHdjgqyywKIJGjJjhMn07UnFZv8T
         RFs4fhQyGe8yHzYOGwdMGb8SjRjIwS4MC6P2vODVXMqqrS5sO86gtj0fY6HLCKSovbGb
         oGEGfcPjPdji+oDXcVQbWobbnkIf2Iryf0OUW/3KBBPr9q9+X3mtz5TV+Icu3A+HQtDa
         6Jf6hGgwzDetYbo/ZEa6jDHwCDlYsnY7wQhE5svQ6XegChaXuij1YVqCKpP44XdCQ4L8
         OnLw==
X-Gm-Message-State: AOJu0YxM61zEFpFkGWY78W3P3qDU7G7M714/SeHFSmZyIph4z++uIZRB
        21VlXP4+LxAi9sUm2Al9/jm0Ag==
X-Google-Smtp-Source: AGHT+IGC2Vf7sjQDdr5V4QHRIfVkhDfG8KHUs1E6JqOKtM2FEDh4ZHWiW4GAfGWqyxVFmC3dv1Il+A==
X-Received: by 2002:a05:6512:1081:b0:4fb:8f79:631 with SMTP id j1-20020a056512108100b004fb8f790631mr13843222lfg.46.1692962825383;
        Fri, 25 Aug 2023 04:27:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:27:04 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 10/13] dt-bindings: power: Clarify performance capabilities of power-domains
Date:   Fri, 25 Aug 2023 13:26:30 +0200
Message-Id: <20230825112633.236607-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-domains bindings has in many years been used to describe so
called performance-domains too. Rather than using a separate binding it has
been convenient to re-use the power-domain bindings, as in some cases it's
in fact a combination of the both that would be the best description.

Therefore, let's make it more clear that the power-domains bindings can be
used to describe a performance-domain too.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- New patch.

---
 .../devicetree/bindings/power/power-domain.yaml | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/power-domain.yaml b/Documentation/devicetree/bindings/power/power-domain.yaml
index d1235e562041..8fdb529d560b 100644
--- a/Documentation/devicetree/bindings/power/power-domain.yaml
+++ b/Documentation/devicetree/bindings/power/power-domain.yaml
@@ -13,8 +13,9 @@ maintainers:
 
 description: |+
   System on chip designs are often divided into multiple PM domains that can be
-  used for power gating of selected IP blocks for power saving by reduced leakage
-  current.
+  used for power gating of selected IP blocks for power saving by reduced
+  leakage current. Moreover, in some cases the similar PM domains may also be
+  capable of scaling performance for a group of IP blocks.
 
   This device tree binding can be used to bind PM domain consumer devices with
   their PM domains provided by PM domain providers. A PM domain provider can be
@@ -25,7 +26,7 @@ description: |+
 
 properties:
   $nodename:
-    pattern: "^(power-controller|power-domain)([@-].*)?$"
+    pattern: "^(power-controller|power-domain|performance-domain)([@-].*)?$"
 
   domain-idle-states:
     $ref: /schemas/types.yaml#/definitions/phandle-array
@@ -44,11 +45,11 @@ properties:
 
   operating-points-v2:
     description:
-      Phandles to the OPP tables of power domains provided by a power domain
-      provider. If the provider provides a single power domain only or all
-      the power domains provided by the provider have identical OPP tables,
-      then this shall contain a single phandle. Refer to ../opp/opp-v2-base.yaml
-      for more information.
+      Phandles to the OPP tables of power domains that are capable of scaling
+      performance, provided by a power domain provider. If the provider provides
+      a single power domain only or all the power domains provided by the
+      provider have identical OPP tables, then this shall contain a single
+      phandle. Refer to ../opp/opp-v2-base.yaml for more information.
 
   "#power-domain-cells":
     description:
-- 
2.34.1

