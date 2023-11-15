Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418DF7EC73F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjKOP30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjKOP3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:29:17 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4D41A1;
        Wed, 15 Nov 2023 07:29:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT9gE34oZIVNnWJ26hVPICiyEPjUgZH5qyeDOqiU+3HvcP03aqsoFT1dn1b7OI2t5KrDiHQjHNucYNDUBp3gLQz7iMtojZOUnjCzq3klsdLuZb8HfAk08M0Rt3GMZsTw02OWUMDQxh5m60Tfu2Q79AT3XALN2gzgshs0oEgd4iUmJ8OhtpRc+gZsuxDoEnu4liQVGC6mcp5JbLHA3+keKeklexo9hVHf3DCFBCSPU8yVT8tEh+tNlG4Ocgq98O2IwkW+RumJgNFibGl8VQ/5L9JSkyFDzgOSuLQaTJvCY3YDAowm4b7n+lpRMDJdAF6ZQaYH3gn6B1wTBiqiaoXqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo+ViQCVwP4zn25XTOp+1bolcZ0vuCqNmJ/hK0s8FhQ=;
 b=FJEj6cq6M3C5XUB118chP+sAXGXGG5wK4y+mwuVubuf0pw1QMcr+WI35+5bOrQXwx/F4cyE+NdFj78oJ23H9JL7AdgFI2O4Kj2OZ4B33IXlgqZNYWFFYwtwnfvgp04tq0xA4/v9sYTj4aC1FmYRWQy0icjX74aIlcLkuZRVC0fCquEFtTikdLx1+CW0bT4T/KMN4yALjC0zFnkq1I+4pzllazLMGWk6qMhk4fAHjKxaFgfieFlOvFM+/RAt+2u0H8e3K646lImht0PJflEr4GaDCLHdj8eppOtDnfoDM2XH1XzftUwnsTn5lZfikJRpRSZY9P+PV3rs0n9JIGdbeuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo+ViQCVwP4zn25XTOp+1bolcZ0vuCqNmJ/hK0s8FhQ=;
 b=kXXoLe9Cvwayg/d7xfzXAP7RLXQdfEKQldMBxEc4N++S9BH8BjVMPE4ZGssixa4shtiS4fOeJVIBxWBpft1XqJjZVodeb/7onFnVF0E7vddppQV/bMofxQo7J9KA5HwDiW5YjpvBB02IAvQ0vw05nPXAiAv+nAnXsSbI/3YJ1lM=
Received: from AM6P193CA0100.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::41)
 by DB8PR01MB6520.eurprd01.prod.exchangelabs.com (2603:10a6:10:15d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 15:29:07 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:209:88:cafe::8d) by AM6P193CA0100.outlook.office365.com
 (2603:10a6:209:88::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19 via Frontend
 Transport; Wed, 15 Nov 2023 15:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 15:29:07 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
         Wed, 15 Nov 2023 16:29:06 +0100
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
Subject: [PATCH v6 0/2] backlight: mp3309c: Add support for MPS MP3309C
Date:   Wed, 15 Nov 2023 16:29:00 +0100
Message-Id: <20231115152902.851715-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 15 Nov 2023 15:29:06.0631 (UTC) FILETIME=[78B45570:01DA17D8]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|DB8PR01MB6520:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a9e77758-64e6-480f-1266-08dbe5ef9ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ac6GwUEcAOeStTqHP1Av5+JmUlJqqipuRZgWTlKhbzmlOm+VhS8juuIpCZ/JItnlt73mROuoNj/hhuhoqfSAx6zYhOJHJqS671XzMjUruZIJRNgG1z/V1i89wY2xunDFhAS2ebAiK4Lx4gkDSQGvbnCT9Y/Xtb/oypl/R5Acz3bpAv3B9L7z72TV+fDx8YMBUzMRrX1xGcCPh6Q+5aDdrzw74jjcI5gsi43wtvA7EPjtBPn8x1SFG14C49FTV7c40xA7J/jwrpoBHAzVU4a2oVDVyYmhrolUD2cxqxQqOiECZuUK5eYG7hkevHD7hQ9dW3SJfCiEkOljmWI5oDM8vp96S6g4TEOveoMIuw5fsmG5yC2OmKFnBX+ssL/mBs0zFhPNpUSuQxS45L0rg3pCQxRHqxmBToFHfW0MABpziLjF5izKPEkbYZxv7dzuHwgdGkZoxYJ87SO05N9HZ98dozIEpBIYz9L4E5agf7AHqZsvj9qBOV8JeRUZ7Rzj2TGvJs6/lMdrlFC8RJdZh6tGBmY/vTcY5NqMUoNA4VfNQx13tIgxA7BKXUo4tolfErofhpxtQwbcNv6FNpr34EK/JWcGk2nE3h2p+VVj6Ev5v7FGoNfGiEgCp1zPN70OUu7XchJxUu+b0xnSCgrmrNebUg06pip6XXFQVQRve/mxahCT2H7zjWcmj+3aRgrbibIE2sEVCNPO4vvFEJP4FPga+jZPE4dxE5dmgPqJgsZfpodn6dm/rJFQd4Fv5MDrFgGk
X-Forefront-Antispam-Report: CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376002)(346002)(39850400004)(396003)(136003)(230922051799003)(82310400011)(64100799003)(451199024)(1800799009)(186009)(46966006)(36840700001)(107886003)(2616005)(1076003)(336012)(70586007)(110136005)(70206006)(26005)(82740400003)(478600001)(6666004)(83380400001)(36860700001)(86362001)(81166007)(5660300002)(47076005)(41300700001)(2906002)(316002)(356005)(450100002)(36756003)(8936002)(40480700001)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:29:07.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e77758-64e6-480f-1266-08dbe5ef9ba6
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR01MB6520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset (rebased on v6.7-rc1 kernel version):

- updates the mps,mp3309c.yaml dt bindings file:
    - Documentation/devicetree/bindings/leds/backlight/mps,mp3309c.yaml

- adds the related device driver to support the MPS MP3309C backlight chip.

Note: about the first point, the mps,mp3309c.yaml file updating, there are
      no compatibility problems with the previous version, since the
      related device driver has not yet been included in any kernel.
      Only this dt-binding yaml file is already included in the current
      v6.7-rc1 kernel version.
      No developer may have used it.

Flavio Suligoi (2):
  dt-bindings: backlight: mp3309c: remove two required properties
  backlight: mp3309c: Add support for MPS MP3309C

 .../bindings/leds/backlight/mps,mp3309c.yaml  |  10 +-
 MAINTAINERS                                   |   7 +
 drivers/video/backlight/Kconfig               |  11 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/mp3309c.c             | 443 ++++++++++++++++++
 5 files changed, 466 insertions(+), 6 deletions(-)
 create mode 100644 drivers/video/backlight/mp3309c.c

-- 
2.34.1
