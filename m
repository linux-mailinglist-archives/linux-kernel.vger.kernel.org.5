Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ACB80B47B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjLIM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjLIM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:25 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB71724;
        Sat,  9 Dec 2023 04:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGVldkkRPUKN9fDU3woKlupuoUDpVmI60cp6menB2RCXvO2hDF+NhgdGLfY/p2R13OqHjQGygQm+xQiRG2REbYWnVq/aaUYY+iQMq6Gji+cWJZ7Qvw3Cn9s1gYmjhA/BFi9y40ZfneXO5jqy3A8qpPCUnUTBX4xLbVlOPpzvVLj8rKrhkmVARHl5VMk3X8TJVA/m7EeU2F04PDV48tCDd0D72y/naEJZSRwzJznm3C8kHsbmAqiWKxqrhM3FcalGfckcvqJQa+1wWMAgxFLeDtaOAncG6jIANFSr13TzBX7DT+3Dpr7he7CROxQ26QyREAaonr0e9Kd96E9OIfGlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCBLbQLe3EP2f7hu3Tl5EQiwyecLdsnuvnoNW4MOtrQ=;
 b=Fwi/S4hdEVpgiDtN806+kDfa6X+4p6EBkB9WXKXueyHTh5ud70iRhp+xou6FNVCTQ+fjJrkg+NvPPzhUDD4vjY1oWVQ6072gSmpd6qSgv+e37z7s1n7J7+lDnsrlMcZIhq8k9isNDZqCgUCSu0HA9eJhRIFmfdZ2II1tjOTq8jKravLHZiqcB8UbjoHUXjzYdnst0bsMnFYC5CBmTdTEopSpxFiSqaBvmo0A68RuPk95zh2OcRNHwdN0oKLBIyYKHZbJpi8NKuyOr4iPDoTvJ4quombglmKjTr/LFrE3WgWHqCTW4s6CFg0ej+HkeDJ5jL64Ahg/HPoDCeab7S63IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCBLbQLe3EP2f7hu3Tl5EQiwyecLdsnuvnoNW4MOtrQ=;
 b=kimpEe5ZaxqTZLyzmHr8rBvqCP+1KPZWLa9ycVO0djZOW42oDoVha/oUxD3mODCeQKJdYa3QuYQBdN41kZj7jp/isMYL014imhFTXF3M3BqMk3qk5IifVDkWy11QncQNY+9TdQhepXMRbIec/lcwMxA6CsDuDt7CBWpyEzMpe5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:20 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:20 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 7/7] serial: 8250_exar: Set missing rs485_supported flag
Date:   Sat,  9 Dec 2023 13:58:36 +0100
Message-ID: <20231209125836.16294-8-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0555:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e739ce-24e5-4821-f388-08dbf8b6a907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOdQDXFfhLn82yElBF2NN57d/Ps8IlmMgi90v/OgrHeBwyXPgg4Wsae5jzyvwzgJvpJlKXVh5DsR9XGMOEm5Y4UW1m4doefPTZ9JssvkEDbAXzjYsmA7p2KKLmtvclxLOTI58QUKnk9UqIbqpvHmA0d36BCCBCVAud57RHnFXo8qK++9eU2wMqNe0LQdS9HD4breF53VDW3z78fN3NQZUIRBdA6s+7aHqQQ8J5wIYZDAT8cG4aFPCwDJ2W7bAZlfM7Wh//3sCSWBw0IWjduv48CyVpCM+HMKpOy6lNhhq3mWruIPNmG5HUpRxmHqwzSYNvWDAvjDcUkvaVDVGXaAeuHuPdJX6BblvDlmINNYCApW38mK5BMKmHP6cnkN6tbedl1S6VNznOLsekWX6UYfWOggU9QxvMy9rpYgIX0a+JcWU+UjXwrX8MgYz/GngovHhNZlhi7nzUc5k6Zr58K2zXPv9J5IltLGfQsG95O2hD+LozT1mtVFaok/xmplLywzrHEXY01SjeJxwYCa+K2cOGGhOZJjOm2WLVQDn//EoiRuNiJ2g4i38RPKNxiXVd9oRiPVkm/PIi1kgNQw+i1fVzDRjGl3JH95k/xEni/A9tRvGVkSksclKLHPTgj/YQ7a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pdah+BdrJS/RxmI5EAukwsyKzXR/d122mSictOTuJ2IE0uMzKcGgYA2U86Hv?=
 =?us-ascii?Q?BQ7K+NXwX9EYpa+vuGtK1qEudr5QGGF1BxWUnGLlITsXC+AT+yW76tPpjEFp?=
 =?us-ascii?Q?tg+/Vbo7Dxqg2i43hzSCF4zpKr8FIJANkTDO6dYoJKoZHc1VFflBAH5cBYLN?=
 =?us-ascii?Q?pvrGJ2+9tPIl/AooaEXNJIKcPxrrPjZVrve3ATPdzK1A+pP/TnMLpNWWVFfY?=
 =?us-ascii?Q?IhT5nYXcMzi1S9vN1+s8Hz7teh/Fy4rJK++6zs2fS+7nNhn5aGRZat0Tpg3+?=
 =?us-ascii?Q?HDLZ3qkSI/zPCLEPIhMsAbDqpAjTeJQuUF+TnArVJ3IqeXyF3fDKZGLV1CWi?=
 =?us-ascii?Q?EpGlEFO9q1KDlNA1qAaHwaudZyxUrGuTyCHRknTVvWnuFquPRlKBtMSZACR0?=
 =?us-ascii?Q?6QZ9ZnWWoQmwgY1h2TEeTtKj6CsIuZeCb+CrIJ/xc1ORu++K3QKcJLvkbd27?=
 =?us-ascii?Q?0uCaYgRNjsOE0E0iWNsLzUCW+MhJLJk1aNPTNB0tEatmVhUD1uphARwQdwdY?=
 =?us-ascii?Q?KdAKVb/jskUCUo+zA1j+GZZMvlBpDjkSZpIuNMLxNb8cGFeOxqKEdrc0sq+f?=
 =?us-ascii?Q?bURz4T2HLF/u2BKGuDQPhf2XpEs1PeZWQaRL5aYQiK8uCPEg3yUIfQB+qO79?=
 =?us-ascii?Q?oL1yrz6xdWD9Bd6K3mGiupUkFuabHqAzmDWboxYkCVeUX2Ms6a3UKTfN8LNS?=
 =?us-ascii?Q?rcYYiOciYVcaaXvd8JDcT6pmwYf4gBdOSbMhogZDZ6eYMuObjj8nwmtmlfcS?=
 =?us-ascii?Q?S0I4W0Yf5daONlspPgZapdpzB5qABL5SuBR39flDwe0MAeQCJi8RbHQODPtX?=
 =?us-ascii?Q?Y4Mo4n5dI1MiMFfoq2I9ie78lfz/I2oMSJYhLKn81BHr51G4COkbtYAF0Krh?=
 =?us-ascii?Q?TuFzZCsv+GYjXfwdckbpY5GEc/6v186JSjdbyMQuNm+y/LRYeeAJXmDW+SPO?=
 =?us-ascii?Q?QJyiUpJ9gOZ1pKswa5JSmfYG3NtbHEvDYc2d8jNVxBGqSrUAw7rBrPK4Nrin?=
 =?us-ascii?Q?vh4ktvGFbVPKrgl0W4VI4AgehChP9wzyv9O1PWZyoNyyzjpgIOnjojhi7xc8?=
 =?us-ascii?Q?kjVnDuRar19aCeTakmxD+oDNdjIkaBWiIF+VsfVYnnvbHv4JBsHnFHupRcIm?=
 =?us-ascii?Q?2cziBg5A6hLcpB2PvoDRBQUQVe6OuWOzP9YORAmUxZ3ohWLzArhcMmwX9nh8?=
 =?us-ascii?Q?V0h936QdpIpHjBb3DyKzczciZJeg9KEFZALzsroU1FZI+xCCumRtYWmzGSv1?=
 =?us-ascii?Q?E+Foxn5yjGIEZq18+0OYLKFFxgI8cQ/dIWlOry5dzBoKElNAbEbPBFrAiQNs?=
 =?us-ascii?Q?REjNk1K9sd5CovgWEvYIupsna5vCEbx5Nhm48btCGBWdnlVYnq7SB/NRh3mN?=
 =?us-ascii?Q?x5BpwyO3Uwe1XVqnpz+wMFgrBhWuAPxkbqIAyaYeAcLG0YFbe4Kn+mZzhzKz?=
 =?us-ascii?Q?AtPGKhiu9CQvfg1dy/hfeteu1+oCENsZkkXPs8waOCcqi8y7hg26+OURwRsl?=
 =?us-ascii?Q?kjtX/s2oOi5CZYCzry/CyGBmF4uOEg7vp5RyQri4YZsRWDYNyQTGEY5zgEEt?=
 =?us-ascii?Q?zR7uy8ym8tWkMN6r/VMQqbfeTw5Jpynz3NphEy88+kPQ+e6JSPZfMdghklX9?=
 =?us-ascii?Q?NoZk11Hm6tAYR5vLawqPX4/+4KlnCqcxcYyqkMjm87Vq?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e739ce-24e5-4821-f388-08dbf8b6a907
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:20.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AQG1+7gcjayBSpolyk4t+yUcyYNDMEHxnW/LEaU6W2hCxBx8E/2dJGtP0MHUhF4bkewy3Xvb65XAZa19nu/5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0555
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
