Return-Path: <linux-kernel+bounces-70183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7834A859470
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 04:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061251F22301
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADE95227;
	Sun, 18 Feb 2024 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="gHcB9Mw1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2108.outbound.protection.outlook.com [40.107.220.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844EE4C7C;
	Sun, 18 Feb 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708228332; cv=fail; b=Vt4fw+h47O2DscTKWqR/7S3iNxqwWgyKQqnR1tQgUu1zAZMIS1oJZUQ9IQq1KeCuGS3YSLOBkzpXpZaVhwXhcDCzWQmYs9LCJDNpxa8T7/1CJlnJxCYXsSoxwFhn+h0AZ+S7EWx9YgpreA7iV7qaaiVOgVEaxrUM8iIlXOTwU3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708228332; c=relaxed/simple;
	bh=KUoRjIlItvzAHrOdYpOi/9QFnkx8aMeT8yEd5eZ/Gm8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fI0UJYrUYoG9KqC/sNmLrvgTwz2deATG2ZGrEDEVlnHhZm1VOKCT0oarpmBU0BxDf+wU+5YnL9i4mpBFniAyc7mfpeLsMMnOHuXeN3hFRQnrZIFEgaXZlFOExsaIRLB5SvtdX9be1jmiBiFfDDmZ9CLFHQ/57EJIGV6TuIL4oEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=gHcB9Mw1; arc=fail smtp.client-ip=40.107.220.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSXj/uvmSHQO4DnQgAZz/kIJF6+MM9sPNnkDhmqY2OIYnDKPed1IyOykCdCXOWvW2i3+wP5w4pQUdgGFPd+/nTklQ3Rp2RkPv5ywLA7b1O/dZL+XIBCugHXuA1RH0S4DZpMZqnFY6OcxlFWGzTndQxNXi5RwUEgxgYOEJPd0lVB180z6fSK+wSDi551lRKgp4g8Y9VxUuuoGOLKS2+5LfJgQCUGw5hDetX2j+VkbpAs4O+k8RzLyAI4H/rasjqvrKSAie284HKQooRUnEImdol6ZquG0tZ/Veo+9SG+82FQUUq0zrR231iOElXeSSJFWRzZXqtgVWI8alxV3wQkgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06qUIGMldaCECkyNo4sfQrnRQ+Y+DnEcsqAMYiFs1ew=;
 b=AqZia48gDgMzcR2CPSyeP63BLRKnuxQbox9x6nkEOtnwyMXbxxHzbCioMpi4Ga0wxmf86Okt8HAcuaK0IK18/xbC5pdVADOIR3Ji8zcKhUgUO6vT1ZcIs/Y9mhJ+vqA2QGYKgFV/cV6o4V2d9AQ6DOqqkuCd0j2ZidnOeS2LgNOIk9Mw3UzN9+5BD1z2j7FW9e72UwYz3wQBqGdwzcvoPbe98SM+C2nAfbCu9KHgMoQtrBYkaVD+fvHbkDFyOdbmjH3jwBoLb3B/HOcTi6dB97MlWt9icruLELlAhyPWchAv8fdnwspyx/3VhN1abwcvEIl9pVtrh1EHVG1QyJ+j8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06qUIGMldaCECkyNo4sfQrnRQ+Y+DnEcsqAMYiFs1ew=;
 b=gHcB9Mw1aqHyKGLHnqmNksJamOnvQEw82Lg371iDfqQ7mN4mAqNWwi3VBpoIegM8wm3mGo918WS0TBb+SVKHReGDGm/VWC/HZMGyup4+sxwoApc+NmB8iRpJxZhGyX3LHKAvq0DeD5/Phi5sO6yKDVSV2CeJMqDaoDcFdXVg0Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by CO6PR03MB6211.namprd03.prod.outlook.com (2603:10b6:303:13b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 03:52:04 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5%6]) with mapi id 15.20.7292.029; Sun, 18 Feb 2024
 03:52:04 +0000
Message-ID: <4e7640fc-5764-4fb0-aea1-8b26b9c1fede@synaptics.com>
Date: Sun, 18 Feb 2024 11:51:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Randy Li <ayaka@soulik.info>, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl, sebastian.fricke@collabora.com,
 alexious@zju.edu.cn, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240210180414.49184-1-randy.li@synaptics.com>
 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
 <30e44b19731c4821fdf325689482671f90389100.camel@collabora.com>
Content-Language: en-GB
From: Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <30e44b19731c4821fdf325689482671f90389100.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::25) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|CO6PR03MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8280857b-d3da-4047-3e89-08dc3034f82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XRe1s8ZEuf7imjTkEC1YsR5yn8NdtQXdxA4WcPMDXAY78GtIHoElxps0Hw1s7hu/BB7TmrSTHu9r+gBs1uU23vW8VUnmMbPKJDU9S3lTUflW56aCIPCpBBtOt0AHrgylfbdykhfjmYX9q06zqm9OBUs9+kQse8+73X3s5ypNyh4sHycKh/FWx2gTQS7VwydkqocNd1B8CUV0CV9m52GYfiWKIbSyiZPF7Q4mJxf5bdZTRWJBGLH24ZlYBDp5BWWZI2JLXuoOlGJOf0536G5CvBmn4tZWGT1XCbYfHxxXlHiHZhn/no5EvaFIKp/oO5ha0ok3l31D2kdL9KRfMG3hgIfJF0bnZQC/HNZuWQrfn+fmwwCckChiGVQvq9deMWfUzsSH5YPluovJ22J01grZ9dKYTrUxnTXIA0SO6rIdkj25BTqJaJV1UgKXk61gWuDJPuEaBCtLLLoVM8wTw7FPMhxarh3fWHHVIk/ntHJkiH1vZKcUPoxAn6lsA1l1Cj/igsFxfFP9RJjawDhjTqqQIvYh8ihJ13jzeXbheDmUOKTIj7aaL33yo7y+AmBlCo67cxp1NaIAahOkA7Mnd03tZpFOnBhSeo6CNtBqI96qnEhMiEGpPU4edZLJ/aYF+A8w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(346002)(136003)(376002)(396003)(230922051799003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(66574015)(83380400001)(66899024)(86362001)(31696002)(6916009)(36756003)(2616005)(38350700005)(6666004)(41300700001)(316002)(52116002)(53546011)(6506007)(6512007)(6486002)(2906002)(478600001)(5660300002)(66556008)(66946007)(66476007)(8676002)(8936002)(4326008)(26005)(38100700002)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0ltODg4THlJZ24vVnBDU0NiY1lsODV5SUJZRUQxVWp4Y1liRUhhZjJISUZy?=
 =?utf-8?B?OVAzWlpkaFczTWxTMEV4dElEVmpnOForZnhNRDFyVzhMRS9ZSytCUHJQaHhF?=
 =?utf-8?B?YjNKK1UyNmdRWGIwSmdCNFpRS3BzdDZPMjlxa3U3c2p5TnJWS1R4SHBxVUM0?=
 =?utf-8?B?NWE1MFl1QW9KcEY0L0EwNDlTWXV1azNPbEJEQnFzZEFtdjc5N3N4UTNuN1dN?=
 =?utf-8?B?U0pwMUlBOTlTT1VzNEJlM0llRHZRczUyS1BhbEtGb3NFMTd0WUtCbXhKY1lq?=
 =?utf-8?B?OHFRdllvcnowY2c0eGxISWxVY2JSNk1kOUtkQmZIczFZcStoV3hpa0t2TkM0?=
 =?utf-8?B?cWdDbG9idktORS9TKzB0UjFOSnNVc2V3RU5yR0xwNjBMRE5RN1VYNG9ITTRL?=
 =?utf-8?B?TEZtcXZ0MExwMCtXaVdDWGQ0Y1V5L0NnRGVmQnpHbjVidXE1bS9TWUpvcFJE?=
 =?utf-8?B?REdVRHpmZFgwNnZOM2xrY3NEeEh4dVFpSWRhbThEejdRVFVyVW9XQ0lTd3BO?=
 =?utf-8?B?UjV3eVdma1Q3RjhTR2NGSG9XYlpNbGsyOUphSkt0UFZ5eXZQcmNkb3dmRnhS?=
 =?utf-8?B?QnB3MUhzUjFzem5iOS95YVQ1VUVMUzM1NEI4YnpQaUhSVUMwSTdlRDNQbU1Y?=
 =?utf-8?B?RGMzQTRmWnJyUzhiODFnZnd1eXh1ZUY3UzRUSVlpd1BaZUpIOHUvckRCUnM2?=
 =?utf-8?B?WnNnWFB2QzJwRkhGTHJHdU5JM1FlWERvZERSR3RYazNES0k3dlZGUC8wYS9Z?=
 =?utf-8?B?ck1KNzVDdEVVemxWNjhDTC9UYitNTVI4LzlINS9zWXdLcWlFOWl4ZlU5WVJx?=
 =?utf-8?B?Y0dUTzNnTkZoaU0reDBqRWVROEUycTBBajBiVEdjWkpBVWo4NFRjclA0Kzk0?=
 =?utf-8?B?dVBKMDJiYVdpMzF3aGVwMDNTSWM5RHpsOWQrZG9KZ3ZacTNlaGZLcVFvRTVp?=
 =?utf-8?B?dGZ6RUE3MUowRk9FKzNOM2VrSkpKT1VzNHUwWFBDT2pFNEsrdUhDUVVSUWtH?=
 =?utf-8?B?U3V6RWpuZUZ4MWhTWjRZczRzT3E1eTV3ZjBHd0lxMnc5aUVZVDBKRkNlejNG?=
 =?utf-8?B?c2hKRkxmQUhIRHJkbWE1MUdnZkd4Ylk0Wlk2WXFNajc3ZVpxNWtKWUdxT3Ev?=
 =?utf-8?B?Nm5JWHJFYW5BQ3VEc1BBNFg2Rjl6dUZ0MmNaUWYwN0xyWndnNDRVeXNXcm53?=
 =?utf-8?B?ZjVHUWY2Y0lONEhHUWhKYXJubTVSVjF5N0ZOQVdjV3JFR1ZldVZhYnlnRDUw?=
 =?utf-8?B?b2k1ZXV3WVVHcHYxN3RPVzVCYkRvR1hjcUN4Z2QwTXlXczdYdEI3N0NOckFk?=
 =?utf-8?B?WUNMei9pN2JCWFc1cFBwUjQ5ckVhOUFWQ2JUZ0tzeUFTcWt0V0JXejVTR09q?=
 =?utf-8?B?YStCN21lc2UwVzVrdDI1cmpTRUpqelE3ajhpTXpHSnVqWGVvQVZqZVcyTS9a?=
 =?utf-8?B?VjR4K3h3bDVqVFFYVXRPUGZTdlI0NEE2N013L0F0M29VWk9ETDRPa0JhY2NK?=
 =?utf-8?B?Z0FGMENKcmxiN2hCdUs4SHFITzI0elFRVHB4VU9ITXJIT0JwdkxRZEFSZnZN?=
 =?utf-8?B?TDFlbzlwRGtldVpZaDFZaFZza3lOS3dmVGMyVmFMMkFCN2hpUmRWM0xRZ0ZY?=
 =?utf-8?B?bkYyVDg0UTFJTnBSZkRpMXdSMk1BUkxIdjYyclhQVk45TzM3SkVGc1RFclpr?=
 =?utf-8?B?Njl4ZjMwNWVsRDVMUEpJVWlGdGRSVTF4SUVrMm1CNk4wSzFBV3BnT21zZkZW?=
 =?utf-8?B?WE4xajVpbWVOZjlTQ2FoNk5RVGZqdVM2L053QUw2ellPN3hiY3cwSmluWUxT?=
 =?utf-8?B?bjcwakZwWkZ1L1d6SVVFN291LzdRSFJvQ1E2MkdQMHV3d2M3NHYwaWhva2d4?=
 =?utf-8?B?Yk15d1VzWE5LWENCTG8yaTZBd21qdVFQTklDMEd6bmFMdlg1Q2tFSkdtU2Yy?=
 =?utf-8?B?NjNOOFh1Rm92RHlXeVQ2THJFajlMcjl1RllNY2NzYU9wemZ3RG1qQzFwOUM4?=
 =?utf-8?B?cStLUmJFQ1kvVHhUTDhNMENOeWdnbDg2OGNxQ1FYYXNKUHdMcGFzMTlySWdq?=
 =?utf-8?B?TEtWRC91bGZlS2dycFoybWVoSit1TDRyVjJSZnhqV0VFR2dPV0RBb2NieFdR?=
 =?utf-8?Q?74EzMtmH4kOGSFbYuwiaQKPKX?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8280857b-d3da-4047-3e89-08dc3034f82f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 03:52:04.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvZ/EW1ORjG/1jXsRrzz+MOZhson0W1HYJEoRdr+L7Q8xBHN+zK9b0B+sMKCQcmJE1v/2jr5PFUe0BYq5YV8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR03MB6211



On 2/17/24 02:56, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le jeudi 15 février 2024 à 11:16 +0800, Randy Li a écrit :
>> On 2024/2/15 04:38, Nicolas Dufresne wrote:
>>> Hi,
>>>
>>>>    media: v4l2-mem2mem: fix mem order in last buf
>>> mem order ? Did you mean call order ?
>> std::memory_order
>>>
>>> Le dimanche 11 février 2024 à 02:04 +0800, Hsia-Jun Li a écrit :
>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>>
>>>> The has_stopped property in struct v4l2_m2m_ctx is operated
>>>> without a lock protecction. Then the userspace calls to
>>>                    protection   When ?                   ~~
>> Access to those 3 booleans you mentioned later.
> 
> There were commenting you commit message typos, not a question.
> 
>>>> v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
>>>> a critical section issue.
>>> As there is no locking, there is no critical section, perhaps a better phrasing
>>> could help.
>>
>> "concurrent accesses to shared resources can lead to unexpected or
>> erroneous behavior, so parts of the program where the shared resource is
>> accessed need to be protected in ways that avoid the concurrent access."
>>
>> It didn't say we need a lock here.
> 
> I said it.
> 
I mean, I think my description was correct. Because the critical section 
don't need a lock invoked.
>>
>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>>> ---
>>>>    drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> index 75517134a5e9..f1de71031e02 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>> @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m2m_ctx,
>>>>                                   struct vb2_v4l2_buffer *vbuf)
>>>>    {
>>>>            vbuf->flags |= V4L2_BUF_FLAG_LAST;
>>>> - vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>>> -
>>>>            v4l2_m2m_mark_stopped(m2m_ctx);
>>>> +
>>>> + vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>> While it most likely fix the issue while testing, since userspace most likely
>>> polls on that queue and don't touch the driver until the poll was signalled, I
>>> strongly believe this is insufficient. When I look at vicodec and wave5, they
>>> both add a layer of locking on top of the mem2mem framework to fix this issue.
>>
>> Maybe a memory barrier is enough. Since vb2_buffer_done() itself would
>> invoke the (spin)lock operation.
>>
>> When the poll() returns in userspace, the future operation for those
>> three boolean variables won't happen before the lock.
>>
>>> I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3 booleans
>>> accessed in many places that aren't in any known atomic context. I think it
>>> would be nice to remove the spurious locking in drivers and try and fix this
>>> issue in the framework itself.
>> I tend to not introduce more locks here. There is a spinlock in m2m_ctx
>> which is a pain in the ass, something we could reuse it to save our CPU
>> but it just can't be access.
> 
> If you can find a way with memory barrier, but that is difficult to maintain and
I was thinking the spin lock which already existed in vb2_buffer_done() 
is an implicit memory barrier. Anyway, the problem is a clear, the other 
thread who would access those three 3 variables should happen after the 
write operation here(v4l2_m2m_last_buffer_done()).

I would try to offer a possible memory barrier solution appended to this 
version.
> often breaks without noticing. I'm happy to review something that introduce
> thread safety rather then depending on userspace call order. Can't disagree with
> the spinlock, its been difficult in Wave5 and there is still a bug report of one
> more case were we get that spinlock mixed with mutex.
> 
I don't want to introduce a new spinlock either. But since the code here 
has already used one, if we needed one, it would be a variant of spinlock.
> Nicolas
> 
>>>
>>> Nicolas
>>>
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
>>>>
>>
> 

-- 
Hsia-Jun(Randy) Li

