Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019C47C5B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347015AbjJKSQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjJKSQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:17 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54038D9;
        Wed, 11 Oct 2023 11:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXdHBdnC6WhmN9PlfkTirPaEkYkML65kRjl2re4nlkNJ09jx80JT2vVIDD/0Mr8xybvrNUazc9hrsS+YF8Ur4HNNq0sOq5xE4Swlvh7HpkMPZR2fdGxrIMaWHSxHqSJdVC2sFxyhwUEJxBJu1Bp2bWcoV6AiV10+G/lUOwOTULe2JH/Gumy5IZQz19RmT6nNWWO7GE5b+Lqe4pu6F+ZgWOXpow5gkmbYnqKvSSmPSZOtyOncxxXXd5yX15gf9OgbywGHH2xKTNZr+9HD2cZp2QMrqQBOQhyPY3TLLbhQFIA0+0bJen+/3QtGXSpGWYHc8MU6+nFLKgtLn2JVfIeHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9VNnrRh+93b9tiZ7+fqQ29BWG2jfMJ+okhxSduWaaw=;
 b=KdKdLg1RH1oN4WpVsw111jvDuzHpMVxO30wO8tcQBrUH+DPm2kGksKw7Qz8puEsoo7C0fUfPMnCD2nB/Uex9tzs9kmx+f2t3D/TxmJ9hrWsA10wHLiiN/xX2Gv4G8cUN//CmW15pciNEswH+WwKZYzegS7iYUioj9KL8kjD8n0WBZkQ+Fcti7IhSgMuKm+eWcaZxMS39cmEsz0/JsRHKZKNbe+64MJolkxfu19IZbY+vjjiXmS8hiKU8PYEJNgJ7O39ZF4tY6q8oTDSu5eOnCPI56LkDBXv3fho6GNd5hrirKOm/g+yy8GaF3/OV2CJDUanGdWAlqR29rIozfFe2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9VNnrRh+93b9tiZ7+fqQ29BWG2jfMJ+okhxSduWaaw=;
 b=rB+J3iFT50VeuhTkAs28X/9WcLga4mwUGKh6aQ4/J8vaw12cNBJjUdliK6j3iKJ8+MSZXVFz0sl+jzsJODsdNxyvbOGrj4T6ZL8FwAJw4WsNtZ3lipM2XSuTZS6JArLKo6LI/ufMedS72LEGAcN3D0M9NLdEu0+bJGxa1egVXwk=
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
        stable@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 5/6] serial: core, imx: do not set RS485 enabled if it is not supported
Date:   Wed, 11 Oct 2023 20:15:43 +0200
Message-Id: <20231011181544.7893-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1925:EE_
X-MS-Office365-Filtering-Correlation-Id: 431bd925-95d4-4136-c32b-08dbca8626cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xxAimYXLwWIUiYQznvLn5SMTRgidD2blBXwI6wau5ivXhaMed3u79M3uB2dcLynqk7ET9SECfQGGOKwQoupurBgYM5ylILXyoTxeyWwn+gLGE7NiK1G0x9dzyOdtSXGL0JsMn5iqoVTFHXoM3gq7BJlV7dfJmJn8pdKw/uhQaEqaE5XnbdClAh7stEN6AREMZu9j2MozqIjqof01n8/oc/oLAkd6zISZz5XMSrqeG2xucFsjjVKdzKT/t96GgqnT2/dF5rky0IOQ3og/NKIklE4nz19JPMeeZFMHqwmrhAHd3nUzk4r9mbVgJRdS5MJh01lEN+yTcln6JXwOVr+yDiIcuYFOR8/q8QKYwythPx7rJWQTpnhlo6+lVp6rutIaxPiEc6dY6yPEOhtAykGaUGkDGoMaF0SfsP7L4r+imiYxzQEj87FKR6QYskgvDHQkg77HH04CDfKagLtvsXbbySZqUZkjeLxfEVD1nLrM1OpG5vbM2UAqDymHDxN+lHyk1QLpVzylT8YhcLQTZTt8kniN2M3xCMkXrntroYjlMhOO0Mku7ILdGusBeKZAAxBQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(36756003)(6666004)(52116002)(83380400001)(6506007)(6486002)(6512007)(1076003)(2616005)(4326008)(41300700001)(2906002)(478600001)(8676002)(8936002)(5660300002)(7416002)(66556008)(54906003)(316002)(66946007)(66476007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUxwRTJlOFNDRHBmdCtVZkgxL2xZWVhxNEVUcjVRUjNESUlmNHdEZjNpRjdC?=
 =?utf-8?B?d2lreEFXUHdSSVRURWJmenVZSmI1Yk9EamRlNmRRTnduNmlYeTc3cHdycWVK?=
 =?utf-8?B?SmJQR29qNUpxY09OQWQzR1dOcDhCVXgvQ21hdTFTNnFtNHdXNDc0cHBuVVJh?=
 =?utf-8?B?bmNxbTJYR2ZOd1RSRTJSRXZkbXNvWmg1MVRQdCtIM1RibUtvQWxVNmZ1K1Rn?=
 =?utf-8?B?dENOZ0tDT1lESnNaaGRoNzFYVEk0dEg1RzRCMGs0US94ZW83cUZZenE1amVH?=
 =?utf-8?B?QTZZTmtuSFhVWm9VZ01iVkNTYUdTUE9Ja1dYOC9BVGd1dmpjN29pM25Td2hq?=
 =?utf-8?B?Y0FZM1JUZHkzL2ppWHdjUGp3T1ltRzNkcFZCZEY4bHB3WVNIYll5N3UyYlFv?=
 =?utf-8?B?Smh2U2tmOHlmNktWM0ZYcG5yRWs0dDN5SjdxTTFEQVJVRTh0REdUajNma1Ur?=
 =?utf-8?B?Qy9RcythMHhSVG5OUU04Vy9iZXRGNGFya2plRG5WUWtxOFoxUmVRWWhacTNv?=
 =?utf-8?B?T2NCY2FyUHE5R205YnBvU01FbXRJTXBQeldDMWYyL0poL1hVYjdjbk5BeHBS?=
 =?utf-8?B?TFFkejJlWUpYMitFSFN2cXB0TGdhV2R4V2RkRlgzbEpIY2ZHN05JZnk0dWNI?=
 =?utf-8?B?WGdnY1pXeVgwMUFqbmNycXYwNVZTVXYyWDlYNWJWcDdxVHJyZytuVTJvckZu?=
 =?utf-8?B?dFZpZSs1ajRqSzZkcHdWRWVZQTBxd2JLVlN4NXM1NnJGWkk3ck5EV2JVZWpU?=
 =?utf-8?B?OGhrcnFXdVc5cG00cHZ6SnJXUXhzeGpuLzY2VDc2ak9uM1JMaG9qWUF3RFd1?=
 =?utf-8?B?SUJ0R3d2YXcrVUZqaWtpTUxJNzRUQUFVSW1RTXRhYzBJUHpJaS9MZWxjWG1z?=
 =?utf-8?B?QzM4bHIyVFQ1d05lUTY2OHVwNi9JaFhtTXNYT1ZyNzFBM0lUSFBHRVlONmhh?=
 =?utf-8?B?ODNHMDZFSlBsdTRoamFFc2xDRE5GQlphL1Z2Nk9jTHB0Y0lHNUc5SDRsM2Zt?=
 =?utf-8?B?WUlNZVkzKzdmb2RXeWtrMGhUOEIzR09lR3hSWGJwamFsaFhpdGlTSFhOcmhQ?=
 =?utf-8?B?ZllFdGxudXduVEEyUWZjeVZ2Y2hYUnpvR3JuV3dZKzVNTWoxL3dBVTllMXRl?=
 =?utf-8?B?ak82eE9hMVBsbFBUYWpOK1NYZXJ3MHlKSWNHdXpKUi82NlBQR1dLQVlQUG1F?=
 =?utf-8?B?dTQzNWNtbnhHWWhtOHZlcWJKdUFPSDBid1lXY1hCMmY2TTZvTitjbjVacldy?=
 =?utf-8?B?TmZkTDlDSng1UXdFb0lYSndUQ2tCSW1Ndm9ralZWcTE5TkNqaU9jUlNnbDBC?=
 =?utf-8?B?VTV5cFd0VDFhRUJhN21mTVYySDFyTi9ReEVrVS9lYjQrK0lnUnJFK0h2TDJT?=
 =?utf-8?B?VXZubGNpbDVtalJxU1hQMWIwSkpmb1lFa3JYL1gyQkhXZkhLdm1OU2tQczNY?=
 =?utf-8?B?Q1JlQXJ1Uk9JZDlaSFByMnZXalNXdjZpaUZ3NXExTmErSUoyRGtUNzRnMkZ0?=
 =?utf-8?B?UU9RNUVTUTF4V3F2RnJ1ZnhVQzY2UWV0VldlTWlwc2U5UWJ3bGNpTm5GUkFi?=
 =?utf-8?B?ZU54YXFhNHQ3clp6YkRERU1GYmFHdTdzT1lpaWNyUDJrNkNQWFFwbTkzMXdD?=
 =?utf-8?B?cHdpZXpzMVpqVkczNmxrd056dDJHQlgxRitSU1Y3M0g0ZE9EVDZqczR1cFZt?=
 =?utf-8?B?Z2EyanFoSXUvbjlZRlkvM3o2QmFzWjRZd2Y0dzNaSVNZRGprdXhCVDBGQzZX?=
 =?utf-8?B?WXZhamhvQ3g1REhrUVV4S2dQWGpRbEcxb3U0WWdiemovZ09DRE5xNEZpYVhp?=
 =?utf-8?B?aEk1YTR6di90eHJZcWJwYUFkZFZ6SFBBMlJVUi9ia2dYTzhCeDM1YlZKekt4?=
 =?utf-8?B?SVJoeWp2c0ExVzlZemllaUY3VWl0aVJPQWUvZlhCeUVWRG00YTJGOVJPMmRB?=
 =?utf-8?B?VlB5cElEbzFJSHJicTR3UTRvYXFlTUtCMlN3eXNvblNGUGFmMjRhVnovSDBD?=
 =?utf-8?B?ajBqWFZlRWU4MG5LdCt6VVZueE5zNDBRYlkyb3BoTkRvWDVoQXgzalR6WnlI?=
 =?utf-8?B?bDhxbjlaY3NpVlM1ZFdhM3V2OGdBbEI5TzVTYS8xMUhNUmxpQ2VjcWt5Q2hO?=
 =?utf-8?B?WVFnSWY0S3ZLVlhRWis0SUZIM0w4dlU1T0VkcmVyNDJtd2pCdHlRM3gyZWww?=
 =?utf-8?Q?qHjIk8Sx5gqsmPF3HKP5MBzmocJCmYQ1Enp6B/yRqez1?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431bd925-95d4-4136-c32b-08dbca8626cf
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:12.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/tuzAMqmoaEiBKp4xbuH72d8BrsCnKnZiQgtEvcb20ar4O8W+J7Cwp3Cwh5MAOKghaTe5URiTw9Zj99P5Q/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgc2V0cyB0aGUgcG9ydHMg
cnM0ODVfc3VwcG9ydGVkCnN0cnVjdHVyZSB0byBOVUxMLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFy
dF9nZXRfcnM0ODVfbW9kZSgpIHdoaWNoIG1heSBzZXQKdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBu
ZXZlcnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJT
NDg1IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRl
ZCBpbiB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBi
eSBiYWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJM
RUQKZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEg
Y2hlY2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJp
dmVyLCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFJlbW92ZSB0
aGlzIGNoZWNrLCB0b28uCgpGaXhlczogMDBkN2EwMGUyYTZmICgic2VyaWFsOiBpbXg6IEZpbGwg
aW4gcnM0ODVfc3VwcG9ydGVkIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU3VnZ2VzdGVk
LWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpT
aWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgot
LS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgIHwgNCAtLS0tCiBkcml2ZXJzL3R0
eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDMgKysrCiAyIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwv
aW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKaW5kZXggZWRiMmVjNmE1NTY3Li5jOGMx
OWJmODU4NWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYworKysgYi9kcml2
ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTIzMzIsMTAgKzIzMzIsNiBAQCBzdGF0aWMgaW50IGlt
eF91YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJCXJldHVybiByZXQ7
CiAJfQogCi0JaWYgKHNwb3J0LT5wb3J0LnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQg
JiYKLQkgICAgKCFzcG9ydC0+aGF2ZV9ydHNjdHMgJiYgIXNwb3J0LT5oYXZlX3J0c2dwaW8pKQot
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBSVFMgY29udHJvbCwgZGlzYWJsaW5nIHJzNDg1XG4i
KTsKLQogCS8qCiAJICogSWYgdXNpbmcgdGhlIGkuTVggVUFSVCBSVFMvQ1RTIGNvbnRyb2wgdGhl
biB0aGUgUlRTIChDVFNfQikKIAkgKiBzaWduYWwgY2Fubm90IGJlIHNldCBsb3cgZHVyaW5nIHRy
YW5zbWlzc2lvbiBpbiBjYXNlIHRoZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwppbmRleCBkY2Ew
OTg3N2ZhYmMuLjk1Y2VjMjM0M2IzNSAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKQEAgLTM1
NzYsNiArMzU3Niw5IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpCiAJaW50IHJldDsKIAlpbnQgcnhfZHVyaW5nX3R4X2dwaW9fZmxhZzsKIAorCWlmICgh
KHBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0
dXJuIDA7CisKIAlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzJfYXJyYXkoZGV2LCAicnM0
ODUtcnRzLWRlbGF5IiwKIAkJCQkJICAgICByczQ4NV9kZWxheSwgMik7CiAJaWYgKCFyZXQpIHsK
LS0gCjIuNDAuMQoK
