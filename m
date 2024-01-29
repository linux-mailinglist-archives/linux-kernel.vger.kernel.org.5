Return-Path: <linux-kernel+bounces-42685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5448404FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D3D1F22BDF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDFA605D6;
	Mon, 29 Jan 2024 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeOns9yq"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF668604C4;
	Mon, 29 Jan 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531260; cv=fail; b=j9bIRUerPiD38R0ZI/YcHqK3TQMqlzggLSJeEx1FeVagK2nRqIdfcZh/P3znDLLY3qZii9z0w3aeLFFyn3bH4ouE+OczSFAQN5JP3AjQn8+mDwKZeT6EVHaphp+Mm1/Jow1HPuOCI633yaAS77e+13RHAY9BUv/o/B52pOQMYDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531260; c=relaxed/simple;
	bh=Gfo5/l9TlgunpNZdThq9AInLc+V2+gaL+FxknA4DGTg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OFP+8C1XzEpgSzyf9xXgORp5TGHFuNc/2T/XKNnA71V90fUPYMurho6bPnVV4NsjEbFdVWzr1ubYGw/Tinw4wkAn2rPNyytsERobF/6SLPyV/vjgumveRa6EQmi8I9MUTc+n3kRRhqSxtpaHP2SyTqtTSn0rTaoGVPqdvDP/9t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeOns9yq; arc=fail smtp.client-ip=40.107.93.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CapuowzO/3hW0SzBBcEinfkTYutIBrs5PeLsBidVx7C/HMvXAJUamtgsS5askBu/sbcANycxCRb4UFAx/Ooy0+p4cMzRA5sqniiVFtJsSX5AXsH7pIypFzHEeWjwrDrk0knL+oys8lAfK/M61wnX9AkN0yxJ2rO86/kov4TRGyNuFUH3AeVSpPRJXDRwqE/BtMYVGOIAASZo6a0Ov443dDGqKH3D+FuO/j0UNy1Fs9XxMNtbEygJxLt5pBOEWdfbsTW0pbFJkmZUXGp75icHGKTpMXDl79L81+yYON75mgIWsVYazTS4ROr4Y5qXHxsn9tOlCZb4RfvBQ2xBszWfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l66aN5tm58f0COzm20i7hFllSAgASOdpIBzfTqjcY9g=;
 b=J9+kFsKpkZaKCbTsRxITkz21SWjtBJer+ogkjcPULH6+VBlAd3XiyMzxFsoeZm3byeUuvfZyMpCTWkVZtMe+IkuBarBibqVJXzDeI8+OIMJ7amcGbWeQ08KLEr0ADrsA3ngw0yd74eQIWvKNkEF3Z1Ao9EHh+ryk29lJZDL9zWcjReQa2WbqQFEMDgpZy8LlbEnHw6oLo0gNaBhXJtKY6Du+5l3jrzFHlbUa1c664ZjvqiInEZg9c9wPMRMC7QClK935ubIH+WF3ygA+0tAkQATp6YXtBGfObbzSvTTKEDaj7uc4x5fbQ/aXXjBsJOpD/6GuZ0dQf32qMxRbEfWOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l66aN5tm58f0COzm20i7hFllSAgASOdpIBzfTqjcY9g=;
 b=xeOns9yqwip5a9RSAi70icVCbWVVk1MfARRgEM7MFBK1erZECEt9yPFKaUAD1hJnxIQrVNNNoB9OhvIhg9cvzCwol8ANfjr5K2xIB7VQOiVzKGQ0uEA0WhEFEPsqsCm4zlO1zeulkwvoUjOFvOZdI/OfmJu5H6iJmtsCcQCSTu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 12:27:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 12:27:35 +0000
Message-ID: <f017868c-973b-409f-8210-4aacf2639fb9@amd.com>
Date: Mon, 29 Jan 2024 13:27:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Linaro-mm-sig] [PATCH 2/3] udmabuf: Sync buffer mappings for
 attached devices
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Paul Cercueil
 <paul@crapouillou.net>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20240123221227.868341-1-afd@ti.com>
 <20240123221227.868341-2-afd@ti.com> <ZbLE6FYXFVzTLh28@phenom.ffwll.local>
 <9105137a-058d-4314-83de-3424f82a838e@ti.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <9105137a-058d-4314-83de-3424f82a838e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: de8ea2c5-a1a6-46ae-a247-08dc20c5ac9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qHtzlKEshlIBzMce5dkGx5fMglQJTENuwk7eRvmBHTefeAaZhKjARjTnVZBbh6jZYot62jbUSlSDGeV6+QuuO78PgB7lpaFyEdu3fRk4TcQADqoLCFxgVfrdRL7CsDZbo1Kl991vvpMTuPEflG0wCdY7f7DyS8LpRI3WsPENxj7Ttlq/dc0JXsb0SUQJKkxRUAkoOkldq637z6l6E5N9DFtV2Ce+vLUGPgLEl+7TP8XzbOT/7Graj+zOky0yHY5KftzZI88Lkb71DInLNiGe0j7ctvuCQKL13Ruxn/f1P1+PApY5+WMnZ0l1EzbXc3STb+21xhuswIHITYSud6jRRYCWfg0VP0Q48jEixiB6nYJ/KNiLueAOJZh1v0uF0kQqBO+KaEP7Jf0Cfm1hEL314p/7KTLjIutEwJQy9T67Z8O1B8V5fyhl5j3b9ptNRLsbVBRTVbz0VVN9j2Bk58VJNeYW/e5ytANPq9hDvcQNnT7Wxdr2E5dYgM3yiqsNoup2/HROMEHM5DvxgyPu4DgmRDoLoiJe2VgR3jgBiPcoIwAV8rLwunv8dxYHbgJfETvB7Rh8ZJMg659DnY/xiuFpdmI3gxYtYsXIiZy/SiwBx+IQs3Ph3JY5pLB8BJRfqxKve7megYW7dR6+nLlVsgxMEA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(316002)(83380400001)(110136005)(66556008)(86362001)(66476007)(66946007)(31696002)(6486002)(478600001)(53546011)(6666004)(38100700002)(31686004)(2616005)(6512007)(26005)(8676002)(8936002)(6506007)(5660300002)(2906002)(66899024)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3lUcFJNQThEU3FlOHR5ekVnemd0V1UvUzJYL29kd2hRby9BOHBqa1JYdVhR?=
 =?utf-8?B?cTVkSkxrclFJU3VlT3BNNGZVV01HOTFqazFqOFBIU2MzV1FqWDNzTCt6UnRq?=
 =?utf-8?B?Uzlma2FGdjlydzVvSkFNM25hSU1jNStWMVZGWndXMDlxQzhYM0lTQXpEZVlM?=
 =?utf-8?B?YlkvOG5iZzlyeDhJeUJpaE5EUTg3N013YWMwNnpFMm1CZVl3NWltSWpLZ2lt?=
 =?utf-8?B?Z2tIMkd5Qkt0amliQ2xFUTNEOWJjUFdkalV3MGFuR1pCb0g2Rk5Db3dGMDFx?=
 =?utf-8?B?SGFGT3pHSFo1WVVaSlZucWRNekN5T0paMVRqYktyZFlpbVgvRFpUblNScHRJ?=
 =?utf-8?B?dkdQRlJOWmh2OE9iZGUvQStaeFdZOFJERkUxU3ZpbE9HdmQ4bTF0OTJVbUdt?=
 =?utf-8?B?dkZUaXBqNWd3TXZDeEM4RXRBaVJncGxrNkxiTFIrTHZUT1hFZ1I5QmZwSWNK?=
 =?utf-8?B?N2lZTGtSZDlQbEw1TFBreHA4VE5nUHdycGRlb1J3VVJ4eGVqSStuTkY2N0VN?=
 =?utf-8?B?OTNUbGZhd0E0MDNxaFJ2VU9hb3A0WEFVMU95UVdrL2w3VjlOckRuQjhKNVFj?=
 =?utf-8?B?bmdPWlg0bVNvU2VmTDlobjlLQllLR1B5L1kvdmExYzdjM2ZZTVVwRlBJdk42?=
 =?utf-8?B?K0F0UkRzd0xlZ1BEalhQN1NEUWNoOG1mOGI1dm5NOFhrdVo4WDA5ZVBreGhY?=
 =?utf-8?B?TXhTbHNVamJpWk9LUW9YdWZIQ1VGWnVOcndZOHlwTEZ6Zm5tOHBOdE5mVFJE?=
 =?utf-8?B?eFpXYktuSkgvSklEcSs0RmVIdGtzRE56enpFUWdLRENiTWJGSmpSazNBVThy?=
 =?utf-8?B?cFFCY0liRFh1N2Zwc1ZHS0xiYTJYZ0c2ZHRXWGRHYnhUMjVPcWtJbnRUMzRL?=
 =?utf-8?B?cEUwK2JqeUYxdFMxNUIreVdjK0RXcDJZRHpqNjBmaW5zT0VjUUVFWnlMQ0Ux?=
 =?utf-8?B?akFKVkt6L0xIY0JqcTV5MkR6NmxLbzlpN1VoZUdHOHZ5SmthcldDancwUGhM?=
 =?utf-8?B?N2twVjl4My9OWm1UTSsvNDJ2UTFPMXNldEtwaTEzbm1VVUI4RlBGeUVMaXhV?=
 =?utf-8?B?VnRCb21OWFA2RVd2R3BRZWIzN0RzY3UrcXJSWEdkczZmZXlJV25jd1praG1I?=
 =?utf-8?B?YnhtUWdzMlR0bGRNUlNPcHVNS3BwOHFFOGo1VGtJQVczRWpKM2VQS3JBWTVl?=
 =?utf-8?B?UGQxaTA2OWdOdTJtK0phVkNhN1djZE42N3VCU1ZzOFYrQWoxZy9oYUozbXFP?=
 =?utf-8?B?TG4wc3lqVEVteVp2b1BNM2xaelQzQWwzbG5HS3Jrb1RlWmM1WjhqUzk0Mm91?=
 =?utf-8?B?ZHZub2MyNzdvQW5ab05DdWFaZFM3L3o0dFFoNTU3VHFKbDRpMVIvN3lkOU9t?=
 =?utf-8?B?Qm5TZ3djNHRXSG5peUZnODdaYXNQNm1TQWFOVHNXanQ3Rk9wb3ZiOWhlSERi?=
 =?utf-8?B?QjlzcWVOa0FBSktkckhvZEpzV3c3KzlPUTBRZk5OZlBQS2ZqVTRIM3RzMWt1?=
 =?utf-8?B?ZUx1aW9yZVJMQmxKQm9TTmUvN1hVbXN2cmhGcFlnQ05TaWVOZXA0WHNmcjdk?=
 =?utf-8?B?dWs3c3RLclJEQjRWYXJXeVg1cy9ZY2N2SlNmU3l2d0lqbG5KQkxwd2E1cWky?=
 =?utf-8?B?OUlnOWY5VXRmSkNsZGRwV3kxWXMrQmV6VXhHN2hTRTZGWThVRGJnMkczSXMz?=
 =?utf-8?B?akEwREJYaFkxYmZiaWpqdlJ6ZFdoUGU0djlHL1dCYy9SaXBQSFRGNFdHVVdq?=
 =?utf-8?B?UnZCQWlGclR2NTNndUJHc2pWR2F1cjFITXN6ZDBmbG8vbGxjNjdpcnAvZDMw?=
 =?utf-8?B?dTg3bmFFT2N4cmM5Y0gxS2czUnNNNmpTaUFWVDIxU01LbU1vZkxVTlFwdnZJ?=
 =?utf-8?B?aVZ1OGVXNW5WQmJHN09QcC9sbDVyLzJma2tHMWUxN3M5cWJEelpuR0NJQ1pY?=
 =?utf-8?B?YitsclV0NlNoOEV2TS91VTdaeUFzdEtiNmw0NzdsdlYxU2lWY0pCaS9TMnV6?=
 =?utf-8?B?a2REZjZoYTFHQndHYnp3NkN4MkVDeWd1aWVyV1YwU2NMNFBtRStFZkk3YlhR?=
 =?utf-8?B?eUMwYkFIMzU0a2lhZFhNY2YrRVhiRXNxNzJwRWZxL3pMSVMyOGdqTlc0Z2Rr?=
 =?utf-8?Q?WWXQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8ea2c5-a1a6-46ae-a247-08dc20c5ac9a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 12:27:35.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCMaxE1NqF998O95PbvhuenOvV7uQ39fBBtg/HsJom2Q+b+nHxk6bfZ8PAh/kx67
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

Am 26.01.24 um 18:24 schrieb Andrew Davis:
> On 1/25/24 2:30 PM, Daniel Vetter wrote:
>> On Tue, Jan 23, 2024 at 04:12:26PM -0600, Andrew Davis wrote:
>>> Currently this driver creates a SGT table using the CPU as the
>>> target device, then performs the dma_sync operations against
>>> that SGT. This is backwards to how DMA-BUFs are supposed to behave.
>>> This may have worked for the case where these buffers were given
>>> only back to the same CPU that produced them as in the QEMU case.
>>> And only then because the original author had the dma_sync
>>> operations also backwards, syncing for the "device" on begin_cpu.
>>> This was noticed and "fixed" in this patch[0].
>>>
>>> That then meant we were sync'ing from the CPU to the CPU using
>>> a pseudo-device "miscdevice". Which then caused another issue
>>> due to the miscdevice not having a proper DMA mask (and why should
>>> it, the CPU is not a DMA device). The fix for that was an even
>>> more egregious hack[1] that declares the CPU is coherent with
>>> itself and can access its own memory space..
>>>
>>> Unwind all this and perform the correct action by doing the dma_sync
>>> operations for each device currently attached to the backing buffer.
>>>
>>> [0] commit 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
>>> [1] commit 9e9fa6a9198b ("udmabuf: Set the DMA mask for the udmabuf 
>>> device (v2)")
>>>
>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>
>> So yeah the above hacks are terrible, but I don't think this is better.
>> What you're doing now is that you're potentially doing the flushing
>> multiple times, so if you have a lot of importers with life mappings 
>> this
>> is a performance regression.
>
> I'd take lower performing but correct than fast and broken. :)
>
> Syncing for CPU/device is about making sure the CPU/device can see
> the data produced by the other. Some devices might be dma-coherent
> and syncing for them would be a NOP, but we cant know that here
> in this driver. Let's say we have two attached devices, one that
> is cache coherent and one that isn't. If we only sync for first
> attached device then that is converted to a NOP and we never flush
> like the second device needed.
>
> Same is true for devices behind IOMMU or with an L3 cache when
> syncing in the other direction for CPU. So we have to sync for all
> attached devices to ensure we get even the lowest common denominator
> device sync'd. It is up to the DMA-API layer to decide which syncs
> need to actually do something. If all attached devices are coherent
> then all syncs will be NOPs and we have no performance penalty.
>
>>
>> It's probably time to bite the bullet and teach the dma-api about 
>> flushing
>> for multiple devices. Or some way we can figure out which is the one
>> device we need to pick which gives us the right amount of flushing.
>>
>
> Seems like a constraint solving micro-optimization. The DMA-API layer
> would have to track which buffers have already been flushed from CPU
> cache and also track that nothing has been written into those caches
> since that point, only then could it skip the flush. But that is already
> the point of the dirty bit in the caches themselves, cleaning already
> clean cache lines is essentially free in hardware. And so is invalidating
> lines, it is just flipping a bit.

Well to separate the functionality a bit. What the DMA-API should 
provide is abstracting how the platform does flushing and invalidation 
of caches and the information which devices uses which caches and what 
needs to be flushed/invalidated to allow access between devices and the CPU.

In other words what's necessary is the following:
1. sync device to cpu
2. sync cpu to device
3. sync device to device

1 and 2 are already present and implemented for years, but 3 is missing 
together with some of the necessary infrastructure to actually implement 
this. E.g. we don't know which devices write into which caches etc...

On top of this we need the functionality to track who has accessed which 
piece of data and what DMA-API functions needs to be called to make 
things work for a specific use case. But this is then DMA-buf, I/O layer 
drivers etc.. and should not belong into the DMA-API.

I also strongly think that putting the SWIOTLB bounce buffer 
functionality into the DMA-API was not the right choice.

Regards,
Christian.

>
> Andrew
>
>> Cheers, Sima
>>
>>> ---
>>>   drivers/dma-buf/udmabuf.c | 41 
>>> +++++++++++++++------------------------
>>>   1 file changed, 16 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
>>> index 3a23f0a7d112a..ab6764322523c 100644
>>> --- a/drivers/dma-buf/udmabuf.c
>>> +++ b/drivers/dma-buf/udmabuf.c
>>> @@ -26,8 +26,6 @@ MODULE_PARM_DESC(size_limit_mb, "Max size of a 
>>> dmabuf, in megabytes. Default is
>>>   struct udmabuf {
>>>       pgoff_t pagecount;
>>>       struct page **pages;
>>> -    struct sg_table *sg;
>>> -    struct miscdevice *device;
>>>       struct list_head attachments;
>>>       struct mutex lock;
>>>   };
>>> @@ -169,12 +167,8 @@ static void unmap_udmabuf(struct 
>>> dma_buf_attachment *at,
>>>   static void release_udmabuf(struct dma_buf *buf)
>>>   {
>>>       struct udmabuf *ubuf = buf->priv;
>>> -    struct device *dev = ubuf->device->this_device;
>>>       pgoff_t pg;
>>>   -    if (ubuf->sg)
>>> -        put_sg_table(dev, ubuf->sg, DMA_BIDIRECTIONAL);
>>> -
>>>       for (pg = 0; pg < ubuf->pagecount; pg++)
>>>           put_page(ubuf->pages[pg]);
>>>       kfree(ubuf->pages);
>>> @@ -185,33 +179,31 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>>>                    enum dma_data_direction direction)
>>>   {
>>>       struct udmabuf *ubuf = buf->priv;
>>> -    struct device *dev = ubuf->device->this_device;
>>> -    int ret = 0;
>>> -
>>> -    if (!ubuf->sg) {
>>> -        ubuf->sg = get_sg_table(dev, buf, direction);
>>> -        if (IS_ERR(ubuf->sg)) {
>>> -            ret = PTR_ERR(ubuf->sg);
>>> -            ubuf->sg = NULL;
>>> -        }
>>> -    } else {
>>> -        dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
>>> -                    direction);
>>> -    }
>>> +    struct udmabuf_attachment *a;
>>>   -    return ret;
>>> +    mutex_lock(&ubuf->lock);
>>> +
>>> +    list_for_each_entry(a, &ubuf->attachments, list)
>>> +        dma_sync_sgtable_for_cpu(a->dev, a->table, direction);
>>> +
>>> +    mutex_unlock(&ubuf->lock);
>>> +
>>> +    return 0;
>>>   }
>>>     static int end_cpu_udmabuf(struct dma_buf *buf,
>>>                  enum dma_data_direction direction)
>>>   {
>>>       struct udmabuf *ubuf = buf->priv;
>>> -    struct device *dev = ubuf->device->this_device;
>>> +    struct udmabuf_attachment *a;
>>>   -    if (!ubuf->sg)
>>> -        return -EINVAL;
>>> +    mutex_lock(&ubuf->lock);
>>> +
>>> +    list_for_each_entry(a, &ubuf->attachments, list)
>>> +        dma_sync_sgtable_for_device(a->dev, a->table, direction);
>>> +
>>> +    mutex_unlock(&ubuf->lock);
>>>   -    dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, 
>>> direction);
>>>       return 0;
>>>   }
>>>   @@ -307,7 +299,6 @@ static long udmabuf_create(struct miscdevice 
>>> *device,
>>>       exp_info.priv = ubuf;
>>>       exp_info.flags = O_RDWR;
>>>   -    ubuf->device = device;
>>>       buf = dma_buf_export(&exp_info);
>>>       if (IS_ERR(buf)) {
>>>           ret = PTR_ERR(buf);
>>> -- 
>>> 2.39.2
>>>
>>> _______________________________________________
>>> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
>>> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
>>


