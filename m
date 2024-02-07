Return-Path: <linux-kernel+bounces-56482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79C584CAB4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FC88B22987
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674BD59B7E;
	Wed,  7 Feb 2024 12:27:56 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C5A5A0FD;
	Wed,  7 Feb 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308875; cv=none; b=N6DptMUbslajFagpNPmN7sMRle+QA7S05LSAflNri5W0nKIfvMfPBgfnOBd85C+WykA90tMUcXOo6/xaKco+oXKTC2CvM1EpxrwoUBfkre1j5BftJC63mwAUG7xxt5obH/b+rArC9LaoqUXH6UqiRvMmwb93FDs/RhHW/mJ+RQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308875; c=relaxed/simple;
	bh=zNgtsqJEnEr66FZuG+V88C+VFdZoePSCJZJWhNtsyyA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GW23hhP26mDl1CaBAIUie0IPjDZ7V14IxtaqLC6aBZnEEUL4KbcEPwNhggYPmXHPe6W/AAcNdQod6s34HhTyxfc4EGZjOL+E0R9XjMyzhQ1lT3ftq4tktpSW3QXCfJgonOW5n0ehYAK3NqDDosEFB48pG/xNTB2LSHsLxeZDqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVK6y1jhjz6K62N;
	Wed,  7 Feb 2024 20:24:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 97A32140736;
	Wed,  7 Feb 2024 20:27:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 7 Feb
 2024 12:27:44 +0000
Date: Wed, 7 Feb 2024 12:27:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hojin Nam <hj96.nam@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wonjae Lee
	<wj28.lee@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH v2] perf: CXL: fix mismatched cpmu event opcode
Message-ID: <20240207122743.00004acc@Huawei.com>
In-Reply-To: <20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764@epcms2p3>
References: <CGME20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764@epcms2p3>
	<20240207042235epcms2p358e40f0409e25bd9e875ad1ae0dd0764@epcms2p3>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 07 Feb 2024 13:22:35 +0900
Hojin Nam <hj96.nam@samsung.com> wrote:

> S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
> r3.1 3.3.9 Table 3.50. However, it is defined as 3 in macro definition. Also
> adds s2m_ndr_cmpm for bit 3 that was added in CXL r3.1.
> 
> Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> Signed-off-by: Hojin Nam <hj96.nam@samsung.com>

Ah. Sorry I've mislead you. I lazily assumed this was in the 3.0 spec as well
without checking.

As a fix, we should not add the cmpm or update the reference comment.

So should be the v1 patch with a reference to table 3-43 in r3.0
and the fixes tag.

A follow up patch to add the 3.1 definitions would be excellent but we shouldn't
be looking to backport that so it doesn't belong in the fix :(


Jonathan


> ---
> 
> Hi Jonathan,
> I've modified the commit messsge and code to reflect you mentioned. Thank you!
> 
> Changes since v1:
> - Add s2m_ndr_cmpm event attribute (Jonathan)
> 
> 
>  drivers/perf/cxl_pmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 365d964b0f6a..d85d53d907a6 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -415,11 +415,12 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>         CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,                CXL_PMU_GID_S2M_BISNP, BIT(4)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,                CXL_PMU_GID_S2M_BISNP, BIT(5)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,                CXL_PMU_GID_S2M_BISNP, BIT(6)),
> -       /* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
> +       /* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
>         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,                     CXL_PMU_GID_S2M_NDR, BIT(0)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,                    CXL_PMU_GID_S2M_NDR, BIT(1)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,                    CXL_PMU_GID_S2M_NDR, BIT(2)),
> -       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(3)),
> +       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,                    CXL_PMU_GID_S2M_NDR, BIT(3)),
> +       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(4)),
>         /* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
>         CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,                 CXL_PMU_GID_S2M_DRS, BIT(0)),
>         CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,              CXL_PMU_GID_S2M_DRS, BIT(1)),
> --
> 2.34.1


