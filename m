Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A89760F4F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjGYJeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjGYJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:33:59 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0607.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::607])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C9D19BF;
        Tue, 25 Jul 2023 02:32:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu9AWD0rp2GU63nX+vvBUlFeNkkfbTsGwAk81YsGHaoEFXcwVvzBM0OZmFfeUlehArbycoPykahespb6tOo7gj/+kZJ56z2QuBaqTfkQUS/hLYDvXqvJ0KEYwyzQVV52qrRBBVSBKwE58Rh4zjDFn5bdwV8A85y1YZTeyeJvS+M8b4G1K2rj5R8Cs1UfgTN2aBAjNQZom5DWl/+5n26hK9eiSRuI/qws+Vpp4ho9Jft9XCQ027nBVeUyofG0JEAsaCC1CGF7X+kIo4DUnxe0vR5cV8WD8GISDsKyUzzpUjtWugF0717zl5doRpT3jwX/HSG+GnMszvFhVEFm2zi4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeZF2GTALl5c3GzY+uIKWc9Iia3qgoKekwql8Jocwko=;
 b=WY8lXq8qAjVyeJWyOo50TttMeIQM/6zgj6IWaq/2X//XaZxpTkFKsrgEhwP7Zlkgs8Sykc2QSvBWKXkwO7LrSC+DE4F/bTmPQY+uG9tFbPIjeCCd+G2cxYM1mP9r8t3jGJvmP4CfFrMGDcR4KYt5TjOd6JxgvGMnbdrp00YbseQXqvNtxc1vwCxCPbZdkM3uS/utqPRhfQFjAastMykmqT5C4jqfKi46sLVVGJQffwjAAPD46dyciY09zU1xhaRy2xSvEdGRX7wTY8d78pShRcLF5/ye2dyz2TbhMSU0qrcygwOGrnQPwepQi1sK3LoxxVLpg21n3KdtU5yInwwo/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeZF2GTALl5c3GzY+uIKWc9Iia3qgoKekwql8Jocwko=;
 b=h6dRAXed8y2S30EBlnLTP9Sor46MLAggQhMSBMQCTtWFO1+aoOj0tZWqDlJ5OMLBOaNHqa5J6kRWFzMXZJoz+XIO3LGK+w5SeHG67gK++uLUYsFSe1rq1keYu0Fa9fct47hl4jDmrpqTM3JAt0eMq4H28G+OMb9Xo6rMe9lz+9seEPPDYjwA5ZnGnEwt2QRA6i8E5xi+6+oz6L/tbtWWA7KRpzZj8Zu+Rwd44gcT625C+1ct0mCNcEWpz4hSy3qs+1WsSN9m9QX+HHxpzrP+N8d/Kh3AdeRVg4TY4jbSNSn6PlmY0YfvEQ38+apR5YiFPaZ+FMMT5Pn66+xL629a7g==
Received: from DUZPR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::28) by GV1PR10MB6196.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:93::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 09:31:25 +0000
Received: from DB5EUR01FT066.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:4bc:cafe::ae) by DUZPR01CA0133.outlook.office365.com
 (2603:10a6:10:4bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 09:31:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT066.mail.protection.outlook.com (10.152.4.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.24 via Frontend Transport; Tue, 25 Jul 2023 09:31:25 +0000
Received: from DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.16; Tue, 25 Jul 2023 11:31:24 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.68.189) by
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 25 Jul 2023 11:31:24 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/2] platform/x86/siemens: fixes for CMOS battery hwmon
Date:   Tue, 25 Jul 2023 11:31:11 +0200
Message-ID: <20230725093113.9739-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.189]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8WBA.ad011.siemens.net (139.25.226.105)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT066:EE_|GV1PR10MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebd7028-addd-4d09-9cc3-08db8cf1ea72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZbCxu5zD5Z7r5Ifbk/tsVysLsG0vqHJOF6A/nCqD0x0A/WXa3UymBm2adZr5olRWi81C+nD5lrCtvZdhsFXWaUQ5G0WkN7oKr849qzhJayU4n33gtogw2mNrg+uLHAr25zwAg6SY7PckJ7AAsDN6k1PNAXAmbSrzmkuG1NQHmyE+4Ev6PUCJYOX6K+orlSCfuB2RO5IJtX7+k0VxORqD2qfgv2RuGBbcEYHFKNolbJRHIvr5bQcYcET/V+poJOQZB1X1pC/+3xEISE7G15YMRvY4oxGI2cO+31RF8b7JZzzYdGV8103LA9Vj4RPX264MD6w+Kj7TUrw2Kdesrcf6gsIfoQ2zH3Pl9HDtCEdJ6grzb2DSMVFIxPlZfK3zKVznHhXuQ77Gv9keoIOPjZfuJywNUqAnx6qzTZgThXMLyFzohOyBs/5ltGtQZDOQPelH/IJpZLAWeldzurQjydKItp89R3aCsurWLgqV0xifGGwzwGt28azArq5IKhZ9voJzjBm+KIWr8nxsRU03J59TdgbgGwds1tr0Y+y1KImmlQT/7LHSHiVVWp94msb5g1pXRewHMPMtLObW8h2Wk6g97ehsTkAXXo9WKC6wd9L2/Ywc+YXDDO5kp2kZLCNID3HtmK1DkgE6SHmYnFMQ7oMAGoudpiPzKOPj7QMUqlf05aXiVFPKSHLBerfFXlenU68YQMjofjJP7PJtB/Rd1Ebr22+Rz4TLuTD1obmSaa7PsAxQC972t1c5B2H/EG3IoshYffdT4KHidmtUxpvi/JcAA==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199021)(82310400008)(46966006)(40470700004)(36840700001)(956004)(2616005)(336012)(186003)(107886003)(1076003)(16526019)(26005)(40480700001)(36860700001)(40460700003)(83380400001)(47076005)(356005)(6666004)(82740400003)(81166007)(110136005)(478600001)(54906003)(86362001)(82960400001)(36756003)(41300700001)(70586007)(316002)(4326008)(70206006)(2906002)(4744005)(8936002)(8676002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 09:31:25.0665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebd7028-addd-4d09-9cc3-08db8cf1ea72
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT066.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two fixes apply on top of

[PATCH v2 0/3] platform/x86: move simatic drivers into subdir

One minor documentation mistake and one functional patch where one IPC
did not read out the GPIOs correctly.

Henning Schild (1):
  platform/x86/siemens: Kconfig: adjust help text

xingtong.wu (1):
  platform/x86: simatic-ipc-batt: fix reading in BX_21A

 drivers/platform/x86/siemens/Kconfig          |  2 +-
 .../platform/x86/siemens/simatic-ipc-batt.c   | 21 +++++++++----------
 2 files changed, 11 insertions(+), 12 deletions(-)

-- 
2.41.0

