Return-Path: <linux-kernel+bounces-162376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF8F8B5A32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF88E1C21607
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E25745FD;
	Mon, 29 Apr 2024 13:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="ubie8qzf"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2108.outbound.protection.outlook.com [40.107.20.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD266F510;
	Mon, 29 Apr 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397775; cv=fail; b=eowleGmRqBf5GW/ct8c1SefFfVPCPeUWMeFQO5j77MgS4i9M3/66rNp2Cz05+SzcvfAf48woLZnkW/ZK9tWP6DfBIwreq7vJKhXFyKkvB/+4L0bxtREfkNgvdJBlhd2kXUDb8zhhiHueZMN/41JmL+2nCLc2z/O4IsusB/te9hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397775; c=relaxed/simple;
	bh=b2fB4JTmGhN4zOjp698Eto1qzkFTqwYPsBdkK8M4Pdo=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=SPoADhrklBPYVDqYZtV0lfY+vt/kc44hfPjX8suO2KVxqxHczvtI+UrSCq2LoyrEekaWu3+psr8BrhHJ9TW28PaLa2GUdMANsP5saFVDJStEgAXIQ+UGKTOZ8XvCfTqTDmKkeleYOghUXg2XyD94XQeEoQTd4CThuhVy+ZSTZdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=ubie8qzf; arc=fail smtp.client-ip=40.107.20.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/qHW8o5dmXOmsYNM1CX2TjxMIa6QyX816i1sHZULeZD7titPL3P3/Mhzj8b5ZO0yl+xbx5fYGov905GUvKyw47rBAaqqEQrPBiNkWq5VUyBcOyhtoYZsIfPt8zYHF6bgqWtma/Wn0b0qubF4pl8RFXklyMtjKnEkHNJ8/sRKae6VohSGWjNMxC/DyKcn4Ced8MqTLb7HZebzirORGsnol+l/UHN/25FutSTtoxprvZbxTN0OrQbsBL8XxKBsFIE9mCw/m8TwbHMiJ6d6W60H5NI2HDXILULGLwq29U36cNwuGsZDC6JuiRyniDWUn41CqEd8ELUeXWeYjo4ewdkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTA1lxa/g4Z5bd0fFvP0OdfIlgtGE3qIljn6t1PH5Io=;
 b=A7oPPpcTOM8MYDeAOH6Lwkaooq4SDgPWlzXMOFkMDoUMmPYw0eu/2jec9KatfpxkzlvJB0YpGy6kpjm9R4NtCx4nNf6gAODbIc165lx8FfRiimpqihjDZKI9sBhmstwhNanWSPJuLLQVUE/V/bkQZjcwCSEG5fklHIGiaW6qpno38z6jWKdo8mYSc9BItO24N4TlPLn9wXAb6GOp5ZWCqqdSZQpPvcTAIiutyVAtLxbpEKlfYX+RVBv81mk95xjjDWSlCkyIyy3hIXsVsoT9epQ/1/fZZkqr0LhjVob99kgx0r09x4e/qRyzaGqxxVUNxmtY2DjMp340FG+yq1xWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTA1lxa/g4Z5bd0fFvP0OdfIlgtGE3qIljn6t1PH5Io=;
 b=ubie8qzfIGk6Th0bxbUdWVmvNI3/Aiovu3j2H2uXk2Z/9fbgeX39IIJRaXaVcdNZd/l9BlZ3+lrCfnKbbbbqgHbqsJM+RMVsqTC7p42jSTH+KzX/RBpUh6doEiSqHiaTjm4G0L6IqpZgha11D0ANFEXlc05h6P5y+yDjJYXvCM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6119.eurprd08.prod.outlook.com (2603:10a6:20b:290::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:36:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6621:68a6:ab00:c040%6]) with mapi id 15.20.7519.021; Mon, 29 Apr 2024
 13:36:10 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v3 0/3] usb: typec: tipd: fix event checking in interrupt
 service routines
Date: Mon, 29 Apr 2024 15:35:56 +0200
Message-Id: <20240429-tps6598x_fix_event_handling-v3-0-4e8e58dce489@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADyiL2YC/42OQQ7CIBREr9L8tRgKYqkr72GaRuXT/qSBBgjWN
 L27WC/g8k0mb2aFiIEwwqVaIWCmSN4VkIcKnuPdDcjIFAbBxYlLoVma41m1euktLT1mdKkvPTO
 RG5iUrTbSaGG1gmKYA5bWbr91hUeKyYf3Ppbrb/qfN9eMM8VFI2prG64e15ef7O/s0WGCbtu2D
 5mhZ+bLAAAA
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714397770; l=2623;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=b2fB4JTmGhN4zOjp698Eto1qzkFTqwYPsBdkK8M4Pdo=;
 b=OIRHfLncoY7lBQvv5icf2+TtoTiMCH7K8BfKppz3ZZTkBcjpiEkri/pMKdugfVJjCnRM/iAJb
 QP7AW/tHDD/AfP4kOsBqQBQQ/3jgFMj8nYQyWtRCy1cJbrmposvKgmP
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: d287b70a-b275-4548-401a-08dc685154a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGlQenpzNC9WVXMxaE5IZzBpVHA5MmEvRkxKdmhIbnFUbFZGejk2VUlZYWxp?=
 =?utf-8?B?SG1zVWRFYmtPYitKU2F0SnFtZ09pQmJDTm5yMFhyUCtWaW1weFZ0U0VSNUlS?=
 =?utf-8?B?MmhZQ3VwcDdndDI3Ti9CY3p2dk4vMWZQcXFoelg0c3ZBbnc3b0FRRnQ1QWpz?=
 =?utf-8?B?bXQ5VTllZjFPcllMWnFSdllOcmJuczJoZE5mSXp5bVEyOHVjK2pxd0RzMGVR?=
 =?utf-8?B?cTcxWks2cVlyLzVoTERob1VCb3JTb2ZRVTBGbFRwN2QwTERFYkpjNFNxNTNP?=
 =?utf-8?B?NkRPYUhGS0JFaDVYdmtHS2RZV2ZXVU9hZU4wbCtIZ3l1Nnh2Y3hLL0tVWi92?=
 =?utf-8?B?bjRmcjJ6bENqYVI4Y3lDQXF3K3doVWtFS3I0QmRBU3RQVTBRakRiZHFJeUgz?=
 =?utf-8?B?OC9wRVZwZ0QrTHJzUExaSGRRS0JIeVJKZ1BZcW5lTHNOc09GTExSWitGRUsw?=
 =?utf-8?B?ZUhyLzg3cFlhM250SWtPcGJ1Nm9iOGhreHdIbFJ2N29lT1A1TUc0RHR3WE01?=
 =?utf-8?B?UENWM0NWM3B2cHZHbm5pcC9HZm9iZnRzeER0TUpzdmRjTW9VQ0ZiTEhuS0h6?=
 =?utf-8?B?dFBBVlJJOFRTd2M1UkJjdW5vb3hOc1owZll4eFlrRS9PSHdFZnAza1BuM0hl?=
 =?utf-8?B?cllKaEx4QWdLTUxQTFk1ejlabnNvVVRYR2pycmUwdXZTRFJOM1RHbHV2SUxz?=
 =?utf-8?B?eHQvQVlWOVZHejFiVHdsZHNVTWdlazl4SVpLNktUZXRrblVHOFRvbDVDeTRo?=
 =?utf-8?B?RW56cGt5N2ZyNUJKNnhvdlFwWllKemhLanR4ZTdrcklwN2dTaDg1d2FpWUV2?=
 =?utf-8?B?QllreTVpb3IvZmxJcW1xTVdQMmVaVGxPaFlJWUUvNHFTTStCd2cwUUxMZUhn?=
 =?utf-8?B?ekZHY05CaWQrY3pZdml0a2VBZFc5ejAvKzYvSTZvdHBkM3Y3RVJ1VmN1RFBS?=
 =?utf-8?B?bVRPSWlCRWYzUk5kYkVFak5uRDdRMUZieFpLVFE5RzRGR2VtaGJLZ0FobThk?=
 =?utf-8?B?MzhYZzduOUtSRlVaNlFUN0Izb3ZLVjFMRXJLOFprUWJ1ajBMZ1B0MVNLbkxF?=
 =?utf-8?B?SWFHVFRxRTk4NHlQTnB0K2RqQ3RJNTQvNGh0VytiRkRURER4QVdRTTlUMjls?=
 =?utf-8?B?NU4ySjlNRUtoczFkbGh2MW01d1pLc1h4YWZIOEpCcE5BcEVuWklSYXVEUFo0?=
 =?utf-8?B?a2hYbEdxQklnZUx6YzF4YmdCdVYvK09Nb0xTRW1zdFJVOEl0YVZvMm5lcWxF?=
 =?utf-8?B?NzVFdDBxOUVrOWtVbVczMFI2WFE0R3V3dUlJN0dpQnd2b2ZUUFZsSHMyVFA2?=
 =?utf-8?B?N3ZWSTdNcWUzNHBzU2k2M0dyenlWQzl4R3MxeWtJb1VWb2FZNmVWSmpIb2FV?=
 =?utf-8?B?dUQxM3Z5bENnc284S2xKSnhiSnFLcVAwUmViWnk3eDlzWEUzQWhzSlIvWFdp?=
 =?utf-8?B?akQzcVNUSWMvLzRVa0c5WEZJV3l6bXg0YkJ6d25McFZnR1FLK0RZa05YOENV?=
 =?utf-8?B?RGFGdWNYYUVxcmlYSi81TGV6VTBoOU9PWCs1YUtLQ3ZybWNiMUx3elZjQmdo?=
 =?utf-8?B?dGRKYjFZWlFLNHMvbG92b052c016RTcramNWbjhENUNES0VZYVpkRE9kM1RZ?=
 =?utf-8?B?MjFzSkUvNm15NzFGWTU2OUxqYWhvRTJXWlBadXVBUHNIME90QitNOTVkTjZG?=
 =?utf-8?B?WDNiSFdjMDVmYzNNdUxGeHpDdWpsVHM5Y2RtOXBHQUJJVUs5M0dXVTZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlvaUJES0ZNZzlERk5iM2NnSXl2VUo3cTdWdG1tU3d1U3BOMk5yQS81Y2dM?=
 =?utf-8?B?bWI3bXJPRDdFK21sT200aXM3c2Q2NG5jeVMrS3BENFBRbzVMbHJob2xoTkk2?=
 =?utf-8?B?QmdtWFRKVWtmbEUvT0JtUWZqL0IvS21FNm9SSTlJUXM2bUFNN29FV0wzcWNV?=
 =?utf-8?B?cXZ6d01FbS8wWXRUVld3aVpXRTg4TUlja3V4WS96M0FwOFpZQ3NqMkZKSVY5?=
 =?utf-8?B?bXBMYkxSdUZQdmVTRU9xR1VZU01UV0NZVGthaHNoWDBzTkNsYS9vbnRmcnFh?=
 =?utf-8?B?dDBsQzBrOURMOXhDVk1tNktlY0Z6eDBvL1hHQWQwV244QktpN2I0aFQzQTRh?=
 =?utf-8?B?bWpDUjVBYVY1c3VxeFEvdjZDUmxnM1cwMHhuaFZYdEJLS2pDUGNVZGlXTFNn?=
 =?utf-8?B?SEphbTNkZEFReUcyVFNSVEpuQ1dwMmtLejhSNnVUZWdpVEtDb3cwWCtMRGFE?=
 =?utf-8?B?SGQrd3BzUmtxRE5oSEtpNmg2VjYxNE9YQ3ExbzZ6dytaNjVPQ0VQUVo3VWNS?=
 =?utf-8?B?bkhGYmNXS05uR3lVdHRoMi9HRWNQUkJkT1FQT0ZvWXdtSGdwOFA3dEVDQXZi?=
 =?utf-8?B?bTkxOFpaYkxKWExFQlVqWnY0TkVEYmQxU0JyUXRaL3pvR0lDMHkvTWFWUWJn?=
 =?utf-8?B?V2JIWWRGUk50bi9iN3FOOUU3MmxhMEZ1UVhuQnYzMkZWNCtXMkhaUkphTTZ2?=
 =?utf-8?B?TERvaExYNFdVT2VhU2Noc29YQUdWS004dFFSSG5IeXlEcEpWanVVTjJnZHNB?=
 =?utf-8?B?amt6RjMxV2lUdDA5djVQMWMwQWdIZVlGeHVFR1NNMEVaR1ppRkFNRTZIOUZk?=
 =?utf-8?B?WVNYN2lEQWkxSGJmSXlhVnE0RWFMWFFWeHFHOVdSSlJMbTJocWQ4NHlQNWI1?=
 =?utf-8?B?eVIxUkxxS0RGVUs3eFZhK0JWNjdGYUlpSGFxcFJOVHRPZGM2bHNncmJKRkk0?=
 =?utf-8?B?UXZzY3hpQ3pqVWYvS3JieWJaNHFOcGFrbzB1KzlybVpCLzVCeUdaYjh1dlJN?=
 =?utf-8?B?WXZsMVVHUkNjYlFlRERyVHZDSFRHbDByaXdGdVhZR2FhdUtKMldZY0xnS1NJ?=
 =?utf-8?B?NGtYZDlMYWhXWUN6bHN6a0VYcXVpcHRuZkVhcFhlUkV1bDZzMEdNQjh3d2J4?=
 =?utf-8?B?UzdrRGpXTEk3RVNEdklJS0hWdlVmNGc0YmJEeWdhVzNSMm9vdHJuT01JaFRw?=
 =?utf-8?B?eHl6S2VmU3ZaSmU5blRFczgwbDJyOHU1TW4zMVNpcXZrQndXVG11QmcvYWhQ?=
 =?utf-8?B?VWp1MGY4ZVVIMmRKc3d1T3NCVUVhMnNMMVB5UGtUY0k3NHI5QlpLSHpUclVy?=
 =?utf-8?B?cFdrUjE3MzR2MThmMjVLb1Zod1BFcTYwWGVpS2RwSHp2V2F4dlU4OHZCamdZ?=
 =?utf-8?B?WStDaFpDU281cklqUXcrdUdqNnlia3NnckZvV3VXRWV5YWxHMHgyUmxkVDdF?=
 =?utf-8?B?amU4SGpiajE2QjhzRHRuSzhVYzNCbmhIS3psUWRSUVdOUEpiS2RJY1EzWmU5?=
 =?utf-8?B?bURVeDQ4M2Y4S3l6ZE4rWVBJd0ovRHZjUUtvZ2RDWWdNS2dlUXUrWkg5dndL?=
 =?utf-8?B?NG10eHlPTm9Hb1pTcEd0cE5ybUMwbjNka08vZmFaSXdwZHRxaGQxMGQ0ci9k?=
 =?utf-8?B?T04vb3ErRnY2Z2dXZzF3MmhFTytZWUtod25QSlUxNnZzeG5LdTBOMVZaTEVz?=
 =?utf-8?B?T0xGNnRKNDJYVWgzcXZ0MDdzWHAzNU9YdzFHUFhGMUgycU9UNElyWEdkUy9V?=
 =?utf-8?B?a2d0L2o1R1VXRVlQUmNvNklvSkJOOEE2MWE2Z0U4YzllWFBjZmZNbW9ucW9N?=
 =?utf-8?B?NnpRVGxlMncyMlZ5Z0hacXM1b1lWR0xuOHNDNW8zNjFXMEIwMStGekRRanBF?=
 =?utf-8?B?cnB3aTNxT0lZcEl4RzN2OU5GMUZuVTViaHIyekYwaUhEZHlWdys4U3BwK3BR?=
 =?utf-8?B?Vkl2amVNMFcvK2JYa1JBSTNpUWhqN2xqOURaanZVakRQNGpsSThtRUNRTWhP?=
 =?utf-8?B?QkJpWFVjTWFiQk9US0Y2eUNudjgrenRhY2VEU0hvQ2xNaXNKVythdFNPcGNt?=
 =?utf-8?B?Qk94ckpMQlRqeXNSL2x0YzJ2VWN1bHkzWWtYaUNqanpSQTgrMWRuNzJTaWVj?=
 =?utf-8?B?aXRkbm5xK2FWd2xJVVdiRTd6a29oTU8wOTFhZ3BhRzdVQklJQUF5c1ZBTnAw?=
 =?utf-8?Q?8dNG2qJuCCFZBcNjAO9eV7g=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d287b70a-b275-4548-401a-08dc685154a7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:36:10.3010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeTuIxSFXDHdxf+zae/5a9umXaqa5vWdIphZScN02FewQOpeNiEk7JprAufuwednzLHCyQcix7M1HX/bC89WNA2OvJdP2I32dY1uN3ykFUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6119

The ISRs of the tps25750 and tps6598x do not handle generated events
properly under all circumstances.

The tps6598x ISR does not read all bits of the INT_EVENTX registers in
newer devices (tps65987 and tps65988, which have 11-byte interrupt
registers), leaving events signaled with bits above 64 unattended.
Moreover, these events are not cleared, leaving the interrupt enabled.

The tps25750 reads all bits of the INT_EVENT1 register, but the event
checking is not right because the same event is checked in two different
regions of the same register by means of an OR operation.

This series aims to fix both issues by reading all bits of the
INT_EVENTX registers, and limiting the event checking to the region
where the supported events are defined (currently they are limited to
the first 64 bits of the registers, as the are defined as BIT_ULL()).

In order to identify the interrupt register size, a simple mechanism has
been added to read the version register and select the right size
accordingly. This mechanism has been tested with a TPS65987DDHRSHR (DH
variant) which returned the expected value (0xF7).

If the need for events above the first 64 bits of the INT_EVENTX
registers arises, a different mechanism might be required. But for the
current needs, all definitions can be left as they are.

When at it, an explicit device_get_match_data() (which is already
contained in i2c_get_match_data()) has been removed.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v3:
- Remove explicit usage of device_get_match_data() (new patch).
- Fix series versioning (last resend should have been v2).
- Keep 64 bit reads in the interrupt handler for tps65981/2/6 by reading
  the version register.
- Link to v2: https://lore.kernel.org/r/20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net

Changes in v2:
- Add Cc tag for 'stable' (fixes).
- Link to v1: https://lore.kernel.org/r/20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net/

---
Javier Carrasco (3):
      usb: typec: tipd: fix event checking for tps25750
      usb: typec: tipd: fix event checking for tps6598x
      usb: typec: tipd: rely on i2c_get_match_data()

 drivers/usb/typec/tipd/core.c     | 56 +++++++++++++++++++++++++--------------
 drivers/usb/typec/tipd/tps6598x.h | 11 ++++++++
 2 files changed, 47 insertions(+), 20 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240328-tps6598x_fix_event_handling-3398d3d82f85

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>


