Return-Path: <linux-kernel+bounces-45997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F35843905
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CB101C28358
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2945EE7E;
	Wed, 31 Jan 2024 08:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Nqczv3se"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513DB5DF38
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689673; cv=none; b=WFx9wTTLuLWPBVS6ZyM70IUPu4NSCLJYu+k0+bJ4gu7WqJMi2xTCP91lyJtpm97FtNH4UQqfUQbhyUb1xEM9ob0t+pVXgL3YZoK+bhK9okq8yB4O6bCWtltH0xnesfwpEpamRa2qFmt9IcS3ggmOcf8rC+MMYqtjQg1veWdl2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689673; c=relaxed/simple;
	bh=orznHyIXR/TRlFZMDePnS4WyxDd6rHA4buz/W4I3SGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ip0P8/QaDqZxgYk1MKVa4Bmo2WyBq7rCglfOIc+HnQAEkcuBNxm/E7l0kER6IiX67hQ2FvY+gIxLKGYtGdi8uw4AJcXuIRj57JYC9b+3IBZsZCNwVraOYqtmFzJqSBg6n6JBkpTqMe8jfSRoEHVZaqvsODp6jGhcqegT3Os1iDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Nqczv3se; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240131082748euoutp0247d783a9de61b6b13818b172a3715622~vYTYKdbOR2115921159euoutp02O
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:27:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240131082748euoutp0247d783a9de61b6b13818b172a3715622~vYTYKdbOR2115921159euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706689668;
	bh=0fsq8uLzDhaRpa8JcI+ljGH3/xpVL/O1vkUxc2H28Ds=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Nqczv3seLew/Fi9Kc9QdtunYmx+b/s4Y6GdyyR7NbSKtgSaH/ctTdj3a/xAoNbpuv
	 V06BGoGihmxWzCbFv5EXEGJ7YfnVZ7SA0Kh7Ny5vgrtRhsQcociO/jeXJFbVIVhDpa
	 BOqYFs7R/EsZF7n4u6vFGR8aOoqEtRe8wgCPhyg0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240131082748eucas1p1f414264063bad9c61660997d0fca31f5~vYTX8POpT1221012210eucas1p1T;
	Wed, 31 Jan 2024 08:27:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E3.F1.09539.4840AB56; Wed, 31
	Jan 2024 08:27:48 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240131082747eucas1p293986d8863a529e23044280b3bc6e72e~vYTXn0vv21497014970eucas1p24;
	Wed, 31 Jan 2024 08:27:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240131082747eusmtrp19da54ccefa5c57a3b5b935a47c7b345f~vYTXnXwl53256532565eusmtrp1Q;
	Wed, 31 Jan 2024 08:27:47 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-ba-65ba0484d1f3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A1.C6.10702.3840AB56; Wed, 31
	Jan 2024 08:27:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240131082747eusmtip1636d14d8f71c954921391745323dbecd~vYTXObc901683916839eusmtip1d;
	Wed, 31 Jan 2024 08:27:47 +0000 (GMT)
Message-ID: <676cf135-ab3e-48d8-9fdf-83276502b58a@samsung.com>
Date: Wed, 31 Jan 2024 09:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pwrseq: Use proper reboot notifier path
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Yangtao
	Li <frank.li@vivo.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240126190110.148599-1-afd@ti.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd0Wll2pBm9/81q8PzWR3WLikRlM
	Fpd3zWGzOPK/n9Hi+NpwB1aPO9f2sHkcv7GdyePzJjmPDZ86mANYorhsUlJzMstSi/TtErgy
	FvX+Zyp4L1Dxcd1FpgbGq7xdjJwcEgImEqv/PmfsYuTiEBJYwShx9/tUJgjnC6PEpZ6bzCBV
	QgKfGSXeLTCC6djQ9p4Nomg5o8T3Dy1Q7R8ZJS5v3cPaxcjBwStgJ7H8VzWIySKgKnHxrBpI
	L6+AoMTJmU9YQGxRAXmJ+7dmsIPYwgKOEjevPmYEsZkFxCVuPZnPBGKLCKRKPL3Zxw4Rt5b4
	+aOVFcRmEzCU6HrbxQZicwLZc1f9h6qRl9j+dg4zyDkSAic4JL727WGFONpFYuOuR+wQtrDE
	q+NboGwZidOTe1ggGtoZJRb8vs8E4UxglGh4fosRospa4s65X2wg3zALaEqs36UPEXaUOHX6
	O9i/EgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYevHCJeQKj0iykYJmF5P1ZSN6Z
	hbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMAEc/rf8U87GOe++qh3iJGJg/EQ
	owQHs5II70q5nalCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVVT5FOFBNITS1KzU1MLUotgskwc
	nFINTBPu3gh/v+Dup9Brhj025u0LyjvPtHP/OO2/9ojVXblvnF0yRkovd0VdUbz4bIt0XVRn
	p5viq7vsCl+kXllt3/517/ugyafzP+mlq3Me3xt7wzum42tuyvdXQVu5p67OsNul9njXHpWV
	50xzK66GbJ67TvVqQnu45YwN+R/7ckROPwj7UeB1nUXnSNOC1rNhjQzXGx4E7ON6H1d9oOLE
	3gqPuwclb1lPNVt0WHT2a8XQ54lrA8IuPLvvwRQn8VOs7v2V/vubo3Wyaw0tmFi0j239WFlV
	msHex1cp7nZJTmPS6/bpjwR/2hllSvu5rxBZvtdhn6bTni239+yZffT7Fs28HrGzizUmvVSW
	mfZ6NbsSS3FGoqEWc1FxIgDbSNr3nwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xu7rNLLtSDe5sMbN4f2oiu8XEIzOY
	LC7vmsNmceR/P6PF8bXhDqwed67tYfM4fmM7k8fnTXIeGz51MAewROnZFOWXlqQqZOQXl9gq
	RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlLOr9z1TwXqDi47qLTA2MV3m7
	GDk5JARMJDa0vWfrYuTiEBJYyijx4dFjVoiEjMTJaQ1QtrDEn2tdUEXvGSU2vL7P1MXIwcEr
	YCex/Fc1iMkioCpx8awaSDmvgKDEyZlPWEBsUQF5ifu3ZrCD2MICjhI3rz5mBLGZBcQlbj2Z
	zwRiiwikSpx9OocZIm4t8fNHKyvEqhZGifPLf7KBJNgEDCW63naB2ZxA9txV/9khGswkurZ2
	QQ2Vl9j+dg7zBEahWUjumIVk3ywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kR
	GFPbjv3csoNx5auPeocYmTgYDzFKcDArifCulNuZKsSbklhZlVqUH19UmpNafIjRFBgWE5ml
	RJPzgVGdVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA5MSdnbXo
	jKiw8oINXM1cxk/nXLaXyQ5l28nXLGprcmbNiVWldYyOsTNzF6YcaWY61nrV/OTVXt/NDxRO
	ub5ZVc4RpDtzb9+3lm2PH/+zDz7x8bzbv67ziyVXZyrdlazUlzd1nC624KvTjIjay+9rt9Ub
	anPva18/1Vzsr+V0z5xVL+6UNV6ZEfZ97ZI56y/dyU/Z1PFC/ogqmyD7ZL/vu7bMtJF77Ray
	K6WlPed/6CmPWY4PPt0Ivff0rXOzV8kntxq1ZJmMFamVmy4G8dye86Rv66XT1yvubkk/qXYn
	z3XXrWTTsq9SX6ZsDNlzb9mf48xPJpdK+ykd/it3omnKZ/etZyqNVj15VloexrrjZKkSS3FG
	oqEWc1FxIgBgUHajMgMAAA==
X-CMS-MailID: 20240131082747eucas1p293986d8863a529e23044280b3bc6e72e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240126190119eucas1p28714f09cd2afe41087dcaceba9862a64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240126190119eucas1p28714f09cd2afe41087dcaceba9862a64
References: <CGME20240126190119eucas1p28714f09cd2afe41087dcaceba9862a64@eucas1p2.samsung.com>
	<20240126190110.148599-1-afd@ti.com>

On 26.01.2024 20:01, Andrew Davis wrote:
> This driver registers itself as a reboot handler, which means it claims
> it can reboot the system. It does this so it is called during the system
> reboot sequence. The correct way to be notified during the reboot
> sequence is to register a notifier with register_reboot_notifier().
> Do this here.
>
> Note this will be called during normal reboots but not emergency reboots.
> This is the expected behavior, emergency reboot means emergency, not go
> do some cleanup with emmc pins.. The reboot notifiers are intentionally
> not called in the emergency path for a reason and working around that by
> pretending to be a reboot handler is a hack.


Well, I'm the author of this 'hack' and unfortunately there was no other 
way to make emergency reboot working on boards requiring the eMMC 
pwrseq. IIRC this has been already discussed and the conclusion was to 
accept the hack with the comments explaining the problem.


> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>   drivers/mmc/core/pwrseq_emmc.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 3b6d69cefb4eb..d5045fd1a02c1 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -70,14 +70,8 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
>   		return PTR_ERR(pwrseq->reset_gpio);
>   
>   	if (!gpiod_cansleep(pwrseq->reset_gpio)) {
> -		/*
> -		 * register reset handler to ensure emmc reset also from
> -		 * emergency_reboot(), priority 255 is the highest priority
> -		 * so it will be executed before any system reboot handler.
> -		 */
>   		pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
> -		pwrseq->reset_nb.priority = 255;
> -		register_restart_handler(&pwrseq->reset_nb);
> +		register_reboot_notifier(&pwrseq->reset_nb);
>   	} else {
>   		dev_notice(dev, "EMMC reset pin tied to a sleepy GPIO driver; reset on emergency-reboot disabled\n");
>   	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


