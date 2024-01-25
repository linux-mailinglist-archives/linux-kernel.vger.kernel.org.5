Return-Path: <linux-kernel+bounces-37854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF3583B694
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B7E1C20FA5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC49317C2;
	Thu, 25 Jan 2024 01:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jEmoUSgX"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC05EA9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706146502; cv=fail; b=sxsCT2bdh5JAOoAbEL17EgxY2iTcZlgoWEAUIforEdlrxWiazyTXml9gmDqwV9njdOK8dHnTs3rQ7gxg8o/DF0nUhoM1RSy1bQnJCRzS3fOY251wrwmXqaKWjeBuEz/0SbmqnAzLLt1mXw6iaOW4M24Rhjf9jglpUJ8fED4D03M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706146502; c=relaxed/simple;
	bh=cSkNDnFUQm6911mLRD/CnJVO6Gm57SPdndxf2mDo118=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=llplrA7O3olTZQrr+AnYfMK0T6gM7d9eSEBbfz7pwDPJSDsD5DTTRMdJV9zZD3ORxncu6sxdKi3vodI/9CFoX31bFtPBLkwvjvkyHVaQbF+YOZ7ceWcx8FL+dgMI34WEXWqeSRbohCLXNTLCzjqHD13fsFkV7trobFo4kU82h00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jEmoUSgX; arc=fail smtp.client-ip=40.107.255.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpmUDeV8pHMCScWG+UG4hOu6ZfUEyudKuYa/6QCunjSuYwT5lOMFe1K8M0vfirZce+NwKVJXoRpjTZ8wNZr0YyBqn5EJif1TPhd7vuLZ0Ma1fnofecntVYD+6AfHC/FRSW0ynWxMpjwBgwAQsS3q5ZiYoj/FTYZtBtoHDUiW+AqutVdM3oVi084dt880/vLFL3cJ/qACRmxvZmcyz08xVIXSfFbTmLEhB28imgZ0UGzW0hTAROjtilYZy+KLIT25aXaq3d8n9fOC5vimb4G55WacEoC3sx3K721AUNQj0QIl120OofkusjlUgqxweV1ys3OHv4dg9kNtdNFI6OCsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf5uuVp5RhHLSBJBkBOFwYjJ2i9RIvaIbRqT/IbOSRc=;
 b=KbwUo1iIMmc/LFrZtyF5mHHy6FRCDYj9sZmKVgn1Pw6bsnlxYmdq7IOcZNHoyNzBAk/CoGVIyltsfvRA1DKxlTRQi0FI5jK2Jsc97W7Uf7fdT6y3wBg23nw1bIKtVqu9mjJDoEqpBt8LfVJbypiRDIN50xW/Eh4dnLtYbeYGwyIRbkmhX8gF6R1T/0m71sUFPg6t907ZQofMGxrdFd4BLinhMa1bzgwJX7CxsWjD6VEpb0tvg/YrP+IhCQA63kvtNn1E/bB9A3uEuTax/BocrFCayKoamuP3RguYkbkhLK03S065/qcK+LgBHFeXWO8E3s3V7l1cTpjBihnwhDJppw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf5uuVp5RhHLSBJBkBOFwYjJ2i9RIvaIbRqT/IbOSRc=;
 b=jEmoUSgXPe+4CPefOGvVORpEgNVaEnIGC9S0EcWcZANAm5rhjMEvz7kMPOZ+Q5pG2FmBt7dIfWdiVzsHG8H/6Y7Qf4/KCP5Bi7yTzkphasyVrPRlXBVtDHumut7P2gqOo4cNq6W27iKIL1ygarqTNiqLZBbmD5Enbwt9r530W3UnRQCQXJvk5eRaBy2u7Z913nV9XE4uQON9LeClrp0A7npOyCmhP8v1AdQqB3Qx6gbuxt1WXwykCdWwiSOKt6qQC1kUuJHIrL+oRcsGG2f3utHqB3HY+zJdUxEvt5ZGfUQcVSYIWKoIQpcQ+jeRz47JYSsA1pEd9Coddlut7NcW0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB4365.apcprd06.prod.outlook.com (2603:1096:400:70::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 01:34:56 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::1be0:ebf0:eb04:6bd3%4]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 01:34:56 +0000
Message-ID: <726d018c-01d0-48b3-870b-c63fb06eb0d0@vivo.com>
Date: Thu, 25 Jan 2024 09:34:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm:vmscan: shrink skip folios in the exiting task
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240124124308.461-1-justinjiang@vivo.com>
 <ZbEOrim8tjMXB5os@casper.infradead.org>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZbEOrim8tjMXB5os@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0218.apcprd06.prod.outlook.com
 (2603:1096:4:68::26) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB4365:EE_
X-MS-Office365-Filtering-Correlation-Id: df6565f2-070d-494c-d207-08dc1d45d635
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BgSvbK+Z4p5l9Vip2FzzCOmq6gzL4oEKnVcAYGawSm0+F9J0XuL1NQPvOT6mk3yRH/OyjhA7iFzeDl55uXDspmbQgyqF+bTR9gbQ+Uc/KamEq/W3lT+QwmPBPj+orOh2i6VRA8umoBd69Nlu6GIjtDdxRqnq2d3bykkvF/EoqkYT/nXsVJoYmakVDMh+Uo/sjzHpbodoEZXZSiPdPQA4gNd+4v/T0MUIPimP7e28j8HzkcGeEzYzLAG92A3Cwwm9wEgfB1Rquu0Vs7hI1DTrgYIPiJ5MK8jiaop75ohZkOmchgByM1mHOMRW6Dvt4vkFa1EsAcLSHU0CNaQi6AGBfFZ32bKF0hKNQgPxvoL79jB10w/avpHb1A0x1Tpu15hMtHjGS47IqKWBR06QAs1ug4TCgbpjddyyrjQq63awBD0hpuRB3n57zf9O16op1EvKkgamTE8LaVKb11Z8jF83kh40MhdJeBDkqjuuaIKY0Nc/VbMFd2+8XidBdY3uJHdafvEVVlmZ3COrC4Kr1q6IFi2zxKh3s6e2mLjLlvMrrB8O+EC8B3IGWGmBgllIheMtv/99XjokLCrvoRpR4TwgkCXEW/zm0t4CeeJqRM7yY2NWnZ3J9L7hDN/5RMY7MrGe3tGNxWCQBlzWpz2d1X5QorvEgZhQjmtVDHUB4jRdrHU7AU9a0hP3odZT6tE8q70A+w7Xdh9YQU/gyB3pAFYjhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39850400004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(31686004)(107886003)(26005)(36756003)(38100700002)(478600001)(38350700005)(6666004)(52116002)(6506007)(6512007)(2616005)(5660300002)(6486002)(66556008)(31696002)(2906002)(66946007)(316002)(86362001)(6916009)(8936002)(4326008)(8676002)(66476007)(43062008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qlc1QlM1MDBId01WZzZBWjlVZXU3dnFzZzRydFEwck14Zno1NHdsdHNhVHI1?=
 =?utf-8?B?QTV2V213VWlsT00xZ3F1SWx5YU5iTnVENEkyODI5YXhoYzdDUHM4cHpBUTNm?=
 =?utf-8?B?OUZvWlRJSkhKMy9QYTg0cTVnUnJMNzFORzN2L3NRMlp4VDFSR1pwU2NIMGVp?=
 =?utf-8?B?Z1lCMEFRNVdJWDlWQzVtRjZNTFdkUzlqdFRjL2hrbHZEeXBWNVUwL1ZQS1pR?=
 =?utf-8?B?Uy9tdkdZbG50Ym0yL2ZHZEw1NXdzckphNTVqUU4zWlg2R0lhaFI3VmFYTmZk?=
 =?utf-8?B?dW5zTUNBazhGeWtWc1dEeERyQXIvVHRwdEpvTitTajltcGtoUGhyVTEwaFM2?=
 =?utf-8?B?Vi81M1hLbDFnL0NWR2V5M0pWeW5jN3dxVW5HL3V2RW0xRXBpQ211WE1DVmlq?=
 =?utf-8?B?Mm1xZldJYXEzTXZ4c0J5a2lkTi95MjlNeitIUTk0QS9NMTNmWjl1NVhmL2h2?=
 =?utf-8?B?SFJhTEc1MjVnY1E1QzRoQXBFaTMzK1VTZlZiSEtwaHE1WDRUYXBTSzhMNjJH?=
 =?utf-8?B?SHNNWDBtT0txcFFiTW9kME5JaWJzcTRGdUxlZjllcU1KWnpodFhrSHlHeFVw?=
 =?utf-8?B?eTBvK3hCYWxIdDAzSjlmRDJuMmpZR0M5UDAwTVNETHVwZ2ovNHRHSVNPa1E1?=
 =?utf-8?B?R2QrS2E0YSsreVlrOXpFLy91WUpIUjFzS1YzaWg2ODNOWkl0WVlYbndOT1R4?=
 =?utf-8?B?QXVVNG5kU2JrR2c0cldOeisrcmtkZjZxNDVITzVpMTN6cG5tYUZ3YjJUYmRE?=
 =?utf-8?B?bnRERE9qb2FTeEtQS1pmcUwycWdmZUFWSUpRV3NsYkdSR2ZFQUlkWnlUY2g5?=
 =?utf-8?B?c05BSWNMcVBYeTloWTNkUVMydHRsS0NpODlhSmFCNzZ2RVFEVTc5ZTZESXh4?=
 =?utf-8?B?Rm1saFExSTc1MXBsQjFWaEtzZ1Z4ZVhMYWZsSmlVN2cyVXMzc0hXdDQrWkVo?=
 =?utf-8?B?UHBLSDcvc2VUb09lcEtzelJVR25aOXIzaUZSMEFOYzl3YkdFWXpDajRKR01O?=
 =?utf-8?B?NWRrQXEzVGxLbmgzblJMd2h2a2RaVTlOTEhTaDdqY0U5Vm9XUHVRcU9SYmFJ?=
 =?utf-8?B?RnZZNmpsczhPUkthNGQxRjkyb2s5UC9XWjNGWWI4eW9ZVmZhUTRwUGRaVHJV?=
 =?utf-8?B?K1FpTDBaM1RaYjA5bWFRYUV6NDVvR3FQQ0hUWUdxelUwNG50VlZqL1BsUzFK?=
 =?utf-8?B?RFdPb0E5UGF1Y2VQMERPSi9hc2k5QndXTlVRelFET2tRUEpUSnN1VnBnNWlj?=
 =?utf-8?B?VUMrZ2FHcnQxTWhXNWZ1UVF1Smh1RENFZlhJcndWU1NZOUNvZld3TXFta1hE?=
 =?utf-8?B?QVYwSXlsSVVDMkQ0MXVad0FnSHdZYVlhZVlZRGJKRjd5cUU0aXFzNWNzd3RL?=
 =?utf-8?B?UXNrMUhYZmRrOUdIeVJuQ0pmdU1BS3piZC9WOWlVRm1rOFZPZlIxVno3L2d6?=
 =?utf-8?B?NFpuYWtxNXgvM29EbmJqOHhGbWNFTlZ5OEtxa2d4L293RER6OHFXSHNSZW0y?=
 =?utf-8?B?NVEyNlN4eGc3SjYxdFNwWmsxNDMwSUNkbjgyaDVJMVFOYkMwUUw1UUhHeDZy?=
 =?utf-8?B?M3dYSGE3UEhCdFFsVFAvcXd0RzZPTVA2cDArQThvcDNXVU1LUEErdXVkRVB3?=
 =?utf-8?B?WDBucFZDQkc4cEtWTzBLbEFKSyt2QjZwZWJOakFUWkthZHVTWVRzdk82cHFy?=
 =?utf-8?B?OE1OTE9KSHhLckxoUCsyS24xaUZWb0VDY3Q3bVR5eUE4K0VKVnNCVkhqTmkz?=
 =?utf-8?B?dkdMa3E2a0hPdi9kbjNFV29ieEZkelRFQW5NQ2t2VFQwK3llOEw5ajdVMGor?=
 =?utf-8?B?RTNRT2FEMjFNUkhsTWswTE5QMXFyaDBIT0NrY3V3bVUxcTVjOTVEbVFtQ1JK?=
 =?utf-8?B?S1dDOE55ejU2TWx4ZVIyZ1NrcE9hY1BKdHN0eFBKeDBHODlDQkxxYjZMb0Yv?=
 =?utf-8?B?ajR6cnJTL0N6VlkrdzFwODREUExyRGZsZ3ZmTnc3UGNHZlVlN2Zwd1NCN1pw?=
 =?utf-8?B?bGhWb2w1NEl4c2N4UUFDbTZ6dEIvVDZBNkMraW14YXdnMmpuNkpvbUtGUE91?=
 =?utf-8?B?cS8yOEZzSFZ5RUlLNUgvcXVKNDFwVEt3T0FJWXFUNVIwQnFoSjVrOGFlYllD?=
 =?utf-8?Q?AIB99jdSzJ8U4py6ZLW5Jq9+j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6565f2-070d-494c-d207-08dc1d45d635
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 01:34:56.4540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce22R8CX0DnJDMlY+RDUtWZB3mLhYccVheWvGwclvJbObUwdkGSxAnj12mfErc2yrdBiv4NAFxnlUrNuzOx+5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4365



在 2024/1/24 21:20, Matthew Wilcox 写道:
> On Wed, Jan 24, 2024 at 08:43:07PM +0800, Zhiguo Jiang wrote:
>> If the shrinking folio is belong to the exiting task, this folio should
>> be freed in the task exit flow rather than being reclaimed in the shrink
>> flow, because the former takes less time.
>>
>> If the folio which is belong to the exiting task is reclaimed in the
>> shrink flow, such as the anon folio, the anon folio needs to be first
>> written to the swap partition by swap-in in shrink flow, and then the
>> corresponding swap folio needs to be released in the task exiting flow.
>> As is well known, releasing a swap folio will task more time than
>> releasing directly an anon folio.
>>
>> In the scenarios of the low memory system and mutil backed-applications,
>> the time-consuming problem caused by shrinking the exiting task's folios
>> will be more severe.
> What testing have you done of this patch?  How often does it happen?
> Are there particular workloads that benefit from this?  (I'm not sure
> what "mutil backed-applications" are?)
1 Yes, this patch has been tested.

2 When the exiting tasks and shrink_inactive_list occur at the same time,
    the folios which shrink_inactive_list reclaims may be the exiting 
tasks's folios
    in lruvecs. And when system is low memory, it more likely to occur, 
because
    more backend applidatuions will be killed.
    The shrink_inactive_list reclaims the exiting tasks's folios in 
lruvecs and
    transforms the exiting tasks's anon folios into swap memory, which leads
    to the increasing load of the current exiting tasks.

3 This patch can alleviate the load of the tasks exiting process. This patch
    can make that the exiting tasks release its anon folios faster 
instead of
    releasing its swap memory from its anon folios swap-in in 
shrink_inactive_list.

4 "mutil backed-applications" means that there are a large number of
     the backend applications in the system.

Thanks
>
> And I do mean specifically of this patch, because to my eyes it
> shouldn't even compile.
Has been tested.


