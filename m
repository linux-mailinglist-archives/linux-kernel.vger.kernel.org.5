Return-Path: <linux-kernel+bounces-59184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3783084F2CB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3673286371
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFE667E80;
	Fri,  9 Feb 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="vImKsyhY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2130.outbound.protection.outlook.com [40.107.21.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CF7664CC;
	Fri,  9 Feb 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472548; cv=fail; b=UKDtBFisSKyYtHSj1z08yA/WpR3NEQ+7ud+jM8LkJqr5JmAiGccUC83WHXMShe2kTEM2UNPr4syOXoSFaTyLjqQfQz9xG2R6ioz2sSUTm8XIFYc/qHqsKMnBpYtCcufvuqFn3AKPSZcCjw7fy5DC0vces5PCg+mxYs/V/fLsMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472548; c=relaxed/simple;
	bh=3yQGCLwFIonXvJgBuAFKRBsKCuGxIBNQcn/+QXlp8YU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QUurLdmyWComkiMskyqeMkWf/RyPjvMEtW7aGg5Azmitt8XXOl/mdcLAblIWdGdDmzxESyfTvDLtQR5fKT95AiSsorUfO5v1RyumP4ZRPJPjdtQccnvb+JGWZFFznmgj8haW5fkZB/NvvpDRUdbQy8Pdj0Kzmb0eSHzSr7rN1/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=vImKsyhY; arc=fail smtp.client-ip=40.107.21.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euYR7cFEdXe6+7YEtEPoPkR7zob5PCkBdsbPiKXI5so6it5hwaDsDV+TaaPKibJkWy4zNMKX/pny0Mjio5IIHhis1Lbu2bd0IIdGmZLeh2iRmKifUHS82tu7x8KCiM7lEiBToFUfGuGIwjbsocxjZD9VS9UPm+WTPnFgwOQf0Wu3U2iEMajYMrXEW9RTEC2T5Xlgl3GD5weNBltoPIpP3nG8M+HyqckgueEZpNNnRwOzhP9MgghHQPv+9dEDC4TthkKKciiMCbNhlX28Z8jkOswIosiTsM6BzPiZY9m48DLirJ1/JH+5OBN9pQX9fGU1MwzBMahzZ+K5q51XU/rtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv0kjk2O6kI/rnTvn2aaW+dT+3choQclYzbCXho3JCg=;
 b=NwQimp5il1ZsaBJZDJ3r6CTdJgykv46OOI96KWKmXaANriyHhOityARAuBD8/r8awEH201fJbd83ACDB2vP/p55Cjsk+Vo3OLYhTYZJT26l248ZzOtfL9yiEaoDFTjAAH3UJDW254dtw0tJEDoc6TkwWx93XJPS6A9QhKSOy+oIf8rT8ghQooq32BghIBHF5TuvlORIiQB0xWdQCUwrORpPgDQfceTEmg60XmrA6WF8vOmFeqni8jmMvOOs42G0azkqxiYXFGJLMdcE9JmvTwpIqx8e8pLgCM8Nd1mJbH3xenx//jg+ihZuD/N7Bq0iDBgEfs+dhF++TXGIwB70FfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv0kjk2O6kI/rnTvn2aaW+dT+3choQclYzbCXho3JCg=;
 b=vImKsyhYqlRxhFy170YCkCOK2GcS1y0IhR8noO+1rE2tjajYnulRtFJep2Hcakh6njaViOlNxtNhhlZW0qshto1lUBhAsRovMlPaTLdKmLnyAoWGDbLoXfcP66kUg3m4KTAKulqwX7v5mOr2b7WcyQK8By4ErMA3qzCTwaUOPQgln2kT4zm7TbPGvbO965RzLAhLMO0UvKDynxRD9ER1KNitIkZ9RwFRFpUdHrymbUE0gQUGAx6yU1py4wet3YDs1nQyeiVvG0HXWu6GgYZw4+d0P1smJU+8w+ymT7Akx1tc+OyRDAAsJJD/G+AQf7tDBtltyvuS5Z9gZTiiGemAsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com (2603:10a6:20b:4e2::11)
 by PR3PR06MB6970.eurprd06.prod.outlook.com (2603:10a6:102:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 09:55:42 +0000
Received: from AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0]) by AS4PR06MB8447.eurprd06.prod.outlook.com
 ([fe80::b5ae:8355:acaf:29e0%4]) with mapi id 15.20.7270.025; Fri, 9 Feb 2024
 09:55:42 +0000
Message-ID: <3fdd409f-25de-4a5e-875a-8b59a1a0c0cc@vaisala.com>
Date: Fri, 9 Feb 2024 11:55:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: core: Make default authorization mode
 configurable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, vesa.jaaskelainen@vaisala.com
References: <20240105114956.30714-1-niko.mauno@vaisala.com>
 <20240105114956.30714-2-niko.mauno@vaisala.com>
 <CAMuHMdUy793gzDVR0jfNnx5TUdJ_2MKH5NPGSgHkytAhArtqmw@mail.gmail.com>
Content-Language: en-US
From: Niko Mauno <niko.mauno@vaisala.com>
In-Reply-To: <CAMuHMdUy793gzDVR0jfNnx5TUdJ_2MKH5NPGSgHkytAhArtqmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::17) To AS4PR06MB8447.eurprd06.prod.outlook.com
 (2603:10a6:20b:4e2::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR06MB8447:EE_|PR3PR06MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: d7ee3309-f6a2-45ab-fe0c-08dc2955473e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UgvkU7vJ3cMzHMiFUL9op7G18ykIhaSeF4s/8v/1xU7LnFo0sPHwhRY9BzvVnH7AJr+APV8mJm8QP+AVchilz8ZSuqS9Ly6BEk0fmD7uLxZiYQ015R3F6ehoPPYDz7oU9CVVhJUNwYEV8cNvg5/4sdo+b+2huztywcR9gcRPlpcA/IHkk0iznnI3MbmVT/VuwTB4bdIU+nqN1KUeQCpZ741fkbSQZLjjvldg/FvwlrDetb9RoeFehvcN+G1T/VV6UxCHM5eU7jx0nseTOuNP0MVKAt7BjgEXETAAYLmrleczViSJrnbOA2g5ExabZG/XELIKt7IENazqDiux3F4QxdWw+aSl6PXIxE8b0Vqtio0AcMS4KBwPUVggWbZgnTV4ULz5cPiIHgN5mCsc6UIPkW5BfGPkzUAegjzA2z73agblDHAKYf195mblqBELzfuSmMjJF920CoN+XYAC2e0nwuox+JvnXffVKBVKqJfrx2qk4CX2Z3c55LLOt803sPQr4EznyHt3jGrzWQpb76MCjPGCFiYIDLS36nVwr/G6et31xEWIP7GhKk4p5w9RJeWy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR06MB8447.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(53546011)(6512007)(6486002)(478600001)(83380400001)(26005)(107886003)(5660300002)(44832011)(2906002)(2616005)(4744005)(66476007)(6916009)(316002)(66556008)(66946007)(8676002)(8936002)(4326008)(36756003)(38100700002)(31696002)(86362001)(41300700001)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHl6VUdKekNLblNzWHl2bkJXVUxsWjFHUk1UMytyaG8xb0J1eDRXMXJDenZo?=
 =?utf-8?B?MDBZM0QwM0ZJck1DeHZDb3h0N3NqSnJuaGNxc01ZR3Eya0dqN2YrbG9XdDg0?=
 =?utf-8?B?MXorSFNDdmhVS3luZHlFc2dNalhwUTRWaHpGSThaWWNEYUl4Yk9sUFZUUVBE?=
 =?utf-8?B?UFhzYTZSZmZLSDlGR2xYN0VMenRJVGY1MklFcXZYM0NNT0FyT3JHcFA0czlW?=
 =?utf-8?B?bDh3cFFJVDRVZStuL0o0dlF0elBEZVBSc3JEQS8zcFozOTJGWVl1aStYNlUy?=
 =?utf-8?B?RXordWhZSzJPMmlveHBNZjE0RDIySmdSZXRXMEpDbjExaDQzaDNsNncvY3lJ?=
 =?utf-8?B?Um8rUlNhZ3JvbVNGVU9QcC9CZHorS3FJTnN3eUdFbXlaZktqUDNLa3liM29M?=
 =?utf-8?B?TjhNNmlNd2FKQnZ0RkowVkdEUTI3VUhjaHJqSXBpbzV0Q1djb2hoTDlBNzAx?=
 =?utf-8?B?bk9EME91Y2wrTGhqblRzcXZ6TnI5YndGdFc0UjgvcThvVVpJcWM4cWQ5ZFUz?=
 =?utf-8?B?K25hc2phdXcwTTE4YW55M2NqM1NtUjg4SkJqL0dpYTd1YjFmZ3JFTk5abW1H?=
 =?utf-8?B?Ris5clhRRjVRcXBabVRac3g1WFlTcFo5R2RWRUE5Tm5mUWdLN3RyY2w0d0cx?=
 =?utf-8?B?T2tIZlE3aFN4eVIzNWZSaHRlc2VKRVpNTVVIcnhvZy8rdm9DWDJMNm0vbms0?=
 =?utf-8?B?VC9OcWc1NGlzc0VUSDZvYkdYaGRCK2R2R2tuRWlMcEVHKzYweVkvOWZVSWZw?=
 =?utf-8?B?UUNISENwb3Y5Z0o4T2djYnU0Qk5zSXQwY05xczRMSG9BNjlLeXk3dG9KNFpN?=
 =?utf-8?B?ekVTN0c1S1FRNW4zT0Q3OGx5dVZva2l6L01mSHVGTTcxaWpKYWU3Mk9RVkgw?=
 =?utf-8?B?U05DWE15M1BudHVueXRnSVUraGpOcVAzcDlhTXNUMUUwNDhlbzRad0xjR2hO?=
 =?utf-8?B?TEZuRXVJTzNlaU5QWjN4c1NlcXZoaEUveG1IaWtneUk2MEtjWGE4S0Z5bVJN?=
 =?utf-8?B?QWMyQmhQUW5oVmEyRy9BRjVUMStHclNxWVJld3lIQktLMk1qVW1SN3hRQVdK?=
 =?utf-8?B?Q2MyMjZhVVhTNDBpRGZLejZZQVcyVWdqMmdRMktvdkdxZS9uT05Ra2pwb0dZ?=
 =?utf-8?B?ZTBrMGpNbE4vay9FT05QeHBrVnp2dGV4T0pKY1puUnY5WUQ3VHpjV29OMEJC?=
 =?utf-8?B?TXpBMWlDTCtFWWRtRHVqbGxwWllqTm9DRTU5dnM2Sm9FYWV0VjZCQzN5d0dz?=
 =?utf-8?B?c0ZYOEJrR0NJSHp2cnZpRnNzZ0VaaHRhQ2RlSTE4dmpNc0hZV1hJYUJlVy9Y?=
 =?utf-8?B?T3RFUm41NThsOFV2aDYzZmE4Vy9ndGoxU1hlZmN0akZwZGFkai9ITGdiclNH?=
 =?utf-8?B?QXZuZVBoemJ6S3AybkRmMzZUeDJMM0Vkc3lpSVRyTVg1S3hDZFMwakQrSWJh?=
 =?utf-8?B?KzNONWU1WVFmME5LSVpYNFAxWTNPUFBWeUZXcjlEb3cyQTZJazRGUGRLNFl3?=
 =?utf-8?B?cVBoSVJMSHR2N2tUYlI3b2k2dU1scnFwaDJqMzdpOCtZMG5tcm43SUppS3dm?=
 =?utf-8?B?cTFHajlSbDNPclowS0JweC91QkJEOEJoMmJ0cWtGRDluVVV5UDc2WGZRL0Yv?=
 =?utf-8?B?NjUySkFOZjFvNmM5NTFFZGpCdm5KNStsL1ZtbnNWSmQyN2p2WXkzV0dsNzlZ?=
 =?utf-8?B?elYxUlVUclJyekYyY0laaWl0MVU1dVRZanpRWTJlaU45OTd6dU03M0ZuTVpN?=
 =?utf-8?B?Q0ErdVYxckVqSFhiVElldWtacE5CRFFMZzFiU0hac2VBcUdKblE0T0ltRWJ4?=
 =?utf-8?B?a2psS1YzWVorNm5tVWlsNEFpYTg4OStlcC9VbWRqcTljbTNLUGRFNUgvZnd1?=
 =?utf-8?B?bGljbW1DWkk5WUdiTXZydEhXSVVKK2pIcVY1dlBVZVA3UmNEUTV6WnFHbWVq?=
 =?utf-8?B?ZTZLWVJKSG1jN2Q1UjlvQ3FUUVdoMHh0eGd2OHQxcHNoazdQSUwzYko4dTNa?=
 =?utf-8?B?NVlVaHY0NjlxTXRmMnF6YWIxNThNN3NYSExTbW9Za2x2TlFPcldTN0Vmbytp?=
 =?utf-8?B?ZDhNRXJRclZ0ZHZpbW05RUxZM0tYM2owdkZ3d0tWcEtTdUZVMUJXSXF5ZDFM?=
 =?utf-8?B?UzVQUk5vZ3QraWQ0RFhZRHN2VWJrM2xMcmxlSmMxcHJEUXNad2lYVlFaNHBD?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ee3309-f6a2-45ab-fe0c-08dc2955473e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR06MB8447.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 09:55:42.5723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewUqsjHHPd7QIYlUmlrCCyPVMXT/A6+HcoQTosijBHWpAk5N2gX1illJO4GwOPCTgEGrgZNpDntBYx01T3hEaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6970

On 6.2.2024 16.33, Geert Uytterhoeven wrote:
> On Fri, Jan 5, 2024 at 12:51 PM <niko.mauno@vaisala.com> wrote:
..
>> +         The available values have the following meanings:
>> +               0 is unauthorized for all devices
>> +               1 is authorized for all devices (default)
>> +               2 is authorized for internal devices
>> +
>> +         If the default value is too permissive but you are unsure which mode
>> +         to use, say 2.
> 
> I'm sorry, but I don't have any clue about what to answer to this question.
> Usually, you are (or are not) authorized to do _something_, but the
> /something/ is not mentioned at all here.
> Can you please make this a bit more clear?
> Thanks!

Thanks, submitted v3 which is hopefully better in this respect.
-Niko

