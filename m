Return-Path: <linux-kernel+bounces-165322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3548B8B46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7A41C2131C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE3212EBCE;
	Wed,  1 May 2024 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qsua7jz3"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04olkn2090.outbound.protection.outlook.com [40.92.73.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9699112E1D9;
	Wed,  1 May 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.73.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714570574; cv=fail; b=ptSYK8xn/7HvHxKk2+9IMHr0P3HFUtZCcylthUpHIKTXadVl+BGPS5v5geaRfsf/8cU/WK4AJLI/0zIo5OGajLtWLH94dW1Lka4IBrsq/1nUCPthZb9rEwtCk26blZvjfXwTvkESUWaqIBlkSCRCJURPIhq6r7LKwuiM1n+eyTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714570574; c=relaxed/simple;
	bh=0krC9nqe9tAz2Y5uucLSW/tbrHWym+bbvQBdc2Ob5OI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RYgeQdUl1NBYJe/GDkVxUQ8nLFehCiHTE3I1E127p37K6yP/wvTadYc1JTg4/4hkw/b3N/Me5G1BypVtZ56NkNI1vw7oRMI+hJ7fuAJNKPNFArq4eg7QN8+oPwckKLqgEFaivZJ4sbvfJMGNb3j+AcXRnEZ8Bn/GkmtB9pTNIuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qsua7jz3; arc=fail smtp.client-ip=40.92.73.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkJ4pu3/TJ25cCjKFwS8sP+2VtGT0dlY2NtO4i6PYZwmIYs/aQ+bisdjvGgRfiQuw2JJDByTSyEg1TpvZSXZ4UgObPRUKKuizMxlw7mAre5+ampyoiJPqJhJpv/U2IWDFdNvzavFtoMf0kFBAOA8OBmuZK0c1CIaHtFs0s7GiQKJDhToWzqXjAeClUIDqdumHVL8nrGtNYW/zCZJARKVyS8moD/OwWHwqyG1IZod6wO5Rk88jDJCU5M4TkNzr3AO9zvDcd8M1RriA9laNO3m1sDmF51WXmAKqki3oeTmn+BNfsfCCdbghjIA4Qa68y1KJdxeQMvegg0OTWxA1rQZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwUI7W7B84/5t41V9y0WKWfNuClSohuetF3peNRBj5U=;
 b=XRrNW+2lPlXas11h6S56FaUzblqkpExpWysa7D7ppBn05bC/UEIg3f/NdZPhIL3czCNF2QgudMCM8DWm+jBwBPsHuVq+fHxxCMJLY8a3rZYK30QlG4qmtdqPpDEmMRFlj7lZG19qk0N7EUmuQcnJvI6/s3CN74Y+PHhzGfXLZOPagB+tbMb9EQ6oLzBOsSt3s7npgnmfzupjQnyV7pcaA2Kn//gx8Y6T/mS5vMFII3+C9xDK3WxH6RgIeiCIX0FHe+q8hBKNYJ9c85wJlOu//IN9qETaM5Y3SpiEDANI/jx3yexaxSE9NmfyJu/7rXjeV2AUrWRYyLGtpAS9PloRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwUI7W7B84/5t41V9y0WKWfNuClSohuetF3peNRBj5U=;
 b=qsua7jz3sy89jGaTMktjGRt+AU4ltkgZkhPTI6Yz1Xr9tndVo+eW/+DiW2VRG8VE/Rf/ShlkAFTRFVk+vimZXOr3JPZlnXe96rQcFqdIL2VS5u+qHTQuz17uYK+K5DmYfIDHBQsk2/GyWPkdHa91tOL+vvVIa1SRnOqLA7nIQ39qiL+oZ1bdTRpLxvHxV6+MediuZWEobmOpqkx+w6j/VozuKWTzh/zJP6hncJLsWixy9JEQeqtJ1lX2TqKErTWxwkNtyiVb/cXpgZrju2G1slvkaS8M1F6pITGX82BzozJGCm/CpSWH+aHIz1Oau7E3kqus0FPSdgjy/QXczi93uA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB9910.eurprd02.prod.outlook.com (2603:10a6:20b:619::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 13:36:09 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 13:36:09 +0000
Date: Wed, 1 May 2024 15:35:57 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	Sven Eckelmann <sven@narfation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID:
 <AS8PR02MB7237099D421106BC1EF10BDB8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB723756E3D1366C4E8FCD14BF8B162@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202404291030.F760C26@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404291030.F760C26@keescook>
X-TMN: [aED3kosncXmW/cjt8Yutl1pxaKLbKyeN]
X-ClientProxiedBy: MA4P292CA0005.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::18) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240501133557.GA2861@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: e15d07d5-bc9f-490a-9573-08dc69e3a8c7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	PhU/VvkXDVhJbTyK6Hf88iSS5N4f6+AM4DlrMNVg/3NiwCF/5dSeuXk8xUzqQZd94PHsiMwn9IBGSqpGNz4qGhxteW0NADy/jH72LTaVaLXlEPZHrCWtpFHuewLGpCmrec0R2xFZr43cizvd/BCcBfkMmATqWzfofhz8uKkGl1B5zTlqOmmqP9Vs2iUOsFQIjCS5PataqEY8qMWgnasYivxp3z2bQNmdQ5tjELeOZBeZ7xYwtmbWl5utDhVTj/qdd0JYjbhmxdO9yWYlIjsjJ2GPomDIK9/qslURQcj9a3pXJJSlLScFexiWcGod16LoCVw+b3V6ZfKzyYyYKY2oiqR9Pe9SADIJaDSln4SO00QRsPL9X4hXx86EXqy2PAMZInP+cgJpqSEygj9BePt7+Ya/KI9U3oRnJbGq7yFkz4uti18Y7dDR4qlcW6U+yXhJr3CU7TRbL6hz5DxIvGB8Qx48wohfhHHnfaLK60CycWI/watLxFc2odz3khMLP7N7hUhw8iSvd39LDPLEx6g+NqAn9/RBBwuQMNF6bMj616dQMQ4/+tBlxP9E6/NJ96w58x5NwE0Ka6SRbYNFN+fe66bvRTNqRRkolkahN6InjHhwCb2zXYi3KZK0PdxQW0Ql
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pAvegvZ/7pFCq0DVaCMpi79yK13krMJKxl8RlXEAH+Pr0KlukygmlgNVtwH6?=
 =?us-ascii?Q?VkolgkTxF/T/hXpxq1ilXBFVNQHPyMkm7q9gd4RS7B26cTovj6ifj7Do6JQ3?=
 =?us-ascii?Q?mhm0mZ6BHk+Fq1J4hyPr/aWbasmlX4Rjlkq1SZYAetXmM0CYclIib51BmLhi?=
 =?us-ascii?Q?OBlDxzcb/6GlVnFkuDmfJFvh3c4tlMG3NhErADQRWWXmCORGokpeWlpn3uiv?=
 =?us-ascii?Q?VQNvuyOXic05rxO/4jp3U5wHD/Edu8eLtX/lgDYd93CHsoB7rz1yUKSROoVr?=
 =?us-ascii?Q?8vZ9DxtVEszK/dXViqvxRDa3V1h/URmTnlRYpZJyI7jxmk8Unskzj7ccqGAg?=
 =?us-ascii?Q?nqSofZCe1XiSnCkvaACjIaxQFJjJAeEl8x86n3VnOUBcJVkKnl/NPq1MzXNi?=
 =?us-ascii?Q?aLVEIbqu1qlWGZsfxdDaCS2SRHyvIrK+me7X3vLYeoix52W30X1xMRk861Cy?=
 =?us-ascii?Q?+JWMd/bemrHY/hMlN9f7raeTqcCvZZzK0HS7Ydqye2NF2VEihDXlWflVEfqy?=
 =?us-ascii?Q?AzvPPH6gvJ6oQ7/i0NxS1YhQfmx7BRtZaIsTmcuExRpr+CMM8wIjQ/iG7ea3?=
 =?us-ascii?Q?58IT14nlFo5SIK+oE9RSk7BlMYj2tPXmp521TZGWxVHfvm7wcQ0Xjn7q+lTu?=
 =?us-ascii?Q?di1aN2PKdYauLOX9mVTtyKuFK02SIw6dd9fpVx4DJIxCt3sltjNKSsukeO7l?=
 =?us-ascii?Q?Qi760uqMNmtYMxL9Am+zuYT7FOcbW5kA1e6QTHc5hRP1nf8R8FMJsatu1zdG?=
 =?us-ascii?Q?YOqMyUUXo6HQLz87HnoBgItm7+8Ahx9c0d1bPPD7dJkVOMyWhl0B/gRJw9k7?=
 =?us-ascii?Q?u1Be6pBbB0H0le0Yija3IWvpVFlH071Ph9isg+VwmBPN3QKdJby0Exnyfsbq?=
 =?us-ascii?Q?6/WZe6H4drBzoCS/MkGxNRTFMcmBHaATylTRbUifCFRQXwI/U/qKedAqhCgO?=
 =?us-ascii?Q?NLeFaIEcRgwJsLRqyBMgtA/sOIgW2usjTYwz1uqN7uTQ27a/OX+1CHGVDQ1n?=
 =?us-ascii?Q?rLyQ36j6o5U6ta4eZ9Ae7qVG27gw05OG7xe7d86oH9D01fzD3S9kCzDWe9Ev?=
 =?us-ascii?Q?wMlgdi0X9KaqW0URKBIzGNeXhNAdSIthur23/P15s5CQPMLeBHjxprzfY56r?=
 =?us-ascii?Q?gnbAxDp2XWJw4hsbdx3ey+KuVRm9N8VFAPw/jjTL2nLWTwVz+JLdVlYpIaGh?=
 =?us-ascii?Q?1Be5OhvBpaX3mck4oofQxCFGHC+V9Ll94H81bXq6hj/H7ptIxQDzixOwHhQ3?=
 =?us-ascii?Q?LhfeyHrrM4mK55B8MIJP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e15d07d5-bc9f-490a-9573-08dc69e3a8c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:36:09.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9910

Hi Kees,

On Mon, Apr 29, 2024 at 10:36:23AM -0700, Kees Cook wrote:
> On Fri, Apr 26, 2024 at 07:22:47PM +0200, Erick Archer wrote:
> >  
> > @@ -3957,17 +3947,18 @@ static void batadv_tt_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
> >  
> >  	num_vlan = ntohs(tt_data->num_vlan);
> >  
> > -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> > +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> > +	if (tvlv_value_len < flex_size)
> >  		return;
> >  
> > -	tt_vlan = (struct batadv_tvlv_tt_vlan_data *)(tt_data + 1);
> > -	tt_change = (struct batadv_tvlv_tt_change *)(tt_vlan + num_vlan);
> > -	tvlv_value_len -= sizeof(*tt_vlan) * num_vlan;
> > +	tt_change = (struct batadv_tvlv_tt_change *)(tt_data->vlan_data +
> > +						     num_vlan);
> 
> This is the only part I'm a little worried about. The math all checks
> out, but the compiler may get bothered about performing a pointer
> calculation using the vlan_data flexible array memory. As in, this may
> be calculated as an array offset, since it is the same as:
> 
> 	&tt_data->vlan_data[num_vlan]
> 
> Which, for big endian where __counted_by is in effect, the bounds
> checker may throw a fit since we're going past the end of the array. In
> other "multiple trailing flexible array" situations, we've done the
> addressing from the base pointer, since the compiler either knows the
> full allocation size or it knows nothing about it (this case, since it
> came from a "void *" function argument). I would suggest:
> 
> tt_change = (struct batadv_tvlv_tt_change *)((void *)tt_data + flex_size);
> 
First of all thanks for the review and the great explanation. The change
looks reasonable to me. I will send a new version with this suggestion.

Regards,
Erick


