Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30167C5A65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjJKRjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232655AbjJKRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:15 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CA6A9;
        Wed, 11 Oct 2023 10:39:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHq9G8iW5Y/QKfhvI7TrnEm9OYr+Hr6JTly/F1TrZQpjJs+HcIMxfqAUf6yYfKrpOd9kHDYPNIL6kvs8y3Lrl4kV0sLDtNWYQumDmi2fjC1NXz1sqslUvRr1jG0OEd3ephyUd13vsL8bnvUS2n3tcD+gfVEhTrDuCwpc5iWHwk984wtzuydI5YPT4JF+xkG/bR0NwSJLvS2E7sRvL3HhKhpdgRE2oVOY9YM4sLR5FigSUlq3KZYRIKRacNHW+0a1zN2CjMbRLMd9fF34BTG7PG4Ey0Q3DHZlLh4l2B94W+35tgYKZEErB+iqsLHRCpBF7da3lVPerooYmaW9XryFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfr9CVtu2RhfuGF5Ku22UhpbfvaQTz9uuOjeoqXvcnk=;
 b=WFkQRrsaM7bh7KSZO7IVb3S5uydf/O9itgmU94qj8eWsHo3QNT0x4U9QhIFVfna/elMQfqyQaSPR+ij+XypQ1cdrAPLLpwi6xsMK7EDvUjk/OF2FGj9YQWuNYKpo/Y0d8fuO275ARID03sBr8kRzOuS0LMfN3r+lWkCaZyqQ3k179XuJz3Wst6K0pFVrHvX5ftGYVyBnNvuBCy0xqSc73KOJ1JRF8AcatDtj/Vx4eymuI8ZK49DG5CUAWOW/gYSndMCcwOv2mJg5g9k93OoRLSSOdG/EEcEjEBmOKeFZSZeqb0JDxPC8sqLDiNaClPX6+ts1r/JcpMj6h6QL26F3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfr9CVtu2RhfuGF5Ku22UhpbfvaQTz9uuOjeoqXvcnk=;
 b=r4AiKIoJQJzvgW+IXJ1Dz/LXsF89G5OSVbEyxXYyLTCCow4214Vb0uzPoF32O7d4prv7Na5Mv374wrz1/AdtrxoyqKi1PmOJj9U2D4YGTnexhv0Eu/w2CKep/lMSK24MKumJFYZM6iq/3e3q6pFTXYrCm1KEX06GB9Ck8ESGRfo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1187.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 17:39:06 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:39:06 +0000
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
Subject: [PATCH v2 3/7] serial: core: set missing supported flag for RX during TX GPIO
Date:   Wed, 11 Oct 2023 19:38:25 +0200
Message-Id: <20231011173829.10508-4-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb6f5678-c754-462b-7505-08dbca80f79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dt655zRSC6lwo33MtuKDB+fCz5OkI7nVASqYi+4jVDJbofUdmeIVLfKjcrJhKQCDcIEHG/Nk/lYVmQeR0W9/SZ5+jdqDno9ehW3DzoEj7diDgpAkJZ/8+7zIgynnF0cpBU/gnth1udeEZJDxYb9lFGqv5bRbovIpcPoBZrAd0kKHfebH8kbKFuD20Nf4yIqamEwh4vNfE2D4zk4kjAzAp7eEaD520EMwnyv5OCdd64l2ZSCx0EFiqVOdLrID4wPWYXfBZ1HbXIkLLvrA2/CVhT49uWCCkOq5iop1Ntpqce+EwYKMZKtw/RGRarKnnNa9xkCSVxUKY/7+nIOKzToAjI2gD4ok1hf4apfZTsO5tz6m1Ow+UAQsn4NCaW+tDgtaRO8jBQ2gVIevqRhbW6xAZXyi8jfbYKwouSNZab1rJw8LIR0K8y7eIfgNBayKhP6btimQ5GdCdTLWp7KFuvikDLM+n2B4HPrRsFpSx8lZa/qWLU7a2VSgTOqAVWsHoEIJmdrIBLVkS1L59juLdEGlUdutGsQCnAd/1Q4pcLSrmCes2z00Q0etxDXfn8TxfVpn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(6486002)(478600001)(1076003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tdn6qAuQaOm0auhL9rQ3o+E+l1jrSnmoH7vmAf1DmWUybKeYdMie8IP24VbE?=
 =?us-ascii?Q?WypzUD4Kkx10y5IFYhaqDVHqTZe1lcssS0ambQZMyPwAtNH5Q982kWH9LNGD?=
 =?us-ascii?Q?25ypUzcfxA5QwRCaol04MD7xHvjUeT0xrEj4tYwD9sLCo1lU91WKGtsmRq/i?=
 =?us-ascii?Q?Gz6AfD1zptPKzyu+ABf1wCPQpRMcVm7Bq37T3ndy4jRScMXiX3e1gYEj+w0I?=
 =?us-ascii?Q?VYBtutObB180pGEdvgCoZo4f6HGZpW4p1/RfD7l2g9OL1Bz0LsIN5qx/o9q4?=
 =?us-ascii?Q?4AdIIhiKjfXGXNkiYcscGUA74Do/ui5fq7zVK/v6+NAohM1HGXRYuDDrQnDu?=
 =?us-ascii?Q?hCSnf6gJyXhpq4UgJJPAKC1X0qXe5CpMP/OatLxvp2YDLXImDcKGx+yvYHW5?=
 =?us-ascii?Q?LKRGeawb6A7mN7XbaZn+fsH1IFewQZLOyqscboAz3AlqzJ9Oi6Gjlzt4SWWW?=
 =?us-ascii?Q?+4iKnr9Q7WN6IlWTrHWnVM941NvpQDZwp95AC+I6NB/mAk4vSEnT7+FxCtXs?=
 =?us-ascii?Q?4mJyK/c3dLJcJPXYGscNuINX0lgVx4tDlI4TzhJrH5JZWf5n05od5yMNCC/A?=
 =?us-ascii?Q?a/Rf9VTolJ1xwk7jEbn3IFgyB5jWzpe+jpy7dDXvrGKmYR8EZMWeG1X1cxUY?=
 =?us-ascii?Q?NDlOXXqdCIp/KjkyhQ0gtdPBQjVY76HUyV9CeYOSLEuAKSzqD0IbpsN9BPhf?=
 =?us-ascii?Q?JjvsFafP+GGPjPCjOge2ASBTCAbv5lQdqRiJVyEnTZ8vlhGDdDNGGdAjud1e?=
 =?us-ascii?Q?BCS9lx9O1oByE8xVnBPe7nfNwvVDXPWaZcI0o88yexCywb5tYeNrPCaqJNoZ?=
 =?us-ascii?Q?mhptkKBkxmhfltVOW/wXdyroDGwVpHme5O3fyt+fout3AHNyISwvdMuiwOI+?=
 =?us-ascii?Q?lW+AALlKTGbc78jpDcOW1sDieCaw75zWuTlZobA0YI3XzIPJ4CbMWKCbDmER?=
 =?us-ascii?Q?PGFmYDGigSPL5TvtGGidkyEz1952DbzKyQgsU9WSEIK+BMdSaCz2oTKCnD/2?=
 =?us-ascii?Q?j9arHJah3JrfPnf58zqZoYqjqjjvN3/C7JtABAR070NYH97xltt/N+KYLWdm?=
 =?us-ascii?Q?1tYqxGnTEaf+HZ8FDU9mBgLE28yZXvNKR/bY6dRPyHhdQV9DLQrzkwGEFUVG?=
 =?us-ascii?Q?KJQlGmEftDqa0Riaslm1Ey9W7dDvNYn5slUC1UC8JJCJb53vjBelwGruMU50?=
 =?us-ascii?Q?JLDTBT9Hg7G9lhqXchDxjzq/L5jYfSFz/TgGtRCcI1Lp5go0Qn+PKEz7dQf7?=
 =?us-ascii?Q?8M3NNY05K4pfVGTuMeFOitkI+1tA9nBptU/4IFRN1Lz94Ibkyv6M7V26XN3c?=
 =?us-ascii?Q?KQIEHRGaFQjJ1OOODVtmhn2qfSpvdKKMQqqLHIAoSwQdkIRGNJbfLpdXh6cE?=
 =?us-ascii?Q?Zj+kUJS2Rs2WzQsLycvx3DjK4P0XiBBDNISsZ7pHztzfvhhOMgnwELa2gPVM?=
 =?us-ascii?Q?Y9i5m+6z8PkTr1gIEXF0Ub1EgHF7wlswyV9aO0eKW/laU62OzuH9Uj0OCuRY?=
 =?us-ascii?Q?qWm9DMJ7TxR3CxcwmtvkwpHlmmaXoKyaQOwm4lGa5egxkc+x0sBQlg16uI9S?=
 =?us-ascii?Q?YSKYxXNDfp1iB+KZ5/XtDh5zTvQfwXGfnQk3+oTBaD2UZu5Wwzfvc+X6ziO7?=
 =?us-ascii?Q?y8TNYrTc+4N3UpMwhV4hJrFVDAy3K+KpCG12m6ktUbJM?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6f5678-c754-462b-7505-08dbca80f79c
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:06.3396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLoPjhgH/Wrv5Zdngp8WkiPi3dtCS3CkcUmRMgLg0NAZpE+TbiEnxMCSWymYRFoRVGvFiNVf501etWzdSOPgcA==
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

SWYgdGhlIFJTNDg1IGZlYXR1cmUgUlgtZHVyaW5nLVRYIGlzIHN1cHBvcnRlZCBieSBtZWFucyBv
ZiBhIEdQSU8gc2V0IHRoZQphY2NvcmRpbmcgc3VwcG9ydGVkIGZsYWcuIE90aGVyd2lzZSBzZXR0
aW5nIHRoaXMgZmVhdHVyZSBmcm9tIHVzZXJzcGFjZSBtYXkKbm90IGJlIHBvc3NpYmxlLCBzaW5j
ZSBpbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NSgpIHRoZSBwYXNzZWQgUlM0ODUKY29uZmln
dXJhdGlvbiBpcyBtYXRjaGVkIGFnYWluc3QgdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBhbmQgdW5z
dXBwb3J0ZWQKc2V0dGluZ3MgYXJlIHRoZXJlYnkgcmVtb3ZlZCBhbmQgdGh1cyB0YWtlIG5vIGVm
ZmVjdC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAxNjNmMDgwZWI3MTcgKCJz
ZXJpYWw6IGNvcmU6IEFkZCBvcHRpb24gdG8gb3V0cHV0IFJTNDg1IFJYX0RVUklOR19UWCBzdGF0
ZSB2aWEgR1BJTyIpClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBv
QGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyICsr
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YwppbmRleCBlZjA1MDBiZTM1NTMuLjY5N2MzNmRjN2VjOCAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9j
b3JlLmMKQEAgLTM2MjIsNiArMzYyMiw4IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpCiAJCXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvID0gTlVM
TDsKIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJDYW5ub3QgZ2V0IHJzNDg1LXJ4
LWR1cmluZy10eC1ncGlvc1xuIik7CiAJfQorCWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhf
Z3BpbykKKwkJcG9ydC0+cnM0ODVfc3VwcG9ydGVkLmZsYWdzIHw9IFNFUl9SUzQ4NV9SWF9EVVJJ
TkdfVFg7CiAKIAlyZXR1cm4gMDsKIH0KLS0gCjIuNDAuMQoK
