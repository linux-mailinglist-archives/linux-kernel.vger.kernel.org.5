Return-Path: <linux-kernel+bounces-52110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C29E5849438
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAC01C2275F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B81C8DE;
	Mon,  5 Feb 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MtckPxYJ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2082.outbound.protection.outlook.com [40.107.102.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEFD10A2E;
	Mon,  5 Feb 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707117017; cv=fail; b=Z+U/uDzcdvUTfpduD/7OVU/OoS74nPJjf8MO+MUq8Tk+CeBdfNspXC7h3FqY3w1MmY8U7tCN5ftbe03Y54Si1USkJfBdtuXYxWCUAgRZoM4uB5OrmKJzYjWJR5uZxj5on21zcpBZMs+T27nE28dpZcfob6j6JGSvGpCvMiBmpvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707117017; c=relaxed/simple;
	bh=Zq1YHmyH3GtY4NyozeASZEe8vpWQZeFDp52MNW0opos=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=XNuDdptXhZipe2+HZSQoAH4cKT954uqEQRVEZzai8P3jIG6jberG2VD+uepM5/j5AtzYo4BOvKBNrpYgdRtxNYX1ax/BtGR+WyerFyQQGGmDQ1yGtvtypcYxXnGTrwT/eluPa4DMitNi0/cIp1S+YE68vfrtIrsB/MpRneiBwcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MtckPxYJ; arc=fail smtp.client-ip=40.107.102.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2YMaspjrkJ4y20zDsGIJ3Cp1ETZ2/SzAcY/WU7uQP3MIrD0tSeRlHIsOLziHbMKolOuHGqo07ImAqiAZe5lbdYKoeW9PoWeVEeHk0pOCqponYfZKj75rGwecCUGrAxb6GgiWJCjWgClCu/pYpB6wwwqY30hpZV5cM1KfVoFqgXr0TI05v65EDKNOCGjODRqUaddvWY4pSZQQXzJwGa1ZDFHvy+akYPArB4OzYd+ahbQdz8CUs2gCuaOFR7iyYRuTzyOc/RCTkHGOFH82XWaPV7vzJwj4iWOJZVFt2fNcKElQLmOwx6M92fpwv/rDxEin9sxF4TTMRCXgnXuVH4dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8oaeFUkJMWLJ7wMZGPImGcnywyXHWk3k4xb8cqU6To=;
 b=D6SuJysHFocizK7vOT0JAuHpuKQZxW8bKqQesR/KTSizQZT8SRZmHHbK4dPOzUPrn8ylKjnF1AthKHuwZTL2XzSNuPqVkY/UoK16lxX835yrgeQatKHeAVTVtrvtNYV5egV0TxvRGQX0jYTRYDBLL9ivI8EmqbpKiwXgoGznT3eXcINDTDUdp7SLcbp1ky8ayUPrWo3/ascGRtXmmuiykMPv+xEWI9p36zv3xzMvy1LuzgVXKiSoup8KwxpmKCoKlE8rpoQZF7KfdjuS6M0DSgQ4holYxbb+sVXangBuRmqThSqq/HomBAVXDtEoD1E23BDQhsnpJNydW3gVJUUn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8oaeFUkJMWLJ7wMZGPImGcnywyXHWk3k4xb8cqU6To=;
 b=MtckPxYJcIegdAaqn7ml36U0qnzUqNoMNCxdUxgYVsV53oOwumdBT/ECJi6LrLIM6xr6om+NcpHhgK7I7yjjDQ9le11KgkJP6U4VFZXOqQtuI/H6+WSppclYKUyxus4TefirQLCcEoeRAsrVDiLItK9cLlxuayUKezJf96xzRSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 07:10:11 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::a2e6:c3b5:4e05:825c%4]) with mapi id 15.20.7270.015; Mon, 5 Feb 2024
 07:10:11 +0000
Subject: Re: [PATCH] EDAC/amd64: Add MI300 row retirement support
To: Yazen Ghannam <yazen.ghannam@amd.com>, bp@alien8.de,
 linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com
References: <20240204155106.3110934-1-yazen.ghannam@amd.com>
From: "M K, Muralidhara" <muralimk@amd.com>
Message-ID: <7469b9fe-227a-4ab7-f88d-b399ad1d7941@amd.com>
Date: Mon, 5 Feb 2024 12:40:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240204155106.3110934-1-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::19) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7328dd-4d9b-4ffe-ca59-08dc26197dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JB1HMMzh/lid4GjNYNPAtk/yDz/STmeoCB7Z+OnreTp2AG+hRVWE0X9QsM2UeZC61mUbqQ00+bJRRuQeC6UieAYwTSzNJH5hod++Rztj9VN9+ozsZONRi9JyajdXGiw5FWtxwL2ngVKM+a3exHp6sq7ODhfc86pzQxKuit4KffMNwAtpWlj40JHZQMC86c7fTMn0bSDzaxIEcbygnqoOtSv5JGkD2FmJCY5zeYnnDRG0t2rPzq1bihClIDt7dVl0+g0xO9f4Z7AA3Te5VQX1ZOZIXh4eub93WzFyvqyB/KcquZKduik8Cd0tr1O6UQUrai8fpa/TpCOpO+NmwXE3TqKp4BoadA2E5bh4s6Rj0VWtV2xMcTphd5oVeqBmA9Wmju2DTXy9E7Dh8daDf+zNLIXf5QyviH1PsIEKH37CZTowQRmfJj/wQxz7axQOxB0gXbUFfJdF+bpamfAs1SUEB7Jka+WmjEwcEe6SrRHI56mOLiI+CPxjcOH6zutI9r0qLXnXq6YS3gFWg5Dmo38WjSht626vFYO6tpx9raIWq/LiVbuhDciexERweZPRjyiXZPTmBvPjGWGzO1amqk8BOmyBtBpguV54rQ0NFh5gNJO2P7Dm6lcdeT97IPx1S6bt1hDnaepth+WeL+pTnIQGXg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(6512007)(2616005)(26005)(6506007)(31696002)(478600001)(966005)(53546011)(6486002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(316002)(31686004)(6666004)(38100700002)(36756003)(41300700001)(2906002)(4744005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlaYVJ2Q0tRM0pYbzRDOWVqak1tTSsvbmtNOXBTR3FNdmx1TWN0VkNBUU9h?=
 =?utf-8?B?R0tMaThLbGNVMEJDRGdRMlNYdnNvZ01KbC9pRkExMDlncmJnK0V5NzZtYmFx?=
 =?utf-8?B?OERSWmpYaHBUd3VjMFIxa25oNldZOFdwWG0zVVJpUVNYay9CSlBiWE5iQnVT?=
 =?utf-8?B?T3VKTHpCd3ZEcko0NGt4MFg5TzhrNUhIM1hoUTFKSWZsQVdtUnpPL2lHKzc4?=
 =?utf-8?B?QUJuaGZGQWcxbWxINzdyeENoWFdyeFgrcllmMDgzYUJlWEplcmdydGRGSGRi?=
 =?utf-8?B?ejlodHEraUZRclkvSUh2NDljTTByaC9uZ20vT2tsOVlIYVROYTNwUk51YWlo?=
 =?utf-8?B?amdKeGtaMlVPOGNKR3lsaCswOE9JZk5oZ29qOVpRbjIzUEphd0VNU01IVVZR?=
 =?utf-8?B?blo3NVpVeWx0Y3BjcTBkanhPaFAxVUM3ZXB2Ykxkbk40TC80WVdVWHc0M1BT?=
 =?utf-8?B?UXo0SWY4Tk96eGdTcVJoUlhKelRyZ2VNNm4yaVJjSmR2NHNhWE56YnhGNjdK?=
 =?utf-8?B?R0QrQ29NdEVPSjVlMGhDakMwalc4NWlDZmpLM3pSTWVsZXEzVlA2MGhYdmJD?=
 =?utf-8?B?NHFSczF5NUw4OXczRzMrcGt3cEdoTTh0bndLektXaTMzQW5VK04rZWFybVVX?=
 =?utf-8?B?N2ZUZUs2eGJ2eENaYm44ckJxVStSbGVEY1B1YTdrTmxIQndxN1YzSkVUcm1H?=
 =?utf-8?B?Q0xaQmFlZFVEemt1aEFZcUU3aTNEZzQ1TE9LMzA1bk0valpjcWovRWFURUlZ?=
 =?utf-8?B?Z1d6bjRoNXVDQlZjWmQwcWIzMWhjQW5ici9HelNWV0pUVU1KUFJXQ2pBZkNE?=
 =?utf-8?B?WHFHWW9NWnlxMDNXbWpOOTc0TEZpTUdXUDBMZTkxZndJMi9rOUxOeVh6RGFi?=
 =?utf-8?B?OWp2VkRXOGpwNjUzejNJMzFESnFuTnVsZWlsWjlCRzBTd1RXVFlWdnVmKzh1?=
 =?utf-8?B?bHNuNEJWUG01d1V0Wnk2WWJFcmVENUJzc1QzeUJYdU1mTWFvN0R1UGFreU9n?=
 =?utf-8?B?WGVReitTNm5SeDgwUHlPdG5YdkVLMjIrdFVwbjE2dXdxdHZOTmhVNU5OQXdj?=
 =?utf-8?B?YlBuTktaN3ZzdzZMd0p2NVVZdEFYaHhRSkd1N1ltUDl2dFdrdy8zbXhaQ3Y0?=
 =?utf-8?B?aDhrSUl5SnFEWHBUdWhwUzBEanNyNURnL3R5KzVRc2htOG8vbE1acTJzQ0do?=
 =?utf-8?B?WnhxRGQwSGhNQndXY3lNd1J1eUx5QmtSZ0VIYUdKZ3NGUjMzRS9yZmQ0REVl?=
 =?utf-8?B?MUU1Zi9Vb3A5am8zOGNCTmo1cnl5QTZ3em1ZemxCVEE0LzhtVGtjSUN6bWU4?=
 =?utf-8?B?bU9IMk1xUDMxZDVxT20zaTZwT0xpSXFzTEVmaDRzWitKc2ZjaGJJc0VKb1pv?=
 =?utf-8?B?YmovTkkxL2o3bjFGc1dsbjNKbE5EYnA3Y2VYczNPSCt1TjhtZWJQVzN6aFky?=
 =?utf-8?B?NFZzME5aTmtsbUxibzRnSnRVWWFJRVUra3dULzBOU1BVRmQydkl0ZlZkVzdC?=
 =?utf-8?B?cHh1UVZMTTVoblg1RU0yTnkyalhsblZYWDFKdjFiL1RHcWtwY2lrRjF1L3lk?=
 =?utf-8?B?UkFucUFvczN5Sjh0OFZ5YzFSYjdPN1U3QWhDOGxPWGZSK2F6WDdBTHI2S2Zp?=
 =?utf-8?B?aEMxTVIvV2t6QWdMVTlCdXdqMU5DVUpRaFJ0dktTcmIraTZiWm1EWHZEamJ5?=
 =?utf-8?B?QmRUSFA4YjZ3ZkpCRlI2bjAvYWRwekhzUUJqL253STB5ZzJWUDUyMHhqZjF5?=
 =?utf-8?B?RG5rak1lSzdUVnAwbW16RUt3VVdJY0k3NTRUN1ROL1NxTm8wTzR2UmtKSFNS?=
 =?utf-8?B?TzlqVWEzc3dHMkxvZ3RrV2FRY2dKbGNyZHR3UmVjZE9CdE8wV2xBVlhIRjZj?=
 =?utf-8?B?U3lRVGpvdlBGS3Q4dEcwVEt2NmFOYWJmTk1iRTFVbmVzc1NmT1gweEp6QW1P?=
 =?utf-8?B?R3pxLzE3NE1DYzFRcmVoVzkvMERZT09qTVBVUFppQlZHWmZET0lOcDZIL2t6?=
 =?utf-8?B?TTAzanF1aCtkcWRxV3RGOEdDMGowOHdLbHBENmZrc2o4Sm5OT1VicUh3RWxT?=
 =?utf-8?B?TVpGZkoyWmhvT2w1cy81Z24rVisyb1ljd0d5blFPS1FEWVhUTTY3TDFVTEl3?=
 =?utf-8?Q?gQrM79cDPbrU9ZXa6lEPTCRe0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7328dd-4d9b-4ffe-ca59-08dc26197dce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 07:10:11.0474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ze5OH5xX+vRFToJZ8brIE9XEPOrcB2WCXPfrF2DSQRMKwD+EyTve6YptMAt/zWc0sAYLJsSPk+F1LZzS+QOXew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641



On 2/4/2024 9:21 PM, Yazen Ghannam wrote:
> https://lore.kernel.org/r/20231129073521.2127403-7-muralimk@amd.com
> 
> I'd like to include Murali as co-developer, since this is based on his
> work.

Thanks for the flow. I have tested and row retirement feature is working 
as expected. Please include Co-developed-by:Muralidhara M K 
<muralidhara.mk@amd.com>

