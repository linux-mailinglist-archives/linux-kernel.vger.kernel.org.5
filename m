Return-Path: <linux-kernel+bounces-55575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAB84BE60
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5C22881A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0083179BE;
	Tue,  6 Feb 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vcTgIhH8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22F617735;
	Tue,  6 Feb 2024 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707249487; cv=fail; b=Wnk6NxLlWsze373mpR06DuPgMZyDMMXH+11NgIbMhE53Etk2gdnf/42Vks0cvzyt/E3rpl4kSZjlj4S4r4qJdUWCdi8YnkvfSoLUJu8mIO7NcAw2yDdF5VcRjqW7XPq7NYqqFPAjqFaQTVdyjzGKryOpCuh9H3I8XK1Xp6AOrKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707249487; c=relaxed/simple;
	bh=G+rDGJZC5CwUxFk453sMwRI4fwTL0GS8fT/WeSG2iRA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4sq1QCVvHQ/GiUOh4mENqUiTzTJGpZjQcvdtnRxZXpiHFQYiz8dJWnKw4P0I844r4EusLnWD/5JmOoFXdnN6KhR7k+PzQ/V//4+EAI9ftDJ29ZpjUs5W7zSBmDKnsMrimmS2SJ2cTa2mj7Q54mumq0Yk3qtYgqdd6cK2YKJS4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vcTgIhH8; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkXaU7I8F66gk4G9Qq4IFtoHvKO3glAl2wvTHqDxZuR+PZh3pGUyBAq/hU0HZx0kZnnmqs/ZPvx1gM9bo6pv/jVXQhqPH1oj9p3hHNTHeCr1P6khtjwYhpVg7hs1xgBvi3lGYjMETeEZRPjgOKt9EDDDyP22hChZU+pt1eWTH7obS8/+CI1POR+CAQ5b/JvAQuBW8m+XH2lgRaDmJ01BlByRampzRjNIXf/MU1AOAQGJiwJ/79+hFyrFnSTg8mRZGMTrH6Jqw9cxzOm7e23/yPdM11l9qZUN3hCgOIEBvnzwv+2mnZLtY3qY1diMaB5DODAqdA9Ac0NjS758Plqgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMczvQYWVAKp2LqrmTn8PyM/gK1OmT+baaHrMCVFlJY=;
 b=BBst2s9r76q6X67wXXHiEafsW8QJDBe2qoyZxi5J1MN7BQw3OkzPM4bKlFEk8EwvtZCM0sqsM3aXzpPkaCcgM07X0gGbsa5x40jGHR2fQqy4ZDDgBnqVQhyXsBU8aYvdys2+u/QFQ/5UlNGqIKgiNlcRAzJjj4cXTAoAERU5NZHdZFJKTHx0BSeLzX29/2ORqj0ybhY4CmGQ30m1wPoy9QSxZcfWZIq4Yu7tt1m6dOMUsmnLINkZaesEMw4KnS81uWt7u0GCe3obRaIkwEVCwDzMA9r3usWkzAlkF5PUzjrPLzYNy/i3zR1iSQl59H4K+04Ilwq4KM1I4bmdegYCXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMczvQYWVAKp2LqrmTn8PyM/gK1OmT+baaHrMCVFlJY=;
 b=vcTgIhH8PMmivpWa1i9bXhG2lScF+GS/gA2EhR/Kfb4FX6cOGg/gwsDAU25mLjY0pFkhTqpPlJPsr+vuKGnjbX9jb233kD8PkLRg3PudmhLcDqzGOyXLC0fmMGlfdRNenA0hHA5GivHcO4p4WcamH6EJV9SqZ4PioaTubOwN6NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8837.namprd12.prod.outlook.com (2603:10b6:208:491::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 19:58:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 19:58:02 +0000
Message-ID: <26c73a47-c672-4c99-9c41-aa0bdc162a4c@amd.com>
Date: Tue, 6 Feb 2024 13:58:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: PM: s2idle: Enable Low-Power S0 Idle MSFT UUID
 for non-AMD systems
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 David Box <david.e.box@linux.intel.com>
References: <12388452.O9o76ZdvQC@kreacher>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <12388452.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR08CA0048.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: e63f8018-ed95-4e3f-035e-08dc274ded43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L9UjbExgg55GJNn+aaiO+Wgr/wjlvTApoJHk4pPlYjuBPzSQApJ8ukdYjvnJwLuiwyhkcLL0kYHVY+Ajfj9X2A0NmNUlRV8f0YLAC7n3WWUNNu0O/dHQmTE1uoJYdWdd+R8i9pmxE9W1NZKiY/XE75bwPLPkGgFRtZ3JPpehcERjhIfkbh+1dtBKBRZtCzHxOfSc5MiMu/lRERvZ9TBmlFoQzDHW40XjIvoqJg1a9hl1qkjpq2SXhyJZaTlLe3UCz98/ID4zwBJJ5XQ3LAOcFR4Qh0HCZWbIFG1/P08+Nx2DkHSDzDdnQL0b9wx2m6RdJmUGe78GSz80/Ws9aM55r9Q/kj7R/zgg71SUTuIOSdKYqsaEDDSdoI/Hpuqm5+o14hpnsGR3YIajdibwFjbaU+Gt5UIRTWNa9C/TTtvU6DkjVlQmCrrQIWGbURQ7U/PrZ6whZMGrVHMTk0XD+XoWruRUYUBapyOUhJY75h9VO6r+EJH4Wc8ooGEXFiVm3Bb6OwXupPL72SjtVY7h/AfZF/0NSeq1THUFEpUFzNBme60AIuFJb6OuGOOdnIm1ejmKOV4uBaJ1sAJzwvBZLSL3oYN5BvG0mkRiHepTdMJstLS9VYqdPAFc68t9G34ua95vGRtN8wfNUKdpybesyBDYNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(84970400001)(31686004)(6512007)(86362001)(45080400002)(53546011)(478600001)(6486002)(41300700001)(83380400001)(4326008)(26005)(2616005)(66556008)(316002)(5660300002)(54906003)(8936002)(110136005)(44832011)(2906002)(6506007)(66946007)(66476007)(8676002)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhTVmlZQTQydnlIN2E0QjRMMnNXS3V0K056TkxWamVudFpZcmM5ODNBVEV1?=
 =?utf-8?B?K0QrOVQ0TzR3T0tieWNlOW4vUVFkT3dzUGtlNVVTdDJSSFcxTUZJOW1vUDZX?=
 =?utf-8?B?VmJVU1NlM0FWNW42Yk9qWm0yd29IdkdEQWtvU1I0WXFsU3NQczZjdVZKRFYy?=
 =?utf-8?B?MkpEZ1Q3azBYcjhWNnVSVkg2TXJrZ25aTXhYVm5WZThodXRVcXFFYU1pMVR6?=
 =?utf-8?B?NzhOVHNUNVQ3d29UcmM1SmJRMzJxL1dmaHJjK3FYQXd1dExvUkJ1OUprV2VU?=
 =?utf-8?B?RnFkczMwcml2bXg2MEYxM05qd3pVYTFIcDQzY1lDL29YMCtlZ2JFVVlOTzZT?=
 =?utf-8?B?NjE3Nzd5UjhWWXdseXRWM2ZlTlk3NU5tSWJrUjRqU09iYVRTOGhKNkt3VWtv?=
 =?utf-8?B?Yk5VN3BBRXRQeTVlYlg4ZGxyODRrZzhWN3M0cThMazRESm9UTUpQVGlJdGRt?=
 =?utf-8?B?aVFFRnAwRi80dGd5dlZUOFpWWnlIRjhWRUdaeGFqekhncmxJZ0FjU3dmWEQ3?=
 =?utf-8?B?UW0zcGMzeWMzTEJ5dklKYWVKZzRrOHVTbUxLNHhSL05FaVkyZHlwSllrV00r?=
 =?utf-8?B?VEswK0txdlVwYTRDb1ZKYnRRWHRUTXVkMEgzTE9GMitCbXZJK0JvNW93SENa?=
 =?utf-8?B?QitaTVZPaEFBUHBiSE1BL2pKaGo4SDk4K29oTDV6Y29YQ2hCVjk3OUZiaTJ6?=
 =?utf-8?B?RkxWaWhjTWlhaXlvOFV0cXFlVzJLRU53eGJVQkw2K2hyeUR5TWgxZzc3bE0r?=
 =?utf-8?B?MmRqT1dvUE40b1pFUll2MFc2QXFRKzc3NERZVHU3NmhhY1czbnFuc01RRy9Z?=
 =?utf-8?B?dnc5eCtwSEQ0UDZETTlJMTdpM09ld3ArZnRJTzNzMzVTQW1jYi82SXQrWU5k?=
 =?utf-8?B?cWpWMGcwM3BSV3hWc1loY3QrZ1FMWVg0SlNTUHFKNkhsSGlWMXFMZXIyaW9P?=
 =?utf-8?B?SURLdVZaOFNlUGhZTG9UODBaY1BSbGh1aWIyekhVWmZiWDRpNnJXZzZYVXgy?=
 =?utf-8?B?dllPdThJbGNOaWNZVTlSejVBUXE2NXp2dU8yZnFDWlNSYlcrNHVSb0p1Ti9z?=
 =?utf-8?B?ZXVWV2FGVlBKa1RoMlJaOTRvZG9EckIrVlhqckx4aWVMaklpNjhhS3grMXRw?=
 =?utf-8?B?eHdDWlR6bmhibzFkVjhaWU5vdUllN2lKazVwNE1VRTNjSmN0RDM0cmVOczZZ?=
 =?utf-8?B?a1YxWlpQSzY2R0xUZk40RVM0Yk5ML2x2clg1UlBlS0w3dzFlSUNiRVRtNGJV?=
 =?utf-8?B?azRXRzhYNENVaHNqYjkvcXV0VkhDckJHZFpndnloZ2h5SDA1ZHA3RUpJM014?=
 =?utf-8?B?bkNZMi9NSDhab0pKdGxjcHZ5UEZWSzFGKzRZeTZNUWhweDljK01Da3NPTk1z?=
 =?utf-8?B?OEJTaW5aQzVkTzF1Q0RWdjVCc2FLKzNtSGlobFlONjRsVGZSNCt2S25qWnJU?=
 =?utf-8?B?RVFaTkdLSFk3M0hjaExKUUUwWFJ3dHAwK0dUQUh1aTlSWnlxUFh1TTNWMGwr?=
 =?utf-8?B?VXVwVUFLOEFaaCtqUGgrNjdHbkRFeHdjNHoyR0xxc2YydllULzI0dnVVbUc3?=
 =?utf-8?B?KzJvYk50VDQ2WHg5RWRnWllhbGhkZWE2VGdRd1Jwem5hbGZ3TE9NTjlhRU1U?=
 =?utf-8?B?dVJGWHNwS0h5cWpiRkdSbElmZTM5bVhKQTJuYng5R0d0VWs0bWVXeXdtbmQr?=
 =?utf-8?B?RWF2UVZ5VWlMNU8rNENvTEI2T2JpL0h5RVJQRDhoUGpUVmgyS2c5T09sTzhi?=
 =?utf-8?B?a2IzaUM2NjNWRjJrYjdvZXQ2N2kzdnQ2Q3VERnlQK3BSVEU1R1lPeHZXZHNi?=
 =?utf-8?B?dk5KNzZCQWpFRGZYMlNSZXpuTURIQjdJbnk3R3l0cThKekk2cWFkWXVLUVIw?=
 =?utf-8?B?WjJndm1xa1RuMllrS1NTMTNxTjY0Qml4YmtWZnJGa3BjOExnNG42bnVSbG1L?=
 =?utf-8?B?aXlrZDMyaUlaVmZFbERsaFJ3Qkg4Qnl0MW1YVVkxanJNdU9lRXFVT0dLMXll?=
 =?utf-8?B?WGJBSHhjMlZEbVF2YlY1MUV0L0JhcUFvVk5GUGpLSisySlFXeTJrQlBDMW5a?=
 =?utf-8?B?QWlDWWs5TjNiaytZbmVSNWlRZW1IUjVxQU5FRmg1WmpGR0FyZ3pwRUxIVmVU?=
 =?utf-8?Q?wiWXXGCtNiQ+buPcD4mo9nOhp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63f8018-ed95-4e3f-035e-08dc274ded43
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 19:58:02.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a48wjBLT/JMS7gOxfiyWMofoBiiZxGo6yLl/j/yVFAXdSHomLKe6K3HZC0D2DeRh5tbLrH+8M+yi4VErhG2Lfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8837

On 2/6/2024 13:33, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Systems based on Intel platforms that use the MSFT UUID for Low-Power S0
> Idle (LPS0) have started to ship, so allow the kernel to use the MSFT
> UUID in the non-AMD case too, but in that case make it avoid evaluating
> the same _DSM function for two different UUIDs and prioritize the MSFT
> one.
> 
> While at it, combine two MSFT _DSM function mask checks in
> acpi_s2idle_restore_early() so as to make it reflect the
> acpi_s2idle_prepare_late() flow more closely and adjust the
> Modern Standby entry and exit comments slightly.
> 
> Non-AMD systems that do not support MSFT UUID for Low-power S0 Idle are
> not expected to be affected by this change in any way.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/x86/s2idle.c |   37 +++++++++++++++++++++++++++----------
>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> Index: linux-pm/drivers/acpi/x86/s2idle.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/x86/s2idle.c
> +++ linux-pm/drivers/acpi/x86/s2idle.c
> @@ -488,7 +488,21 @@ static int lps0_device_attach(struct acp
>   		rev_id = 1;
>   		lps0_dsm_func_mask = validate_dsm(adev->handle,
>   					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
> -		lps0_dsm_func_mask_microsoft = -EINVAL;
> +		if (lps0_dsm_func_mask > 0 && lps0_dsm_func_mask_microsoft > 0) {
> +			unsigned int func_mask;
> +
> +			/*
> +			 * Avoid evaluating the same _DSM function for two
> +			 * different UUIDs and prioritize the MSFT one.
> +			 */
> +			func_mask = lps0_dsm_func_mask & lps0_dsm_func_mask_microsoft;
> +			if (func_mask) {
> +				acpi_handle_info(adev->handle,
> +						 "Duplicate LPS0 _DSM functions (mask: 0x%x)\n",
> +						 func_mask);
> +				lps0_dsm_func_mask &= ~func_mask;
> +			}
> +		}
>   	}
>   
>   	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
> @@ -549,19 +563,22 @@ int acpi_s2idle_prepare_late(void)
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>   
>   	/* LPS0 entry */
> -	if (lps0_dsm_func_mask > 0)
> -		acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -					ACPI_LPS0_ENTRY_AMD :
> -					ACPI_LPS0_ENTRY,
> +	if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
>   					lps0_dsm_func_mask, lps0_dsm_guid);
> +
>   	if (lps0_dsm_func_mask_microsoft > 0) {
> -		/* modern standby entry */
> +		/* Modern Standby entry */
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>   	}
>   
> +	if (lps0_dsm_func_mask > 0 && !acpi_s2idle_vendor_amd())
> +		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
> +					lps0_dsm_func_mask, lps0_dsm_guid);
> +
>   	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
>   		if (handler->prepare)
>   			handler->prepare();
> @@ -600,14 +617,14 @@ void acpi_s2idle_restore_early(void)
>   					ACPI_LPS0_EXIT_AMD :
>   					ACPI_LPS0_EXIT,
>   					lps0_dsm_func_mask, lps0_dsm_guid);
> -	if (lps0_dsm_func_mask_microsoft > 0)
> +
> +	if (lps0_dsm_func_mask_microsoft > 0) {
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -
> -	/* Modern standby exit */
> -	if (lps0_dsm_func_mask_microsoft > 0)
> +		/* Modern Standby exit */
>   		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>   				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +	}
>   
>   	/* Screen on */
>   	if (lps0_dsm_func_mask_microsoft > 0)
> 
> 
> 


