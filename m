Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1567D10ED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377507AbjJTNzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377274AbjJTNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:55:13 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817C93;
        Fri, 20 Oct 2023 06:55:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uf4/ueOwSpGueg1moM9yL0r5SwPzTQFwl3G54Cnma/po/fu7KZdx9anjleLcrOBpBCCUom0oJ0IfKb4yRsBMJ8kQmSwUNz2lQV2VB24QH66KCDrtf8Oox7CheHpa+z9MzfSUtHJdA5hOOCTpr5L+EOLJ/4v3gvNUwWZkoE07j/yBgbdirdyKOUdoQiWHJqlB0xKwYvEmMFqt38Q+kgKprULMSk0suc/HofPuBkmLTh2U7z7AGkiWhv46PzIhx0XE2d8BkaqInhRhV+/TrK4b58k78DJk9N0O2/7f6HwbI4CDAMemwKHbE2DmycS4ryj1L1i3lr9NeQrZx7CHHxaBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNA+Hw6QwGM3O5n7svgM4gdZNh5Lp6FAvnOV5X3vxak=;
 b=L5C8RJvWXGqsJt9UNqqb/932w/bvyi4GACeO+lxx2LDhkJU5eJxnr3jWLTFkEVgPIFV4XzRXvN0Kp9MQa//81E23ytfypcNi5gZU5dnmJ2aToWdCxrNZTv550Z5XbcnDTO00lJvrTvSi8HYf9E+cdfU8YHtvVFAiY1nIMuqAi82ob2zGcB0LpJYaYqOHOXXAQxL2UPbXUIiqxNPJCT97myxZgSiCDs45KYmGlUQRKydpr0QUw5fiQpHiW4sl9uWXP3pnA0meLICetnlHYd3nWRRMGTTH51XKt69ABOD8eN44koWY/B/SOBz1n7BGNuNVAvD8uxWDeZ/DtmXSEqqR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNA+Hw6QwGM3O5n7svgM4gdZNh5Lp6FAvnOV5X3vxak=;
 b=IGTcRPZ06KooiZ+2KZNqSk0mUs3lAcl6BEuYCV+tg3zWIxgX0FM8MMeQAkaxsO1fE74naOn7iGszryFR2xLQrXGIj6XOVfBiakwI9gaKcdBYvURYVTDFZ2HiEQTGx8WC4RR+r2rQuBasn+0TBu1a/T4KUMefJD5hD8UJNR313yg=
Received: from DU2PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:10:3b::24)
 by VI1PR01MB6511.eurprd01.prod.exchangelabs.com (2603:10a6:800:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 13:55:04 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::38) by DU2PR04CA0019.outlook.office365.com
 (2603:10a6:10:3b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25 via Frontend
 Transport; Fri, 20 Oct 2023 13:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.20 via Frontend Transport; Fri, 20 Oct 2023 13:55:04 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Fri, 20 Oct 2023 15:55:02 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] dt-bindings: backlight: mp3309c: remove two required properties
Date:   Fri, 20 Oct 2023 15:54:33 +0200
Message-Id: <20231020135434.2598578-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020135434.2598578-1-f.suligoi@asem.it>
References: <20231020135434.2598578-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2023 13:55:02.0828 (UTC) FILETIME=[05FED6C0:01DA035D]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B622:EE_|VI1PR01MB6511:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 32b5913a-d99f-4a22-c8c3-08dbd1742989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CRDKt9tApOnTbpky9xlyv5+53R1ePhZOL0b9JvEvNLmA0MlLHv+HwKvBnyVm3PXqj4wph6xwrqnoSZzFezcL0bwjtQONX2Ne217KVqaHZKwmMdWzn3G+SXUStUqqVTHuG7A0YhMmTTTo4d7FKc9SjDuONSyPmpJ3XZ+U3vbb447bvxmA4bdpzoqT9dytZ9BVFCKpiQQaiSi7JOLFWY5SjjXbdof6O+shcXzWu4fpUyOJ6F0413ulAFgKKfSH5dFSynOREDKG/Emo8XKs+WybnP1pY/78DraMJJkiYm0oj0BynVBPuCdwZNrvkbpYEE/ZoxSRp7197iYCUy6Btszfjws2z9bKg/HmbmcWKtNYtXqmZAuSUxisWtFdciNUR8c6cb5qOf08HKONqrOOLbIA9KGExZ72qfrvtr/kK27By6LEzyie9BrcnWFFQuqzhB6Gm3DQPvoldWa+sGEb5Mdooy9+EeRtW4Je3UhEoRVSNCdPMd4+ZIDnmj800xL1MI1LIH0NN6QpHHfu4k6++jeIDZatevkpeU1crVQz6bunXv1r6Kn4g9uoOkXKOgaz22ayIW2ukQTd4CsswmDHRTRLlSUZb1wBPGj4ckOPrVxVA/REOxjgFkvz0OS8NJj9h5rxivud+In3a+CpH0dkBvEszsCgBgZSBpZGW+vCrabuKMXAG8z5p9MKn5pAGGY2rZC5bYgg1+xDVJyEpCX93p4Nm0FEtrdp2m49SZbypMd4tAc=
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(39840400004)(396003)(136003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(4326008)(356005)(41300700001)(316002)(110136005)(36756003)(8676002)(8936002)(966005)(2906002)(478600001)(70206006)(81166007)(36860700001)(5660300002)(450100002)(70586007)(6666004)(26005)(336012)(1076003)(2616005)(86362001)(40480700001)(47076005)(83380400001)(107886003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 13:55:04.4176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b5913a-d99f-4a22-c8c3-08dbd1742989
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR01MB6511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two properties:

- max-brightness
- default brightness

are not really required, so they can be removed from the "required"
section.

Other changes:

- improve the backlight working mode description, in the "description"
  section
- update the example, removing the "max-brightness" and introducing the
  "brightess-levels" property

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 .../bindings/leds/backlight/mps,mp3309c.yaml           | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
index 4191e33626f5..527a37368ed7 100644
--- a/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml
@@ -14,8 +14,8 @@ description: |
   programmable switching frequency to optimize efficiency.
   It supports two different dimming modes:
 
-  - analog mode, via I2C commands (default)
-  - PWM controlled mode.
+  - analog mode, via I2C commands, as default mode (32 dimming levels)
+  - PWM controlled mode (optional)
 
   The datasheet is available at:
   https://www.monolithicpower.com/en/mp3309c.html
@@ -50,8 +50,6 @@ properties:
 required:
   - compatible
   - reg
-  - max-brightness
-  - default-brightness
 
 unevaluatedProperties: false
 
@@ -66,8 +64,8 @@ examples:
             compatible = "mps,mp3309c";
             reg = <0x17>;
             pwms = <&pwm1 0 3333333 0>; /* 300 Hz --> (1/f) * 1*10^9 */
-            max-brightness = <100>;
-            default-brightness = <80>;
+            brightness-levels = <0 4 8 16 32 64 128 255>;
+            default-brightness = <6>;
             mps,overvoltage-protection-microvolt = <24000000>;
         };
     };
-- 
2.34.1

