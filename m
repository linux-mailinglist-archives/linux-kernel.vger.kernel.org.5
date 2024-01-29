Return-Path: <linux-kernel+bounces-42101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6683FC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB1328163E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFA7F515;
	Mon, 29 Jan 2024 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="ZVm6eB1X"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D7EECC;
	Mon, 29 Jan 2024 02:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495973; cv=fail; b=C2ddz78i9Y8Al4eHA18W7LUM2uCU6IxTd+uv/wvtYhZzarr3pC8N6f4N6diV3/IW6b0hSvbJS94ah1BNfHCqjJvKsmE8J6KBWaZd4glOwkU/IBhaI1abEoCnJZrTgJtHUfp94fSIAiUO8rBzHBYb4aG/w0TTHRHR6FzewimJZiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495973; c=relaxed/simple;
	bh=CFrueOyunlSpUfOr1+OrEgSgkaNAo3kqFiMZTEZOG3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QWHPvJDt8PyqimulkUGD0qMeZvMIT/g1NhYIESe3xyloRIiNQmHpLrWyecnByXgN1CrI4T0/HvH9C25st6CflZB0VpgI2EgDRgXF7x38Z7t8Mk9OeatP+nSpAFwU12n4wfk3jepyQDmytRmkyh9jaqsy3/0cbOWlMRLjkAJBkSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=ZVm6eB1X; arc=fail smtp.client-ip=40.107.8.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhS6lrjoQToje8VC6TZ7hjI7wOiiqM+XHMJFeKXqR5ngidi1QodQ0Lo/rv9nzauPxoK/CIyxzUX9uIaHQlFgbnpKKWlk1s+X7apetfE3mtIrszRXxhUkGDtvmk1iVo8FIkQHa47yFf/ewlJvhaKb8wrdJPiAVI/kJmPVGT2PtDY12fbzw/ShRtPIcyAkN+JjL6VxcLE/sZ/M9adZpDoN3XmVqh80JOsrR+SbqGfyrhbk+v35lTg9njTw0UPwxAlctKdcfXXeiJgv0xENlD/id5hEPL9L8pSGehsSEhGu4hqYD1jfroOAfjWmZKvgrkhSfJz29Ol4zS3xiguNrx0qbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyY/fyoUNbYOEuCCAbJNzpOPWL8ai2cwitxECGCKNNU=;
 b=EORkh3eI3cVgYn0ZG4KukKlA20tKujNwbtei+WDHYhzMs/trrhHQLWvzO0K9H/KrY+eabDImDC+5dKmQ/wHUkz1KNhvfqdT9+Q3NZEmW9WM/oQSAoCwa1x3BFM1bHAzuwvclR3cGhldopQArpaXi3m6ROo5LmC4pJiBpRZgo6xNOCu61qgBtc1mXYGT1FdTCeZVUMo4dovyE5Ih7KDAgv1TO9H63HB76tBefo0v2wNJveTs7ZfhM+F2ZeEvoEaZ5ePFkJZPNdPyuIDkMgmNfm3sDz9dEuHWUcyB8V9p4bMR6ndzrcmZw8UsUdUTf5V7fXHLPNv3Q73MDXaPu7R2rNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyY/fyoUNbYOEuCCAbJNzpOPWL8ai2cwitxECGCKNNU=;
 b=ZVm6eB1XiYCTOJiTcBYtUebWnHU+bHmnfXzFC6vfpq0ukFbsNMWwIDVB0rWb1TnkjgvGDPo5IFIkeR4nS5QC14+psQrtHJ9BRJsD/VEy4IuddEEVoFqREQrB2AZh7mDK5z1dLVPam9o1cBypziQodBTQikdZYMc/yNTFUuOfmC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0973.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 02:39:28 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 02:39:28 +0000
Message-ID: <b0a23096-f9a6-4aed-910f-42af621cf343@kunbus.com>
Date: Mon, 29 Jan 2024 03:39:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Fixes and improvements for RS485
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
 u.kleine-koenig@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 cniedermaier@dh-electronics.com, hugo@hugovil.com, m.brock@vanmierlo.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20240105141153.19249-1-l.sanfilippo@kunbus.com>
 <2024012705-railcar-hermit-1d3b@gregkh>
Content-Language: en-US
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <2024012705-railcar-hermit-1d3b@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0973:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b797530-91da-4dd6-73b4-08dc2073835f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EYSH18r2SdO4RoD91pvObA0W37XhxN7H5BP9aHdzYgTUlHZJBE4TXLF0M7//jU7uMo+45RcGfVqW/99iXXPPhV7+zODK6pkmpAqXxt4Ek3alrTavxRo4smCHgz/4ZG5+D5q1dmqciyzw7NvD9mDzGNhwTmhTst7ubk0LcoLHbS9Xd9ywjv3YTclfoy/x5qA3Vw2NdWZpTZ/nQ5eCy6MdBLtBe6vLYq0Jw8SGYdg6eWEzfxujG3TlvwQ2l2u8uVhlh5IYr34ruonFHTEWv+b6A4BBPmxuBqN0w4WGMjAniyJesM01/ZykY8DgTapR/b/OmqozSjOfR9Rfgw+D2S0qCGrZt+3QdF+hlXRpIPWFFxFYbYRqtbQbQxFq4Ej1ty/tHRm/7GLZOXEPTlpHXDUctvd1veiiGM0B1xc1nSA/C06HnPp8esnv2ciH2khodAu7eLsttmMqZZe7AtrLHAaVXHow6kKMPrnTp43wxlkpEpfm08+4mynNMDcBsndJ+XxMDAkHuVtrAUqegAWWRWHBAn8zI7SJlcKTqUhQ/dGah9fmJDHQ93LyLavQFi3GdFWIswGZQgkbuCU+rmbQdCbI8nC8FFt7dqhpJaaWstO62eY53q7ryfNyGmcmmQVbRWgDeL0xx0O2EVM/cJCLyV3mNkLpYaRFmHsUi1TuxBYA8XStI3Aqv17gS7b5GH2HqDhl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39830400003)(396003)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(31696002)(86362001)(66946007)(66556008)(66476007)(6916009)(316002)(36756003)(38100700002)(53546011)(6506007)(52116002)(6512007)(478600001)(6486002)(6666004)(83380400001)(107886003)(2616005)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkFwbmdOV3NFOVQ4Mm9DNW83ajVWb1h0VlFZR0tPT3VZVkxqNWhTZGVmQjlS?=
 =?utf-8?B?WWNWZkVUZjBsNVVIV2pGak80ZHQvRzJEaVVralUrL1VTbDhhUmE2QnNybUJt?=
 =?utf-8?B?Nld0UGw1Z3VLWTE2MlQ4ZGZ3T3JLbEJMazNqbnBaZDNkd0V0ZTNNWitkcTk3?=
 =?utf-8?B?c2tUcXFiTWZDZWJreE5ncUFBMHpreUdZdTJnb3ZSWWxISjlSaEZ4YnJLQThH?=
 =?utf-8?B?TU53bUcwU3FqTVBjblIvL05qR1YvYldkYTUzdXhiSXBJTmJEWkJOM0hycnNE?=
 =?utf-8?B?Qk1lVHI5Wkh4TDBvQkZUNndJK3MvUVBaWmpVbjV4NnZhajZ4YXo0MTFLYnd4?=
 =?utf-8?B?Nk9jeSsvMDZRVVVLV1BaQUVWMUtteUx5dlF1WXQzM1RtaXhCd09uMTllY3gr?=
 =?utf-8?B?bkE0dmFhd0pNam1LQTNvNnFGTmtpeUFxb1FQK21sYkZ6dnFMTk50OC9hWVFG?=
 =?utf-8?B?bWthTnpnVjFQekdqb29wUEJSZmZtTXlPU1A2bGoxWWhBM0N1S0xWSmRjZkdU?=
 =?utf-8?B?U3A4ekc1SURYeTgrUVQrSWlNMHpMY2plOWRNNk9mUTNBR1V6cHdPcDZpanVa?=
 =?utf-8?B?Tzk1UlMrSCtNaWlCcU4wUmRzK2dia0JzMDNnNExqWER0VlI2YmtDVDZkR012?=
 =?utf-8?B?bmFDb0gxWUJDZ1pmc3A3VnNaZGlZam5HbjJTYmR6WnFOL0htUmd4OVNhQzVa?=
 =?utf-8?B?aFlvdC9nMjBkZmJsRXlTWFYxQmRNTkZIemp4Y1IzUVg0OHlMbVVTcjBBem8w?=
 =?utf-8?B?OCtzMmh0cWYxTHFveVBaMnV5eTVaWWtIYVZFelJpeE1relRveXhtVzFyc3dp?=
 =?utf-8?B?d284M3JNbzBtWTZqWmZyQnNITWhObDRvWG9zbWxiWE96Qlc3MzZ6ZE5QU1FI?=
 =?utf-8?B?T0ZHaVRibk9MRStUL2FNdHR1UU54aW8wTEFWTnhqTFhRdlYwMXB6NG90NCt5?=
 =?utf-8?B?QXcrSGlvZFdlWXNCOTQyS2JWSXlKbWNQVlBaLzZvNmw4TC9rQ0MzOUc5VHcw?=
 =?utf-8?B?STlmV24weUNoazYxLzdUUTZrQjZiZ0l6cjFCL3JtZkxLOVZnaHhEa0ZpNjRU?=
 =?utf-8?B?MEl1dXY2L1JjakhjTmZyOEE2eUFTeTV1anRIZ3lwOXJYaHhjejRBMHRnNXVm?=
 =?utf-8?B?VnRGKzV0MnpQeUN0QzdwVE9oWjc4MlVjaWtRMWw0c1Y2NHBJZ01DTVh1ZGlp?=
 =?utf-8?B?Tm0yaXN1TXFXQWc3KzJEcm0ra2tXaVlSdmRmdjBtbklkSmE3VENBSFQzTWtY?=
 =?utf-8?B?ZlZpRitPSXU3aVI4S29qWVlsZVV0MWFPRndzd0xMcC9DM3R0YTFHVnBITkhX?=
 =?utf-8?B?TmxlaFppaXVJcGpsb3dBcTRWcnlGL2R0c3Q0K1hmUFBrdXc4bWZ4UTcrQ2tQ?=
 =?utf-8?B?L0pYL2t5Qkc0SXhrZFFOVGhad2JlTEYxcXMvL2JCSzVmQ0picmVtWFZxU1lZ?=
 =?utf-8?B?QXFZRklkamxRQ0g2Ri9Ec09RU3ErT1liUG4zOGJMZDN4a1JSWHN1cFVQcE9I?=
 =?utf-8?B?dUlOalhtSEtmcHg5T3M2QlJNRkVLRVJQdnY0VTRqcTJFSzFMZ3MvUTJwZEFG?=
 =?utf-8?B?b0VCRUxRZDVydk9HY0FRajZOQTljSEo0MEZnWnVKWXpmRFc0Mk5YeFlKUmt3?=
 =?utf-8?B?WkVKcENpTnBIeEwwRk5YdDIyM05OVDAyMmhnU2JneGtZK1Q0cU1LVzNvR0pJ?=
 =?utf-8?B?MmhIOFcvTHJ1NS9hNncxK1lZS09IWlY1TDNhbWNTODMrZTRvaGNiaEZxQTF1?=
 =?utf-8?B?OENPekFYeC9GQUgrQldMc3VsZFZKVExmWUkxRUpUdE15RVVwbmZ1Zkd2R01J?=
 =?utf-8?B?Wmt3MTlUaU1QNnpLb2c0V0llSWNIVDJma2dXbTRrQkYrVHIyeFFRaHNDOXNU?=
 =?utf-8?B?MVJPckxnNVhKRDd0amt4aUZDMlUvaHBvOUtZOEhGa0JpVDVhSnFsT3hzZGtF?=
 =?utf-8?B?SDdTcHhxZ2EzNzk1eFhrVm82YnpQNWRWd0tQeWRQWWlSS1p6eFhNVmV5dHdK?=
 =?utf-8?B?RHNydEhQK05xZ0phMW9YYWY0WFZyOTZlamgzZDU1NTBudm5Xckc2SE5qcDJq?=
 =?utf-8?B?MDN5TThSRVNIWE5wWWZmS2M0WWFockxVeVNxQmgvbXpZT1E1YWZJRkZhbjQv?=
 =?utf-8?B?VVVpWExib0EySDR2QVkyYkdHVTRLbUh6MzNCSnZRMHp5NHBoMHpsdDA3RTlt?=
 =?utf-8?B?Q2FNZ2lrSHo2dkd1L21kczBtdHVjd25zK0ZXNW5WWXpsUUhNK1dSVjVsVWJs?=
 =?utf-8?B?L1pYYUpIMTFRMUM5MnU2SHFPR0NRPT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b797530-91da-4dd6-73b4-08dc2073835f
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 02:39:27.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C5sNUw57SeHnKuGWW46HEQXfyMcm5mShJkfRmpexlMxk1cK1h8/b0xqS5eGWJpwU8GnmNvqKnWEK9hUrWXYS+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0973

Hi,

On 28.01.24 04:10, Greg KH wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Fri, Jan 05, 2024 at 03:11:46PM +0100, Lino Sanfilippo wrote:
>> The following series includes some fixes and improvements around RS485 in
>> the serial core and UART drivers:
>>
>> Patch 1: serial: Do not hold the port lock when setting rx-during-tx GPIO
>> Patch 2: serial: core: set missing supported flag for RX during TX GPIO
>> Patch 3: serial: core: fix sanitizing check for RTS settings
>> Patch 4: serial: core: make sure RS485 cannot be enabled when it is not
>> supported
>> Patch 5: serial: core, imx: do not set RS485 enabled if it is not supported
>> Patch 6: serial: omap: do not override settings for RS485 support
>> Patch 7: serial: 8250_exar: Set missing rs485_supported flag
>>
>> Changes in v8:
>> - remove wrong setting of SER_RS485_RX_DURING_TX introduced with patch
>>   version 7 (pointed out by Ilpo)
>> - fix commit message as pointed out by Ilpo
> 
> Aren't these already in the tree?  None of them apply, what am I doing
> wrong?
> 
> confused,
> 
> greg k-h


Right, the series is already applied. However patch 1 - 
07c30ea5861f (" serial: Do not hold the port lock when setting rx-during-tx GPIO") -
still contains a flaw which is why I sent a v8 to correct that. I sent it a bit too late
obviously, sorry for that.
You can ignore series v8 and instead I can send a follow up patch that corrects the flaw.

Again, sorry for the confusion.

Regards,
Lino

