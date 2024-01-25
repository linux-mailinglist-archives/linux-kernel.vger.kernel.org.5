Return-Path: <linux-kernel+bounces-37986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E5F83B943
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B0F1F24CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC4110971;
	Thu, 25 Jan 2024 05:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DQWniPRS"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5D3D7A;
	Thu, 25 Jan 2024 05:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706162116; cv=fail; b=RF5aLFPe9n7xud8ZQix3pWsjuaBkrSu+JDk0BJ77cSkJOUSsTJfxeYonlaKNBxoCuSCg9wCWq4VFk4X1WcF+QcUYKBMWfPMt60szMIYZnmyusQof1GrwhWlEfZzFZR5fkLT8noX3wNmJRVFa57Tt43kZgfy9IFl5OkTBAPt/3/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706162116; c=relaxed/simple;
	bh=axFTEXn9LVKOIJHVd/qk6ftBcipOqXrmBDiMrKQvaeA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U62vHiz2D3nuZnl+lAzrDXflu6PGuO0enfpNp7x9vxluOTpljorDxzdT3pltJ1MOKRG5bxosoqxrQGgJeJJ33B2AOTtDfmI6jo7QeHgm6W21I22zdsAIJiC5EWPpRIdXADP9U/KbSzv14gCiCqF4yJ5qLcwB79ivtYOFmnpopzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DQWniPRS; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vb217GR8fh+sXvkT+A1vSq8fRuZTYWVxtAOWrOUb37+dcsOujJ0wytU/KAxNB3+HO1jBYkQ9kfA+1uwpnH+TVE22pdK1pvKirZxeXHLtu12IzTVx8mTsluOJvmQEVJJsr+kJgAN6gRkxKtNAVEWsCzLlXnYNyEdfMQKYsU41Bp0jYRpwpvfM/z5Is33enCEbiTjsiVFDUjiO/kITJBmVkzL6TjZrcvIz3L9DtdyoN6eStX+anOezRian+bzvkeneBBbIArbIQgVQY05XVCmvq5CYp6eoyierLMsHRvqnY5WoH+MrFfTrIavzqta32iZvaOko9zfZSvM2fwYqUDH7Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/4+FqB5vVm7ky6074FnqYTxjLhTD+C3ogULF+q/lgQ=;
 b=bvZNrv/xMD6pEZtCN8dVo0v/Q859I6HKK4ARpmhdBKkBfeKraObFk0Vxo0MZEzOC1qPVQKDItYJ+WhuSNXNmGia6goGRUX4+IpImlNmJuRtaQWPgTFkIU5bVtUgEoCZFHNAxlUfgzWMSvQxvYCG+iubhR2XuB+3EpUgP1EZXCyD988zCDKzMJHctJqG/IW6qO7tekJWC7+/m/xFJXPtkt8pyAjXeUd88lpWZ9E3vANafw7lpn+9DbDlYYruSU4SA3VkShhPRK7b+/rreOto/u2FAa+wWPuSQLuH+Pomu56KvEVTJOI3evBwbJA+m8AGIVttU92Cv+vC9WEzijFy9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/4+FqB5vVm7ky6074FnqYTxjLhTD+C3ogULF+q/lgQ=;
 b=DQWniPRSocT9P40qCVKeR9/Yz6xERQfIi2bD3mFVbOFcB6Yo1bv4Ej/NpMxnnfnfvH9qq/d4VJC6iPOxQBdo96N1SWDZkaoXI8CEQvK3BpvpgfG45/RE/uvWdDJJ6884Nac/KLGb88G05LSG0YcA6Fexr6VnjQ7WMrttBNNFcR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 05:55:12 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 05:55:12 +0000
Message-ID: <6ad208a6-66b5-4870-8290-a1ac9b119130@amd.com>
Date: Thu, 25 Jan 2024 11:25:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: hid-sensor-als: Add light color temperature
 support
Content-Language: en-US
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 jikos@kernel.org, jic23@kernel.org, lars@metafoo.de,
 Basavaraj.Natikar@amd.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240109180007.3373784-1-srinivas.pandruvada@linux.intel.com>
 <20240109180007.3373784-4-srinivas.pandruvada@linux.intel.com>
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240109180007.3373784-4-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: c2206e28-7f37-4e11-3ec0-08dc1d6a31c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3BFf/688KSjwWPskPP27v8HmdHK69LW+aEV2e7DwiZ3i1xh255m1SgaH3FOBFv8iB6oQhVwF6MP2FY56dY5PTqq3shozGxUfd+mLvHZjIIU26A14J/DhtDYii6fROK/C+z5/IJKkmdF3MHEYZDXpWFon3X9YBJZpKMCmqOPRxABylGUrDql/xGWDnlRkH6ppbxg77CKCc92LQstUz6bWpeBm1nzHpGDeKsf1XRfsr7j/5cLo0sucA7SqyAED5PY59aHDY34J6iYEvQih0r/6GTL9TkrYs6bgp50R93YQeb0sCVAfF+0ec6WqT5Z+PGgYYQNd4tnNuSeIa9VHxlw3hRuS8Z6Sbx+bPzCj36GGJJavGBOrqidCG2ZA20e2fREOUfHEXYpLJx/uRqxZKPBd7hGGUtp+yO5rEjPa9uxlTI8/9nxagAl4P588PK36WSVb1RjbDbLl14p5ZLfImu6kup9dI79QBjojfjTzEyAS4mc1v3/RmImcrLb5FgqaU9jdaqrv3HmtFI414OTi2JW1WoY+XqaT+nxw5RAnTW/+YVa/P0mCtYgvNmoQHiPKrssbgnPy82IiRNahWRyVi8yUDOQ1imdrJ0kY0nsSAEiV/viNbk3+grtFbb7lsj524wZYdtHZ8E7xjK3JT4Y4Ckq8Hw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(31696002)(5660300002)(2906002)(41300700001)(36756003)(31686004)(66476007)(66946007)(66556008)(6512007)(316002)(6636002)(83380400001)(6506007)(38100700002)(6666004)(53546011)(478600001)(6486002)(2616005)(26005)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MGJTcVFHaEwzWmdFaUI5OHYwemY2WTRmckJ3RFp1WlpTTmtIeVFxTjFFWWxU?=
 =?utf-8?B?aUw4OUtHZWtvblY3aW1vbHdTYkRDRmVQUmdwK3IvVnRlQ3prTkVSNWVkNE5i?=
 =?utf-8?B?Q21tMTU4eDYrTy9XbmluQWlDWHljd0VqSXpSN1VtcmdURm92OHptQThJVC9M?=
 =?utf-8?B?eGpVdVllc2k4RGI1d0ZqTE1lcktub05MeVY2YXBFY21SU1hSLzFSeXlmZUtt?=
 =?utf-8?B?TXZhMmFZUE02d0szemhOUER4YlBHN0JERW9nVGhOVEl1RmcrTzZqS2xBU2hv?=
 =?utf-8?B?dTgvTTdDalJ5RHhaUFNaWHlrSXlYdUI0dWZmL1BCNDQ4L3FvKzIwU2tVR0hu?=
 =?utf-8?B?M2tjNzJ3OElwL3UwU1lJUWxvTDgvNXdUZTJpN3htQzdBZmVmRzRkbjJ6emZr?=
 =?utf-8?B?QXdEazN3UEw4bUtpbVNGTVdFYkFSRWVwcHVXeU81L00rTExSZHZxMjY0UXZW?=
 =?utf-8?B?ejV5bFNjZFkyc3JacXlSSS9hcCsyNjFSeGlhamJaaUg5Y0VKb3BhZE5UczlI?=
 =?utf-8?B?UFV5cVB2djl5aFhObUcvMnc3SkVRcE1yNTdsZ21EWlgwU3VlcUF1K0hnVU0r?=
 =?utf-8?B?QjMzbWp2QzZDNDkrVHJXa3VZTmwvUjVzWGRTMDdKd01JK0huK08vU0svNlRL?=
 =?utf-8?B?MFNDUVR2MFZkNWkwVXMrdnRnSXdQMUdmU20zMkZOZ1hVbFBhWjdsM3dNQjlT?=
 =?utf-8?B?aVhHTHAxeDRoYzErT09HQTVsL2J4T3hRbERRSUs3anFoTnpWcTdkdmV4WkJ6?=
 =?utf-8?B?VnlpODFJbGNhUFdHZmZhOUtrSytzN3RSKzBjMEc3Ylc1aXIrKzhuemEybkhm?=
 =?utf-8?B?UW9xaTVOb1dyRUc3MEpmbDVwaFlaeFU1dWZpeFNSREZhSWxCR3c0ei9Rd2p0?=
 =?utf-8?B?aTM2WSswdHZTM3ZqdWg1QmdwMnhmMEptQWZ4TVNETGZuN2dNbDVWRFZnVm9Z?=
 =?utf-8?B?N0dneFNkc3Brc3NOT3YyQmpPakJKMklLa0owN0JvUmwwekM3UWRmSWVoSkdH?=
 =?utf-8?B?Q2MycVJKNkY0cndDV1NVaEhFbTJlOG4vaFZFa0J4M1VNRU9WcVppbDJDa0dJ?=
 =?utf-8?B?U09MK2RZQVJnNVZFKzlDZ0hoVk1mcWFTYm5zczYyM1JVVER5MDVKMjJHL21L?=
 =?utf-8?B?R2JVN2NveUZTazd3KzZ0SUhPU1pzYXhVQzAxR2pxSXpQampPWERTbU5OcDRW?=
 =?utf-8?B?TkxLQkhBU1B6YXZFVWdJUWx1TjdyZ3Z3YUhtV0dDeWE5YUxodk5KRndJZCtU?=
 =?utf-8?B?OUFwcmFjU0c2bkhxMktMMm1RQ0lTSmZBcXFkSGpIdnQxaFA2c2NGQ1MwZWkw?=
 =?utf-8?B?V3FlVDFFbWQrRUM1VDNITVJCbkNEY0hBTUNBa1ZmMm5TRWdPR2VXRjkzOGVy?=
 =?utf-8?B?RUx2K3Nab1pjVU5mQ3VPMUVIREFsSU1ISnRmWDhnd0l0b0tLS1hNdEtKMWZR?=
 =?utf-8?B?QVA4KzBvT0tDbU16c0xjOUFudERJVkdhMUwxUDBUb05paHRNVnRlbWRrUS9E?=
 =?utf-8?B?c1hTNnlKLytMKzVyL0pJc3ZiZVEveDBidDhsNFVscDIwMTcwVEphWUhBUC9a?=
 =?utf-8?B?L0Z4aXEyTmp0T3FHWVF5QjBUMVZqVWJiaXB0SGFBMGRWY2FVZFBBdFRTZHZh?=
 =?utf-8?B?ZFcwLzBSdmcvTnFZUGVxd0I4SnlrRFVoQUF5Z1JTL3FwR3VYc1gyd1NwTlpV?=
 =?utf-8?B?cm8rL0JpNGYvWG5HYnJVRVFpMWwwbDhGb3Fna0Y2SnJDVGZ2WmlHcUM5NVJT?=
 =?utf-8?B?VDNkUWFoeldnVFNpVGZFZEJnQ05DN0lFeDdrUFJKWnI5YjVOUzZJdXNBbUlk?=
 =?utf-8?B?LytST1RVMWZqV1ArUWdoWHdHa0JTRTlOcVV1aVlSZkJ3dmdEc3NhNkdqRTNu?=
 =?utf-8?B?SmJXOXp1REhKYUZQcnE2cnl4K0k4WkJoMmIyZmc5dU5xZXRsS01OcG1WU05G?=
 =?utf-8?B?TVBvZStvRG9CVndwN3UwcnAyQklDdFBPa04xQVhCSVNZRC8zNVlmamRwb1Z3?=
 =?utf-8?B?NGxuejRQZU1pZFQ2ZDB0Uzh4VmpxblhRbmZLdk9rd1RDaS9Sckk4c0gxZUhO?=
 =?utf-8?B?Zk55WC94VThrTlk4eUNxSFZIbWlOaHl2QzhzaDVQZ1hzWUJ5WlA0RVhTNFlU?=
 =?utf-8?Q?bznBnxyrAFdiw9U78IdJ4X0h/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2206e28-7f37-4e11-3ec0-08dc1d6a31c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:55:12.1634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRN8Xd0JwBgJjgtRBD0iJF2YsiyAmuMWs1TwUE8i5CtFExEugTRrFu4Y9PpIZm7c7h82PCJ/D308VKj4UujLzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

Hi Srinivas,


On 1/9/2024 11:30 PM, Srinivas Pandruvada wrote:
> From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>
> On some platforms, ambient color sensors also support light color
> temperature. Add support of light color temperature.
>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>
> I don't have a system to test this patch.
> Hi Basavraj,
> Please test.

After fixing both comments in patch 1 all works fine.

Thanks,
--
Basavaraj

>
> v3:
> Simplilified as no special processing is required in als_parse_report()
> v2:
> Original patch from Basavaraj Natikar <Basavaraj.Natikar@amd.com> is
> modified to prevent failure when the new usage id is not found in the
> descriptor.
>
>  drivers/iio/light/hid-sensor-als.c | 22 ++++++++++++++++++++++
>  include/linux/hid-sensor-ids.h     |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index a7bde6b68102..0d54eb59e47d 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -16,6 +16,7 @@
>  enum {
>  	CHANNEL_SCAN_INDEX_INTENSITY,
>  	CHANNEL_SCAN_INDEX_ILLUM,
> +	CHANNEL_SCAN_INDEX_COLOR_TEMP,
>  	CHANNEL_SCAN_INDEX_MAX
>  };
>  
> @@ -43,6 +44,7 @@ struct als_state {
>  static const u32 als_usage_ids[] = {
>  	HID_USAGE_SENSOR_LIGHT_ILLUM,
>  	HID_USAGE_SENSOR_LIGHT_ILLUM,
> +	HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
>  };
>  
>  static const u32 als_sensitivity_addresses[] = {
> @@ -74,6 +76,16 @@ static const struct iio_chan_spec als_channels[] = {
>  		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
>  		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
>  	},
> +	{
> +		.type = IIO_COLORTEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS_RELATIVE),
> +		.scan_index = CHANNEL_SCAN_INDEX_COLOR_TEMP,
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(CHANNEL_SCAN_INDEX_TIMESTAMP)
>  };
>  
> @@ -112,6 +124,11 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  			min = als_state->als[chan->scan_index].logical_minimum;
>  			address = HID_USAGE_SENSOR_LIGHT_ILLUM;
>  			break;
> +		case  CHANNEL_SCAN_INDEX_COLOR_TEMP:
> +			report_id = als_state->als[chan->scan_index].report_id;
> +			min = als_state->als[chan->scan_index].logical_minimum;
> +			address = HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE;
> +			break;
>  		default:
>  			report_id = -1;
>  			break;
> @@ -235,6 +252,11 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  		als_state->scan.illum[scan_index] = sample_data;
>  		ret = 0;
>  		break;
> +	case HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE:
> +		scan_index = als_state->scan.scan_index[CHANNEL_SCAN_INDEX_COLOR_TEMP];
> +		als_state->scan.illum[scan_index] = sample_data;
> +		ret = 0;
> +		break;
>  	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
>  		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
>  								    *(s64 *)raw_data);
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index 13b1e65fbdcc..8af4fb3e0254 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -21,6 +21,7 @@
>  #define HID_USAGE_SENSOR_ALS					0x200041
>  #define HID_USAGE_SENSOR_DATA_LIGHT				0x2004d0
>  #define HID_USAGE_SENSOR_LIGHT_ILLUM				0x2004d1
> +#define HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE		0x2004d2
>  
>  /* PROX (200011) */
>  #define HID_USAGE_SENSOR_PROX                                   0x200011


