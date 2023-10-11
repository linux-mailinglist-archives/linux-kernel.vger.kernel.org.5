Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C327C5B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbjJKSQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjJKSQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85893B6;
        Wed, 11 Oct 2023 11:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+hdFfT+R15uih21pofpL3/QwClNrlJeAskkXX0B1hgKPuAZ2Zpp/V8JbZqcx9SKHYUDfAF36dn7d/4A0Ch84YOk59NmfZIVGtRzbMYS1BcAFEHfTEfCziqO9Wir3BlBkKhR6gCjFUV+LnF/hVhFUUZKg7x8t1IvvIVCYu1tSx+BUv8Kd6ymYXYaRuJAggrNi2h8V/8gCPqTxK9cVED07J/l2LxNlFMqcgSDHq9nENaIQE3vqkblPZaeG68m4XkHpwp8thMo2VgrI22XrdSxoYLSoibyCtsj7+yPvmZ+P7XocGVSoNDHrtZbKfgzJ3sPeUs7TOyqFVipQVlw3JOhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK48PGvsIKhBF+d21ldU+Id6JckShcS/hsDClCbGVHo=;
 b=iRGED2Fi0ar57sU88uftMc5JL3RqAmFd1gT53JxXLCuIHKzqLi/2oQdV5eDNbBiUzmO9GKESqMHdiCs4gXWpEciFwaG6FVinc71nZt18HP0BYCatAn2HVuWstQdl7aR2i7i/S9639jumM7kGAufCkdDEwPNDboJsvH6x0ohFas+LMLx7uB1OHbQwP5XBA5q0Cc8lFaQCMKsoyucL5h3q473oGPoT0GowQ/iajEnPeqbFQXRGOvKFOK9zwwlI3qEbCZTdyhNgeHs0jfXlX9NpF6GF4w0m9IZ3JQ5Ouo9kEHT/8pl8QVgkraVIxH9wiu5SpaJ4GNZkwFMZAjKvDEfXZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK48PGvsIKhBF+d21ldU+Id6JckShcS/hsDClCbGVHo=;
 b=X799JHKFKYF/N1d/OuJ86tBRjc88huH/RLbaPRPCAVfCFSA6UyroiWbStH3YqmmSSUuzXqer9vgi0Mnk0D5yAUKqduD2Y4eks8FK9q5IHCWznPDeltQSp5rA3o6UK6hJuawK5BCzjkcFVso95isDP7XGqtVWNWYWWEfJcViV+Bw=
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
Subject: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS settings
Date:   Wed, 11 Oct 2023 20:15:41 +0200
Message-Id: <20231011181544.7893-4-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: 43847260-053f-4bba-f5ff-08dbca86261c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRYtO92ghuCmwL9JHuhswjOw1hrqbhDAy48W75Flad92NBkqdibTG8lkWApZgrBsqeiDJJuULCR60Vk1U7blWLiqqOuGkwD49KP1xL6ULFDfC2sFVlLtCi6C9JSaWgPxl2TF1fIwULj9ePnM53fVp2KyTJ5SkodaxoT1TbpuXpZ4VaFUPtCLouXHXq9oXpXmyokZ18VYD+alaIfDjdd8guf5wu7B3ImNuj3cTJuldOzvnQzjVOYpkG9JghnIkNuUSgW+9rq4Sqpqt9KfaqpmKVOnKHOpxTebaECRl7I2oHXtlJKlg3gFOXooFvHcnm7g6CZquKDn1tKAzCgghDhZAUfz6N9uyn20IBNfLkFwzE9CV2Je07pXHd4OqY0bheB1oHN2HPNG95kft+gHyMN5aaVGdvVY48YLp4G9Hzw/00WYlwPH/mSWoMyzfMb+kZRewpOxaibvYWo220/P6qeujxbV7imoMr7/U6wLTMRlhgHkDGLFdRlBSxg6zabOlPRJOqBrpavKj57hGJ+dYGM5t9AdNBfDDq2X8krv3FBfkEppdBNnsnJ4Kkiumdme2Cyl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(52116002)(6666004)(6506007)(478600001)(6486002)(6512007)(38100700002)(86362001)(36756003)(2906002)(5660300002)(7416002)(83380400001)(1076003)(2616005)(316002)(66946007)(8936002)(4326008)(8676002)(41300700001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DDKOJfUVJFY4/tBWkIyHhiiTogb17dvXGA4IgdBoNtnD8Ygh/9S9KpJaIOQB?=
 =?us-ascii?Q?E/6dZxnYGfgTXHqXQU69c5cV6Q2X+IVrje/meaCqUJtPF6fPHIFVT2fNgEFv?=
 =?us-ascii?Q?MdJfzldlna5irOqovOKeHSFWVDnMH/+SAhDgZLDE8a2q6QXoHnvD5Q0zC/11?=
 =?us-ascii?Q?t1bLQfhxWw94LDT0zRkxDfTsUP/n4u5P1TvmiCThQp5Rj3bZ/fYgJgWnbM0N?=
 =?us-ascii?Q?t7+anbtTTo2Lpj2lvJPgPP8JzLmYHczDvi/1+mUY3YJKG4SuKTbdWjUprEkU?=
 =?us-ascii?Q?+hr0a5olkSza2KLByv5bU3Rx5Lm39dBI3Z7uVIdHDsV10P2MR2evaRBGwZwi?=
 =?us-ascii?Q?ZPpPJfmlx9BuqJsDzeK+ZlWt5y9tVn0PKWY6fILoaUkNd9V9Bq7Oa2gpIcmt?=
 =?us-ascii?Q?XxH9kVmdqOld9nxWOGBZjK8F6cEnwAYVYgYFil6vGUJMG8NsvyfJffi7Xm5v?=
 =?us-ascii?Q?WHW4/KJXMoA+Xd02L5su68oeT+dVOHxVf/PXjbKYkRUe7p/GHr4KwNZPscg0?=
 =?us-ascii?Q?Vt8LQm1qRqahwPzOXd8/mUZEKWMFt7sWc3REwqsjD5LZIFDXzHL9rBDe+n2s?=
 =?us-ascii?Q?ZMmhHyyH7Dye/yREetOp16PdGB4chHmlgscEpdW0nrE2qGb0OCSzprwQ69IB?=
 =?us-ascii?Q?KREyjFFnz2oNZ6wnLfF3RRQVFfQF+ty0vBp8xaAgHCS/Di8ikWyQKALHTkJP?=
 =?us-ascii?Q?Wi35h+ehbCAj8hconEcwB8rj9G4r88UpICakVE/O0zpopxXxJEILCki9UuPU?=
 =?us-ascii?Q?k+Wf3HdbnvS7eANNKnWLidEih8OHE+l/vbS9z/NucN0Y8mGVC0aB/tpV07hx?=
 =?us-ascii?Q?fQxD6w3K499amy/rBuA1mIF19jfIzX2D8gK00eI0DPPoJ1D7alZLypgQwacZ?=
 =?us-ascii?Q?NA3EGd+Z7hjvvZP0KK7pH1zbGnjSbgJ3HDcw/EOD8kBpp8+eieIx1/nYCCsY?=
 =?us-ascii?Q?yBb7161YJsS67jinffODesC9pcZbiSZIuq5yRKUzkalYKtdym0BrxSnnTu9N?=
 =?us-ascii?Q?4iMVHfr05x0pEdgMVx9ys8Wq+D/jfF/ly1HnGoSoRod5EhAFQsfpW/64Ee8E?=
 =?us-ascii?Q?ONQQx7N5TI/07M5pnYqZC5m3mQslhJeYuMT2baF1PU+zjO+Z9jEqiiJmp/1/?=
 =?us-ascii?Q?Gbh11wJhMWZR/1S/2G3bKFxBrkTTzg2ghz6wENJDEPpc/vBRsLYwvZLtLiGE?=
 =?us-ascii?Q?FWgMiggJZQbFEAalIDSZdwQWZZ0kKvIMOOTYzCsCYjckjsdjb4WBUzvu3jEt?=
 =?us-ascii?Q?hCxeUQbr8d80Tl2OnAwF4F8YZGh09lSKgZTDk6dCuTlS8E7mz5PfwbftHVLG?=
 =?us-ascii?Q?C3un1sxWZB/9zDWl7uubaHEbJhY4DytOU5RJoPLsBeosynYR0Tf9t0xoovSb?=
 =?us-ascii?Q?I/0gONkxfTNMqcKd3Y3IqfknH8mAgTKeytjNXINRrm1RuE8HCxju8FMyD9Fk?=
 =?us-ascii?Q?Q/U8FKK+uad2TtCPear9Vf4urod6fsseUvt/OKd8Bx/8fBZvKyqhCzCRvblJ?=
 =?us-ascii?Q?ZGabLCtq67LAJDrijbuw0mg0Gqtb3jOgyc3Sy+K6MI734CcGD0GuadO0UBtO?=
 =?us-ascii?Q?1R38rh4UZ53ZEE/DMXr56+LG2eRKGo3zRb0FXeFGmkNRU6hwVJJV6cWsK+1+?=
 =?us-ascii?Q?ong63dKpULywE5glYfTqxs8yu/8qbCLGykdeBi0y2/Tg?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43847260-053f-4bba-f5ff-08dbca86261c
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:11.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovbd2qOxB/1Wb+x1VCnRcBiDuQMSeRVZWs/EwQCfLO8SSeQKuIkCWT8NYt98SaKfmVNz88mpgdFRVS2YTKKUFg==
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

QW1vbmcgb3RoZXIgdGhpbmdzIHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KCkgdGVzdHMgdGhl
IHNhbml0eSBvZiB0aGUgUlRTCnNldHRpbmdzIGluIGEgUlM0ODUgY29uZmlndXJhdGlvbiB0aGF0
IGhhcyBiZWVuIHBhc3NlZCBieSB1c2Vyc3BhY2UuCklmIFJUUy1vbi1zZW5kIGFuZCBSVFMtYWZ0
ZXItc2VuZCBhcmUgYm90aCBzZXQgb3IgdW5zZXQgdGhlIGNvbmZpZ3VyYXRpb24KaXMgYWRqdXN0
ZWQgYW5kIFJUUy1hZnRlci1zZW5kIGlzIGRpc2FibGVkIGFuZCBSVFMtb24tc2VuZCBlbmFibGVk
LgoKVGhpcyBob3dldmVyIG1ha2VzIG9ubHkgc2Vuc2UgaWYgYm90aCBSVFMgbW9kZXMgYXJlIGFj
dHVhbGx5IHN1cHBvcnRlZCBieQp0aGUgZHJpdmVyLgoKV2l0aCBjb21taXQgYmUyZTJjYjFkMjgx
ICgic2VyaWFsOiBTYW5pdGl6ZSByczQ4NV9zdHJ1Y3QiKSB0aGUgY29kZSBkb2VzCnRha2UgdGhl
IGRyaXZlciBzdXBwb3J0IGludG8gYWNjb3VudCBidXQgb25seSBjaGVja3MgaWYgb25lIG9mIGJv
dGggUlRTCm1vZGVzIGFyZSBzdXBwb3J0ZWQuIFRoaXMgbWF5IGxlYWQgdG8gdGhlIGVycm9ybmVv
dXMgcmVzdWx0IG9mIFJUUy1vbi1zZW5kCmJlaW5nIHNldCBldmVuIGlmIG9ubHkgUlRTLWFmdGVy
LXNlbmQgaXMgc3VwcG9ydGVkLgoKRml4IHRoaXMgYnkgY2hhbmdpbmcgdGhlIGltcGxlbWVudGVk
IGxvZ2ljOiBGaXJzdCBjbGVhciBhbGwgdW5zdXBwb3J0ZWQKZmxhZ3MgaW4gdGhlIFJTNDg1IGNv
bmZpZ3VyYXRpb24sIHRoZW4gYWRqdXN0IGFuIGludmFsaWQgUlRTIHNldHRpbmcgYnkKdGFraW5n
IGludG8gYWNjb3VudCB3aGljaCBSVFMgbW9kZSBpcyBzdXBwb3J0ZWQuCgpDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZwpGaXhlczogYmUyZTJjYjFkMjgxICgic2VyaWFsOiBTYW5pdGl6ZSByczQ4
NV9zdHJ1Y3QiKQpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0Br
dW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMjggKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXggNjk3YzM2
ZGM3ZWM4Li5mNGZlZWJmODIwMGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJp
YWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBAIC0xMzcw
LDE5ICsxMzcwLDI3IEBAIHN0YXRpYyB2b2lkIHVhcnRfc2FuaXRpemVfc2VyaWFsX3JzNDg1KHN0
cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0CiAJCXJldHVybjsKIAl9CiAK
KwlyczQ4NS0+ZmxhZ3MgJj0gc3VwcG9ydGVkX2ZsYWdzOworCiAJLyogUGljayBzYW5lIHNldHRp
bmdzIGlmIHRoZSB1c2VyIGhhc24ndCAqLwotCWlmICgoc3VwcG9ydGVkX2ZsYWdzICYgKFNFUl9S
UzQ4NV9SVFNfT05fU0VORHxTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQpKSAmJgotCSAgICAhKHJz
NDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05fU0VORCkgPT0KKwlpZiAoIShyczQ4NS0+Zmxh
Z3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09CiAJICAgICEocnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19BRlRFUl9TRU5EKSkgewotCQlkZXZfd2Fybl9yYXRlbGltaXRlZChwb3J0LT5k
ZXYsCi0JCQkiJXMgKCVkKTogaW52YWxpZCBSVFMgc2V0dGluZywgdXNpbmcgUlRTX09OX1NFTkQg
aW5zdGVhZFxuIiwKLQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUpOwotCQlyczQ4NS0+ZmxhZ3Mg
fD0gU0VSX1JTNDg1X1JUU19PTl9TRU5EOwotCQlyczQ4NS0+ZmxhZ3MgJj0gflNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORDsKLQkJc3VwcG9ydGVkX2ZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VO
RHxTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7Ci0JfQorCQlpZiAoc3VwcG9ydGVkX2ZsYWdzICYg
U0VSX1JTNDg1X1JUU19PTl9TRU5EKSB7CisJCQlyczQ4NS0+ZmxhZ3MgfD0gU0VSX1JTNDg1X1JU
U19PTl9TRU5EOworCQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7
CiAKLQlyczQ4NS0+ZmxhZ3MgJj0gc3VwcG9ydGVkX2ZsYWdzOworCQkJZGV2X3dhcm5fcmF0ZWxp
bWl0ZWQocG9ydC0+ZGV2LAorCQkJCSIlcyAoJWQpOiBpbnZhbGlkIFJUUyBzZXR0aW5nLCB1c2lu
ZyBSVFNfT05fU0VORCBpbnN0ZWFkXG4iLAorCQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUpOwor
CQl9IGVsc2UgeworCQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORDsK
KwkJCXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19PTl9TRU5EOworCisJCQlkZXZfd2Fy
bl9yYXRlbGltaXRlZChwb3J0LT5kZXYsCisJCQkJIiVzICglZCk6IGludmFsaWQgUlRTIHNldHRp
bmcsIHVzaW5nIFJUU19BRlRFUl9TRU5EIGluc3RlYWRcbiIsCisJCQkJcG9ydC0+bmFtZSwgcG9y
dC0+bGluZSk7CisJCX0KKwl9CiAKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NV9kZWxheXMo
cG9ydCwgcnM0ODUpOwogCi0tIAoyLjQwLjEKCg==
