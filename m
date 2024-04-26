Return-Path: <linux-kernel+bounces-160317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 810768B3BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5973EB232DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E214B08A;
	Fri, 26 Apr 2024 15:42:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8F145B07
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146131; cv=none; b=U6Vu7a2eFyznc15MZ9Kq0M9FRVROSeF3BNuXEVvUOiZaSiipo1udnD+tg8moIu/imDt9PgC9i2KMHOU+cH+291p5k31T5dFte9ccbabv67AldI8cEgpYviRiXzwXH3sWdOXqQhRK0z6yQcuOb3bUEHGIMS8KB2cb4trGU66VGZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146131; c=relaxed/simple;
	bh=tq3SE+mwdciluA8/4j9PC+jNl7w8+x+Bv9tcZ4BTsto=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKqH0jJKUt50/diH/Cm+cN0yp+/ywst0wtopsfFvdBCOwz0iPxYaRtxRalkUvY9VvOIoq7ZcMzrzMZZGXWcNb+nF9j1/qL9zek+qwKOfI7CyPQMtLZ+xi3THYDM/Av4q31lYNdMrBmqvrvX2liQwpFe7I39P2T8ue17mQ9svpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VQxmM3Jprz6DB73;
	Fri, 26 Apr 2024 23:41:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EA19140A70;
	Fri, 26 Apr 2024 23:42:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Apr
 2024 16:42:06 +0100
Date: Fri, 26 Apr 2024 16:42:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Junhao He <hejunhao3@huawei.com>
CC: <will@kernel.org>, <yangyicong@huawei.com>, <shaojijie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <chenhao418@huawei.com>
Subject: Re: [PATCH 3/3] drivers/perf: hisi: hns3: Actually use
 devm_add_action_or_reset()
Message-ID: <20240426164205.000029f3@Huawei.com>
In-Reply-To: <20240425124627.13764-4-hejunhao3@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
	<20240425124627.13764-4-hejunhao3@huawei.com>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 25 Apr 2024 20:46:27 +0800
Junhao He <hejunhao3@huawei.com> wrote:

> From: Hao Chen <chenhao418@huawei.com>
> 
> pci_alloc_irq_vectors() allocates an irq vector. When devm_add_action()
> fails, the irq vector is not freed, which leads to a memory leak.
> 
> Replace the devm_add_action with devm_add_action_or_reset to ensure
> the irq vector can be destroyed when it fails.
> 
> Fixes: 66637ab137b4 ("drivers/perf: hisi: add driver for HNS3 PMU")
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

> ---
>  drivers/perf/hisilicon/hns3_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
> index cbdd53b0a034..60062eaa342a 100644
> --- a/drivers/perf/hisilicon/hns3_pmu.c
> +++ b/drivers/perf/hisilicon/hns3_pmu.c
> @@ -1527,7 +1527,7 @@ static int hns3_pmu_irq_register(struct pci_dev *pdev,
>  		return ret;
>  	}
>  
> -	ret = devm_add_action(&pdev->dev, hns3_pmu_free_irq, pdev);
> +	ret = devm_add_action_or_reset(&pdev->dev, hns3_pmu_free_irq, pdev);
>  	if (ret) {
>  		pci_err(pdev, "failed to add free irq action, ret = %d.\n", ret);
>  		return ret;


