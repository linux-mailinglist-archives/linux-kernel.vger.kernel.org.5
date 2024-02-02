Return-Path: <linux-kernel+bounces-49052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B5184654E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222F31F260D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2B9610E;
	Fri,  2 Feb 2024 01:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="Yqxdsr+m"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2090.outbound.protection.outlook.com [40.107.14.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D76BA2C;
	Fri,  2 Feb 2024 01:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836421; cv=fail; b=CGT8MkNgO0recI4mVVYlcJaQX5+lQ3n0EwdoNhH4l4ItAj4Q6bFRSxht/bLhfUxjlnuNNXwV0IFAgD5P3pk471VUWUuv1f7K19PPiEr94cLCQUL5ZTUoFGUSZ8D3DBaY01ocwBztHBeopa9HPsmyIRZs/UhzJGcW3bA2nPynWCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836421; c=relaxed/simple;
	bh=VBX+SOuUgWlKpYfhByyQoZRqxaiTVW+4TpaJtDmVws8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=luY+FX6I8RsbHPAjncdwxzvqlV8bPhwNmd7CMpC9W/GQZbfEsTgd0XN0IB5YvLwNrpDw3CYksxegsNPAe/tWO0fBZO64xL6FXj9+su3cf6cnHOSe0W/fSjgGzZHlsPUH+ttF/xmzJ35JXGonhzAFt7mBiiOtyq3W58BfMtvjZvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com; spf=pass smtp.mailfrom=kunbus.com; dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b=Yqxdsr+m; arc=fail smtp.client-ip=40.107.14.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuS4hJ2nzGXUMKZtNstA9dnWX2ZA3Td9E2cuVPh8MuUGOJMc9P/g3tTbQeq0GWYeChBJWXw/diUQTnpIhUvYPwNHvlnRid+pkZF5EuFjksHUVGGir7K1L+mxeo/rA9hHfrMeYeDQYirf5epYiSKz30XKqNz1GTxUuPgwuMcxh2SqtE8onXMrev2xtAGV5rRB1gTxVOJU+pPfzud3GvnQjyWrIFrgLX6/iwZf3kRYCKWl0VNADy8ikPIGVsGi6azvKg5STVlj68UvlZ9XbljqXBXgUht3qhz+CnstngsOuhuwDLcIHzyh6nDwCYmrGXJRJp/D7+FldVd/pUvDrl4Maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0n89srrSS6YJMGu56vxeqCvBVCKJ3NylhsVVqNgKqk=;
 b=EWvWLIq8tDJ6zwMSZ8OeJMTqjlRE6RmgOdMvQlcnyvFqGUUJtifbxk2cBMuFBsfm5xy6KF13IYcKzHxrItUYBhnMchJRzboyNDNWnRGqNPPXjbhQtQoRcS2hFw0a9Rv72QxOa3ISJU0UoaU/gRJtue9F96pFwgGp2Pn8lJZXoUVLoGxcGmhWnIHL+EToC9lokOUV9jMfttX7Zfp+OosLZB1RaPpbVI+NH2FML+gTXUNOnbc2xKPmtN5/We5rKTT1662j8kdeGRQKqVLD+jyzG7bpKRY1+euSGSX0TEqcH0Mo7LcsvnDGnqojVrouX6YsjOzYgIWdkzz5etYJ6lDSyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0n89srrSS6YJMGu56vxeqCvBVCKJ3NylhsVVqNgKqk=;
 b=Yqxdsr+mlNg1JX5T3G82SF+tZWkdcbvKMTAIBkqPpD6SKW+mLUiJ4VAaANPInAnpYdMycnc6vgHEPdtNtGOkkSCvftDv4ChY4ev+hX92NAt+7ajjTCO5s96ZgV6y6HUgXEam3/oHj2AoBhDs3uvWnl9bSDPOO6lmbxTk7nBNKGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1895.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 01:13:36 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%7]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 01:13:36 +0000
Message-ID: <cc182e56-d0de-4a47-bc0a-d0c830649166@kunbus.com>
Date: Fri, 2 Feb 2024 02:13:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
Content-Language: en-US
To: "Elliott, Robert (Servers)" <elliott@hpe.com>,
 "jarkko@kernel.org" <jarkko@kernel.org>,
 "peterhuewe@gmx.de" <peterhuewe@gmx.de>
Cc: "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
 "p.rosenberger@kunbus.com" <p.rosenberger@kunbus.com>,
 "lukas@wunner.de" <lukas@wunner.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20240201113646.31734-1-l.sanfilippo@kunbus.com>
 <MW5PR84MB184274E28D83DC337B486CEFAB432@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <MW5PR84MB184274E28D83DC337B486CEFAB432@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0352.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::6) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1895:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd100a1-a028-41e0-a756-08dc238c2e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rlvkXIWfq8a1yS9MO+IIxJRuxuo7bMutq3IhYI07VozOFqCL7RpJks1CdWr9UKAPIoBOQfsdzOCArGnOFDNNK0ONakQiUPCVCsV68gRy7h6/BE4BwqEFw/m/DLCHI7yoeDK6+XTfbFb4ELAw7mYeSpd2fsq2cqijejprE6mHs93LtNRRqXCTAf6jWJPTEqZuPvLoX2jT+yqWEKgLbmWb5V3estsYy+R6+bHGsFn13q6kHSdGQTr3LPofczO89sUHhk1mxpFqzK9/N8Fl18B739FCy1d+yBx4GEs0yKGKcqUjLkI42BzrK+glJ0tp/YO/ZDi4ZpxPxA43GP6daUMgLj501Rvv/IjyXn34FR5lI0D4viNfGLg5dCPVQh6qamS6bIc3zWBQbdeS+PwxOiEDwOlfiCH/zP1dquX/9IJpH2yqlSmQsO1/U8TFnAzLzI1sPx3Xf9IULCvwlLd/GG8KwF1rZjFfe2Q9RtX0NLD/TvIeuHeGf4c2nVM0FIgqWpwTAonFa7sj4XjKB8I3J2xu5PorAIZNSuh21iaOuYufu/raJOySM3SJ/cbNFoWEB6BQfdSG8/KfBmdZI+BQcoeKhcvxjTb+5V6Mo5j8/xC9qju/+7cvqTbASYE2Jk4Et1cUfCYRFpGNrY5U3OF1/foBnqAJdegVkClNZ1OnytvX0Z7tOLCS5k1nkOQ5g1uDyS2h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(376002)(366004)(136003)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(6512007)(2616005)(38100700002)(66556008)(5660300002)(8676002)(8936002)(4326008)(478600001)(2906002)(6486002)(6506007)(52116002)(53546011)(6666004)(54906003)(66476007)(66946007)(296002)(316002)(110136005)(31696002)(86362001)(41300700001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDBQYlhXYm5GQ2VQOEpLOW1kVmJHVDlPOVRzczg2VmNFcXJWMVk0bTBMYVlx?=
 =?utf-8?B?SVRjSC96Y29FWlZGYWJqbEV1T0Fva1M4aW84czlGUjB5TVZzVDMzUUpINzVN?=
 =?utf-8?B?MUpIb1Z6RHNvU2FKaGRzUDlLaW90UVJpQUU1V2xrdG9xckVIQnhLbTJPbWJ3?=
 =?utf-8?B?N2p0SjNKc08ydVg0cE9PUVVRcmJWZmQ5dVZveFJMaEFSazR3QWRmc2xwYTdT?=
 =?utf-8?B?TzNZaDFRS3A4ZXRidzI5NnlkcEw2elhMckpzcmNSNEVPeEg1MWNLaklFMDMy?=
 =?utf-8?B?MlhXVGFGWUU4RnpoVFlEMUJGc0crUmtXMEo5SThYSzRLRmRDcmlmM3hDNm9o?=
 =?utf-8?B?UU01bU5LTk15eGV1cDB2SkdRT0VsbGV0R0FFVjRsYVlnNU01bVJhU2xYdXNt?=
 =?utf-8?B?SEpKM2dINUROTHZEbW9mSlJ0VWlDY3EvaFdhQlJhWFZCVlBaM01SbEJrWDVz?=
 =?utf-8?B?ZDVlZkg1TmdzN2crY0c5NjRoM1VWU3RpT3ZvYTN5THc4SzVlR3FlUG1OQ3My?=
 =?utf-8?B?bngwVWhYdjZ5WmxXOGdtbzVGWWF5SS9QdTltYVlwa3RIVG02aFZLR1ZJV1E1?=
 =?utf-8?B?RmszYyt4YzIyci9RL290M3dLaDVJSTNFQS9iSC8rWEc5RUU0QTJ4WjFadW8v?=
 =?utf-8?B?NlBIYS9Ib0QyWEJFanNGcjFVNktCcTJ1WTRQMTFHMW1Cc3krNkJSNk0xUFdI?=
 =?utf-8?B?Qm5KN2JwRkZ3anA0ejVMelBidldxOVB0WFhwNEdVQ0V1bHg0MjhqUkxJRWtL?=
 =?utf-8?B?M0tMamtKZllqRTJpM1N6djM2WXhJSTUxdUZoMzdLMFJMU2V4d2RVZ2lzS0lB?=
 =?utf-8?B?OVFNYXNaaHBxU1Z1Q2ZOTFdrejNYYnU1UTFzdG5tckt1S0ZnOVBPa0ZwdHdS?=
 =?utf-8?B?d2RuZENlQ1F2TG94c2h4N3ZmbEVycnlmaEg3dEMvakM5NjFCV0h2cGVjUGNI?=
 =?utf-8?B?R0RBblpMZGR5MmpKdGJsbll6Z0JyOTJtRG5ieWxqYUxkeHZFaGM5MThDY3ph?=
 =?utf-8?B?eDY1OWdLTmsvNXFDcUtpYWVWWDlxa2pTU1Jrakoxck1rVEsvYXoyZ0UyWUVF?=
 =?utf-8?B?MTF5NGNpNXR1QWFySW5XaHY4WVJKeDNRWWIzakd0ckdKUXpYNXhrUFVrcGlQ?=
 =?utf-8?B?TmJkY3EveTg2UGtHZStuMUQ5SzR6M2NWMmFzNC9uYWpxQ1BKVlA4VVA3MWJB?=
 =?utf-8?B?SWdlNmxKekpwWHJZVEg1aGhQTXBKVWgrdjViQUZ4R1hrZnBKZUJXM1V5dVhW?=
 =?utf-8?B?L0x1NXJUY05vQTdOM1NuSW1RZmN2aTBVVnhiZ3daMk16N1NmU2dTaldpV0tD?=
 =?utf-8?B?bEJOcGRITC9qUWl6dW10WUhVZk1uNDF3REU4REQ2UFF3T0RtNGZQUnlQN1ZF?=
 =?utf-8?B?WThBaUl1T2tDdFc1KzQ3dHZrbU9YTHFnMi9hWmk0QlF4OGxoWXBYaVlrVk5U?=
 =?utf-8?B?UXBrcUlNNit6UDRmbnZGdWxqWGlscHYvbU9INTI1WlRubGl3RVFUVVRNTURE?=
 =?utf-8?B?a2hmNC9OUVFDc1FINEZsVzk4dUdDNmhXQndsdjR1b1BDdnlZVVV3bnl1Qzl2?=
 =?utf-8?B?S1RVTmNObUdYNEhlRC8rcFpLMDA5NExRSXdjQTNHUXMwZ0Q2VEdqNVpnSlRE?=
 =?utf-8?B?UU1VOXFwd1NwUy9zOFRrYjZDeDFEMHFaakZjYTgxczIzdG03WTVoek5oNHJw?=
 =?utf-8?B?cVNvNFBlclhZa25tVm0rZUZwdTkrTTVVL2dGb09oQU5JbS94VHlRQUpicUtV?=
 =?utf-8?B?YUFDTGJJNno1d2RFT24vbXBSZXpMTStMenRtS2p0WmdwVWFqdjlEWStnWHVx?=
 =?utf-8?B?Skw5cFdlWU80MHFBN1JZKzdYS3plS3pVdHNpUkVCVEZPY0s2SnN5VVJ1ZnMv?=
 =?utf-8?B?OEE5WWJsSms5SWdrWU1YcHRaQkhkWUhlYzM5UzR6R3E5bjE4QXp6Y3BXMmRM?=
 =?utf-8?B?N2wvVTlnUE0zZjFTekFrU3ZJYkVCbVgzM05QdkZEenFKR2xncG4vOXMwVmNV?=
 =?utf-8?B?akJ2WEh5c1dtaFEwS29kTjJBQTRyZlUrYlRUMm80UVdKQXp5NU5LNExBME5B?=
 =?utf-8?B?K0I5VVozQjJacnZuN2EyMVRZK1diaEgxOWlDK3AzeVVEQWpjK05EY3BWL2pm?=
 =?utf-8?B?UFQ0S3RpNVM1VnhnSisyVW1HYXZxcHg1d2RiblNveEFCSk9JYS9ESGZYV0ZG?=
 =?utf-8?Q?nQypU6BZ845qPa44Vxy5MfSvvQxMK1F9hsU93klZAiew?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd100a1-a028-41e0-a756-08dc238c2e2a
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 01:13:35.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q6MPaATf72qYqD7QRPtPA1l/+dHPp7kZz5st2dkdqCltxKdsjTCDjX1jPdhl4kYahfkrGIhsRXNrbw/CHT2rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1895


On 01.02.24 17:40, Elliott, Robert (Servers) wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> Sent: Thursday, February 1, 2024 5:37 AM
>> Subject: [PATCH] tpm,tpm_tis: Avoid warning splat at shutdown
>>
>> If interrupts are not activated the work struct 'free_irq_work' is not
>> initialized. This results in a warning splat at module shutdown.
>>
>> Fix this by always initializing the work regardless of whether interrupts
>> are activated or not.
> 
> That's using flush_work(), which just waits for one to complete. Is there
> any case where multiple work entries could be queued, and cancel_work_sync()
> would be necessary?
> 

No. There is only one work struct (namely free_irq_work) and it can only be
queued once at a time (note that schedule_work() does not queue the same work
again if it is already queued).   

> tpm_tis_probe_irq() has a loop calling tpm_tis_probe_irq_single()
> for 3 to 15. Could each of those could trigger an interrupt storm and
> call tpm_tis_revert_interrupts(), which calls schedule_work()?
> 
> 

The iteration stops as soon as there is an interrupt found that "works" (i.e.
as soon as one interrupt fires, see the "irq test" in tpm_tis_send()). If this
irq starts a storm it is handled by the implemented irq storm handling and
deactivated. No other interrupts are activated afterwards. So no,
I do not see that multiple interrupt storms are possible at the same time.

Regards,
Lino




