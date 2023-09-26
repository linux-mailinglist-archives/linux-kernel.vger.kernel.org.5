Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293CC7AF111
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjIZQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjIZQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:45:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE80E5;
        Tue, 26 Sep 2023 09:45:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66410C433C7;
        Tue, 26 Sep 2023 16:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695746709;
        bh=NLDXpZvaFQNHIhUvBJFKAVrrZdic9lys/WgPWvzaSa8=;
        h=From:To:Cc:Subject:Date:From;
        b=awUPCHvX89TNdhiQI/PIhXg0GM/ClTHd8530cIF+XNPJEepM9m3LsaOT7s1saJ5Kr
         kJU/V/ODgcGbK86avt6X+rCfStP/6DQApu4bOGXI+PCZxycD+iccBeTi9t5I8X0RQ3
         oc6YL5CvJcDr8BkZrvZyBxqkUGNJUsutl9DiOVBpuxWWlGJXzrdx/MvuViSFAk922N
         lVYEBd7ZXkpMlvDV9jx7XlFScPhzTdXMX74sFjvufktD8RZH9PzjA0Bwtzpdpc5inF
         LXkwycxA2eXJliKYIjJOoLbaIgOgh0g7Mkqd1mB9oZkxdLfSmNx8MW6xrWCrrQqu6H
         HtTcmtF3ndZGA==
Received: (nullmailer pid 101904 invoked by uid 1000);
        Tue, 26 Sep 2023 16:45:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: nvidia,tegra124-soctherm: Add missing unevaluatedProperties on child node schemas
Date:   Tue, 26 Sep 2023 11:44:52 -0500
Message-Id: <20230926164500.101593-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just as unevaluatedProperties or additionalProperties are required at
the top level of schemas, they should (and will) also be required for
child node schemas. That ensures only documented properties are
present for any node.

Add unevaluatedProperties as needed, and then add any missing properties
flagged by the addition.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 04a2ba1aa946..b0237d236021 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -68,7 +68,12 @@ properties:
     patternProperties:
       "^(light|heavy|oc1)$":
         type: object
+        additionalProperties: false
+
         properties:
+          "#cooling-cells":
+            const: 2
+
           nvidia,priority:
             $ref: /schemas/types.yaml#/definitions/uint32
             minimum: 1
-- 
2.40.1

