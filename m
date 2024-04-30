Return-Path: <linux-kernel+bounces-164573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFAF8B7F84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1650B1F22986
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89411836C7;
	Tue, 30 Apr 2024 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKs9SOCD"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A9180A85;
	Tue, 30 Apr 2024 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500684; cv=fail; b=KWBlobcG+25aSNF58aonVgyAl6B8M2Td7OL7SAIvnNjzTCghGQkHipB4dqkdZ3L3v9Mwh/OFHMW7z2iFYkKD3+1+o3iQJm4ES7tU8xdLktM7fA0nRMazG8ByWvIISziKgXHMrP8fkNtEcoqC9gQOSKEoeV24ZB8ZB6dFgoWxlmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500684; c=relaxed/simple;
	bh=CI0tQZMx3x3r69uL3KUUCad0jW9aEp9ZR+Z6bHw/hDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=humq10J74gKgaEOxiQos3XRQj4pdAF+CqfFdNd272i/keBPd18fNQp2JNukBzCJAdSV0GyYhv3jsLIj9Ufrso/OJVUWcVQubnR3t3upMM1NKvD5Qs06cEHw/e2mc0Qq/2TkNEvvdYekMoMSZVrvpjGrOZchIyJMCdO8+g4T55r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKs9SOCD; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjJ4BcGrJU/N6RRBx++t8rqRn1FBMMVR4DkUNXnBZS8PBwN1SZBmF6qHkrHFrNYiQCys1v+CnAe33GOMDRH/Kdacjus5ldTroy2mYfBJV/5kgM9U2WkDBP06KQbKxezvf8jpbLMlytuwfoqu29GIvs+H6IzxspEfAxOLUjHzGLWAJyEeNVcpZFFFlYyT6gCT+I9iCqE+4VLIz8bG4soYAnO7telK4UTLgt1l9R4Yhb6xBwNLElP2sBaakKMqNoq/hf3Wlf+wiTU/mnIVklAWJ81ZX3iycKH5oLz5LrW59Trr6cr0qcSNGmoKs6/Kkr3XyiPRcuMkk/ftP/7Ie9xsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CI0tQZMx3x3r69uL3KUUCad0jW9aEp9ZR+Z6bHw/hDs=;
 b=Io12lUkCsgBZsydIc0s/TeAolk6EWIhM9PKXDwivfLlyWm0tLUdkhszzBByBrZFSz9fPBe+gGhiGqUw44TsAkCXZXWO0Sy2q/gIogPdQke8bvIkhfLJKlk3WUeLFC3bwCn/wFsl2lMzzk2OUsn0sUxUuyO16jYf/QqFXkWLKT+j+OaTzXhpxeKJclq7I+U5/4BhqJZq4fwurY5uyqJv1c6qWm5LGUHw5+gMeXkXQiP9emKosN1n+HwnUK6a7Q/WkP0PAf47JxDnQFeXuSShSoE4wTCLoeyrwroQFMURvMuTouVAFSJj0gg3Zt/YMIgGGya+T07bcyDmpDXXYF7bwoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CI0tQZMx3x3r69uL3KUUCad0jW9aEp9ZR+Z6bHw/hDs=;
 b=WKs9SOCD2hVR2MoYQypj9O84h5c9BCgDVcnxpw/t3qtoIH/oQBe3T82s2iBwnlp0oUDFfaFo8FYTzWtlXgwtHxcRj1tC0blC8z0c42T9nE739nRRMSLUwvPt/DaUxKE48LzDvUFLIMInh4sunNt9Mlj+OXAftyvEG3ppgkCN8IlE+E/C+rFNNBfMerHtsnQ56uZTbgB7hRrqlZzc1DMCW+2W1MWtrAaVn0pnKVoyigefEuyEbZm5zLWV/mLzL7rktZjQJnL/5h/981CSxov4Y1M7/Hz61KxOwijbzfqmb+3WCimc8mhCYmqCOWPYJ0j418kYB/u9T0hdamOYTqguig==
Received: from DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 18:11:18 +0000
Received: from DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd]) by DM6PR12MB4516.namprd12.prod.outlook.com
 ([fe80::43e9:7b19:9e11:d6bd%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 18:11:18 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
	<sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
	"przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
	"ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
	"paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, mlxsw
	<mlxsw@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: RE: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Thread-Topic: [PATCH net-next v5 04/10] ethtool: Add flashing transceiver
 modules' firmware notifications ability
Thread-Index: AQHalku5+CuUOiSJUkSAUJYGzVV2UbGAK5kAgAD6ZCA=
Date: Tue, 30 Apr 2024 18:11:18 +0000
Message-ID:
 <DM6PR12MB45168DC7D9D9D7A5AE3E2B2DD81A2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240424133023.4150624-1-danieller@nvidia.com>
	<20240424133023.4150624-5-danieller@nvidia.com>
 <20240429201130.5fad6d05@kernel.org>
In-Reply-To: <20240429201130.5fad6d05@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4516:EE_|IA0PR12MB8326:EE_
x-ms-office365-filtering-correlation-id: 4b62167e-7c66-4d6e-be64-08dc6940eec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?VTN0ZjR3SklXU3o0MEtHR1B4VmtPbUtET3BwK1BMZVBBNXFNcUE0TllqR3Bn?=
 =?utf-8?B?NzVjTlZiRFBadzRwT0o3cTA5eDZ4UlhWbkF1QU9JeE4rTzlYQTJrZURBYUQz?=
 =?utf-8?B?RzdjVDJSSFZtRHQxbXBPZ1RKMWFmUkowNWxwekJQb0ZSTUlURDF4TmhMdFVU?=
 =?utf-8?B?eDlsOHB0SGJWaHlnUTlXM3hoTWpsMG01WGtCenR4NWZPak51RzJtMTJVRFF4?=
 =?utf-8?B?dEdVS1BzZkxLbGJDSFU4YnVTMFRkTFp3VHdWRGo4Skg3TmQ5TDU1QlBjeCtU?=
 =?utf-8?B?M1JNS1RYZVVxMmJFRWp5dkYxTitYR3U5SENBaCt2eHdMc3RySVdOeWxVUCs5?=
 =?utf-8?B?ZVI5WHVxV08zNmkveE5zL1V3bVpVNzJZT29NSGJNK0hTcFR3TlgzbGpCTHhv?=
 =?utf-8?B?RGoyU05yU1I3S2pPZWZHRE5VMzg0RWJxTTZ3aEVPd3psTU52d3BTYjhSdDlV?=
 =?utf-8?B?TXZwcmdibG5WWngxYXRVTWl1aVdSR1lNMmZHMmpSUm1rUEkzWkRCaXBwMEVz?=
 =?utf-8?B?ZXpiMlEvOUE5ektGSTRkMUg5eDdsWVBFT3U2bnJaQzFVUC9wN0R3ZW1hMi9H?=
 =?utf-8?B?Wm4vRkxaSmp2UmFaQUFjaFgvUDNhcko4djI0MS9pRUNUT01DajFraHl5SGcv?=
 =?utf-8?B?WERtMkJOS2VVRVRXL3ZRU3dOaE1kcW8vamN4TDl4WmtxZThYVCtzOTVFcHN4?=
 =?utf-8?B?YmVWUmZXQk5kenFnTnkrNEc1QUh6bVJQWkVsazhFUkQ5SlFoSnFISEVaTEQ5?=
 =?utf-8?B?eXpHSGp6dmxSUFhSdXdlaTdRREw2dEM1eWROSThwYktLYjh3aVNsTlljcWVY?=
 =?utf-8?B?K3JiMnhUSG84Zy9ZNXBONmw0czJiSmdDaFZXN1AzT1JzODluYnUyRGJkRjlx?=
 =?utf-8?B?d3dxZCtsYzBuQWszb3V0bnptRVVWR3p0cTdwK0lMRFNNZWVZMzRsZmJ2SWUz?=
 =?utf-8?B?L3JhYzg3dm56UmZ3RzBVSHV2d0ZZWldtdjROTEZCV1Z6L3AxN3BzTERZdnRo?=
 =?utf-8?B?UmtMLzdJMnFVdUEwcTZCNml4aVNtZXh0bis1QXovSUY2UjRKYi96a29aZGxV?=
 =?utf-8?B?R2pIM1NOTUEwREljUUdwT0RrOHdsbU5meTRCNllyRk8ranNyc1Qva1ZIU3gx?=
 =?utf-8?B?Q1dTZ0ZGTHI2VEJDZzFtUTZqQjI0NGpCQ0xGaXhtZUpSY1hqZVphbkpiSnFr?=
 =?utf-8?B?OVRsK1I2ZDVqNnZzNHJnY3VnTFh1MHowMlNaYnl1bFhkTWczVEg3WnRjM1A5?=
 =?utf-8?B?NkU4MnErZDk4SGthWGNMUXVDcC9BSWhidzh1dFZLNUJPNWtETENYeFkyd3M2?=
 =?utf-8?B?bTBsNlhvVTVQN1BFUXk4T3ZNUmdkSXoxZmRFQ2RZUmdyd0tCSWN6OGpIVzVQ?=
 =?utf-8?B?c1ZGUUZKVVIzanYzSnN4blh3RC82NjIwSy8rYzg4bmhtQUdNdVhrKzBLQjJH?=
 =?utf-8?B?TWFySkZYWWZFR2JqVXNqckplUkh1WWc5RWw5OXJzVllHUkg4czNSQ1NqdVB2?=
 =?utf-8?B?U1VQOHRoWkpSa1pGc2FjcksrcHJJbkYzYjgybG9LT20zZHAwejJrendNQVdG?=
 =?utf-8?B?cUs4SWNaTlJBR3dLUzhrbzI2UXpzd2R1ZHpQTjl2KzN4S3RuSkhFVFliUWwr?=
 =?utf-8?B?R1JHNVFzbEM4S29yclk4VmJQbm9QTVMvRzJVS0pxNXVkSHN0TEwzWWxsUm5x?=
 =?utf-8?B?TzA5TlJxTlZqQzBVT0dGMjlqUEdtSWxXMW9qdHI1OGhHYWxnWUtXZ0xKRTRH?=
 =?utf-8?B?c1AvRm5nRjd0YTRwL2xRSm5TcStWdXNXY0VUTlgyOXV5T0VBcUY2MDhHVEZ6?=
 =?utf-8?B?dHo1LzU2SSttYTBVVXlpQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4516.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?REJ4WjF3K0dNaTQ3TDd1SWtwRTVEdmVad0JhZUluYUczeGlUemk1U0RnTVZP?=
 =?utf-8?B?dThvRzZhQmdjVy9qeStzTHdpbm5vV1Y4TVMvZ1U0MU1tWGJxby81bzhaaWxQ?=
 =?utf-8?B?emswRnh3WTVnR0RzaStvM3I4RXh4NUN4SmNOQnJ2b2FYNHZhYi80ZGx3UUxa?=
 =?utf-8?B?eGV3UkM1bU4vZHNDZndFZnkwc3h5eTJCelo0M2lpS2MvVzNMbzZacldrWEhu?=
 =?utf-8?B?cmlaaUo1bzAzRFR4L3hJTmFnMkk0dW9SNk5EOUxETG9nTkVnMUdsYnQvcjBs?=
 =?utf-8?B?SFBVYlVmRXM0VWtyMzNSV3N1Y3lrNjF1R0lsZGFpa2kzZnlXeThJT1NQb2hO?=
 =?utf-8?B?NStZQ2pwWDhEWnREb0JWVzhBZGE2cU9mNG1VN2twN0c5R3BUUml0ZmVJZ1R0?=
 =?utf-8?B?YUJHR0pBc0F6SFZYYlk4OG9GcFBLMjZyMWlaeTdEYXNsMkd0dHlNUHhrSU1U?=
 =?utf-8?B?K2RaWW4yaFo2cWI4dFVoSWQ4RldlM2hjRzVYbmZQeVpsNG9vZXZwU0w3OWlm?=
 =?utf-8?B?T3hpT1B0MDZpZUpTRVViQ3E2WDh1Vk83LytTVEtYNnk2WEo5cHNFRktqSDIz?=
 =?utf-8?B?WFhRMm9peWx4SUZYSWVFRVAwcURMWDBlVDQ5ZDdXOURabHpycHJibXczNkJq?=
 =?utf-8?B?RUVFS1ZabVBRdDg0RzcxYVVOWDJIQnVublZhVU14ZllJejQ2TGhTSTNnd2hk?=
 =?utf-8?B?a1U0ZWtNY1hXMEVndHgxUVNLb0NJT01OUWZpOWtoeEtwMzI5amFKdi9pbXYv?=
 =?utf-8?B?NXNhakt5VGdYemlDcWpFQ0NNUysxUTFxeThwOVREcnpJT2RaN3VKT0NoR0Nx?=
 =?utf-8?B?ckpaMWdzaldLRGt5alRKSk1hbGdwTFZ3SW84SUw1U0sxRkxqQlpmaHVjUDVM?=
 =?utf-8?B?bnR1VS9WMk9nYmVKeTZaY1NhbDFVMmRtczR0U2lFWk9XdGliU0NxWngzZFB5?=
 =?utf-8?B?Wm8rVnFzUXdwbUtseDdsZzdhbEpjNEhOZ0JkVjEvaDlURms2bUxuTTdwaWhV?=
 =?utf-8?B?ajdJd3RNT1Y4QjZpeGhZN21XMlVvcnJ3aHNmaXk1T09mM1BiZ2lCQlJ2VmZh?=
 =?utf-8?B?MzcySklWRHJGOWF3U0loM0gwL29TWVRKeWdWZi9tcEs1ZWJVRzFlTzFjV2VH?=
 =?utf-8?B?L3EzcW16TXM3NkZaMFJLS1p2bnhTRWdlS0FsME0wZ21odVZBbkJ0Wml3aHN3?=
 =?utf-8?B?cHozaHh4UVk4M1RaNWsvbFMzeng3RUVlYXEzazVPc0x6UkxzU3lNd1UrSEww?=
 =?utf-8?B?blFoVzlWZkRGMGRnUGV3Ti90Ym5xRFZxRnpaZTFhNkI3Q01hNWNVcFVUREs2?=
 =?utf-8?B?cUJHaGlzbC9YRW5ieXZxZkNUZm5Pd0tqZjRvbVlVUEg4R1NyMVB5UVVPcndX?=
 =?utf-8?B?amExZ3loZ1Q5QUJqWGlZYVp4bnVtcmp0VWdIeEliSkVBK2tma1dEbk43a3Jl?=
 =?utf-8?B?NGdnTlcrTjhvc3lyQ29EZnhyN01zQ3ZJdk83SEtIcGVyYzZhVTBmWHVpcjJu?=
 =?utf-8?B?SEFmZHZoYWg3c2xUOFd4TTRHU2ZhcWJVTmpqVlQ5VkJUSExxWjJscEJJR0Z4?=
 =?utf-8?B?WjBqYzI3UnlIbFJ5QUdEeFRDbC96ZHIzcHBmWmJIa3Q3MnAwQmF4aE9SQ1NS?=
 =?utf-8?B?UTZWc1A1MFZ0WDZ2V0pOcTE2T3I5MHZ4TE0vVDVvZnUvWWRlVWsvbW0va1VU?=
 =?utf-8?B?YkxPT3hReUc1YXhhTUlJUUw4OHgxaCt1YmlQZ253UkNLZC96OU1RdlJMUmpv?=
 =?utf-8?B?OHRqTzd4ZG5yRXBSQXFzcG5NUndOaHlIR0svL2RKWWRlVU12Q093ak5oMm8z?=
 =?utf-8?B?KzFXdDhLamh2UFdDci9tZHd4Nmd3QUJGTFBDbC9VOEk0SzN3Yzl4U2JsaTNv?=
 =?utf-8?B?NE1xSzFueG9tTU1ETUl6ZnpEZXY2bW02Z1JmemhYdDZYRnY2YlYyU1dWaVRj?=
 =?utf-8?B?cVBaL2R6OTlQc3N6YlQ3WDR6d1BwTHF2SWFhWGVjZFY2K2g0a3pyVEpIblVo?=
 =?utf-8?B?SmVjZkFNc0JET2lEK05jSytTcHppT1F5aHh2eGl5ZmkyeFBiRGI2T3d6SkVv?=
 =?utf-8?B?TGhSbnpHQURiaEgxaXJuemFrWk40cUc2ZGVQU1JhNmxuZWU3MVB5UFIzWE9G?=
 =?utf-8?Q?chliK22gMQDhXgwXiT+4myH1k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4516.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b62167e-7c66-4d6e-be64-08dc6940eec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 18:11:18.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coXqYUyGZA1hd/Le8WvmW2rdW7c8IjSFeo9rQGnjdfYpICsPjEO+jILpQHhek1TgzcI8663H16hwrs+r1STFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCAzMCBBcHJpbCAyMDI0IDY6MTINCj4gVG86
IERhbmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+DQo+IENjOiBuZXRkZXZAdmdl
ci5rZXJuZWwub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOw0K
PiBwYWJlbmlAcmVkaGF0LmNvbTsgY29yYmV0QGx3bi5uZXQ7IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsNCj4gc2RmQGdvb2dsZS5jb207IGtvcnkubWFpbmNlbnRAYm9vdGxpbi5jb207DQo+IG1heGlt
ZS5jaGV2YWxsaWVyQGJvb3RsaW4uY29tOyB2bGFkaW1pci5vbHRlYW5AbnhwLmNvbTsNCj4gcHJ6
ZW15c2xhdy5raXRzemVsQGludGVsLmNvbTsgYWhtZWQuemFraUBpbnRlbC5jb207DQo+IHJpY2hh
cmRjb2NocmFuQGdtYWlsLmNvbTsgc2hheWFnckBhbWF6b24uY29tOw0KPiBwYXVsLmdyZWVud2Fs
dEBpbnRlbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtbHhzdyA8bWx4c3dAbnZpZGlhLmNv
bT47IFBldHIgTWFjaGF0YQ0KPiA8cGV0cm1AbnZpZGlhLmNvbT47IElkbyBTY2hpbW1lbCA8aWRv
c2NoQG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjUgMDQvMTBd
IGV0aHRvb2w6IEFkZCBmbGFzaGluZyB0cmFuc2NlaXZlcg0KPiBtb2R1bGVzJyBmaXJtd2FyZSBu
b3RpZmljYXRpb25zIGFiaWxpdHkNCj4gDQo+IE9uIFdlZCwgMjQgQXByIDIwMjQgMTY6MzA6MTcg
KzAzMDAgRGFuaWVsbGUgUmF0c29uIHdyb3RlOg0KPiA+ICsJaGRyID0gZXRobmxfYmNhc3Rtc2df
cHV0KHNrYiwNCj4gRVRIVE9PTF9NU0dfTU9EVUxFX0ZXX0ZMQVNIX05URik7DQo+ID4gKwlpZiAo
IWhkcikNCj4gPiArCQlnb3RvIGVycl9za2I7DQo+IA0KPiBEbyB3ZSB3YW50IHRvIGJsYXN0IGl0
IHRvIGFsbCBsaXN0ZW5lcnMgb3IgdHJlYXQgaXQgYXMgYW4gYXN5bmMgcmVwbHk/DQo+IFdlIGNh
biBzYXZlIHRoZSBzZXEgYW5kIHBvcnRpZCBvZiB0aGUgb3JpZ2luYWwgcmVxdWVzdGVyIGFuZCB1
c2UgcmVwbHksIEkNCj4gdGhpbmsuDQoNCkkgYW0gc29ycnksIEkgYW0gbm90IHN1cmUgSSB1bmRl
cnN0b29kIHdoYXQgeW91IG1lYW50IGhlcmUuLi4gaXQgc2hvdWxkIGJlIGFuIGFzeW5jIHJlcGx5
LCBidXQgbm90IHN1cmUgSSB1bmRlcnN0b29kIHlvdXIgc3VnZ2VzdGlvbi4NCkNhbiB5b3UgZXhw
bGFpbiBwbGVhc2U/DQpUaGFua3MhDQogDQo+IA0KPiA+ICsJcmV0ID0gZXRobmxfZmlsbF9yZXBs
eV9oZWFkZXIoc2tiLCBkZXYsDQo+ID4gKw0KPiBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0hF
QURFUik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlnb3RvIGVycl9za2I7DQo+ID4gKw0K
PiA+ICsJaWYgKG5sYV9wdXRfdTMyKHNrYiwgRVRIVE9PTF9BX01PRFVMRV9GV19GTEFTSF9TVEFU
VVMsDQo+IHN0YXR1cykpDQo+ID4gKwkJZ290byBlcnJfc2tiOw0KPiA+ICsNCj4gPiArCWlmIChz
dGF0dXNfbXNnICYmDQo+ID4gKwkgICAgbmxhX3B1dF9zdHJpbmcoc2tiLA0KPiBFVEhUT09MX0Ff
TU9EVUxFX0ZXX0ZMQVNIX1NUQVRVU19NU0csDQo+ID4gKwkJCSAgIHN0YXR1c19tc2cpKQ0KPiA+
ICsJCWdvdG8gZXJyX3NrYjsNCj4gPiArDQo+ID4gKwlpZiAobmxhX3B1dF91NjRfNjRiaXQoc2ti
LCBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX0RPTkUsDQo+IGRvbmUsDQo+ID4gKwkJCSAgICAg
IEVUSFRPT0xfQV9NT0RVTEVfRldfRkxBU0hfUEFEKSkNCj4gDQo+IG5sYV9wdXRfdWludCgpDQo+
IA0KPiA+ICsJCWdvdG8gZXJyX3NrYjsNCj4gPiArDQo+ID4gKwlpZiAobmxhX3B1dF91NjRfNjRi
aXQoc2tiLCBFVEhUT09MX0FfTU9EVUxFX0ZXX0ZMQVNIX1RPVEFMLA0KPiB0b3RhbCwNCj4gPiAr
CQkJICAgICAgRVRIVE9PTF9BX01PRFVMRV9GV19GTEFTSF9QQUQpKQ0KPiANCj4gbmxhX3B1dF91
aW50KCkNCj4gDQo+ID4gKwkJZ290byBlcnJfc2tiOw0KPiA+ICsNCj4gPiArCWdlbmxtc2dfZW5k
KHNrYiwgaGRyKTsNCj4gPiArCWV0aG5sX211bHRpY2FzdChza2IsIGRldik7DQo+ID4gKwlyZXR1
cm47DQo+ID4gKw0KPiA+ICtlcnJfc2tiOg0KPiA+ICsJbmxtc2dfZnJlZShza2IpOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICt2b2lkIGV0aG5sX21vZHVsZV9md19mbGFzaF9udGZfZXJyKHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsDQo+ID4gKwkJCQkgICBjaGFyICplcnJfbXNnLCBjaGFyICpzdWJfZXJy
X21zZykgew0KPiA+ICsJY2hhciBzdGF0dXNfbXNnWzEyMF07DQo+ID4gKw0KPiA+ICsJaWYgKHN1
Yl9lcnJfbXNnKQ0KPiA+ICsJCXNwcmludGYoc3RhdHVzX21zZywgIiVzLCAlcy4iLCBlcnJfbXNn
LCBzdWJfZXJyX21zZyk7DQo+ID4gKwllbHNlDQo+ID4gKwkJc3ByaW50ZihzdGF0dXNfbXNnLCAi
JXMuIiwgZXJyX21zZyk7DQo+IA0KPiBIbSwgcHJpbnRpbmcgaW4gdGhlIGRvdCwgYW5kIGFzc3Vt
aW5nIHNpemVvZiBlcnJfbXNnICsgc3ViX2VyciA8IDExNiBpcyBhIGJpdA0KPiBzdXJwcmlzaW5n
LiBCdXQgSSBndWVzcyB5b3UgaGF2ZSBhIHJlYXNvbi4uLg0KPiANCj4gTWF5YmUgcGFzcyB0aGVt
IHNlcGFyYXRlbHkgdG8gZXRobmxfbW9kdWxlX2Z3X2ZsYXNoX250ZigpIHRoZW4geW91IGNhbg0K
PiBubGFfcmVzZXJ2ZSgpIHRoZSByaWdodCBhbW91bnQgb2Ygc3BhY2UgYW5kIHNwcmludGYoKSBk
aXJlY3RseSBpbnRvIHRoZSBza2I/DQoNCkkgY2FuIGdldCByaWQgb2YgdGhlIGRvdCBhY3R1YWxs
eSwgd291bGQgaXQgYmUgb2sgbGlrZSB0aGF0Pw0KDQo+IA0KPiA+ICsJZXRobmxfbW9kdWxlX2Z3
X2ZsYXNoX250ZihkZXYsDQo+IEVUSFRPT0xfTU9EVUxFX0ZXX0ZMQVNIX1NUQVRVU19FUlJPUiwN
Cj4gPiArCQkJCSAgc3RhdHVzX21zZywgMCwgMCk7DQo=

