Return-Path: <linux-kernel+bounces-152746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1BD8AC3C4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06A2B21167
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B7918042;
	Mon, 22 Apr 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="OhWQ6OLX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2088.outbound.protection.outlook.com [40.107.105.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0ED10A19;
	Mon, 22 Apr 2024 05:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764161; cv=fail; b=NDh9kElv0dXM5JKGulvrIODQ29aPhq+qkcWYwfZOnOCPq5Cd8kvHzFNi9uLdm6pMnsG6ZvqmZtidAzJhYXrMEEKld53rgIhfEE+OgTV3l7v66fH+U1yYMEQ0B2Gg0RamD4Ddw0V7MW82FQzU8fXpn6//RXaOu0L2K++w+lS7GFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764161; c=relaxed/simple;
	bh=GCAc/R+66sEjARnWNPY0A0AyVoYirdpF392oOmMLgH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l3o0DPdAmX+WjTZ4jcbzX3nKUSSDWvckYH0REcNx81jy75vUHrlWjutEyyriVc5CtWOuBh0PIdK6Nvlc8OUqunR1m+M0rSojQucfpCGpY+jcfxVc3OxaJhnJIZOUHmc3YZV7UT56OiZ8T0WnG9LeifA+U7XXai2IONErztzkTPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=OhWQ6OLX; arc=fail smtp.client-ip=40.107.105.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj1NSrKqMj9tgHd6M78v3/J739oe+tn+Os3Ox/j+SYvFiUZYJ+3VmxoVWhZ7XMYAwKwIML5+M2EAL9lZVkpTCDHpV0jjS8m4TmXWzLZUnNEnCVOCvnm9Pigdtjj6o+HZFsNhN3IamZrS/zb+k+y39P4YUblzVFbvihBpOqxvltaSNmphVTs1oA13OJy//QJWnGWJFJqv1OJPi2iU3mcMvuSg1eYax1kolzFBngLNtdenNhlqoXYJG1u4SCU6/3jGzJ/RQ6Tce+3++eHqKykiJWKeQ00hcl2z9cJd19mWgcnzFhvWkqtXbphCQwyYGKBqjsOQIkxSgeJCsNgrMXoP6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0omA0/jZTjoPDi140ZuizkPtA3M4c1ipJuoYpXuzBg=;
 b=Vb94k2XJvACzXuftK+QPHNFX83G4dJyhyGyp9GNvfwpG79Ryx6q6pWlH67waru6omDS2vkO6wnj+CvD/W/p1StqCuGir8KHluw+EiNckwGeM7SMj7PnR7PWYwCAij9V70CK66UrFs/IQDTtWX7WS5/xKHg0Hi2gBKTa52GNHuTsHAnNEb1+5AnMfxOpODK/QpL7hE5CXZXsxumz8sgQzN6adE22lJBuRMk6IKe3uSC3aRy9aKaFUjVFRPl27gg2EBLSCXupNt0Zelvsn9kxjo5rOAz8Iihe/dyg2jRlvDbhh0drHwxxoFxxAUMYS+lA+bZWtuo7dTuOK6DonhucT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0omA0/jZTjoPDi140ZuizkPtA3M4c1ipJuoYpXuzBg=;
 b=OhWQ6OLXDR3OvroAdhNn9po16UOuo/wpQV+frAOHImqWKntqAwE1pnKdqxWf0d5CqhqRWSYCCma1vsswZSi9lM2Cq6z8unn6vWqyjPHHCyWczHjNt5R3+J94KepevtmsLO7/khbv4FxHG4e3YpXKJ4Z4kEAeg1mtpRABiNzknRwWXupWgliEcU+SekdHWH/1vR2VkOlnLQkzuuOQo2G5xIJcW/tCCdBlptblX8tC8wwHxqe9cV8lTrt6mH1I5STcJ8kFwOKMJVo3hG2hG7D5lv5/FsB7mLeJckvjdh5rbfqoocarkxKId+xDQGe2UA/tNFR2Fw+bTCnv3xc07QALvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5622.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 05:35:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 05:35:55 +0000
Message-ID: <9ed68e05-5761-4dc9-b81c-fc847ec6d043@siemens.com>
Date: Mon, 22 Apr 2024 07:35:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] watchdog: rti-wdt: Provide set_timeout handler to
 make existing userspace happy
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Tero Kristo <t-kristo@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
References: <4d82b8ce-bc34-e4b2-c5fe-9e883b0db59d@siemens.com>
 <20240421084916.GA4208@francesco-nb>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240421084916.GA4208@francesco-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 097874f0-266b-41d8-b06e-08dc628e14f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NytGeWxkVVhLVW5lbTUxWDU2NnYvV1AwN3NkSldDVUFHRzJQUlJ3N2xyRGJS?=
 =?utf-8?B?V2JoMm1FN280aWZNdEFJdzlqbmR2OFo1VG1jaEZuNUUrTmYvVlF5SDhmSkxK?=
 =?utf-8?B?cUlITkplYjRBTW50VUZJM0NVRGNRY0ZIMHRKWEovTVJFOUxLanYrK0ZyZCtJ?=
 =?utf-8?B?dyt6OGJsQTZwd3gxQWFMYlpkRXhZajVzeU5CM0t0M3F0b1piRkJ0UFZMbEc5?=
 =?utf-8?B?M0tuTGZJem85VmE0K3JWVVg0U1oxUEVBcWNwNEZJWlZlUmJPd2hocjI4NEdR?=
 =?utf-8?B?SGUydGROSzFGOWRRSVRXdFFrNjh0K2h4NklzTkdxWnkyNmxKbklXREZxdnRt?=
 =?utf-8?B?MWZ3Q1B3VDhnT1BNS1IxSU5HV1JRRnNxaEJNT0hwY3BleHFpOC82MDRHN2t4?=
 =?utf-8?B?cFdMRmhYMytUcXg5MEVvbnpKMlFhbDFuM0dRcUhIU3FOUkZMTFBOYVlGbWlD?=
 =?utf-8?B?V3FDTzhOMVl2OGd2MitxVjA4a0ZJT2ZYOXhXTkhSQXJLY3hxNlJCbU1mT1NS?=
 =?utf-8?B?bEp0bnFvbHJEVGdPdXp4RmU3b29BbnlQUW5IdjBGM0srUXBaS043ODVHVGJ5?=
 =?utf-8?B?VzNkSUZkeFVLcXhQcnEvVWhRcWw1b2IvLy9JMUxJTG9PWUNXWHp5YlgzL0VS?=
 =?utf-8?B?MUFMczJIUG52TDVCK3Bwd0lRR1BPYmNVNWMzbzU0TmwrZmxyd0tWRituOWtl?=
 =?utf-8?B?VU55ZzRQaTV1SWMrMHIzd1g3SmVRVnl2SzJYaVQrRFhZbENMMk8rRFM3R0Rq?=
 =?utf-8?B?YkxNbkovV3MycmsyT2JaeXk2Y09iQy9PaitZOXRRY0R3NmJTM2xmcENqemx5?=
 =?utf-8?B?TGJpUmtQb1poKzJYa3E0UnhhV2Y4RGtiM21USXhhTFpqcjVsallQOFh5c1E5?=
 =?utf-8?B?RjBkMlRFOVJ6TnRLeUt1RlhXRVdXZVJOOWVTajg4QUlFWGoyZzhkZHZXMmdk?=
 =?utf-8?B?WHliNHBkRzU3LzBsK2M0WnpCNUpTbTJjVlF4aGFhelo0U05hQ1JjMEJPdlV6?=
 =?utf-8?B?RDRuYzdFQUgzTXQrUXZhMC9FdkdmTkJmWkNkVWVLbmdSVVZKN0ZlUHk2aXpE?=
 =?utf-8?B?cElBdkNlTVpLKy9VaVhVQzhUa1dnMWdHbEhzMVBsOGxtdTdsNUNCc25Mb2dR?=
 =?utf-8?B?bGVoNTU1YjlicnhTSjNkOHJBa2NodzdhVFFrS0Vxck9rSkhSRXFDVDVIc2dC?=
 =?utf-8?B?SHFDWkZSMjhsdzFyMThnT05NMFRTUmU3TjFGTysybjU0RmZSK01UVEVpZjNO?=
 =?utf-8?B?aENhNGdpOEpsbmdaeGc5RktnQ2kwcW5kZDJ5OGV6eXZLdkJzcm9JcHN1MzhE?=
 =?utf-8?B?SnlPcSt5YjlPUC90ZTY4N21pbGttSXZ4dGltTVNJVHdZL0FtOWl1alhsTmYv?=
 =?utf-8?B?cU9aamhuQWlOVWdYL1JKZWlBeVhyNHMwL2RQNXFxQ2I3NzEvR3U5YkJlTGpE?=
 =?utf-8?B?VGdnWCtzOE9KcW1ydFJ5dTE3RklUK0dOc3R1RUN5ekR0TUZJcSt4Y3J4Rlpa?=
 =?utf-8?B?UVl3R0x5T3ZWQ3kxZ0RxYklyZXR0T1YzNkNoaTJBY2dYaTMrYWhhN1pWTC9Y?=
 =?utf-8?B?TlV4VXlVV2pVbk56WGlNTkY3RXpUY05ZSnhhYnRIQStYTkFCa1pOcmdwbS9h?=
 =?utf-8?B?M0JjME9LUms5T2FLcCthQlRhYXBFVTFkdTliZkdGVDBzRkxweWMwR25IZzhk?=
 =?utf-8?B?OHR5WVVCbVhLQzBnN0VHa2ljZE12eVJhSS92MFJqTm1DVGpCZ3d6RzFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXdOYVhSbHZCM1NCelZWdmM4WHBaZHRDU3hCcDltTXJFVFRTVExIKzhEV2xv?=
 =?utf-8?B?RWJtM3hoWkVxeEoyL2o0aitRcmsxYVZUZ0hJTUloOVQ4TXk0ODdEQk1mclZz?=
 =?utf-8?B?UG5yc2tyZDJvYVhVSnJ3R04zeHRFdTVzbUlwV1NvbytGNHB5dU5hcUhaZ01o?=
 =?utf-8?B?WWtONytmejBDMUcyNTRtYkhKd2lvOGNaY0xad3NWUG5OUFhNUWJnNEQvY1V5?=
 =?utf-8?B?eWlUOHRreFQzUEZrSzdza1FQYkJLaUJqM05JeS92YjNHbFc1bDQwSU52RDA0?=
 =?utf-8?B?c0h1NVBOaGJzU1UvdmhsNUlKbEZJdzJ3bysrQlRSNEp6L012SUM2MWg3M0lT?=
 =?utf-8?B?ZUljUUQ4Q2VZSFFWK0h6eThVY21UR3dRTi9SbXgxK0lETXp2dzFhN2VRYXFR?=
 =?utf-8?B?T0xkU1BhZG9ydGsvUmxkRTJTK21sb2MxWHJ6WVorL3RUOTVHaGtoVGx4RDFS?=
 =?utf-8?B?K2xxSjZ3ZGFNSklEUXlhYVVwNjR1bFNwUUFWV010NG42ckdUbllCc0JZRWEr?=
 =?utf-8?B?dDZvZjltQ3I3akg0NmkwN0dEeWhjdk5pQVUvZGNHRm5idDFyWjNiY2xGSHFL?=
 =?utf-8?B?emVtQnNEWDh2a2ZEV05nMnhQQnhqd1lBZ0NLbWxXNlUzS1BoL3JxaGJXMUFT?=
 =?utf-8?B?c2RyL1hEZ3Yrb29LSjVkZnpKUXM5d3Q2a3RFNEU3UHVRTnFybUNGWmxFRmxN?=
 =?utf-8?B?aDB1MXNaQmNReHN0S0NyaVpDazZjaG1vcExDcE40cU1ONEZwU1ZGNEt3R2Y4?=
 =?utf-8?B?bkhLaDhZc3RjdlZsdlNCci92WTRDaTIyL0FHSXNTWHByVEFWalJYdGloZXJn?=
 =?utf-8?B?RXdmV3p4amgzZmZSQVJnbWh1bHBHcUhrWDFURXljcHBHTkk5NEI0Q0RrRE9l?=
 =?utf-8?B?WGVSbHUyRi9ncXNJSEJrSFdQN1QwMlgzcHc1dit3VUgzUFR3cTIzbG9KZTRT?=
 =?utf-8?B?RzhDZlp4MFJRVWdPdUJ6bjR1blRFR0ZyRHlNVzEyQytacC9zcHlJUWllejFR?=
 =?utf-8?B?VUxsa1N1VWlHQnJaeEpRN2ZwL0VreWdaWmlRTkkxQ0w0TUNLVExRdkd5UnZT?=
 =?utf-8?B?aTJQM1BTYkxmT0ZMOFI2ckNWSE5Bb2lYcGtEUWxrdUhNNC9NMG03aTE4MXpM?=
 =?utf-8?B?SnN2cmdsM0ZLZitjck9vVHVabE5OaGtCaE5kWGhmQnVER2FTRDYrQVRYVjcr?=
 =?utf-8?B?TVRmOW5FeEpNdVAzOHFvbmE0WExHNGUvNUxFSGRrbXhjazV4RzZMSHRUcjZx?=
 =?utf-8?B?eEdFczZKVFhlaS80YU9ibHJ0RGorU3I3dXJrR2o4Z240YmVBY1JnaFMvMXoy?=
 =?utf-8?B?cWIyejVLT0ZFdmJyWnRTak81YWdOMDcyeHdmNytKY1dvVFhrNlRTRTJNSHdJ?=
 =?utf-8?B?cUZZdXVEc1R2S0hVU2JCNGJUMXFPdGxWU2NWUHBtZ2g3WjNkQ1YvUWhIb0Jm?=
 =?utf-8?B?RkRSMEdFRXFjY1VyTkpjUlRIRHVMTjJNd0hBb0c2QTE4VW9UdTk0MjBwdmow?=
 =?utf-8?B?SDJNNEZrNHFYNTRhU3BRWHVraHpIbFFYRnArNHVYbVlleUtTQlVMYmdHK1Mx?=
 =?utf-8?B?aGtaczNIRzBGaGZwSlRMcnJ6ekhSUHFRdHplZjNENTZ3cEdQdlNOUVZvYVE2?=
 =?utf-8?B?M3QzMXdFT2tiUEhLOTFQUDBIVk1BS0FsTElCWW1WRVZZcisyZWVBVkhrNHEy?=
 =?utf-8?B?Mm9pOGhuc1hWTFh4NjcrbFBMTVM0OGZ5TUhCbFRDdGMzR3ZMVmFwMUxLZE1w?=
 =?utf-8?B?TktSZDh1UXdBWWNCcGMwOWd0dWRuY1I0N2hlZTgyZXM1WEhaKzZRdWwyWWNv?=
 =?utf-8?B?L0svcFhnUmNBQVhWdWdTM25JbGxqYjlabmFscGM5OHFYOStTcmthQit6M3Bj?=
 =?utf-8?B?aUFBckJxSGNJOXhKNlp2WTltQnBvK01KWXhhNWRwbU9sdUNTQ09UeGltSko1?=
 =?utf-8?B?SWdtbVM2dk0zNnNPVDhIMEFaNHBzR1krQzlXbUt0Mis3M3NNbGUyN3hYcWhz?=
 =?utf-8?B?b0FaMWRIS0N3ME1xeHR0WnZXM0ZYUXR5UmFRU1dXanpaK2o2R2JFN1dxRkhD?=
 =?utf-8?B?NjJwVHBpbzRmV1loeEJIWEdDYmhHSFJYQjZqZDRHM1VmZXpzQWczMG9NRmhw?=
 =?utf-8?Q?viB/SjsZPDO3/VVfFVM5FupLo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097874f0-266b-41d8-b06e-08dc628e14f0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 05:35:55.7130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83KyX2aKbwXigVHUJUFOdWaoIx1FV2g+CvC7Ihc+gA7tSnzYsqdNzkqpd7Aj6iqgfSX788FyipIQ+fXLzUy9sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5622

On 21.04.24 10:49, Francesco Dolcini wrote:
> Hello Jan,
> 
> On Mon, Sep 13, 2021 at 01:41:43PM +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Prominent userspace - systemd - cannot handle watchdogs without
>> WDIOF_SETTIMEOUT, even if it was configured to the same time as the
>> driver selected or was used by firmware to start the watchdog. To avoid
>> failing in this case, implement a handler that only fails if a deviating
>> set_timeout is requested.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Are you aware of this patch https://lore.kernel.org/all/20240417205700.3947408-1-jm@ti.com/ ?
> 

Thanks for the heads-up, we will surely try to test things on our setups
as well. But commenting on this dead and not directly related thread may
have caused some confusion...

Jan

-- 
Siemens AG, Technology
Linux Expert Center


