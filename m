Return-Path: <linux-kernel+bounces-66209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8595855889
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962151C267DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14610E4;
	Thu, 15 Feb 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c5S7aO2M"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C5EC7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958912; cv=fail; b=Qv7NY3OFJ2c4Zk9/lownTKc6rpQhYmgwxegs4oifSRQOPEPNSYkgdXcB9nwzcPXQqQ7Xj4KZCUvy9ecmxOmMcIps+g2Vs1uFOoP8HHnpoj9Wbc+G8ObgmonNhvHsVEDewRFdkaXVtaOdT7+3x0GOjgmKIJ6MqS0oDIHnJd6Us3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958912; c=relaxed/simple;
	bh=ctTE4mB3qt507m3NDF+HD+Lnn3QES1qt/FPyoRX9pG0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=gVU17BRNK6Ppezk/q8E2SjX8ZDIGzwFakEzyKb/j+UuNeAHh42VUXsLXS8pEwSUtKqjAoF+WM7LpHUDaqpLjqG43EG5Kg5/eDT8ZVtNRWqt8Qq30pXgnwN/n/dQMNaYEeH/Ut/YdLgZOUyHhZDP98z9KeXGOHmIRlXQ4gPekVJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c5S7aO2M; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeiICFaXsf/ZCPkKxlDEMeEuZJC0mEgiZYLlU9PfLgSkj5zgOIUw5z2nrrTHmZSThZJw2aSMOEUJs4/qKuMxpCzcO8zBMqnzF8KYAERQnh6KPaKB9eIKulMfsV+lHwhxq0M6hCwY9ouafljrQZr0N4pAmV9XkAAtsE5hagqSmDInCTCHXrTzGgty/JmN9J2U2cY22iNAd62OM8RyZRbMzA+UMJQ+4VxuzSjW3IwL88r867+L+Pn35qazPwxHw8bRH09tdxRVu8UrIWotNDGyhnE3DRQE/h4uYFh6FsmOAl19wwJ2jUP4yWPQbjnYkMBeWdws5bItAuP2DqEE6NvVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uO5ET74HwsQg66NhN82ltMrRyb1Omag4U01MygcR2ZI=;
 b=WF/mhMET3D6nvMIAdRBow6p4nZTOdlY4fodBrJjL85L/9ZbtySXxkkBdPrnpyl+babmq/iOusRI6yTtHelSm5qK4hxkpdvOJtF66M/hs7rsLJqc2+fY45IfvhXaNZVkYDEFdBTTPuZ+3IWGYyUn7k551jXChAndwB3m0M9sCR/f9fxXQBq2d2cyMwJmqC7SwUAMSOl0dolTBFtpy6Nmbvd9k7HtSCdoOmZOwNfkehDyV++0PUqNyqq8fC/WLniCEIcwwDomLua2V49N/W4z8QR4wr1VGa0JoSMEP14L4wYQjBLxydPS8W5vTiweHmXkpR3XQhavxOwXH32AQo2INhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO5ET74HwsQg66NhN82ltMrRyb1Omag4U01MygcR2ZI=;
 b=c5S7aO2MfmdlRErU67SR841JwoBU8GvkDM8kWqXqhM2r4TgJhD6FoEey2rjHd2N4d0iZ0loxhA2zlx955Y0n7VRwDU9X7SI59uh+DB9wekWjv+5ZqRQUw79pXonC3Ylwz596+BSrr+GyX8EjjqIMczs8AmcUyAAk36AFrotNctQt86NrEIA7Sfvj4iX2kflFXsicDvgHQPrL3dx/zvNhlsK15nAoWSiGxR/SVERoxkOn+qdmAy3f+WnizXoLJMz6U/+3mXYv/iosal48AwdhgGT4IU/OOByijxWrLyzySkSDPy1drokitJJuNWBo9HSsY2jt3h6w4QlAlhndSvGxIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.18; Thu, 15 Feb 2024 01:01:46 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::a892:3047:6c68:5adb%4]) with mapi id 15.20.7292.022; Thu, 15 Feb 2024
 01:01:46 +0000
References: <20240214202055.77776-1-sidhartha.kumar@oracle.com>
 <20240214202055.77776-2-sidhartha.kumar@oracle.com>
 <8734tu7jbe.fsf@nvdebian.thelocal>
 <df59f5e3-6c16-e371-f987-7776f2d24f15@oracle.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Alistair Popple <apopple@nvidia.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH 2/2] mm/migrate_device: further convert
 migrate_device_finalize() to folios
Date: Thu, 15 Feb 2024 11:58:54 +1100
In-reply-to: <df59f5e3-6c16-e371-f987-7776f2d24f15@oracle.com>
Message-ID: <87wmr6a6bu.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0070.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::13) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a2e91f-f4a4-43bc-8ddb-08dc2dc1ae69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H22zZTiVEG0SaTLY7PwUUznYKcLp3A6GvqOFdo6PfrU6MOqG45ORLn5YeHlJ7YEFg1JsvEFfgGzrzmVq+mYWYRajSdQy63l3T+yIIUSPpajk1Sb7VAUCRItd79RVtBwBwzwAsWXQiv880dU68RH3qc+ZZrzo2+T6WMt6JM9ju9Wd18bDgSEegHewPzhT8laF7QanmaOIOh6Tb2w51MOgVR2/RcbBJ3/oVENpqTiN0iiR6KxLLN12k0zek2Rk9uljfAbHFu7IPpCBuNqdd5aTE5qHfnZJAg7bvrBzP/VPuH9UkrKAFrb7DkguGzX0uf3AjgR2RwPNUFLZ1y0ZZOIWwy7FIF1amM5X5wVvAYL5ofLNjXukkv1S3BoQ/1PTxqriogNV/9QdIOUPKlSXHhsaQgCUPlAbspuqBTpYTkewXSlddAK3sDFFVYJOnfPPtuYxq/9/+nvhxfYqXFlG18OYw1ZsQ+HC9UKUjbBZgcMTQTI8ZLxHxOkY9QYmeuLIiu6uSd9xpDcF9e9nhIGhliqH1ZKo54Odg4IS6XVl3rPKZvKeny76YRFCkpSzMxDN6LNA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(6916009)(316002)(2906002)(478600001)(4326008)(66946007)(86362001)(66476007)(8936002)(8676002)(6486002)(38100700002)(66556008)(9686003)(5660300002)(26005)(6666004)(6506007)(83380400001)(53546011)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/pmM3/FtiiZr/L/gLLZvuydIdh6VDT2QR8pVcoype8v8QEYKJDiIrV47tHR5?=
 =?us-ascii?Q?A6Q6/F+BnTzteVOnBY1UP3YoQV4YEH4A4JN2FUTZZg3zzS23xTUIKaFZVQpE?=
 =?us-ascii?Q?zmfNCcOaFvj0Dzyr8/lx5xsvB001G+hGpRCjJcaUPCkKoZ4xy1T75Vgj5lk7?=
 =?us-ascii?Q?saL28lodHz5nFrdfgVS/4QpvEtTuPXjx6I2W/K3R5z6gfyQYSRNUPovaFkZo?=
 =?us-ascii?Q?6fd8FR+pg7dlQs0mzL9BvOP6eDvRGhGMESNjYDRfa8jnB9dMhsHTswul0fdF?=
 =?us-ascii?Q?wVNET/1JT0wsJcp3uY750jSxBPUUAW9VmT+TQ+jHl7RwVfxFXhmlkbBzEdkk?=
 =?us-ascii?Q?x3FaO1a4lLbbqIFQkBrSXMjTEyXtS7LFfe7L2qh2C2kpYbRHC7U5N4wnde/w?=
 =?us-ascii?Q?+UEjw4k+4P35Yi05HAu0aBV5MO8lt0TLH+qG3DZebMT1Uwwemkv5txN3Se2r?=
 =?us-ascii?Q?1OXFX/r9cICXqEKbiOGuyPv4zJI3ZUekavnVSHcm1pcolWOQLHsbcU67Klx9?=
 =?us-ascii?Q?vom32+qjkGHjCJKDDCrBpzU8hn/HHohoURT7/9OzQ1WyAAWmhgHu5RUgbTps?=
 =?us-ascii?Q?34KIOB5vV+ZayObkWWadoCz1KIuUlUZJMkeg2ZZwZfR/yyWMzwF/o+pvn0IU?=
 =?us-ascii?Q?FKUOh/L8AjSlPfgR4My6EDvK4MQcuDxVauQRTd5JEh/NnFRcFL8BNPRZ0bjM?=
 =?us-ascii?Q?ZxhJNy4pxq6a4qT5W4MpSbABvc7E5OwD7e76CIWb+CipbFUyEgeUt9LPYtnU?=
 =?us-ascii?Q?NTtX0EC7nNSiDwatS2uz50nV2NKYiTHT09Qhs+aKcLCnPiaURiNFOO5kYvuB?=
 =?us-ascii?Q?mjv/lkHfjzy7oNMnqbZJG0YaqpC+g63HOADqoCjH46c+lRH7zXxhOyWUvsP/?=
 =?us-ascii?Q?sxDqJv0ZFSkp3suKKlqNh8UHnE6s5TI8p2v4iRk2Jxn35fERRECxdwpQUOif?=
 =?us-ascii?Q?PPwKPGkpipn/VdPRhcuwUZtoCVNyyRHtT+VhPC/hXRoVDLk0a4189zycno4/?=
 =?us-ascii?Q?EvQ/AP3dr5/xX6L5WpxdOe8yEZKQUMArtbtDT5wsJm43ZfjZaHx3MGrkq5On?=
 =?us-ascii?Q?6RqUgqk0oXW+z6Ck75hwgnsu4olFZieXtGWOwgp3f5E/g9bWMO9wUsTlMr2v?=
 =?us-ascii?Q?8cs+WlNSVmvwYlNluX5fc3sb0XbVKotHi5FS2f4auAE4AUgh28C9kW21YAMG?=
 =?us-ascii?Q?SELtR0M/EDPyrPJQp1D93XlYAn5jrC4AgLh1V+NJtcAMQrC6FK04YW0y9mNR?=
 =?us-ascii?Q?CZnjOmmOECB3QM8Pxh+PnmJTSg3E5de9TYc1ZTgEeqwzAZooGfamlJjbYskF?=
 =?us-ascii?Q?jU68/sQw0w0Lugfs847rfWhcpYbK2l52ToZMX7qitmZCYZz5DxGO68dHDEj5?=
 =?us-ascii?Q?fQblGzqbwlt/VJ41DlmthzVhiNPtk+3SLF3nwZLwoxHhbJhBkDKXKl7hEJNv?=
 =?us-ascii?Q?BgKud/T8TWRhiy30JzmT+VudT8rvjQhjl3vCIbge/d4D1BxsjmHpbpZxL3T3?=
 =?us-ascii?Q?m0rveHl24eFdfLMHOU5V57OTTvcWIgDiahNLh9cjbmkb8pYbdnaagYccNvOG?=
 =?us-ascii?Q?Z9DCZuDqltIXtUkmlj+WkxWIpJ8hE2exgAk7WkzD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a2e91f-f4a4-43bc-8ddb-08dc2dc1ae69
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 01:01:45.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+ddOjOswFFtKpX/9ahybGPVsbh57+9DxLo4+Zy0peR5zZkrI4n8LLmbdmuo/XRfLR7b3p9c1rqKl2GfvAJgXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436


Sidhartha Kumar <sidhartha.kumar@oracle.com> writes:

> On 2/14/24 2:45 PM, Alistair Popple wrote:
>> Sidhartha Kumar <sidhartha.kumar@oracle.com> writes:
>> 
>>> Use folio api functions from the already defined src and dst folio
>>> variables.
>>>
>>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>>> ---
>>>   mm/migrate_device.c | 14 +++++++-------
>>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>> index 9152a329b0a68..a48d5cdb28553 100644
>>> --- a/mm/migrate_device.c
>>> +++ b/mm/migrate_device.c
>>> @@ -843,17 +843,17 @@ void migrate_device_finalize(unsigned long *src_pfns,
>>>   		remove_migration_ptes(src, dst, false);
>>>   		folio_unlock(src);
>>>   -		if (is_zone_device_page(page))
>>> -			put_page(page);
>>> +		if (folio_is_zone_device(src))
>>> +			folio_put(src);
>>>   		else
>>> -			putback_lru_page(page);
>>> +			folio_putback_lru(src);
>>>     		if (newpage != page) {
>>> -			unlock_page(newpage);
>>> -			if (is_zone_device_page(newpage))
>>> -				put_page(newpage);
>> Defining migrate_pfn_to_folio() would also allow the removal of the
>> newpage and page variables entirely which I think would make this
>> clearer.
>> As an aside is there any motivation for making these changes other
>> than
>> as a general cleanup? I ask only because I have been looking at allowing
>> device pages with order > 0 so have some of these clean-ups in a local
>> tree as they're a pre-requisite for that.
>>   - Alistair
>> 
>
> Hello,
>
> The motivation is just general cleanup. In folio-compat.c I saw that
> putback_lru_page() does not have much users left so I could convert
> them and then just get rid of putback_lru_page(). Should I still
> continue with a v2 that will include defining a migrate_pfn_to_folio()
> or wait for your clean-ups?

No, don't wait for mine. Please continue with defining
migrate_pfn_to_folio() for v2, I was just curious in case you had some
larger goal in mind.

Thanks.

 - Alistair

> Thanks,
> Sid
>
>>> +			folio_unlock(dst);
>>> +			if (folio_is_zone_device(dst))
>>> +				folio_put(dst);
>>>   			else
>>> -				putback_lru_page(newpage);
>>> +				folio_putback_lru(dst);
>>>   		}
>>>   	}
>>>   }
>> 


