Return-Path: <linux-kernel+bounces-74543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFF85D5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89941F23D95
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73E122095;
	Wed, 21 Feb 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="QCRfLw19"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2112.outbound.protection.outlook.com [40.107.95.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51471EB51;
	Wed, 21 Feb 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511835; cv=fail; b=lEE72MCu+onWxSboW+w58D3yA31xfdgRxsgk/EhPoGUz9Z7a3JFFwK5kiXkQ6T/mBaTBVzWnj37QYUl5QfxNhLJVC5ENH1DaEkWg4ZaJ9duXu7fMvK8lSqI73oxtNu3LXyzqFS08EoSbsZjtojEctZQCEUSFloJ6ASHfJEJo6QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511835; c=relaxed/simple;
	bh=pCchMJieeZjTq3QhWp3ofppGdnaG5eHmdEfV1xS0hQA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BuuUP0JiPKudIJYt/5gZLgudO2YYR7NB81usBfPTtemavsf+FboR+AYDrCAT6NdR5Gm20OrFBz9DiXhqt9XKezxCvUzAeT0H+FAVXbg8nXi55lq1mOuquM7eS8QGkW8t0NOTMgzWvEgH7cfa0kBkPBAsEZZYJYpPJVn4G8bItjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=QCRfLw19; arc=fail smtp.client-ip=40.107.95.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwK3YG2+/RUnoNibSYcRTLJOdlWxVQyVARdHcQZf6C8XvTtMu5yY7bOIt+SAE+kJDZyaJZ6fvXMSk/Bm8AcvdPCqZbhOKv0BXVa9JiIXxTEuKsBEjdzmY9c/WdXIAw4abkvfHWgcCBoUOlVyEMMX3KvmpOOMSUmjq3cdyshZa6/tgte43wGOgSUH57gMMcom7p5xV2jp2UvfONpWAKiMHbd65NtfuNqd34pBA/6HLbaNAfqUr9wO0lJPt/Xio7n+VKlH6c0YlNhWYTcUfBEtjkl6tAoTLEhD8EScn3gCEWe/0IyVa1YIu91PGxHwAtdWwjqZjW7GcWsO70MRyKeTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wymDlDlWP58iKKWk91r8DBJUnaYLQ9GOdeW+ud1wd3w=;
 b=Hobm6vuHPvXq7LaW9EREg37S/5b8YEe8pPd/q8YPMuSqlgDPcmJnwE7ngZnrPNxJ4rf/8AlOCh4mg1jUR5GF47ywvB5OoElLXPLwBmrKrU+iirmaEmXaSmk3ApD/ZCicXPjYbti+WRrwtZtUbB6YNsYCY6oOv73gQ+oPT3gXNpxEcZI5aVIG/Nw2RP4NMCpyskQw2dfTdqROORj6gwV/s/NlgzWP3aRObYPWZHx/R3OkPIfBfv/g2y7+Eikv7B0BWXdut5LJCxfkB5YyEDk3UyrWTacDF/z3hJeonFzIWUdgNPu3EAW4TfIinxFCmvD6MIYylfC4oJIyBIjvBv3yLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wymDlDlWP58iKKWk91r8DBJUnaYLQ9GOdeW+ud1wd3w=;
 b=QCRfLw19Fa4D4uQcJ9OOzc1DoYo+kWeqmFZotlwIKi9FpQF7lsaWIQD81sDYzsIfowNpVfTE061CWI6MoByMEPb9OP1RBKQnZkpkN9o8rqYtf8nkRfB65KpWyFsCU2cKo4c/W6Z5ew9ZEAp4idumj9WBhBw4LgVcJJQ0CPNqYy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Wed, 21 Feb
 2024 10:37:10 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5%6]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 10:37:09 +0000
Message-ID: <e5b1db79-7fb2-4e51-bb93-73f31bbd8804@synaptics.com>
Date: Wed, 21 Feb 2024 18:37:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
Content-Language: en-GB
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: mchehab@kernel.org, Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 sebastian.fricke@collabora.com, Randy Li <ayaka@soulik.info>,
 alexious@zju.edu.cn, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240210180414.49184-1-randy.li@synaptics.com>
 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
 <27ef9490-a56b-46bf-84bd-bc2ec08896af@xs4all.nl>
 <8d236cbfca8c4ea573d340109387fc804f1a89cd.camel@collabora.com>
From: Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <8d236cbfca8c4ea573d340109387fc804f1a89cd.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0046.namprd02.prod.outlook.com
 (2603:10b6:a03:54::23) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|PH0PR03MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 69fc622e-ed15-4c81-f040-08dc32c90ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1/h+dUczVZ/bb6/VRgVIAyxuD8G36NY0kWjtfiF5aX3y1IYJZ+RbPUNCrlQTocl2Zmz+GIgg+rL07qlTzrakCynFkG+2J+g7ihdCm94iGu5LySu6DmHIqTavXU5+h1UVTSwXGP4SUCkrWSMLdP3eR7rlBH4wEHEyahdUpQ1FQ/nEHkIwvqj4Lfl0CcRFwAXWBJ1NxdJ9w7EXZl0QvXJtCM9ESGjTAIGKLZmCWW+K1/9tqycxGl4yE3oMLPE/++2mk7T+96Ruzp4DTiCtWLMe0be5oHCoP4ZmFcFrbliTxR7mWmb15GuwXlFcNGgKwUzraUfZq8+O1emTnKXyLuNwG0CxuhBBoBqOpsRrDAFOtItUxxz57vPj9tWfun8WsK4ZJOeH3/lvjgWcCTU3tU0sAiOtLaBFfYkjXRrORJ9F4qktOOptXUo/pIISfn+kYYm72suNJOjagTBy0adF6zQIvH1Ke8CQtbL2ONyWcyJDeF/J/kEPWfQQrh/o3yAZNVp/MjAZ/hFpUeYkwnXnOV6n6H/ZXIQdLdkWjg4WzSWl/PJJ0D1wM6cT8PnguiyAFBNowG1BHfFw+zLdl63sxuF3pmD5i9XtBEZqEVrWU/ix8zYqYlcPKZuWr5Fo4TeJTUgx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWx3dUhQcXgrakJMV21hVUFhdGhtckdtM0g2MTVoZkcwVm1MSExVNlJGMkdZ?=
 =?utf-8?B?Zk54ZVBJVGxDTlMrRTR6M1ZkKzZZeVhWRkFqWlVEZWlxaFg2VllNam5OcC9M?=
 =?utf-8?B?YTQzUjdOTFBVNGtYeXIzbDRScElFbnQ3RVNQNTFQNFR1SSthSldnajg1QWQ2?=
 =?utf-8?B?OUcrVitXbml0MVliMmhJWTdXdi9TZnF4UVA5R1lTSXdFTVg2RXE1RW9DMDZI?=
 =?utf-8?B?Q2VzNDVwbFQvVW1zclNEK3JFSHBYR1QyWTR6Y2U5OUpDTkdSb1ltenFHWDhU?=
 =?utf-8?B?VDhCV1Z4ajF6TVFpR0ZHdENCcktrelBab1F5WlFuV1FYaXpKVE05ZzF2Q2xz?=
 =?utf-8?B?ZFdac3R6UlpFRzEvaFFhVTlIcWxwRUllUDFWVm03TnpVSm5xRWRuNFFJaDBv?=
 =?utf-8?B?Nm5QYklvZVB6bVF0UFBZMHl5c2R6Z0s1Y1o0eWorWmdGMHhEWDVSeXdrdTNG?=
 =?utf-8?B?OXdKaXBKODgxZ0JSUU9PVW1XbUtxZ1BoUzNlM0VzQ1h4eDlSMi8rajRma1RV?=
 =?utf-8?B?VUVkYTBVb3Z1OE5hNCs1Wm9QY0dQUVorcU1WcjB3dEh5ZjhBMkJqWmRWbURJ?=
 =?utf-8?B?QlludlhnZFNFMHppU2dkRjVvcUExTnplcUdlMEo5LzBhSVk5eFZ1VmFYdWZs?=
 =?utf-8?B?MnJkUExpVjlSN01VV005aWFvT0l4eUthcjh3VTVwMjEyejRvMlVJcEhEK1NU?=
 =?utf-8?B?c2k4SmRMZmNmODJ1WVJrV1ZTMktHNGF3T0kzZjA5Z2dpWWVMOS9oZDRUVDZo?=
 =?utf-8?B?U2E3Qkc3bEhSWVYyaFpVUHREUUs1Q1NUSVRXN3RZU2N1b1pLOU9CQ0dPQnE1?=
 =?utf-8?B?aHlBVXBEaXR0d214OGU4MHF1RFNCbndoQzdmbE05RWxDSW5mUWVMSkJrcW9r?=
 =?utf-8?B?b1FDZGVEMUFtUmRUdHBCM0JHSXpUNzJ5T0g0YTkrd1Rxa3FhOElvaVBiZ1ho?=
 =?utf-8?B?RHNOaU94T1BNd0EvaHNMZTBHUlJ2SFFyRnczR0xXcmR6OXhSdlprVlBReElz?=
 =?utf-8?B?em1Jd0MrYmdPYmdLcUsvQlE4YTVBRzhwZzdpcm0rMFBlMEtqZkdBOU1LblpJ?=
 =?utf-8?B?Y2c2Z3ltOUZEMmsvU0pPdjRkVVlDUTdSSVZYWXM2a21KemQwNlpxYUJBZzdJ?=
 =?utf-8?B?VHVOQmpsZGZqSUpWOGRFT0paaGh4dFpvaEpzWjl0YXQxNXp5Tmg0SExoeVIy?=
 =?utf-8?B?dlluU3l4Q3BxRS9wWkI0YTZvTHFTbTFNUnU3L1BIL0FycTBLS0tHTU9ycU11?=
 =?utf-8?B?bmZVR3kyOEZjaWdrS0N2TzBPZGgwcnNRbEpYOVIvN3VQZWlVeGtNUlVMdmlm?=
 =?utf-8?B?NmVsUENzdEN5bS9lZWtaN1grN3FOTmE4cm1SbFFqbmwwdFEyMmtqdzZOb2NK?=
 =?utf-8?B?blF4dDI3VTArL2R5ZWFoQUc3cVZzdUVNQmo0ckt5MUxOd1ZOYm83SHAyYWNU?=
 =?utf-8?B?c2hqMmhmZzczbXVUT2I4a0tWRHVWbC9uQkJwdmtFSGR6bmZ5SytXZFM1ektu?=
 =?utf-8?B?NjBwcCtIZHNqaDVvMmVkeEs1dEFiN2NxejV5VFJXQzc1WmxkNm9jTWRaVnJG?=
 =?utf-8?B?dElNazRyQTcvdXdSdWdHTy9JWThFb1FrVjA5ejcrWUVJZ2FoeTNuaUNNc25T?=
 =?utf-8?B?ZEg3L0I1YXd6K0JvY2oyajdkYXoxUGc2Vm5NSmI3Q3VYdWh0VXNkQ0UyZjhi?=
 =?utf-8?B?eHZBbmJJcEYza2JGak1iNW1aakJPWmFSbmxqcnRHM1UwMStteGFVRnppZUxV?=
 =?utf-8?B?cEUyelZPZkw1S21YYmZwdTJvT3VzK0NxSHcrWG0vZWZBVFNqN1BPUmhNbDlh?=
 =?utf-8?B?ekw2OW5LdUc0MGpYaXJzL2xpeTVrRDRCU2gyYTB0cnZhN2R6bUhpbzIxU3gr?=
 =?utf-8?B?UTlBNmtuM2FjOTR6L29jMjkxYWxYTXhVVkFscmxnZi9pTzhBYm40R0s1SjNv?=
 =?utf-8?B?SGVWWkFXR0hjWFRjM2VBVTU1YzdEOFp3VHVUVFdiTDlMTGpXMW5PTGVlaExF?=
 =?utf-8?B?aEU3OVA4ZkM4OWpiOEJEamtvbTZDRWhVKzVkSFpvcU96ekFiUm9laktkU09m?=
 =?utf-8?B?OEtYV1Yrd25CQUVmRFFzV1pXM1BDQVFXdURKTENlNGlJUmpjL0E4ZU5GaFY1?=
 =?utf-8?Q?hpaHC0j5RGhbnNzoaPzCn+/TZ?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69fc622e-ed15-4c81-f040-08dc32c90ea3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 10:37:09.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAIvb9oy/1k2syjjXjYxaYy2iNer0rsGwQPY3UvvYJYkvEj7FD77H2uWrv0JFS8FlVfuI8g+njB6ucu4SGbGSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6235



On 2/17/24 03:09, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le jeudi 15 février 2024 à 09:41 +0100, Hans Verkuil a écrit :
>> On 15/02/2024 04:16, Randy Li wrote:
>>>
>>> On 2024/2/15 04:38, Nicolas Dufresne wrote:
>>>> Hi,
>>>>
>>>>>    media: v4l2-mem2mem: fix mem order in last buf
>>>> mem order ? Did you mean call order ?
>>> std::memory_order
>>>>
>>>> Le dimanche 11 février 2024 à 02:04 +0800, Hsia-Jun Li a écrit :
>>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>>>
>>>>> The has_stopped property in struct v4l2_m2m_ctx is operated
>>>>> without a lock protecction. Then the userspace calls to
>>>>                    protection   When ?                   ~~
>>> Access to those 3 booleans you mentioned later.
>>>>> v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
>>>>> a critical section issue.
>>>> As there is no locking, there is no critical section, perhaps a better phrasing
>>>> could help.
>>>
>>> "concurrent accesses to shared resources can lead to unexpected or erroneous behavior, so parts of the program where the shared resource is accessed need to be protected in ways that avoid the
>>> concurrent access."
>>>
>>> It didn't say we need a lock here.
>>>
>>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>>>> ---
>>>>>    drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
>>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>> index 75517134a5e9..f1de71031e02 100644
>>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>> @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m2m_ctx,
>>>>>                       struct vb2_v4l2_buffer *vbuf)
>>>>>    {
>>>>>        vbuf->flags |= V4L2_BUF_FLAG_LAST;
>>>>> -    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>>>> -
>>>>>        v4l2_m2m_mark_stopped(m2m_ctx);
>>>>> +
>>>>> +    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>>> While it most likely fix the issue while testing, since userspace most likely
>>>> polls on that queue and don't touch the driver until the poll was signalled, I
>>>> strongly believe this is insufficient. When I look at vicodec and wave5, they
>>>> both add a layer of locking on top of the mem2mem framework to fix this issue.
>>>
>>> Maybe a memory barrier is enough. Since vb2_buffer_done() itself would invoke the (spin)lock operation.
>>>
>>> When the poll() returns in userspace, the future operation for those three boolean variables won't happen before the lock.
>>>
>>>> I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3 booleans
>>>> accessed in many places that aren't in any known atomic context. I think it
>>>> would be nice to remove the spurious locking in drivers and try and fix this
>>>> issue in the framework itself.
>>> I tend to not introduce more locks here. There is a spinlock in m2m_ctx which is a pain in the ass, something we could reuse it to save our CPU but it just can't be access.
>>
>> I think the root cause is something else.
>>
>> Let me say first of all that swapping the order of the two calls does make sense:
>> before returning the buffer you want to mark the queue as stopped.
>>
>> But the real problem is that for drivers using the mem2mem framework the streaming
>> ioctls can be serialized with a different lock than the VIDIOC_DE/ENCODER_CMD ioctls.
>>
>> The reason for that is that those two ioctls are not marked with INFO_FL_QUEUE,
>> but I think they should. These ioctls are really part of the streaming ioctls
>> and should all use the same lock.
>>
>> Note that for many drivers the same mutex is used for the streaming ioctls as for
>> all other ioctls, but it looks like at least the venus driver uses separate mutexes.
>>

But I saw many drivers didn't assign that q_lock here. I am an one.
Since it is an optional mutex lock.

>> With that change in v4l2-core/v4l2-ioctl.c I don't believe any locking is needed,
>> since it should always be serialized by the same top-level mutex.
>>
>> The v4l2_ioctl_get_lock() function in v4l2-ioctl.c is the one that selects which
>> mutex to use for a given ioctl.
> 
> There was no way to comply with the spec without accessing that state in the irq
> thread in Wave5. In that case, we need to decide if we continue or cancel a
> dynamic resolution change.
> 
> 
>                  if (!v4l2_m2m_has_stopped(m2m_ctx)) {
>                          switch_state(inst, VPU_INST_STATE_STOP);
> 
>                          if (dec_info.sequence_changed)
>                                  handle_dynamic_resolution_change(inst);
>                          else
>                                  send_eos_event(inst);
> 
>                          flag_last_buffer_done(inst);
>                  }
> 
> That forced us to introduce a spinlock to protect that state in that driver.
> 
Usually we won't do buffer operation in the irq handler context. It 
causes too many times,

But that makes a point. Sometimes, I can't just introduce that a mutex, 
while most of the m2m context has acquired a spinlock.
> As for locking cmd_start, that might help, its certainly a behaviour change and
> will have to be taken with care. How does the ioctl lock interact with blocking
> QBUF notably ?
> 
> Nicolas
> 
>>
>> Regards,
>>
>>        Hans
>>
>>>>
>>>> Nicolas
>>>>
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
>>>>>
>>>
>>
>>
> 

-- 
Hsia-Jun(Randy) Li

