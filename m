Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9336B7C5A57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjJKRjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjJKRjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:14 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E7D98;
        Wed, 11 Oct 2023 10:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnZ7gbPricR2ACpOXheK35H30OSlirJ0sRNbq2BNUfprgmFlHc5svTR/vhVwz/oMUzNFf2SBvMYTVv0/hLDqXQaE4LU6IB3cgv2NenhNH0TUV7Md/vdcFYonDchSbNXvJfemsErOLod7M4N/EIRpzkQTMH+yRF/o1yQJ9v4QVHZ79MhVL/JD46C4N29JIWJQAhA9E6d5TJdWfV8UA0qi2elJD6d8b6vWpCP3QPcXDSYqWK4oIuGPuY4nOGW0oS5LoyDQVB284vkLuaCK16zb1lX/l8gYbz2AQGbz6eGuxTnGyZ19TFXUwJAWEL5YFklTSwmEui+ZhRbzNzJoh9Y3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GdkgcY/GaYzPupCbixjzBwTpe3yNotCFgwLRCoSCFU=;
 b=Hc0wO1p8od/ZkpnVeH7OPDF00CHci20/YQCmtTkncw/PeMnydGLK+14VbL2Wphol2WGL6NOvw/gYLqybZk7kaU2Go55Mm70lJymAuWTr7COWD1dM59QZ0wRS3DUx/vQ3tTeCxIPrNJsCeMI02MIOfwwXhWo020h+OfwsmDPClTf7MylxcaXlogb/Qm0EjGrzDTvQUiaO2uCpkpF8NLcYOD7lceaG2f270psOyKaXzRVzKfI/7ZJBntcPzRxveQ5simEK+O60neNaYCeTr6tFyRA67J0hVsoLUbk8k+pCKYYby5kP1/ep82lMA6PEmRQf++eJnyv+WrZ/OsHfgJDUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GdkgcY/GaYzPupCbixjzBwTpe3yNotCFgwLRCoSCFU=;
 b=MJxAlVUKboAjc3pnWKf5Qx6lgDT0aXgANdEfYhea3qRmKVX1/GNlL6RX41RZohYRzbvHNf9khEqd94g9qhsHs4QwA3uAV0hAvDUFZOA4ERQLEWTXm6s9oNqRbp0WS0zqR0MACmPPvIMOrJMYJ6h5EALzxJ/p6863t7nPjp/eKyM=
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
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 2/7] serial: amba-pl011: get rid of useless wrapper pl011_get_rs485_mode()
Date:   Wed, 11 Oct 2023 19:38:24 +0200
Message-Id: <20231011173829.10508-3-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: cea16201-84a7-4859-cad4-08dbca80f72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRs833aB0CzXkuyGa32oC1obW3+IQ/WEMrvnuVu6mheOfUuAve45hx2o5X08kbVf9QzDyh29KLK1MkCA911bjBO0GxfSuM/0ShiUgC06Dy7wJTD0NuEHqMJ1gDcBTFubtoduNMgAhaPVzkFiM7WmSIy2YFMZys5tJtvCNogtUaHbk7DTD8pCNDb1DOtHCZ9XotZL0128ZCmcG+0xCHIPyL24oaHOYzugkkpx5nD+pNN12H/RIjohBYFvCwy0CLEXOYf3dzBPqMr17diq8csXGlus2tEk/+HPNXootosn89MGbW1rcvSlEwG3Xl/1CgIBO9RF3hlqyVP77PwQXcOdOQHJer7GsgS6Ub1zD0QKMhamhvGk2UHUD38iGTYIGRJIqvD+EBcfLIjBPXPCtKpWaECbJxsVS8n0MUXnxnxep21BbMb0m9FGNIajDVXjZskVrk/PSlHYd1TPaYnRiDTLTJnrUw+AnTl44J92ygzEz2vulsBRXhbwgUmIS0kdKLSWn2BeeudQMqbxPPgo8a+KQRC+ACB1qrxcAlmKFafOuYRT2ZdeDfc0wHVgi3I+mBCd0NN0KCT9ukea+nZVAGkfYwRZABzNbWWl9XsZt2O4xiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(107886003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002)(26583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcsL/23QVWB3aLyfKslCBBRVJue6luKUKao4dSgfWqnRx1T4Y0KfquhU9XI5?=
 =?us-ascii?Q?SnW1Vsvi+mxhIcugYOwGR3uzZ++JWX22S2r94PXe6zSxzXFkr/HDTFecIsa0?=
 =?us-ascii?Q?m5u+0mFW7opetsk9wTh8e4vaNlEBPByWeLvJRdTf+RxidIjm7Pe3uY40l9KO?=
 =?us-ascii?Q?wOyjobmtbBicOW1SvM9hugIkugbTyh4RYjzK/fYt/wMqwljyfwlKE2Hi6tZP?=
 =?us-ascii?Q?sNLNnzCi/1wCL0WEnT8nAHSVpMPDJMKDFP70kEtx/1R1UCAAnjiGB6LgU3Lc?=
 =?us-ascii?Q?jQj4HnOrCbGbD+zhCR5UXVSIG1+eZWhe+M6MW23kdDsgFMmi8/GE28oyUz5a?=
 =?us-ascii?Q?X7Ujo5wp84dwI4oSkXltuJ6Wxmd5RfZiOy2+lPBBZ2c8UpodJzh89WMSyIzs?=
 =?us-ascii?Q?qnib8rlflufo5EWIRn/lVD5qvqoOCD4QDct/GZa9APiMJEu9qlujzOS8e6Gb?=
 =?us-ascii?Q?oU6QiT3DV1v9qR2ffsanSZ739wE2mEP0K2A8L1DdR3bLURhTeeq0E1Dm1rPQ?=
 =?us-ascii?Q?0I5uH9ztPUBdJE02BxZDmiRYKjs+fjV0Vw/cxAhsem0+Nac3Pf7OEPfJ6Lhw?=
 =?us-ascii?Q?CYyGG4blG9QWSdPoZqGyt97PkjxWtFJJlEjgyJT+cHljovy9PRlBx5DI4OK8?=
 =?us-ascii?Q?XLLIWZ9oqMCfRdlHN6BgFJzMNhltyS6jOcp1I1Bb982sQpcZ5PQaQ+1rsHJM?=
 =?us-ascii?Q?3P9GguoTry/x5FHGmI0GPFw6mm5oP7CQUAcehB2qckvqB9dzQi6urlBcyCTn?=
 =?us-ascii?Q?1Qq8o8ZcD+Z7hC/R1aSZUEqh2JxSlQft+AtW8Xl0icOwxiF6SFYsYZkVJ9kW?=
 =?us-ascii?Q?5GUsSsDTVrrgIBqPnzyRRNRhY+VyL/UFrrs9SzJeQEXQ25J5YzBVmebLE10N?=
 =?us-ascii?Q?NOUvt9UjMvJhBS8lvrMcDgXBfZOd7QygIV52xTxecY282ph3EAKERVyBHE8b?=
 =?us-ascii?Q?OsaMxOGRQHD+UQFEB71A1mB5MAuOnnr2y2kJI5jiee111Xa/b0qClrR6Gr4k?=
 =?us-ascii?Q?Ie5Vox64ozsqTOO97q+Y29rvzVHizqDTxrzhzALW4jwxCRVIdwYCatEWbMMA?=
 =?us-ascii?Q?Ndr+DeooYGDwJQg31+Zcf9OEAxFfm39D5lnDURWRsnWnPMOtcTX8w/OF3AUJ?=
 =?us-ascii?Q?dFN+032H8pXNxnb0EeusiWxjZ9jnBI0SdLSNGlXPsmaypHwlYUNyy3YqAcef?=
 =?us-ascii?Q?pgbnxXSGIHsevaDTK1f0GrRVj2VxvN5qWzVeUF2JWLkUss+s7khwJi4LlmZW?=
 =?us-ascii?Q?56AfAFlm6+GbsqUJxX7e0ihhdGMNkFKGk8jqIV81L5+ibZi0hqfeQGqpRj4j?=
 =?us-ascii?Q?ZP8IX0uoSI9GkXnFxOsPx/txhPoZ56QWkOSP6Z/6gV6caf1PM8Ggr4I20awr?=
 =?us-ascii?Q?uW589HQvUVoYbEi8qEp8P2F8DcT9Ibet1l7PeWG1J5pGEEAkBMIxfyisSHpl?=
 =?us-ascii?Q?wlfzOZbQGhbMGLFlAW9ZJ9SymojFG8hi5tZHhrZOZo2DoJfb9ekbicrd7EU2?=
 =?us-ascii?Q?9mR7Q03aCLeJCPlrR97Ef18xmZrOxydBpL72WXRpgfavxphERduVQFqSlEvq?=
 =?us-ascii?Q?UQQwqrMkT8mgDa7nypEKDp1dF/dE8RgmpDpOGpoPIQv01Cil3sucaJ71mAav?=
 =?us-ascii?Q?oBwyeY1yu+NYyNFFHEGDccbxpREEvanmDq1cDU2zrh4J?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cea16201-84a7-4859-cad4-08dbca80f72e
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:05.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqKcf8aIXkPvFHHLJr5O8xrqz3WCbhdSGh6CROWO06UVsrv5qxNHuWewcD9k4AqsGusLnzSKB9a75bBiLL44fQ==
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

RHVlIHRvIGVhcmxpZXIgY29kZSBjaGFuZ2VzIGZ1bmN0aW9uIHBsMDExX2dldF9yczQ4NV9tb2Rl
KCkgaXMgbm93IG1lcmVseQphIHdyYXBwZXIgZm9yIHVhcnRfZ2V0X3JzNDg1X21vZGUoKSB3aGlj
aCBkb2VzIG5vdCBhZGQgYW55IGZ1cnRoZXIKZnVuY3Rpb25hbGl0eS4gU28gcmVtb3ZlIGl0IGFu
ZCBpbnN0ZWFkIGNhbGwgdWFydF9nZXRfcnM0ODVfbW9kZSgpCmRpcmVjdGx5LgoKUmV2aWV3ZWQt
Ynk6IEx1a2FzIFd1bm5lciA8bHVrYXNAd3VubmVyLmRlPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNh
bmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3Nlcmlh
bC9hbWJhLXBsMDExLmMgfCAxNCArLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwvYW1iYS1wbDAxMS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYwppbmRleCAz
ZGM5YjBmY2FiMWMuLjcwYjQ0ZjNlOWViNyAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvc2VyaWFs
L2FtYmEtcGwwMTEuYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jCkBAIC0y
NzE2LDE4ICsyNzE2LDYgQEAgc3RhdGljIGludCBwbDAxMV9maW5kX2ZyZWVfcG9ydCh2b2lkKQog
CXJldHVybiAtRUJVU1k7CiB9CiAKLXN0YXRpYyBpbnQgcGwwMTFfZ2V0X3JzNDg1X21vZGUoc3Ry
dWN0IHVhcnRfYW1iYV9wb3J0ICp1YXApCi17Ci0Jc3RydWN0IHVhcnRfcG9ydCAqcG9ydCA9ICZ1
YXAtPnBvcnQ7Ci0JaW50IHJldDsKLQotCXJldCA9IHVhcnRfZ2V0X3JzNDg1X21vZGUocG9ydCk7
Ci0JaWYgKHJldCkKLQkJcmV0dXJuIHJldDsKLQotCXJldHVybiAwOwotfQotCiBzdGF0aWMgaW50
IHBsMDExX3NldHVwX3BvcnQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgdWFydF9hbWJhX3Bv
cnQgKnVhcCwKIAkJCSAgICBzdHJ1Y3QgcmVzb3VyY2UgKm1taW9iYXNlLCBpbnQgaW5kZXgpCiB7
CkBAIC0yNzQ4LDcgKzI3MzYsNyBAQCBzdGF0aWMgaW50IHBsMDExX3NldHVwX3BvcnQoc3RydWN0
IGRldmljZSAqZGV2LCBzdHJ1Y3QgdWFydF9hbWJhX3BvcnQgKnVhcCwKIAl1YXAtPnBvcnQuZmxh
Z3MgPSBVUEZfQk9PVF9BVVRPQ09ORjsKIAl1YXAtPnBvcnQubGluZSA9IGluZGV4OwogCi0JcmV0
ID0gcGwwMTFfZ2V0X3JzNDg1X21vZGUodWFwKTsKKwlyZXQgPSB1YXJ0X2dldF9yczQ4NV9tb2Rl
KCZ1YXAtPnBvcnQpOwogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKLS0gCjIuNDAuMQoK
