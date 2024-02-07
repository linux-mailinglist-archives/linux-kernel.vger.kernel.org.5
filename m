Return-Path: <linux-kernel+bounces-57232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C617D84D565
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8ADF1C2580D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB212B151;
	Wed,  7 Feb 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LYKXjOMh"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A883F127B6C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341466; cv=none; b=NMNpcr5S17TRRPSu5NsyfOCnTTQRw/MLR22iTXV2QoYBoRTB8Qckw5Ads2KWUMhkqV1YsXoGQZGBeB+k+Re0kCERon2kuuZsgL5/9AgcKEz5ZgE7v80EG2hnnEAAnpNYhiRPYuJZDpbItX3JLIvqViSxyfpQs16e1q/AzQsPgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341466; c=relaxed/simple;
	bh=cdJe1ztU6E5GZI3pna9qPmlOhh2zb+xFkuJpyM7H3KU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=pdsCjyXHyGBAjW9ndmpieumgdzjVXz7eWOnDR7KmImdiwFGZ0MUtNjilKyDIgRhsITrMKTuKD0F9M0JlUEXerlDFHeMrVo7iGLI/otiqtzYaDdnM9p5F7epnc46O66Lcuisk402xjmTRIlGYGF5Y18MWVbmiVIOVxecPGvsgio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LYKXjOMh; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240207213100euoutp0226c9caecb7d50dca679a52337ee7e430~xsgM3SfhS1444914449euoutp02Q
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:31:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240207213100euoutp0226c9caecb7d50dca679a52337ee7e430~xsgM3SfhS1444914449euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707341460;
	bh=giEsucpdNlnWSHysV0Xbof/QdmgFW+LMKr4piMpm4aQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LYKXjOMh89zCve+4r0IWw/2xrPj4B0xDYxsIb2ihkIPg6FbKz7tTaWrsz1rQEovri
	 c9KVNfKVwVH7zH6CiCxORINfhe+mytFH4r3JV/abmSZKsmRJubazpu2JCoakslKXcl
	 5CM8bL+hmOgBoYBWsy3U23m5+wVxcLLffTnPoPAc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240207213100eucas1p18ff344f47d25a7d13a51048eb1945f47~xsgMg8qZN2313223132eucas1p1s;
	Wed,  7 Feb 2024 21:31:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 67.46.09552.496F3C56; Wed,  7
	Feb 2024 21:31:00 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240207213059eucas1p10a237b3b9208eae12cd75afb55a3e071~xsgLb7sc21776717767eucas1p1i;
	Wed,  7 Feb 2024 21:30:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240207213059eusmtrp100bb07f68e681f3b18b1a9aaa030f9a4~xsgLWX7uR1255812558eusmtrp1v;
	Wed,  7 Feb 2024 21:30:59 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-9d-65c3f6948ac3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.FF.09146.296F3C56; Wed,  7
	Feb 2024 21:30:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240207213058eusmtip122feeca1207a4fa13dd66b3a6b1a7c9a~xsgKjtXA03032030320eusmtip1V;
	Wed,  7 Feb 2024 21:30:58 +0000 (GMT)
Message-ID: <b4ceab79-3208-419b-9a79-f34540db3f70@samsung.com>
Date: Wed, 7 Feb 2024 22:30:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PM: sleep: Restore asynchronous device resume
 optimization
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki"
	<rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Ulf Hansson
	<ulf.hansson@linaro.org>, Nathan Chancellor <nathan@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Stanislaw Gruszka
	<stanislaw.gruszka@linux.intel.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ZcPelerpp3Rr5YFW@slm.duckdns.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbVBMYRT23rv37q21ubboTD52ZpUwbDWMuWiayHCHMWgyZgzD0m2L2szu
	RvqRJaTEhCI7ZMcIoexsykd2raUWsehjSzbJV2G2mVQUE9pu6N/zPOc85znnnZfCJVYigEpQ
	aTm1SpEoI70FFdX9z2blfbvPhea8FjH5JZUYY3lxlWTqbp8mme7DDxBz1F5GMJnFH0jmTE8+
	zjypqSWYrjtGxPy4WIUYe8naSBF7S98iZE2Xs0jW5bxDsoWPVrOOF6ns9YZMAdttmsxmWg9h
	q6h13uGxXGLCDk4dErHJO77g5RVse9P41E97+pAOZfhmIy8K6Dlw/vs3lI28KQl9CUGn48gw
	6UFQ+LiD4Ek3guPOAeFfi/HdJ5IvXETQ3PEV40kXgtLCp5inS0xHQI6rHXmwgA6EPTVFiNfH
	wqNT7wUePI6WQmtzwdBUXzoGvjytIjwYp/2h+f3ZoTl+9CSoP9E2tBNO63AwFhUPGUg6DLLd
	2aQHe9EhcPd3OcmbpXDDfRr3GIA+5AXtZW9xfu/FYLX0Dd/gC5/t14fxRKg5niPgDZkIDD9b
	MZ7kItC1NyO+awG4HD8GI6jBiOlw7XYILy+E/eeNhEcG2gea3GP5JXzgWMVJnJfFcPCAhO+e
	Cnp76b/Ye89r8Vwk0494F/2I+/UjztH/zzUgwWXkz6VokpScZraK2ynXKJI0KSqlfEtykgkN
	frKaX/bem+jS5y65DWEUsiGgcJmfeO5NKycRxyp2pXHq5I3qlEROY0MTKIHMXxwUK+UktFKh
	5bZx3HZO/beKUV4BOkzn6w6Iypsv7f/yOip98Ya4oGpn1RJprpzW+FU2rE1o3XtDuOaxLKN3
	TaS2L6+63DQt3m0ON6Yt9bE861dRJwhnXMKB0pBdkJ8emmqpEndFh3WQQsyye2tw0GGXOtB2
	d+bmRfZVuUutWBOqa5A/XHcw40PK74LJK0tmt000miOTtQGisk5R98kVsU5HWla6cBz7tmI/
	k4X3hE8i5nWW3Vu+7V3RguBiYv2sr28+Pm+cYZCaXxnMyjZtnXKMrWVftClOcjSo9RxCV1Yq
	w0QFMQOLItymUdKWI3GNAx3BF3yiRzsqe4/Ft5XXNkwJDHWtXla8MEO3zBoVY66XG/a+kgk0
	8YqwGbhao/gD4WFSkNMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7qTvh1ONXh028Ri6trdTBb7Lq5h
	s7i8aw6bxefeI4wWE49vZrVoX/mUzWLul6nMFmdOX2K1+LhnA6PFr+VHGS2Orw134PbYOesu
	u8emVZ1sHneu7WHzmHcy0OPcxQqPLVfbWTw+b5LzaD/QzRTAEaVnU5RfWpKqkJFfXGKrFG1o
	YaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXMePmaqaCG2IVLxt/MDYwNgt3MXJy
	SAiYSGx4/JINxBYSWMoo8Wp5OURcRuLktAZWCFtY4s+1Lqia94wSD24rg9i8AnYSPXeeM4LY
	LAIqEo2nlzJCxAUlTs58wgJiiwrIS9y/NYMdxBYWCJF4ffYo2ExmAXGJW0/mM4HYIgKyElem
	PQTq5QKKNzFLLP23iwnEERKYwSKxunsV2CQ2AUOJrrcQV3AK6Evs/7+VDWKSmUTX1i5GCFte
	YvvbOcwTGIVmITlkFpKFs5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg1G47
	9nPzDsZ5rz7qHWJk4mA8xCjBwawkwmu240CqEG9KYmVValF+fFFpTmrxIUZTYGhMZJYSTc4H
	po28knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQamKaen7J8nPTPE
	/WTUbeWauXkigbOkNG4/077rF+d8QSeDVeRYwiuLtTP7W0I26ubFVCbbpT+btvbGtAZVY+M1
	qx8qzNuifK/t1YPz51Z84ub1y2DcK31LizPA5fHbT9ej+KVOr3rB/bA+dYORsuRd7ZT7oU+O
	rjvfd8zl9V5nQW1Fj/W/y6u+XEvcLRB91PqwV5J1eo/zhJl+m2pqhLraF01qVLJ7yb4owGTu
	mTjve3vr4rWFnXXibUoFfFxOXwjlk+TkFq5nZ3bf25Wde0njZ49iiYLsOuvZRd/+7Hl/KuPS
	95al2kfzgtaEbZ3yr8ZHooJ1W5sAw+GHSd6hM541MDBvCNj6zcD9766WEzxKLMUZiYZazEXF
	iQAmQFhQYwMAAA==
X-CMS-MailID: 20240207213059eucas1p10a237b3b9208eae12cd75afb55a3e071
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240207103144eucas1p16b601a73ff347d2542f8380b25921491
References: <CGME20240207103144eucas1p16b601a73ff347d2542f8380b25921491@eucas1p1.samsung.com>
	<10423008.nUPlyArG6x@kreacher>
	<708a65cc-79ec-44a6-8454-a93d0f3114c3@samsung.com>
	<CAJZ5v0hn=KgaWn9pwtLsH2a8n61BNxzb1xrNoxUfEi3o9OAZGw@mail.gmail.com>
	<4a043533-009f-4db9-b107-c8374be28d2b@samsung.com>
	<CAJZ5v0hDmwaFEtLc8yDc4cXn2wODXAqATe0+_Hpm9QPODUPMQw@mail.gmail.com>
	<ZcOyW_Q1FC35oxob@slm.duckdns.org>
	<2f125955-8c7c-465c-938c-8768f7ca360b@samsung.com>
	<ZcPSuUBoL_EDvcTF@slm.duckdns.org> <ZcPelerpp3Rr5YFW@slm.duckdns.org>

On 07.02.2024 20:48, Tejun Heo wrote:
> Hello,
>
> I couldn't reproduce effective max_active being pushed down to min_active
> across suspend/resume cycles on x86. There gotta be something different.
>
> - Can you please apply the following patch along with the WQ_DFL_MIN_ACTIVE
>    bump, go through suspend/resume once and report the dmesg?

Here is the relevant part of the log:

PM: suspend entry (deep)
Filesystems sync: 0.004 seconds
Freezing user space processes
Freezing user space processes completed (elapsed 0.002 seconds)
OOM killer disabled.
Freezing remaining freezable tasks
Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
dwc2 12480000.usb: suspending usb gadget g_ether
dwc2 12480000.usb: new device is full-speed
smsc95xx 1-2:1.0 eth0: entering SUSPEND2 mode
wake enabled for irq 97 (gpx3-2)
usb3503 0-0008: switched to STANDBY mode
wake enabled for irq 124 (gpx1-3)
samsung-pinctrl 11000000.pinctrl: Setting external wakeup interrupt 
mask: 0xfbfff7ff
Disabling non-boot CPUs ...
XXX wq_update_node_max_active: wq=events_unbound off_cpu=1 total=3 
range=[32, 512] node[0] node_cpus=3 max=512
XXX wq_update_node_max_active: wq=events_unbound off_cpu=2 total=2 
range=[32, 512] node[0] node_cpus=2 max=512
XXX wq_update_node_max_active: wq=events_unbound off_cpu=3 total=1 
range=[32, 512] node[0] node_cpus=1 max=512
Enabling non-boot CPUs ...
XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=2 
range=[32, 512] node[0] node_cpus=2 max=512
CPU1 is up
XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=3 
range=[32, 512] node[0] node_cpus=3 max=512
CPU2 is up
XXX wq_update_node_max_active: wq=events_unbound off_cpu=-1 total=4 
range=[32, 512] node[0] node_cpus=4 max=512
CPU3 is up
s3c-i2c 138e0000.i2c: slave address 0x00
s3c-i2c 138e0000.i2c: bus frequency set to 97 KHz
s3c-i2c 13870000.i2c: slave address 0x00
s3c-i2c 13870000.i2c: bus frequency set to 97 KHz
s3c-i2c 13860000.i2c: slave address 0x00
s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
s3c-i2c 13880000.i2c: slave address 0x00
s3c-i2c 13880000.i2c: bus frequency set to 97 KHz
s3c2410-wdt 10060000.watchdog: watchdog disabled
wake disabled for irq 124 (gpx1-3)
s3c-rtc 10070000.rtc: rtc disabled, re-enabling
usb3503 0-0008: switched to HUB mode
wake disabled for irq 97 (gpx3-2)
usb usb1: root hub lost power or was reset
usb 1-2: reset high-speed USB device number 2 using exynos-ehci
smsc95xx 1-2:1.0 eth0: Link is Down
dwc2 12480000.usb: resuming usb gadget g_ether
usb 1-3: reset high-speed USB device number 3 using exynos-ehci
usb 1-3.1: reset high-speed USB device number 4 using exynos-ehci
OOM killer enabled.
Restarting tasks ... done.
random: crng reseeded on system resumption
PM: suspend exit


> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


