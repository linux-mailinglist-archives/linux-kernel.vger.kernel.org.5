Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B8C7F05ED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjKSLcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjKSLcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:32:06 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784A3AA2;
        Sun, 19 Nov 2023 03:30:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqMnpe1A7TTuPXB8XlXjjpGFNvwYV2UDVDr54x5Nau8izBIuXhzwelALKBkyJVnx8teBM+OEIU5OIMrcVNml8jweKTmaPN6egSFHSBe6eksIQ/RFkiUd3FskI0JVzqcBWEdk+yIjl7b3AgXnSH2Dts+8w6V/vvbt8yup0fKeucr5SkKVWqEHE2WCy3eVc+2zyxXxxIqOg4Wl+eBxoS6X7uyhz4AeTzZ/KWmK8V1YqIQGKe6UlacjrzLOQ3nWwK8B5vhFUPu3CcRBjA6xYuoFCUWhnxbgvxZsiH0d0e08/tdsmovKKwgbYcBLBMuqEqcDqJVMNem09ES8VtBD5PXASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2pTezH0DgO8+z7w1y5ywOUCZlRR/vO2d+VhJfncoRA=;
 b=Qb0QQbA2gQU9MoUOZxSeqFTsWKJXbVP/AxPACyDocAiYIye8QktYLOL8XJ6Q/oh2HhACq2Xrlv9u6y/h1VBjSA1icN7FGvRseDVz+lQuEhKaEBEeNbZ3YGFncUzBOnSF0stjlHhwKnA9UYuhiWwU2eVF5W0N3P7dKCt3cYvggMapQD22sMAP2MjelSYB5WgS3BwsDdTxzphr+El3MMZnAGV2Yu4t//d3/+KekEb1oaK7OWI7W/WUrnv8LXci7f5XqO8Q3N468AAILAwVLWw5k9abbYu+JLuAnTMd82PC5smaHgLENqCMa7lTJxsvuZUAtt3qtdMocUBwHTgaSQxM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2pTezH0DgO8+z7w1y5ywOUCZlRR/vO2d+VhJfncoRA=;
 b=kVyC4JL3qta0Rq0u5WhXjLzyr3rywyZY73jY73LdvUJcXE8ivyDERZ0+OFAlTrQ4bpsPdCeODtcnLSbQOAiyi32kQWio3i7U0ege/iVDKvERXutNc57ppVRilbmufmDJz/u0APaK/+PjG52AWdmx9FWyYOtpJfTounVEx6Woelo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1060.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 11:29:59 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 11:29:59 +0000
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
Subject: [RESEND PATCH v4 1/7] serial: Do not hold the port lock when setting rx-during-tx GPIO
Date:   Sun, 19 Nov 2023 12:28:49 +0100
Message-ID: <20231119112856.11587-2-l.sanfilippo@kunbus.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef6725b6-4b36-4df9-26f8-08dbe8f2dd1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUTUgW8ALe0G2xq5rLSflLGhGbHz3foUod+q/Bp98SkOWkZwLAbsskDqkpHr9rDpdSFv4LJaPkAmb5cRFluE5IL1YdFZf3HqZtXHNb3PjxmV1imKZY69wCrnncJBFNlhqSMGlwDut2EAscpTzlUV5xjH6yhixcMMP3sKv6/+T413/BM3PuPohcifnEdd8zCimLDr072z31F2/3fZ2ao5a8ovIi4pCyof3SkPjcxuOj0r7wc/vMvuj88MvaPXk9H6aqMDPmYdauclQ9/DRjrrNJs67FabQyJTP0/YduobSwEUAg+shzoJU27Txxq6I7Gog4KRrZTPNCsuKVJHhUWp+cU6kT1KRlzT7cluw9bVmakw9TtRpXLgIO6OCIMCFPidoVRUotFJCM2coNB2/ErELsbk7zXr5dHE/8YT/033tvL9KduE/1fLtneMHcIRHFMIjI4CBxCPGvW8ULVCIkht7mLI2yLCnuB/L2G0sYNdBaWAt4P3w4N0dk+tw2bem37L6jf8p0D8hoKOVZ1W/Fcn1ipxvgo1EWj/6K7sokpc5nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(83380400001)(1076003)(2616005)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycBRkyfAQ76L/h7O0AVb8etclca5oTgbxv1WjzBeBCu3iMySu9gu93whUXT/?=
 =?us-ascii?Q?DdV1OzEC2aF7fACCAsXhILk5v6qPb+NgtAh2mykA1P3arnV3wZGSTw1at0TW?=
 =?us-ascii?Q?d30b0vmtsTiuYB95FKk7yEE6CGG87lKs+OTCds2LPBPj/77YwxAvNji/gNfd?=
 =?us-ascii?Q?mWNdEE52WDL4WDtOE0X0Mj+uk8yhMt+u7TAP1A/IvQ9ka63vSAzoXxf5YkGe?=
 =?us-ascii?Q?lV0FDEtc/N7vIyxI8t+NsyUGypUMYaVgwa+Rw31Gkxw85rOTZF86zpW2JEIH?=
 =?us-ascii?Q?YRxwM50bDfwdF/50mtnk5AFmvADKd/vuQr5lnic007T2Ma+ERPJRumjXE6H+?=
 =?us-ascii?Q?EtcXHMuvSmMU2+C7dfHSF5ZESnDaUnGit3Ft9eUz8ZF+hTf8Cm6z3XegmwW4?=
 =?us-ascii?Q?9OGTMP+hfV7tluyWSa8+bp2j1cH9Fxr/UtS2B1VMfeXaNFRPy6SH9QyT0Awn?=
 =?us-ascii?Q?0yANuDEJsMXUKX7k0BeMOPnwJJMwNdEfIzwJJJLC2b9Tf46P9GbCZMGgXPIY?=
 =?us-ascii?Q?Asfwd6QS2X2qJwgNGW4t1TE/CS9NazlyYrLumhf00XB/YQTY4eDUeaA9OivD?=
 =?us-ascii?Q?tDlujP1lFIX0/eplopmC0f8IX7l+48Yz9w/lPVmg+6K32NIVavKx6tnD5kOK?=
 =?us-ascii?Q?w9gjLaZwcKIml8tmV/lY/pgLRaS9Uz53v+NnLKsBJdPY6JjKBbwAPS/0rMEr?=
 =?us-ascii?Q?sfkz9qM7CZSHlPysogsUx5mQSBwW6HW1HJ2DmpmGt1hafiqWLtO7DQzfzoTf?=
 =?us-ascii?Q?U5cZvOOOMSJOTULW0+vsUeDe9wuvtRvpdYF4RGEDDJUBNSKbVwe/IkSIF2yR?=
 =?us-ascii?Q?BHnoSvvmgx41t6G3uwbG+PSGeDJG/vsr/DjAs5BW/YBWk1x+eeOeT22/Xp2i?=
 =?us-ascii?Q?+QftDfoGs2RWDlhtQlF+PdIWVc8lpHaBEAmULd2wJxoKe3o9s5sRolX5FsRc?=
 =?us-ascii?Q?qj5732WTjR0CnxRjP63/TAC02Ttj6mIY6huWpyYMMHd4S77etepzlbctYtzT?=
 =?us-ascii?Q?dpvxzdyxZy5Ij+0nX7n9fIcp99MvERxYWj9zCD8iS+hs0WuKgpel8XIi9uss?=
 =?us-ascii?Q?TrMpoGs2obLe4guC4q6Nk+zeCyLJaClaGreJNThF4JQmXU7fZatGs6jFKgLH?=
 =?us-ascii?Q?Lggni+zLYkCzgf7tIjahqaqjfKgSqrR/cm1LhI44x8I+aqWIRjA3VG5Wp6Di?=
 =?us-ascii?Q?uvmyurzq2YgmpliZI6LJl6Iwe1yxZjOSqc4V1MuaLECvysZhiQ9ZOk5bCEj3?=
 =?us-ascii?Q?lpBmDqeuqHdiFK0vziBMzN5MuUNLYgkRkehiGHHoZzUQe2ZgInXCfyiB5XyD?=
 =?us-ascii?Q?aEE1iYgFZpNJhRsBewCYIwX6baqTJykK93BiBxszgdMSc8SDfr3EsqI/Wgaw?=
 =?us-ascii?Q?1L6h3oHmwgWFNep9PwXlM4tJsfua5KUPaBqOdtjILZOutQM7l2hJWjLQH0UO?=
 =?us-ascii?Q?plzfkk9wHUjGZLaQpo4lNY4FsfsBdz8DWOsgadgDN17LxoWO6EnO4qDhvIj5?=
 =?us-ascii?Q?tmkoNcKcWuShfHpPnaEeJkk0HkdjYzeHakS3JzoyT/SBzikxnN38y7xEqZjm?=
 =?us-ascii?Q?RuJbdZPmESxViImKrJYcLwwONcoh8v7EWr+gZemf0Ut5jdLlH+fOZwag5aL6?=
 =?us-ascii?Q?aTPiBO6GOWkR+Gy4StS0/t9y6IuO8IMgmVBe80EGeRb/?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6725b6-4b36-4df9-26f8-08dbe8f2dd1b
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:29:59.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IM981oZrSd5OGu9aotJLllfE8gp1pXovJCBdVLsFPmQfz/yw71jDsJtx6/lujfBQ4im35LMfVGIN2F4W1CTtpQ==
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

Qm90aCB0aGUgaW14IGFuZCBzdG0zMiBkcml2ZXIgc2V0IHRoZSByeC1kdXJpbmctdHggR1BJTyBp
biByczQ4NV9jb25maWcoKS4KU2luY2UgdGhpcyBmdW5jdGlvbiBpcyBjYWxsZWQgd2l0aCB0aGUg
cG9ydCBsb2NrIGhlbGQsIHRoaXMgY2FuIGJlIGFuCnByb2JsZW0gaW4gY2FzZSB0aGF0IHNldHRp
bmcgdGhlIEdQSU8gbGluZSBjYW4gc2xlZXAgKGUuZy4gaWYgYSBHUElPCmV4cGFuZGVyIGlzIHVz
ZWQgd2hpY2ggaXMgY29ubmVjdGVkIHZpYSBTUEkgb3IgSTJDKS4KCkF2b2lkIHRoaXMgaXNzdWUg
YnkgbW92aW5nIHRoZSBHUElPIHNldHRpbmcgb3V0c2lkZSBvZiB0aGUgcG9ydCBsb2NrIGludG8K
dGhlIHNlcmlhbCBjb3JlIGFuZCB0aHVzIG1ha2luZyBpdCBhIGdlbmVyaWMgZmVhdHVyZS4KClNp
bmNlIGJvdGggc2V0dGluZyB0aGUgdGVybSBhbmQgdGhlIHJ4LWR1cmluZy10eCBHUElPIGlzIGRv
bmUgYXQgdGhlIHNhbWUKY29kZSBwbGFjZSwgbW92ZSBpdCBpbnRvIGEgY29tbW9uIGZ1bmN0aW9u
LgoKRml4ZXM6IGM1NGQ0ODU0MzY4OSAoInNlcmlhbDogc3RtMzI6IEFkZCBzdXBwb3J0IGZvciBy
czQ4NSBSWF9EVVJJTkdfVFggb3V0cHV0IEdQSU8iKQpGaXhlczogY2E1MzBjZmE5NjhjICgic2Vy
aWFsOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBSUzQ4NSBSWF9EVVJJTkdfVFggb3V0cHV0IEdQSU8i
KQpDYzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPgpDYzogU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpTaWduZWQt
b2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRy
aXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgIHwgIDQgLS0tLQogZHJpdmVycy90dHkvc2Vy
aWFsL3NlcmlhbF9jb3JlLmMgfCAxNSArKysrKysrKysrKy0tLS0KIGRyaXZlcnMvdHR5L3Nlcmlh
bC9zdG0zMi11c2FydC5jIHwgIDUgKy0tLS0KIDMgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2lt
eC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IDcwOGI5ODUyYTU3NS4uOWNmZmVi
MjMxMTJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKKysrIGIvZHJpdmVy
cy90dHkvc2VyaWFsL2lteC5jCkBAIC0xOTQzLDEwICsxOTQzLDYgQEAgc3RhdGljIGludCBpbXhf
dWFydF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0ZXJtaW9z
ICp0ZXJtaW8KIAkgICAgcnM0ODVjb25mLT5mbGFncyAmIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFgp
CiAJCWlteF91YXJ0X3N0YXJ0X3J4KHBvcnQpOwogCi0JaWYgKHBvcnQtPnJzNDg1X3J4X2R1cmlu
Z190eF9ncGlvKQotCQlncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfcnhfZHVy
aW5nX3R4X2dwaW8sCi0JCQkJCSAhIShyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X1JYX0RV
UklOR19UWCkpOwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5k
ZXggZjEzNDhhNTA5NTUyLi5hYjc2NmY0OGMxNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5j
CkBAIC0xMzkyLDE0ICsxMzkyLDIxIEBAIHN0YXRpYyB2b2lkIHVhcnRfc2FuaXRpemVfc2VyaWFs
X3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCBzZXJpYWxfcnM0CiAJbWVtc2V0
KHJzNDg1LT5wYWRkaW5nMSwgMCwgc2l6ZW9mKHJzNDg1LT5wYWRkaW5nMSkpOwogfQogCi1zdGF0
aWMgdm9pZCB1YXJ0X3NldF9yczQ4NV90ZXJtaW5hdGlvbihzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
LAotCQkJCSAgICAgICBjb25zdCBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkKKy8qCisgKiBT
ZXQgb3B0aW9uYWwgUlM0ODUgR1BJT3MgZm9yIGJ1cyB0ZXJtaW5hdGlvbiBhbmQgZGF0YSByZWNl
cHRpb24gZHVyaW5nCisgKiB0cmFuc21pc3Npb24uIFRoZXNlIEdQSU9zIGFyZSBjb250cm9sbGVk
IGJ5IHRoZSBzZXJpYWwgY29yZSBpbmRlcGVuZGVudGx5CisgKiBmcm9tIHRoZSBVQVJUIGRyaXZl
ci4KKyAqLworc3RhdGljIHZvaWQgdWFydF9zZXRfcnM0ODVfZ3Bpb3Moc3RydWN0IHVhcnRfcG9y
dCAqcG9ydCwKKwkJCQkgY29uc3Qgc3RydWN0IHNlcmlhbF9yczQ4NSAqcnM0ODUpCiB7CiAJaWYg
KCEocnM0ODUtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQogCQlyZXR1cm47CiAKIAlncGlv
ZF9zZXRfdmFsdWVfY2Fuc2xlZXAocG9ydC0+cnM0ODVfdGVybV9ncGlvLAogCQkJCSAhIShyczQ4
NS0+ZmxhZ3MgJiBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUykpOworCWdwaW9kX3NldF92YWx1ZV9j
YW5zbGVlcChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbywKKwkJCQkgISEocnM0ODUtPmZs
YWdzICYgU0VSX1JTNDg1X1JYX0RVUklOR19UWCkpOwogfQogCiBzdGF0aWMgaW50IHVhcnRfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCkBAIC0xNDEyLDcgKzE0MTksNyBAQCBz
dGF0aWMgaW50IHVhcnRfcnM0ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiAJCXJl
dHVybiAwOwogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUocG9ydCwgcnM0ODUpOwotCXVh
cnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsIHJzNDg1KTsKKwl1YXJ0X3NldF9yczQ4NV9n
cGlvcyhwb3J0LCByczQ4NSk7CiAKIAl1YXJ0X3BvcnRfbG9ja19pcnFzYXZlKHBvcnQsICZmbGFn
cyk7CiAJcmV0ID0gcG9ydC0+cnM0ODVfY29uZmlnKHBvcnQsIE5VTEwsIHJzNDg1KTsKQEAgLTE0
NTYsNyArMTQ2Myw3IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0
dHlfc3RydWN0ICp0dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJaWYgKHJldCkKIAkJcmV0
dXJuIHJldDsKIAl1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShwb3J0LCAmcnM0ODUpOwotCXVh
cnRfc2V0X3JzNDg1X3Rlcm1pbmF0aW9uKHBvcnQsICZyczQ4NSk7CisJdWFydF9zZXRfcnM0ODVf
Z3Bpb3MocG9ydCwgJnJzNDg1KTsKIAogCXVhcnRfcG9ydF9sb2NrX2lycXNhdmUocG9ydCwgJmZs
YWdzKTsKIAlyZXQgPSBwb3J0LT5yczQ4NV9jb25maWcocG9ydCwgJnR0eS0+dGVybWlvcywgJnJz
NDg1KTsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIGIvZHJp
dmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMKaW5kZXggMzA0ODYyMDMxNWQ2Li5lYzlhNzJh
NWJlYTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCisrKyBi
L2RyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jCkBAIC0yMjYsMTAgKzIyNiw3IEBAIHN0
YXRpYyBpbnQgc3RtMzJfdXNhcnRfY29uZmlnX3JzNDg1KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQs
IHN0cnVjdCBrdGVybWlvcyAqdGVyCiAKIAlzdG0zMl91c2FydF9jbHJfYml0cyhwb3J0LCBvZnMt
PmNyMSwgQklUKGNmZy0+dWFydF9lbmFibGVfYml0KSk7CiAKLQlpZiAocG9ydC0+cnM0ODVfcnhf
ZHVyaW5nX3R4X2dwaW8pCi0JCWdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChwb3J0LT5yczQ4NV9y
eF9kdXJpbmdfdHhfZ3BpbywKLQkJCQkJICEhKHJzNDg1Y29uZi0+ZmxhZ3MgJiBTRVJfUlM0ODVf
UlhfRFVSSU5HX1RYKSk7Ci0JZWxzZQorCWlmICghcG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dw
aW8pCiAJCXJzNDg1Y29uZi0+ZmxhZ3MgfD0gU0VSX1JTNDg1X1JYX0RVUklOR19UWDsKIAogCWlm
IChyczQ4NWNvbmYtPmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpIHsKLS0gCjIuNDIuMAoK
