Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF37C5B1E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbjJKSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjJKSQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:19 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42413E0;
        Wed, 11 Oct 2023 11:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHLxwzJaMi7/ikHZ90F4TWvBBJgT5J2SlDkkAVtSo+uby1PqLgq2oN8R2KbqbCi3JQokkz25OlRw54mPgFXAvUxidl1ttKd4UITgonO9wKit/Q2AbJr98YXeg6ElQEmHncEgWa/eER6jqVEWZ9TVnPnd4DT6GNz8/rprIAJwsXj55jzpqlOxAlo2ZMslzRFcYURLpt6ax3jv0LtzzNXMKoSHwirgLHWFRj7vAxAxcqaUrJocD44jWlUzO2g2Dt/gpekRKZvw+CH3kUuZeHfMIE1pRQ9fTknZ8kgji/pmJFeBtMMbklAqzLWEEWVyQVDDNVu3ww81BRuAgL/fQaMFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/vH9Q9jKs2GzlPx8DEoi1T0SBAlJ5DZXJzhZrsbsp4=;
 b=GevGLuqtgfS/OdwaU7N817b/o12cz4KFlsOkXpramlpZNVP1VLVIg9ov/9IoUiDQd7VDiRg/HlXO1erHChayv31FVvbyF7sqVhM4I1PrBsb1Z+a8EgCIi6lQdue0LXlseP4P/JkuXo+lSISxL8lSX30mJM60r+ykS4X51ar7F/RdDEGJEyghMgAhet7NWesiCZ9iVBhK9drE7Z/OcFkeFq/AjfNglI1YPvgkh+qPMqLUXZQDTn87a5yyqftUVlILu/HC2iWvsyqZkDYxDSWEmLVXR+cso0F6SGy7XqgfDkCI1nW5nL2bg8vZN5E9RjBaxB6j8UcJe2MvTPI2iClxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/vH9Q9jKs2GzlPx8DEoi1T0SBAlJ5DZXJzhZrsbsp4=;
 b=U3Vl78QQwjdHhVCmURIJv9HM5N5OdhaidFv8UBto3TBpWYcg7N72K34jy/K4UyYEP7askgQCvOx/yTQLWEC5kTwsPavJ+klkjSO3rXwmtHOIZtfSnXXaDKhZ36D3ofw5PCoKkzWsaREMbFM13SeuCEe+AT8gGLk00LdFA/LS3XM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1925.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 18:16:13 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:16:13 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 6/6] serial: omap: do not override settings for RS485 support
Date:   Wed, 11 Oct 2023 20:15:44 +0200
Message-Id: <20231011181544.7893-7-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1925:EE_
X-MS-Office365-Filtering-Correlation-Id: a446f01d-0f94-44fe-f897-08dbca862727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7w5gboKttdz/qV5Am5syTj7/z6gQ29fipRuq46KvlKxKuFZkVFT//Eht2JFIvO5u0yM65ikKeIU1j0LcAwWwqypmc9obGZUWlQOOrpbo7J25hTadwmW4pTGUP+plkg0S05sxNsO8j+I8s7Cce9AqT/IcZn2mLbt9HvqCdbqFzzuM8VMEz9TUW1Qlo21yKg5Ba/sAelwgu+nB9QlIL9uCMduVrKn1E11bq2RJfxiBWSClsIAtWfWDgpU7BcNYXtTe653MjfC6kUUTyl2SQFB0PK0kh3ImttRKh+rIOK/jqKW90HQPI3kL4+8PbYweEDKu+rcOYgVT7dAt5Py8w7A968nrGQol0cnBHPA3lkLeDhby3QnOEBMuPB33cPirg1IkcvTcZ9fDe554GxBvBC8vy8h/ea/mdr4qkPpR/kzZl7dqzg6Tw1rJoi94phzDASLwcw5/x/p3WUJ040Cu1/uTCw2/PwhZIKf/uR0KOUheUeEst8XcBQd83k0m/xPl606mLriH5NPLkl9/6ivJ9WsjjLbqaezSX11G1EuyEr5uezODTX0rlnDNSmo7sYDOY2Dt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(6666004)(52116002)(83380400001)(6506007)(6486002)(6512007)(1076003)(2616005)(4326008)(41300700001)(2906002)(478600001)(8676002)(8936002)(5660300002)(7416002)(66556008)(316002)(66946007)(66476007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ih6gXcvcdV2lH/hnOb+5pdWSGdpUQm861V+JvN4/jH6Py3x9a2fwfchoE57Y?=
 =?us-ascii?Q?piicU+FxMJpQyXPfnS0wdK3SoHclQqPEKINOrY7Y+xhIVV9XYCLnPK4G8Y6p?=
 =?us-ascii?Q?68uIw5TFPphHNz87oOew8BKrCCEOvTa0lgFvU1uOx2kInU0aiEc/MJtY3U4y?=
 =?us-ascii?Q?ZA6wRTpovdKJtE06pxCwzozz0IldcOLbqTHvKuE3Y2t2f3XYKypa28zSz0ky?=
 =?us-ascii?Q?Cn7Tc//jhZXBTfLpJbeYL+8Ty3yzLFJqov+yjkHJtTsYK1+iQLq/fC0sdxZo?=
 =?us-ascii?Q?J7pR04FmF/CRLUND0Uf9jjzbU5ySDJZkkRhJTqurycx+X+LT+AvGZTyFcPqa?=
 =?us-ascii?Q?OnnWR8WmaeYO68Erw0EqlsVzJ0BXRXlKuanATtsLf+yY8bpECwdi6Ad3DgkF?=
 =?us-ascii?Q?x1JdNd8Gr/jDr94Nyv5qG0bxlAPvAwu7soq0N1Imc4wZ21hiqL3e4Ponqh7S?=
 =?us-ascii?Q?olOdc6fadsNH+lW5xak3kZy8gfxOrVat7VP7VnMpLQzuq5PXddB4pg4R90sS?=
 =?us-ascii?Q?Wh0m9tsiJSqID1u8Lha/5v3TCMhDotFI4lYXRqqFj8Y7ST7sq0d2GTSUHcyH?=
 =?us-ascii?Q?Vh5gitC2UR8TpQKLEJiIgx007CmiD31n0DdyNpQEy3fhAx0DLhg8jTERTBM2?=
 =?us-ascii?Q?5/ULTISUOj+/sbfZfmCof14NMJhVVr5jGsrr4fxCnnZYXGDTkSgPLxfVWN5t?=
 =?us-ascii?Q?PuUqISsD1zE8H2ir4mTxPiqomgr4ePSkIayPUq1Q8bQYxVsCLb/ijPKfk/hV?=
 =?us-ascii?Q?MpMAfDJ0q2Kv+ndKShnpdhFwBVYqZUdxOaL+vvpL3vkao0cHOhog8sr9SK7v?=
 =?us-ascii?Q?QicXl3L5TUclJzRbhsKdxUqKJxRayXhpizo1kabZBnfGeEVElLMPzKp+uCdA?=
 =?us-ascii?Q?8jNrZyR2vDIt+lYVV4dqsnWnpDPSDqUc00Gxy9xAI3hnCU9X+XeRBfOO+Dua?=
 =?us-ascii?Q?Qf0I124u2pPKXwcDE5uzalF2cj56EH1H71Fe4zTwRAMivKnBL+rrD6esmG1d?=
 =?us-ascii?Q?ke5A8vn63nWg05XM8TChEPtyxGxsGN/5acYFTuuP2jytC+XtI2aVbOXgEZWE?=
 =?us-ascii?Q?ZCUwRfj7k5eXk+hIhbXu0QVHF1Zba6cMeh7PNO8oVQrA0DBrB4Eg0lg0vQtB?=
 =?us-ascii?Q?Zl+sqJSUIViDGWeTvOCifr49bQ1V5s6hV54jpcUjBSRS56RdKy3eX3w79BwZ?=
 =?us-ascii?Q?6IPLUfD5Oorm6OIH3gDgsKq+VgO2w2J2uJ03Jx2ydXG2R6eCrORwrGUk+6Am?=
 =?us-ascii?Q?sVhgIqnG3ZNQ+kHuxBWL+QyTuTEvs1gsuwe1UBoJvR5T6DO+SrNrF3tyl+SS?=
 =?us-ascii?Q?5y/en3l3RVIEk1M0TU/4WkPWcYkUYQkBeKGYQ3PW4RsQbV6QBoFSZdPFhIB1?=
 =?us-ascii?Q?EfVPw7thURSggXtwvGFDk2bUwTHoH7GKOi4r0VmxyQ2VpuYBHXGlTYUPXmrO?=
 =?us-ascii?Q?tB/0SZcTMAok5RCVQyJo2Mxe+KrvF8i/HjGQyv/WI8eZqBOKYLGLD3pZ2NKQ?=
 =?us-ascii?Q?am6HEG5kYNFHxnzwp0+jgeWrF3KSnZBeODxrVfYydiODjwDUpGrxh5NeJVJH?=
 =?us-ascii?Q?KO+9Enuc+GkDKcqS1FckQinQcvFsK6Rs9BkOW7r98UpKNMaL/olAn6p6Dtfn?=
 =?us-ascii?Q?D6yNJwfQ32Dt92w2KUIIUJqJj0G8paEQrgJbihTqQcKf?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a446f01d-0f94-44fe-f897-08dbca862727
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:13.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqHMcAUc6bKZCMmtEMFn+zx0LMPmplMhbZiJlg1u9qjMZ3LQC5MToJ5aDE0F7w1V5gCd0fAQH3xgqy2Gdge4Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1925
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gc2VyaWFsX29tYXBfcnM0ODUoKSBSUzQ4NSBzdXBwb3J0IG1heSBiZSBkZWFjdGl2YXRlZCBk
dWUgdG8gYSBtaXNzaW5nClJUUyBHUElPLiBUaGlzIGlzIGRvbmUgYnkgbnVsbGlmeWluZyB0aGUg
cG9ydHMgcnM0ODVfc3VwcG9ydGVkIHN0cnVjdC4KQWZ0ZXIgdGhhdCBob3dldmVyIHRoZSBzZXJp
YWxfb21hcF9yczQ4NV9zdXBwb3J0ZWQgc3RydWN0IGlzIGFzc2lnbmVkIHRvCnRoZSBzYW1lIHN0
cnVjdHVyZSB1bmNvbmRpdGlvbmFsbHksIHdoaWNoIHJlc3VsdHMgaW4gYW4gdW5pbnRlbmRlZApy
ZWFjdGl2YXRpb24gb2YgUlM0ODUgc3VwcG9ydC4KRml4IHRoaXMgYnkgY2FsbGxpbmcgc2VyaWFs
X29tYXBfcnM0ODUoKSBhZnRlciB0aGUgYXNzaWdubWVudCBvZgpyczQ4NV9zdXBwb3J0ZWQuCgpG
aXhlczogZTI3NTJhZTNjZmM5ICgic2VyaWFsOiBvbWFwOiBEaXNhbGxvdyBSUy00ODUgaWYgcnRz
LWdwaW8gaXMgbm90IHNwZWNpZmllZCIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClNpZ25l
ZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQog
ZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2Vy
aWFsLmMKaW5kZXggMGVhZDg4YzVhMTlhLi40ZjdlZTQzOTIwMzQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlhbC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9vbWFw
LXNlcmlhbC5jCkBAIC0xNjA0LDEwICsxNjA0LDYgQEAgc3RhdGljIGludCBzZXJpYWxfb21hcF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQlkZXZfaW5mbyh1cC0+cG9ydC5k
ZXYsICJubyB3YWtlaXJxIGZvciB1YXJ0JWRcbiIsCiAJCQkgdXAtPnBvcnQubGluZSk7CiAKLQly
ZXQgPSBzZXJpYWxfb21hcF9wcm9iZV9yczQ4NSh1cCwgJnBkZXYtPmRldik7Ci0JaWYgKHJldCA8
IDApCi0JCWdvdG8gZXJyX3JzNDg1OwotCiAJc3ByaW50Zih1cC0+bmFtZSwgIk9NQVAgVUFSVCVk
IiwgdXAtPnBvcnQubGluZSk7CiAJdXAtPnBvcnQubWFwYmFzZSA9IG1lbS0+c3RhcnQ7CiAJdXAt
PnBvcnQubWVtYmFzZSA9IGJhc2U7CkBAIC0xNjIyLDYgKzE2MTgsMTAgQEAgc3RhdGljIGludCBz
ZXJpYWxfb21hcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCQkJIERFRkFV
TFRfQ0xLX1NQRUVEKTsKIAl9CiAKKwlyZXQgPSBzZXJpYWxfb21hcF9wcm9iZV9yczQ4NSh1cCwg
JnBkZXYtPmRldik7CisJaWYgKHJldCA8IDApCisJCWdvdG8gZXJyX3JzNDg1OworCiAJdXAtPmxh
dGVuY3kgPSBQTV9RT1NfQ1BVX0xBVEVOQ1lfREVGQVVMVF9WQUxVRTsKIAl1cC0+Y2FsY19sYXRl
bmN5ID0gUE1fUU9TX0NQVV9MQVRFTkNZX0RFRkFVTFRfVkFMVUU7CiAJY3B1X2xhdGVuY3lfcW9z
X2FkZF9yZXF1ZXN0KCZ1cC0+cG1fcW9zX3JlcXVlc3QsIHVwLT5sYXRlbmN5KTsKLS0gCjIuNDAu
MQoK
