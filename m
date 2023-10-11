Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989507C5A62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjJKRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:12 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EF8F;
        Wed, 11 Oct 2023 10:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klwwR+6mfGr75TVyoV7h8z9micylMuyiaZQZ8n1PCXEoOacW5oYAIDf6juYJz7wyiSze955lSyCBSyj2bLksypvZF2ZV5EpOM4JGayxLCK1y/gy8elOjOrKOoMWoRCsWG7aqKkMfHryJXGdpDiJK1uJ9BVBWu0dT3wWeVf5hgmD9V0bF2cI8MPoDgBR9q5mOxLqKk77p6OwKcPkQx9HVPLRriePHXNsAxfh8mjdGX59iFxdsJrEBW+2sNcEi2awoNMBSnkjH0oKmU3HZCZSVWFyZDgRY0jcYG/70AKZxBWTI+pKKAgfglPRmbCZQQqwQwTU6puK8Xd3P4n3E40VTjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KQh/iKhf9LXRW6pVMZ1tYdiYaWX6FeHAsXrrGRngEU=;
 b=AUz3U2fU/BT4VNr5sXIo3f5tdyEclvTEcCcz4TpXXqbslp9rvbZHZVXGQhq7/eBzlrPQY9E4nd66K7jsCNDz03gsJ6sZLJCdDVjg6vt03g1ZmLM/2vI9M7tF/BzQ52vi9ETUMjgB53XKGbciiusNmi3sTumGcBgLG8dF6dMLBAopnJ8I9QfI+RCtxwPx8ttZZ0BaAxrDSt2Ix7Q/PeoC0HhFkYpX0UzNSMymfJUcb8sfr/thjQIbxa0cNXhTFeOrI0zzFwG3y1rvJ3OzyGh3BhchQeMkyb5J9lLTG4/wZo2Y/V4s3Nq1bMSGsI5flO514iqIN7QeG28qNj0y/zCFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KQh/iKhf9LXRW6pVMZ1tYdiYaWX6FeHAsXrrGRngEU=;
 b=na+PDpR1mbteH6+kkcXBGL+92Wdded29TmdqZ0oqp8SO4L1B+VLuAeZRdNcAldvlalZkct87JkPWNcjjSEHIaWVuBEhHwSuaA5c89+WdygkvRmKvOEKUMwz8jLU0+iomderGUygye+XYLOVZhi5N/g9nDFui9DISmY9Yp9l3bTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1187.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 17:39:05 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:39:05 +0000
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
Subject: [PATCH v2 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date:   Wed, 11 Oct 2023 19:38:23 +0200
Message-Id: <20231011173829.10508-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
References: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: 783012d7-e28b-400d-331c-08dbca80f6d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGRCJjbeSdmcDRTtJiWANZpXMn+re3GcZBJHlcf/hsmZ7D+RudCRbEOpBcZouBoAjPDaWTTnUdgLKJGL3yIQvCV3Zf3GokTLAJR6d+uLyIGAcN3/M/ESQHazdtzrHsrwTV3PejFAYUcIch6q5pO9UR9gRs45ckY1CksWarlvJ19L5o+MRxoBcXUuitR02eMc9J0CPIqZ9FznT5vgpUTTrBNOdTvYNdznISQ1TunYs8VLL3qWNySJflFxrV7VjiDu74isH63E5zZNPusY6iN/gQsNMUw2mqFsU5YhQwSyDQuZWmBbau6sqw+USLJ/wE1XBgb+cDUfSlydjlviV+edAqK751uOlQnDY343uUPs6LdELXdIL31ldfofVMMcY3z6HEMUT55j1yyA3NXhNsoOG7A5l6TSfuacvCb3q71WY1JdmToVs8Mty3/qAze9oGdqDndPIg4UCd0mzQyG5T6I/dzj5vMWmpTGdWQG4b54T/GvuWQYUiQfxLP0IPtTmbYzFYZjcwxUBqfnau6dv9huMhlCveWj4VaVyKZAWnLMve5qpKtBhcLjbxiuiWDsFzjb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hrjWRu5dgBrm2wayejrE3KsI4QEYzrpebvOGLMFrW1Sge+v9auE70OjU/At6?=
 =?us-ascii?Q?xY+8GFBTDZn71GiQnBT7XlMk6ZU+r5qIpJXbCz4WTfTbvDkvEg/nNL24Naak?=
 =?us-ascii?Q?1hW1BSijtPHAVgaza4awWXVkJixOIW+qeLrBOFE+pSxKsHCg/8EXsZ5W5lZt?=
 =?us-ascii?Q?zheKgYjAFOX6iuHKD/t5HK+NvMBLZqRgzi6EURCE71xEbTblkdfO9yiDANeb?=
 =?us-ascii?Q?hSZLEmtYaqEP+83EREGnJ4i14APGGR1n1nBE082+EklQS3pFYgWsPBVg95Tk?=
 =?us-ascii?Q?t4nIyixy9By01d3gJwsyRYvJApC1rKcPiuanFCnhSZtN71ce3xR9b5aPvK6P?=
 =?us-ascii?Q?GUdzK0Q1Cs9i5nn94Vc4Ymkh6XC7RwSTBOP/YIQtNyCjKpkY+X68AewfTbGd?=
 =?us-ascii?Q?pLfVEj5f+hEKXegCCKh9klh/27TDLsIRFRLfF/C4KfsVQjtrjns0rgDKHLSm?=
 =?us-ascii?Q?sbgFqdPlBhAsb3pOjUyERQ0sjlwXvM6F1apzW4tEanVoq6/YUMmr1eyRa0bN?=
 =?us-ascii?Q?WCJY6e3O0gOlQshnSRQbkPJdJ5IjuHMDC1eFVsropiNv5w0uG2cYl3xO6XUL?=
 =?us-ascii?Q?vzY7W1MqG3gmr6Kf1Yc32D2zH02HF378rGAIoCcZ1/LjAqPvbHgP6068j+8h?=
 =?us-ascii?Q?yssDUqOqhe6ECtqtpDttsfv5rX481wWGTFWbjkYH8PHW6CsksVkWn1OwDqR9?=
 =?us-ascii?Q?eEhf2K8/6/QUgrVkrWweKPDAptRdKQpqhE5JTQWvePl9+El1B9IivRy6ZyBZ?=
 =?us-ascii?Q?cWt1F6wpyO2Efa5/Tjno9cNnYY8EhBPpvZNgNeRhxG2zMEs9uDYbrUcY7tkf?=
 =?us-ascii?Q?N0SEEzc0QPwQjwFRnCO4y8mBvOzS1+SPWiliaWk4W35QvQdsOGD8TEMqYHTF?=
 =?us-ascii?Q?NHVVRwpYX6tc5jFvg1LPwEMXz0VB5F+ACe5jw7iW8KX4YUfBEnD4dT2dsjfA?=
 =?us-ascii?Q?eg7JfXc9bwgVFAH1Bg1FYA/XmTdrN+1Mc6g3Xp/Hgfe9pYwOJcdKCptgBvMa?=
 =?us-ascii?Q?V25Cbf2VL5uUjXqnJFPwN1XaKyiNRYsd36mNSjYf8JFJNm+5ik3WNjk7E75a?=
 =?us-ascii?Q?loIOpk6YO/DGjqVsHLhjOyUQfeucdsG5cDGSyHT1jGpoGWRCjo2yYHR9ld4z?=
 =?us-ascii?Q?F0Dyftv9CB+j+aui2/MkXe9Qldqk3aoivhLBETCiLMwg/84JayeOP9Jl6un4?=
 =?us-ascii?Q?TLKdRhuCdpdRU0zfHugJk5RbnuiNeZ5PFGK5H53DsnKA8lreHIJiZlAOHmch?=
 =?us-ascii?Q?qR6zewD2cr/cWqOdoqREmtV2/1tWvWtAjgkRZZ4yOH3znHYxS9hkXj7f99Ef?=
 =?us-ascii?Q?ib3uVijoiFbu90mcausMZdtQWjI8xpvweos41GcPpkLbt7WRL5k+xFSJ3y4l?=
 =?us-ascii?Q?mscG9Fa2yhCPjRsxKslgaOwabT+ioLkgxjV4SW6E+m70PMNpNWOEW4r2lSeF?=
 =?us-ascii?Q?3VfSog8cqoHIbf8DiK4tIqnRpsyhe3fTWNYxm1JW/1YerCCGEHqrm5o2nQjy?=
 =?us-ascii?Q?EZry1SMqpiIkiKm07QQhk9V3B9M2blmZibSdI9mAigIjK+/rVTxzf/kx2y53?=
 =?us-ascii?Q?Q66zazXGgBvTncqx0JU83Dek+Gvf+XZcq6D0RMVJsmLN9l37NFAcKukEEwKF?=
 =?us-ascii?Q?zxgkcaeFhWXv5WlklTWT/eiyNexmNZ3GZhUBjl+Xu0LU?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783012d7-e28b-400d-331c-08dbca80f6d4
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:05.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Snc63m0C3MogJcDZ/TOJFOnkcz7rUAIvNmIXBirTZkHZ8ZX9NGgdCcFJF2ogsv2Q8u/kV9TbUD2Euo8ykP63tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1187
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biB0aGUKcnM0ODVfY29uZmlnKCkgZnVuY3Rpb24gYnkgbWVhbnMgb2YgZ3Bpb2Rfc2V0X3ZhbHVl
KCkuIFNpbmNlIHJzNDg1X2NvbmZpZygpCmlzIGNhbGxlZCB3aXRoIHRoZSBwb3J0IGxvY2sgaGVs
ZCwgdGhpcyBjYW4gYmUgYW4gcHJvYmxlbSBpbiBjYXNlIHRoYXQKc2V0dGluZyB0aGUgR1BJTyBs
aW5lIGNhbiBzbGVlcCAoZS5nLiBpZiBhIEdQSU8gZXhwYW5kZXIgaXMgdXNlZCB3aGljaCBpcwpj
b25uZWN0ZWQgdmlhIFNQSSBvciBJMkMpLgoKQXZvaWQgdGhpcyBpc3N1ZSBieSBzZXR0aW5nIHRo
ZSBHUElPIG91dHNpZGUgb2YgdGhlIHBvcnQgbG9jayBpbiB0aGUgc2VyaWFsCmNvcmUgYW5kIGJ5
IHVzaW5nIGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcCgpIGluc3RlYWQgb2YgZ3Bpb2Rfc2V0X3Zh
bHVlKCkuCgpTaW5jZSBub3cgYm90aCB0aGUgdGVybSBhbmQgdGhlIHJ4LWR1cmluZy10eCBHUElP
IGFyZSBzZXQgd2l0aGluIHRoZSBzZXJpYWwKY29yZSB1c2UgYSBjb21tb24gZnVuY3Rpb24gdWFy
dF9zZXRfcnM0ODVfZ3Bpb3MoKSB0byBzZXQgYm90aC4KCldpdGggbW92aW5nIGl0IGludG8gdGhl
IHNlcmlhbCBjb3JlIHNldHRpbmcgdGhlIHJ4LWR1cmluZy10eCBHUElPIGlzIG5vdwphdXRvbWF0
aWNhbGx5IGRvbmUgZm9yIGFsbCBkcml2ZXJzIHRoYXQgc3VwcG9ydCBzdWNoIGEgR1BJTy4KCkZp
eGVzOiBjNTRkNDg1NDM2ODkgKCJzZXJpYWw6IHN0bTMyOiBBZGQgc3VwcG9ydCBmb3IgcnM0ODUg
UlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKRml4ZXM6IGNhNTMwY2ZhOTY4YyAoInNlcmlhbDog
aW14OiBBZGQgc3VwcG9ydCBmb3IgUlM0ODUgUlhfRFVSSU5HX1RYIG91dHB1dCBHUElPIikKQ2M6
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxs
LnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAg
ICAgICB8ICA0IC0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMTAgKysr
KysrLS0tLQogZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgfCAgNSArLS0tLQogMyBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpp
bmRleCAxM2NiNzgzNDA3MDkuLmVkYjJlYzZhNTU2NyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkv
c2VyaWFsL2lteC5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwpAQCAtMTk0NywxMCAr
MTk0Nyw2IEBAIHN0YXRpYyBpbnQgaW14X3VhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3Bv
cnQgKnBvcnQsIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvCiAJICAgIHJzNDg1Y29uZi0+ZmxhZ3Mg
JiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKQogCQlpbXhfdWFydF9zdGFydF9yeChwb3J0KTsKIAot
CWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bpb2Rfc2V0X3ZhbHVlX2Nh
bnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAotCQkJCQkgISEocnM0ODVjb25m
LT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKLQogCXJldHVybiAwOwogfQogCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IDdiZGMyMWQ1ZTEzYi4uZWYwNTAwYmUzNTUzIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMTM5MSwxNCArMTM5MSwxNiBAQCBzdGF0aWMg
dm9pZCB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBz
dHJ1Y3Qgc2VyaWFsX3JzNAogCW1lbXNldChyczQ4NS0+cGFkZGluZzEsIDAsIHNpemVvZihyczQ4
NS0+cGFkZGluZzEpKTsKIH0KIAotc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfdGVybWluYXRp
b24oc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKLQkJCQkgICAgICAgY29uc3Qgc3RydWN0IHNlcmlh
bF9yczQ4NSAqcnM0ODUpCitzdGF0aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV9ncGlvcyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAorCQkJCSBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkK
IHsKIAlpZiAoIShyczQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkpCiAJCXJldHVybjsK
IAogCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV90ZXJtX2dwaW8sCiAJCQkJ
ICEhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9URVJNSU5BVEVfQlVTKSk7CisJZ3Bpb2Rfc2V0
X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAorCQkJCSAhIShy
czQ4NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYKSk7CiB9CiAKIHN0YXRpYyBpbnQg
dWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkKQEAgLTE0MDcsNyArMTQw
OSw3IEBAIHN0YXRpYyBpbnQgdWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9y
dCkKIAlpbnQgcmV0OwogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgcnM0ODUp
OwotCXVhcnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsIHJzNDg1KTsKKwl1YXJ0X3NldF9y
czQ4NV9ncGlvcyhwb3J0LCByczQ4NSk7CiAKIAlyZXQgPSBwb3J0LT5yczQ4NV9jb25maWcocG9y
dCwgTlVMTCwgcnM0ODUpOwogCWlmIChyZXQpCkBAIC0xNDQ5LDcgKzE0NTEsNyBAQCBzdGF0aWMg
aW50IHVhcnRfc2V0X3JzNDg1X2NvbmZpZyhzdHJ1Y3QgdHR5X3N0cnVjdCAqdHR5LCBzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LAogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAJdWFydF9zYW5pdGl6
ZV9zZXJpYWxfcnM0ODUocG9ydCwgJnJzNDg1KTsKLQl1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlv
bihwb3J0LCAmcnM0ODUpOworCXVhcnRfc2V0X3JzNDg1X2dwaW9zKHBvcnQsICZyczQ4NSk7CiAK
IAlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOwogCXJldCA9IHBvcnQtPnJz
NDg1X2NvbmZpZyhwb3J0LCAmdHR5LT50ZXJtaW9zLCAmcnM0ODUpOwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYwppbmRleCA1ZTljZjBjNDg4MTMuLjhlYjEzYmYwNTVmMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3N0
bTMyLXVzYXJ0LmMKQEAgLTIyNiwxMCArMjI2LDcgQEAgc3RhdGljIGludCBzdG0zMl91c2FydF9j
b25maWdfcnM0ODUoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9zICp0ZXIK
IAogCXN0bTMyX3VzYXJ0X2Nscl9iaXRzKHBvcnQsIG9mcy0+Y3IxLCBCSVQoY2ZnLT51YXJ0X2Vu
YWJsZV9iaXQpKTsKIAotCWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKLQkJZ3Bp
b2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvLAotCQkJ
CQkgISEocnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgpKTsKLQllbHNl
CisJaWYgKCFwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbykKIAkJcnM0ODVjb25mLT5mbGFn
cyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJaWYgKHJzNDg1Y29uZi0+ZmxhZ3MgJiBT
RVJfUlM0ODVfRU5BQkxFRCkgewotLSAKMi40MC4xCgo=
