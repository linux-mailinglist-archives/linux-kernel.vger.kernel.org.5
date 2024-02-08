Return-Path: <linux-kernel+bounces-57825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990C84DDDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7171C27A68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC36BB20;
	Thu,  8 Feb 2024 10:10:58 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C902628C;
	Thu,  8 Feb 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387058; cv=none; b=c1Hugib52EbXlfRubwYb7SSTrCjYwG9Ohavn76bq4ZXcnCK4qletyldtoy6gQFc4u9b7QXjiH7hDHcvmePHw/rA6SCyu7y3gfLFy3em7NWengWWdIzO+Xn77r/+XBdWdalKBBxEnXybeHuN6YTz69awQ3+zqmG/o3zFwGvORpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387058; c=relaxed/simple;
	bh=qLCh3ytdZKeIfbMJV5WpRHUtt4q/bZA8WymOdOW+6n8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zh+h0aD6BFPJ+tM9FHL7U1ogeZan5gUBod7ADtrXGuqCEWCRVdNyMXOxnd5r6HRWxBVXZp7+SsWWYtL5Kem+xrhQEhShu6oW7T6PijvwrpeJ9OTI4iNyQt7NOo7tYQfWW5aSv6NvhSSarqX7zIe8AL2Fx6hVyOOgm8An5wpjVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVt271933z6JB3P;
	Thu,  8 Feb 2024 18:07:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 61C9D1400D9;
	Thu,  8 Feb 2024 18:10:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 10:10:52 +0000
Date: Thu, 8 Feb 2024 10:10:52 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hojin Nam <hj96.nam@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wonjae Lee
	<wj28.lee@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v3] perf: CXL: fix mismatched cpmu event opcode
Message-ID: <20240208101052.000018d7@Huawei.com>
In-Reply-To: <20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>
References: <CGME20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>
	<20240208013415epcms2p2904187c8a863f4d0d2adc980fb91a2dc@epcms2p2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 08 Feb 2024 10:34:15 +0900
Hojin Nam <hj96.nam@samsung.com> wrote:

> S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
> r3.0 3.3.9 Table 3.43. However, it is defined as 3 in macro definition.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
> 
> Hi Jonathan,
> Sorry, I misunderstood your guide. 
> I roll-backed to v1 patch keeping fixes tag. Thank you!
> 
> Changes since v2:
> - Remove s2m_ndr_cmpm attribute and referecne added at v2 (Jonathan)
> 
> Changes since v1:
> - Add s2m_ndr_cmpm event attribute
> - Add fixes tag (Jonathan)
> 
> 
>  drivers/perf/cxl_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 365d964b0f6a..bc0d414a6aff 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -419,7 +419,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,                     CXL_PMU_GID_S2M_NDR, BIT(0)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,                    CXL_PMU_GID_S2M_NDR, BIT(1)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,                    CXL_PMU_GID_S2M_NDR, BIT(2)),
> -       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(3)),
> +       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(4)),
>         /* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
>         CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,                 CXL_PMU_GID_S2M_DRS, BIT(0)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,              CXL_PMU_GID_S2M_DRS, BIT(1)),
> --
> 2.34.1


