Return-Path: <linux-kernel+bounces-107446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76187FCA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FE628241E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8157E76A;
	Tue, 19 Mar 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="H2MPDxbG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943207D098;
	Tue, 19 Mar 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846795; cv=fail; b=sVubUxSXa4Q72mxKymkVhJby4mmu7Z8Bo94N+QN76XalGtY1Uqgz/S2XqWBeCTCyZIfzdvPXxPtMtlySz07bOntvUunlcnVQErgyefpiZBim8sm6SU5+gp/ROEYcwYwD4DHaQJV4MmSuAfYlFq17SyWIRWwxbjzK9HjDwnd17qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846795; c=relaxed/simple;
	bh=Ma+coSQPGDBaEnA6FfBWr47SOG+nduJnKC67O9M0ycY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W82DvIKPJAKJJCKZUSfdJ5jlzguaVrWZPRLbXeGXghWJI/7bmIEHVQhcXg64npBRL58+XfaqApk8mvcm8F1DImO7BmbHGamf5c4O4fKTBcFlVV2m6VKVyAmClKgGnLUDMArlxio3+qoPRjQ7bQ/FMJbZMefO/2HniBB50HOjEfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=H2MPDxbG; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=flc51mVtcZsaOmKcrwzM4tV89Gki+PjJnfHFXWo9JfD2Q7puTepOOY/d3dAhAW4grK0mR98LBYrjeEeb5z4SSSDePEwV314+EgHj9dDjwsXo2GNMC/4yc9NdNde8eMvsTPNHedHwp6+1H0HRcWAoCA+gOp5F0aPjppmGgPzYa1nZmSOm6aNCAyoftfN+zLZaFJa99Lywl7qzp8LqwDi0pQhEVgnv4pee/ukK0yR5FcKvqS+A3YvYUfMQEHGxNqRGHi1soSN1rEuKCZbQRoKTyS+9eCp3zowCLvf/HBgo1IJb/HVLjmAjExQwgjp/11IXvBNBGJ0rb4kB8ua6zMlINA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpN+TlLXPinlcb1KCJZ+adYoFzP1o8Nt9MIspzNm1DI=;
 b=YBNEpnuetG6rRCQi/mYe1C3V58HRFoe8UEHWXzufTtLlLUi6XRzCk4QqOjoGHuZLm1KElaDvrtgw1d/RKKVjZsCMIic/S0hDW1k86cx6gbvAR+w1gYXugfvGJXVDVY2O9sCadR2ebfs5UBFjJC8AtoL/0sE2v9xyRQBxI4RYI0TZrcOHKFlfP/rs5D1MP+AEiQTMvdqDZG4F5UYJQ/iyZGNL1bLPA7d566ypT/SDY3FMIc3f0AWgy8I8jnqQP+uTogHXLvE94R70vqL41nP1GjrF7TijuyDkIuIcp1MTu7M7yWzO9fXQAf5bjcA0NvgsfYXw8Xyh+k/7Hiow3nCA3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpN+TlLXPinlcb1KCJZ+adYoFzP1o8Nt9MIspzNm1DI=;
 b=H2MPDxbGI+0ucbj8ZphSFO1yydtfGfr1x7Tutc/xcjRND40X7/UuImYXhK34YDDtd/ARQR5uwAJP1ElAB66ApVnp9xccPea63yPX/mScT7Q/5BbLpVXPsxOp6F36wsCgIxOLEPJJ7CoBZ5zXGXD3AwKbxJ/wcunJINhzh1YDACY=
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB9765.eurprd08.prod.outlook.com (2603:10a6:20b:616::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 11:13:10 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 11:13:10 +0000
Message-ID: <e373c2c7-0cd9-40d6-a19b-3b9a1a81feb2@wolfvision.net>
Date: Tue, 19 Mar 2024 12:13:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: touchscreen: add touch-overlay
 property
Content-Language: en-US, de-AT
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bastian Hecht <hechtb@gmail.com>,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Jeff LaBundy <jeff@labundy.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20240119-feature-ts_virtobj_patch-v7-0-eda70985808f@wolfvision.net>
 <20240119-feature-ts_virtobj_patch-v7-1-eda70985808f@wolfvision.net>
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <20240119-feature-ts_virtobj_patch-v7-1-eda70985808f@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0100.eurprd04.prod.outlook.com
 (2603:10a6:803:64::35) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB9765:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0OkV7WpT2d6JVFimOILczuWtqqdu3RzWztWxrgrPwJXu6czx7It6Dl+A1vDXbkDTsPhZofoqqCZwEoFayAqPKb8poBpCSCmkVSGf7MRL03G7fEPcXpNgW7Ht4JIMizZKqLiRz/1Fs3t+wZuNYUCXuHAenj+dt0ml9zEG9GKoWlIXzFnJw5GOi9HUWziiCYs4C7LqAXm9UPd3fVvI+CnqW4ETbJaX/L70bQEikC2pD2RrB0H/OGE7N0aSID9IktIOH4jifgYjF88FUtHbDszIXb+eMER3zf/3cc8BtzsIfgnwJj6QUSMMG7kYF0rjp1ykKhdSNKuJRQbj8n8s1LIVVQl5S52yx0nDcQktwzp7aWj+agx9lQ5qFQrnPmpRoBgVD7kco7pVRQ9eB/lF/NBOdp2s2FnOgh3Jq4VVX/a41k4SbIK5SFGMPSb5VxzaKVH9ah19mcjO9rUnuUEp+8Tb1YHCq9WXnRRnmUdPqOMpNhADuX3b/PwxHQZWli7jg998OmHfILz32fkZ6o4GQths+p1Kxj461ULMEqkYKZjVltqOpwWmYCrgVPLiDxThxNwK44jtChCkzTQuA0zNdVI0WW/zr9pAv4evD7nabIw543xAKD66CKd6iM8kmoSEEryJ2VHK1s63BAuvrGU9KijbyuYrQbGQB7fS9BjHx2KVhZM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MERoalc4ZWFLVXV1VmZLbnl4UjBuQzBGSXRWOGNYbEdycVhWTkp1TnkvMmln?=
 =?utf-8?B?S09hdXNqcEZ5NURkVHpIT3ZwUzkrOVRiVUE2UEVOWGZGTFJiVndKT0FrdXRp?=
 =?utf-8?B?WWhBUmxGc0x6QVQ5M3lwZERETFB4RktxTTQzdkxzOTN0aEJhSEJadmVVRVUw?=
 =?utf-8?B?QWUrQXZ3elA5b05XdUFSc3hyQ1FPU0dNdlVxb05qclpHN1F3SzMreFpqVGI0?=
 =?utf-8?B?TFJuVWpOeldudzVaQUI5M29kV3dia1QzVEF2OFlsNjVmTmhYUHg2N0hzRVVj?=
 =?utf-8?B?NlZuSVNucFJrWWpEbDV4ZUxzdDE2Y09tdU5RV0toeVgxR1Mza0F3SVFMeUJv?=
 =?utf-8?B?Z2xFUWpsSU41TE92R2JTK2lFRlBmK2s0UmZRbEVVaEJNNjhOanhUSU5aWURP?=
 =?utf-8?B?NmZ3UWJnRGRyU3JKTy8wQllYR2F3QTlBRlR5WUxEWnZwcFloUThGckE0R0Fq?=
 =?utf-8?B?SnZucnNTVlQrYkVBaWE2V0xueTQ3K0NXeVpVNlBzeU51R1l5bVFXY2ZNQTJG?=
 =?utf-8?B?aXNpWU5IU29PWFgvZ01vMVpCRzRJeTFKYkRjT2tOUVpPSGdrdFBESVA5MEY2?=
 =?utf-8?B?aDZHaVFmVVNCYzFQWHN0Z0F4MmpWakNtODRhUnZGZXhvZE9VYWNnVDZZdHFr?=
 =?utf-8?B?RXl1NFM0K2hnaTNXSmQ2bUhpczJiOUdRc0Y3UWhnVWhiNG9OYVFZQVNSWjRv?=
 =?utf-8?B?VTJNS1Q3amZuUExUeVpybG1UV3dNWSttZGVQR0hsUzF2YTdMR05hRm5ITTU3?=
 =?utf-8?B?NVI2NXU1Q3RVT1N0cmVJZUFObm1RQUJMMU80TzIxeUlkOTlFaXYrTUJwTkJN?=
 =?utf-8?B?QzlRd3FNNmE4OEtoS0NZN3JDZ24wWlBEZk5GZXc2c3IyOUF0clFHdWhYYTVZ?=
 =?utf-8?B?dWFTQ09yd3FTbUtnU2dLZmw3TDRWOG9NUnhwQndDOHdHNmd4dklpdDRMUTdi?=
 =?utf-8?B?OEVHczVKbWdjeUFQV3k0aVNMVnVDTjQ2ZUVPMFozOWZodThaMjNselRRb2xu?=
 =?utf-8?B?dyt0b0JnUU9WYk1pSGR5RExZb1o4Z2ZGNEJIdEZvUkdLSmVSZEE5QklCYzJy?=
 =?utf-8?B?V3psTS9nZk1JOHQ2Y2dKaTIyZ3ZkNHhsbXJzQW53a1lTK0RrVndMeW5OSFZS?=
 =?utf-8?B?ejlQdTZIc00zNU1ITFlzRStUMGYyTzFzZWVQTFc3VkJTOWNRWHdDbnowS2hH?=
 =?utf-8?B?d3g3QTdoRlhIYy9oUW9ETitwNW54VnFNY2VHdVl3azNxcStnbHFkbUhNd0Ew?=
 =?utf-8?B?LzdSMWh3SmdWZ2pRTDFsRDlvbnlWS2VNQkd1UlBIRU1mZEYzcUpoaDJqaEVO?=
 =?utf-8?B?R3pxLzVPQVk1c1c0S1Y5UStKSVNKcWw2SEtMTGxmaTZjamNIY01LdlV0QVI4?=
 =?utf-8?B?VTZTSTJORld2ZzB1UjN1TkhRZTNwaU9HYU9qQkRtMnl0MEVIWS84ZHBTbVho?=
 =?utf-8?B?c1A5N0xqWm44d0JQd1RnZDhrQ0hET3NQT1E5U2hQcHJISVdhUUZmblZSZkh4?=
 =?utf-8?B?UTNqMkpxSzFBbWI2QnFsM0VrbjRLRHU5d3pjU2F3WUNVNVpJWkNYbC9YUVJ1?=
 =?utf-8?B?YXR1T2ZVQVBPSFI0c2czVnNkamVEYlBrajJINFBwSVZXVmZWSGVBSG5nakRv?=
 =?utf-8?B?S0xGSmc3eDhoNTlqK240T1NCZjB1dWZ0Ri9yd2NKMzRieW8rU0U3V29SbDFJ?=
 =?utf-8?B?dkZxcTVjd2FUOHNCYzBHZ3dya0xLemV2SmZJQXBOOERHcUVqQnhBSGxMZmMr?=
 =?utf-8?B?ZzFMN0RyOTk0YzdBeWJhaXFNOUoyUVZSYWlpdjhaTjdETGJZNVlucnJmbTRi?=
 =?utf-8?B?S1JuWnpIbW4wek00ZXYxcjBGV1hka3Z1K1dzdUoveU9VQnRsV3JZR2N3cjBN?=
 =?utf-8?B?OFJUZDZ1ZnhaTGk5N0VGVE9HaGx0SFkwMDVOZ1IvaXU0WitkeVZSSUM2S0Iw?=
 =?utf-8?B?ZG1Vd3BiQWFQaHBwU2Vhc1luaTdheFllVkZsVXpEOVNnU1Z5UlRIbGFVY2sz?=
 =?utf-8?B?STVrbTRSbmNNVzl1bFplN08xemttcno1Yi9mN3JhWnI2T0dTL1Q2RHFJdHA5?=
 =?utf-8?B?ZUV6b2diL2RNYkZmZTUzcEt1c1QzR2EvTEFKc25pbSsxbTFZSGE4NDF1Rkpu?=
 =?utf-8?B?ZUN5THUvZ01hZWtzWWFSM09UMTdNb1hYQk9IZnh3b3VqUmlMMUVHMkR4U2pS?=
 =?utf-8?B?QlpUM3I2dWYyMXAzc1BlVUNQQ2tlU0prUVNnTmFCNjNyenJwOWdIVXJNQ1hv?=
 =?utf-8?Q?cM6nmQf46230smS3n/n52JzvvfzPpxpUGb5kQpAFuo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 159179ce-fb7e-43d2-587c-08dc48058f85
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:13:10.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRhofwO6+gT12wC2LMpX4SynWOuU5c4SbUNe7103EZZBhNaPnUvqtVA1hbK5Lqtpjla+dnVIj/Qb/7dcfqKSeqO6BrZKjyUlv7KK8q89XcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9765

On 1/19/24 08:43, Javier Carrasco wrote:
> The touch-overlay encompasses a number of touch areas that define a
> clipped touchscreen area and/or buttons with a specific functionality.
> 
> A clipped touchscreen area avoids getting events from regions that are
> physically hidden by overlay frames.
> 
> For touchscreens with printed overlay buttons, sub-nodes with a suitable
> key code can be defined to report key events instead of the original
> touch events.
> 
> Reviewed-by: Jeff LaBundy <jeff@labundy.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---
>  .../bindings/input/touchscreen/touchscreen.yaml    | 119 +++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> index 431c13335c40..eb1e86fa86c6 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.yaml
> @@ -87,6 +87,125 @@ properties:
>    touchscreen-y-plate-ohms:
>      description: Resistance of the Y-plate in Ohms
>  
> +  touch-overlay:

Even though it has already been reviewed, just in case before it gets
applied. Should it not be:

	description: |
	  List of nodes...

instead, to keep formatting?

> +    description: list of nodes defining segments (touch areas) on the
> +      touchscreen.
> +
> +      This object can be used to describe a series of segments to
> +      restrict the region within touch events are reported or buttons
> +      with a specific functionality.
> +
> +      This is of special interest if the touchscreen is shipped with a physical
> +      overlay on top of it with a frame that hides some part of the original
> +      touchscreen area. Printed buttons on that overlay are also a typical
> +      use case.
> +
> +      A new touchscreen area is defined as a sub-node without a key code. If a
> +      key code is defined in the sub-node, it will be interpreted as a button.
> +
> +      The x-origin and y-origin properties of a touchscreen area define the
> +      offset of a new origin from where the touchscreen events are referenced.
> +      This offset is applied to the events accordingly. The x-size and y-size
> +      properties define the size of the touchscreen effective area.
> +
> +      The following example shows a new touchscreen area with the new origin
> +      (0',0') for the touch events generated by the device.
> +
> +                   Touchscreen (full area)
> +         ┌────────────────────────────────────────┐
> +         │    ┌───────────────────────────────┐   │
> +         │    │                               │   │
> +         │    ├ y-size                        │   │
> +         │    │                               │   │
> +         │    │       touchscreen area        │   │
> +         │    │         (no key code)         │   │
> +         │    │                               │   │
> +         │    │            x-size             │   │
> +         │   ┌└──────────────┴────────────────┘   │
> +         │(0',0')                                 │
> +        ┌└────────────────────────────────────────┘
> +      (0,0)
> +

When at it, the following line could be aligned to match the rest of the
description.

> +     where (0',0') = (0+x-origin,0+y-origin)
> +
> +      Sub-nodes with key codes report the touch events on their surface as key
> +      events instead.
> +
> +      The following example shows a touchscreen with a single button on it.
> +
> +              Touchscreen (full area)
> +        ┌───────────────────────────────────┐
> +        │                                   │
> +        │                                   │
> +        │   ┌─────────┐                     │
> +        │   │button 0 │                     │
> +        │   │KEY_POWER│                     │
> +        │   └─────────┘                     │
> +        │                                   │
> +        │                                   │
> +       ┌└───────────────────────────────────┘
> +     (0,0)
> +

And the origin above too.

> +      Segments defining buttons and clipped toushcreen areas can be combined
> +      as shown in the following example.
> +      In that case only the events within the touchscreen area are reported
> +      as touch events. Events within the button areas report their associated
> +      key code. Any events outside the defined areas are ignored.
> +
> +                  Touchscreen (full area)
> +        ┌─────────┬──────────────────────────────┐
> +        │         │                              │
> +        │         │    ┌───────────────────────┐ │
> +        │ button 0│    │                       │ │
> +        │KEY_POWER│    │                       │ │
> +        │         │    │                       │ │
> +        ├─────────┤    │   touchscreen area    │ │
> +        │         │    │     (no key code)     │ │
> +        │         │    │                       │ │
> +        │ button 1│    │                       │ │
> +        │ KEY_INFO│   ┌└───────────────────────┘ │
> +        │         │(0',0')                       │
> +       ┌└─────────┴──────────────────────────────┘
> +     (0,0)
> +

Same with this one.

> +    type: object
> +

Best regards,
Javier Carrasco


