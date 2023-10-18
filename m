Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287F27CE54C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjJRRuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjJRRtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBDD115;
        Wed, 18 Oct 2023 10:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir/xu8jj/brKyr8EdoM/iyZl/ho1UERPFGAsXiJ88LqFkHlz5o2wjXe/OVyxAT3CluBoKXeMYqYpAWMZr3GjzMtPRCKzGw07cE28jgmZy7TEQSRdMl+IluNcXqAREYIxcrRCKyz/HgcVpRnRPAJesQcvnn6iwaTMci+a2t6huOLpjQamfwmR5k9+iQ7haj9JDezTS6OOTscJ3gEt1e3MVp9UJvXLExmnFoTWcsN7m5D32gtRDXjhqzs2sIRfQ9dbPRXRh9xEjSB+RebeScHNZKlssRHSzItTuN/qL+q2BTKUdWTp6zIKKFTMnoYHpU7Q9aqjTOtjW4QmYsNjU5qnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/vH9Q9jKs2GzlPx8DEoi1T0SBAlJ5DZXJzhZrsbsp4=;
 b=Y7dqoMSie3hYNki6v3NH0JcfTG2LLhojE2KGPhRVdx+BN+epFzYHYB/70FOJmxCpjRvYvoa4xYg5f+A646gloWWZWhMV1BxuM4FeuI7rS5rqpVNZ++dDL0bjHf+pys5KiPv6nR0ihEYWFGnkmJzbBFzaHS/nB5Fy6h/FaUJxxQglxnornDtIcxEfNgMk/m2vTx/gJQSTBbSlXNiQ2tPuLi8dd21hopL2CATCy+/HndWt0kIVX44WyoqMbUTs4RgQbhBFe11iml8SyR6SNU0oblTznxEPHK8hxhXhLYh33qaKoi/c4A0cAhPw02tKTSNkh4apEwRTdZXT3cbfWlcpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/vH9Q9jKs2GzlPx8DEoi1T0SBAlJ5DZXJzhZrsbsp4=;
 b=GYTZBziUvrEq5AnLQr0+QYDpXMfz27fmrhSSRAnHGzw1iglOkVbwooCNpNclsqZtOaqGuOKuxFmHudFBPLmHuYS2XsqwqubUu3qdnZjB8qhLw7+xKPVnNG4ZrwpNTI0RyRizIY7KfdW28jb18dTxgwUH6fUwZl5KRKMy4Rzm1as=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1478.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:49:40 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:49:40 +0000
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
Subject: [PATCH v4 6/7] serial: omap: do not override settings for RS485 support
Date:   Wed, 18 Oct 2023 19:48:39 +0200
Message-Id: <20231018174840.28977-7-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1478:EE_
X-MS-Office365-Filtering-Correlation-Id: b418d7cd-1bf0-4084-071a-08dbd0029a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHAsiq3XvAxdS3WWCIwFicMti2yPapSJO9fk5y/kCh2nB3Dwkp2jr+5XpBhMnSjD3MI6k3vOAYaZLmeJK0ywHtITk34ZQ0aqAI7bHUoVrHqqXDqowR7fleEMQ9Sw6H5Ks2DoZ1cj3gSQnDv/yNP7yTjD9VpVc1HTS0ppbTBujU1+iEpfwPvwIyFgwd8VUsmBjhNNFtJLQjNUv6XgtjMsHH0SP88trX7dSKUW8J27Uf66Y6Cmts340mAvMoYRufGAu/Geu+NhRjeWDMRrrrSYe8uLHjMsvcigB/rMM3Ci+of1y/8SJoQI6jzY7QfepFu14wdLg+X4Os2/WxqKedvfSowpqpJEMBh9Tl0VqpFG2RRbQGzovAh00AbwOMpRLjTnXv+UNh0GGfvHw12HLsJWLGpXJ4CJqYTUOCAyipJm+5pdErhv86+fRVQBDjJN963W1w064ulohxrRHROTsBkeHq2iaWTDHbTNf72BQ+iHyti4R1UP6Tk+bRDIXA0tNer87VrpTj0AJAM9ejLFh1QAQS5HYteWGwAjnYZEOaPWJhtZvYE7NeBzZ+Vq+YvixNnG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(2616005)(83380400001)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SOdOzTbHzjsp/2/fgazchfTclQfhrp25bQ4MxcewI2BzGYsmJlRxMKAUzulQ?=
 =?us-ascii?Q?3+rcBNioIcEdmgXXbRmCFSxI4FJt0KYADOGemdVirBMvN6npYsLT0wbH4dNb?=
 =?us-ascii?Q?7TFi+payxIAqTnLKY6jgiFqLCQXCQWFaREHs5TXKAIsIhDlBrfaTfUDdm3cv?=
 =?us-ascii?Q?vNIGyfgS+PNvLhP7PhmXeW/l5roZBWijWqAGV0tJGP6My+ae05RXehNBkPzX?=
 =?us-ascii?Q?TX15RHN3wAseAcAv2chOsScze1VS7O1PKSWPfRhI+raJ+MeOFkX+0B2JLEkS?=
 =?us-ascii?Q?arAX+6oiwksdBHI32F8//xjX0nBvnEhAxGbzy1gllDneN5w5Z0A2Hi30l+yc?=
 =?us-ascii?Q?sEt489Z39RLHyC95LTOjfHh4a7bbIIqbO9QdrLAbu/+3qXCmpEPwcnI/yTiw?=
 =?us-ascii?Q?7I6rgD96y+dzpuDaEEUhLxCHDY9UwoIHBDZenEJYEo0YUq8IvybuBslbE0xG?=
 =?us-ascii?Q?/4GNP6SJSw97SDV879ptSxEjkS3r42Cze173QnIJLWmEQyVErXsmULRZg9Er?=
 =?us-ascii?Q?8xiU1v7bflZBYVFUzVxG+98M3AcE66lh3QFSA14iH+H+7zX6U9rCvt7cZM1T?=
 =?us-ascii?Q?YPi7f6eG2OOdBqZlRUz1W5NJim22VLXsqU9Mqx0dzgC9WAAuWsDDQWS8oekh?=
 =?us-ascii?Q?FQBrjh+ocyWvltXM66mZIAywme0yFG0qzaJycYpQEm02eKiCdIl4f2zqv2gT?=
 =?us-ascii?Q?dYQ/yX8r6invBWmdVj8/tzp9Iy8DOzpoLKgzq1i9bEoB0UIBcTVWOM7uZsSt?=
 =?us-ascii?Q?wa0Z3yGhagOLdSQdIKCnjiXhXzd4UZJRXq9hZQ2pMRKGjHh+CAqacsXUb0FT?=
 =?us-ascii?Q?qDe1RsbqMp0EKdsvLKHuDWWpgiwqi39FsUPBFXm8g/8jUsaYpKZvB3yxSjiq?=
 =?us-ascii?Q?D7Vj8wB1dXO15pXEqoRdfR1V+zpg7TO72ZySJiimHFeRo4FtcNcd4S/imWy2?=
 =?us-ascii?Q?UGtFgm9rlaBZ+AR9ko2GjurjmvFNRkf8kcdeHSXn/t0PMU9ka2WZElAxtm30?=
 =?us-ascii?Q?ZwSmdeefLpW5hz0pOQAIzUwz9M5LzoC9x3uOmiKPOLbomgoVVDAwJUY1lzD8?=
 =?us-ascii?Q?gcbMHs0tazHw6ir3o5gaWEQtQNoDcnEscud3/8Esv4JtDKYLX0DbGUUV56H2?=
 =?us-ascii?Q?Lp1FA6FV18jk25j9zxS/0CqUhbmTIEbVFqlaV6hjT4excLQwPF/wjasC+DjZ?=
 =?us-ascii?Q?LX9HwugwbSP9HaYcBUZPUaPpaNTTsYEg+yaeZGYMnq/FegOw1MAgprF+okJm?=
 =?us-ascii?Q?qzy6Bumsw4aP6hmHFEROk4fKEnegQaAxfI2caqWbgkm6rMjGft/gHMc8EffQ?=
 =?us-ascii?Q?sTj6zyBLTGdX7c5fIOWfEEziJkmY42H9GuN/4EJ+49FLlYAOfs/ZcHCeFCxM?=
 =?us-ascii?Q?lpYJQgzgYfwGQbT8E+heIdGBqp6l2ZXY6Eq16FAUBiybJzeiO79GZpHoaXDV?=
 =?us-ascii?Q?Gv9/ODNOCo42iBH4G5fOkbigN62eoz6TsQ3NiOO6Jel0HvIAFEvS8E/pSmdi?=
 =?us-ascii?Q?scd8MQVUZFrGoYAK27bz0vlu4Pfpg7vvT+nK1ZwRwRd/HzADrljZ7xUtQduM?=
 =?us-ascii?Q?XAavl8+af5sy3dNPU/YMDL2+qFmUOmGpQdE7TQcTD6xA4lWGGFBJFPLw9ofp?=
 =?us-ascii?Q?IwGD02va3l0d2uDrndEjEAcjPJBLa/QCP/HARf35aod1?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b418d7cd-1bf0-4084-071a-08dbd0029a82
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:40.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDxx/nWxUXTX6mEinBFWvpZd35WRx4a2pS2N1/jsgQBIJP11JRchSNQ2WqY0KE3jW9K+eJHzEM3+f4JEmsmb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1478
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
