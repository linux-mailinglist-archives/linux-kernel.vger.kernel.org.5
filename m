Return-Path: <linux-kernel+bounces-141363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFB8A1D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C2C1F24449
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519E6165FC1;
	Thu, 11 Apr 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G4rapfdl"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09FC4DA16;
	Thu, 11 Apr 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854714; cv=fail; b=ldZ/BjppDUv4UUGQPYusbpOi/3DOYrqqzodNtWfa/BUzWgnOBcJ0JrOtfSB/TZHMySRmk3y0QcSU0foMZ6uFJ541WUU77KplTtKHpehyF0L/vEGbEo8UBduGBSoVyIcVCxH/08HyBwc2wMHppilZuffo/NpQLKn0hXaDaPfhS4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854714; c=relaxed/simple;
	bh=8+qKE2kXrdfhF4+SloIgfF4yBHrfwhdN0Ik7nhFmbg8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oSm9w8ZyvmcLZUow9IhLn2D3p3vWieV/YofMZs/5HrIBSvHDg3p4o3X4PoCVbQtoQRzWHT9JC1wW6quSD/ki6bHAAtfNPkhWbVIne0vOnBoYs/iKMaRrTqvKsZJNXVZbuAHHC8lNO0+UBF/Rih4d7dj9wQsQOGp2NrZY73lpbPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G4rapfdl; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhpGOrMsGxLev/KjCEWNOaviJQhI9m396F4IsaWgOXjFJ5/tvSQqIt58wIoPdb9+SWmqgO4E0YBQhHQni0PZxYtorQVbKMSd2YLRy8wJi9ysbQPtpJ0r0Z8cWHen9gGP1gPYd9dcDsB1e7CmNE/hRCJJzx0B8Im8UtF5zUVEtBFh/Jw2CVQb7KxPPMjivCz+f14D3N3JektPFx8zIy/qSxeCvCR+URXE+FMXtr5J7H/gpx+6OwCyt2C31q+B6CKBeFZWuXqYFG1EjSIDxJHLd79yMjJ7h4aWtFcZVKvaOgZMt900w0pTjR6SVc7FvoIgTDAmxUryLCjcFXSK2R768Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzfDGp2qcpxtn/xUO9qkSWPh4zsTJw174v0Tr7DTK7Y=;
 b=UFFd8X/yqED2D5kNbgPubFGX/AotKtXNyph2gvTCA1MHLwHDBPhD0u4zDoGGBKd0K/UMxPdfbZ0MTa7tMU98pg/YjqwOyRHtz5rufpBfK26bL3ZUGQ17IhF6HgqN3Er+G9gUxEiiRx+CMEr12UF47CS2ffmMWhMVLqTGDaYvgXizkY4vqdKlEwSz7IxJ3r5NbuVNv7VDq/Jpyl6vkp/K+On6i5oniAshv2+ulryXI3NP52ON3bXgpLhvx9hZcdYVIZeHYENMF+3iL1yjt/1zdd2ElgZGS9V9KSmUAXQM3tqL3igrYPIxomXuACBaCpU8WjPjv6Sjggg9QqM7hoylGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzfDGp2qcpxtn/xUO9qkSWPh4zsTJw174v0Tr7DTK7Y=;
 b=G4rapfdlx/XuALLBBwAWGMChzvTNk3jXnJyhxj4e3sL9CjfS4elkHCrryLiDcWOpwvFfNIWrJEV41H1v7PbJ9K9QYG+oaft72xzz7QQJmwEfq9KWaMRf3YoCuu4CSk/L5DVtx/q9gOs889bHek9E9Pad8RA484Cxab9NeYJwFkg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 16:58:27 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::8b3e:57e8:d574:309a%4]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 16:58:27 +0000
Message-ID: <9cf2cdca-b02d-494a-b37e-78df1f925c4d@amd.com>
Date: Thu, 11 Apr 2024 11:58:23 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v14 4/4] remoteproc: zynqmp: parse TCM from device tree
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: andersson@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, michal.simek@amd.com, ben.levinsky@amd.com,
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240408205313.3552165-1-tanmay.shah@amd.com>
 <20240408205313.3552165-5-tanmay.shah@amd.com> <ZhbFfA7toAkUATfg@p14s>
 <0f62cb47-23bd-41bd-a713-ac9f37a1ec7b@amd.com> <ZhgL8/hJZTJnDYuN@p14s>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <ZhgL8/hJZTJnDYuN@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e1fc09-e7cc-4615-1f3a-08dc5a489b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZaJjIs8GgmSqTeONwTx1sra2fqn2ggUOz52oYxfWO+kA/LC5vE5QL448bBREZj4/dywb4UKT6iWInIWvwE+n0b+bfeiSXrxklxyuQVkC1DSI06LlOQ4VYd2eklCguhPn1VjRfrM98cLH0qzJh57zvcOuhgd4bgoq96iXAUFVBzu7/4kjSp5s3zG34N6PUi0l6iEKSZ3KIMiDzliqT7cIADfARP5gG5s6ziURXi1gNQab8LpDVR2fflv1ZXHCEpu2/qOVtzqZKAtqg4r/11bqGgMsqnqLQkOW5CIC/A+TW0wfkTHZo05l1xTIMuat6rExwB2PrqDgxUHke7olvYVDHyWhlDyi54WkAL6irolEQAJ2G9HnXpUHxL/2ketKpVPJO3V9eNg7ooj4gGLdtDoL6XLLRZHQg6g4g7SqjDB9ZkM9UNnZcV6QzQNkPZ6mwmjaeoh0pC3H0/1/V3YttVpBhS0UtvQ0XTsblyQM7h0ipXvrFVWdWQs0LOwBkXharr9Paiv5cH0WD3g6UgH19Vr/mGommsSsdJl1KqSmmjmCERi6vY9SNMoH8djaEMvGTp87UtfKpjQRmUrS6VbfzfeYlZcoli4OdDulDx7gfvSBlGZbf3iSKN4Hs3DofW9/mPL64rdI1OvsjsGawIw/sQ0RSOUrfEEpbqJ3CWp6shhZ09E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlpUWFVPdm93NlcvTXBMeGI1NXlWck12L3Bwa0Q5VUFDVHFYYjR0cnFGQmhD?=
 =?utf-8?B?VzVQbGg2TXdmT3V3ZnBBdFVXTXIzUXJrQm5vVXdBdFRWMTVWbE1FUGsxRzNM?=
 =?utf-8?B?V0lyQnI4VlZUeE84RUtZZ1J4dVlES0JVWEZoUkFQL083U3crNWxqUk9kUDZY?=
 =?utf-8?B?MGRReWpUanlmQlhaTkxBUlFMY3A3YmJIa1o2cW9LR0hxQWJMZDhRL3RJSDVB?=
 =?utf-8?B?NHlIV25EVHJtdDRTbHRCS3hmckNnaENzZUFncjEyN012ZHovd3E5RU1yYVAy?=
 =?utf-8?B?VnRKK0VySmtxMnZlazRML1ZudU9LeFBHSERIaHpIVDN4bWpFRVg2MVY2ZWQv?=
 =?utf-8?B?VTFVL3JXdlJRZ2l2SElDaW5hanVXUHhlSE1Za3hMbDBnM1EvbGV5TmhKQVVv?=
 =?utf-8?B?VWd4eG15SS80REY1aFEzNFBWK1d2N1F4MnFtdDZVcHdNejI2SEVoNWF2R2o2?=
 =?utf-8?B?NWVVWVF3QXVSNENiTERtT1RHUkRxSTBJS1lZV0JHS3F5blBUS2ZWeG5RTmJ0?=
 =?utf-8?B?dm5OcmN1enNWQm5IYVFKWXdZMlhIbFo4QWxTZnQySVkwcUFnZTIwYWJUVjNy?=
 =?utf-8?B?VTlha2svVUNjd3VMaDhNSW1aSmtFYzg3RHBkME5RcHlMaGR1ZEZTU0lzUUpS?=
 =?utf-8?B?TGlkV1k0eC9NSTZ4bldvam5UZnNWMTRQdDEvUXc1Sk8zMlRTc0lRS3VuQmdo?=
 =?utf-8?B?NmxuUzRpQVJ5QlNLU21QVXpqelZZd2NRbWtXSVFFOUhoMXRNMjYxSTNlY2NI?=
 =?utf-8?B?dHBCMEkxMVNPTkt5Rm42YjA1dkliZDNyK1BiRGdGcyttNmYrRFdGSDkzQlpV?=
 =?utf-8?B?QmI2SEFOcVJ1TkpqVHA1UGM4UDZONmYyaUp3T2E0bS85Z0hTZWU3dnJOMS81?=
 =?utf-8?B?QUc0MVRhaTdCdGRRKzBURUpvZXk1NXhIbklGdU1RY3JsZXFjSHBjRjZqai8z?=
 =?utf-8?B?Y00rYmNiWjhpY05ZTjFqOEQyczhoU1RrODB4bjZSYnFCRWZBZmhVb0pQeVds?=
 =?utf-8?B?OTdZQUVkNXlYcmFrTXArMDRWbHNYM2E0SVZ4ODNHeko4Z1VFOHB5YmozUi9u?=
 =?utf-8?B?UkxHa1ZtWWovVWdScnZuUmhpcEZpVldqVzh1M3Jrc0JSMzBlNXdiTFgraExB?=
 =?utf-8?B?QXZtNXRtem11U3hEaTRJa0p1MzlPNlZIT1BhcWVla1ZnK2JhQm0wbk5JREhP?=
 =?utf-8?B?enVndy9jM2NMdmVVb2hqNmErSzRsekNSdDA1dEUxQ0FBVXpMQW92Wis2WVp1?=
 =?utf-8?B?bFBMUkNkb3M2NndSakh6YUdRZU1scVUxR05kWitDWjRZWmxDQjU4UE0xRjN5?=
 =?utf-8?B?TFhubExTa0VJbkxydllRVzkrc3JzNlVGM3NxRld1Y3k0Y2luTXdBQjlDOXJC?=
 =?utf-8?B?UTlzUkVwaHZlcEU4c1hielhHTkRIRlBrd1lvWG11cnRRWGxOVDBqbXRRYnIx?=
 =?utf-8?B?Y21XcUNBMFIxR3NQLzE0WVNHQXI5OTgrUVIzcWo5ajRienk5andMa0pPSGgr?=
 =?utf-8?B?U2dCVTROeE1Oeko5SG5EQ2ZLaXNDazNaUmdJSHpWMG9PdXlhU0tmVHpOTVE3?=
 =?utf-8?B?b3AyZXB0QzNDUFNveFdmdkt2UjNBL2pTWTcxdVVjNXFCOXh0VDB1dHUvbC8x?=
 =?utf-8?B?SDExRThzdDRsWENIekxiRW5DZ0VubTc3YXFadUJoUjhGNUx5YXF2dWx3U1pu?=
 =?utf-8?B?TWtGQzZCOFpjbEhPdW1mWFRRaHIzam1MT0NjYkNIekpsNjgvTHZaZDc3dDFZ?=
 =?utf-8?B?RmtLVC9LN21jVEFMb3d4OUlzZXJVMkR0UFg1UHNnRnBqY0o0bEQ4UjNodUlG?=
 =?utf-8?B?M3V2WUlGeWl4VHV0MUxMVUVQa3pxZ2lYd013cnpCd0JJTWFIcXVWaytBT1ZO?=
 =?utf-8?B?N0oxQzYwbE82Sk5pVitQZUhvWXdzaFVwV2R3dTJsWTBJZkN2S29CUEVERVFH?=
 =?utf-8?B?WnNrbDIwS2U4emtWMUEyRUpHU0xLZG5UeGlVaTlqb0w3RTJwWmFvRW5BenlO?=
 =?utf-8?B?UFVyb0FXNnE5dXdtazAvbERGYVhVaThWZHVnNFZyZHJXaDk4QTlvaVUvSTJ0?=
 =?utf-8?B?M3BXWi96amhLYWcxN0tYc05mamVEWDUyaE1vbHkrendUL1JMa05tV2lQQzIx?=
 =?utf-8?Q?sLUkwGw0iC4B6OlNu0qrUPGnY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e1fc09-e7cc-4615-1f3a-08dc5a489b76
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:58:27.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybEhPoKhkDDJxKwz65Xag3CDGY+exe8e5hyxn/V6XejTIoYJ6yLyEThFBeXczlgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032



On 4/11/24 11:12 AM, Mathieu Poirier wrote:
> On Wed, Apr 10, 2024 at 05:36:30PM -0500, Tanmay Shah wrote:
>> 
>> 
>> On 4/10/24 11:59 AM, Mathieu Poirier wrote:
>> > On Mon, Apr 08, 2024 at 01:53:14PM -0700, Tanmay Shah wrote:
>> >> ZynqMP TCM information was fixed in driver. Now ZynqMP TCM information
>> >> is available in device-tree. Parse TCM information in driver
>> >> as per new bindings.
>> >> 
>> >> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>> >> ---
>> >> 
>> >> Changes in v14:
>> >>   - Add Versal platform support
>> >>   - Add Versal-NET platform support
>> >>   - Maintain backward compatibility for ZynqMP platform and use hardcode
>> >>     TCM addresses
>> >>   - Configure TCM based on xlnx,tcm-mode property for Versal
>> >>   - Avoid TCM configuration if that property isn't available in DT 
>> >> 
>> >>  drivers/remoteproc/xlnx_r5_remoteproc.c | 173 ++++++++++++++++++------
>> >>  1 file changed, 132 insertions(+), 41 deletions(-)
>> >> 
>> >> diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> >> index 0f942440b4e2..504492f930ac 100644
>> >> --- a/drivers/remoteproc/xlnx_r5_remoteproc.c
>> >> +++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
>> >> @@ -74,8 +74,8 @@ struct mbox_info {
>> >>  };
>> >>  
>> >>  /*
>> >> - * Hardcoded TCM bank values. This will be removed once TCM bindings are
>> >> - * accepted for system-dt specifications and upstreamed in linux kernel
>> >> + * Hardcoded TCM bank values. This will stay in driver to maintain backward
>> >> + * compatibility with device-tree that does not have TCM information.
>> >>   */
>> >>  static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
>> >>  	{0xffe00000UL, 0x0, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
>> >> @@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
>> >>  		dev_warn(dev, "failed to send message\n");
>> >>  }
>> >>  
>> >> -/*
>> >> - * zynqmp_r5_set_mode()
>> >> - *
>> >> - * set RPU cluster and TCM operation mode
>> >> - *
>> >> - * @r5_core: pointer to zynqmp_r5_core type object
>> >> - * @fw_reg_val: value expected by firmware to configure RPU cluster mode
>> >> - * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
>> >> - *
>> >> - * Return: 0 for success and < 0 for failure
>> >> - */
>> >> -static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
>> >> -			      enum rpu_oper_mode fw_reg_val,
>> >> -			      enum rpu_tcm_comb tcm_mode)
>> >> -{
>> >> -	int ret;
>> >> -
>> >> -	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> >> -	if (ret < 0) {
>> >> -		dev_err(r5_core->dev, "failed to set RPU mode\n");
>> >> -		return ret;
>> >> -	}
>> >> -
>> >> -	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> >> -	if (ret < 0)
>> >> -		dev_err(r5_core->dev, "failed to configure TCM\n");
>> >> -
>> >> -	return ret;
>> >> -}
>> >> -
>> >>  /*
>> >>   * zynqmp_r5_rproc_start()
>> >>   * @rproc: single R5 core's corresponding rproc instance
>> >> @@ -761,6 +731,103 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
>> >>  	return ERR_PTR(ret);
>> >>  }
>> >>  
>> >> +static int zynqmp_r5_get_tcm_node_from_dt(struct zynqmp_r5_cluster *cluster)
>> >> +{
>> >> +	int i, j, tcm_bank_count, ret, tcm_pd_idx, pd_count;
>> >> +	struct of_phandle_args out_args;
>> >> +	struct zynqmp_r5_core *r5_core;
>> >> +	struct platform_device *cpdev;
>> >> +	struct mem_bank_data *tcm;
>> >> +	struct device_node *np;
>> >> +	struct resource *res;
>> >> +	u64 abs_addr, size;
>> >> +	struct device *dev;
>> >> +
>> >> +	for (i = 0; i < cluster->core_count; i++) {
>> >> +		r5_core = cluster->r5_cores[i];
>> >> +		dev = r5_core->dev;
>> >> +		np = r5_core->np;
>> >> +
>> >> +		pd_count = of_count_phandle_with_args(np, "power-domains",
>> >> +						      "#power-domain-cells");
>> >> +
>> >> +		if (pd_count <= 0) {
>> >> +			dev_err(dev, "invalid power-domains property, %d\n", pd_count);
>> >> +			return -EINVAL;
>> >> +		}
>> >> +
>> >> +		/* First entry in power-domains list is for r5 core, rest for TCM. */
>> >> +		tcm_bank_count = pd_count - 1;
>> >> +
>> >> +		if (tcm_bank_count <= 0) {
>> >> +			dev_err(dev, "invalid TCM count %d\n", tcm_bank_count);
>> >> +			return -EINVAL;
>> >> +		}
>> >> +
>> >> +		r5_core->tcm_banks = devm_kcalloc(dev, tcm_bank_count,
>> >> +						  sizeof(struct mem_bank_data *),
>> >> +						  GFP_KERNEL);
>> >> +		if (!r5_core->tcm_banks)
>> >> +			return -ENOMEM;
>> >> +
>> >> +		r5_core->tcm_bank_count = tcm_bank_count;
>> >> +		for (j = 0, tcm_pd_idx = 1; j < tcm_bank_count; j++, tcm_pd_idx++) {
>> >> +			tcm = devm_kzalloc(dev, sizeof(struct mem_bank_data),
>> >> +					   GFP_KERNEL);
>> >> +			if (!tcm)
>> >> +				return -ENOMEM;
>> >> +
>> >> +			r5_core->tcm_banks[j] = tcm;
>> >> +
>> >> +			/* Get power-domains id of TCM. */
>> >> +			ret = of_parse_phandle_with_args(np, "power-domains",
>> >> +							 "#power-domain-cells",
>> >> +							 tcm_pd_idx, &out_args);
>> >> +			if (ret) {
>> >> +				dev_err(r5_core->dev,
>> >> +					"failed to get tcm %d pm domain, ret %d\n",
>> >> +					tcm_pd_idx, ret);
>> >> +				return ret;
>> >> +			}
>> >> +			tcm->pm_domain_id = out_args.args[0];
>> >> +			of_node_put(out_args.np);
>> >> +
>> >> +			/* Get TCM address without translation. */
>> >> +			ret = of_property_read_reg(np, j, &abs_addr, &size);
>> >> +			if (ret) {
>> >> +				dev_err(dev, "failed to get reg property\n");
>> >> +				return ret;
>> >> +			}
>> >> +
>> >> +			/*
>> >> +			 * Remote processor can address only 32 bits
>> >> +			 * so convert 64-bits into 32-bits. This will discard
>> >> +			 * any unwanted upper 32-bits.
>> >> +			 */
>> >> +			tcm->da = (u32)abs_addr;
>> >> +			tcm->size = (u32)size;
>> >> +
>> >> +			cpdev = to_platform_device(dev);
>> >> +			res = platform_get_resource(cpdev, IORESOURCE_MEM, j);
>> >> +			if (!res) {
>> >> +				dev_err(dev, "failed to get tcm resource\n");
>> >> +				return -EINVAL;
>> >> +			}
>> >> +
>> >> +			tcm->addr = (u32)res->start;
>> >> +			tcm->bank_name = (char *)res->name;
>> >> +			res = devm_request_mem_region(dev, tcm->addr, tcm->size,
>> >> +						      tcm->bank_name);
>> >> +			if (!res) {
>> >> +				dev_err(dev, "failed to request tcm resource\n");
>> >> +				return -EINVAL;
>> >> +			}
>> >> +		}
>> >> +	}
>> >> +
>> >> +	return 0;
>> >> +}
>> >> +
>> >>  /**
>> >>   * zynqmp_r5_get_tcm_node()
>> >>   * Ideally this function should parse tcm node and store information
>> >> @@ -839,9 +906,16 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>> >>  	struct zynqmp_r5_core *r5_core;
>> >>  	int ret, i;
>> >>  
>> >> -	ret = zynqmp_r5_get_tcm_node(cluster);
>> >> -	if (ret < 0) {
>> >> -		dev_err(dev, "can't get tcm node, err %d\n", ret);
>> >> +	r5_core = cluster->r5_cores[0];
>> >> +
>> >> +	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
>> >> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
>> > 
>> > The previous patch moved the definition of the R5FSS to the new bindings but
>> > this is forcing to use the old bindings - did I something?
>> 
>> Hi Mathieu,
>> 
>> We need to maintain backward compatibility for zynqmp device. So, using old bindings
>> for zynqmp. For new devices (Versal and Versal-NET) new bindings are enforced in driver.
>> It's not recommended to map two programming sequences to same device. So for
>> "xlnx,zynqmp-r5fss" device old bindings are used.
>>
> 
> You are not using two programming sequences for the same device, you are simply
> ensuring backward compatibility for older device tree.  The bindings for r5fss
> have been updated so the driver should be using the new method.  You have used
> "xlnx,tcm-mode" to switch between new and old bindings, do that here too.
> 

Okay. That means checking on "reg" property as it was done before.

> I'm also not sure why Versal and Versal-NET are being added to this patchset...
> It should be in another patchset of its own.
> 

For driver I am okay to send new patchset, but for bindings I prefer to keep it.
This was discussed with Krzysztof earlier.

>> Device tree is matching with new bindings. But that's hardware description. I believe,
>> driver can still choose to use hardcode addresses to maintain backward compatibility.
>> 
>> The end result will be same.
>> 
>> Thanks,
>> Tanmay
>> 
>> > 
>> >> +		ret = zynqmp_r5_get_tcm_node(cluster);
>> >> +	else
>> >> +		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
>> >> +
>> >> +	if (ret) {
>> >> +		dev_err(dev, "can't get tcm, err %d\n", ret);
>> >>  		return ret;
>> >>  	}
>> >>  
>> >> @@ -856,12 +930,18 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
>> >>  			return ret;
>> >>  		}
>> >>  
>> >> -		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
>> >> -		if (ret) {
>> >> -			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
>> >> -				cluster->mode, ret);
>> >> +		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
>> >> +		if (ret < 0) {
>> >> +			dev_err(r5_core->dev, "failed to set RPU mode\n");
>> >>  			return ret;
>> >>  		}
>> >> +
>> >> +		if (device_is_compatible(dev, "xlnx,zynqmp-r5fss") ||
>> >> +		    of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL)) {
>> >> +			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
>> >> +			if (ret < 0)
>> >> +				dev_err(r5_core->dev, "failed to configure TCM\n");
>> >> +		}
>> >>  	}
>> >>  
>> >>  	return 0;
>> >> @@ -906,16 +986,25 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
>> >>  	 * fail driver probe if either of that is not set in dts.
>> >>  	 */
>> >>  	if (cluster_mode == LOCKSTEP_MODE) {
>> >> -		tcm_mode = PM_RPU_TCM_COMB;
>> >>  		fw_reg_val = PM_RPU_MODE_LOCKSTEP;
>> >>  	} else if (cluster_mode == SPLIT_MODE) {
>> >> -		tcm_mode = PM_RPU_TCM_SPLIT;
>> >>  		fw_reg_val = PM_RPU_MODE_SPLIT;
>> >>  	} else {
>> >>  		dev_err(dev, "driver does not support cluster mode %d\n", cluster_mode);
>> >>  		return -EINVAL;
>> >>  	}
>> >>  
>> >> +	if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
>> >> +		if (cluster_mode == LOCKSTEP_MODE)
>> >> +			tcm_mode = PM_RPU_TCM_COMB;
>> >> +		else
>> >> +			tcm_mode = PM_RPU_TCM_SPLIT;
>> >> +	} else if (of_find_property(dev_node, "xlnx,tcm-mode", NULL)) {
>> >> +		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
>> >> +		if (ret)
>> >> +			return ret;
>> >> +	}
>> >> +
>> >>  	/*
>> >>  	 * Number of cores is decided by number of child nodes of
>> >>  	 * r5f subsystem node in dts. If Split mode is used in dts
>> >> @@ -1100,6 +1189,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
>> >>  /* Match table for OF platform binding */
>> >>  static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
>> >>  	{ .compatible = "xlnx,zynqmp-r5fss", },
>> >> +	{ .compatible = "xlnx,versal-r5fss", },
>> >> +	{ .compatible = "xlnx,versal-net-r52fss", },
>> >>  	{ /* end of list */ },
>> >>  };
>> >>  MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
>> >> -- 
>> >> 2.25.1
>> >> 
>> 


