Return-Path: <linux-kernel+bounces-54769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609584B375
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4931F23CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C62D12EBE5;
	Tue,  6 Feb 2024 11:29:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6412D152;
	Tue,  6 Feb 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218977; cv=none; b=bWr2fVSa/uiW4OfqjDNyUWrzPWCRy6qdpOZTWDdtF/++NjxsmNFtOBk24oWufA8PNPC/NwUSUM8bqXjG5lA2fKYedzIZFZdz/HvhoZwwHL0DkaEVUCe8GzHUPS8Gmbz/0k0b7EWf1syX+sKdq8Trars9uEwYm6u0HI61zK1NgxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218977; c=relaxed/simple;
	bh=C6jq6gONzhEHjn/SunkCOAnt+ckT2TxdCHEFn2845Jc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elHajE6D4Bh90nukovhlc3SiA/c91j9vnNGRc0rxg0igh3fN48083NgRjEik/yNMcMwkKc+GJ1h9Z1LbLzDO0AsiVt7SDpk4EwVnPoJi19Q95HTBo/OuMN3FhwdJ8Nz3k60NORinLcPYLKLK1V8DjcH65srYlbzSnN8DNcI1qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TTgtK6JCRz67ZCr;
	Tue,  6 Feb 2024 19:26:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DCF0B140B39;
	Tue,  6 Feb 2024 19:29:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 6 Feb
 2024 11:29:32 +0000
Date: Tue, 6 Feb 2024 11:29:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Hojin Nam <hj96.nam@samsung.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, Wonjae Lee
	<wj28.lee@samsung.com>, KyungSan Kim <ks0204.kim@samsung.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf: CXL: fix mismatched cpmu event opcode
Message-ID: <20240206112931.00004224@Huawei.com>
In-Reply-To: <20240206102132.00000797@Huawei.com>
References: <CGME20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>
	<20240206094151epcms2p373ed7f50efa332765e14bff2b5a2abe2@epcms2p3>
	<20240206102132.00000797@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 10:21:32 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 06 Feb 2024 18:41:51 +0900
> Hojin Nam <hj96.nam@samsung.com> wrote:
> 
> > S2M NDR BI-ConflictAck opcode is described as 4 in the CXL
> > 3.0 specification. However, it is defined as 3 in macro definition.
> >   
> Please provide a reference to a specific spec section.
> Ideally from r3.1 as that's the easily available version today.
> I think this is Table 3-50 S2M NDR Opcodes in r3.1
> 
> Looks like s2m_ndr_cmpm should be there for bit 3 so we should probably
> add that as part of the fix.
> 
Also, please add a Fixes tag.
> 
> > Signed-off-by: Hojin Nam <hj96.nam@samsung.com>
> > ---
> >  drivers/perf/cxl_pmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index 365d964b0f6a..bc0d414a6aff 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -419,7 +419,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
> >         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,                     CXL_PMU_GID_S2M_NDR, BIT(0)),
> >         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,                    CXL_PMU_GID_S2M_NDR, BIT(1)),
> >         CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,                    CXL_PMU_GID_S2M_NDR, BIT(2)),
> > -       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(3)),
> > +       CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,           CXL_PMU_GID_S2M_NDR, BIT(4)),
> >         /* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
> >         CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,                 CXL_PMU_GID_S2M_DRS, BIT(0)),
> >         CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,              CXL_PMU_GID_S2M_DRS, BIT(1)),
> > --
> > 2.34.1  
> 
> 


