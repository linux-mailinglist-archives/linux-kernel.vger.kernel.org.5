Return-Path: <linux-kernel+bounces-99029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A49878296
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092A9B2151D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920ED446B8;
	Mon, 11 Mar 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RkK6CGw9"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D0446AF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169005; cv=none; b=Cz+8hE1GywVrPS71sjtfhB8Vz0rJYko23E7m6M9RwWAXmgyUBLHP7nsYQQkSDhfYwE4FrGNOgsZc+Amwd44+lkc+y98TCWVbXhw5Cj2a5fegV13qRCt4wSAiBAFRVzSleNYzNUDPpFGibXcyo7fMZcLRs9+4pCPpwJjlmoOkq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169005; c=relaxed/simple;
	bh=uu83XHZpqS5kO/WOuCT5FQLzPQ3U0FfXQvrF8UheWmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Jy0soV9B7srlX9m8J6ZbzMdmLgNk/P19svEiFryxj2Yluf8XO3qmfsVh73lqqe3Oi+nbd3cSGqMrYyHpxKW733x6Iu0YsIgYKdQj77vewgD4mm6RIHlxc2xSBvn8wtLWwro2eFOwoTbnaeuJsH6bWa+PTQ0HS8BzMpW2i5DnEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RkK6CGw9; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240311145640euoutp02452e282ce4d2e2900b90989ab025ff78~7vaUi3KgI0523905239euoutp02H
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:56:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240311145640euoutp02452e282ce4d2e2900b90989ab025ff78~7vaUi3KgI0523905239euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710169000;
	bh=uOPd2AwFVdGKb+UngFBePmqdQoXqrn4uH0VfBRH90zo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RkK6CGw91isXmWz7NCu8mBBKkjgSkwvNssUVCy4UD5IWlcL5wiZ8INxSBdHX/FOt1
	 dBQJgS7aUF7xggzbGH8OLf/ZfH/g7REWyRbxGoh+i0HRzFBL+d9xbcFJd9ZOMH16Sx
	 ZmwWHl16SWC9r2IbG2f3k+UwJw2z/NswDvDL4A1A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240311145639eucas1p1c2f9d8b6e5fa1c36088b4babf0c0056d~7vaUBXqwo2427124271eucas1p1k;
	Mon, 11 Mar 2024 14:56:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B8.01.09539.7AB1FE56; Mon, 11
	Mar 2024 14:56:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240311145639eucas1p2dee661847c8c8a29dcba021d800ca73a~7vaTYZ1MU1472714727eucas1p25;
	Mon, 11 Mar 2024 14:56:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240311145639eusmtrp290064aef32d0f8802d12f1e81dc11274~7vaTXWamJ1058210582eusmtrp2d;
	Mon, 11 Mar 2024 14:56:39 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-61-65ef1ba733ca
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id BC.6F.10702.7AB1FE56; Mon, 11
	Mar 2024 14:56:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240311145638eusmtip1ea6702de7106114eb7a6c1426ce239d7~7vaSRcF-G3139931399eusmtip1A;
	Mon, 11 Mar 2024 14:56:37 +0000 (GMT)
Message-ID: <8abb1a69-6cbd-4a36-ab1d-d269cdafa391@samsung.com>
Date: Mon, 11 Mar 2024 15:56:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>, "Christoph Lameter (Ampere)"
	<cl@linux.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh
	Kumar <vireshk@kernel.org>, Will Deacon <will@kernel.org>,
	Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Ze71H4AdY786nSvn@FVFF77S0Q05N>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZduzned3l0u9TDV7OMraYs34Nm8W+E8kW
	75f1MFpc//aG0eLAs0vMFk//LWO3WLXwGpvFpsfXWC0u75rDZnFvzX9Wi8+9RxgtDk3dy2ix
	9PpFJovfy74zWbz5cZbJYu6XqcwWBz88YbX4d20ji8X2+T+ZLV7eusNisfnBMTaLljumFr1L
	TrI7iHusmbeG0ePytYvMHi1H3rJ6bFrVyeax6dMkdo8TM36zeDy5Mp3JY/OSeo+PT2+xeHRf
	vsHucfzGdiaPz5vkAniiuGxSUnMyy1KL9O0SuDLmN1xiLvjKW/Gs8xlbA+MS7i5GTg4JAROJ
	rx9WMXUxcnEICaxglNg9cxEbhPOFUWLV7G+sEM5nRonWIwuYYFrOztvKDGILCSxnlPh4nwei
	6COjxI5pRxlBErwCdhJfd90As1kEVCVOPVjLDhEXlDg58wkLiC0qIC9x/9YMsLiwQKLEq+0L
	wIYyC4hL3HoyH2yZiECYxO7zn8HuYxZYyyrR+eYN2FA2AUOJrrddbCA2p4COxJxP/SwQzfIS
	29/OYQZpkBBo45LoXfUc6mwXiRsfLjJC2MISr45vYYewZST+75zPBNHQziix4Pd9KGcCo0TD
	81tQHdYSd879AlrHAbRCU2L9Ln2IsKPEq7717CBhCQE+iRtvBSGO4JOYtG06M0SYV6KjTQii
	Wk1i1vF1cGsPXrjEPIFRaRZSuMxC8v8sJO/MQti7gJFlFaN4amlxbnpqsWFearlecWJucWle
	ul5yfu4mRmCaPf3v+KcdjHNffdQ7xMjEwXiIUYKDWUmE97XO21Qh3pTEyqrUovz4otKc1OJD
	jNIcLErivKop8qlCAumJJanZqakFqUUwWSYOTqkGJhNdZ4742F8h58z+xYuofzh1Mu3kes49
	Gbq8WXe/sirPNao9HR0R3Tppna1kpdp2jt9JH838jb7MMFgnwPsnZNex/4c/+F5O3Tbx6sTG
	KxLmU0RexGj8ijj1UOrG3E2swoKceoHBXsVLdKbHSXCWLhbvNzy2d0eakXQp3/LWCbezrM5V
	26qz84X+nubJu2tJhPPTtIl3ix6dT/di2PlmSvm6rB35J8Wfux5pNQ6pinnw6U1Zofxj5aab
	Sg6JJ2K/X5z61idQPiQ7dEbUTLUvPy1/aOzaHh1wrlLw4ou+nPqgD8FtmRVZub9VI0KXTy8M
	2f3717NzbNFiiosntp2euTC25PzUOv07Fl83KXD5KbEUZyQaajEXFScCAAm8wP4iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsVy+t/xu7rLpd+nGrRMZrOYs34Nm8W+E8kW
	75f1MFpc//aG0eLAs0vMFk//LWO3WLXwGpvFpsfXWC0u75rDZnFvzX9Wi8+9RxgtDk3dy2ix
	9PpFJovfy74zWbz5cZbJYu6XqcwWBz88YbX4d20ji8X2+T+ZLV7eusNisfnBMTaLljumFr1L
	TrI7iHusmbeG0ePytYvMHi1H3rJ6bFrVyeax6dMkdo8TM36zeDy5Mp3JY/OSeo+PT2+xeHRf
	vsHucfzGdiaPz5vkAnii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxS
	UnMyy1KL9O0S9DLmN1xiLvjKW/Gs8xlbA+MS7i5GTg4JAROJs/O2MncxcnEICSxllOhetYcR
	IiEjcXJaAyuELSzx51oXG0TRe0aJvVNusIMkeAXsJL7uugHWwCKgKnHqwVqouKDEyZlPWEBs
	UQF5ifu3ZoDFhQUSJV5tX8AMYjMLiEvcejKfCcQWEQiTeHmiiwlkAbPAWlaJprPPoE56zSSx
	+ep3sA1sAoYSXW9BzuDk4BTQkZjzqZ8FYpKZRNfWLkYIW15i+9s5zBMYhWYhOWQWkoWzkLTM
	QtKygJFlFaNIamlxbnpusZFecWJucWleul5yfu4mRmBi2Xbs55YdjCtffdQ7xMjEwXiIUYKD
	WUmE97XO21Qh3pTEyqrUovz4otKc1OJDjKbA0JjILCWanA9MbXkl8YZmBqaGJmaWBqaWZsZK
	4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUydd9+kau6+wWGxWFX3XuaMbiNxn7zSEK5zdxvN
	pVX9GITnCdrMFTne8Ptl/cMNXvp9gW/dJr7dUJ8Wv79y37nlUbUraySfFvy9/JZ9b9Plnw7v
	/Cunb7s/d/php6cTIhm+G4UXK84wafsZLz3VMvzu3PPn2KV/XxIpncc3eZPAzGXe/St+188V
	zH470dbvbvCOn5rHu/gt502/rcSnpSzFenrq5Sd5S3TWK2XnqU77smLJvSU/gxQ6D7Kd59W6
	wbkru0D1aLZuyqLVOZ/3vH1x+qjF6wtKny5F3L+afPiis/AdB1fno1yy275tzl13wfSvedub
	Vzw9pVwFV4q/LHBL2e27ze5xa3PpOvkbrx4kKrEUZyQaajEXFScCAAeoS561AwAA
X-CMS-MailID: 20240311145639eucas1p2dee661847c8c8a29dcba021d800ca73a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
	<CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
	<c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
	<ZesmAO1jJfEjTwxd@arm.com>
	<f160a532-1d31-41a7-b8ae-de8575c395e9@samsung.com>
	<e3952dc0-ec28-e7c7-e858-c47f146c93de@linux.com>
	<Ze71H4AdY786nSvn@FVFF77S0Q05N>

On 11.03.2024 13:12, Mark Rutland wrote:
> On Fri, Mar 08, 2024 at 09:08:59AM -0800, Christoph Lameter (Ampere) wrote:
>> On Fri, 8 Mar 2024, Marek Szyprowski wrote:
>>>>> It looks that cpufreq-dt and/or opp drivers needs some adjustments
>>>>> related with this change.
>>>> That's strange. Is this with defconfig? I wonder whether NR_CPUS being
>>>> larger caused the issue with this specific code. Otherwise
>>>> CPUMASK_OFFSTACK may not work that well on arm64.
>> cpumask handling must use the accessor functions provided in
>> include/linux/cpumask.h for declaring and accessing cpumasks. It is likely
>> related to the driver opencoding one of the accessors.
> I took a look at both the OPP code and the cpufreq-dt code and it looks like
> those are doign the right thing w.r.t. cpumask manipulation (i.e. they only use
> the cpumask accessors, and use the cpumask_var_*() functions to dynamically
> allocate/free cpumasks). Maybe I've missed something, but superficially those
> look right.
>
> Marek, can you try reverting this commit and trying defconfig + NR_CPUS=512?

Yes, with $subject reverted and CONFIG_NR_CPUS=512 everything works 
fine, so it must be something else broken.

> That'll have CPUMASK_OFFSTACK=n, and:
>
> * If that blows up, we know the problem is independent of CPUMASK_OFFSTACK, and
>    has something to do with large cpumasks (either a driver bug, or elsewhere).
>
> * If that doesn't blow up, it suggests the problem is related to
>    CPUMASK_OFFSTACK rather than with large cpumasks specifically.
>
> Either way, we probably need to revert this patch for now, as this won't have
> enough time to soak in linux-next in time for v6.9.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


