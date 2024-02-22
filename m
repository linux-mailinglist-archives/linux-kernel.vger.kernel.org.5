Return-Path: <linux-kernel+bounces-75986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9962285F199
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C2C2825B9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20761168BD;
	Thu, 22 Feb 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b="SSDaMrwv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2127.outbound.protection.outlook.com [40.107.93.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA699101E2;
	Thu, 22 Feb 2024 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708584347; cv=fail; b=CLlXcjALXqLkdCnlMmS1dYgxd6+baogP+thFg6dQGTJb0tIWRAmVu5tMe82eu+Kc5D8SI42OnTTCEkJUNODGsUdye0S6DQKYvIMgcDSUKwK96F/1YuhwpbPY5dpAnJab1PtTg0xJcMZ9453oZ+XBXgZAwGAQtwIL+3C3bjxymJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708584347; c=relaxed/simple;
	bh=v7gl5JcNYHpD0KDEkBVkCMnZHNRHG2QmD3f2/6iMpD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VsPnj9rJ1O4i+KSMxp7SnjIeUKai17KAUQOlitgnWxYwD81Wd0eDB1pPftf2JpZCmkfrlqP9RxH08Yb6LOZEoSWuLtWZ/mRcPZ/BuMjK3M+XrhgRkbkt3A1vn4xgO4ZkfvMUTFzlyslSD8SJsDHp7ecIEdEnXaZp79CWeGJv9vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com; spf=pass smtp.mailfrom=synaptics.com; dkim=pass (1024-bit key) header.d=synaptics.com header.i=@synaptics.com header.b=SSDaMrwv; arc=fail smtp.client-ip=40.107.93.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=synaptics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synaptics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz1XRXW4mHdiLBK4rc+J0N25mmD09wNtGKHLaiuSHJW1gOeMrTk+bxN7E6BvRwc9ZUDW0r4dVmbli85BxQUm0NOzyoPgiFEU4zuZjLx+O9ldS/q7W5AYSrZv+J+7lb85Uzn21/IcpE6v3yhE9Oh275e0OsFmbIUETN3IDeYHbke515UXN3bvRHcwbN6XNQbLw3X/VujPir7R6yVTomeutm4K0qkdtXETbrZQ3f+rErzIt05NzNTp4jMGbg/SjILcZKFLAPZgFt/cCb8ymOfJxU+jUGYiNVtgwVjd9eM3YdiEmdBLI1+lE6F6BNKeQ83zIuSl0y8ZH1O7ZMqJgHIs4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsKChv6R2v1CZHlLUXpEV+x/gV/D0htO/XBd42rvR9g=;
 b=EGrrtu+tqFC/NCzN88Jtm1QJ84SF99cnnp3o8p8g0p54PCEhpyLY2YNfhOWEBSL6GSHvBwrIR+VArCt9ltFZNOC8L8g2WxMqMYalVM3Nd/0zMOy02qcw3vy0Ckkz/GvQ2Ts05GlJB40AWffObJcnKFGeJg41sbS1p7h1TA7cBTC7PQQMAETYJJrGokfC+X303cseyrvuSV1+9Einp8ktr7Uu/jyy2+hDjalZzoLMjirUM5hVzuvBsQ+gsan7p5k7JzBzlrZN7oN1+KGyJInKbBlM5y1f2aMRwIdhYv0Z3GFtMve7+SHS4iwTd4K4SADUEhzR8/n2kecMg8vvedGxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synaptics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsKChv6R2v1CZHlLUXpEV+x/gV/D0htO/XBd42rvR9g=;
 b=SSDaMrwv65c0QhNgJ/5CVClSSN8NuK4SpyXs6ncg9A5lEXy1Xg3RxVzcas1N4GseOlQ9QJpgTNwxtOJC6NRwGcaYagJtFCBLuzemmKHezpWnYE3cbQx/m8UN6ruGbXtHZnaAqbNcaxSFlcWkJnYlbns/rdbxwBJ4sp1sfbnMU5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB5196.namprd03.prod.outlook.com (2603:10b6:5:24a::19)
 by MW5PR03MB7008.namprd03.prod.outlook.com (2603:10b6:303:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Thu, 22 Feb
 2024 06:45:43 +0000
Received: from DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5]) by DM6PR03MB5196.namprd03.prod.outlook.com
 ([fe80::1676:f700:fa63:91b5%6]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 06:45:43 +0000
Message-ID: <01dfdbde-d674-4590-b21b-bd4c2af85191@synaptics.com>
Date: Thu, 22 Feb 2024 14:45:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-mem2mem: fix mem order in last buf
Content-Language: en-GB
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: mchehab@kernel.org, sebastian.fricke@collabora.com,
 Randy Li <ayaka@soulik.info>, alexious@zju.edu.cn,
 linux-media@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 linux-kernel@vger.kernel.org
References: <20240210180414.49184-1-randy.li@synaptics.com>
 <a43eaa0cfedeccc85410d2e26f296bda8de635cd.camel@collabora.com>
 <1f80b5ea-1209-438f-b07f-3a4a308ee35d@soulik.info>
 <27ef9490-a56b-46bf-84bd-bc2ec08896af@xs4all.nl>
 <8d236cbfca8c4ea573d340109387fc804f1a89cd.camel@collabora.com>
 <e5b1db79-7fb2-4e51-bb93-73f31bbd8804@synaptics.com>
 <2a6be79192fdd12eaee182dceb8f1cdf0fc1bd8f.camel@collabora.com>
From: Hsia-Jun Li <Randy.Li@synaptics.com>
In-Reply-To: <2a6be79192fdd12eaee182dceb8f1cdf0fc1bd8f.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0038.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::21) To DM6PR03MB5196.namprd03.prod.outlook.com
 (2603:10b6:5:24a::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5196:EE_|MW5PR03MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: c40b8e0a-c880-4294-a253-08dc3371e3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dANXrhA0gnCVDc3JIVIEoM115ubtCFAf0ldjnX6hXA9yeWf5lNtxO3CBb5un0RVS+qaD30Eh9Z899IBKgn0W0LfRBW8SUgmSFOrTSFPn458rUr3Bi97F/tK9iK3QyRE0Kk2sc+dPIo76QmA7x17HLBKNsbyZ1ri7+elcDjBL08S0VAs4P8vCLfLGeqnXqzVQo0YDiP7HxyG+0SA32kk1HOZrDZK9kSAUIPlVDfPwuP9ZtYWNjOsMupbVvag5e+EZHOLjibN4DYnGmefiHsqjV28yIzH2/GTmJlGQ/yBfBHgxUAMDkZOCvv7vToESgIQaaRMgcbEhxk4tsEtpdS3rG9RZEdwAHmL1opIdpyyXrBsRj5QX3d0M6Sf7eq7Rr03YHhIrxQCPobWk+ssk+Xoyh4LLpFR58xtd8MpZr4N0SNJKFDV78MWTmcJkSXHguTbyPnXqMnz4EI9oH2AgTLjEl/OqzWb7rS2wj6mJCsnVe5Lf5xJGlvSdDn0Rfti+TQsqMbuLx9h8VEundVaCuGzeykJYICz4HNK5HtaSQYBw1GAh0eVDmo71dzFzMXsCN0ox/nRdzGV2dc2bIxxiHc53fUPnKoA6sHRWvBBXUyZPGgD9WgA2BLOeJqVYG80vfmJQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5196.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkxYaUlWd3o5SGFNTFpDRFY4Qmw3MFQxUTRpTzJhNTNhZHBKYnVESmVBcFda?=
 =?utf-8?B?UEpienY3R1dVWEI1bkR1NEcwV0NNL1lSNW8wUHZIOFhJWVFkcDNRL0Fab3NV?=
 =?utf-8?B?RVJhK1Z2Slo3R1F0RnEwTFd4TU54ZDNLR1VoR3hZc3hOcVpKZlFUT0FrQk9o?=
 =?utf-8?B?a0lYS0xVd3ZRdUtrYjI4SE9jamlQRUJNSW1KNXpxZHVWV01GeEN5SEVGYmhY?=
 =?utf-8?B?eXVxK0lld0dFbmVIaWxSS1VBazBWNnBvS3pWZmRmOUtZVURXb2prMDJvTEdo?=
 =?utf-8?B?R2xTZWNjb2hhVnJkdGZXb3NoKzltaHpBM1dQbFVsYTN0UGp3UlA4QW4rWWlV?=
 =?utf-8?B?Q280ZC9qc29yWXNCaHU0eW9pVjlRWk5vNnJVR2pBYkVQNm5HRTNzS01wRUVB?=
 =?utf-8?B?dHZ5MHhwTkF1UE04b1ZlRlUzZmh4akorbHo4emk2TWlINmJpOFdKVDdLVDFE?=
 =?utf-8?B?NURjMEUrOTZlSEJFelNRVUt2S3RObVZiWUtVYnhSaWFFZ004V0ozeWlIOW8x?=
 =?utf-8?B?T3hpbU9mSzcyMExhTWVJMG1tUGp5Z240NUJlQWpMUzYxdTNxUkRqY3pURm9i?=
 =?utf-8?B?N21pOU81K3pTc1NlZS9WTCs0SHl4cHZsbmpZNkVCQ0QrOGFOa1B6QzM1SGEw?=
 =?utf-8?B?b3ZwZTRqdW5Sc1poNmo2YTVMVVpRbXVCVXhPcnhEZXo3QVg2UUlNS211ZSts?=
 =?utf-8?B?dndsSGhjN1VvWFBiZWRGSUhFM0Jxem1hOU5MSzVWa0l1ZmZHb3FVbERaR1dT?=
 =?utf-8?B?VFNyb01UTnBlRVNRU1p0ako5ZGNYVkhueDZINmVZMUZXbldoUFpYOExmYzRP?=
 =?utf-8?B?MmJNUXBWMEZESUR6NDQ1WXdZUEROVkdRbFFUckUvd0ZiZ05ZRG11Q09xaHM3?=
 =?utf-8?B?NnkzcWdrZENDTnMyOXpyWVBjWlAreFJFbExTekhpcThoQWVKS2QvcnM0N3JD?=
 =?utf-8?B?Z3l0YnY1N3NiRG9jOGhmeHNaUGRzSmNJTlA5U241NFJud3BQYURIbGszWEdl?=
 =?utf-8?B?QlNlanNGeWh1elV3ZGNPRS94Mzl0WVJkZXBpaWFpUTJodWtIaFN1VDJDL0Y0?=
 =?utf-8?B?UjJpRHJuVmRiMnZiM2RKMzU2L3JPUlNQVW45Q2VmOHM1ckU0a1ZrZjN4YlBU?=
 =?utf-8?B?NHp4Zk9MdXZGTUhJb29oZXd5S0Q2RzljYmdrL0tyd0MzWjY4TGlsZlNGL3Ju?=
 =?utf-8?B?aXFibHRZNXZrelNnUVhiQkJRNWtDWitQdkY3bmZLSUVQVThqck9JWDlsN2dS?=
 =?utf-8?B?alIvWHoyNHhoSWI5OWFnUE5yOWUwNnZxUkdTU1pyREZBdkpBa3ZSbDJZTzFw?=
 =?utf-8?B?OUIxY3IrQXByWm5odDBEaVlJL2N1WjBlakNpYSs0Y29RUDVOblg5alNZT1pM?=
 =?utf-8?B?cmdHZUNaeVcrUXdQNVN5eFhnc2RKRkdDR3N5QUpBOE11RjlTWXpJSWVnNi91?=
 =?utf-8?B?Nk1LWEhrVTNrMGtSbEhnOHBvaDVhWjB2NVRnTEFCOFhLSkVzWVZUMnRwblNw?=
 =?utf-8?B?d3o5MTJ6MUFPL0tEckx1eUkwR3JlTGJ6b2ZPNmRHdm10SHQyRVk0NFMrM01v?=
 =?utf-8?B?N3RMcklOai80WU53aC9oUUdWMWpvMU9VMWVpdERCaGNGaVlEb25HSG5kOURx?=
 =?utf-8?B?clQ2NTNKeDZUdHdJRWw4cjErREF2S1pFUkZYbUtMMHJDUVN5Q3NjaWQzNGc0?=
 =?utf-8?B?WUVuYUZRL0Evc1lsWTN2Y3hmaU1rUHFHcXN6TEZFMUlxRGo0Q01Dd2RCN2Z3?=
 =?utf-8?B?SUZrSmNUK0ZveW5palZ2Q21ibWQzZ01SaG1ldThPMXBpYlgwL2lFMWRXYUFB?=
 =?utf-8?B?cmJxQ3plZHRDaU5meUFMMWw4VGtpNzk3Yll5WnVoYjlNR1BKWWV5aUhiczhm?=
 =?utf-8?B?NU0xZS9yWURweGlRcEJWd0tBRDV2a3hLR2NHeFh1SGYwTURwQ2JIcmc1azlK?=
 =?utf-8?B?TjdvcGo5ekt5dnB5Q1lPSHhkQUw3K2xnU3RmUGxzRW1WQ1BkeUdkN1lFQTJw?=
 =?utf-8?B?b3RPR3RzeURtY0dVRktVUHhpQnhNalRCb3Q4NlVRYVVESzBqUnowcVJrdjdM?=
 =?utf-8?B?V2ZiYWl2TVBsOEpNMlh3QjdSSG5UQjhBbzlmd2w4aHo1aWswUytBSVJkSUts?=
 =?utf-8?Q?6l5Y59RyCxrz6Gwsqj2xWvs57?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40b8e0a-c880-4294-a253-08dc3371e3ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5196.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 06:45:42.9294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLc+fbhuWU623Ozu+yH1SPDEgC6RkdLb0e127h2QtB+pQdzQWS341gldQxUrYqVrBMh1NQ7VblVjzURC7IIMyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB7008



On 2/21/24 23:32, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> 
> Le mercredi 21 février 2024 à 18:37 +0800, Hsia-Jun Li a écrit :
>>
>> On 2/17/24 03:09, Nicolas Dufresne wrote:
>>> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>
>>>
>>> Le jeudi 15 février 2024 à 09:41 +0100, Hans Verkuil a écrit :
>>>> On 15/02/2024 04:16, Randy Li wrote:
>>>>>
>>>>> On 2024/2/15 04:38, Nicolas Dufresne wrote:
>>>>>> Hi,
>>>>>>
>>>>>>>     media: v4l2-mem2mem: fix mem order in last buf
>>>>>> mem order ? Did you mean call order ?
>>>>> std::memory_order
>>>>>>
>>>>>> Le dimanche 11 février 2024 à 02:04 +0800, Hsia-Jun Li a écrit :
>>>>>>> From: "Hsia-Jun(Randy) Li" <randy.li@synaptics.com>
>>>>>>>
>>>>>>> The has_stopped property in struct v4l2_m2m_ctx is operated
>>>>>>> without a lock protecction. Then the userspace calls to
>>>>>>                     protection   When ?                   ~~
>>>>> Access to those 3 booleans you mentioned later.
>>>>>>> v4l2_m2m_encoder_cmd()/v4l2_m2m_decoder_cmd() may lead to
>>>>>>> a critical section issue.
>>>>>> As there is no locking, there is no critical section, perhaps a better phrasing
>>>>>> could help.
>>>>>
>>>>> "concurrent accesses to shared resources can lead to unexpected or erroneous behavior, so parts of the program where the shared resource is accessed need to be protected in ways that avoid the
>>>>> concurrent access."
>>>>>
>>>>> It didn't say we need a lock here.
>>>>>
>>>>>>> Signed-off-by: Hsia-Jun(Randy) Li <randy.li@synaptics.com>
>>>>>>> ---
>>>>>>>     drivers/media/v4l2-core/v4l2-mem2mem.c | 4 ++--
>>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>>> index 75517134a5e9..f1de71031e02 100644
>>>>>>> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>>> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
>>>>>>> @@ -635,9 +635,9 @@ void v4l2_m2m_last_buffer_done(struct v4l2_m2m_ctx *m2m_ctx,
>>>>>>>                        struct vb2_v4l2_buffer *vbuf)
>>>>>>>     {
>>>>>>>         vbuf->flags |= V4L2_BUF_FLAG_LAST;
>>>>>>> -    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>>>>>> -
>>>>>>>         v4l2_m2m_mark_stopped(m2m_ctx);
>>>>>>> +
>>>>>>> +    vb2_buffer_done(&vbuf->vb2_buf, VB2_BUF_STATE_DONE);
>>>>>> While it most likely fix the issue while testing, since userspace most likely
>>>>>> polls on that queue and don't touch the driver until the poll was signalled, I
>>>>>> strongly believe this is insufficient. When I look at vicodec and wave5, they
>>>>>> both add a layer of locking on top of the mem2mem framework to fix this issue.
>>>>>
>>>>> Maybe a memory barrier is enough. Since vb2_buffer_done() itself would invoke the (spin)lock operation.
>>>>>
>>>>> When the poll() returns in userspace, the future operation for those three boolean variables won't happen before the lock.
>>>>>
>>>>>> I think this is unfortunate, but v4l2_m2m_mark_stopped() is backed by 3 booleans
>>>>>> accessed in many places that aren't in any known atomic context. I think it
>>>>>> would be nice to remove the spurious locking in drivers and try and fix this
>>>>>> issue in the framework itself.
>>>>> I tend to not introduce more locks here. There is a spinlock in m2m_ctx which is a pain in the ass, something we could reuse it to save our CPU but it just can't be access.
>>>>
>>>> I think the root cause is something else.
>>>>
>>>> Let me say first of all that swapping the order of the two calls does make sense:
>>>> before returning the buffer you want to mark the queue as stopped.
>>>>
>>>> But the real problem is that for drivers using the mem2mem framework the streaming
>>>> ioctls can be serialized with a different lock than the VIDIOC_DE/ENCODER_CMD ioctls.
>>>>
>>>> The reason for that is that those two ioctls are not marked with INFO_FL_QUEUE,
>>>> but I think they should. These ioctls are really part of the streaming ioctls
>>>> and should all use the same lock.
>>>>
>>>> Note that for many drivers the same mutex is used for the streaming ioctls as for
>>>> all other ioctls, but it looks like at least the venus driver uses separate mutexes.
>>>>
>>
>> But I saw many drivers didn't assign that q_lock here. I am an one.
>> Since it is an optional mutex lock.
>>
>>>> With that change in v4l2-core/v4l2-ioctl.c I don't believe any locking is needed,
>>>> since it should always be serialized by the same top-level mutex.
>>>>
>>>> The v4l2_ioctl_get_lock() function in v4l2-ioctl.c is the one that selects which
>>>> mutex to use for a given ioctl.
>>>
>>> There was no way to comply with the spec without accessing that state in the irq
>>> thread in Wave5. In that case, we need to decide if we continue or cancel a
>>> dynamic resolution change.
>>>
>>>
>>>                   if (!v4l2_m2m_has_stopped(m2m_ctx)) {
>>>                           switch_state(inst, VPU_INST_STATE_STOP);
>>>
>>>                           if (dec_info.sequence_changed)
>>>                                   handle_dynamic_resolution_change(inst);
>>>                           else
>>>                                   send_eos_event(inst);
>>>
>>>                           flag_last_buffer_done(inst);
>>>                   }
>>>
>>> That forced us to introduce a spinlock to protect that state in that driver.
>>>
>> Usually we won't do buffer operation in the irq handler context. It
>> causes too many times,
> 
> I took this one out of context, but this is inside a threaded IRQ handle, we
> indeed have too much work and state to match with how Wave5 firmware behave. As
> discuss on IRC, not being able to see the Synaptics driver you are referring to
> has its limitation.
> 
I think it is common sense not sleep lock(mutex) inside irq handler.
Besides, it is not wrong to keep the runtime of the irq handler short. 
You are occupied a CPU core non-preempt.

I could show you a few slices of our driver while it is not formal 
released. The released version could be mediocre one.


static irqreturn_t syna_vpu_isr(int irq, void *dev_id) 

{ 

         struct syna_vpu_dev *vpu = dev_id; 

 

         vpu_srv_isr_done(vpu->srv); 

 

         return IRQ_HANDLED; 

}

The real work in a separated thread(work queue):
static void syna_vdec_v4g_worker(struct work_struct *work)
{
..
         if (ctrl->status.flags & BERLIN_VPU_STATUS_WAIT_INTERRUPTER) { 

                 ctrl->status.flags &= 
(~BERLIN_VPU_STATUS_WAIT_INTERRUPTER);
                 ret = vpu_srv_wait_isr(vpu->srv, 
DEC_V4G_TIMEOUT_DELAY);
                 if (ret) { 

                         ret = syna_vdec_hw_abort(ctx); 

                         /** 

                          * NOTE: if it failed, keep the device power 
here
                          * then we could dump registers from the 
device.
                          */ 

                         if (ret) 

                                 goto bail; 

                 } 

                 goto decoding; 

         } 

 

         pm_runtime_put(vpu->dev);
..
}

>>
>> But that makes a point. Sometimes, I can't just introduce that a mutex,
>> while most of the m2m context has acquired a spinlock.
> 
> In wave5, we had to use a spinlock as the framework holds its own spinlock while
> calling job_ready() (can't mix lock mutex while a spinlock is held), and we need
Yes, in __v4l2_m2m_try_queue()
> thread safety in that call in order to use that state to make the right
> decisions. On agressive stress test, we were getting stalls due to decisions
> being made with partially written state.
> 
For those three variables, only the has_stopped matters here.
I am not sure which case would need more lock acquired here?
CMD_STOP a context after it has been started?
They would always go through rdy_spinlock.
>>> As for locking cmd_start, that might help, its certainly a behaviour change and
>>> will have to be taken with care. How does the ioctl lock interact with blocking
>>> QBUF notably ?
QBUF? m2m would use rdy_spinlock here.

I didn't really get your case?
>>>
>>> Nicolas
>>>
>>>>
>>>> Regards,
>>>>
>>>>         Hans
>>>>
>>>>>>
>>>>>> Nicolas
>>>>>>
>>>>>>>     }
>>>>>>>     EXPORT_SYMBOL_GPL(v4l2_m2m_last_buffer_done);
>>>>>>>
>>>>>
>>>>
>>>>
>>>
>>
> 

-- 
Hsia-Jun(Randy) Li

