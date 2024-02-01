Return-Path: <linux-kernel+bounces-48021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5134C845659
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB64B24749
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86715D5AF;
	Thu,  1 Feb 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="LHkFL9FB"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2114.outbound.protection.outlook.com [40.107.247.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9583D15CD6C;
	Thu,  1 Feb 2024 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787457; cv=fail; b=sOkV9iK3KJRLtfd7Lc3WpCumS31yCx87wPo7l0uVPgKB4JfEQ9yxQvqyKW2V3Md/bacVo2J1mVsYzdSL810MJlIOcFvmFGOlf3qIfm77DCPjC4L3mtya+HTQUtYfoZ0zTuoJTK8GmLbcrSwe5b1D72Un6HJbbuoTz0GixycAGaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787457; c=relaxed/simple;
	bh=4TLzuUG+cD1ah0+jc3t9NcCQawuhHMyWz8z+IOJLiJo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tJP8UNsRG5m/VmG5pctzud9HjbYpA74WwunErLRbVYX7ys6vNiGmxl8EAolZ1GDGAi3mfci+75gQAz4aIzi/NGDOxJZzsBaKGABFMuCbUMirpFs7mu/uiSrV1N4Km67kNM025SuChEb6SCxgBUq48eiWBiIOwtEo1Wwg2n2FBl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=LHkFL9FB; arc=fail smtp.client-ip=40.107.247.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oV9xOpqPGyRtcZZvJdeJ6tMTTvWpjt4Y+8xJeLjFmhf80q9y5zHi9p/uCif6y1OXyNLNlLXLmwPqNi3775UrvU8VQWzELHEtATzRuT7iVo6bhsUL03MXMvtIDHxfvdFjtLfY0nE8+fWg2IX1HQHWBTNNS8yv17W3dc83fYEOlzY6XDJIVkY5r3ffr9N5hPM9bB+eF3dQw8rANVS7U6gOJeiA1fVcPbWHXa2D8B8Sp3R98wYfsO1+rgPpkFXeE749odqrmetFOZkLdgXfsyWVAVHJQ8DJM3FbK5hU6TYnHA9RkWdEiHLGkyN8bLhaH9sT/rNh4VR/jWl9gMYYfOtSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TLzuUG+cD1ah0+jc3t9NcCQawuhHMyWz8z+IOJLiJo=;
 b=TvLMCJ9b8EUHl2e+7ZwhRMGLnYA+NoJ9jo1TXe8jR6ygF5avijaDb09UYkoa1lEvC73ARw3bePv7+fZyKTO1y1+ihqsUtDEpKTqYf4sl9kTbe1qBAfHE1IX2Wa92lVX3H2Iw0neOKQsayCTXscCvBRkkaXbCC9g6uykWzB+6qK2ggnSbz8OZaUcyQJzSsbQX+ewI3QdakZq4S3CHRx8XJnksBcEkc1qVciD+Hv1qv0ulJVeSc0OSsZL3Nm+o9wVlf/l4leuKmk+iMhI+qxzu/H2MTOonEzQA2Kt9bBieEBi2vyLlqMYoK/M991RoqcMvUK/4JgzCEnYkSNIn0iulQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TLzuUG+cD1ah0+jc3t9NcCQawuhHMyWz8z+IOJLiJo=;
 b=LHkFL9FB0fIrpBc1wp0fQlm/9qxMEzijiEvfViV7f3CCdvT5e2814WpYJYZDG3nS/XC3AG22nJ4hY05MOyCR/8KmPvy/vP3S3YovEDLTRSaRHbuV4AXxRGiU48LuKoVrPz+vubDXiw/dejQh15eIdDdwir9ovb+nxqWAP4iKO7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB0804.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 11:37:28 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 11:37:28 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: LinoSanfilippo@gmx.de,
	p.rosenberger@kunbus.com,
	lukas@wunner.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
Date: Thu,  1 Feb 2024 12:36:45 +0100
Message-ID: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB0804:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c7c2774-3134-4e84-a274-08dc231a2add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0L2CdmkwvP3HSxC50oqgcme1DvJMXWfLdQNue7WGJ2T86oNC5s2Q5H3krHChgdEeYG/NlGbdZgp5BvvLaqTblFWDFGl4ai4mvKnxBoCnz249bnlzuyL3EoeFRdQv3dtrZNnRl4xVnDu8lGXAuOksFULezZFPcxUGoa7wdKkkMdgaViGkoyvJ8rzM5pI8iahjWoDVMCeH9x50tysygEVmBhLacVwCcsDMDEyThaWjNP/Z66Z29aXNwSnzJgvDZN8zmUOHJRwNZQrUKuOjPZ6i62XEiUPdDd6QgNRge8EN7Z7PndmzFUVNvtfkbRP7JZPzLO6Mq9XvEfLt2j0YrwqbrE2S9L5i6DzM3LokX6oWOyoKzA/YS7MhlzsCcsBR1kCakp6NkKP12pZZWudcXCIOo7biMNu2zxSetrET08SIoRuzjnFmL7tsp+oNILRqie5re/wn6q+BMNZQFpIK2xTHrrfXKiOZrbSKo8acdFuMUhmi0DEde6tY5nfmufEvWS9PRraVCqAMxQAZhlH75qaO4Wug/bkipJl/Hlw1blJfbt2TjeVyHoexyQvk0UipPJKETQVyN5u9Bcoq2UECk99b2afI9GKNtIT4PcoqhNRfE6hOk44bxhuWrdeIvlZx7Lf2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(39840400004)(376002)(346002)(230273577357003)(230922051799003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(478600001)(1076003)(6486002)(966005)(41300700001)(86362001)(52116002)(6666004)(6512007)(6506007)(38100700002)(2616005)(316002)(66946007)(66476007)(66556008)(8676002)(8936002)(4326008)(2906002)(36756003)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3mMcsUJl8Z/r1fWnB3iv7riq/rYiCW/ob8aQQWYzL8mV+QpMuJ2Uvuye4VN?=
 =?us-ascii?Q?GXkMtS01etlicLr9wUFfge0irzr7CBzcRkozfBp9f7QJSfp6dld88poTNvmm?=
 =?us-ascii?Q?bFLLOeBvfwwfXo4RQEt4D1wnPkgtndnLwM126pPdFm5It8euKVh8mwr6BL9h?=
 =?us-ascii?Q?FBpbTg3rrCpz/KYLWfhBwLGxHNhvwZ7N7/EdPOuBchClZV4ZjNthqcYXufZx?=
 =?us-ascii?Q?r9fD/3fzAhz64sEk/HCynZ7MNRyf7A9GdVjSE7s8Tu50CX7zXzSMLKnVLHzE?=
 =?us-ascii?Q?h2xybVDl1NlQnYmbHD4HaC5DazsRWdKMoCIalVJJ3JX3WL0bidHibcYnTymZ?=
 =?us-ascii?Q?rwuHNhER4EdwmJVc2gFHRu1R5Htn19h5l30FRpU+pXM4ggYEqu5e/WVp5Cyy?=
 =?us-ascii?Q?xLZzyRNmv/BoUoglQu6Z/RW9c40kjhAFcpV0mkxEM0bEgJfcxl5BiGW/MbEG?=
 =?us-ascii?Q?ZN1HRalHdaaZUXe3O13k537IbV1Ni2bp7S/qJ8Xf9T4j0pf1x+4fvH4QxELI?=
 =?us-ascii?Q?h5sJNd82lseGegpe0FtqO8w57Npf2QwHtSlPX1a9M/5RV2HnNdzwg98x2UkW?=
 =?us-ascii?Q?fI+eubBA3wecpLt5YXetx6ZxrGQ/6jC5KY+/n26UsntwusTghWB/IIQ4l/ZG?=
 =?us-ascii?Q?W9I8kuRJkyo/AsvTCbe0dZSojU8WU02J9iWDH7yO5IIQbJc3K/RPF7WLFgTg?=
 =?us-ascii?Q?Fmu1dCoA3cwtDilVWph57teCOUmhVD6/JFrH8skHHPFtUjaBIHZqyulGguhn?=
 =?us-ascii?Q?pkuADYmO/P79QNSDOMOx0mFszp7HgtdNlGr3fmTsFmCyDwCqPtcfhtlHE7AX?=
 =?us-ascii?Q?XuSx5DwVro+vFyJ7UWsP7T/Urw6vGzvdgDr7Rh2w1DIbW8xnvjLzbT3LOpzE?=
 =?us-ascii?Q?a+rhTZk9+6jqYPIOiY+tss/UgomoBI4dojVhPAvJIUedGEAzbzEwigt7Jmsp?=
 =?us-ascii?Q?PEaIm8AmJcA2S71aJ0W+PMgEyAhwqejRG4MUO2SIHfzuZRpf4Cu3EScZMIeM?=
 =?us-ascii?Q?vPltVO43e88P4qlgi1B1iaxCLKs2Y7xySiIp+NT1bSTc8IcnPkh/q8lwIPcd?=
 =?us-ascii?Q?+qHorTYhmGsVuAFEe/Z/cPgdRFvNYYfbnbvnKJv05jd63pgkSqzF9QYquvSU?=
 =?us-ascii?Q?3lK+VtG6m7qixfzr+SZOQJ9TmoA+vRnH5QVxOwpgpiMJ6VwfV9U296fnDWhm?=
 =?us-ascii?Q?fTZtlUOTHDygLaTI0JXs0gMHJ2dIWKvAP3FDH4x4ADQlWezHFTQ11K7WAXaS?=
 =?us-ascii?Q?TTzR08KpyAzOm/gPEVO8Z9Cvb4NSkTJNm5imo4scNI5VE+8eiU9VPioVFRqe?=
 =?us-ascii?Q?rJNWGi5ledV1BXn8c0fj7CuAU7w8bHfX1I2OrJPoiZ9703Ocxovifk/hUhdA?=
 =?us-ascii?Q?9eVwARXklDC2JE1FaQVxqHzDxNWaoAoUmkcEkV9Hiacx9OB2bNvE26i0+yCl?=
 =?us-ascii?Q?xOq4TWMyHNDXOmD7SwpJf/LBihqPRflVlzzjNDRjr7C5AR4cAFCBGqGHrw+X?=
 =?us-ascii?Q?DF//uLLjw5XeczHW0N4/fAOSlY7OePaa8TABnTNIAGaUNt9AULWbchor+olM?=
 =?us-ascii?Q?aZNKzf3LqNHc6T6QIeN4Moy5amezLQiWdSueOqmWcT6In6JlnqN1yN1F+Zcu?=
 =?us-ascii?Q?a+g/YqPIbTVzyWFmq4744+/iLqkzp6jIHI5UOpKz7l9oBh0oucgA0w/Lkx+1?=
 =?us-ascii?Q?P5CNOQ=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c7c2774-3134-4e84-a274-08dc231a2add
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 11:37:27.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSvuP6o7mbP9rDAZjVqn24aPHLTavy2UitQUuTi6AWKlvmPE/L22T+h6AwEkEarcfqmxoEG8FCiBgG0fYD5PRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0804

SWYgaW50ZXJydXB0cyBhcmUgbm90IGFjdGl2YXRlZCB0aGUgd29yayBzdHJ1Y3QgJ2ZyZWVfaXJx
X3dvcmsnIGlzIG5vdAppbml0aWFsaXplZC4gVGhpcyByZXN1bHRzIGluIGEgd2FybmluZyBzcGxh
dCBhdCBtb2R1bGUgc2h1dGRvd24uCgpGaXggdGhpcyBieSBhbHdheXMgaW5pdGlhbGl6aW5nIHRo
ZSB3b3JrIHJlZ2FyZGxlc3Mgb2Ygd2hldGhlciBpbnRlcnJ1cHRzCmFyZSBhY3RpdmF0ZWQgb3Ig
bm90LgoKY2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDQ4MWMyZDE0NjI3ZCAoInRw
bSx0cG1fdGlzOiBEaXNhYmxlIGludGVycnVwdHMgYWZ0ZXIgMTAwMCB1bmhhbmRsZWQgSVJRcyIp
ClJlcG9ydGVkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPgpDbG9zZXM6
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DWDMyUkZPTUpVUTAuM1I0WUNMOU1EQ0I5NkBr
ZXJuZWwub3JnLwpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0Br
dW5idXMuY29tPgotLS0KIGRyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgfCAzICstLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX3Rpc19jb3JlLmMgYi9kcml2ZXJzL2NoYXIvdHBtL3Rw
bV90aXNfY29yZS5jCmluZGV4IDFiMzUwNDEyZDhhNi4uNjRjODc1NjU3Njg3IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2NoYXIvdHBtL3RwbV90aXNfY29yZS5jCisrKyBiL2RyaXZlcnMvY2hhci90cG0v
dHBtX3Rpc19jb3JlLmMKQEAgLTkxOSw4ICs5MTksNiBAQCBzdGF0aWMgaW50IHRwbV90aXNfcHJv
YmVfaXJxX3NpbmdsZShzdHJ1Y3QgdHBtX2NoaXAgKmNoaXAsIHUzMiBpbnRtYXNrLAogCWludCBy
YzsKIAl1MzIgaW50X3N0YXR1czsKIAotCUlOSVRfV09SSygmcHJpdi0+ZnJlZV9pcnFfd29yaywg
dHBtX3Rpc19mcmVlX2lycV9mdW5jKTsKLQogCXJjID0gZGV2bV9yZXF1ZXN0X3RocmVhZGVkX2ly
cShjaGlwLT5kZXYucGFyZW50LCBpcnEsIE5VTEwsCiAJCQkJICAgICAgIHRpc19pbnRfaGFuZGxl
ciwgSVJRRl9PTkVTSE9UIHwgZmxhZ3MsCiAJCQkJICAgICAgIGRldl9uYW1lKCZjaGlwLT5kZXYp
LCBjaGlwKTsKQEAgLTExMzIsNiArMTEzMCw3IEBAIGludCB0cG1fdGlzX2NvcmVfaW5pdChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB0cG1fdGlzX2RhdGEgKnByaXYsIGludCBpcnEsCiAJcHJp
di0+cGh5X29wcyA9IHBoeV9vcHM7CiAJcHJpdi0+bG9jYWxpdHlfY291bnQgPSAwOwogCW11dGV4
X2luaXQoJnByaXYtPmxvY2FsaXR5X2NvdW50X211dGV4KTsKKwlJTklUX1dPUksoJnByaXYtPmZy
ZWVfaXJxX3dvcmssIHRwbV90aXNfZnJlZV9pcnFfZnVuYyk7CiAKIAlkZXZfc2V0X2RydmRhdGEo
JmNoaXAtPmRldiwgcHJpdik7CiAKCmJhc2UtY29tbWl0OiA0MWJjY2M5OGZiNzkzMWQ2M2QwM2Yz
MjZhNzQ2YWM0ZDQyOWMxZGQzCi0tIAoyLjQzLjAKCg==

