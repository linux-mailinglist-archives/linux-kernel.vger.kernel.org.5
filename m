Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0E7F05FC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjKSLdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKSLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:33:35 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B4A171C;
        Sun, 19 Nov 2023 03:31:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp2xRMGjs/OAEPIR4iZshHe4TRW1v14fvnVa9Rsaftbh7ft4DlNWpT8YZsdGAFZD2uYNc0YYiY2E7TVpT1bnfEMclvteirYUivhWBGaGOHBVvZeVH2X6o3ZmsGJw3iOOAWM3+RsMAjwrQsFw0LpmFcEOgVU56ytTrJtS5KE+Tu0WE1R4xQ5WvjZkGpesU931H2D1PW0Lq/ohsrSyK5uUqjiUz+iR0BZJnT7SETMF4IXNWFgtFwGiyS9cOV5vQvTFH6S2YGb8STbrcGhPDlWBGG9p35gs/x68/xNKSqy1pa8zUJlwxaCEqc6KCFzdvMj/PoZabOM3srKHCbe+YOsH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sRBm8gY2tDiUYzcClFGE54s4heCXu5xxHjSH1pF67Q=;
 b=AZ7Ag5nRr0tyLckH38dbkBC1J+I61gvA34zjA0LoeTXeTw0k98d6cb5tLFpov+RWhsGvxLDUc0TU4ArQJd1u7WcCwbylvr8yDeqt3+iztiJfTf4tsGVq4BvsL/eI4WKKmx1y/FXdmtg2z8CW3u1S1FsgSQo3hmqDKNPBmQHIMmx4mTP4I5sd0jYkb1H5CyOyMu2V4dE4u2pLagtFioVw/ElOdZ/V+rVwAzbslhgswqp0sbvZae97Bve5fZf00S/K8sc74UR7anwMshYZOq2+WmOplCTJbARExHLLB30k52pRXBGPxXgcMgqtIxws9e/B3UzNmTAGyiHZANr2MKgfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sRBm8gY2tDiUYzcClFGE54s4heCXu5xxHjSH1pF67Q=;
 b=XofNqO6PcCF4MmU/CFqn9rx8fA2Z9aHxirsgAb/NJqOt/9Zy1L9S5uTO78yibqKE8Bp0K+mePZoolzFeky2DjI+U+1tis791TT6UaoFQr8wY4Nd3Cc/kujLlVNJuCSBi+S7m7EyENmjzUqiL6t7wy6FS85s/dO/cH8Z6yviCaJk=
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
Subject: [RESEND PATCH v4 6/7] serial: omap: do not override settings for RS485 support
Date:   Sun, 19 Nov 2023 12:28:54 +0100
Message-ID: <20231119112856.11587-7-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: ad1d9d0e-d8b0-438a-fea6-08dbe8f2ded8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sx2pcj8IhFGyLLrJ93U04KCqNpFpRn6F9CjOfv60TqM00A5aLN0cDERetSZrdsPcreArJX3XPOZVx5TC3V2otFjhGZ5eaHNQMpNjWsZXW8SiaaIxsmsJxcd6gTGTqE+DTCvCRn0C57TVRRa2/z+Cie5bko5QpdqPzcPMLBZYMYsoUO62OMxG3KdilArTWrH+Fj6Nl7xNE1hGX8ZoPN9pm1rPgQxU7sUdhF4/5K7g+w265iSQvGbj0EgjJoyNRWEhOtkwtlX4BDB6Dff69vRZuoi7YUvSAp443bzOyh5xDhHTXKOArO3ZC0y/moJ8fCfDmki+L5SL5tAcXImbk1bPDA/3C9I+Tij1nerjeCocYokdGksrYqJuJCLftjsi7GWphzl8ZMEmjsb4W2Sfw8wb7b4wJIYj/WcVxKd81TxMM+v6oKDgret/DZXbBTivxFNHEFDEHtxeqDZvgzP5kNuDz246P/LtHirH4L8CgyC3Cv6264ghiZZ9rksryXftLohY+dmcZM//8teGmKWvGx4j9wHyIIK3N1oarZ4VbRNhZ4OYhy8GBeZPVHAEWxYCh02n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(83380400001)(1076003)(2616005)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJfAXPFQ9frJgoDsfZKkDxUsfRSudgM6Vyl9ML77X0M1Sm/+8x8G2sEwzdpB?=
 =?us-ascii?Q?F5t3NmfDe3GRvjYnwK3KqxFyOii57nI8HT5EDn7q4QMv0NCMOfmtmYhujwx9?=
 =?us-ascii?Q?J1sBxeuABLp1wef78K41Nw+YqEFfJf+Ej2lzxidaX7hY3HSzywgo44UvZbmo?=
 =?us-ascii?Q?8SPGq9Xt6lB6rDxBbW44KWxdgtreBa2weTt5gwpc6+6+tZmrIuUeFqCtBXLO?=
 =?us-ascii?Q?N2Vu3+sHTP8Nf3mFTIVWjr5ONWVljoJOlyiQPmalSyJMaAdN/7lU+4zp+dSK?=
 =?us-ascii?Q?3CVTApEFFkXCP34jxK/ORzYhag63Udo460+DB6I4kCoZNii734FA7gH8nV5a?=
 =?us-ascii?Q?dYyo1Yd3nvBEbIXJm1KIm4rBxM+TaoVD6heLZrueRIxj8FbaWNL8fa1QcGaq?=
 =?us-ascii?Q?1+4y3HwfZOZx72U7+3X1Ke8zruWP3XW0Q1A3LN6uVmzc/CCDPHM1qOTLUg0x?=
 =?us-ascii?Q?6QqRBTuat1HKt2oURRNspveQgVloH2pwCmoG81FSKueN+hPnPe2ZkBJfak8I?=
 =?us-ascii?Q?JUd8JnXIT6Nmsbh2+QXJtBK6bSWBrr1TGfizq9Qvvo03LzoG/4dl/xBs3eds?=
 =?us-ascii?Q?n8q8dk2dY2jg1ZV09quae5iOpmIbT42eXp5K/r58db87BkLk4pGHnElkswt+?=
 =?us-ascii?Q?7mCWXb3i6JQum+i4t5PzJOeiwK9ivdYGoDeYIxZPw/2rXF6GV8NKUQbe2ILb?=
 =?us-ascii?Q?BWjo5YidKyE6r0fHqthYPoC/rvXYHLZOH3MU9smnXepYkgmvHPhLVgeN22N9?=
 =?us-ascii?Q?WTkJp8+g0zxGdLqjjpRub4rco3RIezQ8kqn5qaalE2gSJA1UqSb37vQY4aog?=
 =?us-ascii?Q?9tmtjJ0WiAGL6RWemDZcYIH6vT8vsdRFlGE+fqXHB/XNf9REK1sm37RRM+3y?=
 =?us-ascii?Q?1/Jh+W4LwPZ2iamLZVosAIPs/yGPBtNE/c0peGpRtZeNjp0wLGty4ODokXXk?=
 =?us-ascii?Q?cY24ZTsvG2djB9Iop7Q0Ltz5C+ChwoXjZKmmSqYKudS/vwEcaNECOth+XJKu?=
 =?us-ascii?Q?j0+vqVlBhzoJpoU7rslOEoide4rSYiawvPtesJ17gDY0zngx5uQnHFz1y0nS?=
 =?us-ascii?Q?KIMWdGBQnmsGOd2qUUSmm6Ifzb7QESCQ30UaNOsLGjuBz3kF5Er4tDeceS0b?=
 =?us-ascii?Q?KLzSQ7EHfP8MQ/BeUPVFyaihDLtVq9n87cNeJegPj+7Lj0d+v+7t0HxNT3J8?=
 =?us-ascii?Q?kgYK0zNFuH1QxqDHkFX2f+vqqojCiDe/MLL9UXw6UtH9qfmiIqcPKR322Blg?=
 =?us-ascii?Q?N8bIONiml6wEq+HGnwmNR8pLJ49Ho7rOWXbhOPSwqSsoFZfKXOfZv/lapryN?=
 =?us-ascii?Q?lKBUmHjHES+p+D1QePiXQC4KS3xkcbcWK9JfagkgiBthIA6icRU+s5Loeamh?=
 =?us-ascii?Q?r83G5LZ+XucJGA8KRfaQGcA614G5y9N8mrhTKAoDimgBfIqbedFzXfYd48lu?=
 =?us-ascii?Q?N0gFBx1hN4cSwnuopX/R7aVKCz/cHD8530Doxk8/NKICfYcFVql7Ibkud3AJ?=
 =?us-ascii?Q?YoqIefciYmpgh4vNKq+9NOD1VEWV/jcbSpuW10mgz04OqMYc3jgyZM7y8fWq?=
 =?us-ascii?Q?EPTzt0OxfHyGHjWLgzQtdEEt3qS+IyYQCIwXAH7vNVmUE1gPVykmiA5xDG7S?=
 =?us-ascii?Q?pfDm9vCMx6bW6JjAptFKgNA8O1s2VXy7YOMgMOJmvTW7?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1d9d0e-d8b0-438a-fea6-08dbe8f2ded8
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:30:02.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Wshz98cV/eg2kskAUluFsjLgwjQEN6fLYnzTLdTFXIVdHr407mDbSZEhGSY/8rLo6Mzdk93h9e3WBES0k7Bhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1060
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
aWFsLmMKaW5kZXggYWQ0YzFjNWQwYTdmLi5kOWIyOTM2MzA4YzQgMTAwNjQ0Ci0tLSBhL2RyaXZl
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
X2FkZF9yZXF1ZXN0KCZ1cC0+cG1fcW9zX3JlcXVlc3QsIHVwLT5sYXRlbmN5KTsKLS0gCjIuNDIu
MAoK
