Return-Path: <linux-kernel+bounces-97064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2AD876504
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631281C218BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851873BBDD;
	Fri,  8 Mar 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pvAUTXi5"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2080.outbound.protection.outlook.com [40.92.64.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B2822EFB;
	Fri,  8 Mar 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903979; cv=fail; b=iguObbDmgFA888Wok0bNJRsaOnSE1R5ELFuYxf8qD520Vi0WTLpXtXk7Lo3Kqbb7p/AsWwHhFhyoDuGa1OcCBFbkjiSieImyCT9GQ0GNgBArO6qEVn19lTxA7ZPa6nQAtuD7KIWLjGvUm6iehjHCmK2oih50VSAQddGQVrhc0x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903979; c=relaxed/simple;
	bh=maLG+lG4BRYhGffDIseQcJKOUkhdiXnxgEcXBmXV9fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ryNpp3YJdB6lP6IAAEdLXV6uu56gVqsVgckWtG9cPXRdkY2JWzBJMIpmYHaGNRZQ0jFBd9iekkbEduUMt5paJK0kTcyp9XcjDSZJGAPRZJ4iFn2NDqxKyRnS0PX+mCYXGBOqxlq7bDp5khELwY0rKx+pORIvFUZ5IDwW9WF9aZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pvAUTXi5; arc=fail smtp.client-ip=40.92.64.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoQRR5WBhLnu2N7xuJ+AlxH0je3KJpS3ffJRCv4WlcaRmRg9Z7nzhmSoOPByi/QbeiKPe5U/jvNNVvO2bieBt7psmmM43fuZq85s0lsI8MpzOhg7AJsEPZL66PHLMDd5jrGh8+ehBXYptXtFBEmY6ByWcCzfrZvHnnWmJRqjN3DrRxfbpt28/SpNymh8O+ZnpsVN5ac+arPgFmycJkCxOlrfaDj3NIow7eD9RKoOGu/hnX02gu97PDgwljgzFY88SMmOWOC3yq1HKRpR041gly0QdjI3ya97XOVowTpuJDYDNzqDLL55NO62YM+UBOi2IHfL3Dmr8fJ6eeSXNyZOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MarknDqVVjnz3Vkpmsh4xt8Y2KFGhU5h4Euke8bn4I=;
 b=hE8phGWMdX5CPhAWsvbOmf5ch6Bi8n0hv2OiLIDJmYwT0KFvgsF+75leSvUBWLThJqbdkTco33BTEZwqdRwK7UmgxZh12QPH66pPFjN1M307O8M4gwWvr2fprSjzZxnm2jen4CXLKWAoVNKRPJu+jc6+7M6E+GZPkyegZgKs+qiQyT6lBSzNAvHjVjQiqdHzEmM8nNA1hl4YUp0cZYK3ZW4rZhpYu5i8Oq9SqzNuY6F4cBJibOYenM3NLboaSm0ElLvuyGIBCy28B5gLcrgCVS4LlJW0uJy6eluaei3vMZcAgaZCizfiELng1tSWETbLx92QJYgZ4kZrhMRBb2kycQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MarknDqVVjnz3Vkpmsh4xt8Y2KFGhU5h4Euke8bn4I=;
 b=pvAUTXi52aa1zaSwwO46av9LokWk8AgIa4eMdRWgizCpvdndXuVIc4t6CI8+OkuG/WhoFOovESkQAscbMXfk/vYpHK5VrpwEHtu3QjWX9fKKXPk3pYtmnXlJC1wgkGQ0+XJKnNbAxlnAlt49K3FrdC1tSpThEeDhx6cjkgnbSjQuN2ytxy0g4Mt1qbR0eBvnEtk5BxZvDRVusuUMzFlu8m8rkAcW/e9F/JcgOFi39l1c6YtacQUALzIc59tw/RUXhAyOy+vhRu61kSnB3001v3KSJfw89dfLsGcR6p5+gQUcgLRb52ZUWxEUtnTSziA86pMweDEKDvOb2PzlphtVkw==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DU2PR03MB7941.eurprd03.prod.outlook.com (2603:10a6:10:2d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 13:19:35 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 13:19:34 +0000
Message-ID:
 <AM6PR03MB5848654CAA0174407FD4DE7299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Fri, 8 Mar 2024 21:19:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net/packet: Add getsockopt support for
 PACKET_COPY_THRESH
To: Jason Xing <kerneljasonxing@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB58483266DF047DA017C540CD99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CANn89i+TboBh3S3tegSqZJvjTCCi_Sa+o3iwETygFw5GqjJPsw@mail.gmail.com>
 <CAL+tcoDpZNqU9eJ0oyTyBrcHxnqR_HoGbqy0wznmyczpR05XtA@mail.gmail.com>
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CAL+tcoDpZNqU9eJ0oyTyBrcHxnqR_HoGbqy0wznmyczpR05XtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [QtxF1Z3AwTERGqEDf7wPjvrAy8u6PRLW]
X-ClientProxiedBy: LO4P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::6) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <d857f8a3-e5fe-488d-b09b-b3260562fb80@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DU2PR03MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: d4445de5-4482-454f-e199-08dc3f7265b0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YzpIXBIpBaPiQX/AvfPQTryR55qKYw+nc7fZcMEa24wlPs8wcseLvCpGoEee96IqpBZ3WJdc31qo9LzOypa8lYiijzc3X4wHtsZ3MjosyNxddqudeL+0biBZDZFTyFakSMQcHTQy6wvtgJHvxxJ58SmiHLNBVaO5enYn9VZET/+iPw5twdJUD6T4bS33KXtMX2QUbCnr1hqVtaXAAePyy9d8qsTCQK+IbHGf3s50Zsa86eZJvytFQNEn0LfeBYE32JcIlcsmOzDzVoa1F4nOoc30SS1T6K+CqzijwCIKKlSFLh4h9u1qQuLQ+9CzhdhzmfKt4iRVssZ9jddbKBLcNnvxd4veou8IiOxi4vEnhAnpzmkfS+BKP6D4UZ0Xw1I5DTHauILIwIFP8Dhx1shbjW+vfuVgpQMbPg1gYbMCeAJCrRJdiCZEEr/zOjGjV5jjk5VeJVE3DHwTLwm4HmXuEK0rcMBlPg2atF29y7Xm2lsQrwHlwNmEl6jALU1rz+XCcYja5icvmnt4f218t6OVdYwoSjiihwmyUz+6LGpeaZKgJmVQPaAoc0Czsi5n0kXb
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bE9jSkxJd2QwZjMvSEpWZGl1RUhRalp6V3I2ZmtXTHpFY2VObzZYRDliSDZY?=
 =?utf-8?B?YjBOTXJDT0tiZUc1Tk0rSkhkalhKUmVTbmMzdEpaRE9PZzN5S2cwVEJ1cEhW?=
 =?utf-8?B?OU42TkgrdmFMbDQvTjNBNHVoY1U5SnhCYlpZTGhtRVppRXFKeXNzbUNtUzJX?=
 =?utf-8?B?WEd6TzlocExNRmZJN3k3Z1hKaFo0ajZEZldaODEzUVVLMGVaa2pkc2QvVjZl?=
 =?utf-8?B?Q3QyQlBMcmVDZitoRi9KZWRITUFJc3NjcXhWOUI0RGpPT3YraWt2YWxCNStQ?=
 =?utf-8?B?T25GcmNRczF3elZpWkF3eGdXUUwyV3d0RnkvWHlWa3R4bEs0VkM5UWdJNjA5?=
 =?utf-8?B?ZUF5ZE54akpCT09jaERPQ2N2Q2E5YUFKdFExa0haWWRqZ3BwZ1VkOGJZVFhB?=
 =?utf-8?B?MlN6KzdUeWw3blJaaWtyQmQvUjh5VlVlLzB4SXNvL0cyOWs2SWpXOWIyRGFY?=
 =?utf-8?B?ODRyeXVCWVhqUjZRK2RsQlY1ZEZLWlJ3cVVxeEQvSUVUc3d4dkM0N1REOXJm?=
 =?utf-8?B?RDF5R2h2ZjJTTEZxbXlQK0YrdytHOXdvOUhlVXpRdVUyaU9wOFMxZDZGV1Bx?=
 =?utf-8?B?WGl6ZXBGc2xCdjByWVJFa0VvVTZVTXJhcmVISE1MQUdsVm5saVQ2Sjd3NmR5?=
 =?utf-8?B?L21ha0M4Sk5LMnJXbSt0blNId1pDdFVPZUdHUmQwNlBIZVgwVjFabmZIQmcx?=
 =?utf-8?B?YTZtUmwwTkM1dEdleERzbldKR1dISWxTb3dROEtzWG9URC9EMXZpSEluQnV0?=
 =?utf-8?B?T0VKTmFJVW43d3MydmM3dGNEaEJkSElhYWhWaXpwSFdLNkx4eXY2NnBwbnZl?=
 =?utf-8?B?bk1sUXdsRU9RUVBiUjBIeDVCcG1iSmYrOE1EMGFTNE53em51dGtyMGVsckxh?=
 =?utf-8?B?QXMrVUR0S1RPRG51L0x6WDJDb3JGTitHcGNZSzJLNCttMGgrM1JRK0pOOGd2?=
 =?utf-8?B?d2NzZURmNlUzc3JKYXlIM3hiUXhwZ2pOWDlBWTFVY3dCeXFCajc4SU5KcGY3?=
 =?utf-8?B?bVROYW9hSTZlbmJVTkNqTEsxaVdWMkhEc0hPTU5sdTVkOGlmU2FDWW51Y3N0?=
 =?utf-8?B?QVhES2tNSWxGTm92SjVUbmJRcnFrbUNTNTFUODVPY1VlYkdvdk1OTEhzVjY3?=
 =?utf-8?B?MXRBbGZOQ0plZVZUZzNEQnN5M01zcXQzUFREaHp2dWo5SnpYbjZud2lhUjhO?=
 =?utf-8?B?T29rS3JNZTBxRi9LL3FLblg0eW16TXdzNStKc1dDckQzQlo1SG05TkRvTkhE?=
 =?utf-8?B?NmRhNGkwQ0FUQy9seXlib3hOSkNpS1BFRVFWUFI0TTJ2WHZ6d3IwUHBjRy9F?=
 =?utf-8?B?SU5uUXUrZVFOTTBzT3ZQcFBERE54RVBNWG5SMEd6eE9uUk51SUFQSStTdUVo?=
 =?utf-8?B?TkVMa2hFVVVkY2xnZ0hoanBOcjlqRGNIWklndnBmRml2UFNOYjBwT1lzSmFZ?=
 =?utf-8?B?SStnSXlEM2gvYlc3Y0t0TzdWcU9XNFhMTHk1UTYzUW1JSEVqc29udjNDZWc3?=
 =?utf-8?B?MGlUdmtYdXNhRWhvTnNEWlVPZFcwTlJuTWRZeWpOMklhK1kySVdjWWpVemJN?=
 =?utf-8?B?SUJHUzhxSHlpVWNYQWduWEw2QmFLOWxzOHNPMC9GdEk0cWhYeUwxUTRhKzhI?=
 =?utf-8?B?NzVyVjVYaGlvVU1kS000L2N6L2IvYTYvQmNtMjREK1VvdTZtR1AzMGhockVs?=
 =?utf-8?Q?/uZtbh8+ZBY/AA3M6sXl?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4445de5-4482-454f-e199-08dc3f7265b0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:19:34.6296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR03MB7941

On 2024/3/8 21:11, Jason Xing wrote:
> On Fri, Mar 8, 2024 at 8:56 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Mar 8, 2024 at 1:43 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>>
>>> Currently getsockopt does not support PACKET_COPY_THRESH,
>>> and we are unable to get the value of PACKET_COPY_THRESH
>>> socket option through getsockopt.
>>>
>>> This patch adds getsockopt support for PACKET_COPY_THRESH.
>>>
>>> In addition, this patch converts access to copy_thresh to
>>> READ_ONCE/WRITE_ONCE.
>>>
>>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>> ---
>>> V1 -> V2: Use READ_ONCE/WRITE_ONCE.
>>>
>>>   net/packet/af_packet.c | 7 +++++--
>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>>> index 0db31ca4982d..61270826b9ac 100644
>>> --- a/net/packet/af_packet.c
>>> +++ b/net/packet/af_packet.c
>>> @@ -2318,7 +2318,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>>          }
>>>          if (po->tp_version <= TPACKET_V2) {
>>>                  if (macoff + snaplen > po->rx_ring.frame_size) {
>>> -                       if (po->copy_thresh &&
>>> +                       if (READ_ONCE(po->copy_thresh) &&
>>>                              atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf) {
>>>                                  if (skb_shared(skb)) {
>>>                                          copy_skb = skb_clone(skb, GFP_ATOMIC);
>>> @@ -3836,7 +3836,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
>>>                  if (copy_from_sockptr(&val, optval, sizeof(val)))
>>>                          return -EFAULT;
>>>
>>> -               pkt_sk(sk)->copy_thresh = val;
>>> +               WRITE_ONCE(pkt_sk(sk)->copy_thresh, val);
>>>                  return 0;
>>>          }
>>>          case PACKET_VERSION:
>>> @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>>>          case PACKET_VNET_HDR_SZ:
>>>                  val = READ_ONCE(po->vnet_hdr_sz);
>>>                  break;
>>> +       case PACKET_COPY_THRESH:
>>> +               val = READ_ONCE(pkt_sk(sk)->copy_thresh);
>>> +               break;
>>>          case PACKET_VERSION:
>>>                  val = po->tp_version;
>>>                  break;
>>> --
>>> 2.39.2
>>>
>>
>> I think you forgot to change net/packet/diag.c pdiag_put_info()
>>
> 
> Ah, he updated his patch so soon even without taking a break.
> 
> I just replied to the v1 thread with three changes made.
> 
> Juntong, you could check your v1 patch thread and you will see the
> missing point.
> 
> Thanks,
> Jason

Hi Jason,

Thanks, I have fixed this in the v3 patch.

