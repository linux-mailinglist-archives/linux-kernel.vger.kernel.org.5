Return-Path: <linux-kernel+bounces-65329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709CC854B41
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02E41F28E32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3585579A;
	Wed, 14 Feb 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2gwj2FAa"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD6E5576A;
	Wed, 14 Feb 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920361; cv=fail; b=J4wSpL1il+pGufIhqTRrv4h2p0kZby/0yCHDbySfdGDiQu7piGkX3JE7gRWuh/ukJn7d0K5NB2zwTmQq+ZWadWqgVo5eNB2/R7rtGS9B6CsqaJusOKFefnklUAEJmFy32dTM82TnKdY9HZ/UhwXWORO8bC/YdsKp16K5Qpo3Q98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920361; c=relaxed/simple;
	bh=M5DJPfxmt0zrlBd8gMKtGzES70WwjtxcK4Gl7ORe2fQ=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DOjsU31qg5WBB+BcFluLLrYk5FmTm5QOhCCoKT4jUmw/sS2mEOZGFPD/IGziv2ngsAdF9uv5uuacdjjEi4283buYDCuJj596epYIN1O90LtCjZNU3mnTXKl5cjiYxXUDgwrjRAOMmrR7vSypHJgFdFOO9h8DTKWVrFVLuK8QKR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2gwj2FAa; arc=fail smtp.client-ip=40.107.244.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITvhtItdP0e1NC/h+P4Hjb3cRvmHeIFh19EuNPZ5LcxG3pBkwwToKXwwAbOWdoO/zrRCVoNP3MCxq2TN0QpYiNJz2c7l84h2pjB35X3wg8cPNH59zHodcXkllBlpoBUaoEXS+WCfcSvTxy9PZW3g9YaJZuPOPAe2SR7GJc5xkMEtpx9UZ0UQP6r/PNtfhHWdIqBAkJK5dLWYZNW5A4i6wxk8+fK+cTww46/2SaRa5CEiKvSLS326c2P9sIEEGiO2mDGD2A54z5uhVgsMjGLKpRSTXsYSFIdVizyEQFRalKyQURWSU+EzWk95B6t58ibhoInjTlUFZkEXLk23GQOXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XYwS5W7EfYDiwxdiqLl4+/H62j1Qw1ZQmbYoBfmB3s=;
 b=AcbNT4w6UHrf0+8Q5UKsydC46R42/bvDKt5gL8KhRlH1pO1/PgcHyoOCG0QbA+iBBS1K5/WxgwPAlCsRPlHF7pnZtC9JttUUE82v4y9snb9P+7FG79qbPS/mF93g6C02GiyLoHdOIxW50FtIoV4NSe2Q58zn+3761/PBc3QI2OrQOOnZHwUaJRzKJyIziHiT2VxuAv5MSz8QBs9V5c8dDCiGXR4QAK87EcwHresknqbIjGnZJW8Xnid5KFaZJogRF8bjnrGoKp8BOxT/D5YvUUZ3EQJoDjA4iubnEYS4c2qq3tDCn54Ytb2anqyX6nxRRDCVn3gEoxdRi1fXhMIBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XYwS5W7EfYDiwxdiqLl4+/H62j1Qw1ZQmbYoBfmB3s=;
 b=2gwj2FAaQLfMvMz7HSQNXpb8ydP+jNISVGwc0gTzOEUe6dgalL99R/ErKik6uyQtGOf2Mo8CDIjSXOSrOn99I75JW7tEu29PG5oy3h0/ICuZ15ellaycpeFvw4F+SrU/IqaHv3k6UAZMmf8gs8HUJmapOQfA6hAy37ztb9vgGEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Wed, 14 Feb
 2024 14:19:16 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Wed, 14 Feb 2024
 14:19:16 +0000
Message-ID: <d01ef2f5-10d9-410b-a6ec-d5eca05ffda4@amd.com>
Date: Wed, 14 Feb 2024 09:19:13 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, avadhut.naik@amd.com, john.allen@amd.com,
 muralidhara.mk@amd.com, naveenkrishna.chatradhi@amd.com,
 sathyapriya.k@amd.com
Subject: Re: [PATCH 1/2] RAS/AMD/ATL, EDAC/amd64: Move MI300 Row Retirement to
 ATL
To: Borislav Petkov <bp@alien8.de>
References: <20240214033516.1344948-1-yazen.ghannam@amd.com>
 <20240214033516.1344948-2-yazen.ghannam@amd.com>
 <20240214083623.GZZcx7h_BcIWpoEmMJ@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240214083623.GZZcx7h_BcIWpoEmMJ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:408:fc::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 8268eac1-4425-4db6-460d-08dc2d67ecca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sYWWYvWRRDt9JD3Mu49btAQLcUlauW7S+22LcNK5aFcpeu0sfPYEWCWR6R6T0BdgQo4oP2p4svG4P//hxsfVnR4W3g9EkNdxJFTNbTlnufOK/TxwfJRZfy+XT/u/fYEpvbS6TUTH0nMkBvOCBGpyQRLLf2tD4IRxRg1zL93KImmVnqOWzStq4pONYESY45bucYbqEpaybYicrWPc0gl040Cf2F9AianHyfdBD73ryXqLBvZ350HRCv8Bsi1toQbEomnfYrRPPQIYizAPH2+KQo+R/WShcckwzZybIa0Zk7H+sqV+nYsjR6PZgubc3lvlVExfjy0MxBFAUc2M8nNy+eFz609NjyfKwu5sBgqXidtwEwYrAPLtgErrFMpYEkcP0WAN42cBu9qZUSENKO7VGmyrjp/XijL6mcYstXcXj1xzLwUXXa6HJJZn7xsKEG0UujoK0zSTLgZiPwIYEkxmHGuXiBzGmXmnEAPILKLmp4S7xuTDfxja+TnKdrU+7+Ow+UWcovtKBsKxhJzEvRnVyo0b5X2ey5xl4+l2xKQz+y0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8936002)(31686004)(41300700001)(6506007)(38100700002)(2616005)(6666004)(66556008)(966005)(36756003)(44832011)(4326008)(66476007)(8676002)(6916009)(316002)(5660300002)(2906002)(66946007)(26005)(6486002)(83380400001)(86362001)(31696002)(6512007)(53546011)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WCtZc045R1FJelNYRytlQWVqZE1IZmo3dkhNOTZrNXlZaWdFNGtoVFZNS3Ex?=
 =?utf-8?B?TEtBTTFFZlVjenVxWFpmMU9VU2YzQms2dDd3azRCOWxXRm5wdTB3OXB4Yzd5?=
 =?utf-8?B?WHlaN2FzdlIyZXhuUVBVOTBTNUo3bVQ2cytxL1E2akZpeStmcHBiczJLbVBo?=
 =?utf-8?B?dG5CM2ZGb3huS2NLaUpVWmN1WUt5bXljZDBINFFBbjlqbHB0OHJzUVd1UDc3?=
 =?utf-8?B?bU9wL2g4Q1pjOXMrUWVyc2dZbVh6ZUdRbk9Ecm1OOUJHZ1daZjNvbW53bVNT?=
 =?utf-8?B?ak1BeXVMZ2JMcXVUeTZwWUFudTZFRmNURytTckY4eGJoY1JoREtwUHpvUFFT?=
 =?utf-8?B?T0phUTBuYkJZT3IydGZ5Skpibjk5M2ZsREwvUnJZb2poYmlBaE01SVcwaWJQ?=
 =?utf-8?B?TjlxR1hFWURpTkczdzdjbzNERUtFS2IyU2VFMStFKzU4Rm91TnF5UnB5TTNs?=
 =?utf-8?B?NWJvQUhQa2k3dzQ2UzlMOG41RHNnZ0pBTVpqUzRrRncwR3g3aDQ3U3Q1a3V4?=
 =?utf-8?B?R2p4TVdQaHNHRlV6RGNxOFArc0I5SW9CNW1YblJUb0srR09kSEdHcTNJM2tn?=
 =?utf-8?B?d21LMEdaUjdGVUV1TUh6eHYvRHh2YlZFRmcra09Ud2p3QUZWV2pqY2lyL1Rq?=
 =?utf-8?B?UDRMeFhLVWVUSHJwOFo4M0ViSk5zS0VUZmRud3JvdFpWaGQ2MVdYL2gwMjk0?=
 =?utf-8?B?SzJWM3BIMkIzYTJFWjRTSVdxMnhCbkRodjJkVkFGWDdxaUpKMXYwbzN5dTNz?=
 =?utf-8?B?Q0lhYnE4c0FSZFl3VnQwMWRMLzdVM2p0ek1Hc3hrVDNqeXg3bjQxL2xYWS9y?=
 =?utf-8?B?cE03K2xtZDNMam5ETUpNQ05jOFJCYUZPWWt5RGJGQ3hRMnp1YjlHbTRHdVF3?=
 =?utf-8?B?TzNjRGZ2cDlJa1NxdXdHVnU1c0V3V0xRK0dMUnNoZGo3bUJhZVpGSjFlb1JI?=
 =?utf-8?B?M3Urak8yaG1UaVRjM3M0bkNXTnRSME9pN2UyQjNYZ2xxUDlWcU5veG42NDA3?=
 =?utf-8?B?MHN6a2dHcHpreEt6Ulg2WUw1SU42V2ZDSHhiQW40SXBCT3JBZE81N0pWdXNR?=
 =?utf-8?B?RjV0RWdsT0ExbmQvZmRvVmh4NCtLRUltM2kvT1BkQ0tsRHR0bEEvM1U3a2sv?=
 =?utf-8?B?RjdPWTMvWHIrWllTTVUzKzdmeFVTVFVMdTVKSXZPVmpWZzlkRnhVT1czZ1lM?=
 =?utf-8?B?QlVsaWVqMURZYUwvTDV0OGpldTQwM0kwcXNLYWdvSlpRcyt5K1hPVTN3L3ZP?=
 =?utf-8?B?UjI4dkxMZXVaKzlZRkZnUXdEN3l0eGhoN2xxZjZBenRMWlE2Lzh2anFIajFR?=
 =?utf-8?B?UERNZmIxUUpaU0JpQlF4cTU4VkZYdTV1NW1yWVp5WHh0ZzBnQmxjTWJOVDdO?=
 =?utf-8?B?VExlUDJrRzRLL3RwSmFFazB5RVd1ZFBnWkJTdDZIYU5SOWVOZ2VSQkVka0hy?=
 =?utf-8?B?eHUrb3pna0t1WEc1OWVvNytDYzdmZkx3RzNxdEVjVDlPbXE5RGxWdUNOdlkr?=
 =?utf-8?B?R3VFU25MNGc0N3QzTWRCd3VDS2Q1ZWxWdWplNDRiRVRLdC8ySE9pMkUxd20y?=
 =?utf-8?B?N3I2a1QyWUFBbnNBYldnT0ZoOVdDRXVQT0tKakg0QWZ6UkFRMHo4ZUNxa1ZN?=
 =?utf-8?B?TFdMUWxTOEhJYTVCQUQrTXloaW5NRk1YaFpTNVRBUzJmQVMzWmoyT2VoNVdp?=
 =?utf-8?B?K1k0djd0NGtXMGNFZm1zcUFiNEg2Y05rKytTU1A5cWRqMlpxZkl2UTJHeWZQ?=
 =?utf-8?B?NHo0ZGFLMDJUdFZtZVpYU2JibjMzNW91MFRKN21NMi9vTm9wWjF0QnhuNVBU?=
 =?utf-8?B?Zk52VDc4VWdLTXl6OEJqRllkUlRMOVdqbG4rZWlhNzc5NmtnT3pIN2ZJQXJP?=
 =?utf-8?B?cG1aT1hXbXBRSzFzTXdzQW1aeUg2REtnenV2L3dyOEJYeTZydS8yQzYyb0ll?=
 =?utf-8?B?b3NiWGswWnVYT0Y3WG1rSGNNMTVoRWJnYndzTmtzMGwwTmV4TTRNS2Z1K0pk?=
 =?utf-8?B?TlM2VC92a0xuN2VsTlh5UUVDbVlaWDlTQnIwSjkxb0gyR21JVEpyaW42b0RC?=
 =?utf-8?B?dnJRK2ovUGdWOWt4SURvWXVrakllZXFTajVyQlhyV3gzODQzTXFONThHN1ZY?=
 =?utf-8?Q?vkdvkLgKbZh2r/RNJApD6kgMb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8268eac1-4425-4db6-460d-08dc2d67ecca
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 14:19:16.0987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qt0aoEL9roNLv35AZFenGnDpOAUJjECCmbKVm40xHeBm1O6KFDqeTr470lJxIsDqz3MEdEQJaIqoZoaLy9XYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

On 2/14/2024 3:36 AM, Borislav Petkov wrote:
> On Tue, Feb 13, 2024 at 09:35:15PM -0600, Yazen Ghannam wrote:
>> DRAM row retirement depends on model-specific information that is best
>> done within the AMD Address Translation Library.
>>
>> Export a generic wrapper function for other modules to use. Add any
>> model-specific helpers here.
>>
>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   drivers/edac/Kconfig        |  1 -
>>   drivers/edac/amd64_edac.c   | 48 ----------------------------------
>>   drivers/ras/amd/atl/Kconfig |  1 +
>>   drivers/ras/amd/atl/umc.c   | 51 +++++++++++++++++++++++++++++++++++++
>>   include/linux/ras.h         |  2 ++
>>   5 files changed, 54 insertions(+), 49 deletions(-)
> 
> So basically I can zap:
> 
> 8be4984891e0 ("EDAC/amd64: Add MI300 row retirement support")
> 
> from
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-amd-atl
> 
> and you can send me a patch which adds the row retirement straight to
> the ATL?
> 

Yes, that's fine.

Thanks,
Yazen


