Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C264A80B46D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjLIM7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjLIM7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:17 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601F610EF;
        Sat,  9 Dec 2023 04:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km01yQ9yVNEYXOgIxCwmP1pzGCvvIGZUbzcX1hghw9EKddmQbhwA6OAfMXhmrsyo0fLjdTXgjgK26hdH+YBlJmtYdxk+CWm6M3T54kO/DtPeXMBRXYguo1oUsag89J5nf+TI/PzpxhbstA7QZ2GgnoF/7F72jwtFnK8slHS86OSItFrEd48VBTBeW2M916DeD3KJjQRw2r/GZ979sciXDAiCgrgKUylP76iVdabIF8SRVs0ezyp+l+zFC3qpICy+ycWQN/aL/11w4rMruofYLC2nSGqKRCIAFLDhFRNEth2cW/R6FLkKOTG4bulQMM48iquElULl6DjDmfZoNiNTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z37oomI38hjFz0c5Y/ltYnUcrUN1/Aa6wnLuGYM+HyM=;
 b=S/Gx8k0hUVgVTUy8L1XMF33yckusKax+81Npge1f1C5SSQROHYMiYP8vCty80m3Wk4R27O89VSUeLwLKtaXsdxMC5APr/2ti35yvWNs0vDSSG7ouWdhnPiWxsbcUoO2dfNB/xLJsJKQxtDGT9mf/DJWP7GZ1kknMPG0qtkOktWtiE755/1SPxGQdD0DgYdg//etlLvubez7OJUCo75tqTb0JmigCZQbVGIASVrExssrGE+icgWsCbriZGA9lYgWoZ0zD0A/lBBm+03l0BpkD2kXbE/EJuKDjbE/KYWBf0DWZGvKbsgYK6/nkouFox57vzSdya0x4xPXG3vIGluzJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z37oomI38hjFz0c5Y/ltYnUcrUN1/Aa6wnLuGYM+HyM=;
 b=iN/T9odSKbrEfaKHeSPoC7/9HENUKVQvDN3haM4euPFn/STMmcNr9XD+WfnPfyWuEkK1/qXjwvJ3E0xN+PsJQ7XLGLqbK9FD8ZUvK7IfbwzU1ZZYmvphN+vRB5ezrVYQ/hjaruydWZi+asRWEYYrl6oIFYCkEWWUVAOPkD+AZsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:17 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:17 +0000
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
Subject: [PATCH v5 2/7] serial: core: set missing supported flag for RX during TX GPIO
Date:   Sat,  9 Dec 2023 13:58:31 +0100
Message-ID: <20231209125836.16294-3-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ce4499c-d4c4-4557-f7f8-08dbf8b6a704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0XgYvWmPwYllDeKHmlBnCjqM5UJMnRmL00aS56ohJnCqDiVvMTW6EuLzvhkjwLwcO66rZJwfh+xypL9bWWQO9JrCavfIoMl5Qwks36STgjWCrOSn0CfJOcCD+W8bp3U6iF52WOXpTPc2ypyft15wYkqkl4isnixqMjq+ybE4VWB+5xZUVuTOKGHv9SE0l3wBXK7lDPZWgT+yJ+Oft7C2tXftRDCJv4Zuy3dwXldFTYPFvi1JS/pTTwxVuij3Qhh/LCdpDl9wbcInLLe1rB9A/nZOjT1P4V1X5z+3Kl1qkms2fcz4BEuwBt97obvGhHzpGYjKuzDekxgyJ5tryqKlj3yjvr6qH2+YoiPq7a7ulMj1o3fpp1ortGxYD4w44RVewy9DsQxbyJ35M4WABWP50abeR59QxzgG9UvB2iLg6COMyt6hQwRXpIS5XyTudGSn5SLSLllRtnrGi9KS/sO+CVWDphHb58YqSVp6WwnP5hm6UUQNsIQA2sO2Kd5r/oQ5OWRF0dka4nRXKRLNX5c368lkbr9nJi07dQ6omUo1OGh7fWeIyaWaIyW/u3L8Klh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRLhD6O3YSlL0LsJvVk8dvlaZgDaHZIwG/+Uv7aNRkgEa3SDyjfoIs/btba6?=
 =?us-ascii?Q?3Kauf+e1629sKe8IeiFebrsNTZRmuZfKLWytBOiO9nxBlqCJjpYz86WhvDMc?=
 =?us-ascii?Q?BfEan7LzRGsFJjj8Avk2cTtUw3wZ1oq57AMDGxg834FCs5hnW3klQnnw56FB?=
 =?us-ascii?Q?nZxKVbTwMFkPkC/D07M52VQ/kMEGPpzYJDhLHQVgd+yIrbhoX+Wg6dJrlvA4?=
 =?us-ascii?Q?chhNE6Ght/sp2LUf/YhJfFr8YwgtQ94+vnX4Fe34Mjsmh681xcnIdJ6QKGnW?=
 =?us-ascii?Q?t6lV0LQWtKgZgk6Cdai0EmjmdZu04YeajbvybtB++A6oZBx/6rrbg0l1EuFy?=
 =?us-ascii?Q?zndtWeNh3TEIxp5QV/geLLvtt5Eyvb7EFqAb0j1zSJjKejxLi0Ikye/OIxsj?=
 =?us-ascii?Q?5mXXTc388hKVjwi1afYGjhiJJDPyjjprWPlUZjJgWy1QPS77lP7B71CmHlPl?=
 =?us-ascii?Q?TcWSeiOEE3whhRmh2a9PvUFwLXDnqWBPM6lChzhgShhcw9W68YHG6FkYMMAy?=
 =?us-ascii?Q?kt9r5QvSQIOzoGrc0KDGDKDteVGFV1oOdhZu2SSF/hlNBAicnlArdoKd6y0P?=
 =?us-ascii?Q?+7Sj4zsowAl9ZGGXGH1CLxyZiT9Eu7Sxsk6e6HcsLKZjtycKvY0kU1BnqiQa?=
 =?us-ascii?Q?T3cDIZd5DBIRmEbtsMgoOQnlLbZvyDg5Pd1c5Yh8cqL1Jk03dN72AxBMTXIO?=
 =?us-ascii?Q?qODSmyLZo8F2tLgG9NlhjecdvDEDg4v9C2heZfYi9wn1F8n14op1ZMTL9iFh?=
 =?us-ascii?Q?Kvnql0+dyHhlS8fHA8p4CSvPiaPtaS8TnO0EKNwgXGWDlI92A9yJSFLUPpSn?=
 =?us-ascii?Q?dcom7vnwmY6ooaETwW7kqY//8ece7WjFix6NEJVNvrgMS3Ne4ueyHlD4FyuN?=
 =?us-ascii?Q?k7SWdtbHXHTTv4zm1f3eKWmgLEwy7k3kRiGEtLDrH0SCWXnpNFfGQBvbo50Y?=
 =?us-ascii?Q?OcuhAt1Vl74tmFJtW2G+J7yUMs0vEqbxDrs2xPfo7NPF67a8F2xWJMAPSXNQ?=
 =?us-ascii?Q?KXYLGFe6Gvj8ijf6pqfw0hvP7ApWoIP/srNmoVQb54zPoI95yp+wN7I5kg2q?=
 =?us-ascii?Q?Ld8sISqiAcsvbfMvbkbMD//F3uTSQ+8Lbtg/KlvSQW26DKvfRTgqUU+vZT2l?=
 =?us-ascii?Q?6oGbp0HU/JwWK/0wufjuJeWrlNZgt5KXY/A852s7dV4rtMFP6M+WNudcE9lW?=
 =?us-ascii?Q?L3VmkjVS/kUaTDRxXEuX0f8+amEV2WLSTH0ULXLQkrNGwjHDlDnrT84eRUZu?=
 =?us-ascii?Q?XOC2IOK7szL6LYo61QUE7xJPpY4eVPWWyX6GbQaTGnOlnMXeju1+8NiMbDBl?=
 =?us-ascii?Q?yq2wpQVOXZxFiC2485+oZtSuAoRATTreOgkAvaTcaT3LQOTrrk6T2SlC/A2r?=
 =?us-ascii?Q?vhFrqzKMh2bfH1VpSTvojXzWU96xV8rMvrtJnO9F6pI/ibCpHQeSWzxeXGK3?=
 =?us-ascii?Q?1D0+JKXELhQBTihzmisjiJ4Li/KzlsYxQUEJyi+9JR6FyWK1A31YeIb6T90B?=
 =?us-ascii?Q?kFzgFJjycB10OftLCLmRFntsmBu2ObeThAOsseEaDldGkWlIhqWyTz+PyIHF?=
 =?us-ascii?Q?UgRklHrVA04EBrxY32Qwn5au8BLMrFIZp7Musv1z80EnnuwWZEFKMHcsb8iG?=
 =?us-ascii?Q?gppmn0aTCwoPQTiVNW3yOD+cNUDec1LL0T7ejLZ0bBnl?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce4499c-d4c4-4557-f7f8-08dbf8b6a704
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:17.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6B7S8zfwk5RpG0mBIUuXnzWplIdW+QqoMgCI5sSAWQ3K7dusfTU80PsMI5s7MfLrhs6O4FoBH2ZjIuZf50ueHA==
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
YwppbmRleCBhMDI5MGE1ZmU4YjMuLmMyNTRlODhjODQ1MiAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9j
b3JlLmMKQEAgLTM2MzIsNiArMzYzMiw4IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpCiAJaWYgKElTX0VSUihkZXNjKSkKIAkJcmV0dXJuIGRldl9lcnJf
cHJvYmUoZGV2LCBQVFJfRVJSKGRlc2MpLCAiQ2Fubm90IGdldCByczQ4NS1yeC1kdXJpbmctdHgt
Z3Bpb3NcbiIpOwogCXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvID0gZGVzYzsKKwlpZiAo
cG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCisJCXBvcnQtPnJzNDg1X3N1cHBvcnRlZC5m
bGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwogCiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjQy
LjAKCg==
