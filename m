Return-Path: <linux-kernel+bounces-166457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B603D8B9AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FED61F21FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531D18615F;
	Thu,  2 May 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="L8NyYSGN"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2124.outbound.protection.outlook.com [40.107.20.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466885649;
	Thu,  2 May 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714653151; cv=fail; b=oS/2pWZuQFywTsJKIdu/0vFmIuY01jEyjOMpOccNmioIJLBCfUUIWXQ2CTE0dXndWxtYjQYnw+yx9qphHaSb3FWowuLCtUh9Dz/yhTBTfuvChRYvY6eqx0PGcLaFHFEfPXBWumaSFsKGqIgFww1C0QyXi2aVgnROqcsfAm4VjOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714653151; c=relaxed/simple;
	bh=Z1KU5cz9HrxbXwXA4M6ACmYdIP7PW2iGnsahq9ZIy5A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D93cptasOlvYzCN095jbrFTAG8BDVG2OG3yv+uF7+XTtE7dxsbY+rtbsBkai+2O5s0lZL8KcHArTKN7osBo2la639Ratutm/6CucFUlU4S4xkM22BDE0Fgi3LmZFx0hjfCStuP6CXWX8/tmHiUhxEZvdtBleNi+XZ6W1JCb4uv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=L8NyYSGN; arc=fail smtp.client-ip=40.107.20.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDLhspbrMJ81xSYksnk1Fwd5YE6Zkauo+oEu0MzvBzE46le40dbIsEK6Zu1oRl+C1Ygr/pNZ0tI4XHUZR3HRxgNddkX8psMpigi6ecd+iRytopfnCq2xgRCMpqST/ydJ0juEK7RYXoTTuvRi42Vqc5Qaz0WDQ9dsOqqXHhObKIK6YSSGhmlLeAAu8t1g3HcZJU7wLvlTXrvQ5g9T0U4f5YdsolcuMPovfdEC63P2UJeKcqfaKTRXWH/LstvZBYxgoe4V4+Ut53PShHh7uTlsdmkGWJIDUwgF/hKp+xne9pd9AOW/bBxQcfmlgZhbOXnKMrRsA5i3grl9JGUNphkTiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBKqhe1w7Czp4SbSkwED8e2+65CbgvVrXDmxY4WF4NQ=;
 b=i8zY9kCcA3MdTzC796tZxSdadKrdnyEtEHIluSdets3mGgv53ar3bctlCjrFyB+edA9bupM0jJoD4JMqLb9uhTE75cOia5eA0jwV8argcFz8xDS68cAEFzccnplEmBwgVka9FBjm2TjtRS2nS3u8qzo87rHJElrswK1HwshHcxvtYG3yWhxEXSiR/klAV0fVwE6+VLglTdNeDdySfoSSMyJoGoSmhwC8yeokpnwBeJfx1KwIoKR4Yvi2hnSskFOfPVMbP3zs0DWAYbZJRXJXTrLAkhtADSGvJUIEq2+U968za+anuLtw+kuo/Rb9ntjnEqh4HNrHpfLPhkPdUBy8lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBKqhe1w7Czp4SbSkwED8e2+65CbgvVrXDmxY4WF4NQ=;
 b=L8NyYSGNVS8Ac6X7Yg6j3WLr0IAYfHN2JbQ93AZ4FGZ56IrjVM5N30SyuonZjEPXEhTgVKsV2P+9smReIDnEVK6Qt2l73rQFi5Eu4C/v0wN2yVfZ7e3S0WxCInrO5+XdZQrLYLaPQHyKFOFuy3RigoIFeXUa0HrckRGxyAT33Ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 12:32:19 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 12:32:18 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 02 May 2024 14:32:18 +0200
Subject: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
In-Reply-To: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::11) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DBBPR04MB7900:EE_
X-MS-Office365-Filtering-Correlation-Id: aa75f3cf-f20f-4661-61eb-08dc6aa3e835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|52116005|366007|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDRHWEE2VEtWUk5TajdZbVQwYmtsckx3MFBWN2xiVHhicHMxTzVQQjVJcjJp?=
 =?utf-8?B?RXd0WVFLNlNhc1RidUxxK1I3Q3hub2sxVnRYWUdlVERvTWtqaWY3Nlh5cnJj?=
 =?utf-8?B?cHhSY2Z6OW4weEs5bndDSXc5UHR5NXA3K3Y5RHZ4OGoyY0JwL0V6bXUxc1Bp?=
 =?utf-8?B?cHJpUU9CVWZnRWZIR1RKdzBzVm90QVB1UHdzUzMrQTZtUXBYMTc0Zk95dW80?=
 =?utf-8?B?Zm5FOTMxV1JOZnlBNkgyTFh5aFBONzltNnRNYzRyaFlSdGdzUjlDbGxFdlo1?=
 =?utf-8?B?cFR1cThaNXJsbk1UeVk0U3dlU0VRcCtERTFKL2phWnRPd2VaYUdNV2tRalBO?=
 =?utf-8?B?dXhsMHBBTmQ4YzZ6MmI1UHJrZUJyK2ZIUURPam9ib2xVdGVnYmxUSHFqMDht?=
 =?utf-8?B?NzUvcW1FRjhHY1hoT0lrTmxRT0dOVlNjekNPSDFQTnlUTEs3K09PRHlZbCtQ?=
 =?utf-8?B?Z0dONFRhZ3NqYUdtVUJzNlZCb1BUdS8zbVR0VG9IRjZMSnlGTklFVmNVNTRT?=
 =?utf-8?B?aWtTMCtjZXB0MVRoTXhoK0ZNWGszSWQyMDdROENLbndnOEQyc2R4VjFrYjdG?=
 =?utf-8?B?V2VqOURQajhwMzNTcXlXVmp6b1RleDBFKzVXeHZDWWdmbFI4QzVGUUc1bVRZ?=
 =?utf-8?B?dUtOUE9laUZZQ2NNY2VvdGNpOEhIbyt1UHV1cExCV0lSNHp4ZzQ2Z3NIQkEy?=
 =?utf-8?B?MXA4encrUkpHc3BnMU5MNUk4QndZL2pYZWtDSlRrc0VXdHVmU0MxSDFYRzZ0?=
 =?utf-8?B?VUwvY0dtWmljS2NWOENINWp0NU5BVUIzdVVSdFJEbWJtU2VKVm9McFVNcnJi?=
 =?utf-8?B?VTdWc21zT3RqdnIrdm5SZlNWZzV1TGNrTGFCZ21lQjY4TkFaZWJFQ25odlpU?=
 =?utf-8?B?bEJkRVJxL0JHRTlNbUdTNDYrNEhCVkN1NHVtR015WnQ1MUZGalcveXlnNlAx?=
 =?utf-8?B?UmFueW9EZUVmM3lnSFNmU1BNVWlTVzFHNFAva3hHRW9YV1R3VnY1SlBTYmRx?=
 =?utf-8?B?UGtISWhrR2RPOXZIa0ZJQ2Y5TkhsNy84cjZBZkc5Y0d4RmtjMnFtbTRScDdu?=
 =?utf-8?B?TkVlMWVEWm9OKzBMdW8vL2c3NktwV2FHWStRblBPRE5UaFlCNFNMYnZwMFJl?=
 =?utf-8?B?bzdWZllPVm03dTlzbysxN3daV29LaGhicUNidXpNd3N2eGFyNkFPREc5T0tN?=
 =?utf-8?B?TXNJcStBdDA0eTcyRDZYTUVKbjdKVk83QmwyZlVZSWxyNVFTTnBkcUF5TnFp?=
 =?utf-8?B?dFpLRlZFZ2Q1dVJhQ0RreDlod0hWMnZFSGxzZ2xpbm9UbkNHNlRxMkJlNnhn?=
 =?utf-8?B?VWVqRjFNeGh5OXcrbHZ3eXB6enlWYW9HbEZxdkpaSkNsTVBDTkxTbVpoZ1hO?=
 =?utf-8?B?cTJDS1M0RXlCbWVXSTF4NzZ5dFRBaFRsQUpDYXJFWm1GSmkyUW5MVmdiSUNZ?=
 =?utf-8?B?NFdoRXcxcGs1UFlJckZGOC9WUUl2MWE5TGh1RkV0NlR5aEZ1QUw4SzZPZ3VK?=
 =?utf-8?B?VURGWW5VMXN6TWw5em93Rm5YUDBwdmwycEI4YXFYdFFzRzN2SU1BTjVQYXVj?=
 =?utf-8?B?aUh3Uld4cEtsaFpTNjFXejBnak1MZ1dWR3dtK3hSV1o4aEZjR2lXZXpxejZS?=
 =?utf-8?B?QmtOakxEZHZtM3JKMGg3OWwrazBqK1FmUFhWTlc5Z3h2VUxZbUsxRThQbkpX?=
 =?utf-8?B?MDRzeTlydUlBTlMvRlFVWEttY3RGeGx3OTJ1a1lZYXZ0WEdtUk82ZWUraVNQ?=
 =?utf-8?B?UXZxOWl3U3Mwa3lOamlwRTlzak1Gamxpc3YxQXlCMXIwcDYrYktaSmYzdGtQ?=
 =?utf-8?B?YUl5QW00ZHF1T3pMVGtEZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHZvSll6VWdneDdtOHY4dWFKczNnV2RxVElxZHlOdmVTV2VUZG9NbEZPVlFJ?=
 =?utf-8?B?SGwvdUVTaGFTYStlZ1pZeDJCa1BVOHFrN2JESUJkMlRSN3VHbExHUWN5RUZQ?=
 =?utf-8?B?NnVMSkNFVXczZlBLcmZPR3FMN0s3OWl4WHlYY1BLb2FOdFJiS21WUm1NcGQz?=
 =?utf-8?B?ZUpFeXlBd0JYTkRSUW5PaExUSkFMT01WOU5MaVJIZU5kbU1BTXhOY1NJbGVK?=
 =?utf-8?B?czFiUmxyc25kaGhoYktZRHE2YzdDb2xZekZyVDcrWk0xMmthKzlEVlRtOHZk?=
 =?utf-8?B?bU5wSldhVVdUK2M3Y3hvRmF4T3BOTk9Ic2g4azRqenRUeXdmSktCZVJraDZR?=
 =?utf-8?B?RjNvWDlQRktLTnorNmZqallUQlVZUFJTK2NlQzRoRVpnTzBqWng0ODFYcFJh?=
 =?utf-8?B?UEtmUnQ3TUU5WmFIQ3NDVTBoVlZuR1BZWWpPaURmYUxVcWxyTDl1bUhzY21s?=
 =?utf-8?B?MkptWEhEL1pZTlU4RVRoTHN6UmplVXhzdDVhNU9odkE5MnIvTXNwb1JJVzJK?=
 =?utf-8?B?RjJ3a2xRdEI1L2ZTVU5tbXZhOWRHTzRkSTJhWnNOcG12TWxtQXRJenJRZms3?=
 =?utf-8?B?NmF4ZFZTdFYxcDZXMlo5SmQrTm9OVFFZUnNjNjhxSS8rZTBBazJlTXdyMFFw?=
 =?utf-8?B?L0dpUGgxYnloMUlQc0JaNmpiMDV1cnYvMWd2M0FrazFHRlZzWlVYVG42cUg1?=
 =?utf-8?B?QVNtb1pINFRJcXNOakIybG04NTcrU1BkdWVzcS81S1RXODlBR0Z2UkEvdExW?=
 =?utf-8?B?bzljdFk5eUxVdkxwWDN1UW5mKzM0Tzkzb2E2VmxFS2J6REoyNHM3WXYvWS9a?=
 =?utf-8?B?T29EUXE2Vk5QNTFVRm94SW4xbjdWbFBKT21vYjh2d2lDQS9RSGtoUHllTDlK?=
 =?utf-8?B?Y01IRU9pVHdSTnRMNGdPclNSRVRBVXM4SmduNUZiWENQNzRCM3hHUWI5Rzlh?=
 =?utf-8?B?K0hOYlJ6dVBhREFhUmRqYWF3NHNENkxpdk12OHdwT2ovWkdEYmY3RWxTci8w?=
 =?utf-8?B?WWI1UFZTNkM0MlZNYU5XVnNUSjlIUlp2V0FmbmsyZHF5eURqSkJHc3IvTFZn?=
 =?utf-8?B?TitXT3NBdGs2Z1IySmd4bE9abEF5aXQvc0lhK0ZWa0tBd2FRWkpmcFNsTGxM?=
 =?utf-8?B?L1I1OWo2TGdCL1ZqSzRTa1M0N1d6RklXdXdpK2ljNUtHRGlwYzZQZUQ2Mmk3?=
 =?utf-8?B?cjE0cUhXc3d2azJpSTQ3akphSzQyQjMvaFRwTUIxUGlrWG8zeUdNQkFRbTVp?=
 =?utf-8?B?YXZFVTFYaUFKd214ZE1NbnMrbThNV2JpS0s5YUMvNWp0VitBOThjazBMR3lz?=
 =?utf-8?B?djROZURLMXQ5R0U2ZzRLOFUwcnRBOEJXemFQVVE3Z2tqWkhyVzVNY1ZyQ0tW?=
 =?utf-8?B?YzdveVdLRFNjWlBNY0RYSUxYN0E5UDdxYXVPNXMwWkhtQTh1dzJZemt3ZU9I?=
 =?utf-8?B?Qng2UmJCZWdrUjhIM3JOaHQ0L09PUU1MNGcrWkRZa3JPL0Jycit2RjdnYUd2?=
 =?utf-8?B?eDhaV2JpYk91WUV3L1lNY1p5eUJKSkthTVBCL2xWNkwxRXZWd0x1dFB1RWM1?=
 =?utf-8?B?ZEhNemNKeTVmV3FSMUpBUlY3dExUSUVydjJGNXR2WEM0Q0dqbXJTMFNmRVdh?=
 =?utf-8?B?Y3M2cWdDL01ZK1VlNEFaclJWek5zUkI4MzVOWWtKNDJIUDdrQTNjeE5zZGpQ?=
 =?utf-8?B?MUl6clQ0a0V2VEVSM2FDTTBWYkNwRUU0L2ZDYW1pVjRFNlFjSWtadkV5YXRp?=
 =?utf-8?B?YnRXNloxdEZZejZpdjVFVHdQMHJvcVUxNDBXdUpYOFRGWnBoQTJCemtPRzVU?=
 =?utf-8?B?T29mTXRiTUxjZXZJeDF6TDc4Rzkyb0laTlNGVk9MQVN5UzFKaU5uU0VDVkJB?=
 =?utf-8?B?Tng0ZW1IT1NyOXA3bEdKdmRmc0pSNjRDajdlclBCQTN0OFV4Y2Z5TzlLZ1JL?=
 =?utf-8?B?NEdPb1ZZMVdUZ0h1QVRZd3hVNDdKWm5JaE15UDZQc1diUGFTR3owR0U5WUVp?=
 =?utf-8?B?R01oY0FyNHhXNW1La2s0RU54ZWVjQVRrVGM0UGcrSXpRSEhKZGpwZ0pmUmxR?=
 =?utf-8?B?QnUxaklESWRjYzBublFEcU5pUG9LbnlXb2tFelZ2c0RGU25DUElYeDdkaDRF?=
 =?utf-8?Q?apGOAWr3hvG/DbMOMKosbNc4n?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa75f3cf-f20f-4661-61eb-08dc6aa3e835
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 12:32:18.8551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1bqpIPWqcV2ThDS+gGvTfUOT1TWQJKshMppOGE+yjXJUgwpAcMdapBStRXvLlI6wXsrjB5IgduEJ34qJtdlIdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900

Add description for the SolidRun CN9131 SolidWAN, based on CN9130 SoM
with an extra communication  processor on the carrier board.

This board differentiates itself from CN9130 Clearfog by providing
additional SoC native network interfaces and pci buses:
2x 10Gbps SFP+
4x 1Gbps RJ45
1x miniPCI-E
1x m.2 b-key with sata, usb-2.0 and usb-3.0
1x m.2 m-key with pcie and usb-2.0
1x m.2 b-key with pcie, usb-2.0, usb-3.0 and 2x sim slots
1x mpcie with pcie only
2x type-a usb-2.0/3.0

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/marvell/Makefile               |   1 +
 arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts | 643 +++++++++++++++++++++
 2 files changed, 644 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 019f2251d696..16f9d7156d9f 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -30,3 +30,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += ac5x-rd-carrier-cn9131.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-base.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-cf-pro.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += cn9131-cf-solidwan.dtb
diff --git a/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
new file mode 100644
index 000000000000..a63a8961bad0
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/cn9131-cf-solidwan.dts
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Josua Mayer <josua@solid-run.com>
+ *
+ * DTS for SolidRun CN9130 Clearfog Base.
+ *
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+#include "cn9130.dtsi"
+#include "cn9130-sr-som.dtsi"
+
+/*
+ * Instantiate the external CP115
+ */
+
+#define CP11X_NAME		cp1
+#define CP11X_BASE		f4000000
+#define CP11X_PCIEx_MEM_BASE(iface) (0xe2000000 + (iface * 0x1000000))
+#define CP11X_PCIEx_MEM_SIZE(iface) 0xf00000
+#define CP11X_PCIE0_BASE	f4600000
+#define CP11X_PCIE1_BASE	f4620000
+#define CP11X_PCIE2_BASE	f4640000
+
+#include "armada-cp115.dtsi"
+
+#undef CP11X_NAME
+#undef CP11X_BASE
+#undef CP11X_PCIEx_MEM_BASE
+#undef CP11X_PCIEx_MEM_SIZE
+#undef CP11X_PCIE0_BASE
+#undef CP11X_PCIE1_BASE
+#undef CP11X_PCIE2_BASE
+
+/ {
+	model = "SolidRun CN9131 SolidWAN";
+	compatible = "solidrun,cn9131-solidwan",
+		     "solidrun,cn9130-sr-som", "marvell,cn9130";
+
+	aliases {
+		ethernet0 = &cp1_eth1;
+		ethernet1 = &cp1_eth2;
+		ethernet2 = &cp0_eth1;
+		ethernet3 = &cp0_eth2;
+		ethernet4 = &cp0_eth0;
+		ethernet5 = &cp1_eth0;
+		gpio0 = &ap_gpio;
+		gpio1 = &cp0_gpio1;
+		gpio2 = &cp0_gpio2;
+		gpio3 = &cp1_gpio1;
+		gpio4 = &cp1_gpio2;
+		gpio5 = &expander0;
+		i2c0 = &cp0_i2c0;
+		i2c1 = &cp0_i2c1;
+		i2c2 = &cp1_i2c1;
+		mmc0 = &ap_sdhci0;
+		mmc1 = &cp0_sdhci0;
+		rtc0 = &cp0_rtc;
+		rtc1 = &carrier_rtc;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&cp0_led_pins &cp1_led_pins>;
+
+		/* for sfp-1 (J42) */
+		led-sfp1-activity {
+			label = "sfp1:green";
+			gpios = <&cp0_gpio1 7 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* for sfp-1 (J42) */
+		led-sfp1-link {
+			label = "sfp1:yellow";
+			gpios = <&cp0_gpio1 4 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-activity {
+			label = "sfp0:green";
+			gpios = <&cp1_gpio2 22 GPIO_ACTIVE_HIGH>;
+		};
+
+		/* (J28) */
+		led-sfp0-link {
+			label = "sfp0:yellow";
+			gpios = <&cp1_gpio2 23 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	/* Type-A port on J53 */
+	reg_usb_a_vbus0: regulator-usb-a-vbus0 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus0_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-oc-protection-microamp = <1000000>;
+		gpio = <&cp0_gpio1 27 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_usb_a_vbus1: regulator-usb-a-vbus1 {
+		compatible = "regulator-fixed";
+		pinctrl-0 = <&cp0_reg_usb_a_vbus1_pins>;
+		pinctrl-names = "default";
+		regulator-name = "vbus1";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-oc-protection-microamp = <1000000>;
+		gpio = <&cp0_gpio1 28 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	sfp0: sfp-0 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp0_sfp0_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp0_i2c1>;
+		los-gpio = <&cp0_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp0_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp0_gpio1 31 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+
+	sfp1: sfp-1 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cp1_sfp1_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&cp1_i2c1>;
+		los-gpio = <&cp1_gpio2 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&cp1_gpio2 18 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&cp1_gpio2 1 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&cp1_gpio2 17 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <2000>;
+	};
+};
+
+&cp0_ethernet {
+	status = "okay";
+};
+
+/* SRDS #2 - SFP+ 10GE */
+&cp0_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp0_comphy2 0>;
+	sfp = <&sfp0>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp0_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	/* Without mdio phy access rely on sgmii auto-negotiation. */
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #1 - SGMII */
+&cp0_eth2 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp0_phy1>;
+	phys = <&cp0_comphy1 2>;
+};
+
+&cp0_gpio1 {
+	pcie0-0-w-disable-hog {
+		gpio-hog;
+		gpios = <6 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "pcie0.0-w-disable";
+	};
+
+	/* J34 */
+	m2-full-card-power-off-hog {
+		gpio-hog;
+		gpios = <8 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp0_i2c0 {
+	/* assembly option */
+	fan-controller@18 {
+		compatible = "ti,amc6821";
+		reg = <0x18>;
+	};
+
+	expander0: gpio@41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+
+		usb-a-vbus0-ilimit-hog {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus0-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus0-enable-hog {
+			gpio-hog;
+			gpios = <1 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus0-enable";
+		};
+
+		usb-a-vbus1-ilimit-hog {
+			gpio-hog;
+			gpios = <2 GPIO_ACTIVE_LOW>;
+			input;
+			line-name = "vbus1-ilimit";
+		};
+
+		/* duplicate connection, controlled by soc gpio */
+		usb-vbus1-enable-hog {
+			gpio-hog;
+			gpios = <3 GPIO_ACTIVE_HIGH>;
+			input;
+			line-name = "vbus1-enable";
+		};
+	};
+
+	carrier_eeprom: eeprom@52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <8>;
+	};
+
+	/* usb-hub@60 */
+
+	/* assembly option */
+	carrier_rtc: rtc@68 {
+		compatible = "st,m41t83";
+		reg = <0x68>;
+		pinctrl-0 = <&cp1_rtc_pins>;
+		pinctrl-names = "default";
+		interrupt-parent = <&cp1_gpio1>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&cp1_gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&cp0_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp0_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp0_mdio {
+	/*
+	 * SoM + Carrier each have a PHY at address 0.
+	 * Remove the SoM phy node, and skip adding the carrier node.
+	 * SGMII Auto-Negotation is enabled by bootloader for
+	 * autonomous operation without mdio control.
+	 */
+	/delete-node/ ethernet-phy@0;
+
+	/* U17016 */
+	cp0_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - miniPCIe */
+&cp0_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy0 0>;
+	status = "okay";
+};
+
+/* SRDS #5 - M.2 B-Key (J34) */
+&cp0_pcie2 {
+	num-lanes = <1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp0_pinctrl {
+	pinctrl-0 = <&cp0_m2_0_shutdown_pins &cp0_mpcie_rfkill_pins>;
+	pinctrl-names = "default";
+
+	cp0_i2c1_pins: cp0-i2c1-pins {
+		marvell,pins = "mpp35", "mpp36";
+		marvell,function = "i2c1";
+	};
+
+	cp0_led_pins: cp0-led-pins {
+		marvell,pins = "mpp4", "mpp7";
+		marvell,function = "gpio";
+	};
+
+	cp0_m2_0_shutdown_pins: cp0-m2-0-shutdown-pins {
+		marvell,pins = "mpp8";
+		marvell,function = "gpio";
+	};
+
+	cp0_mmc0_pins: cp0-mmc0-pins {
+		marvell,pins = "mpp43", "mpp56", "mpp57", "mpp58",
+			       "mpp59", "mpp60", "mpp61";
+		marvell,function = "sdio";
+	};
+
+	cp0_mpcie_rfkill_pins: cp0-mpcie-rfkill-pins {
+		marvell,pins = "mpp6";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus0_pins: cp0-reg-usb-a-vbus0-pins {
+		marvell,pins = "mpp27";
+		marvell,function = "gpio";
+	};
+
+	cp0_reg_usb_a_vbus1_pins: cp0-reg-usb-a-vbus1-pins {
+		marvell,pins = "mpp28";
+		marvell,function = "gpio";
+	};
+
+	cp0_sfp0_pins: cp0-sfp0-pins {
+		marvell,pins = "mpp31", "mpp32", "mpp33", "mpp34";
+		marvell,function = "gpio";
+	};
+
+	cp0_spi1_cs1_pins: cp0-spi1-cs1-pins {
+		marvell,pins = "mpp12";
+		marvell,function = "spi1";
+	};
+};
+
+/* microSD */
+&cp0_sdhci0 {
+	pinctrl-0 = <&cp0_mmc0_pins>;
+	pinctrl-names = "default";
+	bus-width = <4>;
+	no-1-8-v;
+	status = "okay";
+};
+
+&cp0_spi1 {
+	/* add pin for chip-select 1 */
+	pinctrl-0 = <&cp0_spi1_pins &cp0_spi1_cs1_pins>;
+
+	flash@1 {
+		compatible = "jedec,spi-nor";
+		reg = <1>;
+		/* read command supports max. 50MHz */
+		spi-max-frequency = <50000000>;
+	};
+};
+
+/* USB-2.0 Host to USB-Hub */
+&cp0_usb3_0 {
+	phys = <&cp0_utmi0>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* SRDS #4 - USB-3.0 Host to USB-Hub */
+&cp0_usb3_1 {
+	phys = <&cp0_comphy4 1>, <&cp0_utmi1>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi {
+	status = "okay";
+};
+
+&cp0_utmi1 {
+	status = "disabled";
+};
+
+&cp1_ethernet {
+	status = "okay";
+};
+
+/* SRDS #4 - SFP+ 10GE */
+&cp1_eth0 {
+	managed = "in-band-status";
+	phy-mode = "10gbase-r";
+	phys = <&cp1_comphy4 0>;
+	sfp = <&sfp1>;
+	status = "okay";
+};
+
+/* SRDS #3 - SGMII 1GE */
+&cp1_eth1 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy0>;
+	phys = <&cp0_comphy3 1>;
+	status = "okay";
+};
+
+/* SRDS #5 - SGMII 1GE */
+&cp1_eth2 {
+	managed = "in-band-status";
+	phy-mode = "sgmii";
+	phy = <&cp1_phy1>;
+	phys = <&cp0_comphy5 2>;
+	status = "okay";
+};
+
+&cp1_gpio1 {
+	status = "okay";
+
+	/* J30 */
+	m2-full-card-power-off-hog-0 {
+		gpio-hog;
+		gpios = <29 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+
+	/* J44 */
+	m2-full-card-power-off-hog-1 {
+		gpio-hog;
+		gpios = <30 GPIO_ACTIVE_LOW>;
+		output-low;
+		line-name = "m2-full-card-power-off";
+	};
+};
+
+&cp1_gpio2 {
+	status = "okay";
+};
+
+&cp1_i2c1 {
+	/*
+	 * Routed to SFP.
+	 * Limit to 100kHz for compatibility with SFP modules,
+	 * featuring AT24C01A/02/04 at addresses 0x50/0x51.
+	 */
+	clock-frequency = <100000>;
+	pinctrl-0 = <&cp1_i2c1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&cp1_mdio {
+	pinctrl-0 = <&cp1_mdio_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	cp1_phy0: ethernet-phy@0 {
+		reg = <0>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+
+	cp1_phy1: ethernet-phy@1 {
+		reg = <1>;
+		/*
+		 * Configure LEDs default behaviour:
+		 * - LED[0]: link is 1000Mbps: On (yellow)
+		 * - LED[1]: link/activity: On/blink (green)
+		 * - LED[2]: high impedance (floating)
+		 */
+		marvell,reg-init = <3 16 0xf000 0x0a17>;
+
+		leds {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led@0 {
+				reg = <0>;
+				color = <LED_COLOR_ID_YELLOW>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+
+			led@1 {
+				reg = <1>;
+				color = <LED_COLOR_ID_GREEN>;
+				function = LED_FUNCTION_LAN;
+				default-state = "keep";
+			};
+		};
+	};
+};
+
+/* SRDS #0 - M.2 (J30) */
+&cp1_pcie0 {
+	num-lanes = <1>;
+	phys = <&cp1_comphy0 0>;
+	status = "okay";
+};
+
+&cp1_rtc {
+	status = "disabled";
+};
+
+/* SRDS #1 - SATA on M.2 (J44) */
+&cp1_sata0 {
+	phys = <&cp1_comphy1 0>;
+	status = "okay";
+
+	/* only port 0 is available */
+	/delete-node/ sata-port@1;
+};
+
+&cp1_syscon0 {
+	cp1_pinctrl: pinctrl {
+		compatible = "marvell,cp115-standalone-pinctrl";
+		pinctrl-0 = <&cp1_m2_1_shutdown_pins &cp1_m2_2_shutdown_pins>;
+		pinctrl-names = "default";
+
+		cp1_i2c1_pins: cp0-i2c1-pins {
+			marvell,pins = "mpp35", "mpp36";
+			marvell,function = "i2c1";
+		};
+
+		cp1_led_pins: cp1-led-pins {
+			marvell,pins = "mpp54", "mpp55";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_1_shutdown_pins: cp1-m2-1-shutdown-pins {
+			marvell,pins = "mpp29";
+			marvell,function = "gpio";
+		};
+
+		cp1_m2_2_shutdown_pins: cp1-m2-2-shutdown-pins {
+			marvell,pins = "mpp30";
+			marvell,function = "gpio";
+		};
+
+		cp1_mdio_pins: cp1-mdio-pins {
+			marvell,pins = "mpp37", "mpp38";
+			marvell,function = "ge";
+		};
+
+		cp1_rtc_pins: cp1-rtc-pins {
+			marvell,pins = "mpp12", "mpp13";
+			marvell,function = "gpio";
+		};
+
+		cp1_sfp1_pins: cp1-sfp1-pins {
+			marvell,pins = "mpp33", "mpp34", "mpp49", "mpp50";
+			marvell,function = "gpio";
+		};
+	};
+};
+
+/*
+ * SRDS #2 - USB-3.0 Host to M.2 (J44)
+ * USB-2.0 Host to M.2 (J30)
+ */
+&cp1_usb3_0 {
+	phys = <&cp1_comphy2 0>, <&cp1_utmi0>;
+	phy-names = "comphy", "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+/* USB-2.0 Host to M.2 (J44) */
+&cp1_usb3_1 {
+	phys = <&cp1_utmi1>;
+	phy-names = "utmi";
+	dr_mode = "host";
+	status = "okay";
+};
+
+&cp1_utmi {
+	status = "okay";
+};

-- 
2.35.3


