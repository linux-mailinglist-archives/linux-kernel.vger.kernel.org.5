Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD1813639
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjLNQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443458AbjLNQ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:29:16 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A238711B;
        Thu, 14 Dec 2023 08:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBxfwrf2kSaIMs1tDY5FPf7vKoF+hStGGxJKfSJuQ+jfvS9DrzRYoiI1Ejsv6lzcT0r50WxTZ7BNGvEDLTSIXPj7fGZgxHnmSQSfnRi5LLonz0neZwnEWr4xe2ZnTf3fFDrOnWab1BTs5+1xtqAxzrbXaecmzKZS9RCcV91WO3TzRhJG1KrgCAUEcFKpBWTsmixvKB9kW9ynQpJRHFkGtAKmjCv+MKIm6yHKabsoAgiDGRJr0HgTwwxbTZjTYp0biBruI1QgVeULGRn5xjn75ak1Nr8zg9bHExcnorR8QXnrayvnKuNpdKl+fE9xSGTyxX4z19O4Y9FHenCVk89ZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nbp7KXbUxxTU41IvOZEP4Y+wSOIC/dVuJsy2ah9s2E=;
 b=mh55u7loVLpSV3fwpXguWeANLhyTQqh4kEmBq4/D1hC2gPEQGYXkwJm2Wq17ccFOTeChE5xWz6OpU5EN+BVbuMsCAoKyDWtlmiZiGadDCriP1nt61MGP1Pl0W/FzjOK8gE7nhZe667270HGA9/dKEs6DwGidD/QpJabXeN46NyRltawUrv7mliPJidJUV3iv9I6Ymaa29dbut3jb99TmDvm+vjQSYrJIBmbGRcUrHDSl/8QZILHIqsNiqfXcal36CSd5kWGkfs8u5mljRzl3OjESmFBe18pfRVaJ7rygIfB0r3Yh2W0GwgW8Ffkq5oqd6Kl3p5e+78JYbrwNbW5uPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nbp7KXbUxxTU41IvOZEP4Y+wSOIC/dVuJsy2ah9s2E=;
 b=JnHWoiou5Mz1J3nn7mkUlKYX4JzWE2NFfbZtSxUBExTeJq34cjwtDj9EH85FnNv9ezPzEZsuc3WPiLF2175Ndm2us7ZNOSNi2XxVyhSdW7lLNRzEQRGEESMYjpSX9hGGOs6ErgMyWllpsQvU7l6DDGGFEHVm4D9ehY4fL5FzfmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DU0PR08MB8302.eurprd08.prod.outlook.com (2603:10a6:10:40e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:29:16 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:29:16 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Date:   Thu, 14 Dec 2023 17:29:11 +0100
Subject: [PATCH v2 3/4] usb: typec: tipd: declare in_data in as const in
 exec_cmd functions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-tps6598x_update-v2-3-f3cfcde6d890@wolfvision.net>
References: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
In-Reply-To: <20231207-tps6598x_update-v2-0-f3cfcde6d890@wolfvision.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702571354; l=1739;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=G8jD1YMhqm/GwQuFi+8ybk99Xtsx5Enpb51VaGZhocc=;
 b=ks125/rMHj9MP/oDOQ4RVolGqp+bBk2Gkt+jrvOZVYLyCbSkJHD7Gb3/E0eKr0pn0JiU7q74K
 v/jlWNtyGo+AR8PYew9gYCxv+K9zuJwMguB2WJ0bHhHoI1TgCZKEQQE
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DU0PR08MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: d396dd6f-1995-445e-708a-08dbfcc1d0e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOkrW8J1in8njbgWfVLXutUWGWql1LPL4gF7a7fcDGDUWOYvuz0Sfjwm2sKG6GwqNQzp98WAbFZ0rT5xr+8uBtc8eGwzKgWBGdYDazhjFJXj4AOaTRS3okZ7V5O4EerYy1t/Vmk96Ef4SE+OrED9W5rjtsZofXXVriYAmjPhoRy+QDeNA+mgkqZEYVFnbVqPoAejc3qrNJ8H6fBg5fRatf9XAunLD2iaGNTjgqbeVDbPHpAei7WcaJIiKlkCnVsjcjMlpEfTFvPhrKi9Mx2RMjk3T00B2Y83DvUyi0g0DuXobTLMrkT0s3KvFooPxBYciscjTHQAJGMR1lLugnK/msLYKI4fJhENJPYin9KGQEDZgSmgGc9o1anoUuOltJq5lntgYHCc1Zf9D3Ax/cmWR0T/O+x//cgX2L9f6iiRFzna7+1qbkBnkrsk1J3mXpFZusi7+N63n4ma72WrJ1kqsetvt+ztl4kzeWYT6ZDjpxqscozIg0S64qfWNJYMNnkefvrgJ/747hPbyHNT3pgG2hTRmQiwjgIEVxK0GSxVvMLKrTezGqR5QZ7/gjWEzhEVwRgf82Q6IDP+UcZmt3fUOsw9uhVJ+16S9aS6XjcZNNVkC6vCzpxdZTMGZE6Ev2UF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39850400004)(376002)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(52116002)(107886003)(2616005)(26005)(6666004)(6512007)(6506007)(66556008)(83380400001)(44832011)(2906002)(5660300002)(41300700001)(6486002)(478600001)(66946007)(8936002)(4326008)(66476007)(316002)(110136005)(8676002)(38350700005)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5qSlRzeEpSK1BPci82LzBNRSswdk5HQlVVK3FySmxuWXNGWDNpZU0zcjZR?=
 =?utf-8?B?N0NUdEIxMWVTTGR6RVdza1BLN1FGZVB0emszTzBHWGI1WG9VN1hPSUYwNFBY?=
 =?utf-8?B?QTdVMzZxUElBMm11UGJwRnhmaFlxd2w4TjE4d1IvVDhhSk9CbS9QcU82K3Za?=
 =?utf-8?B?bit6N1oycUlPM0tJQ3VCeDZ5WjA0NjRLUWN5T2tuZTRZSWJGZnRiZHhiWVdm?=
 =?utf-8?B?Qlo5aytMMktacHJEYi8rVlU4Wk1uUjhoQjRZYndLWGI4WkY3K0c5N3ZuZlpU?=
 =?utf-8?B?aGxuUkdPQ2hZUDBoQWdLL005QTZ1Vmt6Nm9rNk5ua2pSN2JRRkFiaDJYNkti?=
 =?utf-8?B?WVc0b29YbUlPR1NJUmxhb3NSYWFHa2JQUnNFT1p4bXlWeE8ybkgzOWtUajl6?=
 =?utf-8?B?eVlEK1RNeFB5b0ZFU1dCSERIUlBkOUFVYUozSDZpOXp5UHRVajhuczRKUFRn?=
 =?utf-8?B?WmJTTzJnUWxkQ2FaSTNYbHN5TlhLM0NjZTdTV0NOc1lnd1hRR1NITEZEdHhZ?=
 =?utf-8?B?U3M5MkRlMUFibGpvajVLNmZkU1dLdS80K1lxZ3RHV3FMK1lIbnh5M3haQmE0?=
 =?utf-8?B?RUZYWk5GTm9IUkJieFk3ajZaTmNMQ0I1dDI2aWYwSmZFNnN6c09RRkZ6a2x0?=
 =?utf-8?B?Q1pQWFoxbEV4a2M1Nnd0NjlNcEx3YnplUGRYUHRlN3kvYjVKWCtqWkdSOGYw?=
 =?utf-8?B?WFlXb1dsUHJNQ2xtK3BxMTYrVzRMT2xCTzVMTVpsN2FVV05zN2xGZUR4K21S?=
 =?utf-8?B?NVdiL3pBNGJwdkppQ2xSeDZwNmRQTGM5ZlVzK1VMUms0WXdxUm5SWVg2Zldw?=
 =?utf-8?B?bkhmc0x5dTRHRE9xNXBuYytrU0ZTeUZ2Qlg2d0k4VVZ4blNFNkxucWlJdkNC?=
 =?utf-8?B?L3JWbmttN2d3OS9DeklWcWRwanNQRlBwSC9Zd0xUQnJYeDY1OWtUV1JsSTV0?=
 =?utf-8?B?dS9HcUZaWWQ1WHhNMjJpbWZpN3dCTURxZ1lENGxrSzNNNGxnWFYwaXJNcEpp?=
 =?utf-8?B?Uk1hdDFhNnptNlY0SGRXNC9mVEN6aG9TREhtYnJQUk91V2wzeXdQNW93L3Rl?=
 =?utf-8?B?OHFrbmVDTFlYVHdnaGFoSVo3MEtDT0UyS29YeGxKZmxkeXpxVndCQWVKbHZJ?=
 =?utf-8?B?VWpvSVNzTUpldysxQW5ydVZQTXVxVGo4WWFUN3RWbVUraHRNNG9UMkwvVVow?=
 =?utf-8?B?VldWdnNtNjlEN0lobGZCQlRReUVML0RDZTNDb0JhUFlRR09ydXhRcWM3NnN0?=
 =?utf-8?B?UHVMeHJ6YlhwSjJveFBiNlFXdHBKYmNlRkwxbVFQYXYxTk0wTjZTd21mbCtC?=
 =?utf-8?B?RWpYcHozR29ZaktweWFIbVEzYXZyZ1A1VXoySjZFKzFLTTdMcmhQWXY4cm9N?=
 =?utf-8?B?bUc2WFlNWTVSRk5Ia1pBSkxSZzdod0ZncnlJTnJLOElsdzZZYTdnVlpuTkNs?=
 =?utf-8?B?Zkp0cUJrbkhITHhMTTBwYWJhcnVHMWh0Wm52VGRIblVyNnZ1SGZtcHU3dko5?=
 =?utf-8?B?OTgvU2NDYSt6eGd2cGpUMVNIOERlbEQrRnhnRXNWUmFPa3NpR1J1WnBjVmM1?=
 =?utf-8?B?cGJSc3R3SmNJZ2VEVTN3emRuNlF3TG5PVmc3TThWNlB3ZnM0ZzZ1dDB1c09m?=
 =?utf-8?B?d3YrRkNacHk3aEQwQW5HSWFJczRaamtlbDdTcEh3VisrblkrZENWcDA5cDRo?=
 =?utf-8?B?aFBtTVFlMS9DNUdwTmFOU1FXUmo4YnZwRFNuMkZ6c2phWWFLbnM1R1M0ei9H?=
 =?utf-8?B?NlYyTUhiN1pKeDhIOXFyUjZEblZQdkxNVGlEejk5dm1GNzBWZ092RjMxUktm?=
 =?utf-8?B?MndtQndhRGp3bGRtNDdaWnhrZmU4djIxWEQwd0xIQjJEZjU2UmlwZVNPOVdv?=
 =?utf-8?B?VkswK0ZDR1EzNmNOVkZUbnZ0MTdFcGVFT2NwVzRBQytYQm4vT3pTT21nQU1p?=
 =?utf-8?B?QmxyRitCVlRYekdjNDdqMGcxc1lyNkpObzdpU1pqWkNEUnFyU3V3ZUVpMmh0?=
 =?utf-8?B?TW5BTmxPN1BTbjU0S0s2Q01KQ3V6NFFHQVZuUk5nV0Y2YTQ3SE56M1NPV2hV?=
 =?utf-8?B?cDBrL3pRM0pmaXpYY213Uy9SNFVzK1JVczRMNmFCcWZaRC9sYm1VR3c5bmFU?=
 =?utf-8?B?UkE2dlpYTHhvaXBzMHdGQUR6Y2l6ZFpLaDFOYXBSWE1QY1k5S0V0YXpCTHNo?=
 =?utf-8?Q?hjeJpHXGrjIXEHCZPAGasBo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d396dd6f-1995-445e-708a-08dbfcc1d0e3
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:29:16.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gAqaoFCD69lPL89BonTnrsUDM8zLav8QsjB347qJzPG9N8iqnnyZfbF4u+A5y3wW1I9EOMrxufWmj/0QdYF+UwJW6x5Rr5d8yErbvi6dcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8302
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input data passed to execute commands with tps6598x_exec_cmd()
is not supposed to be modified by the function. Moreover, this data is
passed to tps6598x_exec_cmd_tmo() and finally to tps6598x_block_write(),
which expects a const pointer.

The current implementation does not produce any bugs, but it discards
const qualifiers from the pointers passed as arguments. This leads to
compile issues if 'discarded-qualifiers' is active and a const pointer
is passed to the function, which is the case if data from a firmware
structure is passed to execute update commands. Adding the const
modifier to in_data prevents such issues and provides code consistency.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 83e5eeecdf5c..7f4bbc0629b0 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -330,7 +330,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 }
 
 static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
-			     size_t in_len, u8 *in_data,
+			     size_t in_len, const u8 *in_data,
 			     size_t out_len, u8 *out_data,
 			     u32 cmd_timeout_ms, u32 res_delay_ms)
 {
@@ -396,7 +396,7 @@ static int tps6598x_exec_cmd_tmo(struct tps6598x *tps, const char *cmd,
 }
 
 static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
-			     size_t in_len, u8 *in_data,
+			     size_t in_len, const u8 *in_data,
 			     size_t out_len, u8 *out_data)
 {
 	return tps6598x_exec_cmd_tmo(tps, cmd, in_len, in_data,

-- 
2.39.2

