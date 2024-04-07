Return-Path: <linux-kernel+bounces-134107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C748689ADB2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A16B281B78
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB4D7FE;
	Sun,  7 Apr 2024 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="v6KEx3rb"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2133.outbound.protection.outlook.com [40.107.7.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2033368;
	Sun,  7 Apr 2024 00:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712449648; cv=fail; b=mhuHETisRPRKdZrbYdHJoOBKogzUUiHdXE1AeJOXqRUtnP+nYkxgO0e1/jX6sblybzrQJe56gUhFEDoT2uKpYJKRmWZ+QXbDIUXbZs6aiwZN2TrFehbTIOKeINapuRmo3qAngKp5w/Gvrxv/kCaSuuJMY/YU8P2hNMU9R7xGgbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712449648; c=relaxed/simple;
	bh=RKvtzzlZEOW8ymagH8uNpifaZzVGkKeHakrm+XcLlwo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U2vtBmDS7Y7VPILUxCZR5S5e4vpa+hj5to6X31hJpiiWsd7RBbA7hmJ0SdkWZzQtoVtfZNN9NL/QxLc/mBtvJxwr4/4o5XSi0GaaSSO2G4tBPmd9EApnKRvNBqg20WvWnOcTdzmxEsxJNBXLMDmaNt7NPxH+kgA+wwNbfYf6lYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=v6KEx3rb; arc=fail smtp.client-ip=40.107.7.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1kitOvnxSzeOc34xwhKJ+Rl1Nipr8iGESCLc7NJj27mrIVy9ma6tthWUPMOZb5gAbl6Yxe2BHo6JMfmO6vkooZdTEqzMhIicvBU6sj35qJ+2ZuiqaghG/9bi3D+xV4QtwyQ9jGzPCX5hU4jwGIlqHo76iiUiQrpIgwXft66vgxAhVTftE+DhgWkkqQlSVmFCWHVwJfbXlBhVR3uq/0eq+Lx/3ch3KHP3dYLnS/4viHo4O7f2/Gc7di/c4G14/PEFDIzl4U06y9Df7Mzs4R1pEPfxwWHPIzwDy4Y/0Ht3l84boneMRHHPy/v+pEjslOsskB7+Vjs6rRkVnpmc+pD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKvtzzlZEOW8ymagH8uNpifaZzVGkKeHakrm+XcLlwo=;
 b=CZyFq/RzMHNCDdY5rKgE6zkm1gUyExwEdBM7Nvgw99gBl2irhAD518gXrxxrap38g3LjaHM8mVWYlGKAiJowNuxTPckROGKOGrX2ykvQOI5EYHqjY3rWsr9JNtAYwz5RJBnROVVAr2XGFwEkBJXohVsCylnJiSX514wTV3AnYVUOFk2GZLEoao12+OLgxolZcJVCDG9EQgeMJz2zxeq/vfSIDwmDjKM15P84GY9+0LPBwZL4h79Ek8Vl2azxcvmf01aE/P9thwjsK7lL4YgWdumbW6gdGER0h25wIVFSdbUrV1FEwXvBhHa8oAzUUpIeoAcBnJytFT4GTERCcF9Rig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKvtzzlZEOW8ymagH8uNpifaZzVGkKeHakrm+XcLlwo=;
 b=v6KEx3rbRoiBEBBihSzO1KYkUnoK7+u0+St18mX5NP5I10hvxsNIsfcFQPLOwCMUiirscEasP/Cb+UaepdvweHHPtFbXrlTf8gjQi9Wv+vmP0K9CFZ3VEQaC88q4PjjvOnL/C+xjUMomOkDXyRNKhSBKduH+PythUFMDJj2ysNs=
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1339.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 00:27:22 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::b435:c513:2483:90b8%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 00:27:22 +0000
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
Subject: [PATCH 0/4] RS485 cleanups
Date: Sun,  7 Apr 2024 02:27:05 +0200
Message-ID: <20240407002709.16224-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.2
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
	X4B9AyGiz/tunw4NP9MZ0dIKYXUGSsr0ajF3fqD8MzuWWKU/VdHWjEMjGDT6Simfv8EJe3m3yilhTk9WJUT43auMW40ZMc7kVZPM5ZOlKVIM+QrsLKyoEMcfbr94Q0dDdMgOofaMY8ZYxu+8+0Xf+u90CIya5278SZcKXSM1R+vn1gRU3Z0lt2+BUcEsq6mXCWM29Ix8GuWIOSOf/Ht688ek0EC3jM8EqwinKv3C0obVipPLObe7qj9H1tDd37iXZsSLkG76Yj0y6MStmF3aRR9cIWZUwmGdjITh9w4Bnn2x36sWnX1YdWlbvwWIW+6u9gZRAF4x1L/nB06UkPsaewWjSaQGO8Uss8Ig2EfI2gIOKbWpwG746JxzktW6AEMLsFlJb472iZpSWNJTphsMh5KeI4yUp+FKrctiNxHCdMODDjCrVIT8sMzOyTl9CznhQ+8aoHR2GLwFqnKVesp4qc+H+XnAFDXFpbl5udvbegMzrz8QZthzsr1l/tCYVvF8HM9dAJPKtw6gjZ4ldLcpUOqDir3DAcDQfFGuScuG5DX43tCluJJHWmwRnAiEJ3FAO9uqTMCJBNE1a05hqc1UlpoKjalsKt5Hq0qyfkYTEjKDNb5pE/NbBLH4obKSyhg4FGMsjjEh1T6JuEQg2Ji2ids8Z/KGKyObX0KBA2559Lg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7WRMb/cPXeK2nQtbiBm6gQYNzeUKh0L2J83eiW0k4AOVzoSGE3zpZ1e0I+5p?=
 =?us-ascii?Q?UmV3FHxobRLL968jyZAJE/mZUMPh6i0/Lq4G90hir/fVen02XEoSKPgcsdtl?=
 =?us-ascii?Q?MojvJMZB8S9st526Ep9W6hy6WOTLOuvg7oeKyzC0M0es3qhV3Uj587FNZM7S?=
 =?us-ascii?Q?3+brz21iSeO1xfXxD5Ke8ut5vYd1stwZlH927YBjlfZZrvQ4OklUNzyV8GSi?=
 =?us-ascii?Q?fRIwdAdjaXGiI9S01zmd0U0KWJBti/fQpB03wwTqi1VHr9k0ptSCAkR2DW+K?=
 =?us-ascii?Q?ZRXtsmZEJfi3SnVnC8JCRAO3rOQvufu5wKAThRgAPZvtQp4cSysy/oXJ5FCS?=
 =?us-ascii?Q?jghR5S6Y+zF3JSaQJaGyPrzLoKc9vN8tuisAtCDamv4srFnRFmT6cXSmSIQ9?=
 =?us-ascii?Q?dHiZERuujaUZHaNpVp5wKGbp/y0wHgwes1Li/iGv8+8khOt89fUtRfZODa/A?=
 =?us-ascii?Q?tmtYXR4rLoZI17Xf67Z1UQFHIo98z9qIvg1aawf+7SEQkt++WgpeakmNTBWk?=
 =?us-ascii?Q?qTflAaWTpW3gdDnf4HLW18iaPPX1DBARizJyOT413VveglMp+wqX4RWQ2uYE?=
 =?us-ascii?Q?hDHE1NQhfRiUnTVaFVvcbZV2DLMDeiNzNbubBTce8zdvjBesNtj88LxvFiqB?=
 =?us-ascii?Q?EwTky/YEkTpPH5xVjM53Hyfepi5N87uwIY0a2C+C39OPXmx7rUzTLXOr5D/s?=
 =?us-ascii?Q?mKBy+kCXrd3gLQveOqrOfcBhOk+V/clzWpdiNkgTXzM/A+hDMlS5ehnpyKfE?=
 =?us-ascii?Q?B/D1r/cdqN8xTApgBguc82IznC16cJLKmtsADGQ3xn2Co6RZ5OE7mFvJbluj?=
 =?us-ascii?Q?8OR6InxlHYSooXVJJ09fi8O6InJiZacX5QJRvWK6pj9Y/qTXNYhnEmy8jiRN?=
 =?us-ascii?Q?QcH1fq1EOKFAnRpcCLW/CnlekJbUYrS57Ose3iHwCqU5z0ZM5/rIi7ujO/MX?=
 =?us-ascii?Q?BJYBfO1nGPYsRQnRX94lk5Ohb3zegs/lETp6G5AnNr3TUNlLXmdsHTOs8jYN?=
 =?us-ascii?Q?gr0NvNRgtppuVA8L38jzPAWHfJ6u7WL6hSDjSyV3cnK72nmgYtzS8EIrfnLh?=
 =?us-ascii?Q?5Cgr4bY6+VqGt/MtsEQiCKq5FjIL3qUgd4XSEJvoIhcAaviyv/w7+QDLuAYU?=
 =?us-ascii?Q?DIn8tQFIzGuJSoTgHaukKr2cYSmsOpjADO14HoADTXvTO7wFqzw3u3vJGjFs?=
 =?us-ascii?Q?MeSM+Z89PTDLu1Vv4kJH5lQggZzyuhpKbK3Ssn4J0qSh7FTaB1yoRuoOMyKG?=
 =?us-ascii?Q?wCJ2oDTFb2E+b3BQ8Cacpeyjy8QP91IFSjWnKwcSUyy4xiq7R8KFBKq014WD?=
 =?us-ascii?Q?35+o6Km8cputcHnlB4DNIZdMZWTDLTE54INGM2XsDT2mH4Kq5ch276idCXNN?=
 =?us-ascii?Q?TYle9CSGfPRFj6Pg5vqaEvSJ78HdfYP6ipl5ZJm0pBdQOpR+pB27XM1m5ExL?=
 =?us-ascii?Q?9pHANvJO3ul4CfDrU8Z1XmcFzA9HRt7No6MA1Log0p1KcQAZMfVjV/DSMGmu?=
 =?us-ascii?Q?HsTLLlllwp5jz0MhwwX+/VEn7FfRjoH6AK3+myKi9MMSO0PO9EzsAngo3Fyc?=
 =?us-ascii?Q?jCZy3K/wqS8Y0jort1J/6rYIzM14DAm2PB4rx9dlmU3UCu94XhojDnlPziwK?=
 =?us-ascii?Q?HUZpwZtG5+Y+/D2zYI4zFQ4+GliafvdEUqXjmSy1OGth?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd04135-9d06-447f-79ce-08dc56997da7
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 00:27:22.0333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHRtibZ+W4kh1lNspioiPB8C+YKxBYTCc9gVKsUD6Gmjz/VDRmsLoZjbBDRYtUH8sc9lqt55cT/jKFKc4Oy8Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1339

VGhlIGZvbGxvd2luZyBzZXJpZXMgY29udGFpbnMgc29tZSBtaW5vciBjbGVhbnVwcyBhbmQgaW1w
cm92ZW1lbnRzIGZvciB0aGUKUlM0ODUgaW1wbGVtZW50YXRpb24gaW4gc2VyaWFsIGRyaXZlcnMu
IFRoZXJlIGFyZSBubyBidWdmaXhlcyBvciBpbnRlbmRlZApmdW5jdGlvbmFsIGNoYW5nZXMuCgoK
TGlubyBTYW5maWxpcHBvICg0KToKICBzZXJpYWw6IGFtYmEtcGwwMTE6IGdldCByaWQgb2YgdXNl
bGVzcyB3cmFwcGVyIHBsMDExX2dldF9yczQ4NV9tb2RlKCkKICBzZXJpYWw6IGFtYmEtcGwwMTE6
IG1vdmUgdmFyaWFibGUgaW50byBDT05GSUdfRE1BX0VOR0lORSBjb25kaXRpb25hbAogIHNlcmlh
bDogODI1MDogUmVtb3ZlIHN1cGVyZmx1b3VzIHNhbml0eSBjaGVjawogIHNlcmlhbDogYXI5MzN4
OiBSZW1vdmUgdW5uZWVkZWQgc3RhdGljIHN0cnVjdHVyZQoKIGRyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfcG9ydC5jIHwgIDcgLS0tLS0tLQogZHJpdmVycy90dHkvc2VyaWFsL2FtYmEtcGww
MTEuYyAgICAgfCAxNiArKy0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvYXI5MzN4
X3VhcnQuYyAgICB8ICAzICstLQogMyBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIz
IGRlbGV0aW9ucygtKQoKCmJhc2UtY29tbWl0OiBlOGY4OTdmNGFmZWYwMDMxZmU2MThhOGU5NDEy
N2EwOTM0ODk2YWJhCi0tIAoyLjQzLjIKCg==

