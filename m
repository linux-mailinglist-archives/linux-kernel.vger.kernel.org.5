Return-Path: <linux-kernel+bounces-134109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2232989ADB6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B3E281B82
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E34E6AC2;
	Sun,  7 Apr 2024 00:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="RQIcXP2G"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2133.outbound.protection.outlook.com [40.107.7.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06D1103;
	Sun,  7 Apr 2024 00:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712449652; cv=fail; b=evg+a0dI7p4XpO1MbttfK1Uqlvp7w5TS2IWozbEdI7Qvc0ZekUBO2eHB7/WxbVMwIyu9nPUDPptCfnBaqnzM9RMuqZSh/YlB9NWzl2RjO+EoSD2EdPHn31w2MnX43czuzhb1mOsPVRW5+OBrF4ve2dvy8aZP9rKLeCjsMD3LXP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712449652; c=relaxed/simple;
	bh=jsehjd0bixA/6NCwTdCkXfv+Ox++nQrTZnyse0jMm2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nuEDoeTT0P5eNphdaCEzcrzEXy9PZeLPzKLFi83Kem9x0DG20qV5jRlOsJTbh0wOntKVzn6fNW/YveH057SDmJ2bsbTbH1O5ZqvP9JJo5Hdf4bu/LMPlcoEAKlDhcuYOdK7foXiYF4xgGD4rsCHDMYghOfQT9PlbsBfVHEbQbAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=RQIcXP2G; arc=fail smtp.client-ip=40.107.7.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze4ccIIQighsE1FJmiZz/nEDHOva8Z7uLWKVG0NUVh68uggVhmViqZkDBNEM6HGtdwxfxdLgc78YMRIOJanDyLpsiaEUlIihMOE89pEjjhdQMdV0nMQLU6dHgBtsuyDe6rzqBgY2Y/dv/aP45ANEMf10WPVQUEC0ssRY/q8YI9cRkNi0ZOQMzE0zKvuxT+vQJ+15EWUlwnUW9m9Zm8QHLOZh5scs/jKJcPCsS5xezzFVrI+dfwTLPlsO3N4wG9teEQnWC3ddVIxh577XaeQAEqwLfXd8S207vdFNDS8e3mzFaSZfuReCR8b3iXrS4aGW4uylc1vq+aujyQMMcGTvVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsehjd0bixA/6NCwTdCkXfv+Ox++nQrTZnyse0jMm2o=;
 b=S93xtDrbbYkvg8oxsqDDsn5PJPjTJbZ+XKlf3hsjKpRC9++F6oqIJHlWF2nSkGMrzP5Pn7JggxjeKilN7FB6dKByV90jPtf2oV/AsDXDzvQl+XGqAjWrSxFG8VbSTD1QeRe/vD+kh6h31L6tq+FpNhyvwWQhunDAb6rx0HTvS6BpIy72LjSLAHLL4qfnpQQj2Snqg6Qj+VglPcrbi1X4pTkn4uT223GSHQ+oD0kFpeJx24Q2zeD9qM1lTEZ415KIAklhb7suihMtsAaS2jzOdRiVWCNurL/Pv1K1Pa7tJQXelcTZhwqFBWcqhe55tx0L7zxBBZGIHAZC0v4/iQYSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsehjd0bixA/6NCwTdCkXfv+Ox++nQrTZnyse0jMm2o=;
 b=RQIcXP2GXFQl6oZAsntBJrt41cnGEy8P7XmQjZkKsaUUyaD1HJzIiIhleGn8QKXnSIZkwLWVIy7ed7GVUdoUs7iawFCNBON1EPjv9Qze6fHDSa/bd2u4DbWBitQxgmM6kINLzxL1FaoYnT+xYkATXKVshTuSzkwqtFD6Y8cMfsQ=
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1339.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 00:27:23 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 00:27:23 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 2/4] serial: amba-pl011: move variable into CONFIG_DMA_ENGINE conditional
Date: Sun,  7 Apr 2024 02:27:07 +0200
Message-ID: <20240407002709.16224-3-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
References: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1339:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WHSABjwPordocPx9k1xwmKxGK0Nl872a9RLe5NhgshfaL5oGtuwAy5N2xnXcbu0NI6BuN7a+Zf9TMCDfyRHwYgH7PH1WdxS7Yw4AQ5BMq6cUGHQTLtBeDX0Xlr2BrGcZZgyET1mMfx/YgiK3ozQQ5MppTwmgMUJZF4JHf4JpzcvD6dl7MRQA2h/pBiaSSAyKp9TEDBdNvkBObvizeVerD7FuDQ5G6GyrJOcOUqeJPkTcJg9DGY1nkj1mU9C1dqwAXkkdvKRavmZMytlxxtaN/JLU9uuL9NEs7t45BH2qfB27x5hSgoEi9h3BbgIQJq1Bqdw9xxxtQ289Dqd2Ei53zpf2N6ljakaW8fKSsGx7o9MVlWIzAopCscG2dWo1CS97gsXIPbwgb3Wp3scz9K0y3zY9JbUsIHgKI/TUFgyQLJ0Q/9z0wUTUds2B0bS7BUXSlrC97IHpB9YJu51xbLysjep0Ju/3dzwRMck34rF3+GxybQo7pJ1le4FmgKSE0dUi6H5pEtVOi9ufzE/WMaiec2tN8U+CG2MUcMNgqrN0LHlj8C407C602PBQzk1w++8nhjAQeSmUNrpBlaD5bv1JiWUrrSwOgZhGTIEnU2GhKdM+D3YtfMKbn9+AINw04+e0/tnAUPHm0TlaTqLTa4aF1G5qIGON326DkkKJOnK7FRo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MD+mV0KTvGG1hhhOs7z2YWK/r1hSyntyDZqH7sMJzkbaWnYkv42CJRSAbvxA?=
 =?us-ascii?Q?UjkAiLMz4wkCS9WZW6ZjdhdNvl9MGCzDDDOPlMrC+KWe1IO5hHcK0+AZYiAc?=
 =?us-ascii?Q?52ZSXQNjFxnLkj9m05K73TE27hwtcr9pXyLzsv93yweR8cgW1nbmaJB31Oqe?=
 =?us-ascii?Q?Lgyt6EB1PvrEv9uhpuYpB159o3NaBsm2mCQfQuJYd7bnT+oZBo61nk5yYpfB?=
 =?us-ascii?Q?ofSX4oylF5MYVxkq208R+XRt3F0SJHNBevpUZbK/IaYRHXaAEVLyIKqHPcPd?=
 =?us-ascii?Q?XUdY8dYkgFUXsNK5PD2BsQWDpGOYVeoPVUFzfxEWp8Z9tNOkGEgZOri6jQ+j?=
 =?us-ascii?Q?E3aab6zGgOLhFeUFcg6ljzBpEx9lS6bhQhfOl2dys3La0N178CDmtvuM2FOb?=
 =?us-ascii?Q?HvyI9LKL1bJzBfqdvGRgUx9ek/AiUDlXtZhBp+o6RJNZAmK3YuxuVOYIlN7f?=
 =?us-ascii?Q?MiPpCbJkKSwQ7IFTED7BXUPeBI+RPn6p1lXj574oOAinXZNpArlkCkQoJBp5?=
 =?us-ascii?Q?49eFdwaBmip/f7STrLa6Pj3iw8FkwMuLbmI/dbYNwaHHdZrm9AuuGqkufTeu?=
 =?us-ascii?Q?vdn5UFePJ0rN2p/Vwng1eS0JdBIj4h4eD9AUrhK+4g2272K4voy7ibfROIFA?=
 =?us-ascii?Q?Ck2bIR7VI7xcPP+EU6JP2rMB4RT+l8UhVSS0IYfV9sxX5qp2FmS9uuh58AmT?=
 =?us-ascii?Q?lHU3l8GvE4Tbyen/7x6tyzU1d47SunRROiBCllMhuhfIsWiZYe0Sxh3giJBY?=
 =?us-ascii?Q?o6tPzLqv6VsxD/EbMrQKzinc87VehZJP87gnrm5zV5fT8SJGmqXt9Umg1S2e?=
 =?us-ascii?Q?cXGautON4R2O3dwklKvzj1DOOoT7uQvtx1SqjvvgnuL0wO4jnHvhyLR9A8rl?=
 =?us-ascii?Q?q8X8OQrqec5164mb+i3BQdllTwTbthv6NRqhV6UfMigJ363ffqsyEBTTbzul?=
 =?us-ascii?Q?jfUfOF42xWC7egNfoS5HDRVWMU9j5JnYh8EQXRGtmmLpWbAgMlkNCw3O5/MC?=
 =?us-ascii?Q?Ti9ntp9O/vEFSD77bh+yrHufD84X+mE2Ya9vz4ybqYjGVKG8DUS6ogJIa9s3?=
 =?us-ascii?Q?dlMNeNmQSbvjmnrrGzGP1iw9SNT3W0NDHwQ8p3zjBWj0SWXUqluTA3mmxJb8?=
 =?us-ascii?Q?qChj+XaMsW6Wh1hJP6KWx3ejtFAxARDFuuuScRxjV4Wg2Q00HCZoY+LjtoS1?=
 =?us-ascii?Q?T/1Wkvo/VNaJZwLHSX3km3f4ef+kdBhHDG8xa1Nioej/VH/3OItdvIgp+ezf?=
 =?us-ascii?Q?7DtsZy9KQhQOXgqVObTDtCJfYJGj27fG5NgMTdnKh6emSZYDxKZbEClFl6hi?=
 =?us-ascii?Q?wq4An73KzRSv4I3rS2/xhrrukcnWqd2cqhra7rFgNK568VVmmo1XBGJ4Hebo?=
 =?us-ascii?Q?i2p4lhbuRWMYtSSoUdjG3HVYoozrDSfrf4uQeovtPqTfhyPysa+P6/boHVKd?=
 =?us-ascii?Q?OOqvPcRClhozSze66VmXPwBfZP9pdCjrUJemE5hYHZRN3rz/KvGqOyuFu6bG?=
 =?us-ascii?Q?aUFAHz7u/SV77X1RMHnKQsaLQB+AlqkgL+FAcCf2tVJ1rUBKXmGF9v93ZTsJ?=
 =?us-ascii?Q?A0Ot3TN4x7JTNQU341wmjg/o4bt2TIokm60t+0dbqa1tXQ3ArFJEJpVWvEQu?=
 =?us-ascii?Q?qIVNplZmG/Su6TTDQwFCiYIK/CHu2odIrv2PTeWE6FpN?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57edad2-4d3e-4a54-f600-08dc56997e48
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 00:27:22.9576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rq0iOUV2G96prJPy4cpAUhhJ8X0MpBTrSvMBiQj9C53TgaabP/J8vnfJx97Ue8tYkcTe/Uim1LM5xuM6mdxAMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1339

VmFyaWFibGUgZG1hY3IgaXMgb25seSB1c2VkIGlmIERNQSBpcyBlbmFibGVkLCBzbyBtb3ZlIGl0
IGludG8gdGhlCkNPTkZJR19ETUFfRU5HSU5FIGNvbmRpdGlvbmFsLgoKU2lnbmVkLW9mZi1ieTog
TGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0
eS9zZXJpYWwvYW1iYS1wbDAxMS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEt
cGwwMTEuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMKaW5kZXggM2QyZGFjMGVi
Y2RlLi4zNDkwMDVlNmFiOWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBs
MDExLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGwwMTEuYwpAQCAtMjU2LDcgKzI1
Niw2IEBAIHN0cnVjdCB1YXJ0X2FtYmFfcG9ydCB7CiAJY29uc3QgdTE2CQkqcmVnX29mZnNldDsK
IAlzdHJ1Y3QgY2xrCQkqY2xrOwogCWNvbnN0IHN0cnVjdCB2ZW5kb3JfZGF0YSAqdmVuZG9yOwot
CXVuc2lnbmVkIGludAkJZG1hY3I7CQkvKiBkbWEgY29udHJvbCByZWcgKi8KIAl1bnNpZ25lZCBp
bnQJCWltOwkJLyogaW50ZXJydXB0IG1hc2sgKi8KIAl1bnNpZ25lZCBpbnQJCW9sZF9zdGF0dXM7
CiAJdW5zaWduZWQgaW50CQlmaWZvc2l6ZTsJLyogdmVuZG9yLXNwZWNpZmljICovCkBAIC0yNjYs
NiArMjY1LDcgQEAgc3RydWN0IHVhcnRfYW1iYV9wb3J0IHsKIAl1bnNpZ25lZCBpbnQJCXJzNDg1
X3R4X2RyYWluX2ludGVydmFsOyAvKiB1c2VjcyAqLwogI2lmZGVmIENPTkZJR19ETUFfRU5HSU5F
CiAJLyogRE1BIHN0dWZmICovCisJdW5zaWduZWQgaW50CQlkbWFjcjsJCS8qIGRtYSBjb250cm9s
IHJlZyAqLwogCWJvb2wJCQl1c2luZ190eF9kbWE7CiAJYm9vbAkJCXVzaW5nX3J4X2RtYTsKIAlz
dHJ1Y3QgcGwwMTFfZG1hcnhfZGF0YSBkbWFyeDsKLS0gCjIuNDMuMgoK

