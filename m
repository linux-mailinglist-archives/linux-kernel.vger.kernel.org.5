Return-Path: <linux-kernel+bounces-69447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC52858921
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 121442829D2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70524148305;
	Fri, 16 Feb 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="s3Yu7YQL"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2139.outbound.protection.outlook.com [40.107.13.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2039856;
	Fri, 16 Feb 2024 22:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123681; cv=fail; b=ukIYj2OhaLLyPq3tWsPm0/KuMRIehqPALwbY0dOrw9xP3xq5XfFub+lc/8MyK5JXLo9LqSiMdFKGfFc+pHXtdphm3/B3F4Pcwrry0YWR8sm2A19fdInw94VTmo2+eCvBsj5ic7omWH/BF3rjb+IfA4bwOIkncgH7Rm20I2jpTlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123681; c=relaxed/simple;
	bh=njOEwybEhsRFcXwQug2TFE1cmWhigSCzw8w+KGHPsX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhB8lB6A8IooQ3rumZRvGp+Z5QWYGccsHNYEgA1JF5bK2vPn2gveVyOS657UhTAvAmTpioIswtO2ohpYnqHVGuVHi2YpRU2s5gLhkT76ittT8cUosutE1EyXVEXNvxYJh7m9Aj2JN+rmXIUlBgnx3V6W0WD3r8VuE5bThScZtyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=s3Yu7YQL; arc=fail smtp.client-ip=40.107.13.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVqcw2feXeFVQqVBNAqEIi7H0s/XMiDRp0b4OgETSpEwkH1t2NKZEMEjK3inYyuJN+pOqRH3BbGVbtduUk3SnidQMP62OI6SB1FS4fzzUvjGZ7pKTlgfAN0EBQRMywRl9zYT0A11mHuKjWvHK15d9qaPQw1KsKAIL2lUihlW9EKcul0mcnlnA8dhdiE78WTZn+BmDLW62DOTXD4bDRrM2am6zLBFXpG4HeXM4bRgytGtSoIsSZZY9pwYc7uit2vhbnXw7OgeRug37uyHGDPB/1rIrmPlluudzZGwuqwfk/05Kuw7Ij03joPCGw3TF81gLWKp5kfahKXe3LpLFlshWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njOEwybEhsRFcXwQug2TFE1cmWhigSCzw8w+KGHPsX0=;
 b=nmFDiYv+55hZnfjLqQRhs5YEk0hXOiaqLZBCtAOqGQQE6waDkjaZ2OKgBBjALu1uFwj6ptQ56wjPb28NvRXHMAvQxsy1N0TVANwLcE/svgEpuqrT87Y4L+LSRsFcW8G1a31276nV4QA5e+DpfrepOy3MrPnFKg18Msq77QKiF+zfHLdWMAfOGi2dJP+JItuUNXek9FLBt42JGz4Wm5v9u4huONbRcMEBHqaBTeB+EcbHOzr1Ju2Qoq6u1SXcYO9fyhbbn0WdLVDdN/JPtwLIy9LsorkPyOU8uGLQO+Wc7zxYjsY+tmoN5TWrJ/Be7fDaP+MTEfOSLZtYWt+P8fEW1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njOEwybEhsRFcXwQug2TFE1cmWhigSCzw8w+KGHPsX0=;
 b=s3Yu7YQLdo0UOC/hdZ4buZzM2yeaY9A36WFvN5zq0yhNgx7QrE0Lz/wvk7FfrohTEhmo9VLiIc2zEmjQD+aDjd93kCszuSMLwTuDx/857mbbaX4ckCrO8j5ybBHrwYXBgSHh0OB1nG4d6p6fy28x8Hz4lKO0TTLt9/C8oSMeWfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB1872.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:1c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:47:55 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::83c6:a213:7935:ae6f%4]) with mapi id 15.20.7292.026; Fri, 16 Feb 2024
 22:47:55 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] serial: amba-pl011: Fix DMA transmission in RS485 mode
Date: Fri, 16 Feb 2024 23:47:08 +0100
Message-ID: <20240216224709.9928-2-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216224709.9928-1-l.sanfilippo@kunbus.com>
References: <20240216224709.9928-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB1872:EE_
X-MS-Office365-Filtering-Correlation-Id: d5580570-c10a-48c0-1543-08dc2f4150b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N2QjMyT1m+L3om0TwpqKkER+bEZlW6Yk5npVioKtZQUiKecxUiwYUXD4Yq9mmm/TGvXMxhHqWyILmGkOVHdCZDnzz0Ao4/idNY/V1arAddWS9ibrkXNn0XADhgJAJo4Nhsl9iullTCNMJ7EP0qqxubvvKATf9wV7qrjC0HWPYashn840v8HuQFIY6BKxXzcjn2iOFD7G6maNdSfxs4jOSQ/gkIstih0xe7nryZmU2qlJJLcZxUUktlJtLzYOLg8hvSRjz4HZTfxMxq/SP9LoapSPcekN94DgyZJDkFqxGXStB/4m4yNmsbs+O84bqt6KHIk64Ctbht+hnT1DQTCfPzlDdWWtb3dW7K62w2vpwr1U2LTumtdGnJlGQkSeUdO3+rpAzPgW865boICiqyzMWWQiYW1xqT8X3NajOrsYVSURp6kSsCi/WuZzmcOeQ5wIX1rjKaQJWXuDirM74Gy73RCynuovpOciqWhvHsUENC6Bw+GC4X8pE5RWqBKczSq1AXqfLA/Bkyih1Zm7xvusQcCyEbFESsEkaAiOVMCMCx3Z99X+vll9suR58Fn1mDwk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(396003)(39840400004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(66946007)(8936002)(66556008)(4326008)(66476007)(8676002)(7416002)(5660300002)(1076003)(2616005)(41300700001)(83380400001)(36756003)(316002)(6666004)(478600001)(6506007)(6486002)(52116002)(86362001)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r3OlpzHsSVtBEuUd6rJPM0fQp+jTljtJWboPa6dQMqg007KfoGlihax/aOPF?=
 =?us-ascii?Q?Uqc7MJc0fOk5HPzceFvQaxF22uxNiGFxgLk6fGOQVfmpZzsmarXiexDxJywq?=
 =?us-ascii?Q?NcyJtwIgjvBDYrtxCG2wOyE0VOmTwAhP5HsN4lXRgwzx9ZapTXV72cL2uk/8?=
 =?us-ascii?Q?RBIf9bjIMeLciFKvLReYu49XmrlsgalerLpxgRwwnZ6C6g8tTTf76365zKRc?=
 =?us-ascii?Q?MchTU4NAzRAcqlsKV8mL1iueVX6hIiFZkqcHDQBjIs7feYJNeQLhkLIyRCFf?=
 =?us-ascii?Q?wWTMziM2zw2IpAoYBnSd/037Q9Js+Z0lMK/VxLSc3bRcT3r4Omok4zishUE0?=
 =?us-ascii?Q?6z2+r/Zgvs8ATYmnWO6iJhO0t94nyYndWnw8nSsZLPxpCvZMqvhjj53E1Cuh?=
 =?us-ascii?Q?pHquVpei3AGyh6yWteqowV5UVOOYZafZGh1wKtp0RtZXdptxCbkOln13lCKW?=
 =?us-ascii?Q?6sAFC2v/TakMUjGlPcjvXK5xCeaVpO1yg4cfpxF6dv4wFTVY+j/VazhDSMux?=
 =?us-ascii?Q?mDRsnAQFYD3FU1mK7mT32EZt+s6LcUbNZzUmklcS2ueeupUBUFYVP0b3roTq?=
 =?us-ascii?Q?Hd5UhPHYV1fG8CCZhO+2ZHwG8EuXmMaQBW9aDmbGRjNDLbhGorHTQPl26LuG?=
 =?us-ascii?Q?eRWnFs416zF/SHaEJQR9WPlKAg42V7rXUycI/e237p0mVjBuLPzALsP95ilv?=
 =?us-ascii?Q?iZbfIeLugiG1QNr4dfZGeP5/wAv1dXYImXoPaAbeRLemuWl9WJMPkVXU+1I9?=
 =?us-ascii?Q?pw8URVy3rZUUSXLBG8AAROrR0sge+lOWSJ/5+AqLlvXGNx4a61s5XErXDrQp?=
 =?us-ascii?Q?3L9GXH2xfufFtDUaDj9YOARKLE0OSzkoNzC3wLYEkDAP6MtH3hpnGiBGoIvo?=
 =?us-ascii?Q?WCgTI3MQryYCKbWKGgQANLZ9Hi0yi+A/515JINVqmxrQ+kD6us9USDJBRDu2?=
 =?us-ascii?Q?y30vqfkkBInNk1q2sFUoEL5i0+GCKisZLNCO7xQHhiocRM9BzXWkMexblv5c?=
 =?us-ascii?Q?gVwIREj36yH1kN6a5vmL/ftcxFOyKu2yNm0dK7z6RFWRgQpbeHiX2QOH90t2?=
 =?us-ascii?Q?xc6n+wvo5GHvSDHpaOcgkJWuiTUQGuOC1k57Ls3c3zjsfTnI6QZcy2bwN2ih?=
 =?us-ascii?Q?qS9K9HswKD8/mEfgb783Egjm+B+AG7nzAWXo5ZHK7me+SD7CmNaagiwtfAhV?=
 =?us-ascii?Q?7YcN0kq8WkhSAqnlAK6gAhtGgWOfa3S5eGxbxyONEa5QXo+QJE9ixUepfnnX?=
 =?us-ascii?Q?deklji2QYTaCCmCF4Ia3OuVaiKchOVgavpGKjWNfX6F31AGFc6+IhdPRk44h?=
 =?us-ascii?Q?8TvCALjtZHGGHPhCvB414/EwQ5roItfs1AT4gjNly6G/peqcY/MaC68pZdY4?=
 =?us-ascii?Q?LLoxCRIDkfkoGo3j1BkaVepCsu7Aoe6/9Fc6azbPT0JipazNQFtne+6NIMlk?=
 =?us-ascii?Q?0IN/MX7/2Ip/2kEm7ZfksZcDawv09eOr3Ubiyh3dwx5ewoI5s6ni8bj+p4nF?=
 =?us-ascii?Q?/h38wsBKPYnUP6XaSwZxFOoNxedr1SWOPRM18t4L53+n+gIpyYgNBPgg3/jk?=
 =?us-ascii?Q?r8+rCFrZ/etA0TQeRzL/Kx8UFWXHEGUSWhXq4+B9NQR0ZSvMTz0TLHYYCSHj?=
 =?us-ascii?Q?OXzxRM3khcz0NRL71DdehM6QhxeO9D4da34VHn/e6DbILvdHDkUmhw7pLifD?=
 =?us-ascii?Q?oeCwlQ=3D=3D?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5580570-c10a-48c0-1543-08dc2f4150b1
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 22:47:55.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaciCdylX8l3iwmgfbsTd03utZ8QYMRf5Cn1xMug/AHvbyeQSz6AuSPNNH8Yx0aSnfToW5AoVpMGbwUlwJNbBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1872

V2hlbiBETUEgaXMgdXNlZCBpbiBSUzQ4NSBtb2RlIG1ha2Ugc3VyZSB0aGF0IHRoZSBVQVJUcyB0
eCBzZWN0aW9uIGlzCmVuYWJsZWQgYmVmb3JlIHRoZSBETUEgYnVmZmVycyBhcmUgcXVldWVkIGZv
ciB0cmFuc21pc3Npb24uCgpDYzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+CkZpeGVzOiA4ZDQ3
OTIzNzcyN2MgKCJzZXJpYWw6IGFtYmEtcGwwMTE6IGFkZCBSUzQ4NSBzdXBwb3J0IikKU2lnbmVk
LW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBk
cml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jIHwgNjAgKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYyBiL2Ry
aXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKaW5kZXggZmNjZWMxNjk4YTU0Li5jZjJjODkw
YTU2MGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKKysrIGIv
ZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYwpAQCAtMTMzOSwxMSArMTMzOSw0MSBAQCBz
dGF0aWMgdm9pZCBwbDAxMV9zdGFydF90eF9waW8oc3RydWN0IHVhcnRfYW1iYV9wb3J0ICp1YXAp
CiAJfQogfQogCitzdGF0aWMgdm9pZCBwbDAxMV9yczQ4NV90eF9zdGFydChzdHJ1Y3QgdWFydF9h
bWJhX3BvcnQgKnVhcCkKK3sKKwlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0ID0gJnVhcC0+cG9ydDsK
Kwl1MzIgY3I7CisKKwkvKiBFbmFibGUgdHJhbnNtaXR0ZXIgKi8KKwljciA9IHBsMDExX3JlYWQo
dWFwLCBSRUdfQ1IpOworCWNyIHw9IFVBUlQwMTFfQ1JfVFhFOworCisJLyogRGlzYWJsZSByZWNl
aXZlciBpZiBoYWxmLWR1cGxleCAqLworCWlmICghKHBvcnQtPnJzNDg1LmZsYWdzICYgU0VSX1JT
NDg1X1JYX0RVUklOR19UWCkpCisJCWNyICY9IH5VQVJUMDExX0NSX1JYRTsKKworCWlmIChwb3J0
LT5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05fU0VORCkKKwkJY3IgJj0gflVBUlQwMTFf
Q1JfUlRTOworCWVsc2UKKwkJY3IgfD0gVUFSVDAxMV9DUl9SVFM7CisKKwlwbDAxMV93cml0ZShj
ciwgdWFwLCBSRUdfQ1IpOworCisJaWYgKHBvcnQtPnJzNDg1LmRlbGF5X3J0c19iZWZvcmVfc2Vu
ZCkKKwkJbWRlbGF5KHBvcnQtPnJzNDg1LmRlbGF5X3J0c19iZWZvcmVfc2VuZCk7CisKKwl1YXAt
PnJzNDg1X3R4X3N0YXJ0ZWQgPSB0cnVlOworfQorCiBzdGF0aWMgdm9pZCBwbDAxMV9zdGFydF90
eChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KQogewogCXN0cnVjdCB1YXJ0X2FtYmFfcG9ydCAqdWFw
ID0KIAkgICAgY29udGFpbmVyX29mKHBvcnQsIHN0cnVjdCB1YXJ0X2FtYmFfcG9ydCwgcG9ydCk7
CiAKKwlpZiAoKHVhcC0+cG9ydC5yczQ4NS5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSAmJgor
CSAgICAhdWFwLT5yczQ4NV90eF9zdGFydGVkKQorCQlwbDAxMV9yczQ4NV90eF9zdGFydCh1YXAp
OworCiAJaWYgKCFwbDAxMV9kbWFfdHhfc3RhcnQodWFwKSkKIAkJcGwwMTFfc3RhcnRfdHhfcGlv
KHVhcCk7CiB9CkBAIC0xNDI0LDQyICsxNDU0LDEyIEBAIHN0YXRpYyBib29sIHBsMDExX3R4X2No
YXIoc3RydWN0IHVhcnRfYW1iYV9wb3J0ICp1YXAsIHVuc2lnbmVkIGNoYXIgYywKIAlyZXR1cm4g
dHJ1ZTsKIH0KIAotc3RhdGljIHZvaWQgcGwwMTFfcnM0ODVfdHhfc3RhcnQoc3RydWN0IHVhcnRf
YW1iYV9wb3J0ICp1YXApCi17Ci0Jc3RydWN0IHVhcnRfcG9ydCAqcG9ydCA9ICZ1YXAtPnBvcnQ7
Ci0JdTMyIGNyOwotCi0JLyogRW5hYmxlIHRyYW5zbWl0dGVyICovCi0JY3IgPSBwbDAxMV9yZWFk
KHVhcCwgUkVHX0NSKTsKLQljciB8PSBVQVJUMDExX0NSX1RYRTsKLQotCS8qIERpc2FibGUgcmVj
ZWl2ZXIgaWYgaGFsZi1kdXBsZXggKi8KLQlpZiAoIShwb3J0LT5yczQ4NS5mbGFncyAmIFNFUl9S
UzQ4NV9SWF9EVVJJTkdfVFgpKQotCQljciAmPSB+VUFSVDAxMV9DUl9SWEU7Ci0KLQlpZiAocG9y
dC0+cnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpCi0JCWNyICY9IH5VQVJUMDEx
X0NSX1JUUzsKLQllbHNlCi0JCWNyIHw9IFVBUlQwMTFfQ1JfUlRTOwotCi0JcGwwMTFfd3JpdGUo
Y3IsIHVhcCwgUkVHX0NSKTsKLQotCWlmIChwb3J0LT5yczQ4NS5kZWxheV9ydHNfYmVmb3JlX3Nl
bmQpCi0JCW1kZWxheShwb3J0LT5yczQ4NS5kZWxheV9ydHNfYmVmb3JlX3NlbmQpOwotCi0JdWFw
LT5yczQ4NV90eF9zdGFydGVkID0gdHJ1ZTsKLX0KLQogLyogUmV0dXJucyB0cnVlIGlmIHR4IGlu
dGVycnVwdHMgaGF2ZSB0byBiZSAoa2VwdCkgZW5hYmxlZCAgKi8KIHN0YXRpYyBib29sIHBsMDEx
X3R4X2NoYXJzKHN0cnVjdCB1YXJ0X2FtYmFfcG9ydCAqdWFwLCBib29sIGZyb21faXJxKQogewog
CXN0cnVjdCBjaXJjX2J1ZiAqeG1pdCA9ICZ1YXAtPnBvcnQuc3RhdGUtPnhtaXQ7CiAJaW50IGNv
dW50ID0gdWFwLT5maWZvc2l6ZSA+PiAxOwogCi0JaWYgKCh1YXAtPnBvcnQucnM0ODUuZmxhZ3Mg
JiBTRVJfUlM0ODVfRU5BQkxFRCkgJiYKLQkgICAgIXVhcC0+cnM0ODVfdHhfc3RhcnRlZCkKLQkJ
cGwwMTFfcnM0ODVfdHhfc3RhcnQodWFwKTsKLQogCWlmICh1YXAtPnBvcnQueF9jaGFyKSB7CiAJ
CWlmICghcGwwMTFfdHhfY2hhcih1YXAsIHVhcC0+cG9ydC54X2NoYXIsIGZyb21faXJxKSkKIAkJ
CXJldHVybiB0cnVlOwotLSAKMi40My4wCgo=

