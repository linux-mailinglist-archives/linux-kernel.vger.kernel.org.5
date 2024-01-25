Return-Path: <linux-kernel+bounces-37983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C783B933
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E75A1F24549
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC0A10971;
	Thu, 25 Jan 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DaZ9W9GQ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2081.outbound.protection.outlook.com [40.107.96.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52C10A05;
	Thu, 25 Jan 2024 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706161917; cv=fail; b=DAjqF4xEdLwqTto3nEjamgFvEZoGYbaFWmQTTcz0P8RhdyExh3uGlqLSXtOtP2xJ+GN/tWieBb7YHdc1PrmVld5aaVBb2WGMOxooipBHGepBizVPpZvLEX3+jaqE/ZtzpHdO3LSTzt34coQr2lbQ/RTAB15C5twVTD05LFsmBwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706161917; c=relaxed/simple;
	bh=4ao6weJvARRd/QyTH66nxKPb/LNOsCJDzcKZzYgstQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Glmf80dBwfFLkUOvGJcnuLwWkFC1ERLe5IzQFvCOGqEc5QZHn+By4VuWBZsrRYfJVleaeI4ZWYPN5M+KQikrumW9ZB2qNXAeQUkP45rFblEvlHMR6yJjW2KSBQhTJsyjSOCh3NfxATFbuW4Dk0o2DhJBg0PiUMiNB3lNRiOlQwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DaZ9W9GQ; arc=fail smtp.client-ip=40.107.96.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM5WnV7YRhiHZJyuu3ACNo9o4jWc9tFOLli0yY6FRUpPS/LRKcejvIMZq3PJBtp6zDZ0YYzThbPYs3aZvRJfHG3Cul/YB931Io85EpvscYeqDsWuFv49TyLH4aHGZ6ZWjWflJ7gBQFx9RdOruopnPY2F+2T6VBZQAsleawWxFn/gtywM16rlPJW5e10vz0ljmZFJAobrxfdHX0Y8tvsPcSlq+jTqA+H1ERy9tvb3rjrGmigXIZee6tOM0O4X/ku2DQlaWvW7VA7JbKYCsoK+uWh3nsUQ6ofjaoFCyu/Ul0L/7UDWi+Unxo4xqahhCiH0y6b9yngJ48QHChFgBj8DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSKr2ul+xG1enm5y56Pn8tXRs1LNJYu0w6NQxZLs1bs=;
 b=D0y5WzDY0zhONJdckNAOnjaxH8TUMmLSnZKBTxw+brsw7CiVG2vGcxWr4t1eL2VusGoOBqVB79FpKd7auxYQ8oXI7k/Q8uhn1FbAeGMdJIZ/vfZeuj/O3+PHDkUcvbKgp/BytwSmxa+KRF8VA0fcb/G7xBjLZKurmF51G4UDp2gQQzvOFUdDNDm66QiwzwPTPxZuUHYa/kpZCYzu020zsTyq5bxORNWd9C0XffR3TnurViBzopGKxAvIgV4X7uWKXBRavmWAAgWK9NgkpvcjptM+kFyBk0SBuWeusOoF1btBD8Uh3wj2VXHl0iRhamOT/vlD/Z7fC4oEUTmu6JVErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSKr2ul+xG1enm5y56Pn8tXRs1LNJYu0w6NQxZLs1bs=;
 b=DaZ9W9GQd65PffF7YZO0unq6lYexlFtK2h1K+lHWEHn1ck7T1tU8UCs7F0jf6maUPQKniAHbhi3FrFntiHyAHjdAYpwVG/NKvbtMzPmNlD0zosBG+mPJNT9uBWBVZxCr2NhTgODla5gVQvYwuB2qnZiRgFm1AGjILeKZOzfC3R4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 05:51:52 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 05:51:52 +0000
Message-ID: <20defa34-f275-4d9f-95d8-788cb2eb55dc@amd.com>
Date: Thu, 25 Jan 2024 11:21:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] iio: hid-sensor-als: Assign channels dynamically
Content-Language: en-US
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 jikos@kernel.org, jic23@kernel.org, lars@metafoo.de,
 Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
 <20240109180007.3373784-2-srinivas.pandruvada@linux.intel.com>
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240109180007.3373784-2-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ff9a58-20e7-425a-a4f7-08dc1d69ba9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PtpcvSsph+KLSFGa1LHhzVKA7UZ/YQKGmPyWTbwmBv0vMK7slur7X6UGZaZRsU4l7qLviS1E7476gfSONpTzW4+U7bHlYS1SV//sZrqiwZ18cH97UvK9tbdkoJ1/Uq+g9Nc1iq2sQYMgozGvYzXOr877hG8CtEA/xL1yynivyBke7EV+aVFlXSwrmgf9X3RvW7uySvihBok1XSqAk5bvTwqO6HA9/Lb/IiO1JWr6YVAdmo/+qJrOx868+xRDaOZGeM9CDFpK9HL6Tz0rxNso81WdU57/0Hx/56KE5tH9yTc56z2Gn0SS5uOL0kcfaSKMNz/QPXRyX/3q+TYd757wo8Nd2UsvpY/JhUqK3+TyHswj1mbPsypitktyAVLXv2QaLVqmO8SS3nyLEpcCFdCntq36odpqE65OQrWd4806tp6rrowTbJe5/8cV1JLd02ruoTyBnr3/c52xj0M4h+y64I2IpD7WsvTWBUQbwOsCqBCaVpJ1nb+ZvddcI9b8WJ3FEHv1Ng5uiPU98jUwr3jcYw4H0e+jMb078I0oz1hdFe0nUTQN4hIcKGaJDX4wG0L17lH7SLQVzgePlCDVSEZif//DKolQ6onm/78ChvURYN6Rldwwy/w14L3BfwEKl3Dc4g8b3xXwQKAiZIsRRXFHtw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(5660300002)(2906002)(41300700001)(36756003)(31686004)(66476007)(66946007)(66556008)(6512007)(316002)(6636002)(83380400001)(6506007)(38100700002)(6666004)(53546011)(478600001)(6486002)(2616005)(26005)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WU03SGlhaGdrbTFpUHZXazYwSEhxT2VXdDlCd1lxaG9FM0l4dnNZMXZ4ZnhO?=
 =?utf-8?B?anRSRE9xbDEzKzVnNjBOWmYwVlAyL3NhZFFCZDRIMUxSQ3I0N0FBWVFxWjhl?=
 =?utf-8?B?Y3BMVkRlQm14d3RzVTc1UUxSNmhYVXRHZVhzTFNKMzQwM2pFY1pqVm1QTG8w?=
 =?utf-8?B?Q0I5N3IrbWE1eXkyellBZGtpRVI4dXB2Q1QwVlJUallMSUxNbnlDVDBPdTVZ?=
 =?utf-8?B?WGRNRm1vY200aTIzMExtdGxiRUFUeUM3VTAzdU9jcUlMYi9vSkVQK0kvYWUr?=
 =?utf-8?B?QlR6Y2JtVDYraU9xcTVEMWp3Y3NxckxCbHVaU2xJSHMrZENOOXF0c253TW5r?=
 =?utf-8?B?cjJTNHBYdFFpaFdMTlBMaWN6ZnpwTi9mbFJuOVhBZUoxcVY4UUZSZjFRdzFr?=
 =?utf-8?B?RnZMRjlLZ1hvd0o2MjRubDNzZDdTTjRYa09IZm9UUGMrdzNGNmJDTW8xZ215?=
 =?utf-8?B?alowVmtKdFFtc252OG5YbEljWmpJbG45MG5pRTI3Wm1qMlVvdUVJSzhCdnEy?=
 =?utf-8?B?cHVUampVcDZzS2dSVzBxU1VFcDE1M2xuN0tTSVdYNDVjUTI4TFJ3UEcrVUlN?=
 =?utf-8?B?RHhicjd1VnIwSXgwMHVPNGlEemc5RVZzR2Y0cjNiSVZRbzBqeUFXY2pUVUwz?=
 =?utf-8?B?bjdCa2ZkZVg1ckRVS1JVZXozclpydkk5V0pnUW8xejVFcitqclo1b25nUytj?=
 =?utf-8?B?bHorSE1tNVg2RTF1V051VFpValdmdTkvSDk0WHFKYmZCeFJ1dmpvWE1tNU1t?=
 =?utf-8?B?bm9UWHNkNE41VDhxQStiMmZabnpzUEgyZGJQZXZDYXRRQzZMYm1VQXFZNTJN?=
 =?utf-8?B?QUVPMC9MY0oyWFhVMGJDTXQ1MVBDQlJoNnE4cG42OUx6Y3ZYTG9iZXN6NXBX?=
 =?utf-8?B?K0JRbWkvbERNTEF1SnIxdWorWWRscTBMTU5EUWJSQTZNTFZCMEFYRFp5UUJS?=
 =?utf-8?B?Ris2dDlmbGxRT3ovZnRHNDVaRGMvWEJLbE54by8vOVF3ejJrSmVjSzZacHRt?=
 =?utf-8?B?OVcyWDM2R25qM1l2clA2RFFvQ202ZGpqSlh0QzdkWklFeUJUSkxhVjVFOFpo?=
 =?utf-8?B?a2N1S0g5T1VDenRHRkZocGhpUWNLdGpQTUtVTVRuVmppbTZvNVpTYzZjVWgz?=
 =?utf-8?B?YXVRcllRM3ZxOTJ5NHF6NC9PVkh2a0QxclpXZnhxajF1ekVTaE9ITGZwaXNY?=
 =?utf-8?B?OFNnUlFIV2Vsam14M3plYVVhNFJlQWNGVWFLV0p4eGx3bUtMYW5wSjBzNHpz?=
 =?utf-8?B?MGpFb3ZlZ2ptV3V2Qkg0ak54YW9Ua0hwbm9heWw5NDNqaE5kb0RwZnJXcXZD?=
 =?utf-8?B?N0s1VDN3b3hzMWNNaERMMFNtejNWa3N1Y0h1VjI5QXNjekY2ZE1CMXg5M080?=
 =?utf-8?B?d2h2VGd4WWtpdTRmUVdHd3pUcE4wTkhSQ0w4T1FtMjFFWXNOeVhQSnVMWEc2?=
 =?utf-8?B?eElaWkNvNFI5Q0RrZVpkSlFUVDUwRXZXbEc4M2V1UDcxUEZTWVQ4NGVGeFNo?=
 =?utf-8?B?V3I2cVBxcVBjdEFEWE9VajRzd3V1blUvY2h4YnVnSWJtNmpPUXRhSGpPU1hB?=
 =?utf-8?B?eUVHVWMzdUdvd08xWkJCTFlwdGNBOGs4M1J2bFY5T0xqc2Y3aDBJQzQ3dnlR?=
 =?utf-8?B?VmRtR1hlVERWMDZSRlN0YlJCVXgxdGRFR0ZuVVRTOGkyWjlhWC9Hd0QyVnRP?=
 =?utf-8?B?TGo3SHRZZEo5U3Npc1NkVFY4d2lUYkQrMFVJeHViOUJDVk81VnZjTWwxWGlQ?=
 =?utf-8?B?aTY3WjZscUNnaUxzb0JObGszYzFpVy9WTGVhWGRzbElrSUdTbGRKM3AwWmZv?=
 =?utf-8?B?VTFrcW9BN2FQK1A3bVYvNi9IcXNzYjlvYVZvOWRJMUtMN2lLdm54SDVUeEpy?=
 =?utf-8?B?em1wb3BYU1RJdVR4REZyQnI2eXVxZnpBcytIbEY0andob2xpaXFMcTByV0ty?=
 =?utf-8?B?NWgwS2hWTk83SEJGdVZZRHozSVozZVJuV2w1bzdaUnZxeWxDYnlMWXk4U1Vs?=
 =?utf-8?B?Q2UxTVEzOWFyVk0zNlpqU2lGOVVJSGRsSXVLWldOY2lxL2RFMUwwNngxcUhq?=
 =?utf-8?B?OUp5blh0WjlxQVp2KzlGcTRVa01DNDVNeUk3bTh5ZnVnbGRUZ1VHZ2d3bDhQ?=
 =?utf-8?Q?W2r2JRPFFgBHQz3bRaW5QigoH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff9a58-20e7-425a-a4f7-08dc1d69ba9e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:51:52.2692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8a53SU4UU9yqb7KXVV5ZxNMnYHH3zWtSYkL5rN4GQJ4bawkK1cZcz9tWpIc1Wjlk7Yxc3Zoaf0HvJIyTVkekg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Hi Srinivas,


On 1/9/2024 11:30 PM, Srinivas Pandruvada wrote:
> Instead of assuming that every channel defined statically by
> als_channels[] is present, assign dynamically based on presence of the
> respective usage id in the descriptor. This will allow to register ALS
> with limited channel support. Append the timestamp as the last channel.
>
> When not all usage ids are present, the scan index is adjusted to
> exclude unsupported channels.
>
> There is no intentional function changes done.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v3:
> Addressed comments from Jonthan:
> 	- Remove channel allocation and move to iio_priv()
> 	- Parse all usage IDs in a single loop and continue
> 	for failure. This way the temperature and chromaticity
> 	will not need any special processing to parse usage ids.
> 	- Don't leave empty channel indexes
>
> v2:
> New change
>
>  drivers/iio/light/hid-sensor-als.c | 56 +++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 5cd27f04b45e..72a7c01c97f8 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -25,17 +25,26 @@ struct als_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info als[CHANNEL_SCAN_INDEX_MAX];
> +	struct iio_chan_spec channels[CHANNEL_SCAN_INDEX_MAX + 1];
>  	struct {
>  		u32 illum[CHANNEL_SCAN_INDEX_MAX];
> +		u32 scan_index[CHANNEL_SCAN_INDEX_MAX];
>  		u64 timestamp __aligned(8);
>  	} scan;
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
>  	int value_offset;
> +	int num_channels;
>  	s64 timestamp;
>  };
>  
> +/* The order of usage ids must match scan index starting from CHANNEL_SCAN_INDEX_INTENSITY */
> +static const u32 als_usage_ids[] = {
> +	HID_USAGE_SENSOR_LIGHT_ILLUM,
> +	HID_USAGE_SENSOR_LIGHT_ILLUM,
> +};
> +
>  static const u32 als_sensitivity_addresses[] = {
>  	HID_USAGE_SENSOR_DATA_LIGHT,
>  	HID_USAGE_SENSOR_LIGHT_ILLUM,
> @@ -216,11 +225,14 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  	struct als_state *als_state = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  	u32 sample_data = *(u32 *)raw_data;
> +	int scan_index;
>  
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_LIGHT_ILLUM:
> -		als_state->scan.illum[CHANNEL_SCAN_INDEX_INTENSITY] = sample_data;
> -		als_state->scan.illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_INTENSITY];
> +		als_state->scan.illum[scan_index] = sample_data;
> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_ILLUM];
> +		als_state->scan.illum[scan_index] = sample_data;

Could you please use original above change which works fine for some reason if
we use this change als_state->scan.scan_index we are getting garbage value. 

>  		ret = 0;
>  		break;
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
> @@ -237,27 +249,39 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  /* Parse report which is specific to an usage id*/
>  static int als_parse_report(struct platform_device *pdev,
>  				struct hid_sensor_hub_device *hsdev,
> -				struct iio_chan_spec *channels,
>  				unsigned usage_id,
>  				struct als_state *st)
>  {
> -	int ret;
> +	struct iio_chan_spec *channels;
> +	int ret, index = 0;
>  	int i;
>  
> +	channels = st->channels;
> +
>  	for (i = 0; i <= CHANNEL_SCAN_INDEX_ILLUM; ++i) {

Could you please change CHANNEL_SCAN_INDEX_ILLUM to CHANNEL_SCAN_INDEX_MAX
which helps remaining 2 patches in the series. 

>  		ret = sensor_hub_input_get_attribute_info(hsdev,
>  						HID_INPUT_REPORT,
>  						usage_id,
> -						HID_USAGE_SENSOR_LIGHT_ILLUM,
> +						als_usage_ids[i],
>  						&st->als[i]);
>  		if (ret < 0)
> -			return ret;
> -		als_adjust_channel_bit_mask(channels, i, st->als[i].size);
> +			continue;
> +
> +		channels[index] = als_channels[i];
> +		st->scan.scan_index[i] = index;
> +
> +		als_adjust_channel_bit_mask(channels, index, st->als[i].size);
> +		++index;
>  
>  		dev_dbg(&pdev->dev, "als %x:%x\n", st->als[i].index,
>  			st->als[i].report_id);
>  	}
>  
> +	st->num_channels = index;
> +	/* Return success even if one usage id is present */
> +	if (index)
> +		ret = 0;
> +
>  	st->scale_precision = hid_sensor_format_scale(usage_id,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
> @@ -293,15 +317,7 @@ static int hid_als_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->channels = devm_kmemdup(&pdev->dev, als_channels,
> -					   sizeof(als_channels), GFP_KERNEL);
> -	if (!indio_dev->channels) {
> -		dev_err(&pdev->dev, "failed to duplicate channels\n");
> -		return -ENOMEM;
> -	}
> -
>  	ret = als_parse_report(pdev, hsdev,
> -			       (struct iio_chan_spec *)indio_dev->channels,
>  			       hsdev->usage,
>  			       als_state);
>  	if (ret) {
> @@ -309,8 +325,14 @@ static int hid_als_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	indio_dev->num_channels =
> -				ARRAY_SIZE(als_channels);
> +	/* Add timestamp channel */
> +	als_state->channels[als_state->num_channels] = als_channels[CHANNEL_SCAN_INDEX_TIMESTAMP];
> +	als_state->channels[als_state->num_channels].scan_index = als_state->num_channels;
> +
> +	/* +1 for adding timestamp channel */
> +	indio_dev->num_channels = als_state->num_channels + 1;
> +
> +	indio_dev->channels = als_state->channels;
>  	indio_dev->info = &als_info;
>  	indio_dev->name = name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;


