Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8447C5A58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjJKRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjJKRjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:17 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7187E98;
        Wed, 11 Oct 2023 10:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRuXSixgPJs38mZPzNP6C3nsOavSxOGX7lo1/WGijZnlDlRQ8eWrxxxf1W5s4wgsX+daCazjDoNk0OfHsJzU5zHmwJv59nuV1Irt3sqSpAzTt6XOUI14gX4vxqqKFz0DRVxQ92W8xdnKI+3wReLTqeXzcrJsbAb2MurBHUq5v+GDT8d1ObwPgT78MRufFnn6e+VTWTaeFZyRR4iMXaR4MdoTSt8NaHGrnXKN8droefuyWzWrPa/X2EBSK5n/f0/KGUgXgk9Nemg4WkpziIbimHzdJ74Si8SZwA2kNISu53wqk0WSoKQ3P2hnQNvLCIGB+4ujk7jcNRG4Q8g0PrDGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oK48PGvsIKhBF+d21ldU+Id6JckShcS/hsDClCbGVHo=;
 b=OT74+xrYWxE5LGaSillEvi+mLxhaZtkyCcWGYjfWMFCUdR7f/FkIFke2SpWEjp7IAOUU9CIGUzWk3s4FH1GtZcdPTv7dpepdlNYRA6IJh+cOju2UhDv3EHe1iCQMQQDWvaTtDWlGcXXb8dNVqDdI2JsrV+M0FQSgvNcWVabDo+J27fa4vZ4dV1S4OGG9880eh/18gZ/tKu38kkGM/ubCpWY/cV9tdRAs03pg1mtdIDl4InnSu0PH2Sqhuf6EkjZFnnEHctOai0ffUDm0I63BzltP9DW3uDDQKRp8/fv7C99WAUSPV4F5oW/COXndoYngLuuOqEyQS1rrU08ENJ0UJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oK48PGvsIKhBF+d21ldU+Id6JckShcS/hsDClCbGVHo=;
 b=0TSnZkBH9ERhP96Zj9iw3FCyjuI4u8zhWICab8u/G7kBmSaPMRW2f97ngrPpPgUoszJPWWS9F+ZTJeUSwfNCOWV7acV4WScw6KsVT9UfeVl7DTyeGNycu6Vsl2R6KnL6XS+MA1zdDe6AiJHi4849dzzkpBITpQIVWRHhyiiPg5Y=
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
Subject: [PATCH v2 4/7] serial: core: fix sanitizing check for RTS settings
Date:   Wed, 11 Oct 2023 19:38:26 +0200
Message-Id: <20231011173829.10508-5-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6788358-77d6-4af2-aa7e-08dbca80f7f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbRLNG4Hp5hrGIXlig/UQx2qtT2mYfMPwchd1VWf1a1z5+eAsHTwnk4Iy1CUE90jo9TV4un2CXIEUJrix47SHMoHplkwxEJr1ruL5aCJSdlhvEFnR+DckRMDleUYxs/WeU4k+8CvUXWvnGXB6ZLDA/Ctod54VDqg3CiJR8BrS91vFFK6hOBm/rlCuozxLl+Az6IRMb18RZ7HtM8NNx30G9DSAe5rmqioNG4mfoD/QcGVKA8xt+GjolbnjPBeZhjFOFq5a0BjqNUEGbO2ksCyD/gBrmZeOfDTGAmYCgT7pqg8fSyqcPekLnQ4dUR5XPNe5EAeiT+cSFGlvfFz9wjXkWXfXfJ4Rm6UPHQh9+9UD09zirbFGAhjMmGAvfHtZfidfkeUZQ1Uihi91DHW6ZSPp9Ij8GFU8u/V+rNwWUF6R2CYLaMBTZ9BA9XURhjZOhBPqmePSQ0h4xhzVWbElJt/04w7yxijKbUPvbwuRI7Vxpio1EIJ7vJE101yfLaj15ii0Pf5qBMHTUhSpiPMl/qpVWjhIjSQiof6i7rRpmXGFAgwKfz66eyStLKq55hjz8ob
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?heBXJxpCyGJj/bqZnix+xga6zMxVHMayjk9sHXCAlKiBqySPMbeQCqJohOCe?=
 =?us-ascii?Q?3AJ1j9Dcfa4ZXsBrbkwO/7AbGWmPMsmKXlAirgdm3PmrZsXnNdjTn11eUMZf?=
 =?us-ascii?Q?EI9zu7IgpKoqrq4wrHN4Dah4rjuu3V7K6DAFP/4M8yM3yVISz2jIpkGK1O8Q?=
 =?us-ascii?Q?Pz5UJUdXPD0JW6jc0vw4eVHV4Y2ti4LchO9pkCUG3XoCBGnUyxfk8PipLGc6?=
 =?us-ascii?Q?BzeZven5CCY/GSQrVdgUoBrK4rhV8mTHcRG8051bWREcyK9RczTLhJP4CZUH?=
 =?us-ascii?Q?w0E21LN2NPGMz2PzjyGWn7esFuBaBXsK/X1VbIwwAo+ZS0+lzBkrRImJKxHO?=
 =?us-ascii?Q?e3eO3KdfB029fE+cd0g5n0+cef0Wcfr6FUcXnezQ0elZKDlhsZ91hJo4Vf75?=
 =?us-ascii?Q?XALH967+qP6iYHB2fkrZzU91R+w3bDfEr7sC0ocdW5/iN4T4l0ZmQKrbPGDh?=
 =?us-ascii?Q?2iFrelgZCqUXRzwPt9sQVOo45hThZGU1PMsKkcwTceHAA1d40efSdTkCjuXn?=
 =?us-ascii?Q?3GbvAv3JNOyW7wwOMJyVti3uZBgsHWcBGkGj90vIfhOUPm1ciaEPDTtLthMq?=
 =?us-ascii?Q?s2ks0eM7UxHWqTSsO0Ov7Pv123R3JNeRAt4IGMaEWTsfz778gRfZ9ZI5kb+H?=
 =?us-ascii?Q?65m37gi0O2n74FJVdKMuSx38MLA1rDUFPuenLrWmB/4G2xU15nWekrRzRpF/?=
 =?us-ascii?Q?iErbaelEa5Qe/0mmJHW7zS5qlaVvJcbpzwXmPJiBJMBzzF5GcdARZd8yapAK?=
 =?us-ascii?Q?gyuT8PVg0uBIZFUIl9LnqGTNsosh9xwJqHPTdr3gvnEViyy08LBIKQjynY40?=
 =?us-ascii?Q?1ga+JEuZtSfQPzVPxB6AIYe8TswljmUdeZ/VUYkZ0GdautUIkldX3Q0tR0C9?=
 =?us-ascii?Q?AE4S7knKc2iVtZ3mC60F/aaX3AgT7iRQO4pmNR6jaZ2Qke6lIDqLgKNwoAnm?=
 =?us-ascii?Q?QagDls+7V5QMvfMISVY3A1dsLc7zEHyyPqEIwzCDjdG0YQxXIexVI1e52QHy?=
 =?us-ascii?Q?hPMK7CrLesmOLF/7gv/9oxXG+SGfx4WAYzj8J3lCqbQHrQatLcyGW70Xoo7+?=
 =?us-ascii?Q?DcGRu6+aGkRHucxWQBCZxUSQZ9Hg3L1q/hCH08siTn2aQ/FJHzvRqgHRyms+?=
 =?us-ascii?Q?EVVmGrg0FYBL860GrZ5BfHYvHUQrxUASNwdyAujVpdF4dlxpGkr0x6QpPa14?=
 =?us-ascii?Q?5BN/Zm+QrRrStDbAPOlKtcUdS72Q0JwwfV1JwFsY2VBnRuiuUBeN3oD4VWsY?=
 =?us-ascii?Q?24ti+zI6YYaWlKjNyoLQFanxxA9FLwnsxyGLbEu3ZX6CfOKfo/l/7ZS0nGjD?=
 =?us-ascii?Q?pSdR/DqCFTZB4JhKjuAYqWoGXyB5h7j29zClBuEdXDQHg8mWw875Ue71G5QD?=
 =?us-ascii?Q?riEoN+P7kVcEaLCoL3tPQ9V7M6lsLn0a1NtU6ur43GIEQ4voOgTFTy3uMNPZ?=
 =?us-ascii?Q?mvfijBKrlxoGXASAe6q0bKUdjEQv8ifWqp9J9D9Mjg4TpOsLTUIkt1s2ScBW?=
 =?us-ascii?Q?C4W6T5ZGROehPIq0XQNYKoFh+Jc59TGzyT+2Vaw+lStHXLUzIpoQ09S3c/MP?=
 =?us-ascii?Q?Un9G1owUuyxgPq2ZUUfW+PSxVj5u6Xsd/WK/NTYtKfSniodYtSd/G5kBs7dI?=
 =?us-ascii?Q?1Qwocmi7aUdCyOTvIZfn57J4yXVZoxKIDjtBogvjDBIs?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6788358-77d6-4af2-aa7e-08dbca80f7f4
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:06.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwcIsKvEWDJB60NZDevImlIlIArjzwRAk2TI0VUJm+jC7T4F9YtwmyERbmVAlrBwdx/VfE2IHzrPSCtJZvYaZw==
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
