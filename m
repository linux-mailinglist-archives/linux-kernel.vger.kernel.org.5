Return-Path: <linux-kernel+bounces-101721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8216087AAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38797283C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11024482D1;
	Wed, 13 Mar 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sZTlLkTN"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41745BF3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346967; cv=none; b=PuFoq8HkuCNKDemZ7rzPa2F9VRbcdeBQjyZzvwrU8RzAYUftMu07beDchTiRAvc9JRcClITiacADVhMdd56mWwNvpo4ibRnqRCF+iF19W6vciA5gSUsIbTsLR1hGX0m1Wa1D1NdtjnWeDE+3+cbCmyF0GnbCy3fh/lSO9m+Jj0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346967; c=relaxed/simple;
	bh=oaT0QwztCAl0YgK1XcQKqu8DsbQ0u9P2WanTVDxUmxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=g/Zsfq/sPIvkGc1X09A8BUMY5O7ZPKrqO3mDR1CAIzcThWWQ/dXy77gzSj2qipKwjsjCNWpvzpjcr3FPdRscFZrnAYjLybgpgNNge/0apVw2MMvD3Y3KPZWUiAuqGcHK8HsPSyTyxTt5Uw2WwoOJzvN63D+Lrrv1IwEDYlNCLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sZTlLkTN; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240313162236euoutp01101869ad7e4cd1750fdf550e7fede84b~8X37dvQdE1041010410euoutp01g
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:22:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240313162236euoutp01101869ad7e4cd1750fdf550e7fede84b~8X37dvQdE1041010410euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710346957;
	bh=BWYpIQ4r8Zif4LDU74qDLvjeFc0NUCjMapnqPAf0A0A=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sZTlLkTNqAo5IXV3e2hCCVv5aDuAq7NSOgw/jTIlN7oXhG0iKKP55eeeTYDQ6gETy
	 sMEks35VfDlmUj2jk0xnhj9RURHO4joZs8GOh+MMH1+muNC8Umn9ZMguPeiPyLmOWB
	 GPfXIty47g8v4437Hs+ox37FMVfcrU8O3o0pkJm4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240313162236eucas1p188d08dbd27a4fc35d26ebf2f74590b6e~8X36yA8jY2090920909eucas1p1e;
	Wed, 13 Mar 2024 16:22:36 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 68.55.09539.CC2D1F56; Wed, 13
	Mar 2024 16:22:36 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240313162235eucas1p28985c12dd057d42fda670ff1566be92d~8X36Pwf3_1629816298eucas1p2S;
	Wed, 13 Mar 2024 16:22:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240313162235eusmtrp1f3227630d7e3e933cdaf6b8087004dfb~8X36Ojy0i0652306523eusmtrp1H;
	Wed, 13 Mar 2024 16:22:35 +0000 (GMT)
X-AuditID: cbfec7f2-52bff70000002543-cf-65f1d2cc6aa7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.6F.10702.BC2D1F56; Wed, 13
	Mar 2024 16:22:35 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240313162234eusmtip255ffd96a8a17ee58b730fe9562d7edd7~8X35KaLOq1857618576eusmtip2O;
	Wed, 13 Mar 2024 16:22:34 +0000 (GMT)
Message-ID: <432c1980-b00f-4b07-9e24-0bec52ccb5d6@samsung.com>
Date: Wed, 13 Mar 2024 17:22:33 +0100
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
To: Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>, Mark Rutland
	<mark.rutland@arm.com>, "linux-pm@vger.kernel.org"
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
In-Reply-To: <ZfG5oyrgGOkpHYD6@bogus>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjeuff29tJZcimwnrA5QhPZGIFCxsJJYDiWqTeLLi5TF6bONXCh
	jILQwmDitiYgH1UJQZBaUZAgHQ0ZUj6KTIl0QPmYTD5WWFMHywqLxE4LTESkjnpx49/zPO/z
	vu/znhwKF1WSAVRqRjarzJApJKSA6BxY/SXs53EXG6F+JkA1Lc0k6hlMRA8azwA09eg+QLfm
	x3E0527kI8MVK4mMf1p5aKK7hkS/Nz/joaWzfQCZq24CdHVqDENrjSsYuv/4NoYuLVfhqPeh
	g4fc1lYC6Ye7CGSqXcXRPZudQG2zAyQqtL+DzjYM8d+DTPPlZsBMWMdwprDPyWOMhlKSMS5W
	8JlB7RrBOCarMaat4TvGNWcjmNMT03zGMm3CmCXj6/u3fSaITWIVqV+xSmncFwL5udpuMnNl
	W9765XKgBg0CDfCiIB0Fh1fLcQ0QUCL6ewBnNHc3yTKAv8628zmyBOANw9/kixbt7WrAFfQA
	jmrdGEdcAI7XFGMel5COg3btLeDBBL0DmgcLeZzuA4cuOAgP9qcD4YxNy/dgX1oGF0x1uAfj
	tBjaHLUbcyjKjz4AlyyHPPNx2sqDLRuP5/GQdCTUODXPE3ltzF961L7ZGwgLOi4+vwHSGgEs
	a+vfjP0BrFrp53HYFy5Y2vkcfg2OnDtDcA3FANatzWAcKQdQ/ZcNcK4YaB99Qnoi4XQIbOmW
	cnI8XChr4XtkSHvDaacPF8IbVnRW45wshCVFIs4dDHWWH/5b23tnHC8HEt2WZ9FtOV+35Rzd
	/3vrAGEAYjZHlZ7CqiIz2NxwlSxdlZOREp54PN0INj7uiNuy2AUuLbjCzQCjgBlACpf4Cb8N
	crEiYZLs6xOs8vgxZY6CVZnBqxQhEQt3JAWyIjpFls2msWwmq3xRxSivADUWOp92Cj+RhXX7
	xSzHP405eHD4zZCxe/5xCR/uif/U96WTF/YTFf4FCd46eK2/fj3UpchV7ZP2qqofTtV39gRP
	2kQfmdz51wFIDzgWEZJ6JGH7zr73j1yJ65LEJueHFU3E5j1NWPlpt/5UbpSrnpqM0n+Z+Diz
	/8d3Q8McTUclA2/sjHjZ9IfwwdESs4GRl4JvPjm/fURakh4tv5h2xzTVn90ECnq8K8tutg49
	KTzAhgff+HyO1pcN2kNm55OvO/18KsV5hzs056u011Zb3y5N/WcyendVVkVQm0J9uIjK77j7
	SlCTWFucpdybVLdr1565bOdpnsaeLP9N+rFi3/rJxehRCaGSyyLfwpUq2b99bQsXJwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsVy+t/xe7qnL31MNZi0RMlizvo1bBb7TiRb
	vF/Ww2hx/dsbRosDzy4xWzz9t4zdYtXCa2wWmx5fY7W4vGsOm8W9Nf9ZLT73HmG0ODR1L6PF
	0usXmSx+L/vOZPHmx1kmi7lfpjJbHPzwhNXi37WNLBbLT+1gsdg+/yezxctbd1gsNj84xmbR
	csfUonfJSXYHCY8189Ywely+dpHZo+XIW1aPTas62Tw2fZrE7nFixm8WjydXpjN5bF5S7/Hx
	6S0Wj+7LN9g9jt/YzuTxeZNcAE+Unk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWR
	qZK+nU1Kak5mWWqRvl2CXsbk+bvYCr7zVPydN4GxgXEJVxcjJ4eEgInEjLPTGbsYuTiEBJYy
	SvRebGeESMhInJzWwAphC0v8udbFBlH0nlGi/c9vsASvgJ3EnRkHwBpYBFQlDp1ogYoLSpyc
	+YQFxBYVkJe4f2sGO4gtLJAo8Wr7AmYQm1lAXOLWk/lMILaIQIjEgcctLCALmAWusUpcenIa
	6qS/TBI7PzwFq2ITMJToegtyBicHJ9C2z9+2QE0yk+ja2sUIYctLNG+dzTyBUWgWkkNmIVk4
	C0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgSmmG3Hfm7Zwbjy1Ue9Q4xMHIyH
	GCU4mJVEeOsUP6YK8aYkVlalFuXHF5XmpBYfYjQFhsZEZinR5HxgkssriTc0MzA1NDGzNDC1
	NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCKkD+f+k7I+731pWu6Tx+47/GqOy+QU9j+
	2tTQSPzdRiepfTHxUne/M5066sJy+tCK6DqdPWFKkwM+L/9pI3E7e/P3D54mv0Ub9laFb4jm
	kWJ83b9ZdZnitf3/tCU1Jl5K2nCk4nD4yb+CF+02pASkFx0O01+pyzzzq+zJmptVt9sE5or7
	bdy1Lv/i1ztX2Y/eOZofs5N36sa3Z5PlV8joqVdrJVuzbzJtlQ3M4w2buVjSg5Eng6fUY8eZ
	F8+YDR+fkKn70LV+mQVben+amtT5xKgDM37evNVb4Ffp0m/Ft7PQ4vrepsiMyfe2dc3j8Gzt
	lXqS3xYqOHPfmTXJDHqTagv9fldvrC69fyLWJFyJpTgj0VCLuag4EQDv/JGNugMAAA==
X-CMS-MailID: 20240313162235eucas1p28985c12dd057d42fda670ff1566be92d
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
	<ZfG5oyrgGOkpHYD6@bogus>

On 13.03.2024 15:35, Sudeep Holla wrote:
> On Tue, Mar 12, 2024 at 05:55:49PM +0000, Catalin Marinas wrote:
>> On Tue, Mar 12, 2024 at 10:06:06AM -0700, Christoph Lameter (Ampere) wrote:
>>> On Mon, 11 Mar 2024, Christoph Lameter (Ampere) wrote:
>>>
>>>> This could be an issue in the ARM64 arch code itself where there maybe
>>>> an assumption elsewhere that a cpumask can always store up to NR_CPU
>>>> cpus and not only nr_cpu_ids as OFFSTACK does.
>>>>
>>>> How can I exercise the opp driver in order to recreate the problem?
>>>>
>>>> I assume the opp driver is ARM specific? x86 defaults to OFFSTACK so if
>>>> there is an issue with OFFSTACK in opp then it should fail with kernel
>>>> default configuration on that platform.
>>> I checked the ARM64 arch sources use of NR_CPUS and its all fine.
>>>
>>> Also verified in my testing logs that CONFIG_PM_OPP was set in all tests.
>>>
>>> No warnings in the kernel log during those tests.
>>>
>>> How to reproduce this?
>> I guess you need a platform with a dts that has an "operating-points-v2"
>> property. I don't have any around.
>>
>> Sudeep was trying to trigger this code path earlier, not sure where he
>> got to.
> I did try to trigger this on FVP by adding OPPs + some hacks to add dummy
> clock provider to successfully probe this driver. I couldn't hit the issue
> reported 🙁. It could be that with the hardware clock/regulator drivers, it
> take a different path in OPP core.

I can fully reproduce this issue on Khadas VIM3 and Odroid-N2 boards. 
Both Meson A311D SoC based.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


