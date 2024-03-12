Return-Path: <linux-kernel+bounces-100340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD8E8795EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBCE1C21540
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F57AE52;
	Tue, 12 Mar 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x64jNL4e"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176717A733;
	Tue, 12 Mar 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253182; cv=fail; b=XDhov+JbGCBBrzsw62+USsgqVYDcJvUgWcFA8P7iDYi9OthLgQaHVNq5ce6MhxTRP3bie1SexBy7LIDxwnh9Ua9JD/BJdhOhlAh6OG/Ro/8cjjWRkQJ4WGCJaT2eiCRxH7fETMRg0CIMlzsd7Zd/TUGwgmY0qaaJmR6t9lQ/NBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253182; c=relaxed/simple;
	bh=1zMWHA2je78LjDyOf1EPEeyjllkZ32Ou6bymHLqSTck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RJShLgNzEn0GIN+KtHcmjP+lT+Qq7hLK94Sh4YY4fI4jVirtSu6VYkh3ONd6YZae13e6NPZR5gKzIzLHv3iGGvniLDY4dj/yDAV1ZmydlGlGR39sSIHCMlyYyOHR6Kp+UJRTcEpJ+7u7tWuZMX908UugiaUdkciknVCEYn63alg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x64jNL4e; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8upFRB6QSq6BMOplTzuDbslYqYOhLDQYJdson1p23OUGpjr952l+gg2cJh8yJVPiFfxBZHbj2x4dcUqs5bxhro5apT0QGfPILSPK2tAbSWzQHB4eFZbQlz/PCJQRBVWIyrxkcdtCnm4i6sOiuntwjzRRFwYHsmZXg5jG1EnzhgsJfv87lun3grnai7j6SLE8ViwsGYjKj+pV+YGQKJnuzZwmUbX9eLjMBVNYeokKJMWvWdXcVdYDWp8prsBmHFBuBcuSb3/xGaTg90jq1ZfENlhx44W+z9WqLI5tucnR1u1d8fg2Sy4xBNKA+v62WS+WC2An6rmfLrpPet46ehXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6YZWEjGS3ZA2ubY/20fTnmNLPD5gvn1tObS+EjBkWY=;
 b=MEZ5Lu6Ln26IwwxzvrgRVGOyNWgRFFgsJ3SXdI/lSDukUcI2JP6ffW22Wpswt7OgoqYJYdP/nQvDOdqRhDK71l6QjBpY/Xhxr1kc1E0TXej0skkpHnB1Jcgc2rHJ+ILLzkV1ekFkyHhRFXyGrdLPP6wnLDVtXhUfnaegF8JrAtiLXy4rK2o/jKqnJf9UDfUbLGuxb8hIqfr+7PaSFCjYNJQihcAW6Acl1GKMRq34I/Xhkxm0cQJu+MMHS/MGk5hka9Qj3h4KH1+PHXO0+5LnGlh8zF0kM+qHcfGePYgZ+YAkJ2K+W0c4SMqLpZyr2H+DD0njx73tNk6gXnXyCqr4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6YZWEjGS3ZA2ubY/20fTnmNLPD5gvn1tObS+EjBkWY=;
 b=x64jNL4eZJ5QYD/GwMhB444lAbrzKDuLnLyx0rtc82QYgnQZXQ8w/1eNHTljFSHd76AUCthG9o0CqQN9BDrSHcZb0mJTd/xztflGHPm/8TliAMdL37HyDza/zdaCw0Vr8/WC6TNrYu2P5GERxZcvP3+nxyO3DFXAUywqQqCsECI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 14:19:35 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 14:19:35 +0000
Message-ID: <89afddbe-f285-4830-b3c3-27150852d562@amd.com>
Date: Tue, 12 Mar 2024 15:19:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] spi: xilinx: Make num_chipselect 8-bit in the
 struct xspi_platform_data
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>
References: <20240308162920.46816-1-andriy.shevchenko@linux.intel.com>
 <20240308162920.46816-4-andriy.shevchenko@linux.intel.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240308162920.46816-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:332::30) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ffc001-c172-46cc-2966-08dc429f71d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ewd1hvpkYhhmLJ8XOtb+VJNnX/jq7tqP2RJ1g/gjPjcrJsrHbKMEluacVC9zfmXXhB5GZU0SKtxXChl420FRVYWPoSxch5u1HAQehsAe4FAffFzE5g1nzEevg5PQJS9S6dbiV5rDqMNQgUiviz5fFWEYUHSTsSYmpi4ZPci2NHYBTQ7QPXnDY+GRCo6r27fEvAm1bTGOq+bQoASjAT3eMIlFGD3TNqYMb8jQbzdvOh5thufThWRTC6xwWhE83S/8eySg/2Dym4w49zbVBYlKpeH+Iu2awJFCcIvXAiJ4YjSKYdyVBNRwy/epFYruNs7WfB2giUgm9Y/nK5f2aQ2rT5UpDohT1hB6UE8CyZ0wavOaBIVefMlFqBpv0/VGLN1GyRA1M3OgZMLiVQJDcMFD4IW61V8Y0/7DbO6xbDOCZztpHSDvI3l+cHBZpVrcSZslCPbQo6zTwknQft2RYOQ03f1eFIlHUkcvXypw8ybqmF28HuMmsXrYobGETET9+/xPT9kJdrAAXskjOHxwpqA2MG76++cmNqZHq2cmm8D6wIxPnqBCeHL4Zo3QfnSEkQwD/Zx4aV/VP6BDK6/CY0R+kC+IRab/uBATOHk48/SXzoJeMBi6TQM5Q7IgfcvJ2uP3YtW/QfIcVDvsjOEu54f5vHsuwP3md9rS0TCaw1zKBHE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmdONDluSWcwQTZ6OWp1N3ozSkFLanVLRG10R3oxZEQxL2Z1My9nOXFnMHh1?=
 =?utf-8?B?YTBncVdqV1ZNQjlCNlR3S1BROWpLdlJtSEt6eXVnNzFqMzY2Mk1BZjNEaDBu?=
 =?utf-8?B?dUFabWJCS3pSbHhFOUFJUUFMb3RkM3pkemNwK09Udk9PUGpZL1NhWDlZUnVl?=
 =?utf-8?B?dE5KRVlxMGpFUjJXdzVQVjIwU2N6OXRwc005eklIQW1HcElnTDJxS2F5L3Yx?=
 =?utf-8?B?WVlTWWJnSldKbStndXJWa0NsN0pjLzdZQUxYQWpBQXlYa05JcDlQMWZPRHls?=
 =?utf-8?B?SzlRWjRZbVRkYjBsQU51NWNNWDJoeXFLay84eHlVUkxpaUNtS1ZRN3ZmVjFk?=
 =?utf-8?B?OHE0WkxkWktWQVZXcHVJdGhycVV1SzdpdkNyeTZzdzJBdFBNMENQSGZ2T2tG?=
 =?utf-8?B?MWJhM3FoVjlBSFhPMUxBRzlRVjRHOEcweUFqVGNFb0dxU2Nhb0F2MXFUeHM2?=
 =?utf-8?B?MFluVXdFaXhRQUFSek9KU0JEZTd6NExPTFVGSVR1UnZhNnhQQVppbnY1NG1Q?=
 =?utf-8?B?MWNSUm42RkJBMDJmVUFLNFJuVTB5SXBnRXNWdnExc2dzWmQvZy9ndjhxTWpM?=
 =?utf-8?B?YVdBaHVvWE0rNHQxWmhiZGhheXdJQW1yZDdMOENiVURmZmNBQTBFSTM0RTQ4?=
 =?utf-8?B?SkxYVjhIUWZMWGloajFCczgwek9XRzZ3WDBYamNEWUFtMFdCSEcrUS9vRk5U?=
 =?utf-8?B?UW9RWTNOVk9GVXd4Z0JCTmZqeWFTQlcvTFRIODZrMTBXYU5NNVZMN0lrc2ht?=
 =?utf-8?B?UDFBdHdySEsyNDZOaExpWnVRaHVoMU91aTJIOXA1dkxKblFxRUZyQXJhRGFQ?=
 =?utf-8?B?SGZrQW85YzY5MjViOHdZbmVOZ0ZjVlNPZGJxUFdtdzllZkVRYURuWXl2WnNx?=
 =?utf-8?B?YmQ4L3ZkWEdabXhGb2RhV3k2RnloenlPUEhCSFFkcCtKNE9kaW5Ja1ptMzZ1?=
 =?utf-8?B?bXo5eFp1R2Q3WktLRkpHdTVKN0pJbEQ1RzdsOVp5R1JrYkcyb3RrcXpUem14?=
 =?utf-8?B?VmkrSWUvOFh4UUY4M1dpTXdUTkFaY2RDQnJ1dkxMbTRqTkZHSEQ0di92VGNl?=
 =?utf-8?B?bkRKeXlBWENtQ0ZzelI1NXpSbUFDU1lnSXZvZnE1d0pDT29FVmt6ZTFMNHBV?=
 =?utf-8?B?SHRQZW1qL2hWWGNLcDR4TEwzdENsN2tKekJ6cHBNOFNOWjlta3g4YkdEQlJy?=
 =?utf-8?B?ZWVWWUxHT0dqSGwrNGdjci9FdnlRZWpOVkNYaHNOZDlTT0tPRSs0cEZLWGhi?=
 =?utf-8?B?aFdNRmphcC84MCtVanB0Y2hOY0M0RHltRTRCNGpJQzlTV0NjRS9Ya20vak1V?=
 =?utf-8?B?dnBTR2JMV0RXbi8xeGh4QUsySkdOMzl5aHhhUmFlRDNCYTA4M3RneTJ1eTZM?=
 =?utf-8?B?c1NZMFdTU1pSV283ejV6ekdYUDU0SFMzSUZXeHpIVHdRUzE3K0lLRFBUME9M?=
 =?utf-8?B?QkhwT0haS3NTazgwcTRPS1phTktwYnlXLy8yTUFYZnVVU0MrUm9sVFFIOFlq?=
 =?utf-8?B?aUVjdlliNVgvOVlidzBPVFo3VDZ2cXlVSll2VGtJakllY0JNeUpISjdNTzlZ?=
 =?utf-8?B?Q3JtNXAyOVk0S2NtRDFweTEvWlJqVG1sN0xiZ3BCVEJaQUYzOC9zYzhqbUxt?=
 =?utf-8?B?d0RwN0pDd1ArZnF2VlViWjhOV3F6QWlTUW1nRDZkM2lGQWRNSjhiVEcxbUhL?=
 =?utf-8?B?RlpYbWV1YldPVGhSY1RuemxyZEdlRndnWEMxRFloWklYTDh5UU5xblI4TmI0?=
 =?utf-8?B?bFZHWHBQd3BiTCtRZEdqUWdvWm9zdTJtMldCdmlIY0c4Wk15a0U1K0FGUThr?=
 =?utf-8?B?N2RHTXhDNCtrWXgvYzVlQkQ4M3NnZTlwd3laOHBoaG1oZnhaZldjdm5hRXFE?=
 =?utf-8?B?UUdDWkl1VnFFSC9NNkRiSkRPVGROcldoY2JwK3RhN3AyNnZaZ2Qrb3Iza0JW?=
 =?utf-8?B?U3htT21NWjd0Wll2dkFvZzBBWVVTZWxCMkpDYkRWR2JjckNtNnlFYTQ4WEZl?=
 =?utf-8?B?Y1dIRTBJMWtWdms0emxOaklNZjlYbnpkZDgydmhBbmxteGcrSmZobnpaeGVR?=
 =?utf-8?B?R2twYzN3YVRrczc2cllnSDQ3dm9IM09Hc0MyTmFacDFqWHZvNlFKQVNRMllp?=
 =?utf-8?Q?u32G8c21cV8TkEzzwOVHSfWwk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ffc001-c172-46cc-2966-08dc429f71d5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 14:19:35.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZRhQuX0bcK5jrLeNwkTDr+Y6tYsJuPSGDE3ETVmCy5jCIrNa8ViBqNzYBsha8Bu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719



On 3/8/24 17:27, Andy Shevchenko wrote:
> There is no use for whole 16-bit for the number of chip select pins.
> Drop it to 8 bits and reshuffle the data structure layout to avoid
> unnecessary paddings.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   include/linux/spi/xilinx_spi.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/spi/xilinx_spi.h b/include/linux/spi/xilinx_spi.h
> index 4ba8f53ce570..1b8d984668b6 100644
> --- a/include/linux/spi/xilinx_spi.h
> +++ b/include/linux/spi/xilinx_spi.h
> @@ -8,17 +8,17 @@ struct spi_board_info;
>   
>   /**
>    * struct xspi_platform_data - Platform data of the Xilinx SPI driver
> - * @num_chipselect:	Number of chip select by the IP.
> - * @bits_per_word:	Number of bits per word.
>    * @devices:		Devices to add when the driver is probed.
>    * @num_devices:	Number of devices in the devices array.
> + * @num_chipselect:	Number of chip select by the IP.
> + * @bits_per_word:	Number of bits per word.
>    * @force_irq:		If set, forces QSPI transaction requirements.
>    */
>   struct xspi_platform_data {
> -	u16 num_chipselect;
> -	u8 bits_per_word;
>   	struct spi_board_info *devices;
>   	u8 num_devices;
> +	u8 num_chipselect;
> +	u8 bits_per_word;
>   	bool force_irq;
>   };
>   


Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

