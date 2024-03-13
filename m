Return-Path: <linux-kernel+bounces-102484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9F87B2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810E61F264BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514C04E1DB;
	Wed, 13 Mar 2024 20:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K0zbkg18"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BCA4CB41
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361131; cv=none; b=Etuw99/jV2nFvXI1pZCOTVtmpgIAgq7MRRqDB76GC08zEotkTww1uPI5mqBShoYJ9SwX8ph6wEcV1d2AlVuEevZ6FpoY8Imqvg8hmeYb5+SDs16KXMpSmRdE2dYKVqrGry6N8vZlx6kOtxH+0kSPfvvs4x7yaaYW5pwfUuSQ6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361131; c=relaxed/simple;
	bh=NvLdP9RWPjWCCTlUHc3YLyOuTC8sFH9u5xL8Cr0OUIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=q0mo+09BeTvUBXiN/UlxMoRlPA2YAcCML4o76IKF2PSIfLJT86pBlXbreVtDJsyDQ/OL1L0PlhZZT7xH2W1J2vURUAp45MxqaC+Ffc8+xQj4LtVVyR7Pib828GVUYmlNybCT81xIGmr1EsXVwczbDC0SHtoDqFQrU7JVZTssFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K0zbkg18; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240313201846euoutp01c67263b000e036ffa0e96fc206477362~8bGILCwgy1433114331euoutp01O
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:18:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240313201846euoutp01c67263b000e036ffa0e96fc206477362~8bGILCwgy1433114331euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710361126;
	bh=oNMo5LEc3usABFxyA4oBiAOdQqLn4DzF/mzFI1Dkuig=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=K0zbkg18tB0CpWdzx0CHu4MNFCxAUD7yQA+L55lkjjpFLoB0Jh0VGkZiiZmRmwBPM
	 EVIeke+gRGaCEvup9UIvYA5Sw8T3Al4h7ZitDexkaafl4bsUP+wXRGoqTd2WwznaOA
	 I4yBwmi9uBWpmYU6VTiWO+zfRA+cIbPz3aGn4q2A=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240313201845eucas1p29a8e72e12de4cf9e9e15198eb3523dfb~8bGHWWEYM0441804418eucas1p2a;
	Wed, 13 Mar 2024 20:18:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id B5.6A.09552.52A02F56; Wed, 13
	Mar 2024 20:18:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240313201845eucas1p2f042dd14bd3cff23e28b594b330667b0~8bGG5f_5s0441704417eucas1p2l;
	Wed, 13 Mar 2024 20:18:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240313201845eusmtrp199f3fba23e4afad6c843d5c77536f68d~8bGG4xH-M2912729127eusmtrp1I;
	Wed, 13 Mar 2024 20:18:45 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-6a-65f20a25250d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 28.7A.10702.52A02F56; Wed, 13
	Mar 2024 20:18:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240313201844eusmtip1a39b10b1af3da014b0243a17ea407c5c~8bGFwrYTu2660926609eusmtip18;
	Wed, 13 Mar 2024 20:18:44 +0000 (GMT)
Message-ID: <e8533ce6-8771-400c-93b6-829a51c38b74@samsung.com>
Date: Wed, 13 Mar 2024 21:18:43 +0100
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
To: "Christoph Lameter (Ampere)" <cl@linux.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Will Deacon
	<will@kernel.org>, Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com,
	Valentin.Schneider@arm.com, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, Eric Mackay <eric.mackay@oracle.com>,
	dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk,
	robin.murphy@arm.com, vanshikonda@os.amperecomputing.com,
	yang@os.amperecomputing.com, Nishanth Menon <nm@ti.com>, Stephen Boyd
	<sboyd@kernel.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <173078dd-3743-2d39-a9ea-015ea5be48f8@linux.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTZRzved93715m815fqD2hQq4oqRMko3sIgTqxXi//gKtD67poyBtw
	AXobI+TIdrlDILEFEmNNwYPAm0tqonAUniAxGCkMOFxjBjTQ+DFyoOggKbY3i/++nx/fH5/n
	HgpnTpKBVEZ2DifPlmVKSRFxqcvTty1ENM9tv+eMRPpGI4kudx9Af9YfB+jG4ixAV24N4Ghy
	pV6IDGeGSWRyDgvQYKueRL8Z/xaghdJOgDoq2gD69oYVQ8v19zE0++Aahk7drcBR+50JAVoZ
	/oFADZYWAjVXe3A0ZXcQ6MJYF4nUjkhUWtcjfA2yxtNGwA4OW3FW3ekSsCZDMcma5suEbLd2
	mWAnhiox9kLdZ6x70k6wXwzahKzZ1oyxC6aghMffE+1M5TIzcjl5eOyHonS9xUoeqqDyGq4u
	ABVoJkuAHwXpl6FBU4iXABHF0GcBdP8yQfDgLoB6bSXGgwUAh8ZuCR+1nKszC3mhAcBqfa+A
	B24Au6xLmNclpmOhcabFVxN0CJwdWRTy/AbYU+Xd4Uc9QQfDUbvWx/vTMjjdXIN7a5yWQPtE
	ta83gA6HFbVFvptw2iOA3395TOAVSDoClrhKfCn86BhYO36a4JuD4dGL3/gSQfqECGqmilcF
	ahXEQ7WT5SP4w2lz079xNsHe8uME7z8GYM3yKMYDDYCq23bAu6Kh4/oS6R2E06GwsTWcp1+H
	0ycahfz89dDm2sDfsB6WXarEeVoMiwoZ3v0c1JnP/7e2vX8A1wCpbs2z6NbE161Jo/t/bw0g
	DEDCKRVZaZxiRzb3SZhClqVQZqeFHTiYZQKrH7d3xXyvBZyddod1AIwCHQBSuDRAfGSLm2PE
	qbLD+Zz8YLJcmckpOsBGipBKxCGpwRxDp8lyuI857hAnf6RilF+gCttzOeCnczFbQnO6Y2ku
	2db0cOBMpLhMvjX/ZmWRbowqmJ9h7rRb3rpYpezNc1WBr/qfv9b3o/XF2s0expbUVqDdtC/F
	cTVha9DhuODlOP8/djr6bW+Mv70nbeqkJf78O2xStfDpWtGE8qn3Jeacwt25kNHWN43XlUar
	4j+dJI841B/s63yJSfy1ydYTlbj/zdChvIyo+59ThqWfyzWqGEY3WvVKwdF358vlga5TfyVs
	i3ggmfva2Ze0bi4oLi96rynd+dh31/dvLt6lHW9rbbduT7qpzdz9pIgS72IM6sR1z+41TOeO
	JINnon5PCSRNMxtf9QQvzj0sHsnn6Csf7bhtSemUEop0WcQLuFwh+wdUzi2PJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsVy+t/xu7qqXJ9SDZ4tFLKYs34Nm8W+E8kW
	75f1MFpc//aG0eLAs0vMFk//LWO3WLXwGpvFpsfXWC0u75rDZnFvzX9Wi8+9RxgtDk3dy2ix
	9PpFJovfy74zWbz5cZbJYu6XqcwWBz88YbX4d20ji8XyUztYLLbP/8ls8fLWHRaLzQ+OsVm0
	3DG16F1ykt1BwmPNvDWMHpevXWT2aDnyltVj06pONo9Nnyaxe5yY8ZvF48mV6Uwem5fUe3x8
	eovFo/vyDXaP4ze2M3l83iQXwBOlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2Vk
	qqRvZ5OSmpNZllqkb5eglzHn1EW2gqkcFcsPf2ZsYNzO1sXIySEhYCKxeslx9i5GLg4hgaWM
	EnOPX2GFSMhInJzWAGULS/y51sUGUfSeUeLm311gCV4BO4k1r3cwgdgsAqoSb25/Y4eIC0qc
	nPmEBcQWFZCXuH9rBlhcWCBR4tX2BcwgNrOAuMStJ/PBekUE9CWmLu5gAVnALPCbVWLqlx0s
	ENseM0vs3X+UEaSKTcBQouttF9jdnAK2EosfzmOBmGQm0bW1ixHClpdo3jqbeQKj0Cwkh8xC
	snAWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECEwx24793LKDceWrj3qHGJk4
	GA8xSnAwK4nw1il+TBXiTUmsrEotyo8vKs1JLT7EaAoMjYnMUqLJ+cAkl1cSb2hmYGpoYmZp
	YGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwMS4PO5qRXtYlDxvnf32CWcuB3VsTwjj
	P2Un4TGF8fVi/ZB8yQ2ZM8zX3EuO2Xd26d8VflMiph5wuL0yjEmZ7dvZ1H7+t12FstcqNHUe
	JxzatvH21IYFF5q4vKZpWU6Icvz06NDFfx/ey/FzzP288wb/g/u6M9kOvtG6+P/8xzwmjj3s
	a3n2reSVnHf6Sdu3y6t8Dlx5XdX0VeJ93elJv3LflH6Q4i2+7fuqxuOOxb1JV3JPLTORPSJ0
	+vzzRo+CVyt2p/+sZny7XifeIOJqZMmdVll9/Yv6q/qPZXuaHvscKOv3coed5YqE/Ysf9wZ+
	vHBTSdfd8vDXzLSA2l1cqS2xOZcFhNepyx/923r53K4UJZbijERDLeai4kQAWu2UZLoDAAA=
X-CMS-MailID: 20240313201845eucas1p2f042dd14bd3cff23e28b594b330667b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f
References: <37099a57-b655-3b3a-56d0-5f7fbd49d7db@gentwo.org>
	<CGME20240308140130eucas1p1259c805a0b6491ce2f69c6fca0264b1f@eucas1p1.samsung.com>
	<c1f2902d-cefc-4122-9b86-d1d32911f590@samsung.com>
	<Ze9TsQ-qVCZMazfI@arm.com> <9352f410-9dad-ac89-181a-b3cfc86176b8@linux.com>
	<bf1757ca-6d41-87e7-53dd-56146eef5693@linux.com> <ZfCXJRJSMK4tt_Cm@arm.com>
	<ZfG5oyrgGOkpHYD6@bogus> <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
	<173078dd-3743-2d39-a9ea-015ea5be48f8@linux.com>

On 13.03.2024 17:39, Christoph Lameter (Ampere) wrote:
> On Wed, 13 Mar 2024, Marek Szyprowski wrote:
>
>>> I did try to trigger this on FVP by adding OPPs + some hacks to add 
>>> dummy
>>> clock provider to successfully probe this driver. I couldn't hit the 
>>> issue
>>> reported 🙁. It could be that with the hardware clock/regulator 
>>> drivers, it
>>> take a different path in OPP core.
>>
>> I can fully reproduce this issue on Khadas VIM3 and Odroid-N2 boards.
>> Both Meson A311D SoC based.
>
> Hmm... Would it trigger on Orangepi5plus? With some effort I can get 
> that board up at home.
>
> Could you reboot with some memory diagnostics so that we are sure that 
> nothing gets corrupted?
>
> F.e. specify a command line parameter "slub_debug" to enable 
> redzoning. That way we may see potential memory corruption.

I've added CONFIG_SLUB_DEBUG_ON=y to my .config, but I got no reports 
for any potential memory corruption.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


