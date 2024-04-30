Return-Path: <linux-kernel+bounces-163548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1D8B6CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B86B1F239E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BD1272D6;
	Tue, 30 Apr 2024 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="db+rGjmJ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7A127B77;
	Tue, 30 Apr 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466251; cv=fail; b=hERsyyQtEh0NUUB16XTl4QnGYV7r2SIpvJjqTJ5/MZkTCxl0qcSmlWgZk6IXLKVOJy+OUIN1/T7TV17FzL+0gxNzwQtWgzCpXjGN38fCPkY90glRgR9FDQD0JCtfqRH+6CGJTfAg4xdNcW0EUkW81Px0Ev2xy4RJvSZtKhX5QJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466251; c=relaxed/simple;
	bh=UjlzGIoREkBEkzNdoJLhKxVWeiZbQH3xpd/ax7ACe/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Gw+uNmTfa3zoxraUwTiVyAZWXlxJYsS4vzUstDhmUpecx0NkUgv5p9taywv88pGk3XIv1frXSTgmvDOe9Jt2iUcm3o605CfxThHWfpc9m6WXAQCq8TjlpKF0OqIZ1HNy1vZlxBtewNqf1sXhRq3YHlCS7yMEhFpgLGFszFACl9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=db+rGjmJ; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrCe7kUIxjN8OiMIfv/ugsWeSgFaK3MBUw/e+ytP5z+cUDfjzI0H7LmaAnuaxMoxkTbv44Ro2C3M9WOrgynnzQMDhr+lrznGpHDrTF9zG2E/erualUJXSl40diTZrmxIiXPKbV44bG80koct/3ir3PWpxYOYbHEojqCu51Ajzfeor1a2oewgm7AMtnr7FuDQUU98DHqCJFSuwZcD3r7ZyxNWpkqRsjlkdYN2MU+XK/11zOHwExPlyZ/yi7cnltIkgGqNDHs1n3wgsT6pjLYPyp56lJRj5G4ctTZ0ZI6FQJ9xOsJVCeEQ1LyIgkZU1PDZz0l/mKVwLijx6vFgI/yzvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc65M1gJYltW12CM0JT3ob4bHCkLeG+ISdOD3LP8hj0=;
 b=ecogX6y0s6nkiXEL3mMWl6tFOAoSFCtgM0WeRceeJmHoAJU6iHWBbNOk9Ijq1Pk27rVY/j+M+p/tOKlEbdwyilW6ZWwvnljDKjMUCFdIpqcJqbZaNDbHZRzfCRjz6xNRtCc4I34O49aV8enC+jMeh/kqnF+z1jv6fFpfU6EhDLRz3FZRB6eTAxhuXzyZcsTLo+SCKIOPkxaD+GjWUUvwVoqVsY3TGfun7GOcGi5guoOg0Jen66gLi3vkqC9o9bj2wBTeEU1TfIUXqj8DDYluDgsM68EEFkk50rM3sRkT8LHWzNeux37U48XX4zWye7kYe/Y5AQmaBdKUWnJOxbqTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc65M1gJYltW12CM0JT3ob4bHCkLeG+ISdOD3LP8hj0=;
 b=db+rGjmJSRUREOZRtbVYo6UVdsMe0f/NFwTTusRsuV+LhRMuuwzVv+KO7WeiZQ0Q0kDbmyHK1a6cljd7/CdMVR8YF6A4NfV5pFFVr6OTkoMBYCb8PVwDWwdAXE05EaJ2HqGTa1q1bUYgQLsw15slZo881JEUpL1LQihzo1ChyPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by GV1PR04MB10241.eurprd04.prod.outlook.com (2603:10a6:150:1a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 08:37:23 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::8589:eb00:ecf3:b4ca%6]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 08:37:23 +0000
Message-ID: <c1580fc5-457d-465b-b533-37bda8c69181@oss.nxp.com>
Date: Tue, 30 Apr 2024 16:43:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] media: v4l2-ctrls: Add average qp control
To: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
 Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <c9fdf07d-f434-430e-bb41-8bc8f6bf1bb8@collabora.com>
 <383b6e30-1266-4db1-9c5d-10db7ab17957@oss.nxp.com>
 <a839b292-6776-4ecb-8d8a-a25e58816787@collabora.com>
Content-Language: en-US
From: ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <a839b292-6776-4ecb-8d8a-a25e58816787@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0008.eurprd03.prod.outlook.com
 (2603:10a6:208:14::21) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|GV1PR04MB10241:EE_
X-MS-Office365-Filtering-Correlation-Id: 06087668-b0f7-44c6-989b-08dc68f0c1a0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE5OdzZib20rUDRoczY1VEhoYVBML0N3ZFNsWUIrM0FvdGpXYytNakNjRkdY?=
 =?utf-8?B?U2VnWVpZYUIvYnd3cGY2UjFJdW5aaVV0WGsvdWFndmdSem1QY05aZ25BZ0dZ?=
 =?utf-8?B?YzNRMU0rejNReW9KbEhuaUJXUCtXcDByRlRQWTZvTFpWSUdhUStjSWRCWGlP?=
 =?utf-8?B?eUFiVmRKL1E3Vkxxdjk0ajhPakk4T3F6TnRSQTF5TGxhalZQNFd0cW53djk0?=
 =?utf-8?B?SkRBc3YxMkpMWlgwVmZ5dVA5aGF6WUR5UjVHMTU2SDBVdE5INUpydFBZK2JK?=
 =?utf-8?B?dFdjd0l1eFlQNUg3UTc3NCt3a0ZEa3Qwb3ROZXlsWDhXVitGNkJuUit2Z1ZP?=
 =?utf-8?B?MmtSUDkwTndLYlhSNG1GdW81SFpJaGRXbyt5RnZOUUtaZEZPTTVtMCtVMXJj?=
 =?utf-8?B?TWpYQ0tBWTBnSFEveHFkcW9hYzJRaXpKLzZ1UVBLeE9SZFdscGg2SnpJTXJ2?=
 =?utf-8?B?MmJsaTlZbUh1VmJZdEhKeWoyd1ZwcmxWZ3JyUDVhak1tdXRNVlIvcFh1bE5u?=
 =?utf-8?B?bHVOR3N4Uk1SWXNJNElrVDE2eXpacHNjVlMxNW9FS1dmdXBQaW9NdFhDemtE?=
 =?utf-8?B?UldtajI1ZTB6NWNUdGloZE5XcnhRMW91dk52cm9EVG5XZm9qUTBFSUZtQlE1?=
 =?utf-8?B?cmVOUmVZR2ZldUZMS000YlMvYTVwTWxOU3VSSy9XTGk5T2VEa2R3SUQzSytr?=
 =?utf-8?B?VUpMMFpsWTQ3TU5XMGRXR0gyZ3EwR09UVnNkSmpicVE2Ryt6Tnl4aDRvTzFG?=
 =?utf-8?B?bDkxUERyd1lZcncybUtYR3o0Tk1kbmkwL1RITWkzOUlscWx1S1BpeWlkVXJP?=
 =?utf-8?B?SERNdjNISityeTk2RjBxNkFPRE5vZzM1WlhCTk5aZDJlcFRHaGxMNjczbk5N?=
 =?utf-8?B?RXpocStrekk1YnZOUStJdXN4NVliVFFzTkZ6U2xVazBrL2RxRjFqTEFqeHN3?=
 =?utf-8?B?SWsrV3dmUG1xdFR6M3A2RWV6UFBTRmhza0RHMHlJSWllUXBkeVJvMDgvSmcw?=
 =?utf-8?B?cTZzQytNcUZ4bVBwL29YNTRQN2xFY1Y0ZTN4OTA3akZPZENOMEQ5UzFOZEJp?=
 =?utf-8?B?ejZudTRURGRMK2FKN1I5Q3ZCT2MzUGR2WVZ6U1ZZVnZnbjZWaFZsOVlzc2pT?=
 =?utf-8?B?RUFpWjZ4NkpEZjdkSTJuZXQ4am9iT3JXclVteFpKZk40RHRqcTk4U3RsOU1p?=
 =?utf-8?B?cW1hbjltUW1mbEhLTzlhRHNNcWRtNCt6bjE2amZpcGtxYnNOS21ndHgzbWpD?=
 =?utf-8?B?MTdZSnZwaldSU0dsNzlHZTBMSnFyMkVQTmxEeTZsQk1KMXJSZzd2VzV4YzRk?=
 =?utf-8?B?eTlIbVFLdkVvQUU0aHUvRVlIcFZlL24zbm9xZkRneDZoU0xWbVpLR3N3WjVa?=
 =?utf-8?B?VFBVbXA0M3NVTnJZN1R6WklQMGJHWU8vZlJmWTRGblRHRmNUYjlyaUx1blNz?=
 =?utf-8?B?ek9oV0k1VDF4cjZvL1ZXdUdwNzFlajdIMlRYM3d0ZytTS2d1S0Mva3VPQmda?=
 =?utf-8?B?Q2I4Zjl5cDdmSEV3TmQ4Q0k5VEdCYUg2MnVIbURLMEFYYkNVRzk2by9JMDl2?=
 =?utf-8?B?blRRWjY0RHNqb2pHODd6dXRTS2swclFlMG10Rk8zakFURWhmRDBGWUoxMm1a?=
 =?utf-8?B?cWc1UE5sT0ZrOGhKaXJtZG1EWmp6SFBiUkQ1NWNqNDdsVUVKcUpFUDQxbm1S?=
 =?utf-8?B?SUFWaG1IMXhRK0g0Z1hMOTJ3SUFLQWdOOGRkZ1NCOXZzOHhBaFd2WGpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzhweTJ1WjZxN3lkakhzdGhNaTcrcXFOZEV5OGRNbUFLa1hBSWNUSzJyZCtS?=
 =?utf-8?B?T3FxOWtmOFplU0V0bGtrUUc5WGhROTBpTWtwNHRqZGNCSkh4dWVSNHlSRHZF?=
 =?utf-8?B?aFF5b01jWGduTzh4QllGK2hVYTh6TFRJVjA2Um9FTnZ6ZlFzYVZXNkE0MVB4?=
 =?utf-8?B?dEhwckV2eHNSb1dYeHNIUS8xTEliWjhZWkd0RTFHM3dUOUw0SlcvbDgzdU1o?=
 =?utf-8?B?ME5BWWdQZ21MS2FDcjlXWFJpano1c3djUmRjSjZyai9USnNvdGcrenEwazd5?=
 =?utf-8?B?MXhWbkJXeDBKQ3FLR1R5a1VwTGV0Z2hET3FuNWxNMGMrcDZFUVhBM3RUOXlJ?=
 =?utf-8?B?WktWQXN4NFFiTTl1YmJwbUJqZ0s1WnFJSWNMbDJVbjhuMUFoWlBxTDRsUENP?=
 =?utf-8?B?MUFoZXRUMi9NOFRQaGMwL2tXM1owLzVtb2RoQlh2UmFOSnJGdWdGSUhtN2RB?=
 =?utf-8?B?bkRkSjVjT3FWRUpoMnpwYzJnd0o4RTJKZFRhbHY4QzBkbVJDbklzVlFtR2o0?=
 =?utf-8?B?SHRHZVZTSUlsVnFUL2F1S0dSWTdiQWJLY2krTDdHUGFkUmVkY2hYTnM1dUVa?=
 =?utf-8?B?UUdYbDM4K042WVdaYWdpUEYyL3pkeFVoOXIyNVNQdTVhZW5GelBsMzRoTXRU?=
 =?utf-8?B?QnF5V3NPeGNxM2trOWx1dzdTNVdoVHdxUEtzaHJGRGdIdkZReWxnTUx6ZHEx?=
 =?utf-8?B?ZVRZN1pNVjkyT091Qi9pQW0rZFRiMWxJMDlURDVZY202QzBqSkUwMUs4dnJE?=
 =?utf-8?B?cXFGTWZLNTVHTWRTdkNNb1dqOTFtU0pHck9Qd2lUY3ViZ2FWSGxhUjREN1c3?=
 =?utf-8?B?QkZmUmJOSVVRK1pTZjJtTUUwdHJUdWxlQ2hiWEVlWVo1SmVWcklqbXU5dnd2?=
 =?utf-8?B?Qm5HQ1Y5ZGVpRXNNOXFZM2N3T1ZCUCtRRnZ2aWlkeGtMcFoxemJzSkwybjRN?=
 =?utf-8?B?blpReFkwRk5wNmtENjBYYjAwUmRQa1pBODhTeDVrQjlTQ0gxMi8yV3dER2I3?=
 =?utf-8?B?T0RNZHNEMUo2QzIrOHozQlN4YlhmM21YWm9ib3dzNHpuNW03SjVnWDRlN1JM?=
 =?utf-8?B?QW93dXBZMGNqY2pBODZsbFJxNUVzT1JGUE9kdFBDaDZxSiszL3g0aENVaU5Z?=
 =?utf-8?B?cUdGMlgySjlIUmt5a01ET3FKNTNZWk1tQTArYktYZ2lhcGxXbjh5NjRySjZM?=
 =?utf-8?B?dmtLUlZvUmUrNUNmbmo4bHMyMk5xNzlLYmViQTlCcWljdS9xT0hRL1pvMFZr?=
 =?utf-8?B?VzVJR2FvK1BKWUpjY1d0Tkg5UFJPVDNyS1YxMXQ2Qk5ieFVKMm41SXdtUFRR?=
 =?utf-8?B?cXZnQjlMRThmeXFBMlhQTFRFUGFWUmlGQWRiMnNCeE9XZjBtS1g0MUZoalcr?=
 =?utf-8?B?Z1cxTkdRdGZuS1VmUFRGL1B0cDRvNTNiMk5Dc2t6WWZ2SWxmdVdJb0JpdWk3?=
 =?utf-8?B?YmlzYklVZVNCdUNpYXdzT1JMVnJzY2tpTXJlN1FkM0dsRm1qVXhmcElqY0F2?=
 =?utf-8?B?YitVMEUzcER0VGVDZjExV253TUpPakRvRDR5SHEyMDhkRmdPTlpOS29kOWc4?=
 =?utf-8?B?aUh0eXZ5L0JaMmdGd1VueFJld2Y2UFRpa0VnSUVuVUxrZDZCUFgrZk10N3k5?=
 =?utf-8?B?bU0yZXhmQmpPclhleFQrVVovd040WldDV0cwMXRYWDYwbHAzL2JlMHgveWZu?=
 =?utf-8?B?a0hHa29wWGtQVmo4OEVUUjkvMi9DNnI0dnRrU1NienllajdONVEvZzJpR09Q?=
 =?utf-8?B?dVhRbUhOUW9nNzBqY1pha0FTWjJWdThsZmdKeUh1Ungvd25sd09jY2x2NnRr?=
 =?utf-8?B?OUY0b0tZTEoraHBXZVRJV1ZFSmhQV0pPQ0pubWlvQmRqd3BZUVhxQmJhZksx?=
 =?utf-8?B?VWZCdWdJSVA3SUpmYmJURTN3ZFI2ZExHbHlITnlFeDh0MFBZd2dnQ203VE1F?=
 =?utf-8?B?bi9jV1UrU1FLNFNzZnNpR2RoeDRmdzl1L3ZYNXJxdkloeWpEVmNoTHkrdWtN?=
 =?utf-8?B?MUpjYktsWDRmNEQwS0ZTUlo4bk9RdFBqcnRDelZqS1NhMUN3S2FUMDkvc2hn?=
 =?utf-8?B?NVB4ZnJXY2hFQkllZmszTWcwbnl0OThIdktNcGEwYndidzdoa1hodFlSN3RI?=
 =?utf-8?Q?uMD4f2uLyANfqP//9vfwhTmHu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06087668-b0f7-44c6-989b-08dc68f0c1a0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:37:23.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp/ErYY9KaHZR5cY0mZ/xTghvyQGSQwo05FFXQHJiWv+sky5MYIR/b4d3wihCWa2qC3BaWWzm++Dv4oPeggJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10241

Hi Andrzej,

> Hi Ming,
> 
> W dniu 30.04.2024 o 04:20, ming qian pisze:
>>
>> Hi Andrzej,
>>
>>> Hi Ming Qian,
>>>
>>> W dniu 25.04.2024 o 08:50, Ming Qian pisze:
>>>> Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
>>>> value of current encoded frame. the value applies to the last dequeued
>>>> capture buffer.
>>>>
>>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>>> ---
>>>> v2
>>>>   - improve document description according Hans's comments
>>>>   - drop volatile flag
>>>>
>>>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
>>>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
>>>>   include/uapi/linux/v4l2-controls.h                        | 2 ++
>>>>   3 files changed, 12 insertions(+)
>>>>
>>>> diff --git 
>>>> a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst 
>>>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> index 2a165ae063fb..7d82ab14b8ba 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -1653,6 +1653,11 @@ enum 
>>>> v4l2_mpeg_video_h264_hierarchical_coding_type -
>>>>       Quantization parameter for a P frame for FWHT. Valid range: 
>>>> from 1
>>>>       to 31.
>>>> +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
>>>> +    This read-only control returns the average QP value of the 
>>>> currently
>>>> +    encoded frame. The value applies to the last dequeued capture 
>>>> buffer
>>>> +    (VIDIOC_DQBUF). Applicable to encoders.
>>>> +
>>>
>>> What is the intended range of the values? And why? Is your intention 
>>> to make it
>>> a hardware-agnostic control or a hardware-specific control?
>>>
>>> Regrds,
>>>
>>> Andrzej
>>>
>>
>> The value range depends on the format,
>> For H264, it's [V4L2_CID_MPEG_VIDEO_H264_MIN_QP, 
>> V4L2_CID_MPEG_VIDEO_H264_MIN_QP],
>> usually this is [0, 51].
>> For HEVC, it's [V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP, 
>> V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP],
>> usually it's from 0 to 51 for 8 bit and from 0 to 63 for 10 bit.
>> For H263 and MPEG4, it may be from 1 to 31.
>> For VPX, it may be from 1 to 128.
>>
>> I think the driver that supports this ctrl can set an appropriate value
>> range based on the format it supports.
>>
>> Users also need to read the value of this ctrl according to the format
>> they set.
> 
> What happens if the user does not set the format or until they set it?
> 
> This looks like a contextual control, where the context is a cross
> product between setting or not setting the format and which particular
> format is actually set.
> 
> I don't want to voice strong opinions about whether this should or
> should not be accepted, but this kind of behavior should definitely
> be documented so that driver writers know how to implement this control.
> Right now reading the documentation in the *.rst file as a driver writer
> I would be puzzled. So, from a driver writer's perspective I'd expect
> these additions to the doc:
> 
> - the range of returned values
> - the expected behavior when format has not been set
> - the expected behavior when no frames have been processed yet (so 
> there's no QP
> to be read back from the hardware)
> 
> Regards,
> 
> Andrzej
> 

The ctrl value only applies to the last dequeued capture buffer. It
requires that the format has been set and the streaming has been
started. Before that, the value is meaningless, and the driver can set a
default value by itself.

I agree that it's better to add the value range description in the
document, but as discussed above, it's not a fixed value, maybe I can
add some description according to format.

Best regards,
Ming

>>
>> Best regards,
>> Ming
>>
>>>>   .. raw:: latex
>>>>       \normalsize
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c 
>>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> index 8696eb1cdd61..1ea52011247a 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> @@ -970,6 +970,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>       case V4L2_CID_MPEG_VIDEO_LTR_COUNT:            return "LTR 
>>>> Count";
>>>>       case V4L2_CID_MPEG_VIDEO_FRAME_LTR_INDEX:        return "Frame 
>>>> LTR Index";
>>>>       case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:        return "Use 
>>>> LTR Frames";
>>>> +    case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:            return "Average 
>>>> QP Value";
>>>>       case V4L2_CID_FWHT_I_FRAME_QP:                return "FWHT 
>>>> I-Frame QP Value";
>>>>       case V4L2_CID_FWHT_P_FRAME_QP:                return "FWHT 
>>>> P-Frame QP Value";
>>>> @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char 
>>>> **name, enum v4l2_ctrl_type *type,
>>>>           *max = 0xffffffffffffLL;
>>>>           *step = 1;
>>>>           break;
>>>> +    case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
>>>> +        *type = V4L2_CTRL_TYPE_INTEGER;
>>>> +        *flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>>> +        break;
>>>>       case V4L2_CID_PIXEL_RATE:
>>>>           *type = V4L2_CTRL_TYPE_INTEGER64;
>>>>           *flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>>> diff --git a/include/uapi/linux/v4l2-controls.h 
>>>> b/include/uapi/linux/v4l2-controls.h
>>>> index 99c3f5e99da7..974fd254e573 100644
>>>> --- a/include/uapi/linux/v4l2-controls.h
>>>> +++ b/include/uapi/linux/v4l2-controls.h
>>>> @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
>>>>       V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
>>>>   };
>>>> +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
>>>> +
>>>>   /*  MPEG-class control IDs specific to the CX2341x driver as 
>>>> defined by V4L2 */
>>>>   #define V4L2_CID_CODEC_CX2341X_BASE (V4L2_CTRL_CLASS_CODEC | 0x1000)
>>>>   #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE 
>>>> (V4L2_CID_CODEC_CX2341X_BASE+0)
>>>
> 

