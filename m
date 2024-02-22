Return-Path: <linux-kernel+bounces-76079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC21285F2A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A041F22F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD3E179AA;
	Thu, 22 Feb 2024 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="INgojQTK"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2086.outbound.protection.outlook.com [40.107.255.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997461B59F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589968; cv=fail; b=mVz5CNusbcjhXpE+Ck++ID1pHX+naeFSdAkxdnwIW2zOFf71WDK9emCfinhSKfc0grceu0UnYomxEzIePnbggsp6VtaTqYvDsLYRqW3uQeP1VnOTIz9u62xJPN2edvUwV+S/RQuktCwODLBsdGMsrdGjGjPSRP1/UTvtxiV5NCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589968; c=relaxed/simple;
	bh=KiXhafatXWRis/1dcKXLwDzUS1zit5rY5oRy9+MjAQo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ou9Npzo745RNe/EtsT0HKD6EAXWrKRIdlUqps6madqRf2ir1tmlzySi5HmlmibKUiIdcLq+d6h2h//FELWlyfGVCYl0maeMSDNwwzWJ7MlS8aIiNTDDf0h7UQtO3pslzBPGol8jtaS/yreAcmXsJ6wvSXO79M1HF7s9MIp03tv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=INgojQTK; arc=fail smtp.client-ip=40.107.255.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqU/MyiygVjYEv5a9uWqZkj9kGMW15P/hgvzNmAX0EyklrOOcO7rRd19iknM0ba79wNj32SkuejgYyrwuEmu+VLFtZ2cnMZKdNQXCK8TLoPBVL7H0vZuY1FNZqCO7CxXWxJ0uj8mdL/YtnHQzKFCJYku6vAKvnB0+H9pYNnRcPV5hvpvOq0BXhUzgeJ3v5muLiKKffV3n5aLUdyHVNrMXkMgMcERam5p1rDan/7nFG1l3Gu/xHSydKYL5jsL/O1VsDgW5P2mcwP9/C6Ki3US8I6l7hN3wgz4UBjKMUth7HbALsAQ1uDV9wqhB6UGVwdMR6RuRKzxPpmo5V91PDCKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiXhafatXWRis/1dcKXLwDzUS1zit5rY5oRy9+MjAQo=;
 b=TvJ8neKDJrF0MiUE+gdmurHCHK4B9fUpRiSbBAeD10KHw4ghCVNA+KRcojIZPkCH0k95X1jG7zf/NaQPRNW2HYB4WlDHkX92YZHAOoqYOHaQ55bETki5HPpc7pEqBJuOLIDq+7iLNv97iliOgW2WUgAynzfAcrfEI7GDHhLpJ2zUd/s7YurbIqpICgAT61GZZBJifYe1he9xMCL9ysCsGOYiZlbOl5/CmOy3RGbHvU3bhpMMipIE2ipbaNz7BvcmekdzePqI48/kO2tSJLjuOB9/c64SIO5zHC0bBKFGmS4qn8MZ1SlGSWp/3xmoUmLBKjuKBNL+2EaF44JtAoEeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiXhafatXWRis/1dcKXLwDzUS1zit5rY5oRy9+MjAQo=;
 b=INgojQTKq1hmAh5N4rpDYbC33Sp7OYKtGwO02wyVtR04uxvXPQhvso/8BHvHkexS4hyoQAp0uVXS6JNrp4i7sVArWuYqt0KmHO6l7ZWNAe0xMUenq6rXmoTWPsMv8hQfOVbKywKdIRA9RDZaOcbTm6TsqMMbQtt0QBzS7nSAt/aA3g2nrIy5ndRk3L5kBrYYsXxWcrtepqqtwhm+HXtXS6XfnibDMySJmP1IY5CpHvFJ2ot7aKpvf7unYThJLwq3XRv2h2r42jAU0cZ/9yS5amCidgspViCaO2oo7rqWz+pF7zcjQMJVsmB0Q/awNgGAwCXq5aH6qCD+AfiIfA5Izw==
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB5697.apcprd06.prod.outlook.com (2603:1096:301:f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 08:19:20 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::bb55:9ee1:ca98:c525]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::bb55:9ee1:ca98:c525%5]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 08:19:20 +0000
From: =?gb2312?B?wO7R7+i6?= <frank.li@vivo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject:
 =?gb2312?B?tPC4tDogW1BBVENIXSBmMmZzOiBjb21wcmVzczogcmVzZXJ2ZSBibG9ja3Mg?=
 =?gb2312?Q?on_released_compress_inode_while_writing?=
Thread-Topic: [PATCH] f2fs: compress: reserve blocks on released compress
 inode while writing
Thread-Index: AQHaQ6NaJP5KCQgwSkWyEPOTYY0ue7EWR/JQ
Date: Thu, 22 Feb 2024 08:19:20 +0000
Message-ID:
 <SEZPR06MB5269414D751BC878FF577906E8562@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20240110091009.138206-1-frank.li@vivo.com>
In-Reply-To: <20240110091009.138206-1-frank.li@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB5269:EE_|PUZPR06MB5697:EE_
x-ms-office365-filtering-correlation-id: f0dcb5d7-63b9-4fd6-94f0-08dc337ef864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 AtP/DGyzABrQxu6eFwJ5tHR43fDWwB/qfKh9Ym87RXxhLFFHGdVd2fgvsXEwcBNjJ4JZlN2kXXuZX2R2ebMqYPsW19Brp0HNz2PEQ+tfVL6ueAbTjAeLW+X6wPROjhNcs9KOBaTzbtLyOZOAcmsX4WjJRuqDZYv98JSTHNTif+bPltyxe+MR1SPKgwFF1hu334QNNXoIv6ckxllkMyOtipYFD+61CpdQVH8q3qv/oBG21Y/C8o3o573x51GklRDTJBiXrA2ZkJjZJ73RRZnIUmMiUfi2nvYuIrR1EIz2wZO7oloEx/kzZbn+R6u0g3NWcoD9wd/HIyHZLpEF6lzbPsR6PPMeFCPm71MQ2j2bq1o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZjIrSUljMjl4RzVVcGpGZjllVzljRXp1ZHgwdEdTbElqT25Zd0cyZEZTRXFX?=
 =?gb2312?B?U2tWTVRvQVZFR3JwZDdDbkVzTVZOYnJjNHJIdHJNdmRuWDNiKzREZjlNekli?=
 =?gb2312?B?cDdoVnBjVVdTNE9od0xRTHV1akNwOFpYSzQ3cUt5cFZESERGVWNFYmZMQnRK?=
 =?gb2312?B?bUtHUTdadXNSMXBhb2JQN0hUOFRZbm9zb2VNd3JvTjNkSzN1SWJDeExxVjJM?=
 =?gb2312?B?M0k2U1p6ZHp2SExaMVUvQVFiMFhrQzJUVGNHcFg3VER5clh0L2lpQ2lydDRl?=
 =?gb2312?B?bEYxdU01SFUwSHVBZnNrdUdUT0ZOZzdWMCs4bEtqMisxR2F5VStNdHkrTFRB?=
 =?gb2312?B?eWJINVUwM3FSYjBvbnYwMGlTbjgyQzFvTFN1WHpVMFNvWjV6Ukdja0RtRWhY?=
 =?gb2312?B?VDBkTERPdGtWMjB3TlIxZEZadlhaTmUyR3BwbXRyRzVXWnZnOWNSWG5PVzNk?=
 =?gb2312?B?NXZZbCsvZkFzMGE3WkNLekpKWkduc2dZbmhVVFZQOXd0SVpJbm5QbFMrV0Fv?=
 =?gb2312?B?eGxpRzdlMTNWRlNaK1o2d2dTc3dvZVY4VURSNWthMkdPUDcvMGdtRlFSaWFZ?=
 =?gb2312?B?cW8reUFDOUZFc3Z6S3YrekpFVm5JL0cwb3lGc21KZ1pTd0xJdWlXdDNPSjY5?=
 =?gb2312?B?dko1TmpkV0NHWk9BcGNObUc5a3JzemVqYUorWS9TZDE4MlA0b1ZFREtScGFy?=
 =?gb2312?B?clpvKzNuZ21pYXlmQzJZMFU1NzRZL25XZUFaU2tUWVc4OGVTYmNrTTFNSnN4?=
 =?gb2312?B?Umc1V3NFbElsb1YyaVN4ZEIrdnJpODhIYlFLNXBiLzl3L1ZSbndZaTJ6TUFQ?=
 =?gb2312?B?VC9jUjJZdUZzYkdvM3dQcWZVM1AvdTN0MjlDeHNOcjhMTWlRaENSZVZ3QVJY?=
 =?gb2312?B?NkVQSW53R2dZd3Y2RHczR0VpeCt1aVJlRXdWblk0d0N5NllnRGJOcFVuYzd5?=
 =?gb2312?B?YzFQMkZXMndlb1U2Sm80K2ZZSWo5UmxTNHlkK3FVQ2JFSnQxRWQ4WWJoc1FK?=
 =?gb2312?B?QUF4NkhWT0tDU3FyczJyUm9GVUp6S2R1UmhwNStkS1BtaEhhYzRYUWVndkcx?=
 =?gb2312?B?ano2Y0Y4M0NrUk9FTzFvTEcvVU53dlN0elZEWU1vOURhRzVVbEVzNkNxNmtE?=
 =?gb2312?B?OENCL3Z4UVpseWZlbnV2WEhtNFRIekJkcE53ZVhYV2N5QnVYVmN1U21VN0dD?=
 =?gb2312?B?VDQxRUhtTHBoQTZXajBIdXExZXpZNjJ6WDc2MysvM09VZXhDRVl0Y21TN2lV?=
 =?gb2312?B?Y3BnNFlHRmhhUHYvSWVQek9MbDhJZ2I0UTIwSEI3dnRKakRYVE5mcFFKOFUy?=
 =?gb2312?B?SHFQbldUMUtleDl4UkJvdERTek9QMk1YakE4dUFZZjFlNTNiTThlT1dNTWwy?=
 =?gb2312?B?RnFINkY5MUl5SHEzU3pnKzdib0tqNWZUdzBKWndzQWwyc0hBL0NFbzdDZFl3?=
 =?gb2312?B?eHNSUnV5bDdDY3RaWk1oSStGYWpDci9FVWtwMTdkSCtIQ2V5bDVrc0w2alhH?=
 =?gb2312?B?UnFNczdteUl4c3l5SGlKZlRUMHBuNGRpcGxCQzdBNERiVm00MXFqa25pQ1Rm?=
 =?gb2312?B?TWhsU3FVbkxyRnhNWlF3UGE3c0wvOHFWYlM5SFFWUEEvWE5iRVhxNVgxcTVY?=
 =?gb2312?B?SWZhaXFuTjVNKzBjMUZjZ1p2Ry9rcFIxaUQzTzZackRmUHhsQlo0Yy9sa2VW?=
 =?gb2312?B?c0RCaFBXUUgwZWFadnlqc0Yrd0daZVlWRE51Y0VHMGdabVRWRTBxMjdqU1R2?=
 =?gb2312?B?Mi9DU3EraXN0Tk9QL0lZa2ZTU1o4bGdKbFhKdHNkVEUxdy8zQWd0ZkhRbThi?=
 =?gb2312?B?TkZsaTB3ZUtuZmdUbHZqNUcrbXE0dTB4eWxXNTg0SWRzbWtIMjhUSXBQM2JJ?=
 =?gb2312?B?dU5QUmhlUzVKSWFhd0tsQWlsNHdMaW9RRWR3cXF6TmVsRmlEN0gwMDhRN2dK?=
 =?gb2312?B?T1ZPSVVJNDhiVnJmNHhGcmM5b1NFdG9ab2c2VHpVdllSaGh1RHBRakNWazBS?=
 =?gb2312?B?RlVMZ0cvMVNKQnB5YUNYc09kNmlYQjJhUVRGa1BxcXZxcmRwNHBuU21rbU4v?=
 =?gb2312?B?ZmNsWkRqdjlOT21KZ0xkOHVEVFZWSkp3Z3B2TE5raVNVQmhRRHJ1WXI5VWpx?=
 =?gb2312?Q?Gnrk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0dcb5d7-63b9-4fd6-94f0-08dc337ef864
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:19:20.5949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Qz5jCKYd/BPX34OEJAEY3Dh3fHSLNdDPopPJbxhw9SGFDYP1Zx+5abq68p0+78t+Tb/Y+cXPCUGYHed8rO45A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5697

UGluZy4uLi4uLg0K

