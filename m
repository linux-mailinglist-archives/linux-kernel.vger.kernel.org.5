Return-Path: <linux-kernel+bounces-81768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AA867AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E219AB2E17D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AA12A176;
	Mon, 26 Feb 2024 15:12:38 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B0D60B87
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708960357; cv=none; b=Z0V1SozY1iBmphtUdC2veQUZ1WlFJGnfkVKD92CoM9pwMzW+c/AsNohXq8UAV/5IgfkBrtDWYVzrLWuquWXvbH7JbNbGMU+mYcn20IpSiWh6xhhCCNvjdq0JuA8XdZOnuBfZfMWkLbLawnk/mVyxyTsBnu0dzSIcbKEa7h6TOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708960357; c=relaxed/simple;
	bh=tGT7qj9x4O/x8Xg+FUY+hV9nQjfCdZHO4iZ/+Lortng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CEh8wpyV4bju/qv6Jbz7HBFiyj7Q9I8I4PKSGmyGQ++30Oe1RVRMhTmVFEgRECD09oDWHWK73zr6PNaUw8ztgX85oSZpKPy+snR4r0os7pjrEWKokaibGa24c+INI2WBKUVLkn/ZopG+BdCzAJsb5AJtAxvDz5tXw3NDouG3dL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tk3sr6BYxz6K7Gv;
	Mon, 26 Feb 2024 23:08:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CFE81400DB;
	Mon, 26 Feb 2024 23:12:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 26 Feb
 2024 15:12:31 +0000
Date: Mon, 26 Feb 2024 15:12:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yicong Yang <yangyicong@huawei.com>
CC: <will@kernel.org>, <mark.rutland@arm.com>, <hejunhao3@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<yangyicong@hisilicon.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <fanghao11@huawei.com>
Subject: Re: [PATCH v2 3/8] drivers/perf: hisi_pcie: Fix incorrect counting
 under metric mode
Message-ID: <20240226151230.00002654@Huawei.com>
In-Reply-To: <20240223103359.18669-4-yangyicong@huawei.com>
References: <20240223103359.18669-1-yangyicong@huawei.com>
	<20240223103359.18669-4-yangyicong@huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 18:33:54 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The metric counting shows incorrect results if the events in the
> metric group using the same event but different filter options.
> This is because we only judge the event code to decide whether
> the event in the metric group should share the same hardware
> counter, but ignore the settings of the filter.
> 
> For example, on a platform of 2 ports 0x1 and 0x2 but only port
> 0x1 has a downstream PCIe NVME device. The metric counting
> shows both ports have the same counts because we misassign these
> two events to one same hardware counter:
> [root@localhost perf-iostat]# ./perf stat -e '{hisi_pcie0_core1/event=0x0104,port=0x2/,hisi_pcie0_core1/event=0x0104,port=0x1/}'
> 
>  Performance counter stats for 'system wide':
> 
>         7907484924      hisi_pcie0_core1/event=0x0104,port=0x2/
>         7907484924      hisi_pcie0_core1/event=0x0104,port=0x1/
> 
>       10.153863691 seconds time elapsed
> 
> Fix this by using the whole config rather than the event only
> to judge whether two events are the same and should share the
> same hardware counter. With this patch, the metric counting in
> the above case tends to be corrected:
> 
> [root@localhost perf-iostat]# ./perf stat -e '{hisi_pcie0_core1/event=0x0104,port=0x2/,hisi_pcie0_core1/event=0x0104,port=0x1/}'
> 
>  Performance counter stats for 'system wide':
> 
>                  0      hisi_pcie0_core1/event=0x0104,port=0x2/
>         8123122077      hisi_pcie0_core1/event=0x0104,port=0x1/
> 
>       10.152875631 seconds time elapsed
> 
> Fixes: 8404b0fbc7fb ("drivers/perf: hisi: Add driver for HiSilicon PCIe PMU")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


