Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8D7C5B12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjJKSQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjJKSQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E0D3;
        Wed, 11 Oct 2023 11:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpHCnwsjKlRWK254mIMVeJVliv7z+M06W5SWheBaBFBivtdXNS2/Nmgg9a7CZBZlBjAcO2EgqKKM/Gf4jtSgxuPUEgemG2XZ3neLmg23KEZo1eAjr56ndE2GQygwPA0abBBJkfKjeuVttKULVaRFDt2yzpOAjHFN2+IgYz3c1bDQGMzaWh2VxUI0tZTOw8o148PlRP4BNuGgzMdNMNoRLVrn7B+hhXf6/lgWQ45U7N7DYE0yt+ujLuhrhnXlKFqKYr83YtyR6hujqbSdA4H/wC4ZuWc+iWamREDddCOaloL/HgGJJUzmUytYl/BNzo67tH+up8S8cIX8RWFJcEkIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfr9CVtu2RhfuGF5Ku22UhpbfvaQTz9uuOjeoqXvcnk=;
 b=g9rvEPVF/+ojPwOlnOE8yxM9OdBgpbzSPxqUYzar34oUI+R83Ho+/WwTZcdI5YBb7tQQ0PrzUMzdOxL+2c/ZPTXClE4dNW9PfQBkdtZac2aS2BRLryxdb1YZO9qEKmI1oYKBbxkS51h92suMKMg5j7KRN3c/61wnA1orakb+MTEtUDmHhzykTZ82umeQ11bDYrsx4w0oumOsldPPlmpLVumuszXYSUZUdXAjCqDad4plfRx1Alf5sHu9nfFRTFlHoes7YsBzvLZfsxWgsjLwdr9D1MhLF3uFlylc7y56XM7OyKChLTRnhGhnQVQBgj4zxD8gyz1EvSLOwoPbboq6Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfr9CVtu2RhfuGF5Ku22UhpbfvaQTz9uuOjeoqXvcnk=;
 b=BKOd4aCP8zDfInALoAoQIwW8zEHpcc+gFIF9ulIMhvBKhWHCKel66v8oq8lsqzjRfteI9VTQqqKCXlDw1wFI4YCCLmoOU1o6l7g8LLOy9Jl7i9PQwFvC5u5ldDsHrwu/Vjw1CbZj6+mcgpWp+4AgUlkCQVSMjbNL1ECds8pqRxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1497.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 18:16:11 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:16:11 +0000
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
Subject: [PATCH v3 2/6] serial: core: set missing supported flag for RX during TX GPIO
Date:   Wed, 11 Oct 2023 20:15:40 +0200
Message-Id: <20231011181544.7893-3-l.sanfilippo@kunbus.com>
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
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 89d5d62e-89e5-42f4-e789-08dbca8625cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2OU3bmYejiuvsHxVCOjuc+42S4mVK3eg/fg1JnWJewZTJ8eqSlGDfDk3ilrKntjZUG1ICoFluCrFq74InMjd8l76KjBILRQdI3GHeLzjgzJSJVF46LKFEwne+qO/KaSjhgxNon6h/TQCvmGNHQab7JLmrWpCc3tMa8b6+OLPYu7WcNNIUpmM7v1OaMYW+abpcTSt+4Ly8swZEcXkuCTy31KLGSaV0Q8qADESD5mxoMLz0CZIj7efGQfHs/nwXGESeBspv6oTkH4SvOOdZaNPycU0ifTfmWEB74Ye3PV8OXFZHE4I7XqcCt4lpDG3YMFnr62X80uoSQ2PCf89hh6+uWVmQNN9tbvCckA/VG/oUEVMvEjJ0Ge1jkblsPRAGLb4qccc+vc5cIr6TQaK9AEGMNwZax61ij2euNQdHPn2q3iOMfC3X6/IxFtDPNT3R42vq4rDrWEUQpYmniVKgl1AU2QkKsFYVUCPY6bOoGh2MZIs/Gb4rdf1vWhwWbSa/KZIH+G9oNwGwUvUWUeftxfixz5edPlHzwoDRAhjBFi5mhGun8v9GS5m3dm6KK5+ZbF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(52116002)(6666004)(6506007)(478600001)(6486002)(6512007)(38100700002)(86362001)(36756003)(2906002)(5660300002)(7416002)(1076003)(2616005)(316002)(66946007)(8936002)(4326008)(8676002)(41300700001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XYgGaiObTtL4UPAdeN1i0aXzv3tVIafzXi2rCXwkVutlA6zFHx9/rIND+U3w?=
 =?us-ascii?Q?Hoxcxt0/f9glDWYgbSJX/GcMe9Hf2ex2JTpwwTx41vxhNyF9yXHh1oEG1mhd?=
 =?us-ascii?Q?K9PPxtDS9uaMptZvlGSFz/bkp1kpW21edj9VpfLhBh8W+mqB6pbjK3pLYQc2?=
 =?us-ascii?Q?REKrlR8qTA5Yop2CiEmicdzQEd3Q8nzaYRfLeEE74jYitKmoQcWwprwyc7A9?=
 =?us-ascii?Q?DBH8eRDJkiV29W3oSpEWt2H0J7xV6o05MgoNvTpf1xthDIuXMzZbDif5CUHx?=
 =?us-ascii?Q?7/n3ykLzeEdbs8sR3I6TgIK0qQWlfphPz3yaXxXbAtc34JBKZePnYZV0Xg+r?=
 =?us-ascii?Q?4coRpt9mOGkZJEN5FmwAycb/FY7JV7ZxyghVyjf+HRkCQhstboaBzFLky0Za?=
 =?us-ascii?Q?7nnnuiT/ldQYQvn1iUvqGwdAWmS6BF2aeA/rfvJonzWC43K+KkGmEI/Cd/rS?=
 =?us-ascii?Q?lxvzlFIFjykBIfSHHd0l7dedhGU48Bsb0Hd/l8QSSmrcIKHRgZ34JuZ+trq7?=
 =?us-ascii?Q?bYvLC8I9nk3U8gILtVkRME1Gnssb2y3E01IJDmqIdUDKOV9hXElEF1a06U+r?=
 =?us-ascii?Q?clV5Zb/k3H9DtJmbLZ/gY1KN7qasE2ShnnEO5fHi+MdlYNsShqfB7ul4Vs5G?=
 =?us-ascii?Q?EBNfAzmw48v/kcnBEgh6lZgOoyBFCXlk6mQ6zw+xwAgoTA9Y/z+MyEzR546K?=
 =?us-ascii?Q?ZzaGaHgU+tqrCZsD8nj0pzAWP6Y+fJpa5A96G9MSRpmX/Jsfjpjlv6LwqY3h?=
 =?us-ascii?Q?JWm63iFIp1aIin5sHoE8f+uDkL7ZbR+o1Krn1iE/cqqVnQLN7bdfVTj5BdPy?=
 =?us-ascii?Q?acKQJeBsyj4RsZV+IZ5bk1dnyFzrefbHa2OC8STXxM0VIdrVtpOi+Pyw4utc?=
 =?us-ascii?Q?PxHHULTqB8Gz2tCAvip3ABZvovsY1/dz8FH6QAtuBph9tY2AFZkWZYwmFmWA?=
 =?us-ascii?Q?CKoVBC4+0dealkOYjO6rh0Cv4a9cKm5PA2sZ8pcVmoc9aq0MmcFEwmSOnPvN?=
 =?us-ascii?Q?L2h3hB1rgzuHXadNhzfKcjHjM+rBY6O9l+MlMjC1i0eUAMXY/1ZEJ6fy0U/P?=
 =?us-ascii?Q?uLesRak8tN2JAq0AHm1HGxuxJFovNnBvaReGAAADcf9xOmk4f3MMIkE8jPEG?=
 =?us-ascii?Q?qBtR6Mu+E678HJ3AdPT8GZGp9ayrCTK7IpgCjW1S7SaM9dsC2cd8MzWoOyjK?=
 =?us-ascii?Q?F4+Vj2kk85wXB2iSdtNL+zv43l0RzTUWHXk83SlnGu9wNc/HkhVOu+tBWSlz?=
 =?us-ascii?Q?NHqhTqSBDl1+a577Se1Tj225z4QuMHiGHv8/9bgp0uG6TK+lMZm9Hc5NYQcH?=
 =?us-ascii?Q?9tnzsxHtPOQRjeHR+1DmhweF/3bXFJqPVh8CZZDCQBhjGBPoJ/VzD2EsT42z?=
 =?us-ascii?Q?VlhPx8Dzi4FbLhnkc5hIrQhmRFMIEyPzLWS+RZLBOqbhpzDomdkLRetCGOTJ?=
 =?us-ascii?Q?wrnM/rclgNjX0b/on39A/PnKMRllMTcFKpETR7vl0CnKXnBxlMz4UdLAxUzY?=
 =?us-ascii?Q?M/3Rn0jptkodWxbzlM8k7ITZobbTxjz0mPmNtlmNWaLzsRUB2N+Qtz/AnhaQ?=
 =?us-ascii?Q?nruYjkLRHziWnExa/C2qWkjSHSD7Yn5JH5A7++0ArGbWZKLaSK0KNw62sSIv?=
 =?us-ascii?Q?x62UnVgdfUNurhI+ixNz1KnxnjtomfFMPuzBhQIlBVyv?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d5d62e-89e5-42f4-e789-08dbca8625cb
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:11.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6QHQnZ3xkQGqJ9KY2i66AydTU7IFvEqyVOFTM0L0EQ/cdE1taOy9IMx77tuEtG1o+LQ3XdOHPKFpPVisPMPSjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1497
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
