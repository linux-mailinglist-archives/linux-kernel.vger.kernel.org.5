Return-Path: <linux-kernel+bounces-54684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F52784B269
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CF1C22CEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139E712EBCE;
	Tue,  6 Feb 2024 10:21:39 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED2A12E1F3;
	Tue,  6 Feb 2024 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214898; cv=none; b=rEwiBHn1WyO4RjtuOyKKwVw2ZFzvrsdvayRAbeREIzE7tmc44VynkUS50y51lMZS6GTRFxSTEdt8wsk+ifr+MG5m0GIBVeR3c3gWEX+T7i8l344Of2MYur4F7UbO7pGmyRiAwmtUBORQRlz21Ojzc3YLzCVYVq/d2YMZzV1LMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214898; c=relaxed/simple;
	bh=Qc4tQMcCW7sIW6ZtrFPCai8rsVKqyTF2v6Fdl8iPG0Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxU2JKkLYeHVB3f5iceZ9V4WFhqy6LqCcZhpCbhFkCLXtrXd2PVj1cisJQmvLJ2LouowmK1YNukIpLwBhq3kj9iFWGmjUqM+PBSn7NDtYBN4tH3p13DFyzM4NdgqmtMJWnVBF1hQBx69Bu3sjl04FJ1Vnb3+KddYi+tB778UkFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TTfMv04sMz6K90T;
	Tue,  6 Feb 2024 18:18:19 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E89FF140A79;
	Tue,  6 Feb 2024 18:21:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 6 Feb
 2024 10:21:33 +0000
Date: Tue, 6 Feb 2024 10:21:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hojin Nam <hj96.nam@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wonjae Lee
	<wj28.lee@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf: CXL: fix mismatched cpmu event opcode
Message-ID: <20240206102132.00000797@Huawei.com>
In-Reply-To: <20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>
References: <CGME20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>
	<20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 06 Feb 2024 18:41:51 +0900
Hojin Nam <hj96.nam@samsung.com> wrote:

> S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
> 3.0 specification. However, it is defined as 3 in macro definition.
> 
Please provide a reference to a specific spec section.
Ideally from r3.1 as that's the easily available version today.
I think this is Table 3-50 S2M NDR Opcodes in r3.1

Looks like s2m_ndr_cmpm should be there for bit 3 so we should probably
add that as part of the fix.


> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
> ---
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


