Return-Path: <linux-kernel+bounces-134135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D789AE18
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8A61C211FB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF91C0DC3;
	Sun,  7 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HpwPuxLc"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2107.outbound.protection.outlook.com [40.107.13.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908780C;
	Sun,  7 Apr 2024 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712457627; cv=fail; b=XquQ2nh33w3v7pOnSSnyiERccFe3WXZ0fq52zyDkZ+bhBkSOV6zXDXDqCXJlvIGueDFSTcfVA7D3XdFe9xvTwx41oI63rPa/MEPdFcZm8ctUle1uFv9JnM4DDa5oA/vTsyL+K7bGe0xUY/DGZlOSmzcc46Q91COkYDG7Oyn3wXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712457627; c=relaxed/simple;
	bh=2MmauUQI8UJe0pDNjdzkzJ11zOBqXZeDuK3kBUhsElw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bRyyKtXDBoyWgqX5yDtzbBwAp3nIIgM1no6MaTVbGLnc2B2gfSiy6D1seg7XuNvNXmCg3VNGWlhtZ2GBQ15Bw5uAHgIH0u2pcwG2OL3m9NPBWiMLRtB3D79tUB1EH6CXDcDoWOGXyXW9Gde96VCcMhvBE1KUtrSFCUQPX4KGZ6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HpwPuxLc; arc=fail smtp.client-ip=40.107.13.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXbo0pjVEgSGS/HoIf7OzeT7TUaI0X+oQB/2QABQRyobp1eaIgqL4e6i17LKR6JDxM9MvwtO7cLxaJ1sH3JZthu2+xHSbLO84uRRe/mgnAJuZnTkmOCE+yK6lVNLJNVogUytgr9Fy9Fo6s2BA33o2IXZ/DWaGXbL0meC2Edrj7x1GEc+CClqvn8WXocEioB9+1mKfKR/OMQOXrOr9oNp7e0YZrp7WlkDGHXYOvkq1z/8PZvv7XKKIzgggW679wolhAVzKLNpAGIu1p+ukfnd2CjxR7RtAX6oRdrh31CbIr9DKjNLgEnEZnUBo/20AKNVOCJGBY6+fISmnZD8RLg0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUMTTNGHwgtysAUyHMCYfpuXI9BdjDneIKaZ77cQQQg=;
 b=CdwxFHdS638Xhfei90VNlIExFJHbX6BEyu3QkSWrU7PmVrWdpAJmtbOdls8IOC6O48JyPS9GZvpBkzpEFOysOP9xQ5s0BXSPXTy+S69NQNfoBhFwOdpYFNWUhjdgwxEySbVmrTDvog3Z2ljpSRp0HJRFZZdeEOBibrHXdXLlVoWBt+/WO7eKsOypqEOV7aooQgBp482GHclegZVLjjN5cQxAj5H42HJd2WnJ/BdgIrcpC5sW6nWhOscVNjmq6jCfl2MnArliXZHJ6DaFySr2YzhoGqZQlFODixcHB3dsHjV2cNR+GdCjP5K7Zli97CuHt4KxkFUIbTIveb+b5jhaew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUMTTNGHwgtysAUyHMCYfpuXI9BdjDneIKaZ77cQQQg=;
 b=HpwPuxLcDhBeZYIPV7BOuVvc+Qt8lw4mKIPcnWookkCw34vdWZsh5YAIuFcqlp2hMff4en1030vVKvafoFjHlDFMvwrI01uIN2wNGaEVckA/GuCWFctJYGuqDQBUVss0cwe1XHQXEOm9vedecJXfmEydwZF5f5zAl4TkPvlTcFs=
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 by PA4PR04MB7662.eurprd04.prod.outlook.com (2603:10a6:102:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.47; Sun, 7 Apr
 2024 02:40:21 +0000
Received: from PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::da55:641a:a6f2:6e4e]) by PAXPR04MB8254.eurprd04.prod.outlook.com
 ([fe80::da55:641a:a6f2:6e4e%6]) with mapi id 15.20.7409.042; Sun, 7 Apr 2024
 02:40:21 +0000
Message-ID: <e3049f42-400b-4b86-9f9c-c90a89559f78@oss.nxp.com>
Date: Sun, 7 Apr 2024 10:43:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: v4l2-ctrls: Add average qp control
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Ming Qian <ming.qian@nxp.com>,
 mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240329092352.2648837-1-ming.qian@nxp.com>
 <5fc25468198cb3a228b91160dcc490600e1197d4.camel@ndufresne.ca>
Content-Language: en-US
From: ming qian <ming.qian@oss.nxp.com>
In-Reply-To: <5fc25468198cb3a228b91160dcc490600e1197d4.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0159.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::28) To PAXPR04MB8254.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8254:EE_|PA4PR04MB7662:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fM4nS4pbZvhiHZ1CDp019LNNqtiHwe6Bgn2RJm4D5FceJ7rKg4oNRcovG7VZZ0uBZre/x2H7M60uEgf+LECdiglSA7OLmrUF4Rocu5WeKV4eO0YRzcQYcAsPwJZUee1046hMuOUbYcTNQNKtv8vnugHbtLz0AQp5gdbY7ZYTdSLFv7m+3DYHfPBSu2iAvjfrBto5rUwqvPssdBQ1Xz6LhjhUu79k9z9xHzwQmCRUYFontPNHeN/qYAHGOJbui2cMDCatDza/sAg9Bot88eMqF+7znvDvpKi30Ga56kwfpgHlaDSxSKM1EYyEnhS2rtoMmNo0Lx/C4by7W8LllkiucUwoDWjQqU9Xye4Dru9eyAjt00c30vmz4iF9fs9d2Sg+x+HuP7HNmRl6ZfE63l4t0T1xcnCXZQY2c6suTPB9jbrpj21SDnxfqcswAqO3raas/TOkNay+exT1LEbtc7v5c+/T+ATU+8aL8FSJYzREGMNqFIYT9n9KasSMrMapFIUpf9hKWjf6T4yq5affiRquYHpTLV+BxlqVAaLLlR7QfauEwRt3n0KqdSs03Fi1a/9WpC3pomUweRz30UGeNcKiFt7/W/0e7VLAJIjwyd+HcXk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8254.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L05CeWZPQVJYS3A3blJLRk9ZQUVOQnB0NTA4ZGgzTWVPbUp2TFRoZUhnUEFC?=
 =?utf-8?B?TXJueENrdWRCTDBpZTk2K0M3WWd5VjNDaW1PbktlOEM0M255bVI1UTg1OGxl?=
 =?utf-8?B?UVRQVzZvNHFPbER4dXZDY0tiYlNTY1lDUEZCTHhmNFZuelZZZXZTUWJqMDNu?=
 =?utf-8?B?b0VtcmJZbkNpRFY5NjhLMDNFTGFVTWowajlxTFF0dmdvQWVobWYxYU45Y3lj?=
 =?utf-8?B?RHlKdnhOU1U1UVltNWhTRDhxZHJrZ3Y1a3JLd0lLR3JreHRoQUVFV2RhbDFy?=
 =?utf-8?B?bi9UeXI0Q2xQd2NTc3FQdGt0dHZLZTgvak81d3d0NmZicllNS3BNRWRYOE5W?=
 =?utf-8?B?NWx5ZSt6SkpZSk1GUExraVNkN0syWTl3Sll4R0labndBRUd4d2NzUW91YURt?=
 =?utf-8?B?Z08zbWZsOW1tdFRiV0JqbE9kZm5tWHZJNDRpNnRsWFBvcURNUWo4YmxLRXRp?=
 =?utf-8?B?Z3c4NGtJMmlMUXZtZUZLK0NQeEhOTGhhODVLdTV0ZU53cjRKKzVMV2k2U2hi?=
 =?utf-8?B?R0Y2Vm5hVmVjdElpYytNNGtmRHNra21vK1E4MGgxVDBFK1dZVlV3aWFXa2Zx?=
 =?utf-8?B?b2tMQW5DbDFGYzRjKzRXRCtZaXJmVzhXL2hSbDhSbkdYZFRDaDZjN2t5R2Q0?=
 =?utf-8?B?ekpJT2ZxK0ZXWEVxUmFWdWtpMXFlY3RtVUJJK0c2RHVaU0I4OFNoY1I0eUht?=
 =?utf-8?B?aXg3aDd2dkxZYWR3VTNsaHFBcmZqM0RqV3ZocGRHSVUwQkVSazJwbS8yQzV2?=
 =?utf-8?B?OFpDZDh2NFhwT2s4TCtPcnZrSlVQdzh0aGlsYWU1ZUp1NW5hekN4QmJVcitu?=
 =?utf-8?B?K3AveXVjTTd0NzlWRnBvdzNJQTNrU2xUSXd3RHFLM0R1Z1pMSDZ3cExvVTJ4?=
 =?utf-8?B?K21sOXViY2NHc25jSHEzQk0wVkRvdEhndyswTGtkT3FEODAySUZaRm5tcXdJ?=
 =?utf-8?B?bCt0c1hFQWdkRnkyOVpGM2RBQmFEUjF3Kzd3cFU5bXNWS1VFT0J1cFBoSXRI?=
 =?utf-8?B?dmIwaWhxRXZ0Z0lhUUFhYWN0aWlKMUF6RmhrSCtVQ0piWFoySG90aXBwQXJS?=
 =?utf-8?B?UFJjQVE4RGhrYk9MNVpmMDF2cmVsM2tOQXRCRW1CVDFvZjkzNUE1OTVaVmth?=
 =?utf-8?B?V1k5YzZRLzNBbUY2a0QrOGdtcGdBeVFOMG51T3YzMlRYRnNlcFE1OXNVRnBH?=
 =?utf-8?B?YUZFaXRIME5EWUNUaUUwbmFrd2UzTjd4NFl5aWpFWEtMU1ptYVFUS2xweW9x?=
 =?utf-8?B?NVg2WUw3dnlZNDJTamQraG9zZ2RaV2FTV0F0NFBaSUh5djZTeHZXN0xtdUVL?=
 =?utf-8?B?WkVoVHh5b1l2cG50VThBdDRkemUwZzU2L1FRVysxazQzRWhGeEFmc01nTkpZ?=
 =?utf-8?B?Ym8vVCtUZzdlRXE1a1B6YzMrNS90OWxsWGNwSVlFUTRhOEZGTzl3OERFS0k4?=
 =?utf-8?B?d2ZVbUM0RmJZRHg3aDlPVVdZQmgzOUdJUTBpYUI5ekNKV3VJUm0zazJlOXA0?=
 =?utf-8?B?cEYrQ1lrTFpIWm14b3ZCYkwxQVZ2aTZ5anduNng1SGx5V254L2JwcFpGUXd1?=
 =?utf-8?B?ZWZJMlNZNEI1cXlQYk50Vk54bi9Vc0lVakFoMlAxTitZRm91eDlVdVFxbEJU?=
 =?utf-8?B?Z2lmMkdnOXBIQ1AyNVNxUDJzOTNmeWlGK1A0VEkra2VpSHlBUmw1UUpLa0Y1?=
 =?utf-8?B?M0l0SmQ4bU1ISkw1dERNRy9QREJ0L3N2MkpOV3NyQmNpMnNZdVJLY2pxaFNE?=
 =?utf-8?B?Uy85L3pFN2pRbzQ3MHdoeURINkprR2lSR0lhcFhMeU9UVEZvYjd2UU1Ebjhz?=
 =?utf-8?B?TURQTENMZGpvT0dVL2V6bTlWRytQM2VvRjVDUkhid2NVcWN4Vmdtd2ZPQzVl?=
 =?utf-8?B?RjlZdW1tOHp3SEdXdU1FRjBTTmVCS0VKd3gzTGlFTkVVRnlMbXRoWkViSjN2?=
 =?utf-8?B?NzROK3hlb1Q4QzRHZFlsQ1lCaEoySU41bGx4STB5U1JzVSttMEpFUVBQWWZ3?=
 =?utf-8?B?WHZqTTVCRFMyWnRySnRodmZoREhmb0hxNjBJeUZuRlg3M2plZ1NDTjREcXRV?=
 =?utf-8?B?VzkvSDFuZytoajg5TzR1UmI3dldwZ2xqem1NWVpHMjVZQTBrKzN2dXdxRE5n?=
 =?utf-8?Q?2gj0oab0j3NxKFSGvvux9V4Fn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65489b8c-365c-4084-1607-08dc56ac11df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8254.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 02:40:21.6620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aU1WXAdOS4iimoMZB8lumhgq3uH/ccKuQFFQTCcJpQyMZGCVG/oeElf43LpjkUb5lZ0XF1QQtg+ErkpzvEmCuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7662

Hi Nicolas,

On 4/5/24 02:14, Nicolas Dufresne wrote:
> Hi,
> 
> Le vendredi 29 mars 2024 à 18:23 +0900, Ming Qian a écrit :
>> Add a control V4L2_CID_MPEG_VIDEO_AVERAGE_QP to report the average qp
>> value of current encoded frame.
>>
>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>> ---
>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++++
>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 5 +++++
>>   include/uapi/linux/v4l2-controls.h                        | 2 ++
>>   3 files changed, 11 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index 2a165ae063fb..cef20b3f54ca 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -1653,6 +1653,10 @@ enum v4l2_mpeg_video_h264_hierarchical_coding_type -
>>       Quantization parameter for a P frame for FWHT. Valid range: from 1
>>       to 31.
>>   
>> +``V4L2_CID_MPEG_VIDEO_AVERAGE_QP (integer)``
>> +    This read-only control returns the average qp value of the currently
>> +    encoded frame. Applicable to the H264 and HEVC encoders.
> 
> That seems ambiguous at best. What does it mean the "currently encoded frame" ?
> The OUTPUT and CAPTURE queue can be holding multiple frames. For "per frame"
> accurate reporting, I feel like we'd need something like Hans' read-only
> requests proposal [0]. Its basically a mechanism that let you attach request FD
> to capture buffer, so that supported controls can be saved per v4l2-buffer and
> read later on.
> 
> https://patches.linaro.org/project/linux-media/patch/20210610113615.785359-12-hverkuil-cisco@xs4all.nl/
> 
> If this isn't what you wanted, we'll need a better definition. It might be
> helpful to explain what this is used for.
> 
> Nicolas
> 

Yes, I want to report the qp value for every frame.
I thought the request FD is only used for stateless decoder, but I want
to add a read-only ctrl for the stateful encoder. So I checked the
defined read-only ctrls, I think it's similar with
V4L2_CID_MPEG_VIDEO_DEC_PTS.
(https://linuxtv.org/downloads/v4l-dvb-apis/userspace-api/v4l/ext-ctrls-codec.html?highlight=v4l2_cid_mpeg_video_dec_pts)

then back to your question about the "currently encoded frame", it's the
last dequeued capture buffer of the encoder, the capture queue can hold
multiple frames, each frame will have a qp value in this case, and this
ctrl only report the qp value of the last dequeued frame, when user has
dequeued an encoded frame from the capture queue, he can get the ctrl
value of V4L2_CID_MPEG_VIDEO_AVERAGE_QP immediately to get the qp value
of the currently dequeued frame. If user doesn't care about this
parameter, he doesn't need to do anything, it's just the same as before.
so I think this ctrl is backward compatible.

Maybe the request FD is a better and more intuitive way to suggest a
one-to-one correspondence between ctrl and frame. I'm just not sure if
it just applies to the stateless decoder. I did find any stateful
decoder or encoder to use them.
If we use the request FD for this stateful encoder, I'm not sure if it
will break the original flow.

best regards,
Ming

>> +
>>   .. raw:: latex
>>   
>>       \normalsize
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> index 8696eb1cdd61..88e86e4e539d 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -972,6 +972,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>   	case V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES:		return "Use LTR Frames";
>>   	case V4L2_CID_FWHT_I_FRAME_QP:				return "FWHT I-Frame QP Value";
>>   	case V4L2_CID_FWHT_P_FRAME_QP:				return "FWHT P-Frame QP Value";
>> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:			return "Average QP value";
>>   
>>   	/* VPX controls */
>>   	case V4L2_CID_MPEG_VIDEO_VPX_NUM_PARTITIONS:		return "VPX Number of Partitions";
>> @@ -1507,6 +1508,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>   		*max = 0xffffffffffffLL;
>>   		*step = 1;
>>   		break;
>> +	case V4L2_CID_MPEG_VIDEO_AVERAGE_QP:
>> +		*type = V4L2_CTRL_TYPE_INTEGER;
>> +		*flags |= V4L2_CTRL_FLAG_VOLATILE | V4L2_CTRL_FLAG_READ_ONLY;
>> +		break;
>>   	case V4L2_CID_PIXEL_RATE:
>>   		*type = V4L2_CTRL_TYPE_INTEGER64;
>>   		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>> index 99c3f5e99da7..974fd254e573 100644
>> --- a/include/uapi/linux/v4l2-controls.h
>> +++ b/include/uapi/linux/v4l2-controls.h
>> @@ -898,6 +898,8 @@ enum v4l2_mpeg_video_av1_level {
>>   	V4L2_MPEG_VIDEO_AV1_LEVEL_7_3 = 23
>>   };
>>   
>> +#define V4L2_CID_MPEG_VIDEO_AVERAGE_QP  (V4L2_CID_CODEC_BASE + 657)
>> +
>>   /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
>>   #define V4L2_CID_CODEC_CX2341X_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1000)
>>   #define V4L2_CID_MPEG_CX2341X_VIDEO_SPATIAL_FILTER_MODE		(V4L2_CID_CODEC_CX2341X_BASE+0)
> 

