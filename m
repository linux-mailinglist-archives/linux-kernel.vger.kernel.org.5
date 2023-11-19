Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3497F05FF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjKSLeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjKSLdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:33:38 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2065.outbound.protection.outlook.com [40.107.104.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ACA1BDF;
        Sun, 19 Nov 2023 03:31:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuyzIgxhSE9dxlsROJxWrIvo7la+evCTSzzXOCygkmwr+lgycWuoY6cwilWZETGLUSgH2qvKJp0bdIGdWFeweGlYRoIXs18EIwwEL3V5PrLYO3xilxltc4zmNERYS35ub/HJiIGs+B6rLmT7Ck9U2hxke4IXaRn/dKNU4drqtA4KbFF6LrcZvwZ3A3nSbBQt3Srzh/JePGkmZbqywHvfmBNqEAM02iQbpqT/v57ROYHZiLB0qizo14v3L6vfOxHanhc9HziMk7g+aONXGGP8aXj64lzMGc77jqinXdxnH/0PCCvat9XYtF4CCxvilDhb7uba/bnRA+Jrbs9O7EXERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCBLbQLe3EP2f7hu3Tl5EQiwyecLdsnuvnoNW4MOtrQ=;
 b=fepJF2Wn/8eIdW3ceXD7VNYyv7X/lAeo2fe2iozGy4EXOgQD4ZuCDTZJlTIf0p3F0TpbjZ4hRLNRhB+iGPVLOzGo4UJ4JUoMr04UVd2M+OirMcjkkwbmhl2LZ0L64Hk+jqU2bIoMv7+YXXQyA7UIqPou8E1+9N7tmgAlLWN6hwBeI+rxOgrWsTlGAl7wlwIuTAiXMuSr+tIwuXnSdnIta2ld8weksE8sKfVN8NfnxjV5eysqQlEejxvsY9ElQcAM+qAdVojAqbqC6o0BCwgIXhj4m9GxSaaRij5V75OtspWHwOdUZBJNZIDe0xraQv973IY0k9D8gfvyxuyrMzvBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCBLbQLe3EP2f7hu3Tl5EQiwyecLdsnuvnoNW4MOtrQ=;
 b=PtERTnGtHgR0xI3i5j6IrH2PybvrEbCVTQz6A7GGgWcZmSzog74pEa53ndbvDZevdpjKWksS4jmvlsaBw7yAE2JeXCRIT/JXpyibLt8X1ZQMEyvGotdjCw2BUX0s8L3vccGg8uJlJnZo3FwLY4S29SmVRrF6J5U9Ah/POJYQ+cE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1060.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 11:30:02 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 11:30:02 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [RESEND PATCH v4 7/7] serial: 8250_exar: Set missing rs485_supported flag
Date:   Sun, 19 Nov 2023 12:28:55 +0100
Message-ID: <20231119112856.11587-8-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1060:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f578803-9a79-4f9d-fa19-08dbe8f2df35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OSq0oRbRfkcJICtkyU/cBDmNyCzhEl3ssvSm/BUzyC/cCI+RdJ1DE5Vwvp5GnR+UD56UQRDgny3MLOCg+68NAtD2OElIGVkiuJpp0UYMrQ6Ke1gP55RgPg1YFIaGciFwX8oEXcX3mYPTIOow13FmgKVvzVsxRKoguTSMyKmRhwDsGqekc+m9WLTMN4rtKDP5H6K3K6iINBCZ6mUWhlpRYHiox4ckhkgVVlB1KRPSjkjcUmIkZP3iWvLjPlqh9XcmMXG/BdWqLuaEWXZgTGmsGN/7mQ/7+bn4qeZihLkkcpkz77FTEhHFn8X8Ofz4UF+poVqvLVn+RnJ77k6Vrm2/tPfJrsgwoZLhYuwf0wsiri6aBhdIBODusSX9aejxSmsgfOuxOazdgsF+ptHTnnzw8qIFZM6SAvWCEioXJ7yCvOkeiSKVjwiPKqxTUz9tDdtjDzAG7M9gSUs5EdenYKOk79TIQGbElsvTl0FB+qs/TEMWB2JlZB6JwgJqtesOE6lWg6p69ldfrHfA/jptmIupzNc9dmURWt8oKz5IDHgAbqUcuE2jsVf6M1fWHV9hoRsFp1jLBiwJ2Wm6d7SE003Et6lDCNPRoEUhYwe7HEY7gGk/QOZAuRYQgD3lt3LUtQux
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(83380400001)(1076003)(2616005)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vh5jelDQHAy7TiIUuM68eBUvVDrpigeeqH/81av+zLrCCu807fxNkT/HLNkF?=
 =?us-ascii?Q?GKHLk8ty4nz7UrFF64KvFnGw3nbGHFEJ/qsmDQT1H49dYFMG9ZgKst9PRlfU?=
 =?us-ascii?Q?mexnsr7NhAI2Dfdtrnx3t4ixmwDJfmIvmaVWlVMyswnfd4OPrICsmTCDLaF0?=
 =?us-ascii?Q?GHtXh00ymkCsBNDc9V67S1aZEDcZFXToVhiQF4zgWgMEUiDIjSFGqOJEsgf/?=
 =?us-ascii?Q?YuNMIARWk+BGVt7gpXwDsLt9obucmbbCFYGFnGZMoRQTOzkhopVxtodq65yd?=
 =?us-ascii?Q?1t4oMTfQc8zapmG/nPIMpe7F9QfFSF8y+j/AqlxkDWcDCSTAMaf3f65OmHmS?=
 =?us-ascii?Q?X9UzX6ZW/HqxBTy+CvbD+xFFjUKBHpi9gN50AN38u1G4T06Co4xaJ+ON2I0X?=
 =?us-ascii?Q?IJoL13oUkzGYEUQ8Cc9D28dUh1C2f5m5LfXP4rexQ54c0zK3akRn/8VBDJJB?=
 =?us-ascii?Q?8kLo9MmGyEZsUxMxZp6nZZ/xxpsurWADDHUv0mBVTYhoyYQWZm50CMKnz1dB?=
 =?us-ascii?Q?q/1ZvsWasOYCgrs9NrlYEORsew3HgWgy1PZ0dtUn3lsL6LQHTx0VXtkoAC/0?=
 =?us-ascii?Q?3XKKqJX7wrLMm564NMysxbNKGQBvvcHMrtzBy3jGA9kItgisAazkP8w1qCtR?=
 =?us-ascii?Q?WLmg3AfH/XdcCgTiPYYL7rsBhBujn1wWh8L7soXksQLL14t5/SOjozYGxDvi?=
 =?us-ascii?Q?yY33XmRcRZkKc+FcSWSwzWuq+PXiUUuoAPhgnYLgstqxFTsg2D4/Pk6UKiNp?=
 =?us-ascii?Q?kCC3pdxTPP16aUQrmOpY9Nwmfou9NIZY/umiZdOgLkAJikziUdqU+mlhoyfk?=
 =?us-ascii?Q?TmKHw3GLDCdDtuqU1U9jVt4UTcz09HAqYLd5NM8sw/gWs5GJR/3Co7xygW5K?=
 =?us-ascii?Q?OFMe9YhHjNoDpGQVeDrmegBwM+lYxZL2UDwfWSzd6HOkstFr59YJRtAkqqOK?=
 =?us-ascii?Q?Dqc7DuxNsVj/BThZ+3zleGK9ZflL/mCNKjA94AP7ALRoRMWX2wQpX3tLpqsG?=
 =?us-ascii?Q?taqdcaOWZ4NP+JWP5quvOXb2yOMIyHJDCgaSSNZlKLA1DVSm4gaTAvexMMnU?=
 =?us-ascii?Q?ujQhIol7oaFJiRrCrID1Ltn+GYA2egm9oZOuXS5809m105EtaOiCuD/v0thx?=
 =?us-ascii?Q?bipgSOdIJoj2FYR5f0y6DlXmC1DoHXsqfA2ASw83h0rcUFjBqlh/asWwTYyJ?=
 =?us-ascii?Q?MegdPScHDNGlRAmPYg0DqaVu4y89XdkwblVawaLilQSlbhmpjHvkaWW4xi7z?=
 =?us-ascii?Q?tmLJXiUETm839Nk8MORk2n3JcIwGPg4fmg/EtMa1VgD8ZZ9RRS/btByxwllV?=
 =?us-ascii?Q?xo24lma4753J/0W8l9F2nNDUOPnnkogPoXEy1mmuPbOv+ZrknsqvEglTpJai?=
 =?us-ascii?Q?kujMH/QKpiaEHRWUNdUfKv5F1i4ZSQb4Ia/w6rEBlfLk5wjrawPl80gk+1OR?=
 =?us-ascii?Q?Lrh1Co06qZnjZhD4oBfL4bYudVGSyBW9HvK0R+1uqQN7zSHJ0bDUxYWZgu99?=
 =?us-ascii?Q?f35/bOsZVI3y1fcSaNXDJ5qPFk23Kmhe/htDpicH3BqOISRSkjtixqCSNXeL?=
 =?us-ascii?Q?IkplVXmOkkMcBmd5nIX7I0gPy7yWhi2icqTl4iJsu7S0nGw68JE4Ll7Sp0uy?=
 =?us-ascii?Q?V9K5Ky58SDeARFfaSen9s+WKGNIXulmmhrfbHL61UJSr?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f578803-9a79-4f9d-fa19-08dbe8f2df35
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:30:02.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bw151wiF43gNnoIrhPWPTpYV0V15zdXLLvWliVLJPKgk4bNMbJucQpto+Cp3t49twg/1EqsTYrU28cVw0hAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1060
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFVBUlQgc3VwcG9ydHMgYW4gYXV0by1SVFMgbW9kZSBpbiB3aGljaCB0aGUgUlRTIHBpbiBp
cyBhdXRvbWF0aWNhbGx5CmFjdGl2YXRlZCBkdXJpbmcgdHJhbnNtaXNzaW9uLiBTbyBtYXJrIHRo
aXMgbW9kZSBhcyBiZWluZyBzdXBwb3J0ZWQgZXZlbgppZiBSVFMgaXMgbm90IGNvbnRyb2xsZWQg
YnkgdGhlIGRyaXZlciBidXQgdGhlIFVBUlQuCgpBbHNvIHRoZSBzZXJpYWwgY29yZSBleHBlY3Rz
IG5vdyBhdCBsZWFzdCBvbmUgb2YgYm90aCBtb2RlcyBydHMtb24tc2VuZCBvcgpydHMtYWZ0ZXIt
c2VuZCB0byBiZSBzdXBwb3J0ZWQuIFRoaXMgaXMgc2luY2UgZHVyaW5nIHNhbml0aXphdGlvbgp1
bnN1cHBvcnRlZCBmbGFncyBhcmUgZGVsZXRlZCBmcm9tIGEgUlM0ODUgY29uZmlndXJhdGlvbiBz
ZXQgYnkgdXNlcnNwYWNlLgpIb3dldmVyIGlmIHRoZSBjb25maWd1cmF0aW9uIGVuZHMgdXAgd2l0
aCBib3RoIGZsYWdzIHVuc2V0LCB0aGUgY29yZSBwcmludHMKYSB3YXJuaW5nIHNpbmNlIGl0IGNv
bnNpZGVycyBzdWNoIGEgY29uZmlndXJhdGlvbiBpbnZhbGlkIChzZWUKdWFydF9zYW5pdGl6ZV9z
ZXJpYWxfcnM0ODUoKSkuCgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQtb2ZmLWJ5
OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMv
dHR5L3NlcmlhbC84MjUwLzgyNTBfZXhhci5jIHwgNSArKystLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvODI1MC84MjUwX2V4YXIuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfZXhh
ci5jCmluZGV4IDYwODVkMzU2YWQ4Ni4uMjMzNjZmODY4YWUzIDEwMDY0NAotLS0gYS9kcml2ZXJz
L3R0eS9zZXJpYWwvODI1MC84MjUwX2V4YXIuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1
MC84MjUwX2V4YXIuYwpAQCAtNDgwLDcgKzQ4MCw3IEBAIHN0YXRpYyBpbnQgc2VhbGV2ZWxfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlv
CiB9CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGdlbmVyaWNfcnM0ODVfc3Vw
cG9ydGVkID0gewotCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVELAorCS5mbGFncyA9IFNFUl9S
UzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JUU19PTl9TRU5ELAogfTsKIAogc3RhdGljIGNvbnN0
IHN0cnVjdCBleGFyODI1MF9wbGF0Zm9ybSBleGFyODI1MF9kZWZhdWx0X3BsYXRmb3JtID0gewpA
QCAtNTI0LDcgKzUyNCw4IEBAIHN0YXRpYyBpbnQgaW90MjA0MF9yczQ4NV9jb25maWcoc3RydWN0
IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXJtaW9zCiB9CiAKIHN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGlvdDIwNDBfcnM0ODVfc3VwcG9ydGVkID0gewotCS5m
bGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JTNDg1X1JYX0RVUklOR19UWCB8IFNFUl9S
UzQ4NV9URVJNSU5BVEVfQlVTLAorCS5mbGFncyA9IFNFUl9SUzQ4NV9FTkFCTEVEIHwgU0VSX1JT
NDg1X1JUU19PTl9TRU5EIHwKKwkJIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFggfCBTRVJfUlM0ODVf
VEVSTUlOQVRFX0JVUywKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHJvcGVydHlfZW50cnkg
aW90MjA0MF9ncGlvX3Byb3BlcnRpZXNbXSA9IHsKLS0gCjIuNDIuMAoK
