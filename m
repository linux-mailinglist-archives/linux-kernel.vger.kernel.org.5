Return-Path: <linux-kernel+bounces-57620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E098F84DB76
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9782E28BE62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D76A34C;
	Thu,  8 Feb 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cLyh53zB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3E6A350;
	Thu,  8 Feb 2024 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381064; cv=fail; b=OfzmBCZUL1Mt214zuTfwtm6mHIqUi9qoCDqGNmwm7ukWqLqoHZi7qf5FzYbcMPsiFGjssSN/Ml0ya94d/LvERyTFe8sHz7dNrBDdGuz6xUp4+XREpguOrlVCNWqocUZamIOh1ONpzEN8pHlBPfWHLhnHjHTpqeQO+mz3sBl7j2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381064; c=relaxed/simple;
	bh=zS/0q78ibp7k2aPZKI8Wz8vX51KHjb4LmNTZFGJ0r+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rI21nITG1Wf4wbUfVqjje6Hubkax262h7b2xNIFjzyW2PbYf6tIPEIyeIz24hKoavvynNrXetq5C3Lm1wHpFriuR6mj06e682QaJp9dfwXz0x0Y+FE6smyF22/JpS6+cTcApqgz7nvHU2IkLb2n2jOYtHWN1sk2AkZEykbSOpoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cLyh53zB; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAY1D0PbWOn8RTsXhDnb/HwY//VliG1zuibnM55IECgpptiO6uZq9cruTX//UKrn395gtZ1d5tAkjgpZ1BOtz/wfjvl0jOHz9GjfSE+1tkKgKP6FyvidOtsY46RK1SAyLgZ2xaebUMkLMVGEo/bsCS7pEfX2i+bY35Gni8fonxFXOYsijgfpKHV3CmfCD+sMLh53zYWJ0jWmgGla2CPV9wmuz2Tm8/7rFp66xCYxUhhqBNE0KeQSaXTButWY1PCGhaqSoKfasNIvjyB1T0re/NcCIx+SvAfsmWNpIVvLvzc5UJmPeFYt/qAAGjcYtu9Dp4zmGXVuJBV6QcGjIsg/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDApHOrdskyAPIovvPjibk9EHl72RmLXXhtWnnMho+Q=;
 b=QcGKsn7lFyvvFDGWoCCUFRiYk4kpbIQtVC0NgG0sKBVUSaNH986OkiPSNJpIFKDkSLAIgfqrYEwhdJH6tQKk0+cnA35oJ4UJ4Non9OXOegPoZmi7RfllVGVMps2Op011QEIvdXY4lp8om7UvSL7R8IExa0nCi5RVwQvaILX6o1K9BXHoSAyptcVcfNnVzt/VzkuzyT83wFteUO7cOk3RE1EyKdVUNw1zFVti8zFW9bqYY0lRQppDQHQ1vJT65/7QP10En/Mlpt6xMMErrFbaFQdAMoll70R5Q2kT7Ss8bYd09TYaa0hNd/PQMN1gyAi7LXpdgBHNG/oez62A87hkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDApHOrdskyAPIovvPjibk9EHl72RmLXXhtWnnMho+Q=;
 b=cLyh53zBKfrUF78LRlAgYrsHcyXvx3UZ8Il47UARMiddexxdCljtjqbEHQ5WaLcEXpMva310AXjSE7oV/oVHFGrzf1CzfeuV2coA/QIFdKdH5TQwPo8QfHH5pq6AQPmlex9M5ZD/3OLnuRHhJuh24YusThhzh6rt9RPybgnVTUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 08:31:00 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::f16c:d6e8:91e8:f856%7]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 08:31:00 +0000
Message-ID: <ce7150b7-b6f1-4635-ba5f-fdfda84a6e2f@amd.com>
Date: Thu, 8 Feb 2024 14:00:46 +0530
User-Agent: Mozilla Thunderbird
Subject: linux-next20240208: tg3 driver nw interfaces not getting configured
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, hkallweit1@gmail.com,
 andrew@lunn.ch, Jakub Kicinski <kuba@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20240208155740.24c6ada7@canb.auug.org.au>
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20240208155740.24c6ada7@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::28) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 679115ae-64c3-4a94-3ad9-08dc28804775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kytwXs3gEdRssRQ6XWTdwHYyQ1mDsolq3sUTy18NkvwjbisWaZ9jI3fJ3kz+uJlpru5Nv+a4SKXalrrXv5EO8u+Upd9zSmPF3GWLj6bAYeD7AJKN1/fng0AWJdJx8WzAyZo7cgTeIdJExQnKAyTz8nXl2H4DII0jmNX0D+OhUJZtgMbr3ZST4+XHBbGDRUrkTQKgCFGi5jR1lxD+CgoKDaCA8yf65so+/yyC2gTm8Jir7a026HU+pdW8J/LMNSEau74D+E+Cod6ane+Ka8tah/tiKlhUZU50kXnydH4TDGMQBPpiDv86iGtiTDcI67K3foYoXP5CjIss1Qcid1M2x5kn+Q20Hp8pDQZvqh4Sjown0kbob3M3lwCJTXwN69Cb7ADxU0ozjVrO6J3vf5xonrvHDHqrbPbbQkdN9OfAxZ7eUeWZPA4JYb09YMnZ9541r3MRFeCX/2qD2gwLjtMDKEQKZiN6mHl5JsPxtp0pVMZVrY1Gl4kmwIcL2Jw3TP3gR3bLnZVeYFMj+jSnXNSWIb1cV5E+QeB47MNDSbUy3AA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(41300700001)(4326008)(478600001)(6506007)(2616005)(26005)(66946007)(966005)(54906003)(6666004)(38100700002)(31696002)(6512007)(8676002)(110136005)(316002)(2906002)(66556008)(31686004)(5660300002)(66476007)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZadDgvMGNHQzNXOEdtTGxqU1liN1Y0NjM4cFBycHlpb2lENCsyNFFWRGtt?=
 =?utf-8?B?Vm9BSFlUNXZQYS83cSthY1d3b1gwd0tkaDBRb29XVFA2YkMrbktQMms0SG9a?=
 =?utf-8?B?eW5sVlNEWW1JSlI0dm9JSXErS25SRlVIdDA4ZEVNbXE1TDQyVUh0T3BLenJs?=
 =?utf-8?B?ZUMzY1hGeThNc1l1aGJOY1dPOFphL1BNUHlraHliSTcwZjVlQ0NiVWdlbGVt?=
 =?utf-8?B?UFpIclJRS3NTc1huMTZDek9xV0tJYldJYmFuVmU5NURxRUs4bE5sSjI4aWhY?=
 =?utf-8?B?eUlpTjM5KzZzNWVOUDJLeE5mbW8xdUsyaUJEb2tSUldUbjkzSnhWMzlncWI1?=
 =?utf-8?B?RG5ENy85YVB6R3ZxYTRyb2FSUncwbnNoWHd3eXMwdmVwSjNOaTdsZVhNUlNR?=
 =?utf-8?B?MUQ1WFlNZXRQY0tLRkgveEVVRjgwNnVOWm5ZMHB1eWZUaVVHMzFwSm95am00?=
 =?utf-8?B?eHp2dTBES3doTlNNeVptSGgyTElsRHVvVGZBMi9TVG5Qa3V2NDREMktxRGtv?=
 =?utf-8?B?aHFhSVcvZ3puSUVtS2hmUExPZGp2R3cxUTBQUjJ4V2N5aXZma3phYXpaejdV?=
 =?utf-8?B?YUNROU5PbEtUT245eGRRL1drbkVMcmhNMkZIVWxQdm9kYzBPMis2WjFXWTNY?=
 =?utf-8?B?M1lyK2FKeThvNksrQksvY0hpK0RCY2U1WmdPbGxFTzJhZ1hnUElWSmhpczJX?=
 =?utf-8?B?Z3poQ2I3NWxBc29iMTlQa0VwN1N0dTZlK2FxM3dMV3FGVzlheFROb2E5UHU2?=
 =?utf-8?B?MndaZ2lXRkxyNUJjKytFSCtpWVBacEpQRGxVYXQzSG81VTgyUHFsWG5Wdjhv?=
 =?utf-8?B?c24wNFdOTDhETWNaMldBbVQ5bmkvUWVlbjZ0TUVUSG9aelhnN0hMbFBxSEJk?=
 =?utf-8?B?NkdDaGFuTCtiZDV0dkpNaVNlQ1gvSDFGMTBZclEzREJSSXg2YXQ5L2loVGxn?=
 =?utf-8?B?VXJUWi9Bbm80MVorcXowWFQ5QzltZm1RMDNzQ2IwTU45eENuY2h1SXp4YmZn?=
 =?utf-8?B?NTBvbDJIZTdhTkdneXBLcVpzV2ZobmlaeTREcU0vc29NRHZxK1R4eFhNYTVz?=
 =?utf-8?B?RVNmYmlHWWtQSHVFMmtyRExKSjNoWW1lWnFPTG1qS2xINjhieDZ2MnJnejc1?=
 =?utf-8?B?LzJOb1FnQXArTXZxbDY2a1pWTUF6UmVncHFhSkdiY2gxd2lOMUVaTGVuN1hK?=
 =?utf-8?B?Q3ZEUXR1dzBacCtIRzZPa0x6d1dEKzllVENtcmNrOFRJUXQ4R29BYWFORFJ5?=
 =?utf-8?B?MDlpNTlEM1NKR0RWcU92QklUTitsMGNWRkNvUUtFeEJLanlxMGV3Sms1WThy?=
 =?utf-8?B?bEJDMVVRRGdxZnRIeFZtTFBlb0hKV2d3eXNOdDJ2MGJxVFlRN1k0RCt5R2xW?=
 =?utf-8?B?RTJ0eGt4Y0xOcjZ2cUhtTVBvclo3RHE2eTVleUFFTE04VzRmZDJ2bVJtOUhp?=
 =?utf-8?B?T1h1L1JmdG0zNy9oZXlLL2FzcXV1RzF6dW5yNXExQ05uYkg4Z1VCNFBHN0Ix?=
 =?utf-8?B?eXpiTlQ5dU5oWVVnL0pGM0lhUGNuZU1RNG1qR0lCb0ZXNU5KUEZSb2dCOVYz?=
 =?utf-8?B?bUovd1M1ZEF2ZWhIYXB0TExJZzZSMUdnWjVHKzI2RGJsQlBSSE9heXp4OFhn?=
 =?utf-8?B?OWN4Y2IzdTQydVlSOFROUlJyZXVwSUptbWJPMVZvRmxIMEpZQWpSbUU5eVpr?=
 =?utf-8?B?OTcyMWxPNjRkSFF5MXQ2cVd3VFlWRW43c2t5T1A4RmVxVDB4YlNlbWZZSmxU?=
 =?utf-8?B?cHFQOW9wZWNnTzUyRFhhZXBKSkJudUFaTWw1Zkl3eE9uV2pkTThWYUNIMllV?=
 =?utf-8?B?UFZLdGMxS0JXN3BmUm9vMjd3ZjFCSm82eFlxdXk0Nk1pL3NPZGUzVmFXdkNw?=
 =?utf-8?B?Zk1wU3A1aW85ekJ2MGNHSE9aWkE1NWxONzRBR2p0TW1wRGQ0NG9CdHJwN09C?=
 =?utf-8?B?UVpRRFplS2plOGtwaFpzQm9SdkxSUXBzc0RKcHQvTmswTTVldlRzY2FwUExW?=
 =?utf-8?B?RFZvY2NZN2VtKzl0MEVJMnJMdXkvbFQvckNGajB0ZXFEbWx5RVJNd1EzQW04?=
 =?utf-8?B?U0NnNW81bjJiU2Q2ZC9iejlyNURnZVdaZmVWK3c3cUVnL3B2bnRxTWNkaTZW?=
 =?utf-8?Q?cueYvLd3dA9QXxvEKYiula3yL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679115ae-64c3-4a94-3ad9-08dc28804775
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 08:31:00.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Xs1c9mx/V2C5THhY9PJ8rwP4cJQQE8J2B3eX8ruHZk/t7gc8pYoYt2PAA5C/RIjS3BWN9DLqma5RYziqTCZFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

Hi,

On 6.8.0-rc3-next-20240208, the network interfaces are not getting 
configured.

I have 'NetXtreme BCM5720 Gigabit Ethernet PCIe'
        configuration: autonegotiation=on broadcast=yes driver=tg3

If I revert below commit I am able to get back the interfaces mentioned.

commit 9bc791341bc9a5c22b94889aa37993bb69faa317
Author: Heiner Kallweit <hkallweit1@gmail.com>
Date:   Sat Feb 3 22:12:50 2024 +0100

     tg3: convert EEE handling to use linkmode bitmaps

     Convert EEE handling to use linkmode bitmaps. This prepares for
     removing the legacy bitmaps from struct ethtool_keee.
     No functional change intended.

     Note: The change to mii_eee_cap1_mod_linkmode_t(tp->eee.advertised, 
val)
     in tg3_phy_autoneg_cfg() isn't completely obvious, but it doesn't 
change
     the current functionality.

     Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
     Reviewed-by: Andrew Lunn <andrew@lunn.ch>
     Link: 
https://lore.kernel.org/r/0652b910-6bcc-421f-8769-38f7dae5037e@gmail.com
     Signed-off-by: Jakub Kicinski <kuba@kernel.org>


The same works fine on 6.8.0-rc3-next-20240207.

Thanks,
Srikanth Aithal
sraithal@amd.com

