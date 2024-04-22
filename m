Return-Path: <linux-kernel+bounces-152755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5754F8AC3DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8941C1C21BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E99D1865C;
	Mon, 22 Apr 2024 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VSJEQbaO"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC7B18633;
	Mon, 22 Apr 2024 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713764670; cv=none; b=el16BtPhj6p/QgaWl+zTgDSidqtqhmL01DbeFJEy6+3uzxSEB8p6szoasEH+DrI4AQ5taAA9Y70xRUnvYc9SOCeKWjChzjlCRiR05wsF8wERXDy9j4MPSPeQYvpCsVyjl07sc1MmVHzgwfkPUhBlUa04IJHstO2oaKzCumrKX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713764670; c=relaxed/simple;
	bh=dgIFGjvh91BJigSTwoei0LYgKDyBG4QkDR9vUApI6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by371DDiugUsr6fWknkzPuCHHb+KRWHlh8Jqrq5IaL/FNP6crhMk4nyCO0g898Ec5COcCxa4qHPEncIX6aTdnJRd+SRsAQ5tmGrL2z3mt1Fuje88Ekrc6YhhNvYTNsiD3Boe2h6jz1v3cyq81BiTO7jtCkVE0ler8uk6Pb4loLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VSJEQbaO; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0idcnhzrnp921GpmIQ7etOQCstHXDyTmUSD0FgxNCmE=;
	b=VSJEQbaO2XvrfuJndYM1OVjDf11GyRyeMywOtz1I07wVlUhkD4OkxBHq3t/Slq
	Ftu+CEZ7HZUJ+ELWQ/3F3QOH7EW+Or7Qgx5YV4lQPBhKgy/EDi2BlNJsBWXrnljr
	8RPe7DQw/HqbMDzbl3ATP6ZSChSZIS4oQd7AmktW/5WeE=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADnz2iv+CVm9NYzBA--.40373S3;
	Mon, 22 Apr 2024 13:42:09 +0800 (CST)
Date: Mon, 22 Apr 2024 13:42:07 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
	linuxarm@huawei.com, Shaokun Zhang <zhangshaokun@hisilicon.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Atish Patra <atishp@atishpatra.org>,
	Anup Patel <anup@brainfault.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, Frank Li <Frank.li@nxp.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Vineet Gupta <vgupta@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Liang Kan <kan.liang@linux.intel.com>
Subject: Re: [PATCH v2 25/30] ARM: imx: Assign parents for mmdc event_source
 devices
Message-ID: <ZiX4ryyBIkLQiD27@dragon>
References: <20240412161057.14099-1-Jonathan.Cameron@huawei.com>
 <20240412161057.14099-26-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412161057.14099-26-Jonathan.Cameron@huawei.com>
X-CM-TRANSID:C1UQrADnz2iv+CVm9NYzBA--.40373S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-OzVUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBQ3IZVsVCfBTAQABsB

On Fri, Apr 12, 2024 at 05:10:52PM +0100, Jonathan Cameron wrote:
> Currently the PMU device appears directly under /sys/devices/
> Only root busses should appear there, so instead assign the pmu->dev
> parent to be the platform device.
> 
> Link: https://lore.kernel.org/linux-cxl/ZCLI9A40PJsyqAmq@kroah.com/
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied, thanks!


