Return-Path: <linux-kernel+bounces-96975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E051876400
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049E41F21B63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3756763;
	Fri,  8 Mar 2024 12:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="e0U0eP99"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2098.outbound.protection.outlook.com [40.92.73.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378694F1FA;
	Fri,  8 Mar 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899688; cv=fail; b=F5h6qUmP4ZuPOqmYe1NJh/0wM8AUBf46Q5Guhqj43FcI6m51ymI2B/49mpsba9u4lmG5UpZIgQUGvA/ssMhMBHCy7f2edU7/ucnJauprKnGGjgDfMFPaaXNBpymIebH4rZtGXO5Q4UfqX52duGv9vNh6iV+nTpRcTtnixosFZ/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899688; c=relaxed/simple;
	bh=HwgBnu7ocQYXcdrTpmytjyQGzcEbCQj1/C3UxJx3opY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LtNYXCY+LO9svRVvcW04E7g8OvQpm4c11tjzcQZpJBjEFYXywnasXed2syusbPIfoxU7AX4N9SVM23k7i9G4E8qFFuEhZyRQNvljDmVBArilgomfn/t1zmQjlZYqwZU52rZrJRM7O/tjsKDg9Hk3uPa2as9JIybboKVmvQtN9G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=e0U0eP99; arc=fail smtp.client-ip=40.92.73.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV+twj2Zgm800pL5BrLYf3dZJBNx9NJwxpOJldR1g2IpXHEOdRNFys49hN6tpvsxsb7Skbvd0eZwyhGr9Lva8fqSAqLifegADuoBAksL04/8M3cI9Q92W4B0dezN4XJ1Z8jX2wZF8/xIkzF6CIp8r71Oa/SM3x9MsQE/bDf9vIEPdgTBAr0pqBZFehgeXnP5o7SjlhhfxWvWZM5NKtrG0c28yvZiHZMQ2eoAy64x7eQ00T+gYPuHsjHblEeHbehBEJmBXjli4KQHKD0jcPV9IEUPNFqrtMRe7fW782+qQepMpxMM5e484I/IRriSugvFMa6p1MKelOZBWwmP4xONZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDsEN2nENDKSg/7/fuFSa+FR4BicXDDZbXWsToansU4=;
 b=NXidmB59FzrCI5/oHQk+Exg1z/M1GPU4QH29a+IcsIcF4ehAFzJsaXVc5/qUUgnVIe2NTSv+QXYqVzw2xYxyDuGBHhzmU09HEfy1WhhEg0vn250qvU9gF6G2gSz/BlqK66c39ts5fdmTwNorrr2QN2JrTcITDMCsdy+jI0P9iBzHTvhNc0afQIwd2ZRbEgHZXA1Iog0Wh6Le4BbUX4QoSZPvRVXeA+WQ0s6MXH4TmSi2EQrPk8osdlnfPewL7XlxgqH4FfaYkRcs4I78OBhusGyFXxrDhijeBoJDiHZVtVRXIyfUsNQclqNW5vAzvrlS7ZiXJTljX8M9p0fb+HK70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDsEN2nENDKSg/7/fuFSa+FR4BicXDDZbXWsToansU4=;
 b=e0U0eP99D0BG3CPPgXNMmXIXImxYRC4EmNmzuqyjBd8Tv7a4KARByvLfeXuuePNOGQ8CLDQ9kkcqiYUOR/Ea289Cttx0W/eQFzM80glUZ/3SDgnV/c7sCJJW9DtfpupDEBC1XAdp8lGqkmqBqanerOxvVCqgGS1YRsGTyauq0nql5uAyVOaxaRcRQamb8cwhmZNkMCKNcpQ+dJJIQMhQGfYptdcroXacAbBF5BEodNj0s3d9kg1TN+/fMti/0h9oeb67//NJWmxesSYku8XaSs2D7VvOpNt6G1OxouSYH5mEQAkahBvPYNZf9XoOmiF8uqgIcK3kOZgUUXIaDiX/CA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DBAPR03MB6663.eurprd03.prod.outlook.com (2603:10a6:10:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 12:08:03 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7362.028; Fri, 8 Mar 2024
 12:08:03 +0000
Message-ID:
 <AM6PR03MB58489E6E890BA4A20D429DDC99272@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Fri, 8 Mar 2024 20:08:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/packet: Add getsockopt support for
 PACKET_COPY_THRESH
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5848595A20BB5D958C2D9DE299272@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <65eaf9e336d07_133b25294db@willemb.c.googlers.com.notmuch>
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <65eaf9e336d07_133b25294db@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [rgcqBbFA9fG9tvl+t2cIPufx4Vn4eTPO]
X-ClientProxiedBy: LO4P123CA0478.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::15) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <94f68436-2ebf-488f-8e9e-78d6ea841aef@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DBAPR03MB6663:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aba2172-594a-4617-69c8-08dc3f686702
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SZaD5D/3Zvy6KJ+22nvkxxhOmAUFGRt1CzSB1x4ujsG3/wrIKXeINhB1v/Q0ggEgTOzFy3KpftUZEJ3LsVI2t9XJLWkbyKoxlRD0xw6mwVTL10XqC2y6d76WczqvJWy1vnd8jTaVPMhT27NnXsnXvYFMC2Bbs8PrxkyRQkKWjiGNz5ZDUdfLaKGT/7yJqyJXmvk1UwE362oOm7XHvZ6tPZssmlExoP7GGTYt2GdjNF1AjGsvIePzVLHBk8e1Is25BJTJHUhBfSBmzNAFFFzCUEtuNoMhJdvMOxDXK27F1xEHrw4GIG+8zlu6Cqs4o2G4XZNV8yqMFeNbzA+2ZC354FyqnbGGvNHwyqmbjajrFv0MbuUBdwL/ooI9N5a+7K3PADhQpxazt+bdx0eZ9bxdoI8hm63/sUlIeIfWoo38p3TpOuThRIlYOIMTq8xeeL9mR+P95pkP83uAK9B/jVsGrXi0z3Wm7LVI1lHdBZbpyCKbjJfOc4Y3UBkNCp+HnbcUy2ZtRdit5X0yq5ON31ydypK/Fx1Hqwkgt+YwjLMr7yrrp71c9FOF6FEy9JiH/zZw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2k2NjFtZHlIZWJuMWhKbm9XM3RiQytOcmMyUnpIdnZPUXU0QmFDNnVSUTJX?=
 =?utf-8?B?aU0xUFdPbnIzMXhoSjA0T2FZUm5WVytUdFZwVC9xSFdRa001OE5TOXdkeVBZ?=
 =?utf-8?B?cThLSUhIcDRRdnFFVUdCZmY3UDRrcDczWUNWcmxlTWZ4QWxMT3h4aGpkZGNJ?=
 =?utf-8?B?d3pkbkh4RmRrNDAvSDArcXdZRTN4Q1lUNmhXMVBPSkdKZmdvVW13RURnek9u?=
 =?utf-8?B?ZXJTNndhdm0rdDVJdURJcFFVMDdlRDNEc2pkRVlMYTRvazZPcEQ3ZXJJYVBQ?=
 =?utf-8?B?cUtESFcwTk8wSFlwU3oyTUFtQTFXbm9FT1plSU1DUzR2V2x2ODNyVENSU2Uz?=
 =?utf-8?B?YWtQMkRqdzlhVERseWRIRElpeUlERHNTTjdBWmRPbUg3L1VZUzc0NENoRGdD?=
 =?utf-8?B?TDhpQkZiQ1RYSlNZR0Vqc2dmbDc0aW1nSmpYVkYzTUJjK1FRTlNlWWhlajlR?=
 =?utf-8?B?b1g2cU1vUCtTQzJvb3ZlVjZBU3dNVFNTT0FvL3BjWlY4OUVqb0FSd0Zzc0lI?=
 =?utf-8?B?b3Y5cUM4eVpSN3V4UXpUZEcwRkx1R00vVFJQYzJBS3hOVHV3ODRXQlZEWWtV?=
 =?utf-8?B?bUpLeFZ1bkFpbU1TM3lsUWl3bTd2em1QVmNWeWhHRmR4WE5zRk52aVU2OVNE?=
 =?utf-8?B?MHRlSjJSTStEaENvZnJwOGJKOUNZWFF1SUFiMERaNFJwczhRRzNtRW1uUHVk?=
 =?utf-8?B?Z0dNYU03VVZkNXV5S1RPaGVDRnJmY1paR0FPYTl4SXNRQ2hzeDdzSk0zSGc2?=
 =?utf-8?B?OElWMUFYMUdHL2krWUhuYk9ScXhOZ2VkMDdiZVZCS0NBMHBrSzRFR29udW91?=
 =?utf-8?B?OERiYmVZeGppeFprdmxCTG84Q1JRcmMyYkt6YTlxcTV6N2tJU2s2Qjc1Qllt?=
 =?utf-8?B?K0hhVTFyWHpqcVFORzZXcU5nbVBDTmJ5QW9hcCtrNU9HVlQ5dFpyQkc0akc0?=
 =?utf-8?B?c0VYT1pNS1F4Nk4vWmhTb2NpRjNKbWVQdGNQWDhVNnk4U1pDK0R3NUk4V1BY?=
 =?utf-8?B?ZnZhTEs2RmwvcG81OFVzT2Q1dVhjWmFzQk83S3ZRNGRkVThPUDlYREZ1am1y?=
 =?utf-8?B?T2VuWmVkKzN2TjhnTkpSeC9NRGJoZUtaRXZkT2RKK1pnOFJ4SmM1OGpKZy9x?=
 =?utf-8?B?N0ZZMlVPVnJ5bTdyR2Y4bU9teDc5dk9HRkIwbXhYdGNVK1hyTzk4T2hNMWdV?=
 =?utf-8?B?akRUbGhpL3Q0K1VpbGZ4akk2Ti8vUEdnTmlQUU16UDdOTzlqWjJtR2ZWeGtJ?=
 =?utf-8?B?bDhPSHZGRFZML243U1J1eHErQVYrZzdRVkZaS1NIZDFoVTNMVWltWnhPaGgz?=
 =?utf-8?B?RzJQZEg5NjNrZ1lIcGNEQ3RHS0NSZ0NhL3prUEh1a0pkbGJISVZ4Qk5nbmhI?=
 =?utf-8?B?TlY1bW0yQWIyRndZZ1ZZZExjUzJpbGJsQWpIaFVrelcyOUI4ZExoNmtMYXBT?=
 =?utf-8?B?VVhnWDk0ckswTWRmZ3VvaS8vNzdjLytoR0lkeGV0THNUWjZwZXV5TVlMYWJ0?=
 =?utf-8?B?NnJMTUU1ZmZxZ1RxNDBZZmRnSkcwbkZ1YWk0Q2JWUjRjVjZaNDdWZHR5cFRX?=
 =?utf-8?B?Y04xZDdpb0xFU252TlU3VnZYOVZLMjAwbXpiNWdXbkdoR1hRMENWeHZSbTRR?=
 =?utf-8?B?TlJyN0xDWHVMUzFIUEx5Z3JCSWIwM1hxK2czSUtkNE9PbVB6K0dtdGpNUTZm?=
 =?utf-8?Q?DmX4NUIiAGquNX1uOmGK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aba2172-594a-4617-69c8-08dc3f686702
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 12:08:03.1143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6663

On 2024/3/8 19:43, Willem de Bruijn wrote:
> Juntong Deng wrote:
>> Currently getsockopt does not support PACKET_COPY_THRESH,
>> and we are unable to get the value of PACKET_COPY_THRESH
>> socket option through getsockopt.
>>
>> This patch adds getsockopt support for PACKET_COPY_THRESH.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>> ---
>>   net/packet/af_packet.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index 0db31ca4982d..65042edd1a97 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -4090,6 +4090,9 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>>   	case PACKET_VNET_HDR_SZ:
>>   		val = READ_ONCE(po->vnet_hdr_sz);
>>   		break;
>> +	case PACKET_COPY_THRESH:
>> +		val = pkt_sk(sk)->copy_thresh;
>> +		break;
> 
> This is probably a good opportunity to use READ_ONCE/WRITE_ONCE for
> this variable that can be modified and read concurrently.
> 
> Alternatively I can fix up all three locations in a follow-on patch.
> 
> No concerns with adding the getsockopt itself.
> 
>>   	case PACKET_VERSION:
>>   		val = po->tp_version;
>>   		break;
>> -- 
>> 2.39.2
>>
> 
> 

Thanks for reviewing.

So, do I need to send PATCH V2 to add READ_ONCE?

Or do you want you to use a follow-on patch to fix all three locations 
at once?

